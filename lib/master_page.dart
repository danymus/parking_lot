import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterQRCode/QRWidget.dart';
import 'package:flutterQRCode/home_widget.dart';
import 'package:flutterQRCode/notification_widget.dart';
import 'package:flutterQRCode/payment_widget.dart';
import 'package:flutterQRCode/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterQRCode/database/database_controller.dart';

class  MasterPage extends StatefulWidget {
  final User user = FirebaseAuth.instance.currentUser as User;
  MasterPage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  State< MasterPage> createState() => _MasterPageState(user:user);
}

class _MasterPageState extends State< MasterPage> {
  _MasterPageState({required this.user});
  final User user;
  int _page = 0;
  
  List<StatelessWidget> getScreens(){

    return [HomeWidget(), PaymentWidget(), QRWidget(), NotifyWidget(), ProfileWidget(user: user)];
  }
  
  @override
  Widget build(BuildContext context) {
    final DatabaseController controller = DatabaseController.instance();

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.blue,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 26, color: Colors.white),
          Icon(Icons.paid, size: 26, color: Colors.white),
          Icon(Icons.qr_code_2, size: 26, color: Colors.white),
          Icon(Icons.notifications, size: 26, color: Colors.white),
          Icon(Icons.person, size: 26, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            
          });
        },
      ),
      body: getScreens()[_page]
    );
  }
}
