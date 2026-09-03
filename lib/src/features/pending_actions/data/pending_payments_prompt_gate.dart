import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/config/feature_flags.dart';
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

  /// How many showings the user must see before they are offered the
  /// permanent opt-out.
  ///
  /// Offering it on the first launch would let someone switch off a money
  /// reminder before they have any idea what it does — and the people most
  /// likely to do that are the ones who most need it. Three showings is enough
  /// to have read it, understood it, and decided it is not for them.
  static const int optOutAfterShows = 3;

  /// True when the sheet may open for exactly this set of pending item ids.
  Future<bool> shouldShow(Set<String> actionIds) async {
    if (_shownThisRun) return false;
    if (actionIds.isEmpty) return false;
    // The user turned it off for good. Re-enabled from Settings, never
    // silently — see [setEnabled].
    if (await isDisabled()) return false;

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

  /// Records that the sheet was opened.
  ///
  /// The in-memory latch is idempotent, but the persisted counter is what gates
  /// the opt-out, so it increments once per actual showing.
  Future<void> markShown() async {
    _shownThisRun = true;
    final uid = await _uid();
    if (uid == null) return;
    await FeatureFlags.incrementPendingPaymentsShowCount(uid);
  }

  /// How many times this user has been shown the sheet.
  Future<int> showCount() async {
    final uid = await _uid();
    if (uid == null) return 0;
    return FeatureFlags.pendingPaymentsShowCount(uid);
  }

  /// Whether to offer "Don't show this again" on this showing.
  ///
  /// Counts the CURRENT showing, so the control appears on the third rather
  /// than the fourth.
  Future<bool> canOfferOptOut() async =>
      (await showCount()) >= optOutAfterShows;

  /// True when the user switched the launch prompt off.
  Future<bool> isDisabled() async {
    final uid = await _uid();
    if (uid == null) return false;
    return !FeatureFlags.pendingPaymentsPromptEnabled(uid);
  }

  /// Turns the launch prompt on or off. Settings writes `true` here to undo a
  /// "Don't show this again"; both surfaces read and write the SAME flag, so
  /// the switch can never disagree with the sheet.
  Future<void> setEnabled(bool enabled) async {
    final uid = await _uid();
    if (uid == null) return;
    await FeatureFlags.setPendingPaymentsPromptEnabled(uid, enabled);
  }

  Future<String?> _uid() async {
    try {
      final id = await _secure.getCurrentUserId();
      return (id == null || id.isEmpty) ? null : id;
    } catch (_) {
      return null;
    }
  }

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

  Future<String?> _snoozeKey() => _userKey('pending_payments_snooze');

  /// Per-user key. The device is shared (family accounts, a handed-over
  /// phone), so one person's preference must never silence another's debts.
  Future<String?> _userKey(String prefix) async {
    try {
      final userId = await _secure.getCurrentUserId();
      if (userId == null || userId.isEmpty) return null;
      return '${prefix}_$userId';
    } catch (_) {
      return null;
    }
  }
}
