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

/// PAY WITH CRYPTO: the subscription is authorised and recorded, and the
/// conversion that funds it is running.
///
/// A STATE OF ITS OWN, not a flavour of Success or Processing. It is not
/// success — the customer has no subscription yet — and it is not a failure,
/// because nothing has gone wrong. Callers that wait for a terminal outcome
/// settle on this too, so they do not hang until a timeout and then report a
/// failure for a payment that is proceeding normally.
class CableTVAwaitingCryptoFunding extends CableTVState {
  final CableTVPaymentEntity payment;

  /// The coin being sold, lowercase.
  final String asset;

  CableTVAwaitingCryptoFunding({required this.payment, required this.asset});

  @override
  List<Object?> get props => [payment, asset];
}

class CableTVPaymentSuccess extends CableTVState {
  final CableTVPaymentEntity payment;

  CableTVPaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class CableTVPaymentFailed extends CableTVState {
  final String message;

  /// The gRPC status code the backend chose, carried so the screen can withhold
  /// "Try Again" for a purchase the provider has ALREADY accepted. ePINs is the
  /// active cable rail and exposes no requery endpoint, so a retry after its
  /// duplicate code is how one bouquet is paid for twice.
  final dynamic statusCode;

  CableTVPaymentFailed({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class CableTVError extends CableTVState {
  final String message;

  CableTVError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ================= Payment history states =================
class CableTVPaymentHistoryLoading extends CableTVState {}

class CableTVPaymentHistoryLoaded extends CableTVState {
  final List<CableTVPaymentEntity> payments;
  final bool isStale;

  CableTVPaymentHistoryLoaded({
    required this.payments,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [payments, isStale];
}

class CableTVPaymentHistoryError extends CableTVState {
  final String message;

  CableTVPaymentHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
