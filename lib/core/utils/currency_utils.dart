class CurrencyUtils {
  CurrencyUtils._();

  static const Map<String, String> _symbols = {
    'NGN': '\u20A6',
    'GBP': '\u00A3',
    'USD': '\$',
    'EUR': '\u20AC',
    'GHS': 'GH\u20B5',
    'KES': 'KSh',
    'ZAR': 'R',
    'CAD': 'C\$',
    'AUD': 'A\$',
    'PHP': '\u20B1',
  };

  /// Returns the currency symbol for an ISO code OR a full currency name.
  ///
  /// Normalises first. An account's `currency` is not guaranteed to be an ISO
  /// code \u2014 some sources carry a display name ("Nigerian Naira"), which is the
  /// whole reason [normalizeCode] exists. Matching on the raw string made this
  /// silently return the NAME as the "symbol", so an amount rendered as
  /// "Nigerian Naira 66.68" \u2014 or, where a caller supplied its own fallback,
  /// as the wrong currency entirely.
  ///
  /// Falls back to the normalised code so an unknown currency is still labelled
  /// unambiguously, never mislabelled as another one.
  static String getSymbol(String currencyCode) {
    if (currencyCode.trim().isEmpty) return '';
    return _symbols[normalizeCode(currencyCode)] ?? normalizeCode(currencyCode);
  }

  /// Maps common full currency names to their ISO code. Providers (e.g.
  /// MyCover) return a human name like "NIGERIAN NAIRA" for the premium
  /// currency while our accounts carry the ISO code "NGN" — a raw string
  /// compare wrongly flags these as different currencies.
  static const Map<String, String> _nameToCode = {
    'NIGERIAN NAIRA': 'NGN',
    'NAIRA': 'NGN',
    'US DOLLAR': 'USD',
    'UNITED STATES DOLLAR': 'USD',
    'DOLLAR': 'USD',
    'POUND STERLING': 'GBP',
    'BRITISH POUND': 'GBP',
    'POUND': 'GBP',
    'EURO': 'EUR',
    'GHANA CEDI': 'GHS',
    'GHANAIAN CEDI': 'GHS',
    'CEDI': 'GHS',
    'KENYAN SHILLING': 'KES',
    'SOUTH AFRICAN RAND': 'ZAR',
    'RAND': 'ZAR',
  };

  /// Normalises an ISO code OR a full currency name to the canonical ISO code
  /// (uppercased). Unknown inputs return their uppercased/trimmed form so the
  /// comparison is still deterministic.
  static String normalizeCode(String input) {
    final v = input.trim().toUpperCase();
    if (_symbols.containsKey(v)) return v; // already an ISO code we know
    return _nameToCode[v] ?? v;
  }

  /// True when two currency representations refer to the same currency,
  /// tolerating code-vs-name differences (e.g. "NGN" == "NIGERIAN NAIRA").
  static bool sameCurrency(String a, String b) =>
      normalizeCode(a) == normalizeCode(b);
}
