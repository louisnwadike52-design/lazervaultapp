import 'package:flutter/material.dart';

/// Light theme tokens shared by the settings hub (`settings_screen.dart`) and
/// the settings-page voice/chat assistant screens, so those screens match the
/// surrounding settings sections instead of the in-call (dark) voice UI.
///
/// Values mirror the private accordion constants in `settings_screen.dart`
/// (`_kBrand`, `_kBg`, `_kCard`, `_kTextPrimary`, …). Kept in one public place
/// so a future theme migration can flip them everywhere at once.
///
/// NOTE: the in-call voice bottom sheets (voice_session/widgets/*) intentionally
/// stay dark — do NOT use these tokens there.
class SettingsTheme {
  const SettingsTheme._();

  // Surfaces & brand (light).
  static const Color brand = Color(0xFF4834D4);
  static const Color accent = Color(0xFF4E03D0);
  static const Color bg = Color(0xFFF9FAFB);
  static const Color card = Colors.white;

  /// Subtle filled surface for inputs / dropdowns / inert chips.
  static const Color surfaceAlt = Color(0xFFF3F4F6);

  // Text.
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Lines.
  static const Color divider = Color(0xFFE5E7EB);

  // Semantic status colours — identical across light/dark so status reads the
  // same everywhere.
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFB923C);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}
