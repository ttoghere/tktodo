import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      dividerTheme: DividerThemeData(color: Colors.red[200]),
      iconTheme: IconThemeData(
        color: Colors.red[200],
      ),
      appBarTheme: AppBarTheme(
        color: Colors.red[200],
        titleTextStyle: const TextStyle(
          color: Colors.white70,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red[200],
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.red[200],
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.red[900]),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
        background: const Color(0xFF212121),
        brightness: Brightness.dark,
      ),
    ),

    //
    //

    AppTheme.lightTheme: ThemeData(
      primaryColor: Colors.white,
      dividerTheme: DividerThemeData(color: Colors.red[900]),
      appBarTheme: AppBarTheme(
        color: Colors.red[900],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.red[200],
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.red[900]),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
        background: const Color(0xFFE5E5E5),
        brightness: Brightness.light,
      ),
    ),
  };
}
