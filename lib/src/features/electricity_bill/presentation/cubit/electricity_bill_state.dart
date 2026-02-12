import 'package:equatable/equatable.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';

abstract class ElectricityBillState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ElectricityBillInitial extends ElectricityBillState {}

class ElectricityBillLoading extends ElectricityBillState {}

// Provider States
class ProvidersLoaded extends ElectricityBillState {
  final List<ElectricityProviderEntity> providers;
  final bool isStale;

  ProvidersLoaded({required this.providers, this.isStale = false});

  @override
  List<Object?> get props => [providers, isStale];
}

class ProvidersSyncing extends ElectricityBillState {}

class ProvidersSynced extends ElectricityBillState {
  final String message;

  ProvidersSynced({this.message = 'Providers synced successfully'});

  @override
  List<Object?> get props => [message];
}

// Meter Validation States
class MeterValidating extends ElectricityBillState {}

class MeterValidated extends ElectricityBillState {
  final MeterValidationResult validationResult;
  final String providerCode;
  final String meterNumber;
  final MeterType meterType;

  MeterValidated({
    required this.validationResult,
    required this.providerCode,
    required this.meterNumber,
    required this.meterType,
  });

  @override
  List<Object?> get props => [validationResult, providerCode, meterNumber, meterType];
}

class MeterValidationFailed extends ElectricityBillState {
  final String message;

  MeterValidationFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// Smart Meter Validation States
class SmartMeterValidating extends ElectricityBillState {}

class SmartMeterValidated extends ElectricityBillState {
  final SmartMeterValidationResult result;

  SmartMeterValidated({required this.result});

  @override
  List<Object?> get props => [result];
}

class SmartMeterValidationFailed extends ElectricityBillState {
  final String message;

  SmartMeterValidationFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// Payment States
class PaymentInitiating extends ElectricityBillState {}

class PaymentInitiated extends ElectricityBillState {
  final BillPaymentEntity payment;

  PaymentInitiated({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentProcessing extends ElectricityBillState {
  final BillPaymentEntity payment;
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
    BillPaymentEntity? payment,
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

class PaymentSuccess extends ElectricityBillState {
  final BillPaymentEntity payment;

  PaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentFailed extends ElectricityBillState {
  final BillPaymentEntity payment;
  final String errorMessage;

  PaymentFailed({required this.payment, required this.errorMessage});

  @override
  List<Object?> get props => [payment, errorMessage];
}

class PaymentVerifying extends ElectricityBillState {}

class PaymentVerified extends ElectricityBillState {
  final BillPaymentEntity payment;

  PaymentVerified({required this.payment});

  @override
  List<Object?> get props => [payment];
}

// Payment History States
class PaymentHistoryLoading extends ElectricityBillState {}

class PaymentHistoryLoaded extends ElectricityBillState {
  final List<BillPaymentEntity> payments;

  PaymentHistoryLoaded({required this.payments});

  @override
  List<Object?> get props => [payments];
}

// Receipt States
class ReceiptLoading extends ElectricityBillState {}

class ReceiptLoaded extends ElectricityBillState {
  final BillPaymentEntity receipt;

  ReceiptLoaded({required this.receipt});

  @override
  List<Object?> get props => [receipt];
}

// Error State
class ElectricityBillError extends ElectricityBillState {
  final String message;

  ElectricityBillError({required this.message});

  @override
  List<Object?> get props => [message];
}
