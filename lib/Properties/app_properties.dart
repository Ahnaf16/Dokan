import 'package:flutter/material.dart';

class AppColor {
  static const Color appMainColor = Color(0xFF373737);
  static const Color appSecColor = Colors.white;
  static const Color textColorL = Color(0xff373737);
  static const Color fillColorL = Color(0xffe7e7e7);

  //dark color
  static const Color appMainDarkColor = Color(0xff81C784);
  static const Color textColorD = Color(0xff373737);
}

//----------------------------------------------------------------

class AllTextStyle {
  static const TextStyle headerStyle = TextStyle(
    color: AppColor.appMainColor,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    color: AppColor.appMainColor,
    fontSize: 22,
  );

  static const TextStyle smallTextStyle = TextStyle(
    color: AppColor.appMainColor,
    fontSize: 18,
  );
}
