library;

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
    'transfer style',
    'classic',
    'standard',
    'send',
    'transfer',
    'send funds',
    'sendfunds',
    'send money',
    'short flow',
    'long flow',
    'quick send',
    'payment flow',
  ];
  static const loginMethod = [
    'passcode',
    'password',
    'email',
    'phone',
    'sign in',
    'login',
    'login method',
    'how i sign in',
  ];
  static const dashboardLayout = [
    'dashboard',
    'dashboard layout',
    'layout',
    'home',
    'home screen',
    'adverts',
    'ads',
    'showcase',
    'classic',
    'theme',
    'appearance',
    'arrange',
    'services grid',
    'tiles',
  ];
  static const adaptiveServices = [
    'adaptive',
    'adaptive quick services',
    'quick services',
    'reorder',
    'most used',
    'personalise',
    'personalize',
    'frequently used',
    'service order',
    'shortcuts',
  ];
  static const depositTips = [
    'deposit',
    'deposit tips',
    'balance',
    'refresh',
    'tips',
    'guide',
    'keep balance live',
    'linked bank',
    'add money',
  ];
  static const lazerfundsGuides = [
    'lazerfunds',
    'uplift',
    'guide',
    'guides',
    'explainer',
    'tips',
    'how it works',
    'tutorial',
    'onboarding',
    'first time',
    'walkthrough',
  ];
  static const voiceTips = [
    'voice',
    'voice tips',
    'tips',
    'guide',
    'guides',
    'nova',
    'assistant',
    'hold to talk',
    'tap to talk',
    'push to talk',
    'coach',
    'how it works',
    'first time',
  ];
  static const pendingPrompt = [
    'pending',
    'payments',
    'reminder',
    'reminders',
    'payment reminders',
    'launch',
    'startup',
    'prompt',
    'popup',
    'waiting',
    'invoice',
    'split bill',
    'tag pay',
    'requests',
    'dont show again',
    "don't show again",
    'on launch',
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

  // ── Security ───────────────────────────────────────────────────────────
  // The same two-stage drift that hid the Customize tiles was still live
  // here: each list below declared good terms that the SECTION had never
  // been told about, so the section was filtered out before the tile filter
  // ran and the setting could not be found at all.
  static const fraudDetection = [
    'fraud',
    'fraud detection',
    'security',
    'anomaly',
    'freeze',
    'protection',
    'suspicious',
    'risk',
    'unusual activity',
  ];
  static const socialAndBiometricLogin = [
    'google',
    'apple',
    'google sign-in',
    'apple sign-in',
    'sign in with google',
    'sign in with apple',
    'social login',
    'biometric',
    'fingerprint',
    'face id',
    'voice login',
  ];
  static const autoLogout = [
    'auto logout',
    'auto-logout',
    'timeout',
    'idle',
    'idle timeout',
    'inactivity',
    'session',
    'session timeout',
    'lock',
  ];
  static const twoFactor = [
    '2fa',
    'mfa',
    'otp',
    'authenticator',
    'totp',
    'two factor',
  ];

  /// Everything the Security section can answer to.
  static const security = [
    ...fraudDetection,
    ...socialAndBiometricLogin,
    ...autoLogout,
    ...twoFactor,
    // Words for tiles that were already reachable, kept verbatim.
    'passcode', 'change passcode', 'transaction pin', 'payment pin',
    'panic balance', 'decoy', 'banking channels', 'whatsapp banking',
    'sms banking', 'phone banking', 'admin alerts', 'biometric login',
    'verify email', 'verify phone number', 'update password',
    'device permissions', 'login activity', 'recent sign-ins',
    'sign in history', 'trusted devices', 'camera', 'microphone',
    'contacts access', 'permissions', 'set password', 'change password',
  ];

  // ── Notifications & Display ────────────────────────────────────────────
  static const escrowNotice = [
    'escrow',
    'escrow pay',
    'escrow notice',
    'escrow terms',
    'escrow rules',
    'liability',
    'show again',
    'middleman',
    'payment channel',
    'notice',
    'rules',
  ];
  static const chatToneVolume = [
    'volume',
    'loud',
    'quiet',
    'sound',
    'chat tone',
    'message tone',
  ];

  /// Everything the Notifications & Display section can answer to.
  static const notifications = [
    ...escrowNotice,
    ...chatToneVolume,
    'notifications',
    'push',
    'email notifications',
    'sms',
    'dark mode',
    'theme',
    'display',
    'alerts',
    'chat sound',
    'message sound',
    'vibration',
    'haptics',
    'balance vibration',
    'balance update',
    'vibrate on balance',
    'haptic feedback',
    'balance animation',
    'account update',
  ];

  // ── Voice & Chat Assistant ─────────────────────────────────────────────
  static const voiceSetup = [
    'voice setup',
    'set up voice',
    'voice clone',
    'cloning',
    'clone my voice',
    'voice enrollment',
    'enroll',
    'voice recognition',
    'my voice',
    'assistant voice',
    'tts',
    'voice selection',
    'language',
  ];
  static const perServiceVoice = [
    'voice',
    'chat',
    'assistant',
    'voice agent',
    'per-service',
    'language',
    'voice selection',
    'prompt hint',
    'prompt',
    'hint',
  ];

  /// The per-service voice tiles' own names — every `slug` and lowercased
  /// `label` of the `_VoiceServiceTile` catalogue in `_voiceAssistantBody`.
  ///
  /// Those tiles build their keywords DYNAMICALLY (`s.label`, `s.slug`), so
  /// the section cannot spread the tile's list the way it does elsewhere.
  /// Without these, searching "insurance", "payroll" or "lazerspray" was
  /// filtered out at stage one and never reached the tile that matched it.
  ///
  /// Keep in step with that catalogue: a new per-service voice tile needs its
  /// slug and label here or it is unreachable from the search bar.
  static const perServiceServiceNames = [
    'transfers',
    'send funds & transfers',
    'crypto',
    'investments',
    'exchange',
    'currency exchange',
    'banking',
    'banking (deposits & withdrawals)',
    'deposits',
    'withdrawals',
    'products',
    'bills & utilities',
    'bills',
    'utilities',
    'commerce',
    'invoices & gift cards',
    'invoices',
    'gift cards',
    'insurance',
    'business',
    'business (payroll & customers)',
    'payroll',
    'customers',
    'statistics',
    'spending insights',
    'insights',
    'sprayme',
    'lazerspray',
    'lifestyle',
    'accounts',
    'accounts & cards',
    'cards',
  ];

  /// Everything the Voice & Chat Assistant section can answer to.
  static const voiceAssistant = [
    ...voiceSetup,
    ...perServiceVoice,
    ...perServiceServiceNames,
    'voice assistant', 'chat assistant', 'ai', 'chatbot',
    'voice language',
    // Voice transaction-PIN controls (VoiceTxPinSection).
    'pin', 'transaction pin', 'ask for my pin', 'ask for my pin in voice',
    'require pin', 'voice pin', 'skip pin', 'pin entry', 'say my pin',
    // Per-service tuning entry points.
    'per service', 'transfers voice', 'crypto voice', 'bills voice',
    'exchange voice',
  ];

  // ── Group Funds ────────────────────────────────────────────────────────
  static const groupFundsTerms = [
    'group funds terms',
    'terms',
    'first visit',
    'first',
    'visit',
    'show terms again',
    'reset terms',
    'dont show again',
    "don't show again",
  ];

  /// Everything the Group Funds section can answer to.
  static const groupFunds = [
    ...groupFundsTerms,
    'group funds',
    'esusu',
    'rosca',
    'contribution',
    'terms and conditions',
    'how it works',
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
