// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Auth/forgetpass.dart';
import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/components.dart';
import 'package:dokan/Screen/homepage.dart';
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
      backgroundColor: AppColor.appSecColor,
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
              height: 300,
            ),
            Column(
              children: [
                PrimaryButton(
                  buttonText: 'Sign In',
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
