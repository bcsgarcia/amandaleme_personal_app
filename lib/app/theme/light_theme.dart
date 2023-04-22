import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xffED691A);
const Color secondaryColor = Color(0xFFD45700);
const Color blackColor = Color(0xFF000000);
const Color lightGrayColor = Color(0xFFD9D9D9);
const Color whiteColor = Color(0xFFFFFFFF);
const Color accentColor = Color(0xFF362F2C);
const Color successColor = Color(0xFF32C71A);

final theme = ThemeData(
  textTheme: GoogleFonts.robotoTextTheme(),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.blue,
  ),
  primaryColor: primaryColor,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: Color(0xFFD45700),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: blackColor,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: blackColor,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      minimumSize: const Size(291, 51),
      textStyle: const TextStyle(
        color: whiteColor,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
    ),
  ),
);
