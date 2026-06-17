import 'package:shared_preferences/shared_preferences.dart';

/// Persisted user preference for the AI chatbot's response language.
///
/// The chatbot honors a user-selected language (set via the AI Settings modal)
/// and the gateway additionally auto-detects the language of each message. This
/// helper is the single source of truth for the *selected* language on the
/// Flutter side — it's read by the chat datasource when building every request
/// (so the backend always knows which language to reply in) and written by the
/// chat cubits' `setLanguage()`.
///
/// Supported language codes match the gateway/voice allow-list
/// (`en,yo,ig,ha,pcm,fr,es`).
class ChatLanguagePreference {
  static const String _key = 'chat_language';
  static const String defaultLanguage = 'en';

  /// Supported language codes -> human-readable display names.
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'yo': 'Yoruba',
    'ig': 'Igbo',
    'ha': 'Hausa',
    'pcm': 'Pidgin',
    'fr': 'French',
    'es': 'Spanish',
  };

  /// Language code -> BCP-47 locale used for the request `locale` field.
  static const Map<String, String> _localeByLanguage = {
    'en': 'en-NG',
    'yo': 'yo-NG',
    'ig': 'ig-NG',
    'ha': 'ha-NG',
    'pcm': 'en-NG', // Nigerian Pidgin has no widely-supported BCP-47 region tag
    'fr': 'fr-FR',
    'es': 'es-ES',
  };

  /// Map a language code to its locale, falling back to `en-NG`.
  static String localeFor(String language) =>
      _localeByLanguage[language] ?? 'en-NG';

  /// Read the persisted language code (defaults to `en`).
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(_key);
    if (lang == null || !supportedLanguages.containsKey(lang)) {
      return defaultLanguage;
    }
    return lang;
  }

  /// Read the persisted locale derived from the selected language.
  static Future<String> getLocale() async {
    return localeFor(await getLanguage());
  }

  /// Persist a new language code. Unsupported codes are coerced to the default.
  static Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final normalized =
        supportedLanguages.containsKey(language) ? language : defaultLanguage;
    await prefs.setString(_key, normalized);
  }
}
