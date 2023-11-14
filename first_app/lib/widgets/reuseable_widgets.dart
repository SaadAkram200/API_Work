import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Background_Image.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        cursorColor: Colors.grey, // Set cursor color to gray
        style: TextStyle(color: Colors.grey), // Set text color to gray
        decoration: InputDecoration(
          hintText: 'Email Address',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon:
              Icon(Icons.email, color: Colors.grey), // Set icon color to gray
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

TextField reusableTextField(
  String text, 
  IconData icon, 
  bool isPasswordType,
  TextEditingController controller
    ) {
  return TextField(
    maxLength: 50,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.grey,
    style: TextStyle(color: Colors.grey.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

// Reusables for App

class reusableTextFields extends StatefulWidget {
  final TextEditingController controller;
  final String fieldName;
  final bool obscureText;
  final IconData icon;

  reusableTextFields({
    required this.controller,
    required this.fieldName,
    required this.obscureText,
    required this.icon,
  });

  @override
  State<reusableTextFields> createState() => _reusableTextFieldsState();
  }
  class _reusableTextFieldsState extends State<reusableTextFields> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.redAccent),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.redAccent)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.redAccent)),
            label: Text(
              widget.fieldName,
              style: TextStyle(color: Colors.redAccent),
            ),
            prefixIcon: Icon(
              widget.icon,
              color: Colors.redAccent,
            ),
            suffixIcon: widget.obscureText
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;

                        //widget.obscureText =false;
                      });
                    },
                    child: showPassword
                        ? Icon(
                            Icons.visibility,
                            color: Colors.redAccent,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.redAccent,
                          ),
                  )
                : null),
        obscureText: widget.obscureText ? showPassword : !showPassword,
        controller: widget.controller,
      ),
    );
  }
}


// for provider work : grocery app
// ignore: must_be_immutable
class GroceryItemTile extends StatelessWidget {
  final String itemName, itemPrice, itemPath;
  final color;
  void Function()? onPressed;

  GroceryItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemPath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.network(
            itemPath,
            height: 80,
          ),
          Text(
            itemName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          MaterialButton(
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: color[800],
            child: Text(
              'Rs.' + itemPrice,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
