import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/qr_payment_entity.dart';
import '../entities/qr_transaction_entity.dart';

abstract class QRPaymentRepository {
  Future<Either<Failure, (QRPaymentEntity, String)>> generateQR({
    required double amount,
    required String currency,
    String? description,
    QRPaymentType qrType,
    int? validityMinutes,
  });

  Future<Either<Failure, QRPaymentEntity>> getQRDetails({
    required String qrCode,
  });

  Future<Either<Failure, (QRTransactionEntity, double)>> processQRPayment({
    required String qrCode,
    required String sourceAccountId,
    required double amount,
    required String transactionPin,
    String? idempotencyKey,
  });

  Future<Either<Failure, List<QRPaymentEntity>>> getMyGeneratedQRCodes({
    int? limit,
    int? offset,
    QRPaymentStatus? statusFilter,
  });

  Future<Either<Failure, List<QRTransactionEntity>>> getMyQRPayments({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, void>> cancelQR({
    required String qrId,
  });

  Future<Either<Failure, QRTransactionEntity>> getQRTransactionReceipt({
    required String transactionId,
  });
}
