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
    const Currency(
      code: 'ZAR',
      name: 'South African Rand',
      symbol: 'R',
      flagUrl: '$_flagBaseUrl/za.png',
      countryCode: 'ZA',
      countryName: 'South Africa',
      exchangeRate: 14.8,
    ),
    const Currency(
      code: 'UGX',
      name: 'Ugandan Shilling',
      symbol: 'USh',
      flagUrl: '$_flagBaseUrl/ug.png',
      countryCode: 'UG',
      countryName: 'Uganda',
      exchangeRate: 3700.0,
    ),
    const Currency(
      code: 'TZS',
      name: 'Tanzanian Shilling',
      symbol: 'TSh',
      flagUrl: '$_flagBaseUrl/tz.png',
      countryCode: 'TZ',
      countryName: 'Tanzania',
      exchangeRate: 2350.0,
    ),
    const Currency(
      code: 'XOF',
      name: 'West African CFA Franc',
      symbol: 'CFA',
      flagUrl: '$_flagBaseUrl/sn.png',
      countryCode: 'SN',
      countryName: 'Senegal',
      exchangeRate: 555.0,
    ),
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
