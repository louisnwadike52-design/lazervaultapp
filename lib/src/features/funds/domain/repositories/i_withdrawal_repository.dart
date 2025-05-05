import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/withdrawal_entity.dart';

abstract class IWithdrawalRepository {
  Future<Either<Failure, WithdrawalDetails>> initiateWithdrawal({
    required int sourceAccountId,
    required double amount,
    required String currency,
    required String targetBankName,
    required String targetAccountNumber,
    String? targetSortCode,
    String? accessToken,
  });
} 