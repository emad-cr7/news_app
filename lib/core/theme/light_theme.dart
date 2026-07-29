import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(),
  scaffoldBackgroundColor: Color(0xFFf5f5f5),
  primaryColor: LightColors.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF141414),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp16,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      minimumSize: Size.fromHeight(AppSizes.h52),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColors.primaryColor),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    focusColor: Color(0xFFD1DAD6),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColors.backgroundColor,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: LightColors.primaryColor,
    unselectedItemColor: Color(0xFF363636),
    showUnselectedLabels: true,
  ),
);
