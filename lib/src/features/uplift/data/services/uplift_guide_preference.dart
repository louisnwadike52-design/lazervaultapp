import 'package:shared_preferences/shared_preferences.dart';

/// Whether the LazerFunds first-run explainer should appear.
///
/// LazerFunds is the least self-evident thing in the app: three tabs that look
/// like a feed but are actually a funding marketplace, where "Discover" is
/// other people's raises, "My Funds" is money you committed, and "My
/// Applications" is money you asked for. Someone who taps in without that
/// framing has to infer it from the rows, and a funding product is a bad place
/// to guess.
///
/// Two separate ideas, deliberately not collapsed into one flag:
///
///   * SEEN — this tab has shown its explainer once. Per tab, because the tabs
///     explain different things and arriving at "My Applications" for the first
///     time is a first run for that idea even if Discover was read weeks ago.
///   * DISMISSED — the user said "don't show this again", a standing choice
///     that outranks SEEN and is what the Settings toggle reads and writes.
///
/// Collapsing them would mean re-enabling from Settings could not distinguish
/// "show me these again" from "mark everything unseen", and the help icon would
/// have nothing to restore.
///
/// Stored locally. This is a UI preference about what one person has read on
/// one device, not account state: it changes no money, no permission and
/// nothing another service needs to know. Round-tripping it through a service
/// would add a network dependency to the first frame of a screen, and a failed
/// read would either show a veteran the tutorial again or hide it from someone
/// who never saw it.
class UpliftGuidePreference {
  UpliftGuidePreference._();

  /// The standing "don't show me these" choice. Mirrored in Settings.
  static const String _dismissedKey = 'lazerfunds_guide_dismissed';

  /// Per-tab "already shown once" marks.
  static const String _seenKeyPrefix = 'lazerfunds_guide_seen_';

  /// Tabs that carry an explainer. The ids are stable storage keys — renaming
  /// one silently re-shows that tab's guide to everybody, so they are
  /// deliberately not derived from the display labels.
  static const String tabDiscover = 'discover';
  static const String tabMyFunds = 'my_funds';
  static const String tabMyApplications = 'my_applications';

  static const List<String> allTabs = [
    tabDiscover,
    tabMyFunds,
    tabMyApplications,
  ];

  /// True when the user has turned the guides off entirely.
  static Future<bool> isDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dismissedKey) ?? false;
  }

  /// Turns the guides on or off from Settings.
  ///
  /// Turning them back ON also clears the per-tab SEEN marks: a user who
  /// re-enables the guides is asking to be shown them, and leaving the marks
  /// would switch the setting on while nothing ever appeared — which reads as
  /// a broken toggle.
  static Future<void> setDismissed(bool dismissed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dismissedKey, dismissed);
    if (!dismissed) {
      for (final tab in allTabs) {
        await prefs.remove('$_seenKeyPrefix$tab');
      }
    }
  }

  /// Whether this tab's explainer should be shown right now.
  static Future<bool> shouldShow(String tabId) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_dismissedKey) ?? false) return false;
    return !(prefs.getBool('$_seenKeyPrefix$tabId') ?? false);
  }

  /// Records that this tab's explainer has been shown.
  static Future<void> markSeen(String tabId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_seenKeyPrefix$tabId', true);
  }

  /// Clears the SEEN mark for one tab so its explainer appears again.
  ///
  /// Used by the persistent help icon: someone reaching for help wants the
  /// explanation now, regardless of having seen it before — and without
  /// touching their standing "don't show automatically" choice, which is about
  /// unprompted appearances, not about being denied help when asked.
  static Future<void> replay(String tabId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_seenKeyPrefix$tabId');
  }
}
