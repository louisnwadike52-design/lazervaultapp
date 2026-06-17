import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Central, env-gated haptic feedback.
///
/// One place decides whether the app vibrates at all — flip `HAPTICS_ENABLED`
/// in the active `.env` (dev/staging/prod) to turn ALL haptics off without
/// touching call sites. Defaults to ON when the key is missing.
///
/// Usage:
///   Haptics.keyTap();   // light tick per passcode/keypad press
///   Haptics.error();    // failed validation / wrong passcode (paired w/ shake)
///   Haptics.success();  // confirmation
///
/// All methods are no-ops when disabled and never throw (haptics is best-effort
/// and unavailable on some devices/simulators).
class Haptics {
  Haptics._();

  static bool? _enabledCache;

  /// Reads `HAPTICS_ENABLED` from the bundled .env once (cached). Treats a
  /// missing/blank value as enabled so haptics work by default; only an
  /// explicit `false`/`0`/`off`/`no` disables them.
  static bool get enabled {
    return _enabledCache ??= _resolveEnabled();
  }

  static bool _resolveEnabled() {
    final raw = (dotenv.isInitialized ? dotenv.env['HAPTICS_ENABLED'] : null)
        ?.trim()
        .toLowerCase();
    if (raw == null || raw.isEmpty) return true;
    return !(raw == 'false' || raw == '0' || raw == 'off' || raw == 'no');
  }

  /// Runtime override (e.g. a future in-app Settings toggle). Pass null to
  /// fall back to the env value.
  static void setEnabled(bool? value) => _enabledCache = value;

  /// Light tick for each keypad/passcode digit + backspace press.
  static void keyTap() {
    if (!enabled) return;
    try {
      HapticFeedback.selectionClick();
    } catch (_) {/* best-effort */}
  }

  /// Strong feedback for an error: wrong passcode, failed form validation.
  /// Pair with a visual shake for the Revolut-style "nope".
  static void error() {
    if (!enabled) return;
    try {
      HapticFeedback.heavyImpact();
    } catch (_) {/* best-effort */}
  }

  /// Medium feedback for a successful/confirming action.
  static void success() {
    if (!enabled) return;
    try {
      HapticFeedback.mediumImpact();
    } catch (_) {/* best-effort */}
  }

  /// Light feedback for a soft warning (e.g. nearing a limit).
  static void warning() {
    if (!enabled) return;
    try {
      HapticFeedback.lightImpact();
    } catch (_) {/* best-effort */}
  }
}
