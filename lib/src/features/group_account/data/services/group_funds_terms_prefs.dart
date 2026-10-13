import 'package:shared_preferences/shared_preferences.dart';

/// Whether the Group Funds terms still open themselves on the landing page.
///
/// The terms explain who holds the money, what happens when someone stops
/// paying, and that we are a payment channel rather than a guarantor. Someone
/// deciding whether to put money into a pot with eleven other people should
/// meet that ONCE without having to go looking for it — and exactly once,
/// because a sheet that reappears on every visit stops being read.
///
/// Scoped per user: the dismissal is a statement by the person who read it,
/// not by the handset. Two people sharing a device each get their own first
/// read, and signing out does not silently accept the terms on someone's
/// behalf.
class GroupFundsTermsPrefs {
  const GroupFundsTermsPrefs._();

  static const _prefix = 'group_funds_terms_dismissed_';

  static String _key(String userId) =>
      '$_prefix${userId.isEmpty ? 'anon' : userId}';

  /// True when the terms should open on the landing page.
  ///
  /// Fails OPEN — a storage error shows the terms rather than hiding them.
  /// Showing a sheet twice is a small annoyance; never showing the terms at
  /// all because a read failed is the outcome worth avoiding.
  static Future<bool> shouldShow(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return !(prefs.getBool(_key(userId)) ?? false);
    } catch (_) {
      return true;
    }
  }

  /// "Don't show this again."
  static Future<void> dismiss(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key(userId), true);
    } catch (_) {
      // A failed write means it opens again next time, which is the safe
      // direction — the user sees the terms rather than losing them.
    }
  }

  /// Bring them back, from Settings.
  static Future<void> reset(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key(userId));
    } catch (_) {}
  }
}
