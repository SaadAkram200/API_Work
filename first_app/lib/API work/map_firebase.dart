

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/firestore.dart';
import 'package:first_app/model.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);


class MapFirebase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapFirebase();
  
}

class _MapFirebase extends State<MapFirebase>{

  late GoogleMapController _mapController;

  Map<String, Marker> _markers = {};

  //ADD Marker Function
  addMarker(String id,  LatLng location){
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,

      infoWindow: InfoWindow(
        title: 'Saad Here',
        snippet: 'Working on Google Maps'),
      );

    _markers[id]= marker;
    // setState(() {
      
    // });

  }
  // testiing
  void addMarkers(List<LatLng> locations) {
  locations.forEach((location) {
    var marker = Marker(
      markerId: MarkerId(location.toString()), 
      position: location,
      infoWindow: InfoWindow(
        title: 'Saad Here',
        snippet: 'Working on Google Maps',
        
      ),
    );
    print('IM HERE');
    setState(() {
      _markers[location.toString()] = marker;
    });
  });
}
  
// firestore
final FirestoreService firestoreService = FirestoreService();
// text Editing controller
TextEditingController _latitudecontroller = TextEditingController();
TextEditingController _longitudecontroller = TextEditingController();


//Camera position variable
final CameraPosition _position =CameraPosition(target: currentlocation,zoom: 12);
                  
//initState
@override
  void initState() {
    super.initState();
    
              
firestoreService.markers.snapshots().listen((querySnapshot) {
  List<LatLng> latLngList = [];
  latLngList.clear();
  for (var document in querySnapshot.docs) {
    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      FirebaseModel marker = FirebaseModel.fromMap(data);

      double latitude = double.parse(marker.latitude);
      double longitude = double.parse(marker.longitude);
      LatLng latLng = LatLng(latitude, longitude);
      latLngList.add(latLng);
    }
  }
  print('HERE: ' + latLngList.toString());
  addMarkers(latLngList);
});

  

    //List<LatLng> latLngList = [];

    // firestoreService.getMarkersStream().listen((List<FirebaseModel> markers) { 
      
    //   for (FirebaseModel marker in markers) {
    //   double latitude = double.parse(marker.latitude);
    //   double longitude = double.parse(marker.longitude);
    //   LatLng latLng = LatLng(latitude, longitude);
    //   latLngList.add(latLng);
    //   }
    //   print('HERE : '+latLngList.toString());
    //   addMarkers(latLngList);
    // });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            reusableTextField('Latitude', Icons.abc, false, _latitudecontroller),
            reusableTextField('Longitude', Icons.abc, false, _longitudecontroller),

            ElevatedButton(onPressed: ()async{

              //to add new marker into firebase
              final newMarker = FirebaseModel(
                latitude: _latitudecontroller.text, 
                longitude: _longitudecontroller.text
                );
                firestoreService.addMarker(newMarker);
              
              //to point the added marker
              
              //List<LatLng> latLngList = [];
              // List<FirebaseModel> markers = await firestoreService.getMarkers();
              // for (FirebaseModel marker in markers) {
              //   double latitude = double.parse(marker.latitude);
              //   double longitude = double.parse(marker.longitude);
              //   LatLng latLng = LatLng(latitude, longitude);
              //   latLngList.add(latLng);
              // }
              // print('HERE : '+latLngList.toString());
              // addMarkers(latLngList);
                
            }, child: Text('Add Marker to Firebase')),

            // ElevatedButton(onPressed: ()async{
            //   List<FirebaseModel> markers = await firestoreService.getMarkers();
            //   // for (FirebaseModel marker in markers) {
            //   //   print('Latitude: ${marker.latitude}, Longitude: ${marker.longitude}'); 
            //   // }
            //   List<LatLng> latLngList = [];
            //   for (FirebaseModel marker in markers) {
            //     double latitude = double.parse(marker.latitude);
            //     double longitude = double.parse(marker.longitude);
            //     LatLng latLng = LatLng(latitude, longitude);
            //     latLngList.add(latLng);
            //   }
            //   print('HERE : '+latLngList.toString());
            //   addMarkers(latLngList);
            // }, child: Text('test')),
      
            ElevatedButton(onPressed: (){

              late LatLng searchlocation = LatLng(
                double.parse(_latitudecontroller.text), 
                double.parse(_longitudecontroller.text)
                );
              
              currentlocation = searchlocation;
              
              print('Search location: $searchlocation');
              
              print('Current Location: $currentlocation');

              addMarker('123', currentlocation);

              

              setState(() {
               
               _mapController.animateCamera(CameraUpdate.newLatLng(currentlocation));
              

              });


            }, child: Text('SEARCH')),
      
      
            SizedBox(
              width: double.infinity,
              height: 400,
              child: GoogleMap(initialCameraPosition:
                     _position,
                // CameraPosition(
                  
                //   // target: currentlocation,
                //   // zoom: 10,
                //   ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    //addMarker('Testing', currentlocation);
            
                  },
                  markers: _markers.values.toSet(),
                  ),
            ),
          ],
        ),
      ),
    );
  }

}