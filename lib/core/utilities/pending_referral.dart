import 'package:shared_preferences/shared_preferences.dart';

/// A referral code this device has seen but not yet used.
///
/// WHY IT HAS TO BE REMEMBERED AT ALL
///
/// An invite link (`/download?ref=CODE`) is a verified app link, so on a
/// device that ALREADY has the app the OS hands it straight to us — before any
/// signup screen exists, and usually to somebody who is not the new user at
/// all. The code is therefore useless at the moment it arrives and valuable
/// only later, if this device ever reaches a signup form.
///
/// So it is written down and read back once. The whole mechanism is one value.
///
/// WHAT THIS IS NOT
///
/// It is NOT deferred deep linking. If the app was not installed, the invite
/// goes to the store, the install starts a fresh app, and nothing on this
/// device ever saw the link — no amount of local storage recovers that.
/// Firebase Dynamic Links, which used to solve it, shut down in August 2025,
/// and the alternatives are third-party SDKs. The website handles that case by
/// showing the code with a copy button for the user to carry by hand.
class PendingReferral {
  PendingReferral._();
  static final PendingReferral instance = PendingReferral._();

  static const String _key = 'pending_referral_code';

  /// In-memory mirror so a code captured during this launch is readable even
  /// before SharedPreferences resolves — a deep link can arrive within
  /// milliseconds of start-up, ahead of any await.
  String? _cached;

  /// Record a code seen on an incoming link. Last one wins: if two invites
  /// arrive, the most recent is the one the user just acted on.
  Future<void> remember(String code) async {
    final c = code.trim().toUpperCase();
    if (c.isEmpty) return;
    _cached = c;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, c);
    } catch (_) {
      // Storage unavailable. The in-memory copy still serves this launch,
      // which covers the common case of tapping an invite and signing up
      // immediately. Nothing here is worth surfacing to a user.
    }
  }

  /// The code to prefill a signup with, if any.
  Future<String?> peek() async {
    if (_cached != null) return _cached;
    try {
      final prefs = await SharedPreferences.getInstance();
      final v = prefs.getString(_key)?.trim();
      if (v == null || v.isEmpty) return null;
      _cached = v;
      return v;
    } catch (_) {
      return null;
    }
  }

  /// Forget the code once a signup has actually consumed it.
  ///
  /// Called on SUCCESSFUL signup only. Clearing it when the form merely opens
  /// would lose the attribution for anyone who backs out and returns, which is
  /// an ordinary thing to do and costs the referrer their commission.
  Future<void> clear() async {
    _cached = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (_) {
      // Leaving a stale code behind is harmless: it is only ever read by a
      // signup, and this device has just completed one.
    }
  }
}
