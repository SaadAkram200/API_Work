import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model.dart';

class FirestoreService {
  

  final CollectionReference markers = 
  FirebaseFirestore.instance.collection('markers');


  //Create

  Future<void> addMarker(FirebaseModel marker){
    return markers.add(marker.toMap());
  }

  
  
// Retrieve data from Firestore

// Future<List<FirebaseModel>> getMarkers() async {
//   List<FirebaseModel> markerList = [];
//   QuerySnapshot querySnapshot = await markers.get();
//   for (QueryDocumentSnapshot document in querySnapshot.docs) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//     FirebaseModel marker = FirebaseModel(
//       latitude: data['latitude'],
//       longitude: data['longitude'],
//     );
//     markerList.add(marker);
//   }
//   return markerList;
// }



// Stream 
  // Stream<List<FirebaseModel>> getMarkersStream() {
  //   return markers.snapshots().map((querySnapshot) {
  //     return querySnapshot.docs.map((document) {
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //       return FirebaseModel.fromMap(data);
  //     }).toList();
  //   });
  // }

  

}