import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/barcode_payment_entity.dart';
import '../../domain/entities/barcode_transaction_entity.dart';
import '../../domain/repositories/barcode_payment_repository.dart';
import '../datasources/barcode_payment_remote_datasource.dart';

class BarcodePaymentRepositoryImpl implements BarcodePaymentRepository {
  final BarcodePaymentRemoteDataSource remoteDataSource;

  BarcodePaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BarcodePaymentEntity>> generateBarcode({
    required double amount,
    required String currency,
    String? description,
    int? validityMinutes,
  }) async {
    try {
      final result = await remoteDataSource.generateBarcode(
        amount: amount,
        currency: currency,
        description: description,
        validityMinutes: validityMinutes,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to generate barcode', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BarcodePaymentEntity>> getBarcodeDetails({
    required String barcodeCode,
  }) async {
    try {
      final result = await remoteDataSource.getBarcodeDetails(
        barcodeCode: barcodeCode,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get barcode details', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BarcodeTransactionEntity>> processBarcodePayment({
    required String barcodeCode,
    required String sourceAccountId,
  }) async {
    try {
      final result = await remoteDataSource.processBarcodePayment(
        barcodeCode: barcodeCode,
        sourceAccountId: sourceAccountId,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to process payment', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<BarcodePaymentEntity>>> getMyGeneratedBarcodes({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await remoteDataSource.getMyGeneratedBarcodes(
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get generated barcodes', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<BarcodeTransactionEntity>>> getMyScannedBarcodes({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await remoteDataSource.getMyScannedBarcodes(
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get scanned barcodes', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelBarcode({
    required String barcodeId,
  }) async {
    try {
      await remoteDataSource.cancelBarcode(barcodeId: barcodeId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to cancel barcode', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
