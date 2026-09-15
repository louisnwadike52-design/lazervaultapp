import 'package:flutter/material.dart';

/// Canonical palette for the five peer-payment flows (QR, contactless,
/// TagPay, PayID, Group) — the EscrowTheme pattern applied to the dashboard
/// surface set, so every pay flow reads as one product (audit decision
/// 2026-09-07). New pay-flow code should pull colors from here instead of
/// inlining hex literals; existing screens were mechanically swapped onto
/// these values.
class PayFlowTheme {
  PayFlowTheme._();

  /// Page background — the dashboard's near-black.
  static const Color bg = Color(0xFF0A0A0A);

  /// Card / sheet fill.
  static const Color card = Color(0xFF1F1F1F);

  /// Hairline borders and dividers.
  static const Color border = Color(0xFF2D2D2D);

  /// Secondary text.
  static const Color textSecondary = Color(0xFF9CA3AF);

  /// Brand accent — LazerVault purple.
  ///
  /// NOTE: [accent] is a BRAND colour, not a legible one on these dark
  /// surfaces. Measured against [card] it lands at ~1.8:1 — far below the
  /// 3:1 floor for a UI component and nowhere near 4.5:1 for text. Use it
  /// for large brand moments only; for anything the user has to *read* or
  /// *press*, reach for [accentOnDark] / [accentCta] below.
  static const Color accent = Color(0xFF4E03D0);

  /// Purple used as a FOREGROUND on dark: text, icons, selection rings,
  /// chip labels, low-alpha tint fills. ~6:1 on [card] and ~7:1 on [bg].
  ///
  /// Same value EscrowTheme.primaryLight already ships for the identical
  /// reason ("the full primary reads almost black at chip size"), so the
  /// pay flows and escrow stay one product.
  static const Color accentOnDark = Color(0xFFA78BFA);

  /// Filled-CTA purple. A solid [accent] button visually dissolves into
  /// the sheet it sits on; this lifts the button BODY to ~3.5:1 against
  /// [bg] while keeping a white label on it at ~5.7:1.
  static const Color accentCta = Color(0xFF7C3AED);

  /// Semantic colors.
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFFB923C);
}
