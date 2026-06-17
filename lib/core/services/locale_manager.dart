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
      // Unsupported country code — derive locale as en-XX, reset currency to default
      _localeController.add('en-${countryCode.toUpperCase()}');
      _countryController.add(countryCode.toUpperCase());
      _currencyController.add(_defaultCurrency);
    }
  }

  /// Refresh the platform-supported-locales list from the backend.
  /// Backend is the source of truth; this swaps the runtime list in
  /// [CountryLocales] so existing call sites pick up new countries
  /// without code changes. Failures are silent — the previous list
  /// (or static fallback) stays in effect.
  ///
  /// Safe to call before login; the gRPC method is in the
  /// accounts-service public allowlist and returns the same list
  /// either way (the `userHasAccount` flags are not consumed here).
  ///
  /// We intentionally take a fetcher function rather than the
  /// repository type to keep this class free of feature-layer
  /// imports. The wiring in injection_container.dart bridges them.
  Future<void> refreshSupportedLocales(
    Future<List<({String locale, String countryCode, String countryName, String currencyCode, String flagEmoji, bool isActive})>> Function() fetch,
  ) async {
    try {
      final rows = await fetch();
      final next = <CountryLocale>[];
      for (final r in rows) {
        final c = CountryLocales.fromBackendLocale(
          locale: r.locale,
          countryCode: r.countryCode,
          countryName: r.countryName,
          currencyCode: r.currencyCode,
          flagEmoji: r.flagEmoji,
          isActive: r.isActive,
        );
        if (c != null) next.add(c);
      }
      if (next.isNotEmpty) {
        CountryLocales.replace(next);
      }
    } catch (_) {
      // Silent: keep current runtime list (or static fallback).
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

/// Platform-supported country locales.
///
/// Backend is the source of truth — call [CountryLocales.refreshFromBackend]
/// at app boot to pull the live list from
/// `accounts.MultiCountryAccountService/GetSupportedLocales`. The static
/// [_fallback] list below mirrors backend `config/locales.go` and is used
/// when the backend call hasn't completed (cold start / offline). After a
/// successful refresh, [all] returns the backend-driven list.
class CountryLocales {
  static List<CountryLocale>? _runtime;

  /// Current supported locales. Returns the backend-driven list after
  /// [refreshFromBackend] has succeeded; otherwise the offline fallback.
  /// Existing callers (`CountryLocales.all`) keep working untouched.
  static List<CountryLocale> get all => _runtime ?? _fallback;

  /// Replace the supported-locale list with one fetched from the backend.
  /// Pass an empty list to revert to the fallback. The caller is
  /// responsible for converting from `SupportedLocaleEntity` (proto shape).
  static void replace(List<CountryLocale> next) {
    if (next.isEmpty) {
      _runtime = null;
      return;
    }
    _runtime = List.unmodifiable(next);
  }

  /// Offline fallback. Mirrors backend config/locales.go::SupportedLocales().
  /// Used only when the backend hasn't been reached yet.
  static const List<CountryLocale> _fallback = [
    // Nigeria (Primary supported country)
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
    // Ghana
    CountryLocale(
      countryCode: 'GH',
      countryName: 'Ghana',
      languageCode: 'en',
      locale: 'en-GH',
      flag: '🇬🇭',
      dialCode: '+233',
      currency: 'GHS',
    ),
    // Kenya
    CountryLocale(
      countryCode: 'KE',
      countryName: 'Kenya',
      languageCode: 'en',
      locale: 'en-KE',
      flag: '🇰🇪',
      dialCode: '+254',
      currency: 'KES',
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

  /// Build a CountryLocale from a backend SupportedLocale proto entry,
  /// preserving the static fallback's dialCode (the backend doesn't
  /// publish dial codes yet). Returns null when the backend marks the
  /// locale inactive so callers don't render unavailable countries.
  static CountryLocale? fromBackendLocale({
    required String locale,
    required String countryCode,
    required String countryName,
    required String currencyCode,
    required String flagEmoji,
    required bool isActive,
  }) {
    if (!isActive) return null;
    // dial codes aren't on the backend yet — fall back to the static
    // mapping when the country is known, otherwise omit.
    String dialCode = '';
    for (final c in _fallback) {
      if (c.countryCode.toUpperCase() == countryCode.toUpperCase()) {
        dialCode = c.dialCode;
        break;
      }
    }
    return CountryLocale(
      countryCode: countryCode,
      countryName: countryName,
      languageCode: locale.split('-').first,
      locale: locale,
      flag: flagEmoji,
      dialCode: dialCode,
      currency: currencyCode,
    );
  }
}
