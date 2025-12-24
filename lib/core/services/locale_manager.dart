import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

/// Centralized locale manager that maintains app-wide locale state
/// and notifies all listeners when locale changes.
///
/// Locale format: BCP 47 standard (e.g., "en-US", "en-GB", "fr-FR", "en-ZA")
class LocaleManager {
  static const String _localeKey = 'app_locale';
  static const String _countryKey = 'app_country';
  static const String _defaultLocale = 'en-US';
  static const String _defaultCountry = 'US';

  final FlutterSecureStorage _storage;

  // Stream controller for reactive locale updates
  final _localeController = BehaviorSubject<String>.seeded(_defaultLocale);
  final _countryController = BehaviorSubject<String>.seeded(_defaultCountry);

  LocaleManager(this._storage) {
    _initializeLocale();
  }

  /// Initialize locale from storage
  Future<void> _initializeLocale() async {
    try {
      final storedLocale = await _storage.read(key: _localeKey);
      final storedCountry = await _storage.read(key: _countryKey);

      if (storedLocale != null && storedLocale.isNotEmpty) {
        _localeController.add(storedLocale);
      }

      if (storedCountry != null && storedCountry.isNotEmpty) {
        _countryController.add(storedCountry);
      }
    } catch (e) {
      // If storage fails, use default values
      _localeController.add(_defaultLocale);
      _countryController.add(_defaultCountry);
    }
  }

  /// Get current locale (e.g., "en-US", "en-GB")
  String get currentLocale => _localeController.value;

  /// Get current country code (e.g., "US", "GB", "ZA")
  String get currentCountry => _countryController.value;

  /// Stream of locale changes for reactive UI updates
  Stream<String> get localeStream => _localeController.stream;

  /// Stream of country changes for reactive UI updates
  Stream<String> get countryStream => _countryController.stream;

  /// Update both locale and country atomically
  ///
  /// Example: updateLocale(locale: "en-GB", country: "GB")
  Future<void> updateLocale({
    required String locale,
    required String country,
  }) async {
    try {
      // Validate format (basic check)
      if (!_isValidLocaleFormat(locale)) {
        throw ArgumentError('Invalid locale format: $locale. Expected format: en-US');
      }

      // Save to storage
      await Future.wait([
        _storage.write(key: _localeKey, value: locale),
        _storage.write(key: _countryKey, value: country),
      ]);

      // Notify listeners
      _localeController.add(locale);
      _countryController.add(country);
    } catch (e) {
      rethrow;
    }
  }

  /// Update country only (derives locale from language + country)
  ///
  /// Example: setCountry("GB") -> "en-GB" if current language is "en"
  Future<void> setCountry(String countryCode) async {
    try {
      final currentLocale = _localeController.value;
      final languageCode = currentLocale.split('-').first; // Extract language part

      final newLocale = '$languageCode-${countryCode.toUpperCase()}';

      await updateLocale(locale: newLocale, country: countryCode.toUpperCase());
    } catch (e) {
      rethrow;
    }
  }

