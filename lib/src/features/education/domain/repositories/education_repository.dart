import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/education_provider_entity.dart';
import '../entities/education_purchase_entity.dart';
import '../entities/education_history_entity.dart';

abstract class EducationRepository {
  Future<Either<Failure, List<EducationProviderEntity>>> getProviders({bool activeOnly = true});
  Future<Either<Failure, EducationPurchaseEntity>> purchasePin({
    required String serviceId,
    required String variationCode,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String billersCode = '',
  });

  /// Get education PIN purchase history
  Future<Either<Failure, List<EducationHistoryEntity>>> getHistory({
    int limit = 20,
    int offset = 0,
  });

  /// Get education PIN purchase by ID with full PIN details
  Future<Either<Failure, EducationHistoryEntity>> getPurchaseById(String id);
}
