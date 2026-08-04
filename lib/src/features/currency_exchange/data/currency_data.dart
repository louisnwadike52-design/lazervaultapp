import '../domain/entities/currency_entity.dart';

class CurrencyData {
  static const String _flagBaseUrl = 'https://flagcdn.com/w320';

  static List<Currency> get popularCurrencies => [
    const Currency(
      code: 'NGN',
      name: 'Nigerian Naira',
      symbol: '₦',
      flagUrl: '$_flagBaseUrl/ng.png',
      countryCode: 'NG',
      countryName: 'Nigeria',
      exchangeRate: 411.0,
      isPopular: true,
    ),
    const Currency(
      code: 'USD',
      name: 'US Dollar',
      symbol: '\$',
      flagUrl: '$_flagBaseUrl/us.png',
      countryCode: 'US',
      countryName: 'United States',
      exchangeRate: 1.0,
      isPopular: true,
    ),
    const Currency(
      code: 'GBP',
      name: 'British Pound',
      symbol: '£',
      flagUrl: '$_flagBaseUrl/gb.png',
      countryCode: 'GB',
      countryName: 'United Kingdom',
      exchangeRate: 0.73,
      isPopular: true,
    ),
    const Currency(
      code: 'EUR',
      name: 'Euro',
      symbol: '€',
      flagUrl: '$_flagBaseUrl/eu.png',
      countryCode: 'EU',
      countryName: 'European Union',
      exchangeRate: 0.85,
      isPopular: true,
    ),
  ];

  static List<Currency> get allCurrencies => [
    ...popularCurrencies,
    const Currency(
      code: 'GHS',
      name: 'Ghanaian Cedi',
      symbol: '₵',
      flagUrl: '$_flagBaseUrl/gh.png',
      countryCode: 'GH',
      countryName: 'Ghana',
      exchangeRate: 6.1,
    ),
    const Currency(
      code: 'KES',
      name: 'Kenyan Shilling',
      symbol: 'KSh',
      flagUrl: '$_flagBaseUrl/ke.png',
      countryCode: 'KE',
      countryName: 'Kenya',
      exchangeRate: 107.0,
    ),
    // PHP (Philippines) / CAD (Canada) removed — the Klasha account is
    // inaccessible (login 403) and Klasha is reserved for RMB. Re-add here +
    // in FlutterwaveCountryRules + backend supportedCurrencyCodes/
    // getSupportedCurrencies + klashaCurrencies together if Klasha is restored.
    // ZAR / UGX / TZS / XOF removed (#131): Flutterwave's FX/Transfers API
    // doesn't reliably support them, matching FlutterwaveCountryRules and the
    // backend corridor matrix (explicit supported=false rows). Re-add here +
    // there together if provider coverage improves.
  ];

  static Currency? getCurrencyByCode(String code) {
    try {
      return allCurrencies.firstWhere((currency) => currency.code == code);
    } catch (e) {
      return null;
    }
  }

  static List<Currency> searchCurrencies(String query) {
    if (query.isEmpty) return allCurrencies;

    final lowercaseQuery = query.toLowerCase();
    return allCurrencies.where((currency) {
      return currency.code.toLowerCase().contains(lowercaseQuery) ||
             currency.name.toLowerCase().contains(lowercaseQuery) ||
             currency.countryName.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
