import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';

abstract class DepositState extends Equatable {
  const DepositState();
  @override
  List<Object?> get props => [];
}

class DepositInitial extends DepositState {}

class DepositLoading extends DepositState {}

class DepositSuccess extends DepositState {
  final DepositDetails depositDetails;
  const DepositSuccess(this.depositDetails);
  @override
  List<Object?> get props => [depositDetails];
}

class DepositFailure extends DepositState {
  final String message;
  final int? statusCode;
  const DepositFailure(this.message, {this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}

/// Emitted when deposit requires user to complete payment on a hosted page (Flutterwave Standard)
class DepositRequiresAuthorization extends DepositState {
  final String paymentUrl;
  final String depositId;
  final String provider;
  const DepositRequiresAuthorization({
    required this.paymentUrl,
    required this.depositId,
    required this.provider,
  });
  @override
  List<Object?> get props => [paymentUrl, depositId, provider];
}

/// Emitted when a simulated test deposit succeeds instantly
class SimulateDepositSuccess extends DepositState {
  final DepositDetails depositDetails;
  const SimulateDepositSuccess(this.depositDetails);
  @override
  List<Object?> get props => [depositDetails];
}

/// Emitted when deposit methods are loaded for a country
class DepositMethodsLoaded extends DepositState {
  final List<DepositMethodInfo> methods;
  final String countryCode;
  final String currency;
  final String provider;
  const DepositMethodsLoaded({
    required this.methods,
    required this.countryCode,
    required this.currency,
    required this.provider,
  });
  @override
  List<Object?> get props => [methods, countryCode, currency, provider];
}

class DepositWebSocketCompleted extends DepositState {
  final String reference;
  final String status;
  const DepositWebSocketCompleted({required this.reference, required this.status});
  @override
  List<Object?> get props => [reference, status];
}

class DepositWebSocketFailed extends DepositState {
  final String reference;
  final String message;
  const DepositWebSocketFailed({required this.reference, required this.message});
  @override
  List<Object?> get props => [reference, message];
}

class DepositReversed extends DepositState {
  final String reference;
  final String reason;
  const DepositReversed({required this.reference, required this.reason});
  @override
  List<Object?> get props => [reference, reason];
}