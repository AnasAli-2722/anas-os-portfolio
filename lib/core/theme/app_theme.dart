import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color accent = Color(0xFFFF00FF);
  static const Color accentDim = Color(0xFFBD00BD);
  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFFAAAAAA);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accentDim,
        surface: surface,
        background: background,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.orbitron(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: accent,
        ),
        displayMedium: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.robotoMono(fontSize: 16, color: textPrimary),
        bodyMedium: GoogleFonts.robotoMono(fontSize: 14, color: textSecondary),
      ),
      iconTheme: const IconThemeData(color: accent),
    );
  }
}
