import 'package:flutter/material.dart';

class AppTheme {
  // Ultra-Premium Color Palette
  static const Color _primary = Color(0xFF006D5B); // Emerald Teal
  static const Color _secondary = Color(0xFFD4AF37); // Metallic Gold
  static const Color _backgroundLight = Color(0xFFF8F9FA); // Off-white
  static const Color _surfaceLight = Color(0xFFFFFFFF);
  static const Color _backgroundDark = Color(0xFF121212); // Deep Dark
  static const Color _surfaceDark = Color(0xFF1E1E1E);
  static const Color _error = Color(0xFFB00020);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _primary,
        onPrimary: Colors.white,
        secondary: _secondary,
        onSecondary: Colors.black,
        surface: _surfaceLight,
        onSurface: Colors.black87,
        error: _error,
      ),
      scaffoldBackgroundColor: _backgroundLight,
      splashFactory: InkRipple.splashFactory, // Premium Touch
      fontFamily: 'Outfit', // Global Font
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
      ),
      // textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).apply(
      //   bodyColor: Colors.black87,
      //   displayColor: _primary,
      // ).copyWith(
      //    // HD Typography Tweaks
      //    titleLarge: GoogleFonts.outfit(letterSpacing: -0.5), 
      //    bodyMedium: GoogleFonts.outfit(letterSpacing: 0.2),
      // ),
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Outfit',
        bodyColor: Colors.black87,
        displayColor: _primary,
      ).copyWith(
         titleLarge: const TextStyle(fontFamily: 'Outfit', letterSpacing: -0.5, fontSize: 22, fontWeight: FontWeight.w500), 
         bodyMedium: const TextStyle(fontFamily: 'Outfit', letterSpacing: 0.2),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _backgroundLight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.black87,
          fontSize: 24, // Bigger
          fontWeight: FontWeight.w900, // Extra Bold -> Black
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // Clean look
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        labelStyle: TextStyle(fontFamily: 'Outfit', color: Colors.grey[600]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w800, // Bold -> ExtraBold
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _primary,
        onPrimary: Colors.white,
        secondary: _secondary,
        onSecondary: Colors.black,
        surface: _surfaceDark,
        onSurface: Colors.white70,
        error: _error,
      ),
      scaffoldBackgroundColor: _backgroundDark,
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
      ),
      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'Outfit',
        bodyColor: Colors.white, // High Contrast (was white70)
        displayColor: _primary, 
      ).copyWith(
         titleLarge: const TextStyle(fontFamily: 'Outfit', letterSpacing: -0.5, fontSize: 22, fontWeight: FontWeight.w600), // w500 -> w600
         bodyMedium: const TextStyle(fontFamily: 'Outfit', letterSpacing: 0.2, fontWeight: FontWeight.w500), // Normal -> Medium
         bodyLarge: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w500), // Ensure body text is readable
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1), // Crisp Border
        ),
        color: _surfaceDark,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _backgroundDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.white,
          fontSize: 24, 
          fontWeight: FontWeight.w900, // ExtraBold -> Black
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)), // Visible border
        ),
         enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 2),
        ),
        hintStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white38), // Sharper hint
        contentPadding: const EdgeInsets.all(16),
        labelStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white70), // Sharper label
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w800, // Bold -> ExtraBold
          ),
        ),
      ),
    );
  }
}
