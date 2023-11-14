import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Provider%20work/Grocery%20App/item_model.dart';

class ItemFirestoreService {
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  //Add Item to firestore
  Future<void> addItems(ItemModel item) {
    return items.add(item.toMap());
  }

  // get item list
  Stream<List<ItemModel>> getItems() {
    return FirebaseFirestore.instance.collection('items').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        final data = document.data();
        return ItemModel.fromMap(data);
      }).toList();
    });
  }
}
