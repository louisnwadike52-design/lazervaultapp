import 'package:equatable/equatable.dart';

// Enums - moved to top to avoid forward reference issues
enum GroupAccountStatus {
  active,
  suspended,
  deleted,
}

enum GroupVisibility {
  private,
  public,
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
  refunded,
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
  final GroupVisibility visibility;
  final int memberCount;
  final double totalRaised;
  final String? imageUrl;

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
    this.visibility = GroupVisibility.private,
    this.memberCount = 0,
    this.totalRaised = 0,
    this.imageUrl,
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
        visibility,
        memberCount,
        totalRaised,
        imageUrl,
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
    GroupVisibility? visibility,
    int? memberCount,
    double? totalRaised,
    String? imageUrl,
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
      visibility: visibility ?? this.visibility,
      memberCount: memberCount ?? this.memberCount,
      totalRaised: totalRaised ?? this.totalRaised,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // External social media links (stored in metadata)
  String? get whatsappGroupLink {
    return metadata?['whatsapp_group_link'] as String?;
  }

  String? get telegramGroupLink {
    return metadata?['telegram_group_link'] as String?;
  }

  String? get facebookGroupLink {
    return metadata?['facebook_group_link'] as String?;
  }

  String? get discordInviteLink {
    return metadata?['discord_invite_link'] as String?;
  }

  /// Check if group has any external links
  bool get hasExternalLinks {
    return whatsappGroupLink != null ||
        telegramGroupLink != null ||
        facebookGroupLink != null ||
        discordInviteLink != null;
  }

  /// Get all external links as a map
  Map<String, String?> get externalLinks {
    return {
      'whatsapp': whatsappGroupLink,
      'telegram': telegramGroupLink,
      'facebook': facebookGroupLink,
      'discord': discordInviteLink,
    };
  }

  /// Create a copy with updated external links
  GroupAccount copyWithExternalLinks({
    String? whatsappGroupLink,
    String? telegramGroupLink,
    String? facebookGroupLink,
    String? discordInviteLink,
  }) {
    final updatedMetadata = Map<String, dynamic>.from(metadata ?? {});
    if (whatsappGroupLink != null) {
      updatedMetadata['whatsapp_group_link'] = whatsappGroupLink;
    } else if (whatsappGroupLink == '' && updatedMetadata.containsKey('whatsapp_group_link')) {
      updatedMetadata.remove('whatsapp_group_link');
    }
    if (telegramGroupLink != null) {
      updatedMetadata['telegram_group_link'] = telegramGroupLink;
    } else if (telegramGroupLink == '' && updatedMetadata.containsKey('telegram_group_link')) {
      updatedMetadata.remove('telegram_group_link');
    }
    if (facebookGroupLink != null) {
      updatedMetadata['facebook_group_link'] = facebookGroupLink;
    } else if (facebookGroupLink == '' && updatedMetadata.containsKey('facebook_group_link')) {
      updatedMetadata.remove('facebook_group_link');
    }
    if (discordInviteLink != null) {
      updatedMetadata['discord_invite_link'] = discordInviteLink;
    } else if (discordInviteLink == '' && updatedMetadata.containsKey('discord_invite_link')) {
      updatedMetadata.remove('discord_invite_link');
    }
    return copyWith(metadata: updatedMetadata);
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
  final String? phoneNumber;
  final bool isPartial;
  final String? userUsername;

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
    this.phoneNumber,
    this.isPartial = false,
    this.userUsername,
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
        phoneNumber,
        isPartial,
        userUsername,
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
    String? phoneNumber,
    bool? isPartial,
    String? userUsername,
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
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPartial: isPartial ?? this.isPartial,
      userUsername: userUsername ?? this.userUsername,
    );
  }

  // Permission helper methods
  bool get isAdmin => role == GroupMemberRole.admin;
  bool get isModerator => role == GroupMemberRole.moderator;
  bool get isMember => role == GroupMemberRole.member;
  bool get isActive => status == GroupMemberStatus.active;

  /// Can manage group settings, members, and contributions
  bool get canManageGroup => isAdmin && isActive;

  /// Can add new members to the group
  bool get canAddMembers => (isAdmin || isModerator) && isActive;

  /// Can remove members from the group (admin only)
  bool get canRemoveMembers => isAdmin && isActive;

  /// Can create contributions in the group
  bool get canCreateContribution => isActive;

  /// Can manage (edit/delete) contributions they created
  bool get canManageOwnContribution => isActive;

  /// Can manage any contribution in the group (admin only)
  bool get canManageAnyContribution => isAdmin && isActive;
}

