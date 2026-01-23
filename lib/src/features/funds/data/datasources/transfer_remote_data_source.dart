import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
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
    String? transactionId,
    String? verificationToken,
  });
}

class TransferRemoteDataSourceImpl implements ITransferRemoteDataSource {
  final TransferServiceClient _client; // Correct client type
  final GrpcCallOptionsHelper _callOptionsHelper;

  TransferRemoteDataSourceImpl(
    this._client,
    this._callOptionsHelper,
  );

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
    String? transactionId,
    String? verificationToken,
  }) async {
    // PRODUCTION-GRADE: Execute with retry policy for network resilience
    return await RetryPolicy.critical.execute(
      () async {
        // Convert DateTime? to String? for proto
        String? scheduledAtStr;
        if (scheduledAt != null) {
          scheduledAtStr = scheduledAt.toUtc().toIso8601String();
        }

        // Validate required PIN verification fields
        if (transactionId == null || transactionId.isEmpty) {
          throw ServerException(message: 'Transaction ID is required for PIN verification');
        }
        if (verificationToken == null || verificationToken.isEmpty) {
          throw ServerException(message: 'Verification token is required for PIN verification');
        }

        final request = InitiateTransferRequest(
          fromAccountId: fromAccountId,
          amount: amount,
          toAccountId: toAccountId,
          recipientId: recipientId,
          category: category ?? '',
          reference: reference ?? '',
          scheduledAt: scheduledAtStr,
          transactionId: transactionId,
          verificationToken: verificationToken,
        );

        try {
          // Use executeWithTokenRotation for automatic token refresh on auth errors
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.initiateTransfer(
              request,
              options: callOptions.mergedWith(
                CallOptions(timeout: const Duration(seconds: 30)),
              ),
            );
          });
          return response;
        } on GrpcError catch (e) {
          // Log the gRPC error details
          print('gRPC Error during transfer initiation: ${e.code} - ${e.message}');
          // Rethrow as ServerException for repository layer
          throw ServerException(
            message: 'Failed to initiate transfer: ${e.message ?? "Unknown gRPC error"}',
          );
        } catch (e) {
          print('Unexpected Error during transfer initiation: $e');
          // Rethrow as ServerException
          throw ServerException(
            message: 'An unexpected error occurred during transfer initiation.',
          );
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Transfer initiation attempt $attempt due to: $error');
        // TODO: Send analytics event for retry
      },
      shouldRetry: (error) {
        // Custom retry logic for transfers - don't retry business logic failures
        if (error is ServerException) {
          final message = error.message?.toLowerCase() ?? '';
          if (message.contains('insufficient') ||
              message.contains('invalid') ||
              message.contains('not found') ||
              message.contains('denied') ||
              message.contains('duplicate')) {
            return false;
          }
        }
        return true; // Use default retry logic for other errors
      },
    );
  }
} 