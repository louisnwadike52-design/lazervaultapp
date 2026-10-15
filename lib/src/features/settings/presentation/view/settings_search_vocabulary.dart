/// The vocabulary the settings search bar answers to.
///
/// A LIBRARY OF ITS OWN, not a private class inside the screen, for one
/// reason: the matching rule and the lists it matches against are the thing
/// that was broken, and a `part of` private class cannot be exercised by a
/// test. Everything here is readable by both the screen and
/// `settings_search_test.dart`, so the guard checks the REAL lists rather
/// than a copy of them.

/// The search terms of the individual TILES, hoisted out so a section and the
/// tiles inside it cannot disagree about what they answer to.
///
/// THE DRIFT THIS REMOVES WAS A REAL BUG. Settings search works in two
/// stages: [_SectionSpec.matches] decides whether a SECTION renders at all,
/// and only then does [_filterableColumn] filter the tiles inside it. A tile
/// could therefore be perfectly searchable and still unreachable, because its
/// section's hand-written keyword list had never been told about it.
///
/// That is exactly what happened to the whole Customize section: Dashboard
/// Layout, Adaptive quick services, Deposit balance tips, Lazerfunds guides,
/// Voice tips and Payment reminders all declared good keywords, and searching
/// "dashboard" found nothing — the section was filtered out one stage earlier
/// and the tile filter never ran.
///
/// Each list below is referenced TWICE: by the tile that renders it, and
/// spread into its section's keywords. Adding a term in one place adds it in
/// both, so a new tile becomes findable in the same edit that creates it.
class SettingsSearchVocabulary {
  SettingsSearchVocabulary._();

  // ── Customize ──────────────────────────────────────────────────────────
  static const sendFunds = [
    'transfer style', 'classic', 'standard', 'send', 'transfer',
    'send funds', 'sendfunds', 'send money', 'short flow', 'long flow',
    'quick send', 'payment flow',
  ];
  static const loginMethod = [
    'passcode', 'password', 'email', 'phone', 'sign in', 'login',
    'login method', 'how i sign in',
  ];
  static const dashboardLayout = [
    'dashboard', 'dashboard layout', 'layout', 'home', 'home screen',
    'adverts', 'ads', 'showcase', 'classic', 'theme', 'appearance',
    'arrange', 'services grid', 'tiles',
  ];
  static const adaptiveServices = [
    'adaptive', 'adaptive quick services', 'quick services', 'reorder',
    'most used', 'personalise', 'personalize', 'frequently used',
    'service order', 'shortcuts',
  ];
  static const depositTips = [
    'deposit', 'deposit tips', 'balance', 'refresh', 'tips', 'guide',
    'keep balance live', 'linked bank', 'add money',
  ];
  static const lazerfundsGuides = [
    'lazerfunds', 'uplift', 'guide', 'guides', 'explainer', 'tips',
    'how it works', 'tutorial', 'onboarding', 'first time', 'walkthrough',
  ];
  static const voiceTips = [
    'voice', 'voice tips', 'tips', 'guide', 'guides', 'nova', 'assistant',
    'hold to talk', 'tap to talk', 'push to talk', 'coach', 'how it works',
    'first time',
  ];
  static const pendingPrompt = [
    'pending', 'payments', 'reminder', 'reminders', 'payment reminders',
    'launch', 'startup', 'prompt', 'popup', 'waiting', 'invoice',
    'split bill', 'tag pay', 'requests', 'dont show again',
    "don't show again", 'on launch',
  ];

  /// Everything the Customize section can answer to. Composed, not retyped.
  static const customize = [
    ...sendFunds,
    ...loginMethod,
    ...dashboardLayout,
    ...adaptiveServices,
    ...depositTips,
    ...lazerfundsGuides,
    ...voiceTips,
    ...pendingPrompt,
    // Words for the section itself rather than any one tile.
    'customize', 'customise', 'customization', 'customisation',
    'preferences', 'personalisation', 'personalization',
    'entrance animation', 'service tiles', 'home tiles',
  ];
}


/// True when every whitespace-separated token of [query] appears somewhere in
/// [haystackParts].
///
/// Token-based rather than substring-of-the-whole-query, so multi-word
/// ("voice login") and partial ("bio", "kyc tier") queries work regardless of
/// word order. Extracted from `_SectionSpec.matches` so the rule has exactly
/// one definition and can be tested directly.
///
/// An empty query matches everything — the un-filtered state of the screen.
bool settingsQueryMatches(String query, List<String> haystackParts) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return true;
  final haystack = haystackParts.map((p) => p.toLowerCase()).join(' ');
  final tokens = q.split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
  return tokens.every((t) => haystack.contains(t));
}
