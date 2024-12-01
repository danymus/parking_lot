import 'package:flutter/material.dart';
import 'package:flutterQRCode/master_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterQRCode/auth/login_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget _handleAuth() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            //Show the login screen if the user is not logged in.
            return LoginWidget(super.key);
          }
          //Show home screen if user is logged in.
          return MasterPage(user: user);
        }
        return CircularProgressIndicator();
      },
    );
  }
  Widget build(BuildContext context) {
    _auth.signOut();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _handleAuth(),
    );
  }
}
