import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';

abstract class DepositState extends Equatable {
  const DepositState();
  @override
  List<Object?> get props => [];
}

class DepositInitial extends DepositState {}

/// A deposit is being SUBMITTED. The user has committed; the screen should stop
/// accepting new taps until it resolves.
class DepositLoading extends DepositState {}

/// The list of deposit methods is being FETCHED in the background.
///
/// Split out of [DepositLoading] because the two meant opposite things to the
/// UI and shared one state. Loading the method list disabled every method card
/// — bank transfer and card included — so opening the deposit screen left the
/// user tapping dead tiles until an unrelated fetch finished. Nothing about
/// reading a list should block choosing from it.
class DepositMethodsLoading extends DepositState {}

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
  const DepositWebSocketCompleted(
      {required this.reference, required this.status});
  @override
  List<Object?> get props => [reference, status];
}

class DepositWebSocketFailed extends DepositState {
  final String reference;
  final String message;
  const DepositWebSocketFailed(
      {required this.reference, required this.message});
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
