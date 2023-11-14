import 'package:first_app/Provider%20work/Grocery%20App/item_firestore.dart';
import 'package:first_app/Provider%20work/Grocery%20App/item_model.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class AddItems extends StatefulWidget {
  AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  //Text controllers
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemPriceController = TextEditingController();

  //firestore
  final ItemFirestoreService itemfirestoreService = ItemFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Add New Items",
            style: GoogleFonts.notoSerif(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // for item name
                            Text(
                              "Item Name ",
                              style: GoogleFonts.notoSerif(
                                  color: Colors.black, fontSize: 16),
                            ),
                            reusableTextField(
                                "Item Name",
                                Icons.add_shopping_cart_outlined,
                                false,
                                _itemNameController),

                            // for item price
                            Text(
                              "Item Price ",
                              style: GoogleFonts.notoSerif(
                                  color: Colors.black, fontSize: 16),
                            ),
                            reusableTextField(
                                "Rs. ",
                                Icons.price_change_outlined,
                                false,
                                _itemPriceController),

                            // for item image
                            Text(
                              "Select Item Image ",
                              style: GoogleFonts.notoSerif(
                                  color: Colors.black, fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                value.uploadFile();
                              },
                              child: Container(
                                child: value.selectedImage == null
                                    ? Icon(Icons.image_outlined, size: 300)
                                    : Image.file(value.selectedImage!),
                              ),
                            ),

                            //for color
                            Container(
                              //background color of app from color picker
                              alignment: Alignment.center,
                              color: value.mycolor,
                              padding: EdgeInsets.all(20),
                              child: Column(children: [
                                ElevatedButton(
                                  onPressed: () {
                                    value.colorPicker(context);
                                  },
                                  child: Text("Select Color"),
                                ),
                              ]),
                            ),

                            SizedBox(height: 40,),
                            //Add item Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  
                                  // //adding new item to firebase
                                  // try {
                                  //   final newitem = ItemModel(
                                  //     itemname: _itemNameController.text,
                                  //     itemprice: _itemPriceController.text,
                                  //     image: value.imageUrl,
                                  //     color: value.mycolor.value);
                                  // itemfirestoreService.addItems(newitem).then(
                                  //     (value) => ScaffoldMessenger.of(context)
                                  //             .showSnackBar(SnackBar(
                                  //           duration: Duration(seconds: 2),
                                  //           content: Text(
                                  //             "item Uploaded Sucessfully!",
                                  //             textAlign: TextAlign.center,
                                  //           ),
                                           
                                  //         )));
                                  // } catch (e) {
                                  //   rethrow;
                                  // }
                                  
                                },
                                child: Text("Add Item to Store"),
                              ),
                            )
                          ]);
                    },
                  ),
                ))));
  }
}
