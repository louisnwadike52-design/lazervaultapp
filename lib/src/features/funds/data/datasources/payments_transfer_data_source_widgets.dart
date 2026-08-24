part of 'payments_transfer_data_source.dart';

/// Lightweight snapshot of a transfer's live status (from GetTransferStatus),
/// used by the receipt screen to reflect pending → completed / failed.
class TransferStatusSnapshot {
  final String status;
  final String? failureReason;
  final double? amount; // major units, if the backend returned it
  final double? fee; // major units
  final DateTime? completedAt;

  const TransferStatusSnapshot({
    required this.status,
    this.failureReason,
    this.amount,
    this.fee,
    this.completedAt,
  });

  static const _terminal = {
    'completed', 'success', 'successful', 'delivered',
    'failed', 'cancelled', 'canceled', 'declined', 'rejected',
    'reversed', 'refunded',
  };
  bool get isTerminal => _terminal.contains(status.toLowerCase());
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

  /// Current status of a transfer by its reference — drives the receipt screen's
  /// pull-to-refresh / live reconciliation (pending → processing → completed /
  /// failed). Returns null if the transfer can't be found or the lookup fails.
  Future<TransferStatusSnapshot?> getTransferStatus({required String reference});

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
