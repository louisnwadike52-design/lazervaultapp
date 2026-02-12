import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments;

/// Transfer types supported by the payments service
enum TransferType {
  internal,  // C2C within LazerVault
  domestic,  // To external Nigerian bank
  international, // Cross-border
  username,  // By LazerTag username
  phone,     // By phone number
}

/// Result of a transfer operation from payments service
class PaymentsTransferResult {
  final bool success;
  final String? transferId;
  final String? reference;
  final String? status;
  final int? amount;        // Amount in minor units (kobo)
  final int? fee;
  final String? errorCode;
  final String? errorMessage;
  final DateTime? createdAt;
  final double? newBalance;  // New balance in major units
  final String? recipientName;
  final DateTime? scheduledAt;

  PaymentsTransferResult({
    required this.success,
    this.transferId,
    this.reference,
    this.status,
    this.amount,
    this.fee,
    this.errorCode,
    this.errorMessage,
    this.createdAt,
    this.newBalance,
    this.recipientName,
    this.scheduledAt,
  });

  /// Create result from SendFundsResponse (Transfer Gateway API)
  factory PaymentsTransferResult.fromSendFundsResponse(payments.SendFundsResponse response) {
    final hasPayment = response.hasPayment();
    final payment = hasPayment ? response.payment : null;

    return PaymentsTransferResult(
      success: hasPayment,
      transferId: payment?.id.isNotEmpty == true ? payment!.id : null,
      reference: payment?.hasReference() == true ? payment!.reference : null,
      status: payment?.hasStatus() == true ? payment!.status : null,
      amount: payment?.hasAmount() == true ? (payment!.amount * 100).toInt() : null,
      fee: null, // Fee not included in current response
      errorCode: null,
      errorMessage: response.hasMessage() && response.message.isNotEmpty ? response.message : null,
      createdAt: payment?.hasCreatedAt() == true && payment!.createdAt.isNotEmpty
          ? DateTime.tryParse(payment.createdAt)
          : null,
      newBalance: response.hasNewBalance() ? response.newBalance : null,
      recipientName: response.hasRecipientName() ? response.recipientName : null,
    );
  }
}

/// Abstract interface for payments transfer operations
abstract class IPaymentsTransferDataSource {
  /// Send funds with PIN verification (unified for internal and external transfers)
  /// Uses Transfer Gateway (port 50076) -> Core-Payment-Service (port 50053)
  Future<PaymentsTransferResult> sendFunds({
    required String fromAccountId,      // Source account to debit
    required String toAccountNumber,    // Destination account number (internal or external)
    required double amount,             // Amount in major units (e.g., 100.50)
    required String description,        // Transfer description
    required String transactionId,      // Transaction ID for PIN verification
    required String verificationToken,  // Token from TransactionPinService
    DateTime? scheduledAt,              // Optional: schedule for future execution
  });

  /// Get payment/transfer history
  Future<List<PaymentsTransferResult>> getPaymentHistory({
    required String accountId,
    int? limit,
    int? offset,
  });
}

/// Batch item for batch transfers
class BatchTransferItem {
  final String toAccountNumber;
  final double amount;
  final String description;

  BatchTransferItem({
    required this.toAccountNumber,
    required this.amount,
    required this.description,
  });

  /// Convert to proto BatchTransferItem
  payments.BatchTransferItem toProto() {
    return payments.BatchTransferItem(
      toAccountNumber: toAccountNumber,
      amount: amount,
      description: description,
    );
  }
}

/// Implementation of payments transfer data source using PaymentsServiceClient
/// This uses Transfer Gateway (port 50076) → Core-Payment-Service (port 50053)
class PaymentsTransferDataSourceImpl implements IPaymentsTransferDataSource {
  final payments.PaymentsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;
  PaymentsTransferDataSourceImpl(
    this._client,
    this._callOptionsHelper,
  );

  @override
  Future<PaymentsTransferResult> sendFunds({
    required String fromAccountId,
    required String toAccountNumber,
    required double amount,
    required String description,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = payments.SendFundsRequest(
          fromAccountId: fromAccountId,
          toAccountNumber: toAccountNumber,
          amount: amount,
          description: description,
          transactionId: transactionId,
          verificationToken: verificationToken,
        );

        try {
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();

            // Add scheduled_at as gRPC metadata if present
            var mergedOptions = callOptions.mergedWith(
              CallOptions(timeout: const Duration(seconds: 30)),
            );
            if (scheduledAt != null) {
              mergedOptions = mergedOptions.mergedWith(
                CallOptions(metadata: {
                  'x-scheduled-at': scheduledAt.toUtc().toIso8601String(),
                }),
              );
            }

            return await _client.sendFunds(request, options: mergedOptions);
          });

          // Parse scheduledAt from metadata JSON if status is "scheduled"
          DateTime? parsedScheduledAt = scheduledAt;
          final result = PaymentsTransferResult.fromSendFundsResponse(response);
          return PaymentsTransferResult(
            success: result.success,
            transferId: result.transferId,
            reference: result.reference,
            status: result.status,
            amount: result.amount,
            fee: result.fee,
            errorCode: result.errorCode,
            errorMessage: result.errorMessage,
            createdAt: result.createdAt,
            newBalance: result.newBalance,
            recipientName: result.recipientName,
            scheduledAt: result.status == 'scheduled' ? parsedScheduledAt : null,
          );
        } on GrpcError catch (e) {
          print('gRPC Error during sendFunds: ${e.code} - ${e.message}');
          throw ServerException(
            message: 'Failed to send funds: ${e.message ?? "Unknown error"}',
          );
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Send funds attempt $attempt due to: $error');
      },
      shouldRetry: _shouldRetryTransfer,
    );
  }

  @override
  Future<List<PaymentsTransferResult>> getPaymentHistory({
    required String accountId,
    int? limit,
    int? offset,
  }) async {
    final request = payments.GetPaymentHistoryRequest(
      accountId: accountId,
      limit: limit ?? 20,
      offset: offset ?? 0,
    );

    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getPaymentHistory(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      return response.payments.map((p) => PaymentsTransferResult(
        success: true,
        transferId: p.id.isNotEmpty ? p.id : null,
        reference: p.hasReference() ? p.reference : null,
        status: p.hasStatus() ? p.status : null,
        amount: p.hasAmount() ? (p.amount * 100).toInt() : null,
        fee: null,
        createdAt: p.hasCreatedAt() && p.createdAt.isNotEmpty
            ? DateTime.tryParse(p.createdAt)
            : null,
      )).toList();
    } on GrpcError catch (e) {
      print('gRPC Error getting payment history: ${e.code} - ${e.message}');
      throw ServerException(
        message: 'Failed to get payment history: ${e.message ?? "Unknown error"}',
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
