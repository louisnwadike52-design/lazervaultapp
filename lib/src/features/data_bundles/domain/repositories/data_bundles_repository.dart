import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
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
}
