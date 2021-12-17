// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function(User?) onGuestLogIn;
  LoginPage({required this.onGuestLogIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //----------------------------guest Login-------------------------------------

  guestLogIn() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    widget.onGuestLogIn(userCredential.user);
  }
//------------------------------------------------------------------------------

  bool isloading = false;
  bool loginLoading = false;
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            cDivider(100),

            Text(
              'Log In',
              style: AppTextStyle.headerStyle,
            ),

            cDivider(100),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: TextField(
                //controller: ,
                keyboardType: TextInputType.emailAddress,
                style: AppTextStyle.bodyTextStyle,
                decoration: textfilesStyle('Email'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: TextField(
                //controller: ,
                obscureText: isPassword,

                style: AppTextStyle.bodyTextStyle,
                decoration: textfilesStyle('Password').copyWith(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.appMainColor,
                    ),
                  ),
                ),
              ),
            ),

            cDivider(50),

//----------------------------button-------------------------------------

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (loginLoading) return;
                      setState(() {
                        loginLoading = true;
                      });
                    },
                    style: buttonStyle,
                    child: loginLoading
                        ? CircularProgressIndicator(
                            color: AppColor.appMainColor,
                          )
                        : Text(
                            'Log In',
                            style: AppTextStyle.bodyTextStyle,
                          ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (isloading) return;
                      setState(() {
                        isloading = true;
                      });
                      await guestLogIn();
                    },
                    style: buttonStyle,
                    child: isloading
                        ? CircularProgressIndicator(
                            color: AppColor.appMainColor,
                          )
                        : Text(
                            'Guest LogIn',
                            style: AppTextStyle.bodyTextStyle,
                          ),
                  ),
                ],
              ),
            ),

            cDivider(8),

            Richtexts(
              firstText: 'Don\'t have an account? ',
              secText: 'Sign Up',
              roughtpage: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
