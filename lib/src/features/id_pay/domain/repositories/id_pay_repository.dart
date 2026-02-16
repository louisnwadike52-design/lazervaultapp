import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/id_pay_entity.dart';
import '../entities/id_pay_transaction_entity.dart';

abstract class IDPayRepository {
  Future<Either<Failure, IDPayEntity>> createIDPay({
    required IDPayType type,
    required IDPayAmountMode amountMode,
    required double amount,
    required String currency,
    double? minAmount,
    double? maxAmount,
    String? description,
    required int validityMinutes,
  });

  Future<Either<Failure, IDPayEntity>> lookupIDPay({
    required String payId,
  });

  Future<Either<Failure, (IDPayTransactionEntity, double)>> payIDPay({
    required String payId,
    required double amount,
    required String transactionPin,
    required String sourceAccountId,
    String? idempotencyKey,
  });

  Future<Either<Failure, List<IDPayEntity>>> getMyIDPays({
    int? limit,
    int? offset,
    IDPayStatus? statusFilter,
  });

  Future<Either<Failure, List<IDPayTransactionEntity>>> getIDPayTransactions({
    required String payId,
    int? limit,
    int? offset,
  });

  Future<Either<Failure, void>> cancelIDPay({
    required String id,
  });

  Future<Either<Failure, IDPayEntity>> getIDPayDetails({
    required String id,
  });
}
