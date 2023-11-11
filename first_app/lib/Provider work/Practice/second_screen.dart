import 'package:first_app/Provider%20work/Practice/practice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favourite Movies'),
        ),
        body: Consumer<PracticeProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.favlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text('Book ${value.favlist[index]}'),
                      trailing: TextButton(
                          onPressed: () {
                            value.removeFav(value.favlist[index]);
                          },
                          child: Text("Remove")),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
