// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Auth/signin.dart';
import 'package:dokan/Auth/userform.dart';
import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/components.dart';
import 'package:dokan/Screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  //TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //TextEditingController _confirmPasswordController = TextEditingController();

  signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => UserForm()));
      } else {
        Fluttertoast.showToast(msg: 'Something is Wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
                    'Sign Up',
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
                    hint: 'User Name',
                  ),
                  // Textfields(
                  //     isPassword: false,
                  //     needSaffixIcon: false,
                  //     inputTypes: TextInputType.emailAddress,
                  //     textControl: _nameController),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  TextfieldHint(
                    hint: 'Email',
                  ),
                  Textfields(
                      isPassword: false,
                      needSaffixIcon: false,
                      inputTypes: TextInputType.emailAddress,
                      textControl: _emailController),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
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
                  TextfieldHint(
                    hint: 'Confirm Password',
                  ),
                  // Textfields(
                  //     isPassword: true,
                  //     needSaffixIcon: true,
                  //     inputTypes: TextInputType.visiblePassword,
                  //     textControl: _confirmPasswordController),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                ],
              ),
            ),
            //-----------------------------------------------------------------
            Divider(
              color: Colors.transparent,
              height: 150,
            ),

            Column(
              children: [
                PrimaryButton(
                  buttonText: 'Sign Up',
                  gotoPage: () {
                    signUp();
                  },
                ),
                // OutlinedButton(
                //   onPressed: () {
                //     signUp();
                //   },
                //   style: OutlinedButton.styleFrom(
                //     minimumSize:
                //         Size(MediaQuery.of(context).size.width / 2.3, 55),
                //     backgroundColor: AppColor.fillColorL,
                //     primary: AppColor.appMainColor,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15)),
                //     side: const BorderSide(
                //       color: AppColor.appMainColor,
                //       width: 2,
                //     ),
                //     elevation: 0,
                //   ),
                //   child: Text(
                //     'Sign Up',
                //     style: AllTextStyle.bodyTextStyle,
                //   ),
                // ),
                //-----------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Richtexts(
                    firstText: 'Already have an account? ',
                    secText: 'Sign In',
                    roughtpage: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SinginPage(),
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
