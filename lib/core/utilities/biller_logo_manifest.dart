// Maps a biller's code/name to a bundled brand-logo asset for [BillerLogo]
// (electricity DisCos, cable TV, betting platforms). Mirrors
// `network_logo_manifest.dart` but the assets are raster (lossless WebP) rather
// than SVG, so each entry carries its full asset path (with extension).
//
// Resolution is alias-tolerant + case/separator-insensitive: "Ikeja Electric",
// "IKEDC", "ikeja-electric" all resolve to the same disco logo. A key that
// isn't bundled returns null and the widget falls back to its brand-colour +
// initials tile — so a new/unknown biller never shows a broken image.

/// Canonical biller slug → bundled asset path (lossless WebP).
const Map<String, String> _kBillerLogoAssets = {
  // ── Electricity DisCos ──────────────────────────────────────────────
  'ikedc': 'assets/images/discos/ikedc.webp',
  'ekedc': 'assets/images/discos/ekedc.webp',
  'aedc': 'assets/images/discos/aedc.webp',
  'ibedc': 'assets/images/discos/ibedc.webp',
  'phed': 'assets/images/discos/phed.webp',
  'kedco': 'assets/images/discos/kedco.webp',
  'kaedco': 'assets/images/discos/kaedco.webp',
  'jed': 'assets/images/discos/jed.webp',
  'eedc': 'assets/images/discos/eedc.webp',
  'bedc': 'assets/images/discos/bedc.webp',
  // ── Cable TV ────────────────────────────────────────────────────────
  'dstv': 'assets/images/cable/dstv.webp',
  'gotv': 'assets/images/cable/gotv.webp',
  'startimes': 'assets/images/cable/startimes.webp',
  'showmax': 'assets/images/cable/showmax.webp',
  // ── Betting platforms ───────────────────────────────────────────────
  'bet9ja': 'assets/images/billers/bet9ja.webp',
  'sportybet': 'assets/images/billers/sportybet.webp',
  'betking': 'assets/images/billers/betking.webp',
  '1xbet': 'assets/images/billers/1xbet.webp',
  'betway': 'assets/images/billers/betway.webp',
  'nairabet': 'assets/images/billers/nairabet.webp',
};

/// Alias → canonical slug. Covers common code/name spellings from VTpass +
/// the app's own provider entities.
const Map<String, String> _kBillerAliases = {
  // Electricity DisCos (name / VTpass serviceID variants).
  'ikeja': 'ikedc', 'ikeja-electric': 'ikedc', 'ikejaelectric': 'ikedc',
  'ikeja-electricity': 'ikedc',
  'eko': 'ekedc', 'eko-electric': 'ekedc', 'ekoelectric': 'ekedc',
  'abuja': 'aedc', 'abuja-electric': 'aedc', 'abujaelectric': 'aedc',
  'ibadan': 'ibedc', 'ibadan-electric': 'ibedc',
  'portharcourt': 'phed', 'port-harcourt': 'phed', 'ph': 'phed',
  'kano': 'kedco', 'kano-electric': 'kedco',
  'kaduna': 'kaedco', 'kaduna-electric': 'kaedco',
  'jos': 'jed', 'jos-electric': 'jed',
  'enugu': 'eedc', 'enugu-electric': 'eedc',
  'benin': 'bedc', 'benin-electric': 'bedc',
  // Cable TV.
  'dstv-subscription': 'dstv', 'multichoice': 'dstv',
  'gotv-subscription': 'gotv',
  'startime': 'startimes', 'star-times': 'startimes',
  'showmax-subscription': 'showmax',
  // Betting.
  'bet-9ja': 'bet9ja', 'bet9ja-funding': 'bet9ja',
  'sporty': 'sportybet', 'sporty-bet': 'sportybet',
  'bet-king': 'betking',
  '1x-bet': '1xbet', 'onexbet': '1xbet',
  'bet-way': 'betway',
  'naira-bet': 'nairabet', 'naira9ja': 'nairabet',
};

/// The bundled logo asset for a biller [key] (its `providerCode`/`serviceId`/
/// `code`/`name`), or null when none is bundled. Case/separator-insensitive.
String? bundledBillerLogoAsset(String? key) {
  if (key == null) return null;
  final slug = _slug(key);
  if (slug.isEmpty) return null;
  final canonical = _kBillerLogoAssets.containsKey(slug)
      ? slug
      : _kBillerAliases[slug];
  if (canonical == null) return null;
  return _kBillerLogoAssets[canonical];
}

/// Normalise to a lowercase, punctuation-stripped slug (keeps hyphens for the
/// alias lookups, then also tries the hyphen-stripped form).
String _slug(String s) {
  final lower = s.trim().toLowerCase();
  // First try with separators collapsed to single hyphens (matches the alias
  // keys), then the caller-side lookup also tries the fully-stripped form.
  final hyphenated =
      lower.replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '');
  if (_kBillerLogoAssets.containsKey(hyphenated) ||
      _kBillerAliases.containsKey(hyphenated)) {
    return hyphenated;
  }
  // Fully stripped (e.g. "sporty bet" → "sportybet").
  return lower.replaceAll(RegExp(r'[^a-z0-9]'), '');
}
