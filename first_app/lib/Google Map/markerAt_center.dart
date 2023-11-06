import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);

class MarkerAtCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MarkerAtCenter();
}

class _MarkerAtCenter extends State<MarkerAtCenter> {
  late GoogleMapController _mapController;

  Map<String, Marker> _markers = {};

  //ADD Marker Function
  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow:
          InfoWindow(title: 'Saad Here', snippet: 'Working on Google Maps'),
    );

    _markers[id] = marker;
  }


//to move the marker, works for both OncameraMove and onCameraIdle
  void cameraMovement() {
    setState(() {
      
      _latitudecontroller.text = currentlocation.latitude.toString();
      _longitudecontroller.text = currentlocation.longitude.toString();
      addMarker('123', currentlocation);
    });
  }

String finalAddress = "";
//to  get the Address of marker
Future addressGetter()async{
  // final coordinates = new Coordinates(
  //         currentlocation.latitude, currentlocation.longitude);
  //var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(currentlocation.latitude, currentlocation.longitude);
  //var first = addresses.first;
  var last = placemarks.first;
  
 //finalAddress = first.featureName.toString()+first.addressLine.toString();
  finalAddress = last.street.toString()+' '+
  last.subLocality.toString()+' '+
  last.locality.toString()+' '+
  last.country.toString();
   print("ADDRESS:  "+finalAddress);

}

// text Editing controller
  TextEditingController _latitudecontroller = TextEditingController();
  TextEditingController _longitudecontroller = TextEditingController();

//Camera position variable
  final CameraPosition _position = CameraPosition(
    target: currentlocation,
    zoom: 12,
  );

// late LatLng searchlocation = LatLng(
//   double.parse(_latitudecontroller.text),
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
          Text(finalAddress.toString()),
          reusableTextField('Latitude', Icons.abc, false, _latitudecontroller),
          reusableTextField(
              'Longitude', Icons.abc, false, _longitudecontroller),
          ElevatedButton(
              onPressed: () {
                cameraMovement();
              },
              child: Text('SEARCH..')),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: _position,

              onCameraIdle: () {
                cameraMovement();
                addressGetter();
              },
              onCameraMove: (position) {
                currentlocation = position.target;
                //print(position.target);
               // cameraMovement();

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
