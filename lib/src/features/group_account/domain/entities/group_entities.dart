import 'package:equatable/equatable.dart';

// Enums - moved to top to avoid forward reference issues
enum GroupAccountStatus {
  active,
  suspended,
  deleted,
}

enum GroupMemberRole {
  admin,
  moderator,
  member,
}

enum GroupMemberStatus {
  active,
  pending,
  inactive,
  removed,
}

enum ContributionStatus {
  active,
  paused,
  completed,
  cancelled,
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  refunded,
}

enum ContributionType {
  oneTime,
  rotatingSavings,
  investmentPool,
  recurringGoal,
}

enum ContributionFrequency {
  daily,
  weekly,
  biWeekly,
  monthly,
  quarterly,
}

enum PayoutStatus {
  pending,
  processing,
  completed,
  cancelled,
  overdue,
}

enum PayoutTransactionStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
}

// Group Account entity
class GroupAccount extends Equatable {
  final String id;
  final String name;
  final String description;
  final String adminId;
  final List<GroupMember> members;
  final List<Contribution> contributions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GroupAccountStatus status;
  final Map<String, dynamic>? metadata;

  const GroupAccount({
    required this.id,
    required this.name,
    required this.description,
    required this.adminId,
    required this.members,
    required this.contributions,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        adminId,
        members,
        contributions,
        createdAt,
        updatedAt,
        status,
        metadata,
      ];

  GroupAccount copyWith({
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
  }) {
    return GroupAccount(
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
    );
  }
}

// Group Member entity
class GroupMember extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String email;
  final String? profileImage;
  final GroupMemberRole role;
  final DateTime joinedAt;
  final GroupMemberStatus status;
  final Map<String, dynamic>? permissions;

  const GroupMember({
    required this.id,
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImage,
    required this.role,
    required this.joinedAt,
    required this.status,
    this.permissions,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        email,
        profileImage,
        role,
        joinedAt,
        status,
        permissions,
      ];

  GroupMember copyWith({
    String? id,
    String? userId,
    String? userName,
    String? email,
    String? profileImage,
    GroupMemberRole? role,
    DateTime? joinedAt,
    GroupMemberStatus? status,
    Map<String, dynamic>? permissions,
  }) {
    return GroupMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
      permissions: permissions ?? this.permissions,
    );
  }
}

// Contribution entity with enhanced scheduling and payout features
class Contribution extends Equatable {
  final String id;
  final String groupId;
  final String title;
  final String description;
  final double targetAmount;
  final double currentAmount;
  final String currency;
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ContributionStatus status;
  final String createdBy;
  final List<ContributionPayment> payments;
  final Map<String, dynamic>? metadata;
  
  // Enhanced scheduling fields
  final ContributionType type; // one_time, rotating_savings, investment_pool
  final ContributionFrequency? frequency; // weekly, monthly, etc.
  final double? regularAmount; // Amount each member should contribute per cycle
  final DateTime? nextPaymentDate;
  final DateTime? startDate;
  final int? totalCycles; // Total number of payment cycles
  final int? currentCycle; // Current cycle number
  
  // Payout rotation fields
  final List<PayoutSchedule> payoutSchedule; // Who gets paid when
  final String? currentPayoutRecipient; // Current person to receive payout
  final DateTime? nextPayoutDate;
  final List<PayoutTransaction> payoutHistory;
  
  // Advanced settings
  final bool autoPayEnabled; // Automatic payment processing
  final double? penaltyAmount; // Penalty for missed payments
  final int? gracePeriodDays; // Grace period before penalties
  final bool allowPartialPayments;
  final double? minimumBalance; // Minimum balance required for payout

