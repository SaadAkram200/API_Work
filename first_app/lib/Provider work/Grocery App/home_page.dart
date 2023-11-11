import 'package:first_app/Provider%20work/Grocery%20App/cart_page.dart';
import 'package:first_app/Provider%20work/Grocery%20App/cart_provider.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});


// used for greeting msg
currentTime(){
  DateTime now = DateTime.now();
  if (now.hour >11.59) {
    return Text(
      'Good Evening,',
      style: TextStyle(fontSize: 16),);
  } else {
    return Text(
      'Good Morning,',
      style: TextStyle(fontSize: 16),);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.shopping_bag_outlined,),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
      },),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            
            //greeting text
            Padding(
              padding: const EdgeInsets.fromLTRB(24,30,0,10),
              child: currentTime(),
            ),

            
            //Big Text
            Padding(
              padding: const EdgeInsets.fromLTRB(24,0,20,0),
              child: Text("Let's order fresh food for you",
                style: GoogleFonts.notoSerif(fontSize: 36,fontWeight: FontWeight.bold),),
            ),

            // fresh item text
            Padding(
              padding: const EdgeInsets.fromLTRB(24,50,0,10),
              child: Text(
                "Fresh Items",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),

            //item list
            Expanded( 
              child: Consumer<CartProvider>(builder: (context, value, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1/1.3),
                    itemCount: value.shopItems.length,
                    padding: EdgeInsets.all(10), 
                    itemBuilder: (context, index) {
                      return GroceryItemTile(
                        itemName: value.shopItems[index][0], 
                        itemPrice: value.shopItems[index][1], 
                        itemPath: value.shopItems[index][2], 
                        color: value.shopItems[index][3],
                        onPressed: () {
                          print(value.itemList);
                          value.addtoList(index);
                        },
                        );
                      
                    },
                    );
              },)
            ),
          ],
        ),),);
  }
}