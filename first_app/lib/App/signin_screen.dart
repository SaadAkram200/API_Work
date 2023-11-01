import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/App/home_screen.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class signInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _signInScreen();
}

class _signInScreen extends State<signInScreen> {
  //Sign in function
  Future signIn() async {
    // checking if Textfields are empty
    if (_emailTextcontroller.text == "" || _passwordTextcontroller.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter Email or Password',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.white,
      ));
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailTextcontroller.text,
            password: _passwordTextcontroller.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Incorrect Email or Password',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          ),
          backgroundColor: Colors.white,
        ));
      }
    }
  }

  //text controllers
  TextEditingController _emailTextcontroller = TextEditingController();
  TextEditingController _passwordTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 244, 94, 94),
            Color.fromARGB(255, 234, 50, 50),
            Color.fromARGB(255, 245, 45, 45),
            Color.fromARGB(255, 243, 91, 157),
          ],
          transform: GradientRotation(4),
          stops: [0.18, 0.25, 0.35, 2.00],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.redAccent,

        // ),
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              children: [
                //Logo
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/logo1.png')),
                ),

                //Center container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Page name
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),

                      //Email TextFiled
                      reusableTextFields(
                          icon: Icons.mail,
                          controller: _emailTextcontroller,
                          fieldName: 'Email',
                          obscureText: false),

                      //password TextFiled
                      reusableTextFields(
                          icon: Icons.lock,
                          controller: _passwordTextcontroller,
                          fieldName: 'Password',
                          obscureText: true),

                      //Forget Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ),
                      ),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: 200,
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {
                                signIn();
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),

                      //Dont have an account?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Dont have an account?',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                              children: [
                                TextSpan(
                                  text: ' Sign Up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
