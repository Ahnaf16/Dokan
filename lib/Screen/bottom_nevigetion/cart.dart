import 'package:dokan/Properties/export.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.appBackground,
      body: Center(
        child: Text(
          'Cart',
          style: AppTextStyle.headerStyle,
        ),
      ),
    );
  }
}
