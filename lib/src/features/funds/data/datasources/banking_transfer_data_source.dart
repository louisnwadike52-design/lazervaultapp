import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking;

/// Transfer types supported by the banking service
enum TransferType {
  internal,  // C2C within LazerVault
  domestic,  // To external Nigerian bank
  international, // Cross-border
  username,  // By LazerTag username
  phone,     // By phone number
}

/// Result of a transfer operation from banking service
class BankingTransferResult {
  final bool success;
  final String? transferId;
  final String? reference;
  final String? status;
  final int? amount;
  final int? fee;
  final String? errorCode;
  final String? errorMessage;
  final DateTime? createdAt;

  BankingTransferResult({
    required this.success,
    this.transferId,
    this.reference,
    this.status,
    this.amount,
    this.fee,
    this.errorCode,
    this.errorMessage,
    this.createdAt,
  });

  factory BankingTransferResult.fromProto(banking.TransferResponse response) {
    return BankingTransferResult(
      success: response.success,
      transferId: response.hasTransfer() ? response.transfer.id : null,
      reference: response.hasTransfer() ? response.transfer.reference : null,
      status: response.hasTransfer() ? response.transfer.status : null,
      amount: response.hasTransfer() ? response.transfer.amount.toInt() : null,
      fee: response.hasTransfer() ? response.transfer.fee.toInt() : null,
      errorCode: response.errorCode.isNotEmpty ? response.errorCode : null,
      errorMessage: response.errorMessage.isNotEmpty ? response.errorMessage : null,
      createdAt: response.hasTransfer() && response.transfer.hasCreatedAt()
          ? response.transfer.createdAt.toDateTime()
          : null,
    );
  }
}

/// Abstract interface for banking transfer operations
abstract class IBankingTransferDataSource {
  /// Initiate an internal C2C transfer between LazerVault users
  Future<BankingTransferResult> initiateInternalTransfer({
    required String fromUserId,
    required String toUserId,
    required int amount, // In kobo/minor units
    String? currency,
    String? narration,
    String? idempotencyKey,
  });

  /// Initiate a domestic transfer to an external Nigerian bank
  Future<BankingTransferResult> initiateDomesticTransfer({
    required String userId,
    required String sourceAccountId,
    required int amount, // In kobo
    required String destinationAccount,
    required String destinationBankCode,
    required String destinationName,
    String? currency,
    String? narration,
    String? reference,
    String? idempotencyKey,
  });

  /// Initiate a transfer by LazerTag username
  Future<BankingTransferResult> initiateUsernameTransfer({
    required String fromUserId,
    required String toUsername,
    required int amount, // In kobo
    String? currency,
    String? narration,
    String? idempotencyKey,
  });

  /// Initiate a transfer by phone number
  Future<BankingTransferResult> initiatePhoneTransfer({
    required String fromUserId,
    required String toPhone,
    required int amount, // In kobo
    String? currency,
    String? narration,
    String? idempotencyKey,
  });

  /// Get transfer status by reference
  Future<BankingTransferResult> getTransferStatus(String reference);

  /// Get user's transfer history
  Future<List<BankingTransferResult>> getUserTransfers({
    required String userId,
    int? limit,
    int? offset,
  });
}

/// Implementation of banking transfer data source using BankingServiceClient
class BankingTransferDataSourceImpl implements IBankingTransferDataSource {
  final banking.BankingServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final _uuid = const Uuid();

  BankingTransferDataSourceImpl(
    this._client,
    this._callOptionsHelper,
  );