  const Contribution({
    required this.id,
    required this.groupId,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.currentAmount,
    required this.currency,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.createdBy,
    required this.payments,
    this.metadata,
    this.type = ContributionType.oneTime,
    this.frequency,
    this.regularAmount,
    this.nextPaymentDate,
    this.startDate,
    this.totalCycles,
    this.currentCycle,
    this.payoutSchedule = const [],
    this.currentPayoutRecipient,
    this.nextPayoutDate,
    this.payoutHistory = const [],
    this.autoPayEnabled = false,
    this.penaltyAmount,
    this.gracePeriodDays,
    this.allowPartialPayments = true,
    this.minimumBalance,
  });

  @override
  List<Object?> get props => [
        id,
        groupId,
        title,
        description,
        targetAmount,
        currentAmount,
        currency,
        deadline,
        createdAt,
        updatedAt,
        status,
        createdBy,
        payments,
        metadata,
        type,
        frequency,
        regularAmount,
        nextPaymentDate,
        startDate,
        totalCycles,
        currentCycle,
        payoutSchedule,
        currentPayoutRecipient,
        nextPayoutDate,
        payoutHistory,
        autoPayEnabled,
        penaltyAmount,
        gracePeriodDays,
        allowPartialPayments,
        minimumBalance,
      ];

  bool get isCompleted => status == ContributionStatus.completed;
  bool get isActive => status == ContributionStatus.active;
  bool get isRotatingSavings => type == ContributionType.rotatingSavings;
  bool get hasSchedule => frequency != null && regularAmount != null;
  bool get isOverdue => nextPaymentDate != null && DateTime.now().isAfter(nextPaymentDate!);
  bool get canPayout => currentAmount >= (minimumBalance ?? 0) && currentPayoutRecipient != null;
  
  double get progressPercentage => targetAmount > 0 ? (currentAmount / targetAmount * 100).clamp(0, 100) : 0;
  
  PayoutSchedule? get currentPayoutInfo => payoutSchedule.isNotEmpty 
    ? payoutSchedule.firstWhere((p) => p.userId == currentPayoutRecipient, orElse: () => payoutSchedule.first)
    : null;

