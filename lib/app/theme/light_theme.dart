import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xffED691A);
const Color secondaryColor = Color(0xFFD45700);
const Color blackColor = Color(0xFF000000);
const Color lightGrayColor = Color(0xFFD9D9D9);
const Color whiteColor = Color(0xFFFFFFFF);
const Color accentColor = Color(0xFF362F2C);
const Color successColor = Color(0xFF32C71A);
const Color errorColor = Color(0xFFDE3730);

final theme = ThemeData(
  // useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 0,
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Color(0xffbbd6fb),
  ),
  primaryColor: primaryColor,
  // colorScheme: const ColorScheme.light(
  //   primary: primaryColor,
  //   secondary: Color(0xFFD45700),
  // ),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    //background: Colors.black, // Ajustando para uma cor de fundo escura
    // surface: Colors.black, // Superfícies com cor preta
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
