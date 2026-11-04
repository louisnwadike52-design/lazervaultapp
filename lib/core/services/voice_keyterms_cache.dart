import 'package:shared_preferences/shared_preferences.dart';

/// The names this user actually sends money to, cached for the recogniser.
///
/// WHY
/// ---
/// The voice agent transcribed "send money to Onah Praiz" as "praise honor".
/// Deepgram's nova-3 supports KEYTERM prompting — an additive boost for words
/// you tell it to expect — and the gateway's `get_keyterms` has ranked
/// per-speaker terms above its own curated Nigerian-name lists since it was
/// written, calling them "the exact spellings in this user's own address book"
/// against "a guess at common Nigerian names".
///
/// Nothing ever supplied them. The parameter, the budget priority and the
/// docstring all existed and no caller passed a list, so every session ran on
/// the guess while the real answer sat on the device.
///
/// WHY A CACHE AND NOT A FETCH
/// ---------------------------
/// The names have to be in the session-start request body, so fetching them
/// there would put a network round-trip in front of the first word — and the
/// gateway's own comments record that a lookup on that path "previously
/// stalled the first word", which is why the clone status is embedded in room
/// metadata rather than fetched.
///
/// So this is written as a side effect of a load that was happening anyway:
/// the user opens Send Money, their recipients load, the names land here. By
/// the time they talk to the assistant the cache is warm, and reading it costs
/// nothing. An empty cache is not a failure — the session simply runs on the
/// curated terms, exactly as it did before.
///
/// WHAT IS STORED
/// --------------
/// First names only. A keyterm boost works on the word, so a surname only
/// spends the budget, and the server re-sanitises and re-caps regardless —
/// these values reach a Deepgram URL, where an over-long list fails the
/// WebSocket handshake and takes STT down for the session. Never an account
/// number: it would not help recognition and this is a device-local store.
class VoiceKeytermsCache {
  const VoiceKeytermsCache._();

  static const _key = 'voice_recipient_keyterms';

  /// Keep this comfortably under the server's own cap (40) so the client is
  /// never the thing that overflows it.
  static const _max = 40;

  /// Record the recipient names from a list that was just loaded.
  ///
  /// Best-effort in every direction: a storage failure must never break the
  /// recipient screen that triggered it, and nothing downstream requires the
  /// cache to exist.
  static Future<void> remember(Iterable<String> fullNames) async {
    try {
      final cleaned = _clean(fullNames);
      if (cleaned.isEmpty) return;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, cleaned);
    } catch (_) {
      // A recogniser hint is not worth surfacing an error for.
    }
  }

  /// The cached names, or empty when nothing has been loaded yet.
  static Future<List<String>> read() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_key) ?? const <String>[];
    } catch (_) {
      return const <String>[];
    }
  }

  /// Dropped on user switch / logout along with the rest of the per-account
  /// caches: one person's address book must never boost another's speech.
  static Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (_) {}
  }

  /// First token, letters only, de-duplicated case-insensitively, capped.
  ///
  /// Mirrors the server's `_sanitise_recipient_keyterms` so the client does not
  /// send values the server will silently drop — and so a reader of either side
  /// sees the same rule.
  static List<String> _clean(Iterable<String> fullNames) {
    final seen = <String>{};
    final out = <String>[];
    for (final raw in fullNames) {
      final parts = raw.trim().split(RegExp(r'\s+'));
      if (parts.isEmpty) continue;
      // "Onah Praiz" -> "Onah". Boosting the first name needs no surname.
      final token =
          parts.first.replaceAll(RegExp(r"[^A-Za-zÀ-ɏ' -]"), '').trim();
      if (token.length < 2 || token.length > 24) continue;
      final low = token.toLowerCase();
      if (!seen.add(low)) continue;
      out.add(token);
      if (out.length >= _max) break;
    }
    return out;
  }
}
