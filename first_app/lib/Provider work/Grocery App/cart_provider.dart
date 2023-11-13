import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

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

  addtoList(Index) {
    itemList.add(shopItems[Index]);
    notifyListeners();
  }

  removeFromList(Index) {
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

  //image picker
  String imageUrl = '';
  File? selectedImage;

  Future<String> uploadFile() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    try {
      String path = "images/${DateTime.now().millisecondsSinceEpoch}";
      final mimeType = lookupMimeType(file!.path);
      print(mimeType);
      final firebasestorage.FirebaseStorage _storage =
          firebasestorage.FirebaseStorage.instance;
      var reference = _storage.ref().child(path);
      var r = await reference.putData(
          await file.readAsBytes(), SettableMetadata(contentType: mimeType));

      if (r.state == firebasestorage.TaskState.success) {
        imageUrl = await reference.getDownloadURL();
        selectedImage = File(file.path);
        notifyListeners();
        return imageUrl;
      } else {
        throw PlatformException(code: "404", message: "no download link found");
      }
    } catch (e) {
      rethrow;
    }
  }

  //color picker
  late Color mycolor = Colors.blue.shade200; 

  colorPicker(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick a color!'),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: mycolor,
                onColorChanged: (Color color) {
                    mycolor = color;
                    notifyListeners();
                    //print("color : " + mycolor.toString());
                },
              ),
            ),
            actions: [
              ElevatedButton(
                child: const Text('DONE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
        return mycolor;
  }
}
