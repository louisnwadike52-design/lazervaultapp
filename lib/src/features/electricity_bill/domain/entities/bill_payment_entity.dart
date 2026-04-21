import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Color;

/// Mirrors the backend's 9 possible `bill_payments.status` values. Keeping
/// them distinct (rather than collapsing refund-flavours to `failed`)
/// lets the UI pick the right icon/message and lets the recent-payments
/// strip render e.g. "Refunded" instead of a stale "Pending".
enum BillPaymentStatus {
  pending,
  processing,
  awaitingWebhook,
  completed,
  failed,
  refundPending,
  refunded,
  refundFailed,
  reversed,
}

extension BillPaymentStatusExtension on BillPaymentStatus {
  String get displayName {
    switch (this) {
      case BillPaymentStatus.pending:
        return 'Pending';
      case BillPaymentStatus.processing:
        return 'Processing';
      case BillPaymentStatus.awaitingWebhook:
        // User-facing: hide the technical webhook semantics. The row is
        // still being worked on server-side; "Processing" is the
        // friendliest label that also matches what the user sees for
        // the analogous `processing` status.
        return 'Processing';
      case BillPaymentStatus.completed:
        return 'Completed';
      case BillPaymentStatus.failed:
        return 'Failed';
      case BillPaymentStatus.refundPending:
        return 'Refund Pending';
      case BillPaymentStatus.refunded:
        return 'Refunded';
      case BillPaymentStatus.refundFailed:
        return 'Refund Failed';
      case BillPaymentStatus.reversed:
        return 'Reversed';
    }
  }

  /// True when this is any pre-terminal in-flight state — useful for
  /// "still waiting for provider" UI gating.
  bool get isInFlight =>
      this == BillPaymentStatus.pending ||
      this == BillPaymentStatus.processing ||
      this == BillPaymentStatus.awaitingWebhook;

  /// True when the buy was reversed/refunded/failed — distinct from
  /// plain `failed` because we want different copy per flavour.
  bool get isRefundFlow =>
      this == BillPaymentStatus.refundPending ||
      this == BillPaymentStatus.refunded ||
      this == BillPaymentStatus.refundFailed ||
      this == BillPaymentStatus.reversed;

  static BillPaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BillPaymentStatus.pending;
      case 'processing':
        return BillPaymentStatus.processing;
      case 'awaiting_webhook':
      case 'awaiting-webhook':
      case 'awaitingwebhook':
      // Post-charge in-flight states the backend reaches via MarkStatusWithCAS.
      // The user sees all three as "Processing", so we collapse them into the
      // closest enum member (awaitingWebhook) rather than adding 2 more
      // singleton values the UI would just treat identically.
      case 'awaiting_verification':
      case 'awaitingverification':
      case 'enrichment_needed':
      case 'enrichmentneeded':
        return BillPaymentStatus.awaitingWebhook;
      case 'failover_submitted':
      case 'failoversubmitted':
        return BillPaymentStatus.processing;
      case 'completed':
      case 'success':
      case 'successful':
        return BillPaymentStatus.completed;
      case 'failed':
        return BillPaymentStatus.failed;
      case 'refund_pending':
      case 'refund-pending':
      case 'refundpending':
        return BillPaymentStatus.refundPending;
      case 'refunded':
        return BillPaymentStatus.refunded;
      case 'refund_failed':
      case 'refund-failed':
      case 'refundfailed':
        return BillPaymentStatus.refundFailed;
      case 'reversed':
        return BillPaymentStatus.reversed;
      default:
        return BillPaymentStatus.pending;
    }
  }
}

enum MeterType {
  prepaid,
  postpaid,
}

extension MeterTypeExtension on MeterType {
  String get displayName {
    switch (this) {
      case MeterType.prepaid:
        return 'Prepaid';
      case MeterType.postpaid:
        return 'Postpaid';
    }
  }

  static MeterType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'prepaid':
        return MeterType.prepaid;
      case 'postpaid':
        return MeterType.postpaid;
      default:
        return MeterType.prepaid;
    }
  }
}

class BillPaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String providerId;
  final String providerCode;
  final String providerName;
  final String meterNumber;
  final String customerName;
  final String? customerAddress;
  final MeterType meterType;
  final double amount;
  final String currency;
  final double serviceFee;
  final double totalAmount;
  final BillPaymentStatus status;
  final String? token;
  final double? units;
  final String paymentGateway;
  final String referenceNumber;
  final String? gatewayReference;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final DateTime? failedAt;

  /// Non-empty when the backend reversed the charge even if [status] is
  /// still [BillPaymentStatus.failed] — e.g. `auto_released`,
  /// `vtpass_failed`, `reloadly_refunded_upstream`, `admin_manual`,
  /// `pre_charge_release`. Surfaced so the history/receipt UIs can render
  /// a "Refunded" chip instead of a bare "Failed".
  final String? refundSource;

  const BillPaymentEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.providerCode,
    required this.providerName,
    required this.meterNumber,
    required this.customerName,
    this.customerAddress,
    required this.meterType,
    required this.amount,
    required this.currency,
    required this.serviceFee,
    required this.totalAmount,
    required this.status,
    this.token,
    this.units,
    required this.paymentGateway,
    required this.referenceNumber,
    this.gatewayReference,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.failedAt,
    this.refundSource,
  });

  /// Creates an empty entity for use as a placeholder (e.g., null safety fallback).
  factory BillPaymentEntity.empty() {
    final now = DateTime.now();
    return BillPaymentEntity(
      id: '',
      userId: '',
      providerId: '',
      providerCode: '',
      providerName: '',
      meterNumber: '',
      customerName: '',
      meterType: MeterType.prepaid,
      amount: 0,
      currency: 'NGN',
      serviceFee: 0,
      totalAmount: 0,
      status: BillPaymentStatus.pending,
      paymentGateway: '',
      referenceNumber: '',
      createdAt: now,
      updatedAt: now,
    );
  }

  bool get isPending => status == BillPaymentStatus.pending;
  bool get isProcessing => status == BillPaymentStatus.processing;
  bool get isAwaitingWebhook => status == BillPaymentStatus.awaitingWebhook;
  bool get isCompleted => status == BillPaymentStatus.completed;
  bool get isFailed => status == BillPaymentStatus.failed;
  bool get isRefunded => status == BillPaymentStatus.refunded;
  bool get isRefundPending => status == BillPaymentStatus.refundPending;
  bool get isRefundFailed => status == BillPaymentStatus.refundFailed;
  bool get isReversed => status == BillPaymentStatus.reversed;
  bool get isPrepaid => meterType == MeterType.prepaid;
  bool get isPostpaid => meterType == MeterType.postpaid;
  bool get hasToken => token != null && token!.isNotEmpty;

  /// True when the backend recorded a refund reason (non-empty
  /// `refund_source`) on a `failed` row — the user has been made whole
  /// even though the status column is still "failed". UIs should show
  /// "Refunded" instead of "Failed" in this case.
  bool get isRefundedViaSource =>
      status == BillPaymentStatus.failed &&
      refundSource != null &&
      refundSource!.isNotEmpty;

  /// Refund-aware status label for lists. Rows where status is still
  /// `failed` but the backend already returned the money ([refundSource]
  /// populated) render as "Refunded" instead of "Failed", so the
  /// list-level chip agrees with the receipt-page hero copy.
  String get displayStatus {
    if (isRefundedViaSource) return 'Refunded';
    return status.displayName;
  }

  /// Electricity bills don't carry a phone number in the current proto; kept
  /// here so generic history UIs can read the field optionally.
  String? get phoneNumber => null;

  /// True whenever the row represents anything on the refund pipeline —
  /// used by the history actions sheet to render a dedicated badge next
  /// to the status chip. Also true for rows that are still `failed` but
  /// carry a non-empty `refund_source`, since the user has been made
  /// whole even though the status column hasn't moved.
  bool get hasRefundActivity =>
      status.isRefundFlow ||
      (refundSource != null && refundSource!.isNotEmpty);

  /// Short user-facing label for the refund badge.
  String get refundDisplayLabel {
    switch (status) {
      case BillPaymentStatus.refundPending:
        return 'Refund in progress';
      case BillPaymentStatus.refunded:
        return 'Refunded';
      case BillPaymentStatus.refundFailed:
        return 'Refund failed';
      case BillPaymentStatus.reversed:
        return 'Reversed';
      default:
        // Status is not on the refund pipeline (typically `failed`), but
        // `refund_source` tells us the user got their money back anyway.
        // `auto_released` is the most common case — pre-charge hold that
        // never settled, so we call it out specifically.
        if (refundSource != null && refundSource!.isNotEmpty) {
          return refundSource == 'auto_released' ? 'Auto released' : 'Refunded';
        }
        return '';
    }
  }

  /// Accent color for the refund badge (mirrors the status-chip palette
  /// used elsewhere so the two read as related).
  Color? get refundBadgeColor {
    switch (status) {
      case BillPaymentStatus.refundPending:
        return const Color(0xFFFB923C);
      case BillPaymentStatus.refunded:
      case BillPaymentStatus.reversed:
        return const Color(0xFF6B7280);
      case BillPaymentStatus.refundFailed:
        return const Color(0xFFEF4444);
      default:
        // Gray for any source-based refund (auto_released, admin_manual,
        // reloadly_refunded_upstream, etc.) — same palette as `refunded`
        // so the two read as related in the UI.
        if (refundSource != null && refundSource!.isNotEmpty) {
          return const Color(0xFF6B7280);
        }
        return null;
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        providerId,
        providerCode,
        providerName,
        meterNumber,
        customerName,
        customerAddress,
        meterType,
        amount,
        currency,
        serviceFee,
        totalAmount,
        status,
        token,
        units,
        paymentGateway,
        referenceNumber,
        gatewayReference,
        errorMessage,
        createdAt,
        updatedAt,
        completedAt,
        failedAt,
        refundSource,
      ];
}
