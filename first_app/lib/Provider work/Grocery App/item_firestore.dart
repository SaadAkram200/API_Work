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
}
