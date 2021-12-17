import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screen/Auth/loginpage.dart';
import 'Properties/export.dart';

class Tree extends StatefulWidget {
  const Tree({Key? key}) : super(key: key);

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  User? user;

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginPage(
        onGuestLogIn: (userCred) => onRefresh(userCred),
      );
    }
    return Navibar(
      onClick: (userCred) => onRefresh(userCred),
    );
  }
}
