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