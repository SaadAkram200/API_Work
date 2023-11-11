import 'package:first_app/API%20work/api_service.dart';
import 'package:flutter/material.dart';
import '../widgets/reuseable_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextcontroller = TextEditingController();
  TextEditingController _passwordTextcontroller = TextEditingController();

  callLoginApi(){
    final service = ApiServices();
    service.apiCallLogin(
    {
      "email" : _emailTextcontroller.text,
      "password": _passwordTextcontroller.text,

    },
    ).then((value) {
      if (value.error !=null) {
        print("get data >>>>>> " + value.error!);
      } else {
        print(value.token!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'Login',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
              width: 400,
              child: reusableTextField(
                  'Email Address', Icons.mail, false, _emailTextcontroller)),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 400,
              child: reusableTextField(
                  'Password ', Icons.lock, true, _passwordTextcontroller)),
          ElevatedButton(onPressed: () {
            callLoginApi();
          }, child: Text('Login'))
        ],
      )),
    );
  }
}
