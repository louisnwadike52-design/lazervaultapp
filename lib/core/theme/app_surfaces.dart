import 'package:flutter/material.dart';

/// Shared dark-violet surface theme used across the money-movement screens
/// (Deposit, Withdraw, Exchange, Lazerbeam / Move Money) so they read as one
/// cohesive product instead of a patchwork of flat greys.
///
/// - [pageBackground]: the full-screen vertical gradient (purple-tinted top
///   fading to near-black). Apply to a [Container]/[DecoratedBox] wrapping the
///   scaffold body; set the Scaffold + AppBar backgroundColor to [pageTop] so
///   the status-bar / app-bar region blends with the gradient's top.
/// - [card]: a state-coloured card surface (subtle diagonal gradient + accent
///   edge + soft shadow). Pass the feature/state accent for the border tint.
class AppSurfaces {
  AppSurfaces._();

  // Page gradient stops.
  static const Color pageTop = Color(0xFF1A1430);
  static const Color pageMid = Color(0xFF120F1C);
  static const Color pageBottom = Color(0xFF0A090F);

  // Card surface gradient stops.
  static const Color cardTop = Color(0xFF241C3D);
  static const Color cardBottom = Color(0xFF15121F);

  // Default soft-purple accent (one-time / neutral).
  static const Color accentPurple = Color(0xFF7C5CFF);

  /// Full-screen page background gradient.
  static const BoxDecoration pageBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [pageTop, pageMid, pageBottom],
      stops: [0.0, 0.42, 1.0],
    ),
  );

  /// A state-coloured card surface. [accent] tints the border (e.g. green for
  /// active, amber for setting-up, purple for neutral).
  static BoxDecoration card({
    Color accent = accentPurple,
    double radius = 16,
    double accentAlpha = 0.30,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cardTop.withValues(alpha: 0.80),
          cardBottom.withValues(alpha: 0.92),
        ],
      ),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: accent.withValues(alpha: accentAlpha)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.22),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

/// Wraps [child] in the shared [AppSurfaces.pageBackground] gradient. Drop it
/// in as a scaffold body wrapper.
class AppGradientBackground extends StatelessWidget {
  final Widget child;
  const AppGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppSurfaces.pageBackground,
      child: child,
    );
  }
}
