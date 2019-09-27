import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Firebase {
  static FirebaseApp _app;
  static FirebaseAuth _auth;
  static get auth => _auth;

  static Future initialize() async {
    _app = await FirebaseApp.appNamed(FirebaseApp.defaultAppName); 
    _auth = FirebaseAuth.fromApp(_app);
  }
}
