import 'package:first_app/Provider%20work/Grocery%20App/add_items.dart';
import 'package:first_app/Provider%20work/Grocery%20App/cart_page.dart';
import 'package:first_app/Provider%20work/Grocery%20App/cart_provider.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

// used for greeting msg
  currentTime() {
    DateTime now = DateTime.now();
    if (now.hour > 11.59) {
      return Text(
        'Good Afternoon,',
        style: TextStyle(fontSize: 16),
      );
    } else {
      return Text(
        'Good Morning,',
        style: TextStyle(fontSize: 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItems(),
                    ),
                    (route) => true);
              },
              child: Icon(Icons.add_outlined),
            ),
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                    (route) => true);
              },
              child: Icon(Icons.shopping_bag_outlined),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //greeting text
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 30, 0, 10),
              child: currentTime(),
            ),

            //Big Text
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 20, 0),
              child: Text(
                "Let's order fresh food for you",
                style: GoogleFonts.notoSerif(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),

            // fresh item text
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 50, 0, 10),
              child: Text(
                "Fresh Items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            //item list
            Expanded(child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                  itemCount: value.shopItems.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                      itemName: value.shopItems[index].itemname,
                      itemPrice: value.shopItems[index].itemprice,
                      itemPath: value.shopItems[index].image,
                      color: value.shopItems[index].color,
                      onPressed: () {

                        value.addtoList(index);
                        print(value.itemList);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            // value.itemList[index][0].toString()+
                            " Added to cart",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                        ));
                      },
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
