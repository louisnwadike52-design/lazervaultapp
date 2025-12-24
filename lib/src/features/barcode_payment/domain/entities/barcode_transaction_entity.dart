import 'package:equatable/equatable.dart';

enum BarcodeTransactionStatus {
  completed,
  failed,
}

extension BarcodeTransactionStatusExtension on BarcodeTransactionStatus {
  String get displayName {
    switch (this) {
      case BarcodeTransactionStatus.completed:
        return 'Completed';
      case BarcodeTransactionStatus.failed:
        return 'Failed';
    }
  }

  static BarcodeTransactionStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return BarcodeTransactionStatus.completed;
      case 'failed':
        return BarcodeTransactionStatus.failed;
      default:
        return BarcodeTransactionStatus.completed;
    }
  }
}

class BarcodeTransactionEntity extends Equatable {
  final String id;
  final String barcodeId;
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
  final BarcodeTransactionStatus status;
  final DateTime createdAt;

  const BarcodeTransactionEntity({
    required this.id,
    required this.barcodeId,
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
        barcodeId,
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
