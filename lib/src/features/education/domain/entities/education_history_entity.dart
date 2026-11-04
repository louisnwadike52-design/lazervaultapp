import 'education_pin_entity.dart';

class EducationHistoryEntity {
  final String id;
  final String providerId;
  final String providerName;
  final String serviceId;
  final String variationCode;
  final int quantity;
  final double amount;
  final String status;
  final String reference;
  final String createdAt;
  final List<EducationPinEntity> pins;
  final String phoneNumber;
  final String billersCode;

  /// `bill_payments.refund_source`, non-empty when the money came back on a
  /// row still stored as `failed`. Carried so the history chip and the receipt
  /// can agree; see core/utils/bill_receipt_status.dart for the rule.
  final String refundSource;

  const EducationHistoryEntity({
    required this.id,
    required this.providerId,
    required this.providerName,
    required this.serviceId,
    required this.variationCode,
    required this.quantity,
    required this.amount,
    required this.status,
    required this.reference,
    required this.createdAt,
    required this.pins,
    required this.phoneNumber,
    required this.billersCode,
    this.refundSource = '',
  });
}
