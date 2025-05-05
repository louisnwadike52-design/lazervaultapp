import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import '../repositories/i_deposit_repository.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  Future<Either<Failure, Type>> call(Params params);
}

class InitiateDepositUseCase extends UseCaseWithParams<DepositDetails, DepositParams> {
  final IDepositRepository _repository;

  const InitiateDepositUseCase(this._repository);

  @override
  Future<Either<Failure, DepositDetails>> call(DepositParams params) async {
    return await _repository.initiateDeposit(
      targetAccountId: params.targetAccountId,
      amount: params.amount,
      currency: params.currency,
      sourceBankName: params.sourceBankName,
    );
  }
}

class DepositParams extends Equatable {
  final int targetAccountId;
  final double amount;
  final String currency;
  final String sourceBankName;

  const DepositParams({
    required this.targetAccountId,
    required this.amount,
    required this.currency,
    required this.sourceBankName,
  });

  @override
  List<Object?> get props => [targetAccountId, amount, currency, sourceBankName];
} 