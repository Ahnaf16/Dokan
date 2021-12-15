// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dokan/Properties/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final Function(User?) onGuestLogIn;
  LoginPage({required this.onGuestLogIn});

  guestLogIn() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    onGuestLogIn(userCredential.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text(
                  'Log In',
                  style: AppTextStyle.headerStyle,
                ),
                SizedBox(
                  height: 100,
                ),

//----------------------------button-------------------------------------

                OutlinedButton(
                  onPressed: () {
                    guestLogIn();
                  },
                  style: buttonStyle,
                  child: Text(
                    'Guest LogIn',
                    style: AppTextStyle.bodyTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
