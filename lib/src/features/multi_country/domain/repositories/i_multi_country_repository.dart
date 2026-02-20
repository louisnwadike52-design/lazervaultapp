import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/locale_account_group.dart';

abstract class IMultiCountryRepository {
  /// Get all accounts grouped by locale
  Future<Either<Failure, ({
    List<LocaleAccountGroupEntity> locales,
    String activeLocale,
    String signupLocale,
  })>> getAccountsByLocale();

  /// Create an account for a specific locale
  Future<Either<Failure, LocaleAccountEntity>> createLocaleAccount({
    required String locale,
    String? accountType,
    String? accountName,
  });

  /// Get all supported locales
  Future<Either<Failure, List<SupportedLocaleEntity>>> getSupportedLocales();

  /// Get user's current locale preference
  Future<Either<Failure, ({String locale, String countryCode, String currencyCode, String signupLocale})>> getUserLocale();

  /// Set user's active locale
  Future<Either<Failure, String>> setUserLocale(String locale);

  /// Get account creation status
  Future<Either<Failure, ({String overallStatus, int totalLocales, int completedLocales})>> getAccountCreationStatus({String? jobId});
}
