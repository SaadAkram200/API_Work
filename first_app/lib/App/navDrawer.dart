import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/App/firestore_services.dart';
import 'package:first_app/App/user_model.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
   //forestore services instant
 FirestoreServices _firestoreServices = FirestoreServices(); 

//testing variable
UserModel ?userData;

 //geting user info
  @override
  void initState() {
    super.initState();
    var uid = FirebaseAuth.instance.currentUser!.uid;
  _firestoreServices.users.doc(uid).snapshots().listen((snapshot) { 
    
    if(snapshot.exists){
      userData = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      
      setState(() {
      });
      
    }else{
      print('no data');
    }
  });
  }
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userData != null? userData!.username: 'loading'),
            accountEmail: Text(userData != null? userData!.email: 'loading'),
            currentAccountPicture: ClipOval(
              child: CircleAvatar(
                radius: 40,
                child: userData?.image !=null? Image.network(userData!.image!):Image.asset(
                  'assets/images/user.png',
                  //fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/Background_Image.png')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Friends'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}