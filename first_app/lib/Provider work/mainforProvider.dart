import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Provider%20work/Grocery%20App/cart_provider.dart';
import 'package:first_app/Provider%20work/Grocery%20App/intro_page.dart';
// ignore: unused_import
import 'package:first_app/Provider%20work/Practice/practice.dart';
import 'package:first_app/Provider%20work/Practice/practice_provider.dart';
import 'package:first_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  
  runApp(
    MultiProvider(providers: [

      ChangeNotifierProvider<PracticeProvider>(create: (_) => PracticeProvider(),),

      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
