// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future guestLogIn() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }
}
