import 'package:flutter/material.dart';

import '../widgets/reuseable-widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _fnameTextcontroller=TextEditingController();

  TextEditingController _lnameTextcontroller=TextEditingController();

  createData(){
    print('created');
  }

  updateData(){}
  deleteData(){}
  readData(){}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('CRUD Operations')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: reusableTextField('First Name', Icons.person, false, _fnameTextcontroller),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: reusableTextField("Last Name", Icons.person_2, false, _lnameTextcontroller),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(onPressed: (){createData();}, child: Text('Create'),),
                ElevatedButton(onPressed: (){deleteData();}, child: Text('Delete'),),
                ElevatedButton(onPressed: (){updateData();}, child: Text('Update'),),
                ElevatedButton(onPressed: (){readData();}, child: Text('Read'),),
              ],


            ),


          ],
          
        ),
      ),
    );
  }
}

