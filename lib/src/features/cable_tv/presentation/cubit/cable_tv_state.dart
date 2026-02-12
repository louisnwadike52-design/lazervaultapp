import 'package:equatable/equatable.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/smart_card_validation_entity.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';

abstract class CableTVState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CableTVInitial extends CableTVState {}

class CableTVLoading extends CableTVState {}

class CableTVProvidersLoaded extends CableTVState {
  final List<CableTVProviderEntity> providers;

  CableTVProvidersLoaded({required this.providers});

  @override
  List<Object?> get props => [providers];
}

class SmartCardValidating extends CableTVState {}

class SmartCardValidated extends CableTVState {
  final SmartCardValidationEntity validation;
  final String providerId;
  final String smartCardNumber;

  SmartCardValidated({
    required this.validation,
    required this.providerId,
    required this.smartCardNumber,
  });

  @override
  List<Object?> get props => [validation, providerId, smartCardNumber];
}

class SmartCardValidationFailed extends CableTVState {
  final String message;

  SmartCardValidationFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class TVPackagesLoaded extends CableTVState {
  final List<TVPackageEntity> packages;
  final String providerId;

  TVPackagesLoaded({required this.packages, required this.providerId});

  @override
  List<Object?> get props => [packages, providerId];
}

class CableTVPaymentProcessing extends CableTVState {
  final double progress;
  final String currentStep;

  CableTVPaymentProcessing({
    required this.progress,
    required this.currentStep,
  });

  @override
  List<Object?> get props => [progress, currentStep];
}

class CableTVPaymentSuccess extends CableTVState {
  final CableTVPaymentEntity payment;

  CableTVPaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class CableTVPaymentFailed extends CableTVState {
  final String message;

  CableTVPaymentFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class CableTVError extends CableTVState {
  final String message;

  CableTVError({required this.message});

  @override
  List<Object?> get props => [message];
}
