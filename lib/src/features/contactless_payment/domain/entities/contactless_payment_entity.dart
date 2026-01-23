import 'package:equatable/equatable.dart';

/// Payment session entity representing a pending NFC payment request
class PaymentSessionEntity extends Equatable {
  final String id;
  final String receiverId;
  final String receiverUsername;
  final String receiverName;
  final String receiverAccountId;
  final double amount;
  final String currency;
  final String? category;
  final String? description;
  final PaymentSessionStatus status;
  final String? payerId;
  final String? payerName;
  final DateTime createdAt;
  final DateTime expiresAt;
  final DateTime? readAt;
  final DateTime? completedAt;

  const PaymentSessionEntity({
    required this.id,
    required this.receiverId,
    required this.receiverUsername,
    required this.receiverName,
    required this.receiverAccountId,
    required this.amount,
    required this.currency,
    this.category,
    this.description,
    required this.status,
    this.payerId,
    this.payerName,
    required this.createdAt,
    required this.expiresAt,
    this.readAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        id,
        receiverId,
        receiverUsername,
        receiverName,
        receiverAccountId,
        amount,
        currency,
        category,
        description,
        status,
        payerId,
        payerName,
        createdAt,
        expiresAt,
        readAt,
        completedAt,
      ];

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isPending => status == PaymentSessionStatus.pending;
  bool get isRead => status == PaymentSessionStatus.read;
  bool get isProcessing => status == PaymentSessionStatus.processing;
  bool get isCompleted => status == PaymentSessionStatus.completed;
  bool get isCancelled => status == PaymentSessionStatus.cancelled;
}

enum PaymentSessionStatus {
  pending,
  read,
  processing,
  completed,
  cancelled,
  expired,
}

/// Contactless transaction entity representing a completed NFC payment
class ContactlessTransactionEntity extends Equatable {
  final String id;
  final String sessionId;
  final String payerId;
  final String payerUsername;
  final String payerName;
  final String payerAccountId;
  final String receiverId;
  final String receiverUsername;
  final String receiverName;
  final String receiverAccountId;
  final double amount;
  final String currency;
  final String? category;
  final String? description;
  final String referenceNumber;
  final TransactionStatus status;
  final DateTime createdAt;

  const ContactlessTransactionEntity({
    required this.id,
    required this.sessionId,
    required this.payerId,
    required this.payerUsername,
    required this.payerName,
    required this.payerAccountId,
    required this.receiverId,
    required this.receiverUsername,
    required this.receiverName,
    required this.receiverAccountId,
    required this.amount,
    required this.currency,
    this.category,
    this.description,
    required this.referenceNumber,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        sessionId,
        payerId,
        payerUsername,
        payerName,
        payerAccountId,
        receiverId,
        receiverUsername,
        receiverName,
        receiverAccountId,
        amount,
        currency,
        category,
        description,
        referenceNumber,
        status,
        createdAt,
      ];
}

enum TransactionStatus {
  completed,
  failed,
  reversed,
}

/// NFC payload data that gets transmitted between devices
class NfcPayloadDataEntity extends Equatable {
  final String type;
  final String sessionId;
  final String receiverId;
  final String receiverUsername;
  final String receiverName;
  final double amount;
  final String currency;
  final String? category;
  final String? description;
  final int expiresAt;
  final String signature;

  const NfcPayloadDataEntity({
    required this.type,
    required this.sessionId,
    required this.receiverId,
    required this.receiverUsername,
    required this.receiverName,
    required this.amount,
    required this.currency,
    this.category,
    this.description,
    required this.expiresAt,
    required this.signature,
  });

  @override
  List<Object?> get props => [
        type,
        sessionId,
        receiverId,
        receiverUsername,
        receiverName,
        amount,
        currency,
        category,
        description,
        expiresAt,
        signature,
      ];

  bool get isExpired =>
      DateTime.now().millisecondsSinceEpoch > expiresAt * 1000;
}
