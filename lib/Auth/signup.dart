// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Auth/forgetpass.dart';
import 'package:dokan/Auth/signin.dart';
import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/components.dart';
import 'package:dokan/Screen/homepage.dart';
import 'package:flutter/material.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appSecColor,
      body: Column(
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
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextfieldHint(
                    hint: 'User Name',
                  ),
                  Textfields(
                      isPassword: false,
                      needSaffixIcon: false,
                      inputTypes: TextInputType.emailAddress),
                  Divider(
                    height: 10,
                  ),
                  TextfieldHint(
                    hint: 'Email',
                  ),
                  Textfields(
                      isPassword: false,
                      needSaffixIcon: false,
                      inputTypes: TextInputType.emailAddress),
                  Divider(
                    height: 10,
                  ),
                  TextfieldHint(
                    hint: 'Password',
                  ),
                  Textfields(
                      isPassword: true,
                      needSaffixIcon: true,
                      inputTypes: TextInputType.visiblePassword),
                  Divider(
                    height: 10,
                  ),
                  TextfieldHint(
                    hint: 'Confirm Password',
                  ),
                  Textfields(
                      isPassword: true,
                      needSaffixIcon: true,
                      inputTypes: TextInputType.visiblePassword),
                  Divider(
                    height: 10,
                  ),
//-----------------------------------------------------------------
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                PrimaryButton(
                  buttonText: 'Sign Up',
                  gotoPage: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  ),
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
                        builder: (context) => SinginPage(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
