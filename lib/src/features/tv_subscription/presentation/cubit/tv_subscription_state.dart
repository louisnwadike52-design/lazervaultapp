import 'package:equatable/equatable.dart';
import '../../domain/entities/tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/smartcard_validation_result.dart';
import '../../domain/entities/tv_payment_entity.dart';

abstract class TVSubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TVSubscriptionInitial extends TVSubscriptionState {}

class TVSubscriptionLoading extends TVSubscriptionState {}

// Provider States
class ProvidersLoaded extends TVSubscriptionState {
  final List<TVProviderEntity> providers;

  ProvidersLoaded({required this.providers});

  @override
  List<Object?> get props => [providers];
}

class ProvidersSyncing extends TVSubscriptionState {}

class ProvidersSynced extends TVSubscriptionState {
  final String message;

  ProvidersSynced({this.message = 'Providers synced successfully'});

  @override
  List<Object?> get props => [message];
}

// Package States
class PackagesLoading extends TVSubscriptionState {}

class PackagesLoaded extends TVSubscriptionState {
  final List<TVPackageEntity> packages;

  PackagesLoaded({required this.packages});

  @override
  List<Object?> get props => [packages];
}

// Smartcard Validation States
class SmartcardValidating extends TVSubscriptionState {}

class SmartcardValidated extends TVSubscriptionState {
  final SmartcardValidationResult validationResult;
  final String providerCode;
  final String smartcardNumber;

  SmartcardValidated({
    required this.validationResult,
    required this.providerCode,
    required this.smartcardNumber,
  });

  @override
  List<Object?> get props => [validationResult, providerCode, smartcardNumber];
}

class SmartcardValidationFailed extends TVSubscriptionState {
  final String message;

  SmartcardValidationFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// Payment States
class PaymentInitiating extends TVSubscriptionState {}

class PaymentInitiated extends TVSubscriptionState {
  final TVPaymentEntity payment;

  PaymentInitiated({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentProcessing extends TVSubscriptionState {
  final TVPaymentEntity payment;
  final String message;
  final double progress; // 0.0 to 1.0
  final String currentStep;

  PaymentProcessing({
    required this.payment,
    this.message = 'Processing your payment...',
    this.progress = 0.1,
    this.currentStep = 'Initializing payment...',
  });

  PaymentProcessing copyWith({
    TVPaymentEntity? payment,
    String? message,
    double? progress,
    String? currentStep,
  }) {
    return PaymentProcessing(
      payment: payment ?? this.payment,
      message: message ?? this.message,
      progress: progress ?? this.progress,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [payment, message, progress, currentStep];
}

class PaymentSuccess extends TVSubscriptionState {
  final TVPaymentEntity payment;

  PaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentFailed extends TVSubscriptionState {
  final TVPaymentEntity payment;
  final String errorMessage;

  PaymentFailed({required this.payment, required this.errorMessage});

  @override
  List<Object?> get props => [payment, errorMessage];
}

class PaymentVerifying extends TVSubscriptionState {}

class PaymentVerified extends TVSubscriptionState {
  final TVPaymentEntity payment;

  PaymentVerified({required this.payment});

  @override
  List<Object?> get props => [payment];
}

// Payment History States
class PaymentHistoryLoading extends TVSubscriptionState {}

class PaymentHistoryLoaded extends TVSubscriptionState {
  final List<TVPaymentEntity> payments;

  PaymentHistoryLoaded({required this.payments});

  @override
  List<Object?> get props => [payments];
}

// Receipt States
class ReceiptLoading extends TVSubscriptionState {}

class ReceiptLoaded extends TVSubscriptionState {
  final TVPaymentEntity receipt;

  ReceiptLoaded({required this.receipt});

  @override
  List<Object?> get props => [receipt];
}

// Error State
class TVSubscriptionError extends TVSubscriptionState {
  final String message;

  TVSubscriptionError({required this.message});

  @override
  List<Object?> get props => [message];
}
