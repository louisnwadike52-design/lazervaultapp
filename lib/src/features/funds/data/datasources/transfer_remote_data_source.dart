import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
// Ensure google_protobuf is imported for Timestamp
// Corrected imports for generated protobuf files

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart';
import 'package:lazervault/src/generated/transfer.pb.dart';
import 'package:lazervault/src/generated/transfer.pbgrpc.dart';

abstract class ITransferRemoteDataSource {
  Future<InitiateTransferResponse> initiateTransfer({
    required Int64 fromAccountId,
    required Int64 amount, // Minor units
    required String accessToken,
    Int64? toAccountId,
    Int64? recipientId,
    String? category,
    String? reference,
    DateTime? scheduledAt, // Changed type to DateTime?
  });
}

class TransferRemoteDataSourceImpl implements ITransferRemoteDataSource {
  final TransferServiceClient _client; // Correct client type

  TransferRemoteDataSourceImpl(this._client);

  @override
  Future<InitiateTransferResponse> initiateTransfer({
    required Int64 fromAccountId,
    required Int64 amount, // Minor units
    required String accessToken,
    Int64? toAccountId,
    Int64? recipientId,
    String? category,
    String? reference,
    DateTime? scheduledAt, // Changed type to DateTime?
  }) async {
    // Convert DateTime? to Timestamp? here
    final Timestamp? scheduleTimestamp = scheduledAt != null
        ? Timestamp.fromDateTime(scheduledAt.toUtc())
        : null;

    final request = InitiateTransferRequest(
      fromAccountId: fromAccountId,
      amount: amount,
      toAccountId: toAccountId,
      recipientId: recipientId,
      category: category ?? '', 
      reference: reference ?? '',
      scheduledAt: scheduleTimestamp, // Use the converted Timestamp?
    );

    final options = CallOptions(metadata: {'authorization': 'Bearer $accessToken'});

    try {
      final response = await _client.initiateTransfer(request, options: options);
      return response;
    } on GrpcError catch (e) {
      // Log the gRPC error details
      print('gRPC Error during transfer initiation: ${e.code} - ${e.message}');
      // Rethrow as ServerException for repository layer
      throw ServerException(message: 'Failed to initiate transfer: ${e.message ?? "Unknown gRPC error"}');
    } catch (e) {
      print('Unexpected Error during transfer initiation: $e');
      // Rethrow as ServerException
      throw ServerException(message: 'An unexpected error occurred during transfer initiation.');
    }
  }
} 