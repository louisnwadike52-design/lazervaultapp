import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Decides whether the launch-time "you have payments waiting" sheet may show.
///
/// Two independent brakes, because a payment reminder that nags is a reminder
/// people learn to dismiss without reading:
///
///  * ONCE PER APP RUN — an in-memory latch, so returning to the dashboard from
///    a sub-screen (which re-runs the post-frame callback) never re-opens it.
///  * SNOOZE AFTER DISMISS — "Later" quiets it for [_snoozeDuration], keyed to
///    the exact set of items shown. Owe something NEW and the sheet returns
///    immediately; the snooze only ever silences what the user has already
///    consciously deferred.
///
/// Storage is per-user. The device is shared (family accounts, a handed-over
/// phone), and one person's "later" must not silence another person's debts —
/// which is exactly the bug the un-scoped `voice_setup_skips` key still has.
class PendingPaymentsPromptGate {
  PendingPaymentsPromptGate();

  static const Duration _snoozeDuration = Duration(hours: 12);

  final FlutterSecureStorage _storage = serviceLocator<FlutterSecureStorage>();
  final SecureStorageService _secure = serviceLocator<SecureStorageService>();

  /// Per-app-run latch. Static so it survives the dashboard's State being
  /// rebuilt, and reset by [resetForNewSession] on login.
  static bool _shownThisRun = false;

  /// Call on sign-in / user switch so the next user gets their own prompt.
  static void resetForNewSession() => _shownThisRun = false;

  /// True when the sheet may open for exactly this set of pending item ids.
  Future<bool> shouldShow(Set<String> actionIds) async {
    if (_shownThisRun) return false;
    if (actionIds.isEmpty) return false;

    final key = await _snoozeKey();
    if (key == null) return false;

    try {
      final raw = await _storage.read(key: key);
      if (raw == null) return true;

      final parts = raw.split('|');
      if (parts.length != 2) return true; // unreadable → don't stay silent

      final until = DateTime.tryParse(parts[0]);
      if (until == null || DateTime.now().isAfter(until)) return true;

      // Still inside the snooze window: honour it only while the user owes
      // nothing they haven't already deferred.
      final snoozed = parts[1].split(',').where((s) => s.isNotEmpty).toSet();
      return actionIds.difference(snoozed).isNotEmpty;
    } catch (e) {
      debugPrint('PendingPaymentsPromptGate: read failed: $e');
      return true;
    }
  }

  /// Records that the sheet was opened. Idempotent.
  void markShown() => _shownThisRun = true;

  /// "Later" — quiet these specific items for the snooze window.
  Future<void> snooze(Set<String> actionIds) async {
    final key = await _snoozeKey();
    if (key == null) return;
    try {
      final until = DateTime.now().add(_snoozeDuration).toIso8601String();
      await _storage.write(
        key: key,
        value: '$until|${actionIds.join(',')}',
      );
    } catch (e) {
      debugPrint('PendingPaymentsPromptGate: write failed: $e');
    }
  }

  /// Clears the snooze — used after a payment completes, so the next launch
  /// re-evaluates against what is actually still owed.
  Future<void> clearSnooze() async {
    final key = await _snoozeKey();
    if (key == null) return;
    try {
      await _storage.delete(key: key);
    } catch (_) {
      // Best-effort: a stale snooze expires on its own within 12 hours.
    }
  }

  Future<String?> _snoozeKey() async {
    try {
      final userId = await _secure.getCurrentUserId();
      if (userId == null || userId.isEmpty) return null;
      return 'pending_payments_snooze_$userId';
    } catch (_) {
      return null;
    }
  }
}