  /// Update language only (keeps current country)
  ///
  /// Example: setLanguage("fr") -> "fr-US" if current country is "US"
  Future<void> setLanguage(String languageCode) async {
    try {
      final currentCountry = _countryController.value;
      final newLocale = '$languageCode-$currentCountry';

      await updateLocale(locale: newLocale, country: currentCountry);
    } catch (e) {
      rethrow;
    }
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
  Map<String, String> getLocaleMetadata() {
    return {
      'accept-language': currentLocale,
      'x-country-code': currentCountry,
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

  /// Reset to default locale
  Future<void> resetToDefault() async {
    await updateLocale(locale: _defaultLocale, country: _defaultCountry);
  }

  /// Clean up resources
  void dispose() {
    _localeController.close();
    _countryController.close();
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

  const CountryLocale({
    required this.countryCode,
    required this.countryName,
    required this.languageCode,
    required this.locale,
    required this.flag,
    required this.dialCode,
  });

  String get displayName => '$flag $countryName';
  String get localeDisplay => '$countryName ($locale)';
}

/// Pre-defined country locales for common countries
class CountryLocales {
  static const List<CountryLocale> all = [
    CountryLocale(
      countryCode: 'US',
      countryName: 'United States',
      languageCode: 'en',
      locale: 'en-US',
      flag: '🇺🇸',
      dialCode: '+1',
    ),
    CountryLocale(
      countryCode: 'GB',
      countryName: 'United Kingdom',
      languageCode: 'en',
      locale: 'en-GB',
      flag: '🇬🇧',
      dialCode: '+44',
    ),
    CountryLocale(
      countryCode: 'ZA',
      countryName: 'South Africa',
      languageCode: 'en',
      locale: 'en-ZA',
      flag: '🇿🇦',
      dialCode: '+27',
    ),
    CountryLocale(
      countryCode: 'NG',
      countryName: 'Nigeria',
      languageCode: 'en',
      locale: 'en-NG',
      flag: '🇳🇬',
      dialCode: '+234',
    ),
    CountryLocale(
      countryCode: 'CA',
      countryName: 'Canada',
      languageCode: 'en',
      locale: 'en-CA',
      flag: '🇨🇦',
      dialCode: '+1',
    ),
    CountryLocale(
      countryCode: 'AU',
      countryName: 'Australia',
      languageCode: 'en',
      locale: 'en-AU',
      flag: '🇦🇺',
      dialCode: '+61',
    ),
    CountryLocale(
      countryCode: 'FR',
      countryName: 'France',
      languageCode: 'fr',
      locale: 'fr-FR',
      flag: '🇫🇷',
      dialCode: '+33',
    ),
    CountryLocale(
      countryCode: 'DE',
      countryName: 'Germany',
      languageCode: 'de',
      locale: 'de-DE',
      flag: '🇩🇪',
      dialCode: '+49',
    ),
    CountryLocale(
      countryCode: 'ES',
      countryName: 'Spain',
      languageCode: 'es',
      locale: 'es-ES',
      flag: '🇪🇸',
      dialCode: '+34',
    ),
    CountryLocale(
      countryCode: 'IT',
      countryName: 'Italy',
      languageCode: 'it',
      locale: 'it-IT',
      flag: '🇮🇹',
      dialCode: '+39',
    ),
    CountryLocale(
      countryCode: 'BR',
      countryName: 'Brazil',
      languageCode: 'pt',
      locale: 'pt-BR',
      flag: '🇧🇷',
      dialCode: '+55',
    ),
    CountryLocale(
      countryCode: 'MX',
      countryName: 'Mexico',
      languageCode: 'es',
      locale: 'es-MX',
      flag: '🇲🇽',
      dialCode: '+52',
    ),
    CountryLocale(
      countryCode: 'IN',
      countryName: 'India',
      languageCode: 'en',
      locale: 'en-IN',
      flag: '🇮🇳',
      dialCode: '+91',
    ),
    CountryLocale(
      countryCode: 'CN',
      countryName: 'China',
      languageCode: 'zh',
      locale: 'zh-CN',
      flag: '🇨🇳',
      dialCode: '+86',
    ),
    CountryLocale(
      countryCode: 'JP',
      countryName: 'Japan',
      languageCode: 'ja',
      locale: 'ja-JP',
      flag: '🇯🇵',
      dialCode: '+81',
    ),
    CountryLocale(
      countryCode: 'KR',
      countryName: 'South Korea',
      languageCode: 'ko',
      locale: 'ko-KR',
      flag: '🇰🇷',
      dialCode: '+82',
    ),
    CountryLocale(
      countryCode: 'RU',
      countryName: 'Russia',
      languageCode: 'ru',
      locale: 'ru-RU',
      flag: '🇷🇺',
      dialCode: '+7',
    ),
    CountryLocale(
      countryCode: 'AE',
      countryName: 'United Arab Emirates',
      languageCode: 'ar',
      locale: 'ar-AE',
      flag: '🇦🇪',
      dialCode: '+971',
    ),
    CountryLocale(
      countryCode: 'SA',
      countryName: 'Saudi Arabia',
      languageCode: 'ar',
      locale: 'ar-SA',
      flag: '🇸🇦',
      dialCode: '+966',
    ),
    CountryLocale(
      countryCode: 'EG',
      countryName: 'Egypt',
      languageCode: 'ar',
      locale: 'ar-EG',
      flag: '🇪🇬',
      dialCode: '+20',
    ),
    CountryLocale(
      countryCode: 'KE',
      countryName: 'Kenya',
      languageCode: 'en',
      locale: 'en-KE',
      flag: '🇰🇪',
      dialCode: '+254',
    ),
    CountryLocale(
      countryCode: 'GH',
      countryName: 'Ghana',
      languageCode: 'en',
      locale: 'en-GH',
      flag: '🇬🇭',
      dialCode: '+233',
    ),
    CountryLocale(
      countryCode: 'SG',
      countryName: 'Singapore',
      languageCode: 'en',
      locale: 'en-SG',
      flag: '🇸🇬',
      dialCode: '+65',
    ),
    CountryLocale(
      countryCode: 'PH',
      countryName: 'Philippines',
      languageCode: 'en',
      locale: 'en-PH',
      flag: '🇵🇭',
      dialCode: '+63',
    ),
    CountryLocale(
      countryCode: 'NL',
      countryName: 'Netherlands',
      languageCode: 'nl',
      locale: 'nl-NL',
      flag: '🇳🇱',
      dialCode: '+31',
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
