import 'package:first_app/widgets/reuseable-widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);


class MarkerAtCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MarkerAtCenter();
  
}

class _MarkerAtCenter extends State<MarkerAtCenter>{

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
TextEditingController _Latitudecontroller = TextEditingController();
TextEditingController _longitudecontroller = TextEditingController();

//Camera position variable
final CameraPosition _position =CameraPosition(target: currentlocation,zoom: 12);
                  
// late LatLng searchlocation = LatLng(
//   double.parse(_Latitudecontroller.text), 
//   double.parse(_longitudecontroller.text));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          reusableTextField('Latitude', Icons.abc, false, _Latitudecontroller),
          reusableTextField('Longitude', Icons.abc, false, _longitudecontroller),
      
          ElevatedButton(onPressed: (){

            // late LatLng searchlocation = LatLng(
            //   double.parse(_Latitudecontroller.text), 
            //   double.parse(_longitudecontroller.text)
            //   );
            
            // currentlocation = searchlocation;

            // print('Search location: $searchlocation');
            
            // print('Current Location: $currentlocation');

             addMarker('123', currentlocation);
            

            setState(() {
             
             _mapController.animateCamera(CameraUpdate.newLatLng(currentlocation));
            

            });


          }, child: Text('SEARCH..')),
      
      
          SizedBox(
            width: double.infinity,
            height: 400,
            child: GoogleMap(initialCameraPosition:
                   _position,
                   onCameraMove: (position) {

                    print('POSITION');
                      currentlocation = position.target;
                     //print(position.target);
                     print('current : $currentlocation');
                     setState(() {
                      _Latitudecontroller.text = currentlocation.latitude.toString(); 
                      _longitudecontroller.text =currentlocation.longitude.toString();
                      addMarker('123', currentlocation);



                     });
                   },
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
    );
  }

}