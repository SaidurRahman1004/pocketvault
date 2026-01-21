import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //Privet Constructor for not Creating Obj
  AppTheme._();

  static final Color _lightPrimaryColor = Colors.blue.shade600;
  static final Color _lightOnPrimaryColor = Colors.white;
  static final Color _lightBackgroundColor = Colors.grey.shade100;

  static final Color _darkPrimaryColor = Colors.blue.shade400;
  static final Color _darkBackgroundColor = const Color(0xFF121212);
  static final Color _darkOnBackgroundColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: AppBarTheme(
      color: _lightBackgroundColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black87),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: _lightOnPrimaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: _lightPrimaryColor,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: AppBarTheme(
      color: _darkBackgroundColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: _darkOnBackgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: _darkOnBackgroundColor),
    ),
    colorScheme: ColorScheme.dark(primary: _darkPrimaryColor),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: _darkOnBackgroundColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkBackgroundColor,
      selectedItemColor: _darkPrimaryColor,
      unselectedItemColor: Colors.grey,
    ),
    cardTheme: CardThemeData(color: Colors.grey.shade900),
  );
}
