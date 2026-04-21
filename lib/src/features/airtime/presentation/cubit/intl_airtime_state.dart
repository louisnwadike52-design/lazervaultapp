import 'package:equatable/equatable.dart';

import '../../domain/entities/intl_airtime_country.dart';
import '../../domain/entities/intl_airtime_operator.dart';

sealed class IntlAirtimeState extends Equatable {
  const IntlAirtimeState();

  @override
  List<Object?> get props => [];
}

class IntlAirtimeInitial extends IntlAirtimeState {
  const IntlAirtimeInitial();
}

class IntlAirtimeLoading extends IntlAirtimeState {
  const IntlAirtimeLoading();
}

/// Countries list loaded successfully.
class IntlAirtimeCountriesLoaded extends IntlAirtimeState {
  final List<IntlAirtimeCountry> countries;

  const IntlAirtimeCountriesLoaded({required this.countries});

  @override
  List<Object?> get props => [countries];
}

/// Operators loaded for a specific country.
class IntlAirtimeOperatorsLoaded extends IntlAirtimeState {
  final List<IntlAirtimeOperator> operators;
  final IntlAirtimeCountry country;
  final String countryName;
  final String currencyCode;
  final String currencySymbol;

  const IntlAirtimeOperatorsLoaded({
    required this.operators,
    required this.country,
    required this.countryName,
    required this.currencyCode,
    required this.currencySymbol,
  });

  @override
  List<Object?> get props => [
        operators,
        country,
        countryName,
        currencyCode,
        currencySymbol,
      ];
}

/// A single operator was auto-detected from the recipient phone number.
class IntlAirtimeOperatorDetected extends IntlAirtimeState {
  final IntlAirtimeOperator operator;

  const IntlAirtimeOperatorDetected({required this.operator});

  @override
  List<Object?> get props => [operator];
}

/// Purchase submission in progress.
class IntlAirtimePurchasing extends IntlAirtimeState {
  const IntlAirtimePurchasing();
}

/// Purchase completed successfully.
class IntlAirtimePurchaseSuccess extends IntlAirtimeState {
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

  const IntlAirtimePurchaseSuccess({
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
  });

  @override
  List<Object?> get props => [
        paymentId,
        reference,
        status,
        amountPaid,
        senderCurrency,
        deliveredAmount,
        deliveredCurrency,
        fxRateUsed,
        operatorName,
        countryName,
        phoneNumber,
      ];
}

/// An error occurred during any intl airtime operation.
class IntlAirtimeError extends IntlAirtimeState {
  final String message;

  const IntlAirtimeError({required this.message});

  @override
  List<Object?> get props => [message];
}
