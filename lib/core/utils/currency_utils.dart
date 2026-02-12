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
}
