import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeConfig = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      textStyle: MaterialStateProperty.all<TextStyle>(
        GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1E834E),
    onPrimary: Colors.white,
    secondary: Colors.orange,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.grey,
    onSurface: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.montserrat(
      color: const Color(0xFF1E834E),
      fontSize: 64,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: GoogleFonts.montserrat(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: GoogleFonts.montserrat(
      color: Colors.black,
      fontSize: 16,
    ),
    displayMedium: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
);