/// Extension on GroupAccount for permission checking
extension GroupAccountPermissions on GroupAccount {
  /// Get the member object for a given user ID
  GroupMember? getMember(String userId) {
    try {
      return members.firstWhere((m) => m.userId == userId);
    } catch (_) {
      return null;
    }
  }

  /// Check if user is the group admin (by adminId field)
  bool isGroupAdmin(String userId) {
    return adminId == userId;
  }

  /// Check if user has admin role in the group
  bool isUserAdmin(String userId) {
    final member = getMember(userId);
    return member?.isAdmin ?? false;
  }

  /// Check if user has moderator role
  bool isUserModerator(String userId) {
    final member = getMember(userId);
    return member?.isModerator ?? false;
  }

  /// Check if user is an active member
  bool isUserActiveMember(String userId) {
    final member = getMember(userId);
    return member?.isActive ?? false;
  }

  /// Check if user can manage the group (admin or group creator)
  bool canUserManageGroup(String userId) {
    return isGroupAdmin(userId) || isUserAdmin(userId);
  }

  /// Check if user can add members
  bool canUserAddMembers(String userId) {
    final member = getMember(userId);
    return member?.canAddMembers ?? isGroupAdmin(userId);
  }

  /// Check if user can remove members
  bool canUserRemoveMembers(String userId) {
    final member = getMember(userId);
    return member?.canRemoveMembers ?? isGroupAdmin(userId);
  }

  /// Check if user can create contributions
  bool canUserCreateContribution(String userId) {
    final member = getMember(userId);
    return member?.canCreateContribution ?? false;
  }

  /// Get the user's role in the group
  GroupMemberRole? getUserRole(String userId) {
    return getMember(userId)?.role;
  }

  /// Get display name for user's role
  String getUserRoleDisplay(String userId) {
    final role = getUserRole(userId);
    if (role == null) return 'Not a member';
    switch (role) {
      case GroupMemberRole.admin:
        return 'Admin';
      case GroupMemberRole.moderator:
        return 'Moderator';
      case GroupMemberRole.member:
        return 'Member';
    }
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

  // Members assigned to this contribution
  final List<ContributionMember> members;

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
    this.members = const [],
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
        members,
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
    List<ContributionMember>? members,
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
      members: members ?? this.members,
    );
  }

  // External Social Media Links
  String? get whatsappGroupLink {
    return metadata?['whatsapp_group_link'] as String?;
  }

  String? get telegramGroupLink {
    return metadata?['telegram_group_link'] as String?;
  }

  String? get facebookGroupLink {
    return metadata?['facebook_group_link'] as String?;
  }

  String? get discordInviteLink {
    return metadata?['discord_invite_link'] as String?;
  }

  bool get hasExternalLinks {
    return whatsappGroupLink != null ||
        telegramGroupLink != null ||
        facebookGroupLink != null ||
        discordInviteLink != null;
  }

  /// Get all external links as a map
  Map<String, String?> get externalLinks {
    return {
      'whatsapp': whatsappGroupLink,
      'telegram': telegramGroupLink,
      'facebook': facebookGroupLink,
      'discord': discordInviteLink,
    };
  }
}

/// Extension on Contribution for permission checking
extension ContributionPermissions on Contribution {
  /// Check if user is the creator of the contribution
  bool isCreator(String userId) => createdBy == userId;

  /// Check if user is a member of this contribution
  bool isMember(String userId) {
    return members.any((m) => m.userId == userId);
  }

  /// Check if contribution can be edited (not completed or cancelled)
  bool get canBeEdited =>
      status != ContributionStatus.completed &&
      status != ContributionStatus.cancelled;

  /// Check if contribution can be deleted
  bool get canBeDeleted =>
      currentAmount == 0 &&
      status != ContributionStatus.completed &&
      payments.isEmpty;

  /// Check if user can edit this contribution
  bool canUserEdit(String userId) {
    return isCreator(userId) && canBeEdited;
  }

