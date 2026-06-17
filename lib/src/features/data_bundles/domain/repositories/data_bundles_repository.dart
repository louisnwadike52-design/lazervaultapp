import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/data_plan_entity.dart';
import '../entities/data_purchase_entity.dart';

abstract class DataBundlesRepository {
  Future<Either<Failure, List<DataPlanEntity>>> getDataPlans({
    required String network,
  });

  Future<Either<Failure, DataPurchaseEntity>> buyData({
    required String phoneNumber,
    required String network,
    required String variationId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  /// Recent data purchases (domestic + international).
  Future<Either<Failure, List<DataPurchaseEntity>>> getPurchaseHistory({
    int limit = 50,
    int offset = 0,
  });

  // Auto-renewal (non-expiring data)
  Future<Either<Failure, void>> enableAutoRenew({
    required String subscriptionId,
    required String variationId,
    required String network,
    required double amount,
  });

  Future<Either<Failure, void>> disableAutoRenew({
    required String subscriptionId,
  });

  Future<Either<Failure, List<Map<String, dynamic>>>> getAutoRenewSubscriptions({
    int limit = 50,
    int offset = 0,
  });
}
