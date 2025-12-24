import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/barcode_payment_entity.dart';
import '../entities/barcode_transaction_entity.dart';

abstract class BarcodePaymentRepository {
  Future<Either<Failure, BarcodePaymentEntity>> generateBarcode({
    required double amount,
    required String currency,
    String? description,
    int? validityMinutes,
  });

  Future<Either<Failure, BarcodePaymentEntity>> getBarcodeDetails({
    required String barcodeCode,
  });

  Future<Either<Failure, BarcodeTransactionEntity>> processBarcodePayment({
    required String barcodeCode,
    required String sourceAccountId,
  });

  Future<Either<Failure, List<BarcodePaymentEntity>>> getMyGeneratedBarcodes({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, List<BarcodeTransactionEntity>>> getMyScannedBarcodes({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, void>> cancelBarcode({
    required String barcodeId,
  });
}