  Contribution copyWith({
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
    return Contribution(
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

// Contribution Payment entity
class ContributionPayment extends Equatable {
  final String id;
  final String contributionId;
  final String groupId;
  final String userId;
  final String userName;
  final double amount;
  final String currency;
  final DateTime paymentDate;
  final PaymentStatus status;
  final String? transactionId;
  final String? receiptId;
  final String? notes;
  final Map<String, dynamic>? metadata;

  const ContributionPayment({
    required this.id,
    required this.contributionId,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.currency,
    required this.paymentDate,
    required this.status,
    this.transactionId,
    this.receiptId,
    this.notes,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        contributionId,
        groupId,
        userId,
        userName,
        amount,
        currency,
        paymentDate,
        status,
        transactionId,
        receiptId,
        notes,
        metadata,
      ];

  ContributionPayment copyWith({
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
    return ContributionPayment(
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

// Receipt entity
class ContributionReceipt extends Equatable {
  final String id;
  final String paymentId;
  final String contributionId;
  final String groupId;
  final String userId;
  final String userName;
  final double amount;
  final String currency;
  final DateTime paymentDate;
  final DateTime generatedAt;
  final String receiptNumber;
  final Map<String, dynamic> receiptData;

  const ContributionReceipt({
    required this.id,
    required this.paymentId,
    required this.contributionId,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.currency,
    required this.paymentDate,
    required this.generatedAt,
    required this.receiptNumber,
    required this.receiptData,
  });

  @override
  List<Object?> get props => [
        id,
        paymentId,
        contributionId,
        groupId,
        userId,
        userName,
        amount,
        currency,
        paymentDate,
        generatedAt,
        receiptNumber,
        receiptData,
      ];
}

// Contribution Transcript entity
class ContributionTranscript extends Equatable {
  final String id;
  final String contributionId;
  final String groupId;
  final DateTime generatedAt;
  final List<ContributionPayment> payments;
  final double totalAmount;
  final String currency;
  final Map<String, double> memberContributions;

  const ContributionTranscript({
    required this.id,
    required this.contributionId,
    required this.groupId,
    required this.generatedAt,
    required this.payments,
    required this.totalAmount,
    required this.currency,
    required this.memberContributions,
  });

  @override
  List<Object?> get props => [
        id,
        contributionId,
        groupId,
        generatedAt,
        payments,
        totalAmount,
        currency,
        memberContributions,
      ];
}

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

// Extensions for display names
extension GroupAccountStatusExtension on GroupAccountStatus {
  String get displayName {
    switch (this) {
      case GroupAccountStatus.active:
        return 'Active';
      case GroupAccountStatus.suspended:
        return 'Suspended';
      case GroupAccountStatus.deleted:
        return 'Deleted';
    }
  }
}

extension GroupMemberRoleExtension on GroupMemberRole {
  String get displayName {
    switch (this) {
      case GroupMemberRole.admin:
        return 'Admin';
      case GroupMemberRole.moderator:
        return 'Moderator';
      case GroupMemberRole.member:
        return 'Member';
    }
  }
}

extension GroupMemberStatusExtension on GroupMemberStatus {
  String get displayName {
    switch (this) {
      case GroupMemberStatus.active:
        return 'Active';
      case GroupMemberStatus.pending:
        return 'Pending';
      case GroupMemberStatus.inactive:
        return 'Inactive';
      case GroupMemberStatus.removed:
        return 'Removed';
    }
  }
}

extension ContributionStatusExtension on ContributionStatus {
  String get displayName {
    switch (this) {
      case ContributionStatus.active:
        return 'Active';
      case ContributionStatus.paused:
        return 'Paused';
      case ContributionStatus.completed:
        return 'Completed';
      case ContributionStatus.cancelled:
        return 'Cancelled';
    }
  }
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }
}

extension ContributionFrequencyExtension on ContributionFrequency {
  String get displayName {
    switch (this) {
      case ContributionFrequency.daily:
        return 'Daily';
      case ContributionFrequency.weekly:
        return 'Weekly';
      case ContributionFrequency.biWeekly:
        return 'Bi-weekly';
      case ContributionFrequency.monthly:
        return 'Monthly';
      case ContributionFrequency.quarterly:
        return 'Quarterly';
    }
  }

  Duration get duration {
    switch (this) {
      case ContributionFrequency.daily:
        return const Duration(days: 1);
      case ContributionFrequency.weekly:
        return const Duration(days: 7);
      case ContributionFrequency.biWeekly:
        return const Duration(days: 14);
      case ContributionFrequency.monthly:
        return const Duration(days: 30);
      case ContributionFrequency.quarterly:
        return const Duration(days: 90);
    }
  }

  DateTime calculateNextDate(DateTime from) {
    switch (this) {
      case ContributionFrequency.daily:
        return from.add(const Duration(days: 1));
      case ContributionFrequency.weekly:
        return from.add(const Duration(days: 7));
      case ContributionFrequency.biWeekly:
        return from.add(const Duration(days: 14));
      case ContributionFrequency.monthly:
        return DateTime(from.year, from.month + 1, from.day);
      case ContributionFrequency.quarterly:
        return DateTime(from.year, from.month + 3, from.day);
    }
  }
}

extension ContributionTypeExtension on ContributionType {
  String get displayName {
    switch (this) {
      case ContributionType.oneTime:
        return 'One-time Goal';
      case ContributionType.rotatingSavings:
        return 'Rotating Savings (Susu)';
      case ContributionType.investmentPool:
        return 'Investment Pool';
      case ContributionType.recurringGoal:
        return 'Recurring Goal';
    }
  }

  String get description {
    switch (this) {
      case ContributionType.oneTime:
        return 'Collect money once for a specific goal';
      case ContributionType.rotatingSavings:
        return 'Members contribute regularly and take turns receiving payouts';
      case ContributionType.investmentPool:
        return 'Pool money for group investments with shared returns';
      case ContributionType.recurringGoal:
        return 'Regular contributions toward an ongoing goal';
    }
  }
} 