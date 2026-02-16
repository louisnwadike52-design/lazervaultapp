import 'package:equatable/equatable.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../domain/entities/internet_payment_entity.dart';

abstract class InternetBillState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InternetBillInitial extends InternetBillState {}

class InternetBillLoading extends InternetBillState {}

class InternetBillProvidersLoaded extends InternetBillState {
  final List<InternetProviderEntity> providers;

  InternetBillProvidersLoaded({required this.providers});

  @override
  List<Object?> get props => [providers];
}

class InternetAccountValidating extends InternetBillState {}

class InternetAccountValidated extends InternetBillState {
  final InternetAccountValidationEntity validation;
  final String providerId;
  final String accountNumber;

  InternetAccountValidated({
    required this.validation,
    required this.providerId,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [validation, providerId, accountNumber];
}

class InternetAccountValidationFailed extends InternetBillState {
  final String message;

  InternetAccountValidationFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class InternetPackagesLoaded extends InternetBillState {
  final List<InternetPackageEntity> packages;
  final String providerId;

  InternetPackagesLoaded({required this.packages, required this.providerId});

  @override
  List<Object?> get props => [packages, providerId];
}

class InternetBillPaymentProcessing extends InternetBillState {
  final double progress;
  final String currentStep;

  InternetBillPaymentProcessing({
    required this.progress,
    required this.currentStep,
  });

  @override
  List<Object?> get props => [progress, currentStep];
}

class InternetBillPaymentSuccess extends InternetBillState {
  final InternetPaymentEntity payment;

  InternetBillPaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class InternetBillPaymentFailed extends InternetBillState {
  final String message;

  InternetBillPaymentFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class InternetBillError extends InternetBillState {
  final String message;

  InternetBillError({required this.message});

  @override
  List<Object?> get props => [message];
}
