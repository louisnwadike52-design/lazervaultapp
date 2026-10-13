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

  /// Who has already been shown the terms in THIS app session.
  ///
  /// The persistent flag below answers "has this person dismissed the terms
  /// for good". It does not answer "have they already seen them a minute
  /// ago", and the landing screen's initState runs on every push — so
  /// opening a group and pressing back re-created the screen and re-opened
  /// the sheet, on a user who had just read it and had NOT ticked the box.
  /// A sheet that reappears every visit stops being read, which is the exact
  /// thing the dismissal was added to prevent.
  ///
  /// In memory on purpose: "this session" means until the app is killed or
  /// the user signs out, not until a date. Cleared by [endSession] on
  /// sign-out so the next person on a shared device gets their own first
  /// read.
  static final Set<String> _shownThisSession = <String>{};

  /// Forget the per-session record. Called on sign-out.
  static void endSession() => _shownThisSession.clear();

  /// Mark the terms as shown for this session, without dismissing them for
  /// good. Separate from [dismiss] because they answer different questions:
  /// this one is "not again right now", that one is "not ever".
  static void markShownThisSession(String userId) =>
      _shownThisSession.add(userId.isEmpty ? 'anon' : userId);

  static String _key(String userId) =>
      '$_prefix${userId.isEmpty ? 'anon' : userId}';

  /// True when the terms should open on the landing page.
  ///
  /// Fails OPEN — a storage error shows the terms rather than hiding them.
  /// Showing a sheet twice is a small annoyance; never showing the terms at
  /// all because a read failed is the outcome worth avoiding.
  static Future<bool> shouldShow(String userId) async {
    // Already seen since this session began — do not reopen on a back
    // navigation. Checked BEFORE storage so it costs nothing on the common
    // path, and so it holds even when the persistent read fails open.
    if (_shownThisSession.contains(userId.isEmpty ? 'anon' : userId)) {
      return false;
    }
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
    // The session flag goes too. Without this, turning the terms back on from
    // Settings appeared to do nothing until the app was restarted — the
    // persistent flag was cleared but the in-memory one still said "already
    // shown", so the next visit stayed silent.
    _shownThisSession.remove(userId.isEmpty ? 'anon' : userId);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key(userId));
    } catch (_) {}
  }
}
