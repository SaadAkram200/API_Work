import 'package:flutter/material.dart';

import '../widgets/reuseable_widgets.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

