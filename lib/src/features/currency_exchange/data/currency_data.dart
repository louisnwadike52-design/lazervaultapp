import '../domain/entities/currency_entity.dart';

class CurrencyData {
  static const String _flagBaseUrl = 'https://flagcdn.com/w320';

  static List<Currency> get popularCurrencies => [
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
      code: 'EUR',
      name: 'Euro',
      symbol: '€',
      flagUrl: '$_flagBaseUrl/eu.png',
      countryCode: 'EU',
      countryName: 'European Union',
      exchangeRate: 0.85,
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
      code: 'JPY',
      name: 'Japanese Yen',
      symbol: '¥',
      flagUrl: '$_flagBaseUrl/jp.png',
      countryCode: 'JP',
      countryName: 'Japan',
      exchangeRate: 110.0,
      isPopular: true,
    ),
    const Currency(
      code: 'CAD',
      name: 'Canadian Dollar',
      symbol: 'C\$',
      flagUrl: '$_flagBaseUrl/ca.png',
      countryCode: 'CA',
      countryName: 'Canada',
      exchangeRate: 1.25,
      isPopular: true,
    ),
    const Currency(
      code: 'AUD',
      name: 'Australian Dollar',
      symbol: 'A\$',
      flagUrl: '$_flagBaseUrl/au.png',
      countryCode: 'AU',
      countryName: 'Australia',
      exchangeRate: 1.35,
      isPopular: true,
    ),
  ];

  static List<Currency> get allCurrencies => [
    ...popularCurrencies,
    const Currency(
      code: 'CHF',
      name: 'Swiss Franc',
      symbol: 'CHF',
      flagUrl: '$_flagBaseUrl/ch.png',
      countryCode: 'CH',
      countryName: 'Switzerland',
      exchangeRate: 0.92,
    ),
    const Currency(
      code: 'CNY',
      name: 'Chinese Yuan',
      symbol: '¥',
      flagUrl: '$_flagBaseUrl/cn.png',
      countryCode: 'CN',
      countryName: 'China',
      exchangeRate: 6.45,
    ),
    const Currency(
      code: 'INR',
      name: 'Indian Rupee',
      symbol: '₹',
      flagUrl: '$_flagBaseUrl/in.png',
      countryCode: 'IN',
      countryName: 'India',
      exchangeRate: 74.5,
    ),
    const Currency(
      code: 'KRW',
      name: 'South Korean Won',
      symbol: '₩',
      flagUrl: '$_flagBaseUrl/kr.png',
      countryCode: 'KR',
      countryName: 'South Korea',
      exchangeRate: 1180.0,
    ),
    const Currency(
      code: 'SGD',
      name: 'Singapore Dollar',
      symbol: 'S\$',
      flagUrl: '$_flagBaseUrl/sg.png',
      countryCode: 'SG',
      countryName: 'Singapore',
      exchangeRate: 1.35,
    ),
    const Currency(
      code: 'HKD',
      name: 'Hong Kong Dollar',
      symbol: 'HK\$',
      flagUrl: '$_flagBaseUrl/hk.png',
      countryCode: 'HK',
      countryName: 'Hong Kong',
      exchangeRate: 7.8,
    ),
    const Currency(
      code: 'NOK',
      name: 'Norwegian Krone',
      symbol: 'kr',
      flagUrl: '$_flagBaseUrl/no.png',
      countryCode: 'NO',
      countryName: 'Norway',
      exchangeRate: 8.5,
    ),
    const Currency(
      code: 'SEK',
      name: 'Swedish Krona',
      symbol: 'kr',
      flagUrl: '$_flagBaseUrl/se.png',
      countryCode: 'SE',
      countryName: 'Sweden',
      exchangeRate: 8.7,
    ),
    const Currency(
      code: 'DKK',
      name: 'Danish Krone',
      symbol: 'kr',
      flagUrl: '$_flagBaseUrl/dk.png',
      countryCode: 'DK',
      countryName: 'Denmark',
      exchangeRate: 6.3,
    ),
    const Currency(
      code: 'NZD',
      name: 'New Zealand Dollar',
      symbol: 'NZ\$',
      flagUrl: '$_flagBaseUrl/nz.png',
      countryCode: 'NZ',
      countryName: 'New Zealand',
      exchangeRate: 1.42,
    ),
    const Currency(
      code: 'MXN',
      name: 'Mexican Peso',
      symbol: '\$',
      flagUrl: '$_flagBaseUrl/mx.png',
      countryCode: 'MX',
      countryName: 'Mexico',
      exchangeRate: 20.1,
    ),
    const Currency(
      code: 'BRL',
      name: 'Brazilian Real',
      symbol: 'R\$',
      flagUrl: '$_flagBaseUrl/br.png',
      countryCode: 'BR',
      countryName: 'Brazil',
      exchangeRate: 5.2,
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
      code: 'RUB',
      name: 'Russian Ruble',
      symbol: '₽',
      flagUrl: '$_flagBaseUrl/ru.png',
      countryCode: 'RU',
      countryName: 'Russia',
      exchangeRate: 75.0,
    ),
    const Currency(
      code: 'TRY',
      name: 'Turkish Lira',
      symbol: '₺',
      flagUrl: '$_flagBaseUrl/tr.png',
      countryCode: 'TR',
      countryName: 'Turkey',
      exchangeRate: 8.5,
    ),
    const Currency(
      code: 'PLN',
      name: 'Polish Zloty',
      symbol: 'zł',
      flagUrl: '$_flagBaseUrl/pl.png',
      countryCode: 'PL',
      countryName: 'Poland',
      exchangeRate: 3.9,
    ),
    const Currency(
      code: 'CZK',
      name: 'Czech Koruna',
      symbol: 'Kč',
      flagUrl: '$_flagBaseUrl/cz.png',
      countryCode: 'CZ',
      countryName: 'Czech Republic',
      exchangeRate: 21.5,
    ),
    const Currency(
      code: 'HUF',
      name: 'Hungarian Forint',
      symbol: 'Ft',
      flagUrl: '$_flagBaseUrl/hu.png',
      countryCode: 'HU',
      countryName: 'Hungary',
      exchangeRate: 295.0,
    ),
    const Currency(
      code: 'ILS',
      name: 'Israeli Shekel',
      symbol: '₪',
      flagUrl: '$_flagBaseUrl/il.png',
      countryCode: 'IL',
      countryName: 'Israel',
      exchangeRate: 3.2,
    ),
    const Currency(
      code: 'AED',
      name: 'UAE Dirham',
      symbol: 'د.إ',
      flagUrl: '$_flagBaseUrl/ae.png',
      countryCode: 'AE',
      countryName: 'United Arab Emirates',
      exchangeRate: 3.67,
    ),
    const Currency(
      code: 'SAR',
      name: 'Saudi Riyal',
      symbol: '﷼',
      flagUrl: '$_flagBaseUrl/sa.png',
      countryCode: 'SA',
      countryName: 'Saudi Arabia',
      exchangeRate: 3.75,
    ),
    const Currency(
      code: 'EGP',
      name: 'Egyptian Pound',
      symbol: '£',
      flagUrl: '$_flagBaseUrl/eg.png',
      countryCode: 'EG',
      countryName: 'Egypt',
      exchangeRate: 15.7,
    ),
    const Currency(
      code: 'NGN',
      name: 'Nigerian Naira',
      symbol: '₦',
      flagUrl: '$_flagBaseUrl/ng.png',
      countryCode: 'NG',
      countryName: 'Nigeria',
      exchangeRate: 411.0,
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
      code: 'GHS',
      name: 'Ghanaian Cedi',
      symbol: '₵',
      flagUrl: '$_flagBaseUrl/gh.png',
      countryCode: 'GH',
      countryName: 'Ghana',
      exchangeRate: 6.1,
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

  static double convertCurrency(double amount, String fromCode, String toCode) {
    final fromCurrency = getCurrencyByCode(fromCode);
    final toCurrency = getCurrencyByCode(toCode);
    
    if (fromCurrency == null || toCurrency == null) return 0.0;
    
    // Convert to USD first, then to target currency
    final usdAmount = amount / fromCurrency.exchangeRate;
    return usdAmount * toCurrency.exchangeRate;
  }

  static double getExchangeRate(String fromCode, String toCode) {
    final fromCurrency = getCurrencyByCode(fromCode);
    final toCurrency = getCurrencyByCode(toCode);
    
    if (fromCurrency == null || toCurrency == null) return 0.0;
    
    return toCurrency.exchangeRate / fromCurrency.exchangeRate;
  }

  static double calculateFees(double amount, String fromCode, String toCode) {
    // Simple fee calculation: 1% of amount with minimum $2 and maximum $50
    final feePercentage = 0.01;
    final fee = amount * feePercentage;
    const minFee = 2.0;
    const maxFee = 50.0;
    
    return fee.clamp(minFee, maxFee);
  }
} 