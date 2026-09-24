import 'package:shared_preferences/shared_preferences.dart';

/// Whether to show the voice-session guidance, and what has already been seen.
///
/// Modelled on [UpliftGuidePreference], including the part that matters: a
/// standing DISMISSED flag is kept separate from per-surface SEEN marks, and
/// re-enabling clears every SEEN mark. Without that separation the settings
/// switch lies — you turn guidance back on, nothing appears because everything is
/// still marked seen, and the switch looks broken.
///
/// SharedPreferences, deliberately NOT FlutterSecureStorage.
/// SecureStorageService.clearAll() runs on logout, which wiped the dashboard
/// walkthrough's seen flag and re-showed the whole tour after every single
/// sign-in. Guidance state is not a secret; it is a preference, and it should
/// survive a logout the way every other preference does.
///
/// Per-device and per-user: keys are scoped by uid so a second account signing in
/// on the same phone gets its own first-run experience instead of inheriting
/// someone else's.
class VoiceGuidePreference {
  VoiceGuidePreference._();

  /// Standing "don't show me voice guidance" choice. One per user.
  static String _dismissedKey(String uid) => 'voice_guide_dismissed_$uid';

  /// Per-surface "already seen" mark.
  static String _seenKey(String uid, String surface) =>
      'voice_guide_seen_${uid}_$surface';

  /// The in-sheet tip that appears when a voice session opens.
  static const String surfaceSessionTip = 'session_tip';

  /// The first-run coach mark on the interaction-mode chip.
  static const String surfaceModeCoachMark = 'mode_coach_mark';

  static const List<String> allSurfaces = [
    surfaceSessionTip,
    surfaceModeCoachMark,
  ];

  /// True when the user has turned voice guidance off for good.
  static Future<bool> isDismissed(String uid) async {
    if (uid.isEmpty) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_dismissedKey(uid)) ?? false;
    } catch (_) {
      // Storage unavailable. Showing guidance is the safe direction: the cost is
      // one dismissible tip, where the cost of the other default is a user who
      // never learns the gesture.
      return false;
    }
  }

  /// Sets the standing choice.
  ///
  /// Turning guidance back ON clears every SEEN mark, so the tips actually
  /// reappear. This is the whole reason the two are separate flags — a switch
  /// that turns something on and shows nothing is worse than no switch.
  static Future<void> setDismissed(String uid, bool dismissed) async {
    if (uid.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_dismissedKey(uid), dismissed);
      if (!dismissed) {
        for (final surface in allSurfaces) {
          await prefs.remove(_seenKey(uid, surface));
        }
      }
    } catch (_) {
      // A preference that fails to persist is not worth failing a voice session
      // over; the user can set it again.
    }
  }

  /// True when [surface] should be shown now.
  static Future<bool> shouldShow(String uid, String surface) async {
    if (uid.isEmpty) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(_dismissedKey(uid)) ?? false) return false;
      return !(prefs.getBool(_seenKey(uid, surface)) ?? false);
    } catch (_) {
      return false;
    }
  }

  /// Records that [surface] has been shown.
  ///
  /// Call when the guidance STARTS, not when it finishes. The dashboard
  /// walkthrough learned this the hard way: marking on completion meant a card
  /// that failed to render its dismiss control trapped the user in a loop, seeing
  /// the same coach mark on every open with no way to get past it.
  static Future<void> markSeen(String uid, String surface) async {
    if (uid.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_seenKey(uid, surface), true);
    } catch (_) {
      // Worst case the tip shows once more.
    }
  }

  /// Clears the seen marks without touching the standing choice, so "Show me
  /// again" works for someone who never dismissed guidance in the first place.
  static Future<void> replayAll(String uid) async {
    if (uid.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_dismissedKey(uid), false);
      for (final surface in allSurfaces) {
        await prefs.remove(_seenKey(uid, surface));
      }
    } catch (_) {
      // Nothing to do.
    }
  }
}
