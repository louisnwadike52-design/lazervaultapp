import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/withdrawal_entity.dart';

abstract class WithdrawalState extends Equatable {
  const WithdrawalState();
  @override
  List<Object?> get props => [];
}

class WithdrawalInitial extends WithdrawalState {}

class WithdrawalLoading extends WithdrawalState {}

class WithdrawalSuccess extends WithdrawalState {
  final WithdrawalDetails withdrawalDetails;
  const WithdrawalSuccess(this.withdrawalDetails);
  @override
  List<Object?> get props => [withdrawalDetails];
}

class WithdrawalFailure extends WithdrawalState {
  final String message;
  final int? statusCode;
  const WithdrawalFailure(this.message, {this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
} 