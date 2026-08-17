part of 'group_account_models.dart';

// Payout Schedule Model
class PayoutScheduleModel extends PayoutSchedule {
  const PayoutScheduleModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.position,
    required super.scheduledDate,
    required super.expectedAmount,
    required super.status,
    super.receivedDate,
    super.actualAmount,
    super.notes,
  });

  factory PayoutScheduleModel.fromJson(Map<String, dynamic> json) {
    return PayoutScheduleModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      position: json['position'] as int,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      expectedAmount: (json['expectedAmount'] as num).toDouble(),
      status: PayoutStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => PayoutStatus.pending,
      ),
      receivedDate: json['receivedDate'] != null 
          ? DateTime.parse(json['receivedDate'] as String) 
          : null,
      actualAmount: json['actualAmount'] != null 
          ? (json['actualAmount'] as num).toDouble() 
          : null,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'position': position,
      'scheduledDate': scheduledDate.toIso8601String(),
      'expectedAmount': expectedAmount,
      'status': status.toString().split('.').last,
      'receivedDate': receivedDate?.toIso8601String(),
      'actualAmount': actualAmount,
      'notes': notes,
    };
  }

  factory PayoutScheduleModel.fromEntity(PayoutSchedule entity) {
    return PayoutScheduleModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      position: entity.position,
      scheduledDate: entity.scheduledDate,
      expectedAmount: entity.expectedAmount,
      status: entity.status,
      receivedDate: entity.receivedDate,
      actualAmount: entity.actualAmount,
      notes: entity.notes,
    );
  }

  @override
  PayoutScheduleModel copyWith({
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
    return PayoutScheduleModel(
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

// Public Group Detail Model
class PublicGroupDetailModel extends PublicGroupDetail {
  const PublicGroupDetailModel({
    required super.group,
    super.statistics,
    super.topContributors,
    required super.isMember,
  });

  factory PublicGroupDetailModel.fromEntity(PublicGroupDetail entity) {
    return PublicGroupDetailModel(
      group: entity.group,
      statistics: entity.statistics,
      topContributors: entity.topContributors,
      isMember: entity.isMember,
    );
  }
}

// Payout Transaction Model
class PayoutTransactionModel extends PayoutTransaction {
  const PayoutTransactionModel({
    required super.id,
    required super.contributionId,
    required super.groupId,
    required super.recipientUserId,
    required super.recipientUserName,
    required super.amount,
    required super.currency,
    required super.payoutDate,
    required super.status,
    super.transactionId,
    super.paymentMethod,
    super.failureReason,
    super.metadata,
  });

  factory PayoutTransactionModel.fromJson(Map<String, dynamic> json) {
    return PayoutTransactionModel(
      id: json['id'] as String,
      contributionId: json['contributionId'] as String,
      groupId: json['groupId'] as String,
      recipientUserId: json['recipientUserId'] as String,
      recipientUserName: json['recipientUserName'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      payoutDate: DateTime.parse(json['payoutDate'] as String),
      status: PayoutTransactionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => PayoutTransactionStatus.pending,
      ),
      transactionId: json['transactionId'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      failureReason: json['failureReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contributionId': contributionId,
      'groupId': groupId,
      'recipientUserId': recipientUserId,
      'recipientUserName': recipientUserName,
      'amount': amount,
      'currency': currency,
      'payoutDate': payoutDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'transactionId': transactionId,
      'paymentMethod': paymentMethod,
      'failureReason': failureReason,
      'metadata': metadata,
    };
  }

  factory PayoutTransactionModel.fromEntity(PayoutTransaction entity) {
    return PayoutTransactionModel(
      id: entity.id,
      contributionId: entity.contributionId,
      groupId: entity.groupId,
      recipientUserId: entity.recipientUserId,
      recipientUserName: entity.recipientUserName,
      amount: entity.amount,
      currency: entity.currency,
      payoutDate: entity.payoutDate,
      status: entity.status,
      transactionId: entity.transactionId,
      paymentMethod: entity.paymentMethod,
      failureReason: entity.failureReason,
      metadata: entity.metadata,
    );
  }

  @override
  PayoutTransactionModel copyWith({
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
    return PayoutTransactionModel(
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
