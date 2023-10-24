import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String ?stringResponse;
Map ?mapResponse;
Map ?dataResponse;
List ?listResponse;

class GetData extends StatefulWidget {
  const GetData({super.key});

  @override
  State<StatefulWidget> createState() => _GetData();
  
}

class _GetData extends State<GetData>{

  
Future apiCall() async {
  http.Response response;
  response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  if (response.statusCode == 200) {
    setState(() {
      stringResponse = response.body;
      mapResponse = json.decode(response.body);
      //dataResponse = mapResponse!['data'];
      listResponse = mapResponse!['data'];

    });
  }

}

@override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Get Data From API') ),
          body: ListView.builder(itemBuilder: (context, index) {
             return ListTile(
              leading:  SizedBox( child: CircleAvatar(backgroundImage:NetworkImage(listResponse![index]['avatar']),) ),
              title: Text(listResponse![index]['first_name'].toString()),
              subtitle: Text(listResponse![index]['email'].toString()),

             ); 
          } , 
          itemCount: listResponse==null? 0: listResponse?.length,
          )

  
    );
  }
}