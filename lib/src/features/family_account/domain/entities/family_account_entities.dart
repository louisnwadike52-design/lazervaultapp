import 'package:equatable/equatable.dart';

// Enums

enum FamilyAccountStatus {
  active,
  frozen,
  closed,
  pendingSetup,
}

enum FundDistributionMode {
  sharedPool,
  equalSplit,
  customAllocation,
}

enum FamilyMemberRole {
  admin,
  member,
}

enum InvitationStatus {
  pending,
  accepted,
  declined,
  removed,
  expired,
}

enum FamilyTransactionType {
  allocation,
  spending,
  refund,
  adjustment,
  removal,
  contribution,
}

// Main Entities

class FamilyAccount extends Equatable {
  final String id;
  final String creatorId;
  final String creatorName;
  final String name;
  final String? description;
  final double totalAllocatedBalance;
  final double totalPoolBalance;
  final double totalBalance;
  final bool allowMemberContributions;
  final FamilyAccountStatus status;
  final List<FamilyMember> members;
  final int memberCount;
  final int activeMemberCount;
  final FundDistributionMode fundDistributionMode;
  final bool setupCompleted;
  final bool spendingVisibilityEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FamilyAccount({
    required this.id,
    required this.creatorId,
    required this.creatorName,
    required this.name,
    this.description,
    required this.totalAllocatedBalance,
    required this.totalPoolBalance,
    required this.totalBalance,
    required this.allowMemberContributions,
    required this.status,
    required this.members,
    required this.memberCount,
    required this.activeMemberCount,
    this.fundDistributionMode = FundDistributionMode.customAllocation,
    this.setupCompleted = false,
    this.spendingVisibilityEnabled = true,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        creatorId,
        creatorName,
        name,
        description,
        totalAllocatedBalance,
        totalPoolBalance,
        totalBalance,
        allowMemberContributions,
        status,
        members,
        memberCount,
        activeMemberCount,
        fundDistributionMode,
        setupCompleted,
        spendingVisibilityEnabled,
        createdAt,
        updatedAt,
      ];

  FamilyAccount copyWith({
    String? id,
    String? creatorId,
    String? creatorName,
    String? name,
    String? description,
    double? totalAllocatedBalance,
    double? totalPoolBalance,
    double? totalBalance,
    bool? allowMemberContributions,
    FamilyAccountStatus? status,
    List<FamilyMember>? members,
    int? memberCount,
    int? activeMemberCount,
    FundDistributionMode? fundDistributionMode,
    bool? setupCompleted,
    bool? spendingVisibilityEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FamilyAccount(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      name: name ?? this.name,
      description: description ?? this.description,
      totalAllocatedBalance: totalAllocatedBalance ?? this.totalAllocatedBalance,
      totalPoolBalance: totalPoolBalance ?? this.totalPoolBalance,
      totalBalance: totalBalance ?? this.totalBalance,
      allowMemberContributions: allowMemberContributions ?? this.allowMemberContributions,
      status: status ?? this.status,
      members: members ?? this.members,
      memberCount: memberCount ?? this.memberCount,
      activeMemberCount: activeMemberCount ?? this.activeMemberCount,
      fundDistributionMode: fundDistributionMode ?? this.fundDistributionMode,
      setupCompleted: setupCompleted ?? this.setupCompleted,
      spendingVisibilityEnabled: spendingVisibilityEnabled ?? this.spendingVisibilityEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Computed properties
  bool get isActive => status == FamilyAccountStatus.active;
  bool get isFrozen => status == FamilyAccountStatus.frozen;
  bool get isPendingSetup => status == FamilyAccountStatus.pendingSetup;
  bool get needsSetup => !setupCompleted && isPendingSetup;
  bool get canAcceptMembers => isActive || isPendingSetup;
}

class FamilyMember extends Equatable {
  final String id;
  final String familyId;
  final String? userId;
  final String fullName;
  final String? email;
  final String? phone;
  final String? username;
  final String? avatarUrl;
  final FamilyMemberRole role;
  final double allocatedBalance;
  final double dailySpendingLimit;
  final double monthlySpendingLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final double spentToday;
  final double spentThisMonth;
  final double remainingBalance;
  final InvitationStatus invitationStatus;
  final String invitationToken;
  final DateTime invitationExpiresAt;
  final String? cardLastFour;
  final bool hasCard;
  final DateTime? joinedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FamilyMember({
    required this.id,
    required this.familyId,
    this.userId,
    required this.fullName,
    this.email,
    this.phone,
    this.username,
    this.avatarUrl,
    required this.role,
    required this.allocatedBalance,
    required this.dailySpendingLimit,
    required this.monthlySpendingLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.spentToday,
    required this.spentThisMonth,
    required this.remainingBalance,
    required this.invitationStatus,
    required this.invitationToken,
    required this.invitationExpiresAt,
    this.cardLastFour,
    required this.hasCard,
    this.joinedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        familyId,
        userId,
        fullName,
        email,
        phone,
        username,
        avatarUrl,
        role,
        allocatedBalance,
        dailySpendingLimit,
        monthlySpendingLimit,
        perTransactionLimit,
        allocationPercentageCap,
        spentToday,
        spentThisMonth,
        remainingBalance,
        invitationStatus,
        invitationToken,
        invitationExpiresAt,
        cardLastFour,
        hasCard,
        joinedAt,
        createdAt,
        updatedAt,
      ];

  FamilyMember copyWith({
    String? id,
    String? familyId,
    String? userId,
    String? fullName,
    String? email,
    String? phone,
    String? username,
    String? avatarUrl,
    FamilyMemberRole? role,
    double? allocatedBalance,
    double? dailySpendingLimit,
    double? monthlySpendingLimit,
    double? perTransactionLimit,
    double? allocationPercentageCap,
    double? spentToday,
    double? spentThisMonth,
    double? remainingBalance,
    InvitationStatus? invitationStatus,
    String? invitationToken,
    DateTime? invitationExpiresAt,
    String? cardLastFour,
    bool? hasCard,
    DateTime? joinedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      allocatedBalance: allocatedBalance ?? this.allocatedBalance,
      dailySpendingLimit: dailySpendingLimit ?? this.dailySpendingLimit,
      monthlySpendingLimit: monthlySpendingLimit ?? this.monthlySpendingLimit,
      perTransactionLimit: perTransactionLimit ?? this.perTransactionLimit,
      allocationPercentageCap: allocationPercentageCap ?? this.allocationPercentageCap,
      spentToday: spentToday ?? this.spentToday,
      spentThisMonth: spentThisMonth ?? this.spentThisMonth,
      remainingBalance: remainingBalance ?? this.remainingBalance,
      invitationStatus: invitationStatus ?? this.invitationStatus,
      invitationToken: invitationToken ?? this.invitationToken,
      invitationExpiresAt: invitationExpiresAt ?? this.invitationExpiresAt,
      cardLastFour: cardLastFour ?? this.cardLastFour,
      hasCard: hasCard ?? this.hasCard,
      joinedAt: joinedAt ?? this.joinedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Computed properties
  bool get isActive => invitationStatus == InvitationStatus.accepted;
  bool get isPending => invitationStatus == InvitationStatus.pending;
  bool get isExpired => invitationStatus == InvitationStatus.expired || DateTime.now().isAfter(invitationExpiresAt);
  bool get isAdmin => role == FamilyMemberRole.admin;
  bool get hasDailyLimit => dailySpendingLimit > 0;
  bool get hasMonthlyLimit => monthlySpendingLimit > 0;
  bool get hasPerTransactionLimit => perTransactionLimit > 0;
  bool get hasAllocationPercentageCap => allocationPercentageCap < 100.0;
  double get utilizationPercentage => allocatedBalance > 0 ? (spentToday / allocatedBalance) * 100 : 0;
}

class FamilyTransaction extends Equatable {
  final String id;
  final String familyId;
  final String memberId;
  final String memberName;
  final String? memberAvatar;
  final String? transactionId;
  final double amount;
  final FamilyTransactionType type;
  final String? description;
  final String? merchantName;
  final String? merchantCategory;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;

  const FamilyTransaction({
    required this.id,
    required this.familyId,
    required this.memberId,
    required this.memberName,
    this.memberAvatar,
    this.transactionId,
    required this.amount,
    required this.type,
    this.description,
    this.merchantName,
    this.merchantCategory,
    this.metadata,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        familyId,
        memberId,
        memberName,
        memberAvatar,
        transactionId,
        amount,
        type,
        description,
        merchantName,
        merchantCategory,
        metadata,
        createdAt,
      ];

  // Computed properties
  bool get isSpending => type == FamilyTransactionType.spending;
  bool get isAllocation => type == FamilyTransactionType.allocation;
  bool get isRefund => type == FamilyTransactionType.refund;
  bool get isContribution => type == FamilyTransactionType.contribution;
}

class PendingInvitation extends Equatable {
  final String invitationToken;
  final String familyId;
  final String familyName;
  final String creatorName;
  final String? creatorAvatar;
  final double initialAllocation;
  final double dailyLimit;
  final double monthlyLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final String invitedBy;
  final DateTime expiresAt;
  final DateTime createdAt;

  const PendingInvitation({
    required this.invitationToken,
    required this.familyId,
    required this.familyName,
    required this.creatorName,
    this.creatorAvatar,
    required this.initialAllocation,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.invitedBy,
    required this.expiresAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        invitationToken,
        familyId,
        familyName,
        creatorName,
        creatorAvatar,
        initialAllocation,
        dailyLimit,
        monthlyLimit,
        perTransactionLimit,
        allocationPercentageCap,
        invitedBy,
        expiresAt,
        createdAt,
      ];

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  int get daysUntilExpiration => expiresAt.difference(DateTime.now()).inDays;
}

class FamilyAccountSummary extends Equatable {
  final double totalAllocated;
  final double totalSpentThisMonth;
  final double totalSpentToday;
  final int transactionCountThisMonth;
  final List<FamilyMemberSpending> topSpenders;

  const FamilyAccountSummary({
    required this.totalAllocated,
    required this.totalSpentThisMonth,
    required this.totalSpentToday,
    required this.transactionCountThisMonth,
    required this.topSpenders,
  });

  @override
  List<Object?> get props => [
        totalAllocated,
        totalSpentThisMonth,
        totalSpentToday,
        transactionCountThisMonth,
        topSpenders,
      ];
}

class FamilyMemberSpending extends Equatable {
  final String memberId;
  final String memberName;
  final String? memberAvatar;
  final double amountSpent;
  final int transactionCount;

  const FamilyMemberSpending({
    required this.memberId,
    required this.memberName,
    this.memberAvatar,
    required this.amountSpent,
    required this.transactionCount,
  });

  @override
  List<Object?> get props => [
        memberId,
        memberName,
        memberAvatar,
        amountSpent,
        transactionCount,
      ];
}

// Extensions for display names

extension FamilyAccountStatusExtension on FamilyAccountStatus {
  String get displayName {
    switch (this) {
      case FamilyAccountStatus.active:
        return 'Active';
      case FamilyAccountStatus.frozen:
        return 'Frozen';
      case FamilyAccountStatus.closed:
        return 'Closed';
      case FamilyAccountStatus.pendingSetup:
        return 'Pending Setup';
    }
  }
}

extension FundDistributionModeExtension on FundDistributionMode {
  String get displayName {
    switch (this) {
      case FundDistributionMode.sharedPool:
        return 'Shared Pool';
      case FundDistributionMode.equalSplit:
        return 'Equal Split';
      case FundDistributionMode.customAllocation:
        return 'Custom Allocation';
    }
  }

  String get description {
    switch (this) {
      case FundDistributionMode.sharedPool:
        return 'Everyone shares one balance pool. Any member spending reduces the shared balance visible to all.';
      case FundDistributionMode.equalSplit:
        return 'Total funds divided equally among active members. Auto-redistributes when members join or leave.';
      case FundDistributionMode.customAllocation:
        return 'Admin manually assigns different amounts to each member.';
    }
  }

  String get value {
    switch (this) {
      case FundDistributionMode.sharedPool:
        return 'shared_pool';
      case FundDistributionMode.equalSplit:
        return 'equal_split';
      case FundDistributionMode.customAllocation:
        return 'custom_allocation';
    }
  }

  static FundDistributionMode fromString(String value) {
    switch (value) {
      case 'shared_pool':
        return FundDistributionMode.sharedPool;
      case 'equal_split':
        return FundDistributionMode.equalSplit;
      case 'custom_allocation':
        return FundDistributionMode.customAllocation;
      default:
        return FundDistributionMode.customAllocation;
    }
  }
}

extension FamilyMemberRoleExtension on FamilyMemberRole {
  String get displayName {
    switch (this) {
      case FamilyMemberRole.admin:
        return 'Admin';
      case FamilyMemberRole.member:
        return 'Member';
    }
  }
}

extension InvitationStatusExtension on InvitationStatus {
  String get displayName {
    switch (this) {
      case InvitationStatus.pending:
        return 'Pending';
      case InvitationStatus.accepted:
        return 'Accepted';
      case InvitationStatus.declined:
        return 'Declined';
      case InvitationStatus.removed:
        return 'Removed';
      case InvitationStatus.expired:
        return 'Expired';
    }
  }
}

extension FamilyTransactionTypeExtension on FamilyTransactionType {
  String get displayName {
    switch (this) {
      case FamilyTransactionType.allocation:
        return 'Allocation';
      case FamilyTransactionType.spending:
        return 'Purchase';
      case FamilyTransactionType.refund:
        return 'Refund';
      case FamilyTransactionType.adjustment:
        return 'Adjustment';
      case FamilyTransactionType.removal:
        return 'Removal';
      case FamilyTransactionType.contribution:
        return 'Contribution';
    }
  }

  String get description {
    switch (this) {
      case FamilyTransactionType.allocation:
        return 'Funds allocated to member';
      case FamilyTransactionType.spending:
        return 'Purchase made by member';
      case FamilyTransactionType.refund:
        return 'Refund processed';
      case FamilyTransactionType.adjustment:
        return 'Balance adjustment';
      case FamilyTransactionType.removal:
        return 'Member removed';
      case FamilyTransactionType.contribution:
        return 'Member contribution to pool';
    }
  }
}
