import 'package:equatable/equatable.dart';
import '../../domain/entities/airtime_auto_recharge.dart';
import '../../domain/entities/airtime_beneficiary.dart';
import '../../domain/entities/airtime_reminder.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';

// Re-exports so screens and the dedicated reminder cubit can import the
// sealed state space and the entity types in one shot.
export '../../domain/entities/airtime_auto_recharge.dart';
export '../../domain/entities/airtime_beneficiary.dart';
export '../../domain/entities/airtime_reminder.dart';

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
  final bool isStale;

  const AirtimeNetworkProvidersLoaded({
    required this.providers,
    required this.countryCode,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [providers, countryCode, isStale];
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

// Airtime Transfer states
class AirtimeTransferProcessing extends AirtimeState {
  final AirtimeTransaction transaction;
  final double progress;
  final String currentStep;

  const AirtimeTransferProcessing({
    required this.transaction,
    this.progress = 0.1,
    this.currentStep = 'Initializing transfer...',
  });

  @override
  List<Object?> get props => [transaction, progress, currentStep];
}

class AirtimeTransferSuccess extends AirtimeState {
  final AirtimeTransaction transaction;

  const AirtimeTransferSuccess({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class AirtimeTransferFailed extends AirtimeState {
  final String message;
  final AirtimeTransaction? transaction;

  const AirtimeTransferFailed({
    required this.message,
    this.transaction,
  });

  @override
  List<Object?> get props => [message, transaction];
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

// ===================== Beneficiary states =====================
class AirtimeBeneficiariesLoading extends AirtimeState {}

class AirtimeBeneficiariesLoaded extends AirtimeState {
  final List<AirtimeBeneficiary> beneficiaries;

  const AirtimeBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class AirtimeBeneficiariesError extends AirtimeState {
  final String message;

  const AirtimeBeneficiariesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AirtimeBeneficiarySaved extends AirtimeState {
  final AirtimeBeneficiary beneficiary;

  const AirtimeBeneficiarySaved({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class AirtimeBeneficiaryUpdated extends AirtimeState {
  final AirtimeBeneficiary beneficiary;

  const AirtimeBeneficiaryUpdated({required this.beneficiary});

  @override
  List<Object?> get props => [beneficiary];
}

class AirtimeBeneficiaryDeleted extends AirtimeState {
  final String id;

  const AirtimeBeneficiaryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

// ===================== Auto-recharge states =====================
class AirtimeAutoRechargesLoading extends AirtimeState {}

class AirtimeAutoRechargesLoaded extends AirtimeState {
  final List<AirtimeAutoRecharge> autoRecharges;

  const AirtimeAutoRechargesLoaded({required this.autoRecharges});

  @override
  List<Object?> get props => [autoRecharges];
}

class AirtimeAutoRechargesError extends AirtimeState {
  final String message;

  const AirtimeAutoRechargesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AirtimeAutoRechargeCreated extends AirtimeState {
  final AirtimeAutoRecharge autoRecharge;

  const AirtimeAutoRechargeCreated({required this.autoRecharge});

  @override
  List<Object?> get props => [autoRecharge];
}

class AirtimeAutoRechargeUpdated extends AirtimeState {
  final AirtimeAutoRecharge autoRecharge;

  const AirtimeAutoRechargeUpdated({required this.autoRecharge});

  @override
  List<Object?> get props => [autoRecharge];
}

/// A pause / resume flipped the status on a single auto-recharge.
/// Carries the id + new status so the screen can patch the affected
/// row in place without a full list re-fetch.
class AirtimeAutoRechargeStatusChanged extends AirtimeState {
  final String id;
  final String status; // 'paused' or 'active'
  const AirtimeAutoRechargeStatusChanged({
    required this.id,
    required this.status,
  });
  @override
  List<Object?> get props => [id, status];
}

class AirtimeAutoRechargeDeleted extends AirtimeState {
  final String id;

  const AirtimeAutoRechargeDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}
