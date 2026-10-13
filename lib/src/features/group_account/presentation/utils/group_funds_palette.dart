import 'package:flutter/material.dart';

/// The purples Group Funds draws on its DARK surfaces.
///
/// Why this exists
/// ---------------
/// Every Group Funds screen paints on `#0A0A0A`/`#1F1F1F`. The brand purple
/// `#4E03D0` is a deep, heavily saturated violet: against white it is strong,
/// against near-black it is almost the background. Badges built from it —
/// "Esusu · Rotating", "Created by you", the auto-payout chip — rendered as
/// dark text inside a 10%-alpha dark fill and were, as reported, invisible.
///
/// Lightening a colour is not a thing to do per-call-site with a one-off hex:
/// the pills sit next to each other, and three slightly different purples read
/// as three different meanings. These are the two tones, used everywhere.
class GroupFundsPalette {
  GroupFundsPalette._();

  /// Brand purple. Correct on LIGHT surfaces and for large filled areas where
  /// the colour is the background rather than the ink (the summary card, a
  /// primary button).
  static const Color brand = Color(0xFF4E03D0);

  /// The same hue lifted for dark surfaces — violet-400. Use for ICON, TEXT
  /// and BORDER on anything dark: it clears WCAG AA against `#0A0A0A` at body
  /// size, which `brand` does not come close to.
  static const Color onDark = Color(0xFFA78BFA);

  /// A half step down, for the fill behind [onDark] ink when a badge needs
  /// more presence than a 12% wash.
  static const Color onDarkMuted = Color(0xFF8B5CF6);
}
