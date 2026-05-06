/// Canonical URL prefix for each social-link input. The first entry of
/// each `*LinkPrefixes` list is the *primary* form — what we always
/// re-prepend on save and render in InputDecoration.prefixText. The
/// remaining entries are accepted-and-stripped alternates that user
/// data may already contain (legacy domains, alternate paths). Without
/// stripping the alternates, a saved `https://wa.me/...` would render
/// as `https://chat.whatsapp.com/https://wa.me/...` (visual gibberish)
/// because the controller would hold the full URL while the decoration
/// renders the canonical prefix in front of it.
const String whatsappLinkPrefix = 'https://chat.whatsapp.com/';
const String telegramLinkPrefix = 'https://t.me/';

/// Recognized alternates for each platform. Order doesn't matter for
/// stripping; the longest match wins so `https://chat.whatsapp.com/`
/// is preferred over a hypothetical `https://wa.com/` partial.
const List<String> whatsappLinkPrefixes = <String>[
  whatsappLinkPrefix,
  'https://wa.me/',
  'http://chat.whatsapp.com/',
  'http://wa.me/',
];

const List<String> telegramLinkPrefixes = <String>[
  telegramLinkPrefix,
  'https://telegram.me/',
  'http://t.me/',
  'http://telegram.me/',
];

/// Strip ANY recognized prefix variant from a saved URL so the
/// suffix-only value can populate a "prefix-baked-into-decoration"
/// text field. Falls back to returning the raw value unchanged when no
/// alternate matches — that case is rare (user manually typed a
/// non-canonical URL we've never seen) and preserving the data is
/// strictly better than dropping it.
///
/// Backwards-compatible signature: callers passing the canonical
/// platform prefix get the full alternate-list handling automatically;
/// callers passing some other prefix get a single-element strip.
String stripCanonicalPrefix(String? raw, String prefix) {
  if (prefix == whatsappLinkPrefix) {
    return stripAnyCanonicalPrefix(raw, whatsappLinkPrefixes);
  }
  if (prefix == telegramLinkPrefix) {
    return stripAnyCanonicalPrefix(raw, telegramLinkPrefixes);
  }
  return stripAnyCanonicalPrefix(raw, <String>[prefix]);
}

/// Multi-prefix flavor of [stripCanonicalPrefix]. Use the platform-level
/// constants `whatsappLinkPrefixes` / `telegramLinkPrefixes` so all
/// recognized variants get stripped.
String stripAnyCanonicalPrefix(String? raw, List<String> prefixes) {
  if (raw == null || raw.isEmpty) return '';
  // Try the longest prefix first so partial-overlap forms don't win
  // by accident (e.g. `https://t.me/` vs `https://telegram.me/`).
  final ordered = [...prefixes]..sort((a, b) => b.length.compareTo(a.length));
  for (final p in ordered) {
    if (raw.startsWith(p)) return raw.substring(p.length);
  }
  return raw;
}

/// Build the full URL from a suffix-only controller value. If the user
/// pasted a full URL (contains "://"), pass through unchanged so we
/// don't double-prefix or break alternate canonical forms.
String? buildSocialFullUrl(String userTyped, String prefix) {
  final trimmed = userTyped.trim();
  if (trimmed.isEmpty) return null;
  if (trimmed.contains('://')) return trimmed;
  return '$prefix$trimmed';
}
