import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/withdrawal_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_withdrawal_repository.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  Future<Either<Failure, T>> call(Params params);
}

class InitiateWithdrawalUseCase extends UseCaseWithParams<WithdrawalDetails, WithdrawalParams> {
  final IWithdrawalRepository _repository;

  const InitiateWithdrawalUseCase(this._repository);

  @override
  Future<Either<Failure, WithdrawalDetails>> call(WithdrawalParams params) async {
    return await _repository.initiateWithdrawal(
      sourceAccountId: params.sourceAccountId,
      amount: params.amount,
      currency: params.currency,
      targetBankName: params.targetBankName,
      targetAccountNumber: params.targetAccountNumber,
      targetSortCode: params.targetSortCode,
      accessToken: params.accessToken,
    );
  }
}

class WithdrawalParams extends Equatable {
  final int sourceAccountId;
  final double amount;
  final String currency;
  final String targetBankName;
  final String targetAccountNumber;
  final String? targetSortCode;
  final String? accessToken;

  const WithdrawalParams({
    required this.sourceAccountId,
    required this.amount,
    required this.currency,
    required this.targetBankName,
    required this.targetAccountNumber,
    this.targetSortCode,
    this.accessToken,
  });

  @override
  List<Object?> get props => [
    sourceAccountId,
    amount,
    currency,
    targetBankName,
    targetAccountNumber,
    targetSortCode,
    accessToken,
  ];
} 