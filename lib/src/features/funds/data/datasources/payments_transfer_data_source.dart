import 'dart:convert';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_success_prediction.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments;

/// GetPaymentHistory serves `created_at` as unix SECONDS (core-payments
/// payment_handler writes `CreatedAt.Unix()`); interpreting the value as
/// milliseconds rendered every transfer as January 1970. Robust to either
/// unit so a future backend switch to milliseconds cannot regress dates.
DateTime _paymentTimestamp(dynamic raw) {
  final n = raw is int ? raw : (raw?.toInt() ?? 0);
  if (n <= 0) return DateTime.now();
  // Values below ~Nov 2286 in seconds are seconds; larger ⇒ already millis.
  return n < 100000000000
      ? DateTime.fromMillisecondsSinceEpoch(n * 1000)
      : DateTime.fromMillisecondsSinceEpoch(n);
}

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
  final String? providerReference; // Flutterwave/provider tx reference for receipt compliance

  // History-only enrichment (populated by getPaymentHistory from the payment
  // record). Lets a receipt built from a HISTORY row show the real
  // counterparty, currency, narration, and infer direction — instead of
  // defaulting everything. Null on the send-funds result path.
  final String? currency;
  final String? description;
  final String? counterpartyAccount;
  final String? sourceAccountId;
  final String? destinationAccountId;
  final String? destinationBankName;
  final String? type; // "internal" | "external"

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
    this.providerReference,
    this.currency,
    this.description,
    this.counterpartyAccount,
    this.sourceAccountId,
    this.destinationAccountId,
    this.destinationBankName,
    this.type,
  });

  /// Create result from SendFundsResponse (Transfer Gateway API)
  factory PaymentsTransferResult.fromSendFundsResponse(payments.SendFundsResponse response) {
    final hasPayment = response.hasPayment();
    final payment = hasPayment ? response.payment : null;

    // Extract provider reference from payment metadata JSON
    String? providerRef;
    if (payment?.hasMetadata() == true && payment!.metadata.isNotEmpty) {
      try {
        final meta = jsonDecode(payment.metadata) as Map<String, dynamic>;
        providerRef = meta['provider_reference'] as String? ??
            meta['provider_ref'] as String?;
      } catch (_) {}
    }

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
          ? DateTime.tryParse(payment.createdAt)?.toLocal()
          : null,
      newBalance: response.hasNewBalance() ? response.newBalance : null,
      recipientName: response.hasRecipientName() ? response.recipientName : null,
      providerReference: providerRef,
    );
  }
}

/// Abstract interface for payments transfer operations
abstract class IPaymentsTransferDataSource {
  /// Send funds with PIN verification (unified for internal and external transfers)
  /// Uses Transfer Gateway (port 50076) -> Core-Payment-Service (port 50053)
  Future<PaymentsTransferResult> sendFunds({
    required String fromAccountId,      // Source account to debit
    required String toAccountNumber,    // Destination account number (for external transfers)
    String? toAccountId,               // Account UUID (for internal transfers)
    required String type,               // "internal" or "external" - PRIMARY KEY
    required double amount,             // Amount in major units (e.g., 100.50)
    required String description,        // Transfer description
    required String transactionId,      // Transaction ID for PIN verification
    required String verificationToken,  // Token from TransactionPinService
    String? destinationBankCode,        // External: bank code (NUBAN sort code)
    String? beneficiaryName,            // External: recipient name as shown on the bank account
    DateTime? scheduledAt,              // Optional: schedule for future execution
    int? expenseCategory,              // Budget category enum value selected by user
    String? flow,                       // Funnel flow ("long"|"short") → x-flow metadata for backend metrics
  });

  /// Get payment/transfer history
  Future<({List<PaymentsTransferResult> transfers, int total})> getPaymentHistory({
    required String accountId,
    int? limit,
    int? offset,
  });

  /// EXTERNAL transfers (bank payouts) to a specific recipient account, sourced
  /// from core-payments' payment history — the only place that links an external
  /// transfer to its destination bank account. The accounts-service ledger writes
  /// an empty counterparty on the hold-capture row, so per-recipient history can't
  /// find external transfers there; this supplements it. Returns mapped
  /// UnifiedTransactions; best-effort (callers should tolerate an empty list).
  Future<List<UnifiedTransaction>> getRecipientExternalPayments({
    required String accountId,
    required String recipientAccountNumber,
    int limit,
  });

