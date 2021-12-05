import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/material.dart';

class Mytheme {
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColor.appBackground,
    colorScheme: const ColorScheme.light(
      secondary: AppColor.appMainColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.fillColorL,
        primary: AppColor.appMainColor,
        side: const BorderSide(
          color: AppColor.appMainColor,
        ),
      ),
    ),
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: AppColor.appBackgroundDark,
    colorScheme: const ColorScheme.dark(
      secondary: AppColor.appMainColorDark,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.fillColorD,
        primary: AppColor.appMainColorDark,
        side: const BorderSide(
          color: AppColor.appMainColorDark,
          width: 2,
        ),
      ),
    ),
  );
}
