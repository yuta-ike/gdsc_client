import 'package:flutter/material.dart';

class MainTheme {
  final Color colorPrimary = Colors.black;
  final Color colorAccent = Colors.white;

  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: colorPrimary,
      accentColor: colorAccent,
    );
  }
}
