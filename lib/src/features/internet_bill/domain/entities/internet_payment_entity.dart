import 'package:equatable/equatable.dart';

class InternetPaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String billType;
  final String providerId;
  final String reference;
  final double amount;
  final String status;

  /// Why the money came back, when it did. Empty on a purchase that was never
  /// refunded.
  ///
  /// The backend keeps a refunded purchase as `status = failed` — the PURCHASE
  /// failed, which is correct — and records the refund here. A receipt that
  /// renders only `status` tells a customer "Failed" about money they already
  /// have back. See core/utils/bill_receipt_status.dart.
  final String refundSource;

  final String customerNumber;
  final String metadata;
  final String createdAt;
  final double newBalance;
  final String renewalDate;

  const InternetPaymentEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.billType,
    required this.providerId,
    required this.reference,
    required this.amount,
    required this.status,
    this.refundSource = '',
    required this.customerNumber,
    required this.metadata,
    required this.createdAt,
    required this.newBalance,
    required this.renewalDate,
  });

  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
  // Async backend returns 'processing' for an in-flight (webhook-pending)
  // payment — fold it into "pending" so the receipt renders the pending state
  // (and reconciles) instead of the red "Payment Failed" fall-through.
  bool get isPending =>
      status == 'pending' ||
      status == 'processing' ||
      status == 'awaiting_webhook';
  bool get isProcessing => status == 'processing';

  @override
  List<Object?> get props => [
        id,
        userId,
        accountId,
        billType,
        providerId,
        reference,
        amount,
        status,
        customerNumber,
        metadata,
        createdAt,
        newBalance,
        renewalDate,
        refundSource,
      ];
}
