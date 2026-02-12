import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../../domain/entities/qr_transaction_entity.dart';
import '../../domain/repositories/qr_payment_repository.dart';
import '../datasources/qr_payment_remote_datasource.dart';

class QRPaymentRepositoryImpl implements QRPaymentRepository {
  final QRPaymentRemoteDataSource remoteDataSource;

  QRPaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, (QRPaymentEntity, String)>> generateQR({
    required double amount,
    required String currency,
    String? description,
    QRPaymentType qrType = QRPaymentType.dynamic,
    int? validityMinutes,
  }) async {
    try {
      final result = await remoteDataSource.generateQR(
        amount: amount,
        currency: currency,
        description: description,
        qrType: qrType,
        validityMinutes: validityMinutes,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to generate QR code',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, QRPaymentEntity>> getQRDetails({
    required String qrCode,
  }) async {
    try {
      final result = await remoteDataSource.getQRDetails(qrCode: qrCode);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get QR details',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, (QRTransactionEntity, double)>> processQRPayment({
    required String qrCode,
    required String sourceAccountId,
    required double amount,
    required String transactionPin,
    String? idempotencyKey,
  }) async {
    try {
      final result = await remoteDataSource.processQRPayment(
        qrCode: qrCode,
        sourceAccountId: sourceAccountId,
        amount: amount,
        transactionPin: transactionPin,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to process QR payment',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<QRPaymentEntity>>> getMyGeneratedQRCodes({
    int? limit,
    int? offset,
    QRPaymentStatus? statusFilter,
  }) async {
    try {
      final result = await remoteDataSource.getMyGeneratedQRCodes(
        limit: limit,
        offset: offset,
        statusFilter: statusFilter,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get generated QR codes',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<QRTransactionEntity>>> getMyQRPayments({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await remoteDataSource.getMyQRPayments(
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get QR payments',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelQR({
    required String qrId,
  }) async {
    try {
      await remoteDataSource.cancelQR(qrId: qrId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to cancel QR code',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, QRTransactionEntity>> getQRTransactionReceipt({
    required String transactionId,
  }) async {
    try {
      final result = await remoteDataSource.getQRTransactionReceipt(
        transactionId: transactionId,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get transaction receipt',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