  /// Check if user can delete this contribution
  bool canUserDelete(String userId) {
    return isCreator(userId) && canBeDeleted;
  }

  /// Check if user can make payments to this contribution
  bool canUserPay(String userId) {
    return isMember(userId) && status == ContributionStatus.active;
  }

  /// Get progress percentage
  double get progressPercentage {
    if (targetAmount <= 0) return 0;
    return (currentAmount / targetAmount * 100).clamp(0, 100);
  }

  /// Check if contribution is overdue
  bool get isOverdue =>
      status == ContributionStatus.active && DateTime.now().isAfter(deadline);

  /// Get user's contribution member record
  ContributionMember? getMember(String userId) {
    try {
      return members.firstWhere((m) => m.userId == userId);
    } catch (_) {
      return null;
    }
  }

  /// Get user's payment progress in this contribution
  double getUserProgress(String userId) {
    final member = getMember(userId);
    if (member == null || member.expectedAmount <= 0) return 0;
    return (member.totalPaid / member.expectedAmount * 100).clamp(0, 100);
  }
}

// Contribution Member entity - a member assigned to a contribution
class ContributionMember extends Equatable {
  final String id;
  final String contributionId;
  final String userId;
  final String userName;
  final String email;
  final String? profileImage;
  final DateTime joinedAt;
  final double totalPaid;
  final double expectedAmount;
  final bool hasPaidCurrentCycle;

  const ContributionMember({
    required this.id,
    required this.contributionId,
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImage,
    required this.joinedAt,
    this.totalPaid = 0,
    this.expectedAmount = 0,
    this.hasPaidCurrentCycle = false,
  });

  @override
  List<Object?> get props => [
        id,
        contributionId,
        userId,
        userName,
        email,
        profileImage,
        joinedAt,
        totalPaid,
        expectedAmount,
        hasPaidCurrentCycle,
      ];

