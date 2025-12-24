import 'package:equatable/equatable.dart';

class TagPayEntity extends Equatable {
  final String id;
  final String userId;
  final String tagPay;
  final String displayName;
  final String? avatarUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TagPayEntity({
    required this.id,
    required this.userId,
    required this.tagPay,
    required this.displayName,
    this.avatarUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        tagPay,
        displayName,
        avatarUrl,
        isActive,
        createdAt,
        updatedAt,
      ];

  String get formattedTagPay => '@$tagPay';
}

enum TagPayTransactionStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  refunded,
}

enum TagPayTransactionType {
  send,
  receive,
  request,
  requestFulfilled,
}

class TagPayTransactionEntity extends Equatable {
  final String id;
  final String senderId;
  final String senderTagPay;
  final String senderName;
  final String receiverId;
  final String receiverTagPay;
  final String receiverName;
  final double amount;
  final String currency;
  final String? description;
  final TagPayTransactionStatus status;
  final TagPayTransactionType type;
  final String referenceNumber;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TagPayTransactionEntity({
    required this.id,
    required this.senderId,
    required this.senderTagPay,
    required this.senderName,
    required this.receiverId,
    required this.receiverTagPay,
    required this.receiverName,
    required this.amount,
    required this.currency,
    this.description,
    required this.status,
    required this.type,
    required this.referenceNumber,
    required this.createdAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        senderTagPay,
        senderName,
        receiverId,
        receiverTagPay,
        receiverName,
        amount,
        currency,
        description,
        status,
        type,
        referenceNumber,
        createdAt,
        completedAt,
      ];

  String get formattedAmount => '$currency ${amount.toStringAsFixed(2)}';

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  String get statusDisplay {
    switch (status) {
      case TagPayTransactionStatus.pending:
        return 'Pending';
      case TagPayTransactionStatus.processing:
        return 'Processing';
      case TagPayTransactionStatus.completed:
        return 'Completed';
      case TagPayTransactionStatus.failed:
        return 'Failed';
      case TagPayTransactionStatus.cancelled:
        return 'Cancelled';
      case TagPayTransactionStatus.refunded:
        return 'Refunded';
    }
  }
}

enum MoneyRequestStatus {
  pending,
  accepted,
  declined,
  expired,
  cancelled,
}

class MoneyRequestEntity extends Equatable {
  final String id;
  final String requesterId;
  final String requesterTagPay;
  final String requesterName;
  final String requesteeId;
  final String requesteeTagPay;
  final String requesteeName;
  final double amount;
  final String currency;
  final String? description;
  final MoneyRequestStatus status;
  final DateTime createdAt;
  final DateTime? respondedAt;
  final DateTime expiresAt;

  const MoneyRequestEntity({
    required this.id,
    required this.requesterId,
    required this.requesterTagPay,
    required this.requesterName,
    required this.requesteeId,
    required this.requesteeTagPay,
    required this.requesteeName,
    required this.amount,
    required this.currency,
    this.description,
    required this.status,
    required this.createdAt,
    this.respondedAt,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [
        id,
        requesterId,
        requesterTagPay,
        requesterName,
        requesteeId,
        requesteeTagPay,
        requesteeName,
        amount,
        currency,
        description,
        status,
        createdAt,
        respondedAt,
        expiresAt,
      ];

  String get formattedAmount => '$currency ${amount.toStringAsFixed(2)}';

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  String get statusDisplay {
    switch (status) {
      case MoneyRequestStatus.pending:
        return 'Pending';
      case MoneyRequestStatus.accepted:
        return 'Accepted';
      case MoneyRequestStatus.declined:
        return 'Declined';
      case MoneyRequestStatus.expired:
        return 'Expired';
      case MoneyRequestStatus.cancelled:
        return 'Cancelled';
    }
  }
}
