import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/App/firestore_services.dart';
import 'package:first_app/App/home_screen.dart';
import 'package:first_app/App/signin_screen.dart';
import 'package:first_app/App/user_model.dart';
import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:mime/mime.dart';

class signUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _signUpScreen();
}

class _signUpScreen extends State<signUpScreen> {

//firestoreservice
final FirestoreServices firestoreServices = FirestoreServices();

//Sign in function
  Future signUp() async {
    // checking if Textfields are empty
    if (_emailTextcontroller.text == "" ||
        _passwordTextcontroller.text == "" ||
        _usernameTextcontroller.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please fill all the fields',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.white,
      ));
    } else {
      try {
         FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailTextcontroller.text.trim(),
            password: _passwordTextcontroller.text.trim()).then((value) {
              print(value.user?.uid);
              final newUser = UserModel(
                username: _usernameTextcontroller.text, 
                email: _emailTextcontroller.text, 
                password: _passwordTextcontroller.text, 
                image: imageUrl,
                latitude: null,
                longitude: null, );
                firestoreServices.addUser(newUser);
              
            });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Error occurs, please try again',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          ),
          backgroundColor: Colors.white,
        ));
      }
    }
  }

  //image picker
   String imageUrl = '';
   File? selectedImage;
  Future<String> uploadFile() async {

    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  try {
    String path = "images/${DateTime.now().millisecondsSinceEpoch}";
    final mimeType = lookupMimeType(file!.path);
    print(mimeType);
    final firebasestorage.FirebaseStorage _storage =
        firebasestorage.FirebaseStorage.instance;
    var reference = _storage.ref().child(path);
    var r = await reference.putData(
        await file.readAsBytes(), SettableMetadata(contentType: mimeType));

    if (r.state == firebasestorage.TaskState.success) {
      imageUrl = await reference.getDownloadURL();
      setState(() {
      selectedImage = File(file.path);
    });
      return imageUrl;
    } else {
      throw PlatformException(code: "404", message: "no download link found");
    }
  } catch (e) {
    rethrow;
  }
}

  //Text controller
  TextEditingController _usernameTextcontroller = TextEditingController();
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
        //   backgroundColor: Colors.transparent,
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       gradient: const LinearGradient(
        //         colors: [
        //           Color.fromARGB(255, 244, 94, 94),
        //           Color.fromARGB(255, 234, 50, 50),
        //           Color.fromARGB(255, 245, 45, 45),
        //           Color.fromARGB(255, 243, 91, 157),
        //         ],
        //         transform: GradientRotation(1),
        //         stops: [0.18, 0.25, 0.35, 2.00],
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //       ),
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
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
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),

                      // Profile picker
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.pinkAccent,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: selectedImage == null
                              ? AssetImage('assets/images/user.png')
                              : FileImage(selectedImage!) as ImageProvider,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: uploadFile,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      
                      //username TextFiled
                      reusableTextFields(
                          controller: _usernameTextcontroller,
                          fieldName: 'User Name',
                          obscureText: false,
                          icon: Icons.person),

                      //Email TextFiled
                      reusableTextFields(
                          icon: Icons.email,
                          controller: _emailTextcontroller,
                          fieldName: 'Email',
                          obscureText: false),

                      //password TextFiled
                      reusableTextFields(
                          icon: Icons.lock,
                          controller: _passwordTextcontroller,
                          fieldName: 'Password',
                          obscureText: true),

                      // Signup Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: 200,
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),

                      //Already have an account
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                              children: [
                                TextSpan(
                                  text: ' login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                signInScreen())),
                                ),
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
