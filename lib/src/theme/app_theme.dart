import 'package:flutter/material.dart';

class AppTheme {
  // Definition of the color palette
  static const Color navyBlue = Color(0xFF0A1128);       // Deep night sky
  static const Color deepPurple = Color(0xFF1B1464);     // Mystical violet
  static const Color lavender = Color(0xFFE0B0FF);       // Bright glow
  static const Color burnishedGold = Color(0xFFD4AF37);  // Stars/Details
  static const Color sterlingSilver = Color(0xFFC0C0C0); // Texts/Contours

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Background
      scaffoldBackgroundColor: navyBlue,
      colorScheme: const ColorScheme.dark(
        primary: lavender,
        secondary: burnishedGold,
        surface: deepPurple,
        onSurface: sterlingSilver,
      ),

      // AppBar Design
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF050A1A), // Even darker navy
        foregroundColor: lavender,
        elevation: 0,
        centerTitle: true,
      ),

      // Card Design
      cardTheme: CardThemeData(
        color: deepPurple.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white10, width: 1),
        ),
      ),

      // Input Design (für das DreamForm)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: sterlingSilver),
        ),
        labelStyle: const TextStyle(color: lavender),
      ),

      // Button Design
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