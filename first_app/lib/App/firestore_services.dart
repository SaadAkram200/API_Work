import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/App/user_model.dart';

class FirestoreServices {
  final CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

  //Create user
  Future<void> addUser(UserModel user) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = users.doc(uid);
    user.id = uid;
    return doc.set(user.toMap());
  }
  // UPDATE
// Future<void> updateLatlng(UserModel updateUser) {
//   var uid = FirebaseAuth.instance.currentUser!.uid;
//   return users.doc(uid).update(updateUser.toMap());
// }

  Future<void> updateLatlng(double latitude, double longitude) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return users.doc(uid).update({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

//stream to get user location
  Stream<List<UserModel>> getUserLocation() {
    return FirebaseFirestore.instance.collection('users').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        final data = document.data();
        return UserModel.fromMap(data);
      }).toList();
    });
  }
}
