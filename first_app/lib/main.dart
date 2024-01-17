// ignore_for_file: unused_import, unused_local_variable

import 'package:first_app/App/others_location.dart';
import 'package:first_app/Google%20Map/google_maps.dart';
import 'package:first_app/Google%20Map/map_firebase.dart';
import 'package:first_app/Google%20Map/markerAt_center.dart';
import 'package:first_app/App/home_screen.dart';
import 'package:first_app/App/signin_screen.dart';
import 'package:first_app/App/signup_screen.dart';
import 'package:first_app/Hive%20Work/to_do_hive.dart';
import 'package:first_app/firebase_options.dart';
import 'package:first_app/API%20work/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/API%20work/get_data.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'API work/upload_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();

  var box = Hive.openBox("testbox");
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
        
      ),
      home:  ToDoWithHive(),
    );
  }
}

