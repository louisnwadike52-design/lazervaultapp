import 'package:equatable/equatable.dart';

enum BarcodePaymentStatus {
  pending,
  paid,
  cancelled,
  expired,
}

extension BarcodePaymentStatusExtension on BarcodePaymentStatus {
  String get displayName {
    switch (this) {
      case BarcodePaymentStatus.pending:
        return 'Pending';
      case BarcodePaymentStatus.paid:
        return 'Paid';
      case BarcodePaymentStatus.cancelled:
        return 'Cancelled';
      case BarcodePaymentStatus.expired:
        return 'Expired';
    }
  }

  static BarcodePaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BarcodePaymentStatus.pending;
      case 'paid':
        return BarcodePaymentStatus.paid;
      case 'cancelled':
        return BarcodePaymentStatus.cancelled;
      case 'expired':
        return BarcodePaymentStatus.expired;
      default:
        return BarcodePaymentStatus.pending;
    }
  }
}

class BarcodePaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String fullName;
  final String barcodeCode;
  final double amount;
  final String currency;
  final String description;
  final BarcodePaymentStatus status;
  final DateTime createdAt;
  final DateTime expiresAt;
  final DateTime? paidAt;

  const BarcodePaymentEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.fullName,
    required this.barcodeCode,
    required this.amount,
    required this.currency,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
    this.paidAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isPending => status == BarcodePaymentStatus.pending;
  bool get isPaid => status == BarcodePaymentStatus.paid;

  @override
  List<Object?> get props => [
        id,
        userId,
        username,
        fullName,
        barcodeCode,
        amount,
        currency,
        description,
        status,
        createdAt,
        expiresAt,
        paidAt,
      ];
}
