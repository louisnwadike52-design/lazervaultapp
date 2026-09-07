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
  static const Color accent = Color(0xFF4E03D0);

  /// Semantic colors.
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFFB923C);
}
