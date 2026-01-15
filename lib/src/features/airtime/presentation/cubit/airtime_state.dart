import 'package:equatable/equatable.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';

abstract class AirtimeState extends Equatable {
  const AirtimeState();

  @override
  List<Object?> get props => [];
}

class AirtimeInitial extends AirtimeState {}

class AirtimeLoading extends AirtimeState {}

// Country states
class AirtimeCountriesLoading extends AirtimeState {}

class AirtimeCountriesLoaded extends AirtimeState {
  final List<Country> countries;

  const AirtimeCountriesLoaded({required this.countries});

  @override
  List<Object?> get props => [countries];
}

class AirtimeCountriesError extends AirtimeState {
  final String message;

  const AirtimeCountriesError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Network provider states
class AirtimeNetworkProvidersLoading extends AirtimeState {}

class AirtimeNetworkProvidersLoaded extends AirtimeState {
  final List<NetworkProvider> providers;
  final String countryCode;

  const AirtimeNetworkProvidersLoaded({
    required this.providers,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [providers, countryCode];
}

class AirtimeNetworkProvidersError extends AirtimeState {
  final String message;

  const AirtimeNetworkProvidersError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Phone number validation states
class AirtimePhoneNumberValidating extends AirtimeState {}

class AirtimePhoneNumberValidated extends AirtimeState {
  final bool isValid;
  final String? error;
  final String cleanNumber;
  final NetworkProvider? detectedProvider;
  final String formattedNumber;

  const AirtimePhoneNumberValidated({
    required this.isValid,
    this.error,
    required this.cleanNumber,
    this.detectedProvider,
    required this.formattedNumber,
  });

  @override
  List<Object?> get props => [isValid, error, cleanNumber, detectedProvider, formattedNumber];
}

// Transaction review states
class AirtimeTransactionReviewReady extends AirtimeState {
  final Country country;
  final NetworkProvider provider;
  final String phoneNumber;
  final String recipientName;
  final double amount;
  final double fee;
  final double totalAmount;

  const AirtimeTransactionReviewReady({
    required this.country,
    required this.provider,
    required this.phoneNumber,
    required this.recipientName,
    required this.amount,
    required this.fee,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [country, provider, phoneNumber, recipientName, amount, fee, totalAmount];
}

// Payment states
class AirtimePaymentProcessing extends AirtimeState {
  final AirtimeTransaction transaction;
  final double progress; // 0.0 to 1.0
  final String currentStep;

  const AirtimePaymentProcessing({
    required this.transaction,
    this.progress = 0.1,
    this.currentStep = 'Initializing payment...',
  });

  AirtimePaymentProcessing copyWith({
    AirtimeTransaction? transaction,
    double? progress,
    String? currentStep,
  }) {
    return AirtimePaymentProcessing(
      transaction: transaction ?? this.transaction,
      progress: progress ?? this.progress,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [transaction, progress, currentStep];
}

class AirtimePaymentSuccess extends AirtimeState {
  final AirtimeTransaction transaction;

  const AirtimePaymentSuccess({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class AirtimePaymentFailed extends AirtimeState {
  final String message;
  final AirtimeTransaction? transaction;

  const AirtimePaymentFailed({
    required this.message,
    this.transaction,
  });

  @override
  List<Object?> get props => [message, transaction];
}

// Transaction history states
class AirtimeTransactionHistoryLoading extends AirtimeState {}

class AirtimeTransactionHistoryLoaded extends AirtimeState {
  final List<AirtimeTransaction> transactions;
  final Map<String, dynamic>? statistics;

  const AirtimeTransactionHistoryLoaded({
    required this.transactions,
    this.statistics,
  });

  @override
  List<Object?> get props => [transactions, statistics];
}

// Transaction details states
class AirtimeTransactionDetailsLoading extends AirtimeState {}

class AirtimeTransactionDetailsLoaded extends AirtimeState {
  final AirtimeTransaction transaction;

  const AirtimeTransactionDetailsLoaded({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

// Error state
class AirtimeError extends AirtimeState {
  final String message;
  final String? errorCode;

  const AirtimeError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
} 