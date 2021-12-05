// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Auth/forgetpass.dart';
import 'package:dokan/Auth/userform.dart';
import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/components.dart';
import 'package:dokan/Screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({Key? key}) : super(key: key);

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  signIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage()));
      } else {
        Fluttertoast.showToast(msg: 'Something is Wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
                    style: AllTextStyle.headerStyle,
                  ),
                ),
              ),
            ),
            //-----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextfieldHint(
                    hint: 'Email',
                  ),
                  Textfields(
                      isPassword: false,
                      needSaffixIcon: false,
                      inputTypes: TextInputType.emailAddress,
                      textControl: _emailController),
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  TextfieldHint(
                    hint: 'Password',
                  ),
                  Textfields(
                      isPassword: true,
                      needSaffixIcon: true,
                      inputTypes: TextInputType.visiblePassword,
                      textControl: _passwordController),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  //-----------------------------------------------------------------
                  Richtexts(
                    firstText: '',
                    secText: 'Forget Password?',
                    roughtpage: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPassword(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
              height: 300,
            ),
            Column(
              children: [
                PrimaryButton(
                  buttonText: 'Sign In',
                  gotoPage: () => signIn(),
                ),
                //-----------------------------------------------------------------

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Richtexts(
                    firstText: 'Don\'t have an account? ',
                    secText: 'Sign Up',
                    roughtpage: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingupPage(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
