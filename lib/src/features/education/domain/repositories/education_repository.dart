import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/education_provider_entity.dart';
import '../entities/education_purchase_entity.dart';

abstract class EducationRepository {
  Future<Either<Failure, List<EducationProviderEntity>>> getProviders({bool activeOnly = true});
  Future<Either<Failure, EducationPurchaseEntity>> purchasePin({
    required String serviceId,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
}
