import 'package:fixnum/fixnum.dart';
import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/data/datasources/batch_transfer_remote_data_source.dart';
import 'package:lazervault/src/features/funds/data/models/batch_transfer_model.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_batch_transfer_repository.dart';

class BatchTransferRepositoryImpl implements IBatchTransferRepository {
  final IBatchTransferRemoteDataSource remoteDataSource;

  BatchTransferRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BatchTransferEntity>> initiateBatchTransfer({
    required Int64 fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String accessToken,
    String? category,
    String? reference,
    DateTime? scheduledAt,
  }) async {
    try {
      final remoteResponse = await remoteDataSource.initiateBatchTransfer(
        fromAccountId: fromAccountId,
        recipients: recipients,
        accessToken: accessToken,
        category: category,
        reference: reference,
        scheduledAt: scheduledAt,
      );
      
      // Convert the raw response to our model
      final responseModel = InitiateBatchTransferResponseModel.fromProto(remoteResponse);
      
      // Return the model (which is a BatchTransferEntity) wrapped in Right
      return Right(responseModel);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Server Error', statusCode: 500));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: 'gRPC Error: ${e.message ?? e.codeName}',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Unexpected Error: ${e.toString()}', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, BatchTransferEntity>> getBatchTransferStatus({
    required Int64 batchId,
    required String accessToken,
  }) async {
    try {
      final remoteResponse = await remoteDataSource.getBatchTransferStatus(
        batchId: batchId,
        accessToken: accessToken,
      );
      
      // Convert the raw response to our model
      final responseModel = InitiateBatchTransferResponseModel.fromProto(remoteResponse);
      
      // Return the model (which is a BatchTransferEntity) wrapped in Right
      return Right(responseModel);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Server Error', statusCode: 500));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: 'gRPC Error: ${e.message ?? e.codeName}',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Unexpected Error: ${e.toString()}', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<BatchTransferEntity>>> getBatchTransferHistory({
    required String accessToken,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // For now, return mock data - in real implementation this would call remote data source
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      
      final mockHistory = _generateMockHistory();
      return Right(mockHistory);
    } catch (e) {
      return Left(ServerFailure(
          message: 'Error fetching batch transfer history: ${e.toString()}', 
          statusCode: 500));
    }
  }

  List<BatchTransferEntity> _generateMockHistory() {
    final now = DateTime.now();
    return [
      BatchTransferEntity(
        batchId: Int64(12345),
        status: 'completed',
        totalAmount: Int64(150000), // $1500.00
        totalFee: Int64(500), // $5.00
        totalAmountWithFee: Int64(150500),
        successfulTransfers: 3,
        failedTransfers: 0,
        totalTransfers: 3,
        createdAt: now.subtract(const Duration(days: 1)),
        completedAt: now.subtract(const Duration(days: 1, hours: 1)),
        results: [
          BatchTransferResult(
            transferId: Int64(101),
            status: 'completed',
            amount: Int64(50000), // $500.00
            fee: Int64(167),
            recipientName: 'John Doe',
            recipientAccount: '****1234',
          ),
          BatchTransferResult(
            transferId: Int64(102),
            status: 'completed',
            amount: Int64(75000), // $750.00
            fee: Int64(167),
            recipientName: 'Jane Smith',
            recipientAccount: '****5678',
          ),
          BatchTransferResult(
            transferId: Int64(103),
            status: 'completed',
            amount: Int64(25000), // $250.00
            fee: Int64(166),
            recipientName: 'Bob Johnson',
            recipientAccount: '****9012',
          ),
        ],
      ),
      BatchTransferEntity(
        batchId: Int64(12344),
        status: 'completed',
        totalAmount: Int64(320000), // $3200.00
        totalFee: Int64(1000), // $10.00
        totalAmountWithFee: Int64(321000),
        successfulTransfers: 5,
        failedTransfers: 0,
        totalTransfers: 5,
        createdAt: now.subtract(const Duration(days: 3)),
        completedAt: now.subtract(const Duration(days: 3, hours: 2)),
        results: [
          BatchTransferResult(
            transferId: Int64(201),
            status: 'completed',
            amount: Int64(100000), // $1000.00
            fee: Int64(200),
            recipientName: 'Alice Brown',
            recipientAccount: '****3456',
          ),
          BatchTransferResult(
            transferId: Int64(202),
            status: 'completed',
            amount: Int64(80000), // $800.00
            fee: Int64(200),
            recipientName: 'Charlie Davis',
            recipientAccount: '****7890',
          ),
          BatchTransferResult(
            transferId: Int64(203),
            status: 'completed',
            amount: Int64(60000), // $600.00
            fee: Int64(200),
            recipientName: 'Diana Wilson',
            recipientAccount: '****2345',
          ),
          BatchTransferResult(
            transferId: Int64(204),
            status: 'completed',
            amount: Int64(50000), // $500.00
            fee: Int64(200),
            recipientName: 'Eva Martinez',
            recipientAccount: '****6789',
          ),
          BatchTransferResult(
            transferId: Int64(205),
            status: 'completed',
            amount: Int64(30000), // $300.00
            fee: Int64(200),
            recipientName: 'Frank Garcia',
            recipientAccount: '****0123',
          ),
        ],
      ),
      BatchTransferEntity(
        batchId: Int64(12343),
        status: 'partial_success',
        totalAmount: Int64(200000), // $2000.00
        totalFee: Int64(600), // $6.00
        totalAmountWithFee: Int64(200600),
        successfulTransfers: 2,
        failedTransfers: 1,
        totalTransfers: 3,
        createdAt: now.subtract(const Duration(days: 7)),
        completedAt: now.subtract(const Duration(days: 7, hours: 1)),
        results: [
          BatchTransferResult(
            transferId: Int64(301),
            status: 'completed',
            amount: Int64(100000), // $1000.00
            fee: Int64(200),
            recipientName: 'Grace Lee',
            recipientAccount: '****4567',
          ),
          BatchTransferResult(
            transferId: Int64(302),
            status: 'completed',
            amount: Int64(75000), // $750.00
            fee: Int64(200),
            recipientName: 'Henry Wang',
            recipientAccount: '****8901',
          ),
          BatchTransferResult(
            transferId: Int64(303),
            status: 'failed',
            amount: Int64(25000), // $250.00
            fee: Int64(200),
            recipientName: 'Isabel Rodriguez',
            recipientAccount: '****2346',
            failureReason: 'Insufficient funds in recipient account',
          ),
        ],
      ),
    ];
  }
} 