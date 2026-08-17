part of 'group_account_models.dart';

// Contribution Model
class ContributionModel extends Contribution {
  const ContributionModel({
    required super.id,
    required super.groupId,
    required super.title,
    required super.description,
    required super.targetAmount,
    required super.currentAmount,
    required super.currency,
    required super.deadline,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    required super.createdBy,
    required super.payments,
    super.metadata,
    super.type,
    super.frequency,
    super.regularAmount,
    super.nextPaymentDate,
    super.startDate,
    super.totalCycles,
    super.currentCycle,
    super.payoutSchedule,
    super.currentPayoutRecipient,
    super.nextPayoutDate,
    super.payoutHistory,
    super.autoPayEnabled,
    super.penaltyAmount,
    super.gracePeriodDays,
    super.allowPartialPayments,
    super.minimumBalance,
    super.autoPayoutEnabled,
    super.members,
  });

  factory ContributionModel.fromJson(Map<String, dynamic> json) {
    return ContributionModel(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      targetAmount: (json['targetAmount'] as num).toDouble(),
      currentAmount: (json['currentAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: ContributionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ContributionStatus.active,
      ),
      createdBy: json['createdBy'] as String,
      payments: (json['payments'] as List<dynamic>?)
              ?.map((x) => ContributionPaymentModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      metadata: json['metadata'] as Map<String, dynamic>?,
      type: json['type'] != null
          ? ContributionType.values.firstWhere(
              (e) => e.toString().split('.').last == json['type'],
              orElse: () => ContributionType.oneTime,
            )
          : ContributionType.oneTime,
      frequency: json['frequency'] != null
          ? ContributionFrequency.values.firstWhere(
              (e) => e.toString().split('.').last == json['frequency'],
              orElse: () => ContributionFrequency.monthly,
            )
          : null,
      regularAmount: json['regularAmount'] != null 
          ? (json['regularAmount'] as num).toDouble() 
          : null,
      nextPaymentDate: json['nextPaymentDate'] != null 
          ? DateTime.parse(json['nextPaymentDate'] as String) 
          : null,
      startDate: json['startDate'] != null 
          ? DateTime.parse(json['startDate'] as String) 
          : null,
      totalCycles: json['totalCycles'] as int?,
      currentCycle: json['currentCycle'] as int?,
      payoutSchedule: (json['payoutSchedule'] as List<dynamic>?)
              ?.map((x) => PayoutScheduleModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      currentPayoutRecipient: json['currentPayoutRecipient'] as String?,
      nextPayoutDate: json['nextPayoutDate'] != null 
          ? DateTime.parse(json['nextPayoutDate'] as String) 
          : null,
      payoutHistory: (json['payoutHistory'] as List<dynamic>?)
              ?.map((x) => PayoutTransactionModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      autoPayEnabled: json['autoPayEnabled'] as bool? ?? false,
      penaltyAmount: json['penaltyAmount'] != null 
          ? (json['penaltyAmount'] as num).toDouble() 
          : null,
      gracePeriodDays: json['gracePeriodDays'] as int?,
      allowPartialPayments: json['allowPartialPayments'] as bool? ?? true,
      minimumBalance: json['minimumBalance'] != null
          ? (json['minimumBalance'] as num).toDouble()
          : null,
      autoPayoutEnabled: json['autoPayoutEnabled'] as bool? ?? false,
      members: (json['members'] as List<dynamic>?)
              ?.map((x) => ContributionMemberModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupId': groupId,
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'currency': currency,
      'deadline': deadline.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'createdBy': createdBy,
      'payments': payments.map((x) => (x as ContributionPaymentModel).toJson()).toList(),
      'metadata': metadata,
      'type': type.toString().split('.').last,
      'frequency': frequency?.toString().split('.').last,
      'regularAmount': regularAmount,
      'nextPaymentDate': nextPaymentDate?.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'totalCycles': totalCycles,
      'currentCycle': currentCycle,
      'payoutSchedule': payoutSchedule.map((x) => (x as PayoutScheduleModel).toJson()).toList(),
      'currentPayoutRecipient': currentPayoutRecipient,
      'nextPayoutDate': nextPayoutDate?.toIso8601String(),
      'payoutHistory': payoutHistory.map((x) => (x as PayoutTransactionModel).toJson()).toList(),
      'autoPayEnabled': autoPayEnabled,
      'penaltyAmount': penaltyAmount,
      'gracePeriodDays': gracePeriodDays,
      'allowPartialPayments': allowPartialPayments,
      'minimumBalance': minimumBalance,
      'autoPayoutEnabled': autoPayoutEnabled,
      'members': members.map((x) => (x as ContributionMemberModel).toJson()).toList(),
    };
  }

  factory ContributionModel.fromEntity(Contribution entity) {
    return ContributionModel(
      id: entity.id,
      groupId: entity.groupId,
      title: entity.title,
      description: entity.description,
      targetAmount: entity.targetAmount,
      currentAmount: entity.currentAmount,
      currency: entity.currency,
      deadline: entity.deadline,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
      createdBy: entity.createdBy,
      payments: entity.payments,
      members: entity.members,
      metadata: entity.metadata,
      type: entity.type,
      frequency: entity.frequency,
      regularAmount: entity.regularAmount,
      nextPaymentDate: entity.nextPaymentDate,
      startDate: entity.startDate,
      totalCycles: entity.totalCycles,
      currentCycle: entity.currentCycle,
      payoutSchedule: entity.payoutSchedule,
      currentPayoutRecipient: entity.currentPayoutRecipient,
      nextPayoutDate: entity.nextPayoutDate,
      payoutHistory: entity.payoutHistory,
      autoPayEnabled: entity.autoPayEnabled,
      penaltyAmount: entity.penaltyAmount,
      gracePeriodDays: entity.gracePeriodDays,
      allowPartialPayments: entity.allowPartialPayments,
      minimumBalance: entity.minimumBalance,
      autoPayoutEnabled: entity.autoPayoutEnabled,
    );
  }

  @override
  ContributionModel copyWith({
    String? id,
    String? groupId,
    String? title,
    String? description,
    double? targetAmount,
    double? currentAmount,
    String? currency,
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? updatedAt,
    ContributionStatus? status,
    String? createdBy,
    List<ContributionPayment>? payments,
    List<ContributionMember>? members,
    Map<String, dynamic>? metadata,
    ContributionType? type,
    ContributionFrequency? frequency,
    double? regularAmount,
    DateTime? nextPaymentDate,
    DateTime? startDate,
    int? totalCycles,
    int? currentCycle,
    List<PayoutSchedule>? payoutSchedule,
    String? currentPayoutRecipient,
    DateTime? nextPayoutDate,
    List<PayoutTransaction>? payoutHistory,
    bool? autoPayEnabled,
    double? penaltyAmount,
    int? gracePeriodDays,
    bool? allowPartialPayments,
    double? minimumBalance,
    bool? autoPayoutEnabled,
  }) {
    return ContributionModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      title: title ?? this.title,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      currency: currency ?? this.currency,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      payments: payments ?? this.payments,
      members: members ?? this.members,
      metadata: metadata ?? this.metadata,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      regularAmount: regularAmount ?? this.regularAmount,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      startDate: startDate ?? this.startDate,
      totalCycles: totalCycles ?? this.totalCycles,
      currentCycle: currentCycle ?? this.currentCycle,
      payoutSchedule: payoutSchedule ?? this.payoutSchedule,
      currentPayoutRecipient: currentPayoutRecipient ?? this.currentPayoutRecipient,
      nextPayoutDate: nextPayoutDate ?? this.nextPayoutDate,
      payoutHistory: payoutHistory ?? this.payoutHistory,
      autoPayEnabled: autoPayEnabled ?? this.autoPayEnabled,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      gracePeriodDays: gracePeriodDays ?? this.gracePeriodDays,
      allowPartialPayments: allowPartialPayments ?? this.allowPartialPayments,
      minimumBalance: minimumBalance ?? this.minimumBalance,
      autoPayoutEnabled: autoPayoutEnabled ?? this.autoPayoutEnabled,
    );
  }
}

// Contribution Member Model
class ContributionMemberModel extends ContributionMember {
  const ContributionMemberModel({
    required super.id,
    required super.contributionId,
    required super.userId,
    required super.userName,
    required super.email,
    super.profileImage,
    required super.joinedAt,
    super.totalPaid = 0,
    super.expectedAmount = 0,
    super.hasPaidCurrentCycle = false,
    super.cyclePaidAmount = 0,
    super.missedCycles = 0,
    super.membershipStatus = ContributionMembershipStatus.active,
    super.linkedInvitationId,
  });

  factory ContributionMemberModel.fromJson(Map<String, dynamic> json) {
    return ContributionMemberModel(
      id: json['id'] as String,
      contributionId: json['contributionId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0,
      expectedAmount: (json['expectedAmount'] as num?)?.toDouble() ?? 0,
      hasPaidCurrentCycle: json['hasPaidCurrentCycle'] as bool? ?? false,
      cyclePaidAmount: (json['cyclePaidAmount'] as num?)?.toDouble() ?? 0,
      missedCycles: (json['missedCycles'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contributionId': contributionId,
      'userId': userId,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'joinedAt': joinedAt.toIso8601String(),
      'totalPaid': totalPaid,
      'expectedAmount': expectedAmount,
      'hasPaidCurrentCycle': hasPaidCurrentCycle,
      'cyclePaidAmount': cyclePaidAmount,
      'missedCycles': missedCycles,
    };
  }
}

// Contribution Payment Model
class ContributionPaymentModel extends ContributionPayment {
  const ContributionPaymentModel({
    required super.id,
    required super.contributionId,
    required super.groupId,
    required super.userId,
    required super.userName,
    required super.amount,
    required super.currency,
    required super.paymentDate,
    required super.status,
    super.transactionId,
    super.receiptId,
    super.notes,
    super.metadata,
  });

  factory ContributionPaymentModel.fromJson(Map<String, dynamic> json) {
    return ContributionPaymentModel(
      id: json['id'] as String,
      contributionId: json['contributionId'] as String,
      groupId: json['groupId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      status: _parsePaymentStatus(json['status']),
      transactionId: json['transactionId'] as String?,
      receiptId: json['receiptId'] as String?,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contributionId': contributionId,
      'groupId': groupId,
      'userId': userId,
      'userName': userName,
      'amount': amount,
      'currency': currency,
      'paymentDate': paymentDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'transactionId': transactionId,
      'receiptId': receiptId,
      'notes': notes,
      'metadata': metadata,
    };
  }

  factory ContributionPaymentModel.fromEntity(ContributionPayment entity) {
    return ContributionPaymentModel(
      id: entity.id,
      contributionId: entity.contributionId,
      groupId: entity.groupId,
      userId: entity.userId,
      userName: entity.userName,
      amount: entity.amount,
      currency: entity.currency,
      paymentDate: entity.paymentDate,
      status: entity.status,
      transactionId: entity.transactionId,
      receiptId: entity.receiptId,
      notes: entity.notes,
      metadata: entity.metadata,
    );
  }

  @override
  ContributionPaymentModel copyWith({
    String? id,
    String? contributionId,
    String? groupId,
    String? userId,
    String? userName,
    double? amount,
    String? currency,
    DateTime? paymentDate,
    PaymentStatus? status,
    String? transactionId,
    String? receiptId,
    String? notes,
    Map<String, dynamic>? metadata,
  }) {
    return ContributionPaymentModel(
      id: id ?? this.id,
      contributionId: contributionId ?? this.contributionId,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      receiptId: receiptId ?? this.receiptId,
      notes: notes ?? this.notes,
      metadata: metadata ?? this.metadata,
    );
  }
}

// Contribution Receipt Model
class ContributionReceiptModel extends ContributionReceipt {
  const ContributionReceiptModel({
    required super.id,
    required super.paymentId,
    required super.contributionId,
    required super.groupId,
    required super.userId,
    required super.userName,
    required super.amount,
    required super.currency,
    required super.paymentDate,
    required super.generatedAt,
    required super.receiptNumber,
    required super.receiptData,
  });

  factory ContributionReceiptModel.fromJson(Map<String, dynamic> json) {
    return ContributionReceiptModel(
      id: json['id'] as String,
      paymentId: json['paymentId'] as String,
      contributionId: json['contributionId'] as String,
      groupId: json['groupId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      receiptNumber: json['receiptNumber'] as String,
      receiptData: Map<String, dynamic>.from(json['receiptData'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentId': paymentId,
      'contributionId': contributionId,
      'groupId': groupId,
      'userId': userId,
      'userName': userName,
      'amount': amount,
      'currency': currency,
      'paymentDate': paymentDate.toIso8601String(),
      'generatedAt': generatedAt.toIso8601String(),
      'receiptNumber': receiptNumber,
      'receiptData': receiptData,
    };
  }

  factory ContributionReceiptModel.fromEntity(ContributionReceipt entity) {
    return ContributionReceiptModel(
      id: entity.id,
      paymentId: entity.paymentId,
      contributionId: entity.contributionId,
      groupId: entity.groupId,
      userId: entity.userId,
      userName: entity.userName,
      amount: entity.amount,
      currency: entity.currency,
      paymentDate: entity.paymentDate,
      generatedAt: entity.generatedAt,
      receiptNumber: entity.receiptNumber,
      receiptData: entity.receiptData,
    );
  }
}

// Contribution Transcript Model
class ContributionTranscriptModel extends ContributionTranscript {
  const ContributionTranscriptModel({
    required super.id,
    required super.contributionId,
    required super.groupId,
    required super.generatedAt,
    required super.payments,
    required super.totalAmount,
    required super.currency,
    required super.memberContributions,
  });

  factory ContributionTranscriptModel.fromJson(Map<String, dynamic> json) {
    return ContributionTranscriptModel(
      id: json['id'] as String,
      contributionId: json['contributionId'] as String,
      groupId: json['groupId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      payments: (json['payments'] as List<dynamic>)
          .map((x) => ContributionPaymentModel.fromJson(x as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      memberContributions: Map<String, double>.from(
        (json['memberContributions'] as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contributionId': contributionId,
      'groupId': groupId,
      'generatedAt': generatedAt.toIso8601String(),
      'payments': payments.map((x) => (x as ContributionPaymentModel).toJson()).toList(),
      'totalAmount': totalAmount,
      'currency': currency,
      'memberContributions': memberContributions,
    };
  }

  factory ContributionTranscriptModel.fromEntity(ContributionTranscript entity) {
    return ContributionTranscriptModel(
      id: entity.id,
      contributionId: entity.contributionId,
      groupId: entity.groupId,
      generatedAt: entity.generatedAt,
      payments: entity.payments,
      totalAmount: entity.totalAmount,
      currency: entity.currency,
      memberContributions: entity.memberContributions,
    );
  }
}