  ContributionMember copyWith({
    String? id,
    String? contributionId,
    String? userId,
    String? userName,
    String? email,
    String? profileImage,
    DateTime? joinedAt,
    double? totalPaid,
    double? expectedAmount,
    bool? hasPaidCurrentCycle,
  }) {
    return ContributionMember(
      id: id ?? this.id,
      contributionId: contributionId ?? this.contributionId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      joinedAt: joinedAt ?? this.joinedAt,
      totalPaid: totalPaid ?? this.totalPaid,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      hasPaidCurrentCycle: hasPaidCurrentCycle ?? this.hasPaidCurrentCycle,
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

/// Activity log entry representing an action in a group or contribution
class ActivityLogEntry extends Equatable {
  final String id;
  final String groupId;
  final String? contributionId;
  final String actorUserId;
  final String actorName;
  final String actionType;
  final String? targetType;
  final String? targetId;
  final Map<String, dynamic>? details;
  final DateTime createdAt;

  const ActivityLogEntry({
    required this.id,
    required this.groupId,
    this.contributionId,
    required this.actorUserId,
    required this.actorName,
    required this.actionType,
    this.targetType,
    this.targetId,
    this.details,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        groupId,
        contributionId,
        actorUserId,
        actorName,
        actionType,
        targetType,
        targetId,
        details,
        createdAt,
      ];

  ActivityLogEntry copyWith({
    String? id,
    String? groupId,
    String? contributionId,
    String? actorUserId,
    String? actorName,
    String? actionType,
    String? targetType,
    String? targetId,
    Map<String, dynamic>? details,
    DateTime? createdAt,
  }) {
    return ActivityLogEntry(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      contributionId: contributionId ?? this.contributionId,
      actorUserId: actorUserId ?? this.actorUserId,
      actorName: actorName ?? this.actorName,
      actionType: actionType ?? this.actionType,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Activity action types
class ActivityActionType {
  // Member actions
  static const String memberAdded = 'member_added';
  static const String memberRemoved = 'member_removed';
  static const String memberRoleChanged = 'member_role_changed';
  static const String memberInvited = 'member_invited';

  // Payment actions
  static const String paymentMade = 'payment_made';
  static const String paymentFailed = 'payment_failed';
  static const String paymentRefunded = 'payment_refunded';

  // Contribution actions
  static const String contributionCreated = 'contribution_created';
  static const String contributionUpdated = 'contribution_updated';
  static const String contributionDeleted = 'contribution_deleted';
  static const String contributionPaused = 'contribution_paused';

  // Payout actions
  static const String payoutProcessed = 'payout_processed';
  static const String payoutRotationAdvanced = 'payout_rotation_advanced';

  // Group actions
  static const String groupCreated = 'group_created';
  static const String groupUpdated = 'group_updated';
  static const String settingsChanged = 'settings_changed';

  /// Get all member-related action types
  static List<String> get memberActions => [
        memberAdded,
        memberRemoved,
        memberRoleChanged,
        memberInvited,
      ];

  /// Get all payment-related action types
  static List<String> get paymentActions => [
        paymentMade,
        paymentFailed,
        paymentRefunded,
      ];

  /// Get all contribution-related action types
  static List<String> get contributionActions => [
        contributionCreated,
        contributionUpdated,
        contributionDeleted,
        contributionPaused,
      ];

  /// Get all payout-related action types
  static List<String> get payoutActions => [
        payoutProcessed,
        payoutRotationAdvanced,
      ];

  /// Get all settings-related action types
  static List<String> get settingsActions => [
        groupCreated,
        groupUpdated,
        settingsChanged,
      ];
}

/// AI-generated group account report
class GroupAccountReport extends Equatable {
  final String title;
  final String summary;
  final String impactStory;
  final List<String> contributorHighlights;
  final List<Map<String, dynamic>> milestones;
  final String callToAction;
  final Map<String, String> sharingText;
  final List<String> hashtags;
  final bool success;
  final DateTime generatedAt;
  final String? error;

  const GroupAccountReport({
    required this.title,
    required this.summary,
    required this.impactStory,
    required this.contributorHighlights,
    required this.milestones,
    required this.callToAction,
    required this.sharingText,
    required this.hashtags,
    required this.success,
    required this.generatedAt,
    this.error,
  });

  @override
  List<Object?> get props => [
        title,
        summary,
        impactStory,
        contributorHighlights,
        milestones,
        callToAction,
        sharingText,
        hashtags,
        success,
        generatedAt,
        error,
      ];

  factory GroupAccountReport.fromJson(Map<String, dynamic> json) {
    return GroupAccountReport(
      title: json['title'] as String,
      summary: json['summary'] as String,
      impactStory: json['impact_story'] as String? ?? '',
      contributorHighlights: (json['contributor_highlights'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      callToAction: json['call_to_action'] as String? ?? '',
      sharingText: Map<String, String>.from(
        json['sharing_text'] as Map<String, dynamic>? ?? {},
      ),
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      success: json['success'] as bool? ?? true,
      generatedAt: DateTime.parse(json['generated_at'] as String),
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'summary': summary,
      'impact_story': impactStory,
      'contributor_highlights': contributorHighlights,
      'milestones': milestones,
      'call_to_action': callToAction,
      'sharing_text': sharingText,
      'hashtags': hashtags,
      'success': success,
      'generated_at': generatedAt.toIso8601String(),
      if (error != null) 'error': error,
    };
  }
}

/// Top contributor info for public group detail view
class PublicGroupContributor extends Equatable {
  final String userId;
  final String displayName;
  final String? profileImage;
  final double totalContributed;
  final int contributionCount;

  const PublicGroupContributor({
    required this.userId,
    required this.displayName,
    this.profileImage,
    required this.totalContributed,
    required this.contributionCount,
  });

  @override
  List<Object?> get props => [userId, displayName, profileImage, totalContributed, contributionCount];
}

/// Public group detail with statistics and membership info
class PublicGroupDetail extends Equatable {
  final GroupAccount group;
  final Map<String, dynamic>? statistics;
  final List<PublicGroupContributor> topContributors;
  final bool isMember;

  const PublicGroupDetail({
    required this.group,
    this.statistics,
    this.topContributors = const [],
    required this.isMember,
  });

  @override
  List<Object?> get props => [group, statistics, topContributors, isMember];
}

/// Extension for GroupVisibility display
extension GroupVisibilityExtension on GroupVisibility {
  String get displayName {
    switch (this) {
      case GroupVisibility.private:
        return 'Private';
      case GroupVisibility.public:
        return 'Public';
    }
  }
}