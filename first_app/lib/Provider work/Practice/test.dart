import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';


class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7ECEf),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffE7ECEf),
                     // border: Border.all(color: Colors.grey),
                      boxShadow: [
                      BoxShadow(
                        color: Color(0xffA7A9AF),
                        blurRadius: 5,
                        offset: Offset(7,7),
                        spreadRadius: 1, 
                        inset: true,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 5,
                        offset: Offset(-7, -7),
                        spreadRadius: 1,
                        inset: true,
                        // Shadow position
                      ),
                    ],
                    
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Bienvenue sur Vansé Ansanm, vous êtes sur la version bêta de lapplication, celle-ci est amenée à évoluer et à vous offrir de nouvelles fonctionnalités.',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text('NEXT')),
          ]),
    );
  }
}
