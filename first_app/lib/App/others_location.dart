import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:first_app/App/firestore_services.dart';
import 'package:first_app/App/navDrawer.dart';
import 'package:first_app/App/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// golble Variable for location
late LatLng currentlocation = LatLng(31.5222882, 74.439049);

class othersLocation extends StatefulWidget {
  @override
  State<othersLocation> createState() => _othersLocationState();
}

class _othersLocationState extends State<othersLocation> {
  //firestore services
  FirestoreServices _firestoreServices = FirestoreServices();

  //Stream
  StreamSubscription<List<UserModel>>? streamSubscription;  

  //Camera position variable
  final CameraPosition _position =
      CameraPosition(target: currentlocation, zoom: 12);

  Map<String, Marker> _markers = {};
//ADD Marker Function
  addMarker(List <dynamic> userLocation ) async{
    userLocation.forEach((userModel) async { 

      LatLng latLng = LatLng(userModel.latitude, userModel.longitude);
      
      var iconurl = userModel.image;
      var dataBytes;
      var request = await http.get(Uri.parse(iconurl!));
      var bytes = await request.bodyBytes;
      setState(() {
        dataBytes = bytes;
      });
      var marker = Marker(
      markerId: MarkerId(userModel.id),
      position: latLng,
      infoWindow:
          InfoWindow(
            title: userModel.username, 
            snippet: userModel.email,),
            icon: BitmapDescriptor.fromBytes(cropImage(dataBytes.buffer.asUint8List())),
    );

    _markers[userModel.id] = marker;
    });
    
  }
// to adjust the size of image
  Uint8List cropImage(Uint8List imageBytes) {
  final img.Image image = img.decodeImage(imageBytes)!;
  final img.Image resizedImage = img.copyResize(image, width: 100, height: 100);
  final Uint8List croppedImageBytes = Uint8List.fromList(img.encodePng(resizedImage));
  return croppedImageBytes;
}

  //for start tracking button
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: Column(children: [
        //google map
        SizedBox(
          width: double.infinity,
          height: 400,
          child: GoogleMap(
            initialCameraPosition: _position,
            onMapCreated: (controller) {
            },
            markers: _markers.values.toSet(),
          ),
        ),

        //button to see others location
        ElevatedButton(
            onPressed: () {
              setState(() {
                clicked = !clicked;
              });

              if (clicked) {
                streamSubscription =
                    _firestoreServices.getUserLocation().listen((snapshot) {  
                      
                      addMarker(snapshot);
                });
              } else {
                streamSubscription?.cancel();
              }
            },
            child:
                clicked ? Text('Stop Tracking') : Text('Start Tracking Others')),
        //back button
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Back to Home Screem')),
      ]),
    );
  }
}
