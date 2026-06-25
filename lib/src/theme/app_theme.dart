import 'package:flutter/material.dart';

class AppTheme {
  // Definition of the color palette
  static const Color navyBlue = Color(0xFF0A1128); // Deep night sky
  static const Color deepPurple = Color(0xFF1B1464); // Mystical violet
  static const Color lavender = Color(0xFFE0B0FF); // Bright glow
  static const Color burnishedGold = Color(0xFFD4AF37); // Stars/Details

  static const Color lightSterlingSilver = Color(0xFFEAEAEA); // Texts/Contours
  static const Color sterlingSilver = Color(0xFFC0C0C0); // Texts/Contours

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Core Colors
      scaffoldBackgroundColor: navyBlue,
      colorScheme: const ColorScheme.dark(
        primary: lavender,
        secondary: burnishedGold,
        surface: deepPurple,
        onSurface: lightSterlingSilver,

        primaryContainer: navyBlue,
        onPrimaryContainer: lavender,
        secondaryContainer: deepPurple,
        onSecondaryContainer: sterlingSilver,
        
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF050A1A), // Even darker navy
        foregroundColor: lavender,
        elevation: 0,
        centerTitle: true,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: deepPurple.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white10, width: 1),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black26,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightSterlingSilver),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lavender, width: 1.5),
        ),
        labelStyle: const TextStyle(color: lavender),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepPurple,
          foregroundColor: lavender,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: burnishedGold,
        foregroundColor: navyBlue,
      ),
    );
  }
}
