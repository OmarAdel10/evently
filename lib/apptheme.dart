import 'package:flutter/material.dart';

class Apptheme {
  static const Color primary = Color(0xFF5669FF);
  static const Color white = Color(0xFFF2FEFF);
  static const Color black = Color(0xFF1C1C1C);
  static const Color red = Color(0xFFFF5659);
  static const Color grey = Color(0xFF7B7B7B);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: white,

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
    )
  );

  static ThemeData darkTheme = ThemeData();
}
