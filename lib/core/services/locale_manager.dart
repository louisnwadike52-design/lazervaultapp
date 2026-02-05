import 'dart:async';
import 'package:rxdart/rxdart.dart';

/// Centralized locale manager that maintains app-wide locale state
/// and notifies all listeners when locale changes.
///
/// Locale format: BCP 47 standard (e.g., "en-NG", "en-US", "en-GB", "en-ZA")
///
/// Purely in-memory — no persistence. On each login, reset to registration
/// country via [resetToCountry]. Country change auto-derives currency from
/// [CountryLocales] lookup.
class LocaleManager {
  static const String _defaultLocale = 'en-NG';
  static const String _defaultCountry = 'NG';
  static const String _defaultCurrency = 'NGN';

  // Stream controller for reactive locale updates
  final _localeController = BehaviorSubject<String>.seeded(_defaultLocale);
  final _countryController = BehaviorSubject<String>.seeded(_defaultCountry);
  final _currencyController = BehaviorSubject<String>.seeded(_defaultCurrency);

  LocaleManager();

  /// Get current locale (e.g., "en-US", "en-GB")
  String get currentLocale => _localeController.value;

  /// Get current country code (e.g., "US", "GB", "ZA")
  String get currentCountry => _countryController.value;

  /// Get current currency code (e.g., "USD", "GBP", "EUR")
  String get currentCurrency => _currencyController.value;

  /// Stream of locale changes for reactive UI updates
  Stream<String> get localeStream => _localeController.stream;

  /// Stream of country changes for reactive UI updates
  Stream<String> get countryStream => _countryController.stream;

  /// Stream of currency changes for reactive UI updates
  Stream<String> get currencyStream => _currencyController.stream;

  /// Update both locale and country atomically, auto-deriving currency
  ///
  /// Example: updateLocale(locale: "en-GB", country: "GB")
  void updateLocale({
    required String locale,
    required String country,
  }) {
    if (!_isValidLocaleFormat(locale)) {
      throw ArgumentError('Invalid locale format: $locale. Expected format: en-US');
    }

    _localeController.add(locale);
    _countryController.add(country);

    // Auto-derive currency from country
    final countryLocale = CountryLocales.findByCountryCode(country);
    if (countryLocale != null) {
      _currencyController.add(countryLocale.currency);
    }
  }

  /// Update currency in-memory
  ///
  /// Example: setCurrency("GBP")
  void setCurrency(String currencyCode) {
    if (!_isValidCurrencyFormat(currencyCode)) {
      throw ArgumentError('Invalid currency format: $currencyCode. Expected format: USD, GBP, EUR');
    }
    _currencyController.add(currencyCode);
  }

  /// Update currency from server sync (internal method)
  void setCurrencyFromServerSync(String currencyCode) {
    _currencyController.add(currencyCode);
  }

  /// Update country only (derives locale from language + country)
  ///
  /// Example: setCountry("GB") -> "en-GB" if current language is "en"
  void setCountry(String countryCode) {
    final currentLocale = _localeController.value;
    final languageCode = currentLocale.split('-').first;
    final newLocale = '$languageCode-${countryCode.toUpperCase()}';
    updateLocale(locale: newLocale, country: countryCode.toUpperCase());
  }

  /// Update language only (keeps current country)
  ///
  /// Example: setLanguage("fr") -> "fr-US" if current country is "US"
  void setLanguage(String languageCode) {
    final currentCountry = _countryController.value;
    final newLocale = '$languageCode-$currentCountry';
    updateLocale(locale: newLocale, country: currentCountry);
  }

  /// Get the language part of the locale (e.g., "en" from "en-US")
  String get currentLanguage {
    return currentLocale.split('-').first;
  }

  /// Get Accept-Language header value for HTTP/gRPC requests
  ///
  /// Returns: locale in format "en-US" or "en-GB"
  String getAcceptLanguageHeader() {
    return currentLocale;
  }

  /// Get locale metadata for gRPC calls
  ///
  /// Returns metadata in the format expected by backend microservices:
  /// - x-locale: Full locale string (e.g., "en-US", "en-NG")
  Map<String, String> getLocaleMetadata() {
    return {
      'x-locale': currentLocale,
    };
  }

  /// Basic validation for locale format
  bool _isValidLocaleFormat(String locale) {
    // Basic check: should be in format "xx-XX" or "xxx-XX"
    final parts = locale.split('-');
    return parts.length == 2 &&
           parts[0].length >= 2 &&
           parts[1].length == 2;
  }

  /// Basic validation for currency format (ISO 4217)
  bool _isValidCurrencyFormat(String currency) {
    // Basic check: should be 3 uppercase letters
    return RegExp(r'^[A-Z]{3}$').hasMatch(currency);
  }

  /// Reset to default locale and currency
  void resetToDefault() {
    updateLocale(locale: _defaultLocale, country: _defaultCountry);
    setCurrency(_defaultCurrency);
  }

