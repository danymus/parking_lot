import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWidget extends StatefulWidget {
    const LoginWidget(Key? key): super(key: key);

  @override
    State<LoginWidget> createState() =>_LoginWjdgetState();
}

class _LoginWjdgetState extends State<LoginWidget>  {
  bool isLogin = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextControllers = [TextEditingController(), TextEditingController()];

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Login Error: $e');
    }
  }
   Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showDialog<void>(context: context,barrierDismissible: false,builder: (BuildContext context) {return AlertDialog(
        title: const Text('AlertDialog'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("gey"),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );;
    }
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin? 'Login' : 'Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'E-mail'),
              controller: TextControllers[0],
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              controller: TextControllers[1],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(isLogin)
                {
                  signIn(TextControllers[0].text, TextControllers[1].text);
                }
                else
                {
                  createUser(TextControllers[0].text, TextControllers[1].text);
                }
              },
              child: Text(isLogin? 'Login' : 'Sign Up'),
            ),
            Visibility(
              visible: isLogin? true : false,
              child:
                ElevatedButton
                (
                  onPressed: () 
                  {
                    setState((){

                      isLogin = false;
                    });
                  },
              child: Text('Sign Up'),
            ),
            
            )
          ],
        ),
      ),
    );
  }
}