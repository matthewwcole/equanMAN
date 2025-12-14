import 'package:flutter/material.dart';

class AppTheme {
  static final oceanTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF03045e), // Deep Twilight
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF03045e), // Deep Twilight
      ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        //foregroundColor: WidgetStateProperty.all(Color(0xFFCAF0F8)), // Light Cyan
        //backgroundColor: WidgetStateProperty.all(Color(0xFF0096C7)), // Blue Green
        shadowColor: WidgetStateProperty.all(Color(0xFFCAF0F8)), // Light Cyan
        //surfaceTintColor: WidgetStateProperty.all(Colors.transparent), // Prevents unwanted color overlay
        //backgroundColor: WidgetStateProperty.all(Color(0xFF48CAE4)), // Sky Aqua
        //backgroundColor: WidgetStateProperty.all(Color(0xFF023e8a)), // French Blue
        //elevation: WidgetStatePropertyAll(10),
        // other button properties...
      ),
    ),
    cupertinoOverrideTheme: MaterialBasedCupertinoThemeData(
      materialTheme: ThemeData(primaryColor: Color(0xFF0096C7))),
  );
}
