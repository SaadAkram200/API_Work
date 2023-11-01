import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/App/user_model.dart';


class FirestoreServices {

  final CollectionReference<Map<String, dynamic>> users = 
    FirebaseFirestore.instance.collection('users');
  
  //Create user
  Future<void> addUser(UserModel user){

    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = users.doc(uid);
    user.id = uid;
    return doc.set(user.toMap());
  }
}