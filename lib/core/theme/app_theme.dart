import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized light + dark [ThemeData] for the app. The light theme preserves
/// the previous in-app appearance; the dark theme uses the LazerVault dark
/// palette so Material-driven widgets adapt when dark mode is on.
///
/// NOTE: screens that hardcode colors won't fully adapt until they're migrated
/// to theme-aware colors — that reskin is intentionally deferred.
class AppTheme {
  AppTheme._();

  static const Color _brand = Color(0xFF4E03D0);

  // Dark palette.
  static const Color _darkBg = Color(0xFF0A0A0A);
  static const Color _darkSurface = Color(0xFF1F1F1F);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          // FLAT, LIKE THE DARK THEME BESIDE IT.
          //
          // Material 3 defaults an AppBar to `scrolledUnderElevation: 3` plus
          // a surfaceTint overlay, so with neither value set every app bar in
          // the app lifted and tinted the moment content scrolled under it —
          // reported as "the entire app elevation increased". The dark theme
          // sets `elevation: 0` and never showed it, which is why it read as a
          // change rather than a theme that had always been asymmetric.
          //
          // BOTH are needed: `elevation` alone governs the resting state, and
          // M3 applies scrolledUnderElevation independently of it.
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          titleLarge: GoogleFonts.robotoTextTheme().titleLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _darkBg,
        canvasColor: _darkBg,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brand,
          brightness: Brightness.dark,
          surface: _darkSurface,
        ),
        cardColor: _darkSurface,
        dividerColor: const Color(0xFF2D2D2D),
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkBg,
          foregroundColor: Colors.white,
          elevation: 0,
          // `elevation: 0` alone does NOT stop the M3 scroll-under lift — it
          // is a separate value, and the dark theme was relying on its own
          // near-black surface to hide the tint rather than turning it off.
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme:
            GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).copyWith(
          titleLarge: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme)
              .titleLarge
              ?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
        ),
      );
}
