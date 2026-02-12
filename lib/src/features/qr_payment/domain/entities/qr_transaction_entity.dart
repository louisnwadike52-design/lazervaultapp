import 'package:equatable/equatable.dart';

enum QRTransactionStatus {
  completed,
  failed,
}

extension QRTransactionStatusExtension on QRTransactionStatus {
  String get displayName {
    switch (this) {
      case QRTransactionStatus.completed:
        return 'Completed';
      case QRTransactionStatus.failed:
        return 'Failed';
    }
  }

  static QRTransactionStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return QRTransactionStatus.completed;
      case 'failed':
        return QRTransactionStatus.failed;
      default:
        return QRTransactionStatus.completed;
    }
  }
}

class QRTransactionEntity extends Equatable {
  final String id;
  final String qrId;
  final String payerId;
  final String payerUsername;
  final String payerName;
  final String recipientId;
  final String recipientUsername;
  final String recipientName;
  final double amount;
  final String currency;
  final String description;
  final String referenceNumber;
  final QRTransactionStatus status;
  final DateTime createdAt;

  const QRTransactionEntity({
    required this.id,
    required this.qrId,
    required this.payerId,
    required this.payerUsername,
    required this.payerName,
    required this.recipientId,
    required this.recipientUsername,
    required this.recipientName,
    required this.amount,
    required this.currency,
    required this.description,
    required this.referenceNumber,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        qrId,
        payerId,
        payerUsername,
        payerName,
        recipientId,
        recipientUsername,
        recipientName,
        amount,
        currency,
        description,
        referenceNumber,
        status,
        createdAt,
      ];
}
