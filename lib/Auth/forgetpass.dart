// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/components.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.appMainColor,
          ),
        ),
        backgroundColor: AppColor.appBackground,
        shadowColor: AppColor.appBackground,
        elevation: 0,
      ),
//-----------------------------------------------------------------
      body: Column(
        children: [
          SizedBox(
            //color: Colors.amber,
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Restore Password',
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
                ),
                Divider(
                  height: 10,
                ),
              ],
            ),
          ),
//-----------------------------------------------------------------
          Divider(
            height: 150,
          ),
          PrimaryButton(
            buttonText: 'Restore password',
            gotoPage: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
