import 'package:flutter/material.dart';

/// The dashboard's light card styling, in one place.
///
/// WHY THIS EXISTS
/// ---------------
/// The dashboard is a LIGHT surface, but the Public Groups and Trending
/// Crowdfunds widgets were written against a dark one: `0xFF1F1F1F` cards,
/// `Colors.white` titles, `0xFF9CA3AF` body text. Dropped onto the light
/// dashboard they read as two black slabs wedged between the white Exchange
/// Rates card and the Portfolio panel — not a theme, a mistake.
///
/// The fix is not "make them grey". Exchange Rates already establishes what a
/// dashboard card looks like here (white → brand-purple wash, soft purple
/// shadow, a tinted chip for the leading glyph), so these constants lift that
/// treatment out of `country_rate_card.dart` and let every dashboard card share
/// it. Anything added to this row later should reach for these rather than
/// inventing a third palette.
///
/// Deliberately literal, not `Theme.of(context)`: the dashboard's cards are
/// literal-styled throughout, and introducing a token system for two widgets
/// would leave the row half-migrated and harder to reason about, not easier.
class DashboardLightStyle {
  DashboardLightStyle._();

  /// LazerVault brand purple — the same value `country_rate_card` uses.
  static const Color brand = Color.fromARGB(255, 78, 3, 208);

  /// Card ground: white lifted by a wash of brand purple, so a card reads as
  /// raised against the dashboard's own white without needing a border.
  static LinearGradient get cardGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, brand.withValues(alpha: 0.05)],
      );

  /// Soft brand-tinted lift. A neutral grey shadow reads as dirt on white.
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: brand.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  /// Tint behind a leading glyph or avatar.
  static Color get chipTint => brand.withValues(alpha: 0.1);

  /// Primary text on a light card — near-black, never pure black.
  static const Color textPrimary = Color(0xFF111827);

  /// Secondary/supporting text. Passes contrast on white, unlike the
  /// `0xFF9CA3AF` that was tuned for a dark ground. Kept deliberately dark:
  /// these cards sit on a pale purple wash, and a mid grey on that ground
  /// reads as disabled rather than secondary.
  static const Color textSecondary = Color(0xFF4B5563);

  /// Skeleton fill while loading — a light wash, not a dark block.
  static Color get shimmerBase => brand.withValues(alpha: 0.06);

  /// Inline progress/track colour for light cards.
  static Color get trackColor => brand.withValues(alpha: 0.12);
}
