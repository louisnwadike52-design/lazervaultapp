import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Which identities have already completed a sign-in ON THIS INSTALL.
///
/// WHY THIS EXISTS
/// ---------------
/// The step-up screen said "New sign-in detected on this device." every single
/// time it appeared, including for someone unlocking the phone they have used
/// every day for months. That is wrong twice over: it is false, and it is
/// alarming in the one place the product most needs to be believed — a
/// security prompt that cries wolf teaches people to ignore it, which is
/// exactly the habit an attacker needs.
///
/// The backend decides WHETHER to challenge, from risk signals the app cannot
/// see (new device, new location, a dormant account). It does not currently
/// tell the app WHY, and the login response is a proto contract, so widening
/// it needs sign-off. But the app does not need the server for this particular
/// question: whether a given identity has signed in on THIS install before is
/// something the install itself knows for certain.
///
/// So the division is: the server decides whether to ask, and this decides
/// what the screen may claim about it. When this says the identity is known
/// here, the screen must not call it a new device — it says only that extra
/// verification is needed, which is true whatever the real risk reason was.
///
/// WHAT IS STORED
/// Only a truncated SHA-256 of a normalised identifier, never the identifier.
/// The app already stores the phone and email in the clear elsewhere for its
/// own routing; this file does not need a second copy, and a hash is enough to
/// answer a yes/no question. Uninstalling clears it, which is correct: a fresh
/// install genuinely is an unrecognised client, and the backend will treat it
/// as one too.
class DeviceLoginHistory {
  const DeviceLoginHistory._();

  static const String _key = 'device_login_identities_v1';
  static const FlutterSecureStorage _defaultStorage = FlutterSecureStorage();

  /// Cap the stored set. A shared handset accumulates identities, and this is
  /// a convenience signal, not an audit log — the oldest entry falling off
  /// only means that person is greeted as new once more.
  static const int _maxEntries = 12;

  /// Normalise before hashing so "+234 803…", "0803…" and " Me@X.com " do not
  /// each create their own entry and defeat the whole check.
  ///
  /// Digits-only for anything phone-shaped, lowercased and trimmed otherwise.
  /// A Nigerian number is additionally reduced to its last 10 digits, because
  /// the same account legitimately arrives as 08031234567 locally and
  /// 2348031234567 after the backend canonicalises it.
  static String _fingerprint(String identifier) {
    var v = identifier.trim().toLowerCase();
    if (v.isEmpty) return '';
    final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
    final looksLikePhone = !v.contains('@') && digits.length >= 7;
    if (looksLikePhone) {
      v = digits.length > 10 ? digits.substring(digits.length - 10) : digits;
    }
    return sha256.convert(utf8.encode(v)).toString().substring(0, 16);
  }

  static Future<List<String>> _read(FlutterSecureStorage s) async {
    try {
      final raw = await s.read(key: _key);
      if (raw == null || raw.isEmpty) return <String>[];
      return raw.split(',').where((e) => e.isNotEmpty).toList();
    } catch (_) {
      // Keystore unavailable (locked device, wiped keys). Treating it as "no
      // history" is the safe direction: the screen falls back to the cautious
      // "new sign-in" wording rather than silently reassuring someone.
      return <String>[];
    }
  }

  /// Record that [identifier] has now completed a sign-in on this install.
  /// Best-effort: a storage failure must never break a successful login.
  static Future<void> remember(String? identifier,
      {FlutterSecureStorage? storage}) async {
    if (identifier == null) return;
    final fp = _fingerprint(identifier);
    if (fp.isEmpty) return;
    final s = storage ?? _defaultStorage;
    try {
      final entries = await _read(s);
      if (entries.contains(fp)) return; // already known, no write needed
      entries.add(fp);
      // Drop from the FRONT so the most recent identities survive the cap.
      final trimmed = entries.length > _maxEntries
          ? entries.sublist(entries.length - _maxEntries)
          : entries;
      await s.write(key: _key, value: trimmed.join(','));
    } catch (_) {
      /* best-effort */
    }
  }

  /// Whether [identifier] has signed in on this install before.
  ///
  /// False on any doubt — unknown identifier, empty history, storage error.
  /// The caller uses this to SOFTEN a security warning, so the failure
  /// direction must be to keep warning.
  static Future<bool> hasSignedInBefore(String? identifier,
      {FlutterSecureStorage? storage}) async {
    if (identifier == null) return false;
    final fp = _fingerprint(identifier);
    if (fp.isEmpty) return false;
    return (await _read(storage ?? _defaultStorage)).contains(fp);
  }

  /// A one-shot, in-memory view of the history.
  ///
  /// Callers that must test more than one identifier — the lock screen checks
  /// both the cached phone and the cached email — would otherwise pay a
  /// Keystore round trip per identifier, on the critical path between a
  /// correct passcode and the home screen. This reads once; the tests are then
  /// free. It is also what lets the read be started concurrently with the
  /// other identity reads instead of waiting behind them.
  static Future<DeviceLoginSnapshot> snapshot(
      {FlutterSecureStorage? storage}) async {
    return DeviceLoginSnapshot._(await _read(storage ?? _defaultStorage));
  }

  /// Forget every identity.
  ///
  /// NOT called on a user switch, and it must not be. The history is keyed per
  /// IDENTITY, which already gives a shared handset the right answer: user B
  /// signing in for the first time is correctly told it is a new sign-in,
  /// while user A, who has used this phone for months, is not. Clearing on a
  /// switch would wipe A's entry too and greet them as new on their own
  /// device — the exact false alarm this class exists to stop.
  ///
  /// Reserved for a deliberate "forget this device" / app-data reset. Nothing
  /// calls it today; it exists so that reset has one correct way to do it
  /// rather than reaching into the storage key.
  static Future<void> clear({FlutterSecureStorage? storage}) async {
    try {
      await (storage ?? _defaultStorage).delete(key: _key);
    } catch (_) {
      /* best-effort */
    }
  }
}

/// An immutable answer to "has this identity signed in on this install
/// before", taken once and queried many times. See [DeviceLoginHistory.snapshot].
class DeviceLoginSnapshot {
  const DeviceLoginSnapshot._(this._entries);

  final List<String> _entries;

  /// False for a null/blank identifier and for an empty history — the caller
  /// uses this to SOFTEN a security warning, so doubt must keep the warning.
  bool contains(String? identifier) {
    if (identifier == null) return false;
    final fp = DeviceLoginHistory._fingerprint(identifier);
    if (fp.isEmpty) return false;
    return _entries.contains(fp);
  }

  /// True when ANY of [identifiers] is known here. The lock screen greets one
  /// person who may be cached under a phone, an email, or both.
  bool containsAny(Iterable<String?> identifiers) => identifiers.any(contains);
}
