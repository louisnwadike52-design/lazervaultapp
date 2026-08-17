part of 'balance_websocket_service.dart';

/// Balance update event received from WebSocket
class BalanceUpdateEvent {
  final String userId;
  final String accountId;
  final String countryCode;
  final double newBalance;
  final double availableBalance;
  final String currency;
  final String eventType;
  final String? transactionId;
  final String? reference;
  final double? amount;
  final String? narration;
  final String status; // "pending", "processing", "completed", "failed"
  final int timestamp;

  BalanceUpdateEvent({
    required this.userId,
    required this.accountId,
    required this.countryCode,
    required this.newBalance,
    required this.availableBalance,
    required this.currency,
    required this.eventType,
    this.transactionId,
    this.reference,
    this.amount,
    this.narration,
    required this.status,
    required this.timestamp,
  });

  factory BalanceUpdateEvent.fromJson(Map<String, dynamic> json) {
    // new_balance / available_balance default to 0 for events that don't
    // carry a balance snapshot — e.g. insurance_policy_renewed,
    // insurance_claim_status_changed. Those events still need to flow
    // through the same parser so we route them downstream.
    double n(dynamic v) => v == null ? 0.0 : (v as num).toDouble();
    return BalanceUpdateEvent(
      userId: json['user_id'] as String? ?? '',
      accountId: json['account_id'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
      newBalance: n(json['new_balance']),
      availableBalance: n(json['available_balance']),
      currency: json['currency'] as String? ?? '',
      eventType: json['event_type'] as String? ?? '',
      transactionId: json['transaction_id'] as String?,
      reference: json['reference'] as String?,
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      narration: json['narration'] as String?,
      status: json['status'] as String? ?? 'completed',
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'BalanceUpdateEvent(userId: $userId, accountId: $accountId, newBalance: $newBalance, eventType: $eventType, status: $status)';
  }
}

/// Insurance lifecycle event pushed from ws-balance-service.
/// Covers both purchase saga transitions (completed/failed/refunded/
/// refund_failed) and post-purchase events (policy_renewed). The
/// distinguishing fields are `eventType` (the wire string) and
/// `purchaseId` (the InsurancePurchase.ID — Flutter cubits filter on
/// this when they need to react to a specific policy).
class InsurancePurchaseEvent {
  final String userId;
  final String purchaseId; // transaction_id on the wire
  final String eventType;  // insurance_purchase_completed | ... | insurance_policy_renewed
  final String status;     // pending | processing | completed | failed | renewed
  final String reference;  // policy number for renewals, purchase ref otherwise
  final String narration;  // free-form: new expiry ISO for renewals, error msg for failures
  final double amount;
  final String currency;
  final int timestamp;

  InsurancePurchaseEvent({
    required this.userId,
    required this.purchaseId,
    required this.eventType,
    required this.status,
    required this.reference,
    required this.narration,
    required this.amount,
    required this.currency,
    required this.timestamp,
  });

  factory InsurancePurchaseEvent.fromBalanceEvent(BalanceUpdateEvent b) {
    return InsurancePurchaseEvent(
      userId: b.userId,
      purchaseId: b.transactionId ?? '',
      eventType: b.eventType,
      status: b.status,
      reference: b.reference ?? '',
      narration: b.narration ?? '',
      amount: b.amount ?? 0.0,
      currency: b.currency,
      timestamp: b.timestamp,
    );
  }

  bool get isRenewal => eventType == 'insurance_policy_renewed';
  bool get isPurchaseTerminal =>
      eventType == 'insurance_purchase_completed' ||
      eventType == 'insurance_purchase_failed' ||
      eventType == 'insurance_purchase_refunded' ||
      eventType == 'insurance_purchase_refund_failed';

  @override
  String toString() =>
      'InsurancePurchaseEvent($eventType purchase=$purchaseId status=$status)';
}

/// Insurance claim status event pushed by the claim reconciler when
/// MyCover advances a claim to approved / rejected / settled. The
/// transaction_id field carries the claim ID.
class InsuranceClaimEvent {
  final String userId;
  final String claimId;
  final String status;    // approved | rejected | settled | etc.
  final String narration; // upstream label / reason text
  final int timestamp;

  InsuranceClaimEvent({
    required this.userId,
    required this.claimId,
    required this.status,
    required this.narration,
    required this.timestamp,
  });

  factory InsuranceClaimEvent.fromBalanceEvent(BalanceUpdateEvent b) {
    return InsuranceClaimEvent(
      userId: b.userId,
      claimId: b.transactionId ?? '',
      status: b.status,
      narration: b.narration ?? '',
      timestamp: b.timestamp,
    );
  }

  @override
  String toString() =>
      'InsuranceClaimEvent(claim=$claimId status=$status)';
}

/// Connection states for WebSocket
enum WebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// Lock-fund lifecycle event pushed from ws-balance-service. Used
/// by [LockFundsCubit] (or any other listener) to refresh the
/// lock-funds list within seconds of a worker-driven state change
/// (auto-renew at 02:00, maturity at 14:30, etc.) without waiting
/// for a manual pull-to-refresh.
class LockFundLifecycleEvent {
  final String userId;
  final String lockFundId;
  final String accountId;
  final String eventType; // lock_fund.created | .matured | .renewed | .renewal_skipped
  final String name;
  final double amount;
  final String currency;
  final double upfrontInterestPaid;
  final String newUnlockDate;
  final String reason;
  final int timestamp;

  LockFundLifecycleEvent({
    required this.userId,
    required this.lockFundId,
    required this.accountId,
    required this.eventType,
    required this.name,
    required this.amount,
    required this.currency,
    required this.upfrontInterestPaid,
    required this.newUnlockDate,
    required this.reason,
    required this.timestamp,
  });

  factory LockFundLifecycleEvent.fromJson(Map<String, dynamic> json) {
    double n(dynamic v) => v == null ? 0.0 : (v as num).toDouble();
    return LockFundLifecycleEvent(
      userId: json['user_id'] as String? ?? '',
      lockFundId: json['lock_fund_id'] as String? ?? '',
      accountId: json['account_id'] as String? ?? '',
      eventType: json['event_type'] as String? ?? '',
      name: json['name'] as String? ?? '',
      amount: n(json['amount']),
      currency: json['currency'] as String? ?? '',
      upfrontInterestPaid: n(json['upfront_interest_paid']),
      newUnlockDate: json['new_unlock_date'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  String toString() =>
      'LockFundLifecycleEvent($eventType lock=$lockFundId user=$userId reason=$reason)';
}
