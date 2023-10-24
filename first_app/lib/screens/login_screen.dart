import 'package:flutter/material.dart';
import '../widgets/reuseable-widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextcontroller=TextEditingController();
  TextEditingController _passwordTextcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(child: Column(
            children: [
              Container(
                height: 200,
                child: Center(child: Image(image: AssetImage('first_app/assets/images/Logo.png'),height: 150, width: 150,))),
              
              Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),

              SizedBox(height: 100,),

              Container(width: 400,child: reusableTextField('Email Address', Icons.mail, false, _emailTextcontroller)
              ),

              SizedBox(height: 10,),
              Container(width: 400, child: reusableTextField('Password ', Icons.lock, true, _passwordTextcontroller)),
              Padding(
                padding: const EdgeInsets.only(left:270, top: 10 ),
                child: Text('Forget Password?', style: TextStyle(color: Color.fromARGB(255, 2, 173, 211)),),
              )

            ],
          ) ),
        )
      ],
    );
  }
}

