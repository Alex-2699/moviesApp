import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 36, 56, 70);

  static const TextStyle headTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    platform: TargetPlatform.iOS,
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white)
    ),

  );
}
