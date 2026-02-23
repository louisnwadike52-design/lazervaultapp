import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';

abstract class IDepositRepository {
  Future<Either<Failure, DepositDetails>> initiateDeposit({
    required String targetAccountId,
    required double amount,
    required String currency,
    required String sourceBankName,
    String? countryCode,
    String? accessToken,
  });

  Future<Either<Failure, DepositDetails>> simulateTestDeposit({
    required String destinationAccountId,
    required double amount,
    required String currency,
    required String countryCode,
  });

  Future<Either<Failure, List<DepositMethodInfo>>> getDepositMethods({
    required String countryCode,
    required String currency,
  });
}