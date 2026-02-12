import 'package:equatable/equatable.dart';

enum QRPaymentStatus {
  pending,
  paid,
  cancelled,
  expired,
}

extension QRPaymentStatusExtension on QRPaymentStatus {
  String get displayName {
    switch (this) {
      case QRPaymentStatus.pending:
        return 'Pending';
      case QRPaymentStatus.paid:
        return 'Paid';
      case QRPaymentStatus.cancelled:
        return 'Cancelled';
      case QRPaymentStatus.expired:
        return 'Expired';
    }
  }

  static QRPaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return QRPaymentStatus.pending;
      case 'paid':
        return QRPaymentStatus.paid;
      case 'cancelled':
        return QRPaymentStatus.cancelled;
      case 'expired':
        return QRPaymentStatus.expired;
      default:
        return QRPaymentStatus.pending;
    }
  }
}

enum QRPaymentType {
  dynamic,
  static,
}

extension QRPaymentTypeExtension on QRPaymentType {
  String get displayName {
    switch (this) {
      case QRPaymentType.dynamic:
        return 'Dynamic';
      case QRPaymentType.static:
        return 'Static';
    }
  }

  static QRPaymentType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'static':
        return QRPaymentType.static;
      default:
        return QRPaymentType.dynamic;
    }
  }
}

class QRPaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String fullName;
  final String qrCode;
  final double amount;
  final String currency;
  final String description;
  final QRPaymentType qrType;
  final QRPaymentStatus status;
  final DateTime createdAt;
  final DateTime expiresAt;
  final DateTime? paidAt;

  const QRPaymentEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.fullName,
    required this.qrCode,
    required this.amount,
    required this.currency,
    required this.description,
    required this.qrType,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
    this.paidAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isPending => status == QRPaymentStatus.pending;
  bool get isPaid => status == QRPaymentStatus.paid;
  bool get isStatic => qrType == QRPaymentType.static;

  @override
  List<Object?> get props => [
        id,
        userId,
        username,
        fullName,
        qrCode,
        amount,
        currency,
        description,
        qrType,
        status,
        createdAt,
        expiresAt,
        paidAt,
      ];
}
