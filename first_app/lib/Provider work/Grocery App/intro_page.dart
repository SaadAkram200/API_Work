import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        
        //Avacado Image
        Padding(
          padding: const EdgeInsets.fromLTRB(80,160,80,40),
          child: Image.asset('assets/images/avocado.png'),
        ),

        //Big Text
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('We deliver groceries at your doorstep',
            style: GoogleFonts.notoSerif(
              fontSize: 36, 
              fontWeight: FontWeight.bold,
              ),
             textAlign: TextAlign.center, ),
        ),

        //small text
        Text('Fresh items everyday'),
        
        Spacer(),
        
        //Get started button
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=> HomePage())),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple,),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('Get Started',style: TextStyle(color: Colors.white),),
              ),
          ),
        ),

        Spacer(),
      ]),
    );
  }
}