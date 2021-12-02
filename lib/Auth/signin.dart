// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({Key? key}) : super(key: key);

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppColor.appMainColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              child: Container(
                color: AppColor.appMainColor,
                height: 260,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 50),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -250,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.appSecColor,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 30, 30),
                      child: ListTile(
                        title: Text(
                          'Welcome Back !',
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColor.appMainColor,
                          ),
                        ),
                        subtitle: Text(
                          'Great to see you back !',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.appMainColor,
                              ),
                              child: Icon(
                                Icons.mail_outline,
                                size: 30,
                                color: AppColor.appSecColor,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: TextField(
                              style: TextStyle(fontSize: 25),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'EMAIL',
                                hintStyle: TextStyle(
                                    fontSize: 20, color: Colors.redAccent[200]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent.shade400,
                                      width: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.appMainColor,
                              ),
                              child: Icon(
                                Icons.lock_outline,
                                size: 30,
                                color: AppColor.appSecColor,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: TextField(
                              style: TextStyle(fontSize: 25),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'PASSWORD',
                                hintStyle: TextStyle(
                                    fontSize: 20, color: Colors.redAccent[200]),
                                suffixIcon: Icon(
                                  Icons.visibility,
                                  color: AppColor.appMainColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent.shade400,
                                      width: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.appMainColor,
                        onPrimary: AppColor.appSecColor,
                        minimumSize: Size(435, 60),
                        elevation: 5,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: AppColor.appMainColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingupPage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
