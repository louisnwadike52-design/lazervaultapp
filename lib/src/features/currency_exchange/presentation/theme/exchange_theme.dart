import 'package:flutter/material.dart';

/// Central palette for the currency-exchange feature. Matches the purple
/// accent used by the invoice flow so the two "premium money move" flows
/// feel visually consistent.
class ExchangeTheme {
  ExchangeTheme._();

  // Primary accent — invoice flow's deep purple. Single source of truth
  // so swapping the brand purple here cascades through every CTA, icon
  // tint and badge in the exchange surface.
  static const Color primary = Color(0xFF4E03D0);     // main CTAs (matches InvoiceThemeColors.primaryPurple)
  static const Color primaryDark = Color(0xFF4E03D0); // deep accent (icons, dots)
  static const Color primarySoft = Color(0xFF6D28D9); // hover / pressed
  static const Color primaryTint = Color(0x334E03D0); // 20% overlays

  // Dark backgrounds (unchanged across the app).
  static const Color background = Color(0xFF0A0A0A);
  static const Color cardBackground = Color(0xFF1F1F1F);
  static const Color surfaceElevated = Color(0xFF2D2D2D);
  static const Color divider = Color(0xFF2D2D2D);

  // Text.
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // Status.
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFB923C);
  static const Color error = Color(0xFFEF4444);
  static const Color info = primary;

  // Status badge helpers (mirrors admin dashboard status colour map).
  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
      case 'settled':
      case 'refunded': // credit back succeeded — green from user POV
        return success;
      case 'pending':
      case 'processing':
      case 'verifying':
      case 'refunding':
      case 'active':
        return primary;
      case 'failed':
      case 'error':
        return error;
      case 'cancelled':
      case 'manual_review':
        return warning;
      default:
        return textSecondary;
    }
  }

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
