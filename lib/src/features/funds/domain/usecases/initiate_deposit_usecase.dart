import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/core/error/failure.dart'; // Use the core failure
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  Future<Either<Failure, Type>> call(Params params);
}

class InitiateDepositUseCase {
  final IDepositRepository _repository;

  InitiateDepositUseCase(this._repository);

  Future<Either<Failure, DepositDetails>> call({
    required String targetAccountId, // UUID string
    required double amount,
    required String currency,
    required String sourceBankName,
    String? accessToken,
  }) async {
    return await _repository.initiateDeposit(
      targetAccountId: targetAccountId,
      amount: amount,
      currency: currency,
      sourceBankName: sourceBankName,
      accessToken: accessToken,
    );
  }
}

class DepositParams extends Equatable {
  final String targetAccountId; // UUID string
  final double amount;
  final String currency;
  final String sourceBankName;
  final String? accessToken;

  const DepositParams({
    required this.targetAccountId,
    required this.amount,
    required this.currency,
    required this.sourceBankName,
    this.accessToken,
  });

  @override
  List<Object?> get props =>
      [targetAccountId, amount, currency, sourceBankName, accessToken];
} 