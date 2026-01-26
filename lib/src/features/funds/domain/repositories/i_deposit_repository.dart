import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';

abstract class IDepositRepository {
  Future<Either<Failure, DepositDetails>> initiateDeposit({
    required String targetAccountId, // UUID string
    required double amount,
    required String currency,
    required String sourceBankName,
    String? accessToken,
  });
} 