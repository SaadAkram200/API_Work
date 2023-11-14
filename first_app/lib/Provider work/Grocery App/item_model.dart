import 'package:cloud_firestore/cloud_firestore.dart';


class ItemModel{


  late String itemname, itemprice, image; 
  
  late int color;

  ItemModel({
    required this.itemname,
    required this.itemprice,
    required this.image,
    required this.color,
  });

  ItemModel.fromMap(Map<String, dynamic>data)
  {
    itemname = data['itemname'];
    itemprice = data['itemprice'];
    image = data['image'];
    color = data['color'];
  }

  Map<String, dynamic>toMap(){
    return{
      'itemname': itemname,
      'itemprice': itemprice,
      'image': image,
      'color': color,
      'timestamp': Timestamp.now(),
    };
  }

}