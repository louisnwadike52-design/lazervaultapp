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
  };

  /// Returns the currency symbol for the given ISO currency code.
  /// Falls back to the code itself if not found.
  static String getSymbol(String currencyCode) {
    return _symbols[currencyCode.toUpperCase()] ?? currencyCode;
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