  /// Reset locale, country, and currency based on a country code.
  /// Used on login to set state from the user's registration country.
  void resetToCountry(String countryCode) {
    final countryLocale = CountryLocales.findByCountryCode(countryCode);
    if (countryLocale != null) {
      _localeController.add(countryLocale.locale);
      _countryController.add(countryLocale.countryCode);
      _currencyController.add(countryLocale.currency);
    } else {
      // Fallback: derive locale as en-XX, currency stays default
      _localeController.add('en-${countryCode.toUpperCase()}');
      _countryController.add(countryCode.toUpperCase());
    }
  }

  /// Clean up resources
  void dispose() {
    _localeController.close();
    _countryController.close();
    _currencyController.close();
  }
}

/// Country data model for UI selection
class CountryLocale {
  final String countryCode;      // "US", "GB", "ZA"
  final String countryName;      // "United States", "United Kingdom"
  final String languageCode;     // "en", "fr", "de"
  final String locale;           // "en-US", "en-GB", "fr-FR"
  final String flag;             // Emoji flag "🇺🇸" or asset path
  final String dialCode;         // "+1", "+44", "+27"
  final String currency;         // "USD", "GBP", "ZAR"

  const CountryLocale({
    required this.countryCode,
    required this.countryName,
    required this.languageCode,
    required this.locale,
    required this.flag,
    required this.dialCode,
    required this.currency,
  });

  String get displayName => '$flag $countryName';
  String get localeDisplay => '$countryName ($locale)';
  String get currencyDisplay => '$currency ($countryCode)';
}

/// Pre-defined country locales - only includes countries available during signup
///
/// IMPORTANT: This list must match the countries in SelectCountry widget exactly.
/// When adding/removing countries here, update SelectCountry too.
class CountryLocales {
  /// Supported countries - matches the signup flow country selection
  static const List<CountryLocale> all = [
    // Nigeria (Primary supported country - first in signup list)
    CountryLocale(
      countryCode: 'NG',
      countryName: 'Nigeria',
      languageCode: 'en',
      locale: 'en-NG',
      flag: '🇳🇬',
      dialCode: '+234',
      currency: 'NGN',
    ),
    // United States
    CountryLocale(
      countryCode: 'US',
      countryName: 'United States',
      languageCode: 'en',
      locale: 'en-US',
      flag: '🇺🇸',
      dialCode: '+1',
      currency: 'USD',
    ),
    // United Kingdom
    CountryLocale(
      countryCode: 'GB',
      countryName: 'United Kingdom',
      languageCode: 'en',
      locale: 'en-GB',
      flag: '🇬🇧',
      dialCode: '+44',
      currency: 'GBP',
    ),
    // Canada
    CountryLocale(
      countryCode: 'CA',
      countryName: 'Canada',
      languageCode: 'en',
      locale: 'en-CA',
      flag: '🇨🇦',
      dialCode: '+1',
      currency: 'CAD',
    ),
    // India
    CountryLocale(
      countryCode: 'IN',
      countryName: 'India',
      languageCode: 'en',
      locale: 'en-IN',
      flag: '🇮🇳',
      dialCode: '+91',
      currency: 'INR',
    ),
    // Germany
    CountryLocale(
      countryCode: 'DE',
      countryName: 'Germany',
      languageCode: 'de',
      locale: 'de-DE',
      flag: '🇩🇪',
      dialCode: '+49',
      currency: 'EUR',
    ),
    // France
    CountryLocale(
      countryCode: 'FR',
      countryName: 'France',
      languageCode: 'fr',
      locale: 'fr-FR',
      flag: '🇫🇷',
      dialCode: '+33',
      currency: 'EUR',
    ),
    // South Africa
    CountryLocale(
      countryCode: 'ZA',
      countryName: 'South Africa',
      languageCode: 'en',
      locale: 'en-ZA',
      flag: '🇿🇦',
      dialCode: '+27',
      currency: 'ZAR',
    ),
    // Australia
    CountryLocale(
      countryCode: 'AU',
      countryName: 'Australia',
      languageCode: 'en',
      locale: 'en-AU',
      flag: '🇦🇺',
      dialCode: '+61',
      currency: 'AUD',
    ),
    // Japan
    CountryLocale(
      countryCode: 'JP',
      countryName: 'Japan',
      languageCode: 'ja',
      locale: 'ja-JP',
      flag: '🇯🇵',
      dialCode: '+81',
      currency: 'JPY',
    ),
  ];

  /// Find country locale by country code
  static CountryLocale? findByCountryCode(String code) {
    try {
      return all.firstWhere(
        (c) => c.countryCode.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Search countries by name, code, or locale
  static List<CountryLocale> search(String query) {
    if (query.isEmpty) return all;

    final lowerQuery = query.toLowerCase();
    return all.where((country) {
      return country.countryName.toLowerCase().contains(lowerQuery) ||
             country.countryCode.toLowerCase().contains(lowerQuery) ||
             country.locale.toLowerCase().contains(lowerQuery) ||
             country.dialCode.contains(query);
    }).toList();
  }
}
