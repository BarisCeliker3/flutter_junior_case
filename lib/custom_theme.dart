import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6F35A5),
    onPrimary: Colors.white,
    secondary: Color(0xFFFFB74D),
    onSecondary: Colors.black,
    error: Color(0xFFD32F2F),
    onError: Colors.white,
    background: Color(0xFFF5F5F5),
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF6F35A5)),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
    bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF444444)),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF6F35A5)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF6F35A5),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF6F35A5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF6F35A5), width: 2),
    ),
    labelStyle: TextStyle(color: Color(0xFF6F35A5)),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF6F35A5),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);