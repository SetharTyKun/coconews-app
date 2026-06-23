import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Color(0xFFFAF9F7), // warm off-white, easier on eyes than pure white
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,

      primary: Color(0xFF1E1D1B),
      onPrimary: Colors.white,

      surface: Colors.white,           // For card, button
      surfaceVariant: Color(0xFFEFEDE9), // For selected card, button
      onSurface: Color(0xFF1E1D1B),     // For normal text
      onSurfaceVariant: Color(0xFF8C8A85), // For muted text
    ),
  );

  static ThemeData dark = ThemeData.dark().copyWith(

    scaffoldBackgroundColor: Color(0xFF1E1D1B),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,

      primary: Colors.white,
      onPrimary: Colors.black,

      surface: Color(0xFF262422), // For card, button
      surfaceVariant: Color(0xFF4A4A4A), // For selected card, button
      onSurface: Color(0xFFEDEAE3), // For normal text
      onSurfaceVariant: Color(0xFF9C9A95), // For muted text
    ),
  );

}