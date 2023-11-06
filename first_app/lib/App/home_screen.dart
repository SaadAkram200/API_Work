import 'dart:async';
import 'dart:typed_data';
import 'package:first_app/App/others_location.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/App/firestore_services.dart';
import 'package:first_app/App/navDrawer.dart';
import 'package:first_app/App/user_model.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  //forestore services instant
  FirestoreServices _firestoreServices = FirestoreServices();
  // variable to store userdata coming from Firestore
  UserModel? userData;
  //geting user info
  @override
  void initState() {
    super.initState();
    var uid = FirebaseAuth.instance.currentUser?.uid;
    _firestoreServices.users.doc(uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        userData = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);

        setState(() {});
      } else {
        print('no data');
      }
    });
    getUserCurrentLocation();
  }

  // for Start tracking button
  bool clicked = false;

  //Camera position variable
  final CameraPosition _position =
      CameraPosition(target: currentlocation, zoom: 12);
  late GoogleMapController _mapController;

  Map<String, Marker> _markers = {};

  //ADD Marker Function
  addMarker(String id, LatLng location) async{
  var iconurl = userData?.image;
  var dataBytes;
  var request = await http.get(Uri.parse(iconurl!));
  var bytes = await request.bodyBytes;

  setState(() {
  dataBytes = bytes;
  });
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow:
          InfoWindow(
            title: userData != null? userData!.username: 'loading', 
            snippet: 'Working on Google Maps'),
            icon: BitmapDescriptor.fromBytes(cropImage(dataBytes.buffer.asUint8List())),
    );

    _markers[id] = marker;
  }
// to adjust the size of image
  Uint8List cropImage(Uint8List imageBytes) {
  final img.Image image = img.decodeImage(imageBytes)!;
  final img.Image resizedImage = img.copyResize(image, width: 100, height: 100);
  final Uint8List croppedImageBytes = Uint8List.fromList(img.encodePng(resizedImage));
  return croppedImageBytes;
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
          Text('YOUR CURRENT LOCATION'),
          reusableTextField('Latitude', Icons.abc, false, _latitudecontroller),
          reusableTextField('Longitude', Icons.abc, false, _longitudecontroller),
          
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

          //google map
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
                
              },
              markers: _markers.values.toSet(),
            ),
          ),

          // Start sharing location button
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

                    if (clicked) {
                      setState(() {

                        
                        //move the camera along with currentlocation
                        _mapController.animateCamera(
                            CameraUpdate.newLatLng(currentlocation));
                        _latitudecontroller.text =
                            currentlocation.latitude.toString();
                        _longitudecontroller.text =
                            currentlocation.longitude.toString();
                        addMarker('id', currentlocation);

                        //update User latlng in firestore
                        _firestoreServices.updateLatlng(
                           double.parse(_latitudecontroller.text) ,
                           double.parse( _longitudecontroller.text));

                        
                        
                      });
                    }
                  });
                } else {
                  // Cancel the position stream
                  positionStream?.cancel();
                }
              });
            },
            child: clicked ? Text('Stop sharing') : Text('Share your Location'),
          ),
        
          //Other's location button
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> othersLocation()));
          }, child: Text('See Others Location')),

        ],
      ),
    );
  }
}
