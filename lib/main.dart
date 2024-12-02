import 'package:flutter/material.dart';
import 'package:flutterQRCode/master_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterQRCode/auth/login_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget _handleAuth() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          print(user?.uid);
          if (user == null) {
            return LoginWidget(super.key);
          }
          return MasterPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _handleAuth(),
    );
  }
}
