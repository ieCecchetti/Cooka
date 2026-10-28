import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Warm "handwritten recipe card" palette — the look of old recipe papers
/// people used to copy out and pass to each other: aged paper and sepia ink,
/// with the faded red of an index-card margin line.
class AppColors {
  static const paper = Color(0xFFF3E7C9); // aged paper cream
  static const paperDeep = Color(0xFFE7D4A8); // darker paper (edges/shadows)
  static const ink = Color(0xFF3B2A18); // dark sepia ink
  static const inkSoft = Color(0xFF75593B); // faded ink (secondary text)
  static const accent = Color(0xFFA6392A); // faded recipe-card red
  static const accentSoft = Color(0xFFC66B4C); // terracotta
  static const tape = Color(0x66D8C79C); // translucent masking tape
  static const line = Color(0xFFB79C6E); // ruled line brown
}

/// The paper texture asset, used as a tiled background on surfaces.
const _paperTexture = AssetImage('assets/images/paper-square.jpeg');

/// A reusable "piece of paper" decoration: textured cream with an ink border
/// and a soft drop shadow, as if it were lying on a kitchen table.
BoxDecoration paperDecoration({
  double radius = 6,
  Color border = AppColors.line,
  double borderWidth = 1,
  double textureOpacity = 0.35,
}) {
  return BoxDecoration(
    color: AppColors.paper,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: border, width: borderWidth),
    image: DecorationImage(
      image: _paperTexture,
      fit: BoxFit.cover,
      opacity: textureOpacity,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 8,
        offset: Offset(2, 4),
      ),
    ],
  );
}

/// A handwritten display style (recipe titles, headings).
TextStyle handwritten({
  double fontSize = 28,
  Color color = AppColors.ink,
  FontWeight weight = FontWeight.w700,
}) {
  return GoogleFonts.caveat(
    fontSize: fontSize,
    color: color,
    fontWeight: weight,
    height: 1.05,
  );
}

TextTheme _paperTextTheme() {
  // Typewriter body (as if the recipe were typed out), handwritten headings.
  final typed = GoogleFonts.specialEliteTextTheme();
  return typed
      .copyWith(
        displayLarge: handwritten(fontSize: 44),
        displayMedium: handwritten(fontSize: 36),
        headlineLarge: handwritten(fontSize: 30),
        headlineMedium: handwritten(fontSize: 26),
        titleLarge: handwritten(fontSize: 24),
      )
      .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink);
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.paper,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.accent,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.ink,
    onPrimary: AppColors.paper,
    secondary: AppColors.accent,
    onSecondary: Colors.white,
    surface: AppColors.paper,
    onSurface: AppColors.ink,
  ),
  textTheme: _paperTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.paper,
    foregroundColor: AppColors.ink,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: handwritten(fontSize: 34),
    iconTheme: const IconThemeData(color: AppColors.ink),
  ),
  dividerColor: AppColors.line,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      elevation: 2,
      textStyle: GoogleFonts.specialElite(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.accent,
      textStyle: GoogleFonts.specialElite(fontWeight: FontWeight.bold),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.accent,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: CircleBorder(),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.paperDeep,
    side: const BorderSide(color: AppColors.line),
    labelStyle: GoogleFonts.specialElite(color: AppColors.ink),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.paper,
    hintStyle: GoogleFonts.specialElite(color: AppColors.inkSoft),
    prefixIconColor: AppColors.inkSoft,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.line),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.line),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
    ),
  ),
);
