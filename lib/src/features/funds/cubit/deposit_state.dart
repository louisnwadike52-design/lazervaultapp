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