  /// Informational, READ-ONLY success prediction for an EXTERNAL transfer.
  /// Returns null on any error (the feature is non-blocking and best-effort).
  Future<TransferSuccessPrediction?> getTransferSuccessPrediction({
    required String bankCode,
    required String accountNumber,
  });

  /// Fee (in minor units) the backend WILL charge — the authoritative quote
  /// (platform config + CBN/Flutterwave provider fee). No client-side estimate.
  Future<int> getTransferFee({
    required int amountMinorUnits,
    required String currency,
    required String transferType,
  });

  /// ALL of the account's EXTERNAL bank transfers (any status: pending /
  /// processing / completed / failed / reversed), as UnifiedTransactions. These
  /// live only in core-payments `payments` — a failed/pending external transfer
  /// never reaches the accounts-service ledger, so it wouldn't appear in history
  /// without this. Best-effort: returns [] on error.
  Future<List<UnifiedTransaction>> getExternalTransferHistory({
    required String accountId,
    int limit,
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
    String? toAccountId,  // Account UUID for internal transfers (preferred)
    required String type,  // "internal" or "external" - PRIMARY KEY
    required double amount,
    required String description,
    required String transactionId,
    required String verificationToken,
    String? destinationBankCode,
    String? beneficiaryName,
    DateTime? scheduledAt,
    int? expenseCategory,
    String? flow,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = payments.SendFundsRequest(
          fromAccountId: fromAccountId,
          toAccountNumber: toAccountNumber,
          toAccountId: toAccountId ?? '',
          type: type,  // "internal" or "external"
          amount: amount,
          description: description,
          transactionId: transactionId,
          verificationToken: verificationToken,
          destinationBankCode: destinationBankCode ?? '',
          beneficiaryName: beneficiaryName ?? '',
          expenseCategory: expenseCategory ?? 0,
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
            // Funnel attribution for backend Prometheus metrics
            // (send_funds_attempts_total / send_funds_duration_seconds flow label).
            // Backend bounds this to long|short|unknown.
            mergedOptions = mergedOptions.mergedWith(
              CallOptions(metadata: {
                'x-flow': (flow == 'long' || flow == 'short') ? flow! : 'unknown',
              }),
            );

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
  Future<({List<PaymentsTransferResult> transfers, int total})> getPaymentHistory({
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

      final transfers = response.transactions.map((p) {
        // `p.amount` is a decimal string in MAJOR units — convert to kobo to
        // honour PaymentsTransferResult's minor-unit contract. (The previous
        // expression `(double.tryParse(p.amount) ?? 0.0 * 100).toInt()` had an
        // operator-precedence bug that stored truncated MAJOR units, rendering
        // wallet history amounts 100x too small.)
        final major = p.amount.isNotEmpty ? (double.tryParse(p.amount) ?? 0.0) : 0.0;
        // Direction: the queried account is the SENDER when it is the source.
        final isIncoming = p.destinationAccountId.isNotEmpty &&
            p.destinationAccountId == accountId;
        return PaymentsTransferResult(
          success: true,
          transferId: p.id.isNotEmpty ? p.id : null,
          reference: p.reference.isNotEmpty ? p.reference : null,
          status: p.status.isNotEmpty ? p.status : null,
          amount: (major * 100).round(),
          fee: p.hasFee() ? (p.fee * 100).round() : null,
          createdAt: _paymentTimestamp(p.createdAt),
          currency: p.currency.isNotEmpty ? p.currency : null,
          description: p.description.isNotEmpty ? p.description : null,
          // Counterparty = the OTHER account. For an outgoing transfer that's
          // the destination; for an incoming one we only have the source
          // account number on the wire (no source name field).
          recipientName: p.destinationName.isNotEmpty ? p.destinationName : null,
          counterpartyAccount: isIncoming
              ? (p.sourceAccountNumber.isNotEmpty ? p.sourceAccountNumber : null)
              : (p.destinationAccountNumber.isNotEmpty
                  ? p.destinationAccountNumber
                  : null),
          sourceAccountId:
              p.sourceAccountId.isNotEmpty ? p.sourceAccountId : null,
          destinationAccountId:
              p.destinationAccountId.isNotEmpty ? p.destinationAccountId : null,
          destinationBankName:
              p.destinationBankName.isNotEmpty ? p.destinationBankName : null,
          type: p.transferType.isNotEmpty
              ? p.transferType
              : (p.type.isNotEmpty ? p.type : null),
        );
      }).toList();

      return (transfers: transfers, total: response.total);
    } on GrpcError catch (e) {
      print('gRPC Error getting payment history: ${e.code} - ${e.message}');
      throw ServerException(
        message: 'Failed to get payment history: ${e.message ?? "Unknown error"}',
      );
    }
  }

  @override
  Future<List<UnifiedTransaction>> getRecipientExternalPayments({
    required String accountId,
    required String recipientAccountNumber,
    int limit = 200,
  }) async {
    final wantedAccount = recipientAccountNumber.trim();
    if (wantedAccount.isEmpty) return const [];

    // Scope by the authenticated user (JWT) only — deliberately NOT by source
    // account. Recipient history should list transfers to this recipient from
    // ANY of the user's accounts; filtering by a single source account can hide
    // external transfers that were sent from a different account.
    final request = payments.GetPaymentHistoryRequest(
      limit: limit,
      offset: 0,
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

      final out = <UnifiedTransaction>[];
      for (final p in response.transactions) {
        // EXTERNAL transfers only: they carry a destination bank code. Internal
        // transfers are already covered by the accounts-service counterparty
        // query, so excluding them here avoids duplicate rows.
        final isExternal = p.destinationBankCode.trim().isNotEmpty;
        if (!isExternal) continue;
        if (p.destinationAccountNumber.trim() != wantedAccount) continue;

        out.add(UnifiedTransaction(
          id: p.id,
          serviceType: TransactionServiceType.transfer,
          title: p.destinationName.isNotEmpty ? p.destinationName : 'Transfer',
          description: p.description.isNotEmpty ? p.description : null,
          amount: double.tryParse(p.amount) ?? 0.0,
          currency: p.currency.isNotEmpty ? p.currency : 'NGN',
          createdAt: _paymentTimestamp(p.createdAt),
          status: _mapPaymentStatus(p.status),
          flow: TransactionFlow.outgoing,
          transactionReference: p.reference.isNotEmpty ? p.reference : null,
          counterpartyName:
              p.destinationName.isNotEmpty ? p.destinationName : null,
          counterpartyAccount: p.destinationAccountNumber.isNotEmpty
              ? p.destinationAccountNumber
              : null,
        ));
      }
      return out;
    } on GrpcError catch (e) {
      // Best-effort supplement — never fail the recipient history because of it.
      print('gRPC Error getting recipient external payments: ${e.code} - ${e.message}');
      return const [];
    } catch (e) {
      print('Error getting recipient external payments: $e');
      return const [];
    }
  }

  @override
  Future<List<UnifiedTransaction>> getExternalTransferHistory({
    required String accountId,
    int limit = 200,
  }) async {
    if (accountId.isEmpty) return const [];
    final request = payments.GetPaymentHistoryRequest(
      accountId: accountId,
      limit: limit,
      offset: 0,
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

      final out = <UnifiedTransaction>[];
      for (final p in response.transactions) {
        // EXTERNAL transfers only (they carry a destination bank code). Internal
        // C2C transfers already reach the accounts-service ledger, so merging
        // them here would double-count; dedupe by reference covers completed
        // external transfers that appear in BOTH sources.
        final isExternal = p.destinationBankCode.trim().isNotEmpty;
        if (!isExternal) continue;
        final name = p.destinationName.trim();
        out.add(UnifiedTransaction(
          id: p.id,
          serviceType: TransactionServiceType.transfer,
          title: name.isNotEmpty ? 'Transfer to $name' : 'Bank transfer',
          description: p.description.isNotEmpty ? p.description : null,
          amount: double.tryParse(p.amount) ?? 0.0,
          currency: p.currency.isNotEmpty ? p.currency : 'NGN',
          createdAt: _paymentTimestamp(p.createdAt),
          status: _mapPaymentStatus(p.status),
          flow: TransactionFlow.outgoing,
          transactionReference: p.reference.isNotEmpty ? p.reference : null,
          counterpartyName: name.isNotEmpty ? name : null,
          counterpartyAccount: p.destinationAccountNumber.isNotEmpty
              ? p.destinationAccountNumber
              : null,
          metadata: {
            if (p.destinationBankName.isNotEmpty)
              'bank_name': p.destinationBankName,
            if (p.destinationBankCode.isNotEmpty)
              'bank_code': p.destinationBankCode,
          },
        ));
      }
      return out;
    } on GrpcError catch (e) {
      print('gRPC Error getting external transfer history: ${e.code} - ${e.message}');
      return const [];
    } catch (e) {
      print('Error getting external transfer history: $e');
      return const [];
    }
  }

  /// Map core-payments status strings to the unified status enum, normalizing
  /// the provider's "success(ful)" terminal state to "completed".
  static UnifiedTransactionStatus _mapPaymentStatus(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'successful':
      case 'completed':
        return UnifiedTransactionStatus.completed;
      case 'processing':
        return UnifiedTransactionStatus.processing;
      case 'scheduled':
        return UnifiedTransactionStatus.scheduled;
      case 'failed':
      case 'error':
        return UnifiedTransactionStatus.failed;
      case 'cancelled':
      case 'canceled':
        return UnifiedTransactionStatus.cancelled;
      case 'refunded':
      case 'reversed':
        return UnifiedTransactionStatus.refunded;
      default:
        return UnifiedTransactionStatus.pending;
    }
  }

  @override
  Future<TransferSuccessPrediction?> getTransferSuccessPrediction({
    required String bankCode,
    required String accountNumber,
  }) async {
    // Best-effort + non-blocking: never throw to the caller. A failure here
    // must never interfere with the transfer the user is about to confirm.
    if (bankCode.isEmpty || accountNumber.isEmpty) return null;

    final request = payments.GetTransferSuccessPredictionRequest(
      bankCode: bankCode,
      accountNumber: accountNumber,
    );

    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getTransferSuccessPrediction(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 8)),
          ),
        );
      });

      final knownSinceUnix = response.recipientKnownSinceUnix.toInt();
      return TransferSuccessPrediction(
        bankAvailabilityPct: response.bankAvailabilityPct,
        bankBand: response.bankBand.isNotEmpty ? response.bankBand : 'unknown',
        bankSampleSize: response.bankSampleSize,
        recipientTrustBand: response.recipientTrustBand.isNotEmpty
            ? response.recipientTrustBand
            : 'unknown',
        priorTransferCount: response.priorTransferCount,
        knownSince: knownSinceUnix > 0
            ? DateTime.fromMillisecondsSinceEpoch(knownSinceUnix * 1000)
            : null,
        blocklisted: response.blocklisted,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting transfer success prediction: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Error getting transfer success prediction: $e');
      return null;
    }
  }

  @override
  Future<int> getTransferFee({
    required int amountMinorUnits,
    required String currency,
    required String transferType,
  }) async {
    final request = payments.GetTransferFeeRequest(
      transferType: transferType,
      amount: Int64(amountMinorUnits),
      currency: currency,
    );
    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      return await _client.getTransferFee(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 20)),
        ),
      );
    });
    if (!response.success) {
      throw Exception(response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Fee unavailable');
    }
    return response.fee.toInt();
  }

  /// Custom retry logic for transfers - don't retry business logic failures
  /// or any error from operations that consume single-use verification tokens.
  bool _shouldRetryTransfer(dynamic error) {
    if (error is ServerException) {
      final message = error.message?.toLowerCase() ?? '';
      if (message.contains('insufficient') ||
          message.contains('invalid') ||
          message.contains('not found') ||
          message.contains('denied') ||
          message.contains('duplicate') ||
          message.contains('limit') ||
          message.contains('frozen') ||
          message.contains('could not be completed') ||
          message.contains('already used') ||
          message.contains('token') ||
          message.contains('verification')) {
        return false;
      }
    }
    return true;
  }
}
