// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final Function(User?) onLogIn;
  SignUpPage({required this.onLogIn});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
//

  Future signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      //widget.onLogIn(null);
      var authCredential = userCredential.user;

      if (_passwordController.text != _confirmPassController.text) {
        error = 'Passwod did\'t match';
      }

      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LoginPage(onLogIn: (userCred) => test(userCred)),
          ),
        );
      } else {
        error = 'Something is Wrong';
      }
      widget.onLogIn(userCredential.user);
    } on FirebaseException catch (e) {
      setState(() {
        error = e.message!;
        if (e.message == 'Given String is empty or null') {
          error = 'Please enter a email';
        }
        if (e.code == 'weak-password') {
          error = 'The password is too weak.';
        } else if (e.code == 'email-already-in-use') {
          error = 'The account already exists for that email.';
        }
      });
    }
  }

  test(userCred) {
    setState(() {
      user = userCred;
      widget.onLogIn(user);
    });
  }

  User? user;
  String error = '';
  bool isloading = false;
  bool isPassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            cDivider(100),

            Text(
              'Sign Up',
              style: AppTextStyle.headerStyle,
            ),

            cDivider(100),
            //----------------------------textfields-------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                style: AppTextStyle.bodyTextStyle,
                decoration: textfilesStyle('Name'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: TextField(
                controller: _emailController,
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
                controller: _passwordController,
                obscureText: isPassword,
                style: AppTextStyle.bodyTextStyle,
                decoration: textfilesStyle('Password').copyWith(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(
                        () {
                          isPassword = !isPassword;
                        },
                      );
                    },
                    child: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.appMainColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: TextField(
                controller: _confirmPassController,
                obscureText: isPassword,
                style: AppTextStyle.bodyTextStyle,
                decoration: textfilesStyle('Confirm Password').copyWith(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(
                        () {
                          isPassword = !isPassword;
                        },
                      );
                    },
                    child: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.appMainColor,
                    ),
                  ),
                ),
              ),
            ),

            cDivider(5),

            Text(
              error,
              style: AppTextStyle.errorText,
            ),

            cDivider(50),

//----------------------------button-------------------------------------

            OutlinedButton(
              onPressed: () async {
                if (isloading) return;
                setState(() {
                  isloading = true;
                });

                await signUp();
                isloading = false;
              },
              style: buttonStyle,
              child: isloading
                  ? CircularProgressIndicator(
                      color: AppColor.appMainColor,
                    )
                  : Text(
                      'Sign Up',
                      style: AppTextStyle.bodyTextStyle,
                    ),
            ),

            cDivider(8),

            Richtexts(
              firstText: 'Already have an account? ',
              secText: 'Log In',
              roughtpage: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
