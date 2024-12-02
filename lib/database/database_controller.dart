import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseController 
{
  FirebaseDatabase database = FirebaseDatabase.instance;
  static final DatabaseController controller = DatabaseController.instance();
  final User user = FirebaseAuth.instance.currentUser as User;

  factory DatabaseController()
  {
    return controller;
  }

  getUser()
  {
    return user;
  }
  DatabaseController.instance();

  createEntry(User user,int transactionID)
  {
    try
    {
      database.ref("Transactions").child(user.uid).set({"QRData" : transactionID.toString()});
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  
  Future<String> getEntry() async
  {
    final data = await database.ref("Transaction").child(user.uid).once();
    return data.snapshot.value == null? "None" : data.snapshot.children.toList()[0].value.toString();
  }


}