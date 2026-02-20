import '../domain/entities/locale_account_group.dart';

sealed class MultiCountryState {}

class MultiCountryInitial extends MultiCountryState {}

class MultiCountryLoading extends MultiCountryState {}

class MultiCountryLoaded extends MultiCountryState {
  final List<LocaleAccountGroupEntity> locales;
  final String activeLocale;
  final String signupLocale;

  MultiCountryLoaded({
    required this.locales,
    required this.activeLocale,
    required this.signupLocale,
  });

  /// Get the locale group for a given country code
  LocaleAccountGroupEntity? groupForCountry(String countryCode) {
    try {
      return locales.firstWhere((g) => g.countryCode == countryCode);
    } catch (_) {
      return null;
    }
  }
}

class MultiCountryError extends MultiCountryState {
  final String message;
  MultiCountryError(this.message);
}

class LocaleAccountCreating extends MultiCountryState {
  final String locale;
  LocaleAccountCreating(this.locale);
}

class LocaleAccountCreated extends MultiCountryState {
  final LocaleAccountEntity account;
  final String message;
  LocaleAccountCreated({required this.account, required this.message});
}

class LocaleAccountCreateError extends MultiCountryState {
  final String message;
  LocaleAccountCreateError(this.message);
}
