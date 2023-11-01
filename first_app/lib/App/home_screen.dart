import 'package:first_app/App/navDrawer.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
bool clicked= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          setState(() {
            clicked=!clicked;
          });
        }, 
        child:clicked? Text('Stop Tracking'):Text('Start Tracking'))
      ) ,
    );
}
}
