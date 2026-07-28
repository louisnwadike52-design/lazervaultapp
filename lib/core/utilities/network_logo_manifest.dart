// Bundled mobile-network-operator logo manifest.
//
// Lists the Nigerian operators that have a bundled, brand-styled SVG badge
// under `assets/images/networks/<slug>.svg`. Used by `NetworkLogo` to decide
// synchronously whether to render the bundled asset or fall back to the
// brand-colored initials tile. Logos ship in the app binary so there are no
// remote calls (the international/Reloadly path keeps using remote `logoUrl`).
//
// The bundled files are simple brand-colored wordmark badges (nominative use —
// the app sells these operators' airtime/data), NOT reproductions of the exact
// trademarked artwork. To swap in the exact provider/Reloadly artwork later,
// drop files with the SAME filenames into `assets/images/networks/` and this
// manifest keeps resolving them unchanged.

/// Operator slugs that have a bundled logo asset (`<slug>.svg`).
const Set<String> kBundledNetworkLogoSlugs = {
  'mtn',
  'airtel',
  'glo',
  '9mobile',
};

/// Asset path for a bundled network logo, or `null` when no logo is bundled for
/// [key]. [key] may be a network `type` (`mtn`, `airtel`, `glo`, `ninemobile`,
/// `etisalat`), an `operatorId` (`MTN`, `AIRTEL`, `GLO`, `9MOBILE`), a
/// `shortName` (`MTN`, `Airtel`, `Glo`, `9mobile`), or a data network code
/// (`mtn-data`, `airtel-data`, `glo-data`, `etisalat-data`). Matching is
/// case-insensitive and tolerant of the `-data`/`-airtime` suffixes. Returns
/// `null` for empty/unknown keys so callers fall back to the initials tile.
String? bundledNetworkLogoAsset(String? key) {
  if (key == null || key.trim().isEmpty) return null;
  final k = key.trim().toLowerCase();

  // 9mobile (formerly Etisalat) — many aliases.
  if (k.contains('9mobile') ||
      k.contains('ninemobile') ||
      k.contains('etisalat') ||
      k.startsWith('9')) {
    return 'assets/images/networks/9mobile.svg';
  }
  if (k.contains('mtn')) return 'assets/images/networks/mtn.svg';
  if (k.contains('airtel')) return 'assets/images/networks/airtel.svg';
  if (k.contains('glo') || k.contains('globacom')) {
    return 'assets/images/networks/glo.svg';
  }
  return null;
}
