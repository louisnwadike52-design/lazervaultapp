import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart';

// Note: These proto imports would need to be generated for batch transfer
// For now, we'll use mock implementations that follow the same pattern
abstract class IBatchTransferRemoteDataSource {
  Future<dynamic> initiateBatchTransfer({
    required Int64 fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String accessToken,
    String? category,
    String? reference,
    DateTime? scheduledAt,
  });

  Future<dynamic> getBatchTransferStatus({
    required Int64 batchId,
    required String accessToken,
  });
}

class BatchTransferRemoteDataSourceImpl implements IBatchTransferRemoteDataSource {
  // final BatchTransferServiceClient _client; // This would be the generated gRPC client

  BatchTransferRemoteDataSourceImpl();

  @override
  Future<dynamic> initiateBatchTransfer({
    required Int64 fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String accessToken,
    String? category,
    String? reference,
    DateTime? scheduledAt,
  }) async {
    // Convert DateTime? to Timestamp? here
    final Timestamp? scheduleTimestamp = scheduledAt != null
        ? Timestamp.fromDateTime(scheduledAt.toUtc())
        : null;

    // Convert recipients to proto format
    final protoRecipients = recipients.map((recipient) => {
      'recipientId': recipient.recipientId,
      'toAccountId': recipient.toAccountId,
      'amount': recipient.amount,
      'reference': recipient.reference ?? '',
      'category': recipient.category ?? '',
    }).toList();

    // Mock request structure - this would be the actual proto request
    final request = {
      'fromAccountId': fromAccountId,
      'recipients': protoRecipients,
      'category': category ?? '',
      'reference': reference ?? '',
      'scheduledAt': scheduleTimestamp,
    };

    final options = CallOptions(metadata: {'authorization': 'Bearer $accessToken'});

    try {
      // Mock response - this would be the actual gRPC call
      // final response = await _client.initiateBatchTransfer(request, options: options);
      
      // For now, return a mock response structure
      final mockResponse = _createMockBatchTransferResponse(fromAccountId, recipients);
      return mockResponse;
    } on GrpcError catch (e) {
      print('gRPC Error during batch transfer initiation: ${e.code} - ${e.message}');
      throw ServerException(message: 'Failed to initiate batch transfer: ${e.message ?? "Unknown gRPC error"}');
    } catch (e) {
      print('Unexpected Error during batch transfer initiation: $e');
      throw ServerException(message: 'An unexpected error occurred during batch transfer initiation.');
    }
  }

  @override
  Future<dynamic> getBatchTransferStatus({
    required Int64 batchId,
    required String accessToken,
  }) async {
    // Mock request structure
    final request = {
      'batchId': batchId,
    };

    final options = CallOptions(metadata: {'authorization': 'Bearer $accessToken'});

    try {
      // Mock response - this would be the actual gRPC call
      // final response = await _client.getBatchTransferStatus(request, options: options);
      
      // For now, return a mock response structure
      final mockResponse = _createMockBatchTransferStatusResponse(batchId);
      return mockResponse;
    } on GrpcError catch (e) {
      print('gRPC Error during batch transfer status check: ${e.code} - ${e.message}');
      throw ServerException(message: 'Failed to get batch transfer status: ${e.message ?? "Unknown gRPC error"}');
    } catch (e) {
      print('Unexpected Error during batch transfer status check: $e');
      throw ServerException(message: 'An unexpected error occurred during batch transfer status check.');
    }
  }

  // Mock response creators - these would be replaced with actual proto responses
  dynamic _createMockBatchTransferResponse(Int64 fromAccountId, List<BatchTransferRecipient> recipients) {
    final results = recipients.asMap().entries.map((entry) {
      final index = entry.key;
      final recipient = entry.value;
      
      return MockBatchTransferResult(
        transferId: Int64(1000 + index),
        status: 'completed',
        amount: recipient.amount,
        fee: Int64((recipient.amount.toInt() * 0.01).round()), // 1% fee
        recipientName: 'Recipient ${index + 1}',
        recipientAccount: '****${(1234 + index).toString()}',
        failureReason: null,
      );
    }).toList();

    final totalAmount = recipients.fold<Int64>(Int64.ZERO, (sum, r) => sum + r.amount);
    final totalFee = results.fold<Int64>(Int64.ZERO, (sum, r) => sum + r.fee);

    return MockBatchTransferResponse(
      batchId: Int64(DateTime.now().millisecondsSinceEpoch),
      status: 'processing',
      totalAmount: totalAmount,
      totalFee: totalFee,
      totalAmountWithFee: totalAmount + totalFee,
      successfulTransfers: results.length,
      failedTransfers: 0,
      totalTransfers: results.length,
      results: results,
      createdAt: MockTimestamp.now(),
      completedAt: null,
    );
  }

  dynamic _createMockBatchTransferStatusResponse(Int64 batchId) {
    return MockBatchTransferResponse(
      batchId: batchId,
      status: 'completed',
      totalAmount: Int64(10000),
      totalFee: Int64(100),
      totalAmountWithFee: Int64(10100),
      successfulTransfers: 3,
      failedTransfers: 0,
      totalTransfers: 3,
      results: [],
      createdAt: MockTimestamp.now(),
      completedAt: MockTimestamp.now(),
    );
  }
}

// Mock classes to simulate proto responses
class MockTimestamp {
  final int seconds;
  final int nanos;

  MockTimestamp({required this.seconds, required this.nanos});

  static MockTimestamp now() {
    final now = DateTime.now();
    return MockTimestamp(
      seconds: now.millisecondsSinceEpoch ~/ 1000,
      nanos: (now.millisecondsSinceEpoch % 1000) * 1000000,
    );
  }
}

class MockBatchTransferResult {
  final Int64 transferId;
  final String status;
  final Int64 amount;
  final Int64 fee;
  final String? recipientName;
  final String? recipientAccount;
  final String? failureReason;

  MockBatchTransferResult({
    required this.transferId,
    required this.status,
    required this.amount,
    required this.fee,
    this.recipientName,
    this.recipientAccount,
    this.failureReason,
  });
}

class MockBatchTransferResponse {
  final Int64 batchId;
  final String status;
  final Int64 totalAmount;
  final Int64 totalFee;
  final Int64 totalAmountWithFee;
  final int successfulTransfers;
  final int failedTransfers;
  final int totalTransfers;
  final List<MockBatchTransferResult> results;
  final MockTimestamp createdAt;
  final MockTimestamp? completedAt;

  MockBatchTransferResponse({
    required this.batchId,
    required this.status,
    required this.totalAmount,
    required this.totalFee,
    required this.totalAmountWithFee,
    required this.successfulTransfers,
    required this.failedTransfers,
    required this.totalTransfers,
    required this.results,
    required this.createdAt,
    this.completedAt,
  });
} 