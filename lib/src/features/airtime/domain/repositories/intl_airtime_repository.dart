import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/intl_airtime_country.dart';
import '../entities/intl_airtime_operator.dart';

/// Result returned by [IntlAirtimeRepository.getOperators].
class IntlAirtimeOperatorsResult {
  final List<IntlAirtimeOperator> operators;
  final String countryName;
  final String currencyCode;
  final String currencySymbol;

  const IntlAirtimeOperatorsResult({
    required this.operators,
    required this.countryName,
    required this.currencyCode,
    required this.currencySymbol,
  });
}

/// Result returned by [IntlAirtimeRepository.buyIntlAirtime].
class IntlAirtimePurchaseResult {
  final String paymentId;
  final String reference;
  final String status;
  final double amountPaid;
  final String senderCurrency;
  final double deliveredAmount;
  final String deliveredCurrency;
  final double fxRateUsed;
  final String operatorName;
  final String countryName;
  final String phoneNumber;
  final String message;
  final String createdAt;

  const IntlAirtimePurchaseResult({
    required this.paymentId,
    required this.reference,
    required this.status,
    required this.amountPaid,
    required this.senderCurrency,
    required this.deliveredAmount,
    required this.deliveredCurrency,
    required this.fxRateUsed,
    required this.operatorName,
    required this.countryName,
    required this.phoneNumber,
    this.message = '',
    this.createdAt = '',
  });
}

abstract class IntlAirtimeRepository {
  Future<Either<Failure, List<IntlAirtimeCountry>>> getCountries({
    bool includeInactive = false,
  });

  Future<Either<Failure, IntlAirtimeOperatorsResult>> getOperators(
      String countryCode);

  Future<Either<Failure, IntlAirtimeOperator>> autoDetectOperator(
      String phoneNumber, String countryCode);

  Future<Either<Failure, IntlAirtimePurchaseResult>> buyIntlAirtime({
    required String accountId,
    required String operatorId,
    required String countryCode,
    required String phoneNumber,
    required double amount,
    required String senderCurrency,
    bool useLocalAmount = false,
    double destAmount = 0,
    required String destCurrency,
    required double fxRateSnapshot,
    String variationCode = '',
    required String pin,
    required String idempotencyKey,
  });
}
