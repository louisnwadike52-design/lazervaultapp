part of 'group_entities.dart';

// Payout Schedule entity
class PayoutSchedule extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final int position; // Position in rotation (1, 2, 3, etc.)
  final DateTime scheduledDate;
  final double expectedAmount;
  final PayoutStatus status;
  final DateTime? receivedDate;
  final double? actualAmount;
  final String? notes;

  const PayoutSchedule({
    required this.id,
    required this.userId,
    required this.userName,
    required this.position,
    required this.scheduledDate,
    required this.expectedAmount,
    required this.status,
    this.receivedDate,
    this.actualAmount,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        position,
        scheduledDate,
        expectedAmount,
        status,
        receivedDate,
        actualAmount,
        notes,
      ];

  bool get isCompleted => status == PayoutStatus.completed;
  bool get isPending => status == PayoutStatus.pending;
  bool get isOverdue => status == PayoutStatus.pending && DateTime.now().isAfter(scheduledDate);

  PayoutSchedule copyWith({
    String? id,
    String? userId,
    String? userName,
    int? position,
    DateTime? scheduledDate,
    double? expectedAmount,
    PayoutStatus? status,
    DateTime? receivedDate,
    double? actualAmount,
    String? notes,
  }) {
    return PayoutSchedule(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      position: position ?? this.position,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      status: status ?? this.status,
      receivedDate: receivedDate ?? this.receivedDate,
      actualAmount: actualAmount ?? this.actualAmount,
      notes: notes ?? this.notes,
    );
  }
}

// Payout Transaction entity
class PayoutTransaction extends Equatable {
  final String id;
  final String contributionId;
  final String groupId;
  final String recipientUserId;
  final String recipientUserName;
  final double amount;
  final String currency;
  final DateTime payoutDate;
  final PayoutTransactionStatus status;
  final String? transactionId;
  final String? paymentMethod;
  final String? failureReason;
  final Map<String, dynamic>? metadata;

  const PayoutTransaction({
    required this.id,
    required this.contributionId,
    required this.groupId,
    required this.recipientUserId,
    required this.recipientUserName,
    required this.amount,
    required this.currency,
    required this.payoutDate,
    required this.status,
    this.transactionId,
    this.paymentMethod,
    this.failureReason,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        contributionId,
        groupId,
        recipientUserId,
        recipientUserName,
        amount,
        currency,
        payoutDate,
        status,
        transactionId,
        paymentMethod,
        failureReason,
        metadata,
      ];

  bool get isCompleted => status == PayoutTransactionStatus.completed;
  bool get isPending => status == PayoutTransactionStatus.pending;
  bool get isFailed => status == PayoutTransactionStatus.failed;

  PayoutTransaction copyWith({
    String? id,
    String? contributionId,
    String? groupId,
    String? recipientUserId,
    String? recipientUserName,
    double? amount,
    String? currency,
    DateTime? payoutDate,
    PayoutTransactionStatus? status,
    String? transactionId,
    String? paymentMethod,
    String? failureReason,
    Map<String, dynamic>? metadata,
  }) {
    return PayoutTransaction(
      id: id ?? this.id,
      contributionId: contributionId ?? this.contributionId,
      groupId: groupId ?? this.groupId,
      recipientUserId: recipientUserId ?? this.recipientUserId,
      recipientUserName: recipientUserName ?? this.recipientUserName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      payoutDate: payoutDate ?? this.payoutDate,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      failureReason: failureReason ?? this.failureReason,
      metadata: metadata ?? this.metadata,
    );
  }
}
