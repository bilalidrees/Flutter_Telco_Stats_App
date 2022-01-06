import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData zongTheme = lightTheme;
}

ThemeData lightTheme = ThemeData(
  primaryColor: AppColor.mainColor,
  brightness: Brightness.light,
  primarySwatch: AppColor.greenAppBarColor,
  scaffoldBackgroundColor: AppColor.canvasColor,
  hintColor: Colors.grey,
  primaryColorLight: AppColor.darkPink,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 60, color: AppColor.blackTextColor),
    bodyText1: TextStyle(color: AppColor.blackTextColor),
    subtitle1: TextStyle(
        color: AppColor.darkGreyTextColor), //define your customize setting
  ),
);
