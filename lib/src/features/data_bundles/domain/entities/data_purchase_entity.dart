import 'dart:convert';
import 'package:equatable/equatable.dart';

/// User-facing status buckets for a data purchase. The backend emits
/// finer substates (`awaiting_webhook`, `awaiting_verification`, etc.);
/// the UI only ever sees these five categories via
/// [DataPurchaseEntity.statusCategory].
enum DataPurchaseStatusCategory {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

class DataPurchaseEntity extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String reference;
  final double amount;
  final String status;
  final String phoneNumber;
  final String dataPlan;
  final double newBalance;
  final double commissionEarned;
  final String providerReference;
  final String createdAt;

  /// Backend bill-type code: `data` for domestic bundles, `intl_data`
  /// for Reloadly-backed international bundles. Populated when the
  /// entity is hydrated from the unified bill-payment history endpoint;
  /// empty for live-purchase responses (distinguished by the screen the
  /// user came from).
  final String billType;

  /// Non-empty when the row is `failed` but the fund hold was released
  /// (auto_released, vtpass_failed, etc.) — the history badge uses this
  /// to render "Refunded" instead of "Failed".
  final String refundSource;

  /// Currency code of [amount]. For intl rows this is the user's active
  /// locale currency (e.g. NGN) because the wallet was debited in that
  /// currency. Empty when the backend didn't set it — callers fall back
  /// to the user's LocaleManager.currentCurrency.
  final String currency;

  /// Raw metadata JSON from the backend `bill_payments.metadata` column.
  /// Parsed lazily via [metadataMap]. Intl rows carry FX breakdown:
  /// `dest_amount`, `dest_currency`, `fx_rate_used`,
  /// `reloadly_sender_amount`, `reloadly_sender_currency`, etc.
  final String metadata;

  const DataPurchaseEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.reference,
    required this.amount,
    required this.status,
    required this.phoneNumber,
    required this.dataPlan,
    required this.newBalance,
    required this.commissionEarned,
    required this.providerReference,
    required this.createdAt,
    this.billType = '',
    this.refundSource = '',
    this.currency = '',
    this.metadata = '',
  });

  /// Canonical status bucket the UI should render. Collapses the many
  /// backend substates (`awaiting_webhook`, `awaiting_verification`,
  /// `enrichment_needed`, `failover_submitted`) into the four user-
  /// facing categories — "webhook" is an implementation detail users
  /// shouldn't see. Mirrors the airtime `AirtimeTransactionStatus`
  /// collapse so lists/receipts read the same across utilities.
  DataPurchaseStatusCategory get statusCategory {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
      case 'successful':
        return DataPurchaseStatusCategory.completed;
      case 'failed':
        // A failed row whose money was returned via `refund_source`
        // should read as refunded, not failed — matches the receipt's
        // isRefundedViaSource override in other flows.
        if (refundSource.isNotEmpty) {
          return DataPurchaseStatusCategory.refunded;
        }
        return DataPurchaseStatusCategory.failed;
      case 'refunded':
      case 'reversed':
      case 'refund_pending':
        return DataPurchaseStatusCategory.refunded;
      case 'processing':
      case 'awaiting_webhook':
      case 'awaiting-webhook':
      case 'awaitingwebhook':
      case 'awaiting_verification':
      case 'awaitingverification':
      case 'enrichment_needed':
      case 'enrichmentneeded':
      case 'failover_submitted':
      case 'failoversubmitted':
        return DataPurchaseStatusCategory.processing;
      case 'pending':
      default:
        return DataPurchaseStatusCategory.pending;
    }
  }

  /// User-facing label — always one of "Completed", "Processing",
  /// "Pending", "Failed", "Refunded". Never leaks internal states like
  /// "Awaiting Webhook".
  String get displayStatus {
    switch (statusCategory) {
      case DataPurchaseStatusCategory.completed:
        return 'Completed';
      case DataPurchaseStatusCategory.processing:
        return 'Processing';
      case DataPurchaseStatusCategory.pending:
        return 'Pending';
      case DataPurchaseStatusCategory.failed:
        return 'Failed';
      case DataPurchaseStatusCategory.refunded:
        return 'Refunded';
    }
  }

  bool get isCompleted => statusCategory == DataPurchaseStatusCategory.completed;
  bool get isFailed => statusCategory == DataPurchaseStatusCategory.failed;
  bool get isProcessing =>
      statusCategory == DataPurchaseStatusCategory.processing;
  bool get isPending =>
      statusCategory == DataPurchaseStatusCategory.pending ||
      statusCategory == DataPurchaseStatusCategory.processing;
  bool get isRefunded =>
      statusCategory == DataPurchaseStatusCategory.refunded;

  String get networkCode {
    if (dataPlan.isEmpty) return '';
    final sep = dataPlan.indexOf('_');
    if (sep <= 0) return dataPlan.toUpperCase();
    return dataPlan.substring(0, sep).toUpperCase();
  }

  String get networkName {
    final code = networkCode;
    if (code.isEmpty) return '';
    if (code == 'MTN' || code == 'GLO') return code;
    return code[0] + code.substring(1).toLowerCase();
  }

  /// International-vs-domestic signal for the history UI. Derived from
  /// the backend `bill_type` column — `intl_data` rows are Reloadly
  /// purchases, everything else (typically `data`) is domestic.
  bool get isInternational => billType.toLowerCase() == 'intl_data';

  /// Parsed metadata map — empty when the raw JSON is empty or invalid.
  Map<String, dynamic> get metadataMap {
    if (metadata.isEmpty) return const {};
    try {
      final decoded = jsonDecode(metadata);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
    return const {};
  }

  /// Destination amount (e.g. 200 KES for a Safaricom bundle) for intl
  /// rows. Null when unavailable (domestic or pre-metadata rows).
  double? get destAmount {
    final v = metadataMap['dest_amount'] ?? metadataMap['delivered_amount'];
    if (v is num) return v.toDouble();
    return null;
  }

  /// Destination currency code (e.g. KES). Empty when unavailable.
  String get destCurrency {
    final v = metadataMap['dest_currency'] ?? metadataMap['delivered_currency'];
    return v?.toString() ?? '';
  }

  /// Effective currency of [amount] — prefers the explicit [currency] set
  /// on construction, then falls back to the `sender_currency` in metadata.
  /// Empty string means "use caller's fallback" (typically LocaleManager).
  String get resolvedCurrency {
    if (currency.isNotEmpty) return currency;
    final v = metadataMap['sender_currency'] ?? metadataMap['senderCurrency'];
    return v?.toString() ?? '';
  }

  @override
  List<Object?> get props =>
      [id, reference, amount, status, phoneNumber, billType, currency];
}
