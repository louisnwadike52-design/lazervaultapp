import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  Future<Either<Failure, T>> call(Params params);
}

class InitiateDepositUseCase {
  final IDepositRepository _repository;

  InitiateDepositUseCase(this._repository);

  Future<Either<Failure, DepositDetails>> call({
    required String targetAccountId,
    required double amount,
    required String currency,
    required String sourceBankName,
    String? countryCode,
    String? accessToken,
  }) async {
    return await _repository.initiateDeposit(
      targetAccountId: targetAccountId,
      amount: amount,
      currency: currency,
      sourceBankName: sourceBankName,
      countryCode: countryCode,
      accessToken: accessToken,
    );
  }

  Future<Either<Failure, DepositDetails>> simulateTestDeposit({
    required String destinationAccountId,
    required double amount,
    required String currency,
    required String countryCode,
  }) async {
    return await _repository.simulateTestDeposit(
      destinationAccountId: destinationAccountId,
      amount: amount,
      currency: currency,
      countryCode: countryCode,
    );
  }

  Future<Either<Failure, List<DepositMethodInfo>>> getDepositMethods({
    required String countryCode,
    required String currency,
  }) async {
    return await _repository.getDepositMethods(
      countryCode: countryCode,
      currency: currency,
    );
  }
}

class DepositParams extends Equatable {
  final String targetAccountId;
  final double amount;
  final String currency;
  final String sourceBankName;
  final String? countryCode;
  final String? accessToken;

  const DepositParams({
    required this.targetAccountId,
    required this.amount,
    required this.currency,
    required this.sourceBankName,
    this.countryCode,
    this.accessToken,
  });

  @override
  List<Object?> get props =>
      [targetAccountId, amount, currency, sourceBankName, countryCode, accessToken];
}