import 'package:flutter/material.dart';

class AppColor {
  static const Color appMainColor = Color(0xFF292929);
  static const Color appBackground = Colors.white;
  static const Color appSecColor = Colors.black12;
  static const Color textColorL = Color(0xFF292929);
  static const Color fillColorL = Colors.white;
}

//----------------------------------------------------------------

class AppTextStyle {
  static const TextStyle headerStyle = TextStyle(
    color: AppColor.textColorL,
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
