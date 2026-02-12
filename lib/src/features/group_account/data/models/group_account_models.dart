import '../../domain/entities/group_entities.dart';

// Group Account Model
class GroupAccountModel extends GroupAccount {
  const GroupAccountModel({
    required super.id,
    required super.name,
    required super.description,
    required super.adminId,
    required super.members,
    required super.contributions,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    super.metadata,
    super.visibility,
    super.memberCount,
    super.totalRaised,
    super.imageUrl,
  });

  factory GroupAccountModel.fromJson(Map<String, dynamic> json) {
    return GroupAccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      adminId: json['adminId'] as String,
      members: (json['members'] as List<dynamic>?)
              ?.map((x) => GroupMemberModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      contributions: (json['contributions'] as List<dynamic>?)
              ?.map((x) => ContributionModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: GroupAccountStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => GroupAccountStatus.active,
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      visibility: json['visibility'] != null
          ? GroupVisibility.values.firstWhere(
              (e) => e.toString().split('.').last == json['visibility'],
              orElse: () => GroupVisibility.private,
            )
          : GroupVisibility.private,
      memberCount: json['memberCount'] as int? ?? 0,
      totalRaised: json['totalRaised'] != null
          ? (json['totalRaised'] as num).toDouble()
          : 0.0,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'adminId': adminId,
      'members': members.map((x) => (x as GroupMemberModel).toJson()).toList(),
      'contributions': contributions.map((x) => (x as ContributionModel).toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'metadata': metadata,
      'visibility': visibility.toString().split('.').last,
      'memberCount': memberCount,
      'totalRaised': totalRaised,
      'imageUrl': imageUrl,
    };
  }

  factory GroupAccountModel.fromEntity(GroupAccount entity) {
    return GroupAccountModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      adminId: entity.adminId,
      members: entity.members,
      contributions: entity.contributions,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
      metadata: entity.metadata,
      visibility: entity.visibility,
      memberCount: entity.memberCount,
      totalRaised: entity.totalRaised,
      imageUrl: entity.imageUrl,
    );
  }

  @override
  GroupAccountModel copyWith({
    String? id,
    String? name,
    String? description,
    String? adminId,
    List<GroupMember>? members,
    List<Contribution>? contributions,
    DateTime? createdAt,
    DateTime? updatedAt,
    GroupAccountStatus? status,
    Map<String, dynamic>? metadata,
    GroupVisibility? visibility,
    int? memberCount,
    double? totalRaised,
    String? imageUrl,
  }) {
    return GroupAccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      adminId: adminId ?? this.adminId,
      members: members ?? this.members,
      contributions: contributions ?? this.contributions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
      visibility: visibility ?? this.visibility,
      memberCount: memberCount ?? this.memberCount,
      totalRaised: totalRaised ?? this.totalRaised,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

// Group Member Model
class GroupMemberModel extends GroupMember {
  const GroupMemberModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.email,
    super.profileImage,
    required super.role,
    required super.joinedAt,
    required super.status,
    super.permissions,
    super.phoneNumber,
    super.isPartial = false,
    super.userUsername,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      role: GroupMemberRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
        orElse: () => GroupMemberRole.member,
      ),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      status: GroupMemberStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => GroupMemberStatus.active,
      ),
      permissions: json['permissions'] as Map<String, dynamic>?,
      phoneNumber: json['phoneNumber'] as String?,
      isPartial: json['isPartial'] as bool? ?? false,
      userUsername: json['userUsername'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'role': role.toString().split('.').last,
      'joinedAt': joinedAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'permissions': permissions,
      'phoneNumber': phoneNumber,
      'isPartial': isPartial,
      'userUsername': userUsername,
    };
  }

  factory GroupMemberModel.fromEntity(GroupMember entity) {
    return GroupMemberModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      email: entity.email,
      profileImage: entity.profileImage,
      role: entity.role,
      joinedAt: entity.joinedAt,
      status: entity.status,
      permissions: entity.permissions,
      phoneNumber: entity.phoneNumber,
      isPartial: entity.isPartial,
      userUsername: entity.userUsername,
    );
  }

  @override
  GroupMemberModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? email,
    String? profileImage,
    GroupMemberRole? role,
    DateTime? joinedAt,
    GroupMemberStatus? status,
    Map<String, dynamic>? permissions,
    String? phoneNumber,
    bool? isPartial,
    String? userUsername,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
      permissions: permissions ?? this.permissions,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPartial: isPartial ?? this.isPartial,
      userUsername: userUsername ?? this.userUsername,
    );
  }
}

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
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
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