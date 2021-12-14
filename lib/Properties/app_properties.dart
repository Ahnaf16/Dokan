import 'package:flutter/material.dart';

class AppColor {
  static const Color appMainColor = Colors.brown;
  static const Color appBackground = Colors.white;
  static Color appSecColor = Colors.brown.shade100;
  static const Color textColorL = Color(0xFF292929);
  static const Color fillColorL = Colors.white;
}

//----------------------------------------------------------------

class AppTextStyle {
  static const TextStyle headerStyle = TextStyle(
    color: AppColor.appMainColor,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    color: AppColor.textColorL,
    fontSize: 22,
  );

  static const TextStyle smallTextStyle = TextStyle(
    color: AppColor.textColorL,
    fontSize: 18,
  );
}
