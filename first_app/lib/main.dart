import 'package:first_app/App/others_location.dart';
import 'package:first_app/Google%20Map/google_maps.dart';
import 'package:first_app/Google%20Map/map_firebase.dart';
import 'package:first_app/Google%20Map/markerAt_center.dart';
import 'package:first_app/App/home_screen.dart';
import 'package:first_app/App/signin_screen.dart';
import 'package:first_app/App/signup_screen.dart';
import 'package:first_app/firebase_options.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/API%20work/get_data.dart';
import 'API work/upload_image.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
        
      ),
      home:  signUpScreen(),
    );
  }
}

