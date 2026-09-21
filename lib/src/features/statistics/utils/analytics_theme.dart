import 'package:flutter/material.dart';

/// Colours for the Financial Analytics surface.
///
/// WHY THIS EXISTS
/// ---------------
/// The accent was spread across the feature as bare hex literals, and the
/// purples in use were too dark to read against the near-black ground the
/// screen sits on. A dark violet on `#0A0A0A` fails normal-text contrast, so
/// labels, tab titles and CTA text were legible only at a glance.
///
/// These tokens are deliberately on the LIGHT end of the violet ramp: on the
/// dark surfaces this screen uses, a light accent carries the contrast and a
/// dark one cannot.
///
/// ON THE HUE
/// ----------
/// The accent is a LIGHTENED BRAND PURPLE, not a generic lavender. The previous
/// value (`#A78BFA`, Tailwind violet-400) sat at hue 258° and read washed out
/// and slightly blue next to the rest of the product; the brand purple used on
/// the Financial Overview card is `#4E03D0` at hue 262°. [accent] is that same
/// 262° hue lightened until it is readable on a near-black ground, so the
/// analytics surface reads as the product's purple rather than a pastel
/// stand-in.
///
/// Copying `#4E03D0` onto TEXT is the trap here and was measured, not guessed:
/// it scores 2.12:1 on `#0A0A0A` and 1.86:1 on `#1A1A1A` — effectively
/// invisible. It works on the overview card because it is an ICON on a
/// 10%-alpha purple chip, not type on the raw page.
///
/// Measured contrast for the values below:
///   accent        #A175F5 -> 6.01:1 on #0A0A0A, 5.29:1 on #1A1A1A  (AA, both)
///   accentStrong  #C4B5FD -> comfortably above AA for 11sp captions
///
/// Every analytics widget takes its accent from here so a future change is one
/// edit, not a sweep through forty files.
class AnalyticsTheme {
  const AnalyticsTheme._();

  /// Primary accent: icons, selected pills, CTAs, links.
  static const Color accent = Color(0xFFA175F5);

  /// Lighter accent for small text, captions and anything that must stay
  /// readable at 11sp.
  static const Color accentStrong = Color(0xFFC4B5FD);

  /// Very low-opacity accent for selected-chip fills and card tints.
  static Color accentTint(double opacity) => accent.withValues(alpha: opacity);

  /// Page ground.
  static const Color surface = Color(0xFF0A0A0A);

  /// Cards, chips and sheets sitting on [surface].
  static const Color surfaceRaised = Color(0xFF1F1F1F);

  /// Sheet ground, one step below [surfaceRaised].
  static const Color surfaceSheet = Color(0xFF141414);

  /// Hairlines and unselected chip borders.
  static const Color border = Color(0xFF2D2D2D);

  /// Primary text on dark surfaces.
  static const Color textPrimary = Colors.white;

  /// Secondary text. Kept at `#9CA3AF` rather than anything darker because it
  /// is used for amounts and counts, not decoration.
  static const Color textSecondary = Color(0xFF9CA3AF);

  /// Positive money movement (income, credits).
  static const Color positive = Color(0xFF34D399);

  /// Negative money movement (spending, debits).
  static const Color negative = Color(0xFFF87171);

  /// Caution, used for partial or stale data rather than for errors.
  static const Color warning = Color(0xFFFBBF24);
}
