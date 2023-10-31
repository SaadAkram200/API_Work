import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);


class GoogleMapsIntegration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleMapsIntegration();
  
}

class _GoogleMapsIntegration extends State<GoogleMapsIntegration>{

  late GoogleMapController _mapController;

  Map<String, Marker> _markers = {};

  //ADD Marker Function
  addMarker(String id, LatLng location){
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

// text Editing controller
TextEditingController _latitudecontroller = TextEditingController();
TextEditingController _longitudecontroller = TextEditingController();

//Camera position variable
final CameraPosition _position =CameraPosition(target: currentlocation,zoom: 12);
                  
// late LatLng searchlocation = LatLng(
//   double.parse(_latitudecontroller.text), 
//   double.parse(_longitudecontroller.text));

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