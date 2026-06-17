import 'package:equatable/equatable.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../../domain/entities/customer_validation_result.dart';

abstract class WaterBillState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WaterBillInitial extends WaterBillState {}

class WaterBillLoading extends WaterBillState {}

// Provider States
class ProvidersLoaded extends WaterBillState {
  final List<WaterProviderEntity> providers;

  ProvidersLoaded({required this.providers});

  @override
  List<Object?> get props => [providers];
}

class ProvidersSyncing extends WaterBillState {}

class ProvidersSynced extends WaterBillState {
  final String message;

  ProvidersSynced({this.message = 'Providers synced successfully'});

  @override
  List<Object?> get props => [message];
}

// Customer Validation States
class CustomerValidating extends WaterBillState {}

class CustomerValidated extends WaterBillState {
  final CustomerValidationResult validationResult;
  final String providerCode;
  final String customerNumber;

  CustomerValidated({
    required this.validationResult,
    required this.providerCode,
    required this.customerNumber,
  });

  @override
  List<Object?> get props => [validationResult, providerCode, customerNumber];
}

class CustomerValidationFailed extends WaterBillState {
  final String message;

  CustomerValidationFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// Payment States
class PaymentInitiating extends WaterBillState {}

class PaymentInitiated extends WaterBillState {
  final WaterPaymentEntity payment;

  PaymentInitiated({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentProcessing extends WaterBillState {
  final WaterPaymentEntity payment;
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
    WaterPaymentEntity? payment,
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

class PaymentSuccess extends WaterBillState {
  final WaterPaymentEntity payment;

  PaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentFailed extends WaterBillState {
  final WaterPaymentEntity payment;
  final String errorMessage;

  PaymentFailed({required this.payment, required this.errorMessage});

  @override
  List<Object?> get props => [payment, errorMessage];
}

class PaymentVerifying extends WaterBillState {}

class PaymentVerified extends WaterBillState {
  final WaterPaymentEntity payment;

  PaymentVerified({required this.payment});

  @override
  List<Object?> get props => [payment];
}

// Payment History States
class PaymentHistoryLoading extends WaterBillState {}

class PaymentHistoryLoaded extends WaterBillState {
  final List<WaterPaymentEntity> payments;

  PaymentHistoryLoaded({required this.payments});

  @override
  List<Object?> get props => [payments];
}

// Receipt States
class ReceiptLoading extends WaterBillState {}

class ReceiptLoaded extends WaterBillState {
  final WaterPaymentEntity receipt;

  ReceiptLoaded({required this.receipt});

  @override
  List<Object?> get props => [receipt];
}

// Error State
class WaterBillError extends WaterBillState {
  final String message;

  WaterBillError({required this.message});

  @override
  List<Object?> get props => [message];
}
