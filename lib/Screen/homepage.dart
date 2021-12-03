import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Homepage',
            style: AllTextStyle.headerStyle,
          ),
        ),
      ),
    );
  }
}