  @override
  Future<BankingTransferResult> initiateInternalTransfer({
    required String fromUserId,
    required String toUserId,
    required int amount,
    String? currency,
    String? narration,
    String? idempotencyKey,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = banking.InternalTransferRequest(
          fromUserId: fromUserId,
          toUserId: toUserId,
          amount: Int64(amount),
          currency: currency ?? 'NGN',
          narration: narration ?? 'Internal transfer',
          idempotencyKey: idempotencyKey ?? _uuid.v4(),
        );

        try {
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.initiateInternalTransfer(
              request,
              options: callOptions.mergedWith(
                CallOptions(timeout: const Duration(seconds: 30)),
              ),
            );
          });
          return BankingTransferResult.fromProto(response);
        } on GrpcError catch (e) {
          print('gRPC Error during internal transfer: ${e.code} - ${e.message}');
          throw ServerException(
            message: 'Failed to initiate internal transfer: ${e.message ?? "Unknown error"}',
          );
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Internal transfer attempt $attempt due to: $error');
      },
      shouldRetry: _shouldRetryTransfer,
    );
  }

  @override
  Future<BankingTransferResult> initiateDomesticTransfer({
    required String userId,
    required String sourceAccountId,
    required int amount,
    required String destinationAccount,
    required String destinationBankCode,
    required String destinationName,
    String? currency,
    String? narration,
    String? reference,
    String? idempotencyKey,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = banking.DomesticTransferRequest(
          userId: userId,
          sourceAccountId: sourceAccountId,
          amount: Int64(amount),
          currency: currency ?? 'NGN',
          destinationAccount: destinationAccount,
          destinationBankCode: destinationBankCode,
          destinationName: destinationName,
          narration: narration ?? 'Bank transfer',
          reference: reference ?? '',
          idempotencyKey: idempotencyKey ?? _uuid.v4(),
        );

        try {
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.initiateDomesticTransfer(
              request,
              options: callOptions.mergedWith(
                CallOptions(timeout: const Duration(seconds: 30)),
              ),
            );
          });
          return BankingTransferResult.fromProto(response);
        } on GrpcError catch (e) {
          print('gRPC Error during domestic transfer: ${e.code} - ${e.message}');
          throw ServerException(
            message: 'Failed to initiate bank transfer: ${e.message ?? "Unknown error"}',
          );
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Domestic transfer attempt $attempt due to: $error');
      },
      shouldRetry: _shouldRetryTransfer,
    );
  }

  @override
  Future<BankingTransferResult> initiateUsernameTransfer({
    required String fromUserId,
    required String toUsername,
    required int amount,
    String? currency,
    String? narration,
    String? idempotencyKey,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = banking.UsernameTransferRequest(
          userId: fromUserId,
          toUsername: toUsername,
          amount: Int64(amount),
          currency: currency ?? 'NGN',
          narration: narration ?? 'Transfer to @$toUsername',
          idempotencyKey: idempotencyKey ?? _uuid.v4(),
        );

        try {
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.initiateUsernameTransfer(
              request,
              options: callOptions.mergedWith(
                CallOptions(timeout: const Duration(seconds: 30)),
              ),
            );
          });
          return BankingTransferResult.fromProto(response);
        } on GrpcError catch (e) {
          print('gRPC Error during username transfer: ${e.code} - ${e.message}');
          throw ServerException(
            message: 'Failed to transfer to @$toUsername: ${e.message ?? "Unknown error"}',
          );
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Username transfer attempt $attempt due to: $error');
      },
      shouldRetry: _shouldRetryTransfer,
    );
  }

  @override
  Future<BankingTransferResult> initiatePhoneTransfer({
    required String fromUserId,
    required String toPhone,
    required int amount,
    String? currency,
    String? narration,
    String? idempotencyKey,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = banking.PhoneTransferRequest(
          userId: fromUserId,
          toPhone: toPhone,
          amount: Int64(amount),
          currency: currency ?? 'NGN',
          narration: narration ?? 'Transfer to $toPhone',
          idempotencyKey: idempotencyKey ?? _uuid.v4(),
        );

        try {
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.initiatePhoneTransfer(
              request,
              options: callOptions.mergedWith(
                CallOptions(timeout: const Duration(seconds: 30)),
              ),
            );
          });
          return BankingTransferResult.fromProto(response);
        } on GrpcError catch (e) {
          print('gRPC Error during phone transfer: ${e.code} - ${e.message}');
          throw ServerException(
            message: 'Failed to transfer to $toPhone: ${e.message ?? "Unknown error"}',
          );
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Phone transfer attempt $attempt due to: $error');
      },
      shouldRetry: _shouldRetryTransfer,
    );
  }

  @override
  Future<BankingTransferResult> getTransferStatus(String reference) async {
    final request = banking.GetTransferStatusRequest(reference: reference);

    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getTransferStatus(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });
      return BankingTransferResult.fromProto(response);
    } on GrpcError catch (e) {
      print('gRPC Error getting transfer status: ${e.code} - ${e.message}');
      throw ServerException(
        message: 'Failed to get transfer status: ${e.message ?? "Unknown error"}',
      );
    }
  }

  @override
  Future<List<BankingTransferResult>> getUserTransfers({
    required String userId,
    int? limit,
    int? offset,
  }) async {
    final request = banking.GetUserTransfersRequest(
      userId: userId,
      limit: limit ?? 20,
      offset: offset ?? 0,
    );

    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getUserTransfers(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      if (!response.success) {
        throw ServerException(
          message: response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to get transfer history',
        );
      }

      return response.transfers.map((t) => BankingTransferResult(
        success: true,
        transferId: t.id,
        reference: t.reference,
        status: t.status,
        amount: t.amount.toInt(),
        fee: t.fee.toInt(),
        createdAt: t.hasCreatedAt() ? t.createdAt.toDateTime() : null,
      )).toList();
    } on GrpcError catch (e) {
      print('gRPC Error getting user transfers: ${e.code} - ${e.message}');
      throw ServerException(
        message: 'Failed to get transfer history: ${e.message ?? "Unknown error"}',
      );
    }
  }

  /// Custom retry logic for transfers - don't retry business logic failures
  bool _shouldRetryTransfer(dynamic error) {
    if (error is ServerException) {
      final message = error.message?.toLowerCase() ?? '';
      if (message.contains('insufficient') ||
          message.contains('invalid') ||
          message.contains('not found') ||
          message.contains('denied') ||
          message.contains('duplicate') ||
          message.contains('limit') ||
          message.contains('frozen')) {
        return false;
      }
    }
    return true;
  }
}
