import 'package:first_app/Provider%20work/Grocery%20App/cart_provider.dart';
import 'package:first_app/Provider%20work/Grocery%20App/intro_page.dart';
import 'package:first_app/Provider%20work/Practice/practice.dart';
import 'package:first_app/Provider%20work/Practice/practice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
