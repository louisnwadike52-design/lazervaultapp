import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/water_provider_entity.dart';
import '../entities/customer_validation_result.dart';
import '../entities/water_payment_entity.dart';

abstract class WaterBillRepository {
  // Provider Management
  Future<Either<Failure, List<WaterProviderEntity>>> getProviders({
    String? country,
  });

  Future<Either<Failure, void>> syncProviders();

  // Customer Validation
  Future<Either<Failure, CustomerValidationResult>> validateCustomer({
    required String providerCode,
    required String customerNumber,
  });

  // Payment Operations
  Future<Either<Failure, WaterPaymentEntity>> initiatePayment({
    required String providerCode,
    required String customerNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  });

  Future<Either<Failure, WaterPaymentEntity>> verifyPayment({
    required String paymentId,
  });

  Future<Either<Failure, List<WaterPaymentEntity>>> getPaymentHistory({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, WaterPaymentEntity>> getPaymentReceipt({
    required String paymentId,
  });
}
