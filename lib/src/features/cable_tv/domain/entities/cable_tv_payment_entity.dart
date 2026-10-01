import 'package:equatable/equatable.dart';

class CableTVPaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String billType;
  final String providerId;
  final String reference;
  final double amount;
  final String status;
  final String customerNumber;
  final String metadata;
  final String createdAt;
  final double newBalance;
  final String renewalDate;
  final String customerName;

  /// Why the money came back, when it did. Empty on a purchase that was never
  /// refunded.
  ///
  /// The backend keeps a refunded purchase as `status = failed` — the PURCHASE
  /// failed, which is correct — and records the refund here. A receipt that
  /// renders only `status` therefore tells a customer "Failed" about ₦X they
  /// already have back. See core/utils/bill_receipt_status.dart.
  final String refundSource;

  const CableTVPaymentEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.billType,
    required this.providerId,
    required this.reference,
    required this.amount,
    required this.status,
    required this.customerNumber,
    required this.metadata,
    required this.createdAt,
    required this.newBalance,
    required this.renewalDate,
    required this.customerName,
    this.refundSource = '',
  });

  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
  bool get isPending => status == 'pending' || status == 'processing';
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
        customerName,
        refundSource,
      ];
}
