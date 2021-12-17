import 'package:flutter/material.dart';

class AppColor {
  static const Color appMainColor = Colors.brown;
  static const Color appBackground = Colors.white;
  static Color appSecColor = Colors.brown.shade100;
  static const Color textColorL = Color(0xFF292929);
  static const Color fillColorL = Colors.white;
}

//----------------------------cDivider-------------------------------------

Widget cDivider(
  double dh,
) {
  return SizedBox(
    height: dh,
  );
}

//----------------------textStyle------------------------------------------

class AppTextStyle {
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

//----------------------------buttonStyle-------------------------------------

ButtonStyle buttonStyle = OutlinedButton.styleFrom(
  minimumSize: const Size(200, 55),
  backgroundColor: AppColor.fillColorL,
  primary: AppColor.appMainColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  side: const BorderSide(
    color: AppColor.appMainColor,
    width: 2,
  ),
);

//----------------------------textfieldStyle-------------------------------------

InputDecoration textfilesStyle(String labelText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    labelText: labelText,
    labelStyle: AppTextStyle.bodyTextStyle,
    filled: true,
    fillColor: AppColor.fillColorL,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColor.appMainColor,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColor.appMainColor,
        width: 2,
      ),
    ),
  );
}
