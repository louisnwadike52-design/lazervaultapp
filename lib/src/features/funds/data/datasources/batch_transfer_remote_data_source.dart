import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/funds/data/models/batch_transfer_model.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments;

abstract class IBatchTransferRemoteDataSource {
  Future<BatchTransferEntity> initiateBatchTransfer({
    required String fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  });
}

class BatchTransferRemoteDataSourceImpl
    implements IBatchTransferRemoteDataSource {
  final payments.PaymentsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  BatchTransferRemoteDataSourceImpl(
    this._client,
    this._callOptionsHelper,
  );

  @override
  Future<BatchTransferEntity> initiateBatchTransfer({
    required String fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        // Convert recipients from domain entities (minor units) to proto format (major units / doubles)
        final protoTransfers = recipients.map((recipient) {
          return payments.BatchTransferItem(
            toAccountNumber: recipient.toAccountNumber,
            amount: recipient.amount.toDouble() / 100,
            description: recipient.description ?? '',
            reference: recipient.reference ?? '',
            category: recipient.category ?? '',
          );
        }).toList();

        final request = payments.BatchTransferRequest(
          fromAccountId: fromAccountId,
          transfers: protoTransfers,
          transactionId: transactionId,
          verificationToken: verificationToken,
        );

        // Build metadata with idempotency key and optional scheduled time
        final metadata = <String, String>{
          'x-idempotency-key': transactionId,
        };
        if (scheduledAt != null) {
          metadata['x-scheduled-at'] = scheduledAt.toUtc().toIso8601String();
        }

        try {
          final response =
              await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.batchTransfer(
              request,
              options: callOptions.mergedWith(
                CallOptions(
                  timeout: const Duration(seconds: 90),
                  metadata: metadata,
                ),
              ),
            );
          });
          return InitiateBatchTransferResponseModel.fromPaymentsProto(response);
        } on GrpcError catch (e) {
          throw ServerException(
            message:
                'Failed to initiate batch transfer: ${e.message ?? "Unknown gRPC error"}',
          );
        } catch (e) {
          throw ServerException(
            message:
                'An unexpected error occurred during batch transfer initiation.',
          );
        }
      },
      shouldRetry: (error) {
        if (error is ServerException) {
          final message = error.message?.toLowerCase() ?? '';
          if (message.contains('insufficient') ||
              message.contains('invalid') ||
              message.contains('not found') ||
              message.contains('denied') ||
              message.contains('duplicate') ||
              message.contains('daily batch transfer limit')) {
            return false;
          }
        }
        return true;
      },
    );
  }
}
