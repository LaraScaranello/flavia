import 'package:flutter/material.dart';

class AppTheme {
  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF0B1020),
    textTheme: ThemeData.dark().textTheme,
    colorScheme: const ColorScheme.dark(
      primary: Colors.amberAccent,
      secondary: Colors.deepPurpleAccent
    ),
  );
}