import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

//late String id;
  late String username, email, password, id;
  String? image;
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.image,
  });

  UserModel.fromMap(Map<String, dynamic>data)
  {
    id = data["id"];
    username = data['username'];
    email = data['email'];
    password = data['password'];
    image = data['image'];
  }

  Map<String, dynamic>toMap(){
    return{
      "id": id,
      'username': username,
      'email': email,
      'password': password,
      'image': image,
      'timestamp': Timestamp.now(),

    };
  }

}