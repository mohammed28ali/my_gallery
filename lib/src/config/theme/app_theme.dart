import 'package:flutter/material.dart';
import 'package:my_gallery/src/core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.mainColor,
      hintColor: AppColors.hintColor,
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      //fontFamily: AppStrings.fontFamily,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
            color: Colors.white,
            height: 1.3,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ));
}
