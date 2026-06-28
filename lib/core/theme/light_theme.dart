import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';

import '../constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0XFF161F1B),
  ),
  scaffoldBackgroundColor: Color(0xfff5f5f5),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffFFFFFF),
    titleTextStyle: TextStyle(color: Color(0xff000000), fontSize: AppSizes.sp16 , fontWeight: FontWeight.w700),
    iconTheme: IconThemeData(color: Color(0xff000000)),
    centerTitle: true,
    scrolledUnderElevation: 0,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.white
  ),
  // switchTheme: SwitchThemeData(
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Color(0xff15B86C);
  //     }
  //     return Colors.white;
  //   }),
  //   thumbColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.white;
  //     }
  //     return Color(0xff9E9E9E);
  //   }),
  //   trackOutlineColor: WidgetStateProperty.resolveWith((states) {
  //     return Color(0xff9E9E9E);
  //   }),
  //
  //   trackOutlineWidth: WidgetStateProperty.all(2),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primaryColor,
      foregroundColor: (Color(0xffFFFCFC)),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      minimumSize: Size.fromHeight(AppSizes.h52)
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style:

    TextButton.styleFrom(foregroundColor: LightColor.primaryColor),
  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: (Color(0xff15B86C)),
  //   foregroundColor: (Color(0xffFFFCFC)),
  //   extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  // ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.sp20,
      color: LightColor.primaryColor,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      color: LightColor.primaryColor,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      color: LightColor.primaryColor,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: LightColor.primaryColor,
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff6E7191),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: LightColor.primaryColor,
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: LightColor.primaryColor,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(color: LightColor.primaryColor, fontSize: AppSizes.sp20),
    labelMedium: TextStyle(color: LightColor.primaryColor, fontSize: AppSizes.sp16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF9E9E9E)),
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    focusColor: Color(0xffD1DAD6),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r2),
      borderSide: BorderSide(color: LightColor.backgroundTextField, width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r2),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r2),
      borderSide: BorderSide(color: LightColor.backgroundTextField, width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r2),
      borderSide: BorderSide(color: LightColor.backgroundTextField, width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: LightColor.backgroundTextField, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(AppSizes.r4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  dividerTheme: DividerThemeData(color: LightColor.backgroundTextField),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(color: Color(0XFF161F1B), fontSize: AppSizes.sp20),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blueAccent,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColor.backgroundColor,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xff363636),
    selectedItemColor: LightColor.primaryColor,
    showUnselectedLabels: true,
  ),
  //
  // popupMenuTheme: PopupMenuThemeData(
  //     color: Color(0xffF6F7F9),
  //     elevation: 5,
  //     shadowColor: Colors.black,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadiusGeometry.circular(16),
  //     ),
  //     labelTextStyle: WidgetStateProperty.all(
  //         TextStyle(
  //         fontSize: 17 ,
  //         fontWeight: FontWeight.w400 ,
  //           color: Colors.black
  //     ))
  // ),

  //);
  // splashFactory: NoSplash.splashFactory,
);
