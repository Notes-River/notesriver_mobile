// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomThemes {
  static String appName = 'Notes River';
  static Color lightPrimary = const Color(0xfff3f4f9);
  static Color darkPrimary = const Color(0xff2B2B2B);
  static Color lightAccent = const Color(0xff416d6d);
  static Color darkAccent = const Color(0xff597ef7);
  static Color lightBG = const Color(0xfff3f4f9);
  static Color darkBG = const Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: lightPrimary,
      titleTextStyle: const TextStyle(
          color: Color(0xff416d6d), fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    // ignore: duplicate_ignore
    appBarTheme: AppBarTheme(
      color: darkPrimary,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),
      // ignore: prefer_const_constructors
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light
      )
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkAccent),
    textSelectionTheme: TextSelectionThemeData(cursorColor: darkAccent),
  );
}
