import 'package:shared_preferences/shared_preferences.dart';

/// Which voice languages a user may actually choose.
///
/// WHY THIS EXISTS
///
/// The pickers offered English, Nigerian Pidgin, Yoruba, Igbo, Hausa, French
/// and Spanish because the gateway's SUPPORTED_LANGUAGES set lists them. But
/// listing a language is not the same as being able to SPEAK it well: the TTS
/// routing, the voice catalogue and the agent prompts are only production-ready
/// for English today. A picker that offers six languages and delivers one is a
/// control that lies — the user selects Yoruba, nothing changes, and they
/// conclude the setting is broken.
///
/// So availability is now a server-driven allowlist with an English-only
/// default, rather than a hardcoded list that drifts from what the stack can
/// do. When the other languages are genuinely ready, an operator widens the
/// key and every picker follows with no app release.
///
/// Key: `voice_enabled_languages_csv` in payments_db.system_settings, served by
/// the admin-gateway voice-agents settings bulk read. The `voice_` prefix is
/// already carried by that read's WHERE clause, so no new prefix is needed —
/// the omission that has silently broken flags here before.
class VoiceLanguageAvailability {
  const VoiceLanguageAvailability._();

  /// Settings key holding a comma-separated list of allowed language codes.
  static const String settingKey = 'voice_enabled_languages_csv';

  /// English only. Deliberately the DEFAULT rather than a fallback used when
  /// the fetch fails: shipping with everything enabled and relying on an
  /// operator to narrow it is the wrong way round for a control that currently
  /// cannot deliver what it offers.
  static const List<String> _defaultAllowed = <String>['en'];

  static SharedPreferences? _prefs;

  /// Bound by FeatureFlags/EndpointRegistry when the remote snapshot lands.
  static void bind(SharedPreferences prefs) => _prefs = prefs;

  /// The allowed language codes, lower-cased.
  ///
  /// An unset, empty or unparseable value yields English only. A value that
  /// parses to nothing (", ,") is treated as unset rather than as "no
  /// languages at all", because a picker with zero options is worse than one
  /// with the single language we know works.
  static List<String> get allowedCodes {
    final raw = _prefs?.getString(settingKey)?.trim() ?? '';
    if (raw.isEmpty) return _defaultAllowed;
    final codes = raw
        .split(',')
        .map((c) => c.trim().toLowerCase())
        .where((c) => c.isNotEmpty)
        .toList();
    return codes.isEmpty ? _defaultAllowed : codes;
  }

  /// Whether [code] may be offered. The empty code is "inherit general
  /// settings" — a scope, not a language — so it is always allowed.
  static bool isAllowed(String? code) {
    final c = (code ?? '').trim().toLowerCase();
    if (c.isEmpty) return true;
    return allowedCodes.contains(c);
  }

  /// True when only one real language is available, so a picker can present
  /// itself as informational rather than as a choice the user does not have.
  static bool get isSingleLanguage => allowedCodes.length <= 1;

  /// The one language to preselect when there is no meaningful choice.
  static String get primaryCode =>
      allowedCodes.isEmpty ? 'en' : allowedCodes.first;
}
