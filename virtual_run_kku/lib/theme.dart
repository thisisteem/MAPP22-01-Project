import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/constants/colors.dart';

class RunKKUTheme {
  static ThemeData themeData() {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: colorWhite,
        foregroundColor: colorSecondary,
        elevation: 0,
        titleTextStyle: textTheme.titleMedium,
      ),
      dividerTheme: DividerThemeData(color: colorGrey, thickness: 1, space: 0),
      textTheme: textTheme,
      textSelectionTheme: TextSelectionThemeData(cursorColor: colorSecondary),
    );
  }

  static TextTheme textTheme = TextTheme(
    titleLarge: GoogleFonts.kanit(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: colorSecondary,
    ),
    titleMedium: GoogleFonts.kanit(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: colorSecondary,
    ),
    titleSmall: GoogleFonts.kanit(
      fontSize: 36,
      fontWeight: FontWeight.w300,
      color: colorSecondary,
    ),
    displayLarge: GoogleFonts.kanit(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorSecondary,
    ),
    displayMedium: GoogleFonts.kanit(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: colorSecondary,
    ),
    displaySmall: GoogleFonts.kanit(
      fontSize: 24,
      fontWeight: FontWeight.w300,
      color: colorSecondary,
    ),
    headlineLarge: GoogleFonts.kanit(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: colorSecondary,
    ),
    headlineMedium: GoogleFonts.kanit(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: colorSecondary,
    ),
    headlineSmall: GoogleFonts.kanit(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: colorSecondary,
    ),
    bodyLarge: GoogleFonts.kanit(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: colorSecondary,
    ),
    bodyMedium: GoogleFonts.kanit(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: colorSecondary,
    ),
    bodySmall: GoogleFonts.kanit(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: colorSecondary,
    ),
    labelLarge: GoogleFonts.kanit(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colorSecondary,
    ),
    labelMedium: GoogleFonts.kanit(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: colorSecondary,
    ),
    labelSmall: GoogleFonts.kanit(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: colorSecondary,
    ),
  );
}
