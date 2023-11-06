import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseModel{

  late String latitude, longitude;
  
  FirebaseModel({
    required this.latitude,
    required this.longitude,
   
  });

  FirebaseModel.fromMap(Map<String, dynamic>data)
  {
    latitude = data['latitude'];
    longitude = data['longitude'];
   
  }

  Map<String, dynamic>toMap(){
    return{
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': Timestamp.now(),

    };
  }

}