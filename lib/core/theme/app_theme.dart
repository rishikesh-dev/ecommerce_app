import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/theme/theme_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _lightTheme = ThemeData(
    //App Primary Colors
    fontFamily: encode,
    brightness: Brightness.light,
    focusColor: ThemePallete.greyColor,
    cardColor: ThemePallete.blackColor,
    hintColor: ThemePallete.whiteColor,
    canvasColor: ThemePallete.redColor,

    highlightColor: Colors.grey.shade200,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: ThemePallete.whiteColor,
    //Top section
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    //Body Decorations
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ThemePallete.greyColor),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: ThemePallete.blackColor),
      bodySmall: TextStyle(color: ThemePallete.greyColor),
    ),
    //bottom nav
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ThemePallete.whiteColor,
      selectedItemColor: ThemePallete.blackColor,
      unselectedItemColor: ThemePallete.greyColor,
      selectedLabelStyle: TextStyle(color: ThemePallete.blackColor),
      unselectedLabelStyle: TextStyle(color: ThemePallete.greyColor),
    ),
  );
  static final ThemeData _darkTheme = ThemeData(
    fontFamily: encode,
    brightness: Brightness.dark,
    focusColor: ThemePallete.greyColor,
    cardColor: ThemePallete.whiteColor,
    hintColor: ThemePallete.whiteColor,
    canvasColor: ThemePallete.redColor,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: ThemePallete.blackColor,
    // Top Section
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    //Body Sections
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ThemePallete.greyColor),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: ThemePallete.whiteColor),
      bodySmall: TextStyle(color: ThemePallete.greyColor),
    ),
    //bottom nav
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ThemePallete.blackColor,
      selectedItemColor: ThemePallete.whiteColor,
      unselectedItemColor: ThemePallete.greyColor,
      selectedLabelStyle: TextStyle(color: ThemePallete.whiteColor),
      unselectedLabelStyle: TextStyle(color: ThemePallete.greyColor),
    ),
  );
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}
