import 'dart:async';

import 'package:first_app/App/firestore_services.dart';
import 'package:first_app/App/navDrawer.dart';
import 'package:first_app/App/user_model.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //forestore services instant
 FirestoreServices _firestoreServices = FirestoreServices();

  // for Start tracking button
  bool clicked = false;

  //Camera position variable
  final CameraPosition _position =
      CameraPosition(target: currentlocation, zoom: 12);
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

  //stream
  StreamSubscription<Position>? positionStream;

  //Get user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  // text Editing controller
  TextEditingController _latitudecontroller = TextEditingController();
  TextEditingController _longitudecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          reusableTextField('Latitude', Icons.abc, false, _latitudecontroller),
          reusableTextField(
              'Longitude', Icons.abc, false, _longitudecontroller),
          // ElevatedButton(
          //     onPressed: () {
          //       late LatLng searchlocation = LatLng(
          //           double.parse(_latitudecontroller.text),
          //           double.parse(_longitudecontroller.text));
          //       currentlocation = searchlocation;
          //       print('Search location: $searchlocation');
          //       print('Current Location: $currentlocation');
          //       addMarker('123', currentlocation);
          //       setState(() {
          //         _mapController
          //             .animateCamera(CameraUpdate.newLatLng(currentlocation));
          //       });
          //     },
          //     child: Text('SEARCH')),

          SizedBox(
            width: double.infinity,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: _position,
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

          // Start Tracking button
          ElevatedButton(
            onPressed: () {
              setState(() {
                clicked = !clicked;
                

                if (clicked) {
                  // Start the position stream
                  positionStream = Geolocator.getPositionStream(
                    locationSettings: LocationSettings(
                        accuracy: LocationAccuracy.bestForNavigation),
                  ).listen((position) {
                    // Handle position updates
                    late LatLng liveLocation =
                        LatLng(position.latitude, position.longitude);
                    currentlocation = liveLocation;
                    print(' Current LOCATION : ' +
                       currentlocation.latitude.toString());

                    if (clicked) {
                      setState(() {
                        _mapController.animateCamera(CameraUpdate.newLatLng(currentlocation));
                        _latitudecontroller.text = currentlocation.latitude.toString();
                        _longitudecontroller.text = currentlocation.longitude.toString();
                        addMarker('id', currentlocation);

                        //update User latlng
                        _firestoreServices.updateLatlng(_latitudecontroller.text, _longitudecontroller.text);
                      });
                    }
                  });
                } else {
                  // Cancel the position stream
                  positionStream?.cancel();
                }
              });
            },
            child: clicked ? Text('Stop Tracking') : Text('Start Tracking'),
          )
        ],
      ),
    );
  }
}
