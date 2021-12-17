import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: AppColor.appBackground,
          child: const Text(
            'User Form',
            style: AppTextStyle.headerStyle,
          ),
        ),
      ),
    );
  }
}
