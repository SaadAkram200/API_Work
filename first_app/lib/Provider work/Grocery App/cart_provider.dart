import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  
  final _shopItems = [

    ["Avacado", "100", "assets/images/avocado.png", Colors.green],
    ["Banana", "120", "assets/images/banana.png", Colors.yellow],
    ["Chicken", "540", "assets/images/chicken.png", Colors.brown],
    ["Water", "60", "assets/images/water.png", Colors.blue],
    ["Orange", "240", "assets/images/orange.png", Colors.orange],
    ["Snacks", "50", "assets/images/snacks.png", Colors.red],
    ["Cookie", "50", "assets/images/cookie.png", Colors.brown],

  ];

  get shopItems => _shopItems;


// list for cart page
  List itemList = [];

  addtoList(Index){
    itemList.add(shopItems[Index]);
    notifyListeners();
  }

  removeFromList(Index){
    itemList.remove(Index);
    notifyListeners();
  }

  //total bill calculator
   String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < itemList.length; i++) {
      totalPrice += double.parse(itemList[i][1]);
    }
    return totalPrice.toString();
  }
}