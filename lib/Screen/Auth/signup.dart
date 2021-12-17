// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dokan/Properties/export.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isloading = false;
  bool isPassword = true;

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

            cDivider(50),

//----------------------------button-------------------------------------

            OutlinedButton(
              onPressed: () {
                if (isloading) return;
                setState(() {
                  isloading = true;
                });
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
