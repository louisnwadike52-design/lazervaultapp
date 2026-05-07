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

/// Role granted to a member of a group.
///
/// Permission boundaries (enforced server-side; the Flutter side mirrors
/// them in [GroupRolePermissions] for UI affordance gating only):
///
///   admin     — full control: edit + delete group, payouts, settings,
///               and ALL moderator capabilities.
///   moderator — day-to-day management: invite/remove non-admin members,
///               edit non-financial group metadata. CANNOT delete the
///               group, change another member's role to admin, or
///               initiate payouts.
///   member    — participate: contribute, view, no management.
///   viewer    — read-only.
enum GroupMemberRole {
  admin,
  moderator,
  member,
  viewer,
}

/// Discrete actions a UI surface might want to enable/disable. Mirrors
/// the server-side `internal/service/group_permissions.go` matrix so the
/// Flutter app can hide affordances the user can't use — but the SERVER
/// is still the source of truth and will reject any request that
/// circumvents the UI gate.
enum GroupAction {
  editGroup,
  deleteGroup,
  inviteMember,
  removeMember,
  changeMemberRole,
  promoteToAdmin,
  approveJoinRequest,
  createContribution,
  editContribution,
  deleteContribution,
  makeContribution,
  initiatePayout,
  advancePayoutCycle,
  viewGroup,
  viewActivity,
}

/// UI-side mirror of the server's role-action matrix. Update both sides
/// in lockstep; an out-of-sync table here is a UX bug, not a security
/// bug (server still enforces).
class GroupRolePermissions {
  static const Map<GroupMemberRole, Set<GroupAction>> _allow = {
    GroupMemberRole.admin: {
      GroupAction.editGroup,
      GroupAction.deleteGroup,
      GroupAction.inviteMember,
      GroupAction.removeMember,
      GroupAction.changeMemberRole,
      GroupAction.promoteToAdmin,
      GroupAction.approveJoinRequest,
      GroupAction.createContribution,
      GroupAction.editContribution,
      GroupAction.deleteContribution,
      GroupAction.makeContribution,
      GroupAction.initiatePayout,
      GroupAction.advancePayoutCycle,
      GroupAction.viewGroup,
      GroupAction.viewActivity,
    },
    GroupMemberRole.moderator: {
      GroupAction.editGroup,
      GroupAction.inviteMember,
      GroupAction.removeMember,
      GroupAction.changeMemberRole,
      GroupAction.approveJoinRequest,
      GroupAction.createContribution,
      GroupAction.makeContribution,
      GroupAction.viewGroup,
      GroupAction.viewActivity,
    },
    GroupMemberRole.member: {
      GroupAction.makeContribution,
      GroupAction.viewGroup,
      GroupAction.viewActivity,
    },
    GroupMemberRole.viewer: {
      GroupAction.viewGroup,
      GroupAction.viewActivity,
    },
  };

  /// True iff [role] is allowed to perform [action]. Default-deny.
  static bool can(GroupMemberRole? role, GroupAction action) {
    if (role == null) return false;
    return _allow[role]?.contains(action) ?? false;
  }

  /// True iff [member] is allowed to perform [action] right now.
  ///
  /// Combines the role-permission table with the member's lifecycle
  /// state — a `pending` invite, an `inactive` member, or a `removed`
  /// row never passes regardless of role. Mirrors the server's
  /// `assertCan` which loads the row and checks `Status == active`
  /// before consulting the role matrix; without this Flutter would
  /// surface affordances that the backend immediately rejects.
  static bool canMember(GroupMember? member, GroupAction action) {
    if (member == null) return false;
    if (member.status != GroupMemberStatus.active) return false;
    return can(member.role, action);
  }
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
  // Money may have moved at accounts-service but the response was lost or
  // ambiguous. The backend supervisor is reconciling — outcome will land
  // at completed | failed | refunding | manual_review. UI should treat
  // this as "still in flight" and refuse to start a fresh payment with a
  // different idempotency key for the same intent.
  awaitingVerification,
  completed,
  failed,
  cancelled,
  // Phase 3 of the payment failed AFTER a successful debit. The backend
  // rollback processor is issuing the compensating credit. UI should
  // surface this clearly: the user WILL be refunded but it isn't done yet.
  refunding,
  refunded,
  // Reconciliation exhausted automated retries. An operator must
  // intervene. UI should show "we're looking into it" / contact-support.
  manualReview,
}

enum ContributionType {
  oneTime,
  rotatingSavings,
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
  failed,
  cancelled,
  overdue,
  manualReview,
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
  // Denormalized server-side count of contributions on this group.
  // Surfaced so the "Goals" stat tile on the My Groups list can read
  // it directly — `contributions.length` is unreliable here because
  // the list-groups endpoint deliberately does NOT preload the
  // contributions array (perf) and would always show 0.
  final int contributionCount;

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
    this.contributionCount = 0,
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
        contributionCount,
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
    int? contributionCount,
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
      contributionCount: contributionCount ?? this.contributionCount,
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
  final bool emailMatchesSearchQuery;
  final bool phoneMatchesSearchQueryExact;

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
    this.emailMatchesSearchQuery = false,
    this.phoneMatchesSearchQueryExact = false,
  });

  /// True when this row is a synthetic shadow for a pending group
  /// invitation rather than a fully-joined member. Drives the
  /// "Invite Sent" badge + admin "Cancel invite" CTA. Server signals
  /// it via `status=pending` (translated from `inactive + isPartial`
  /// in the gRPC mapper) or via the `permissions.invitation_status`
  /// field, both of which collapse to this single getter.
  bool get isPendingInvite =>
      status == GroupMemberStatus.pending ||
      (isPartial &&
          permissions != null &&
          (permissions!['invitation_status'] == 'pending' ||
              permissions!['invitation_id'] != null));

  /// The linked invitation id (when pending), so admin actions like
  /// "Cancel invite" can target the underlying GroupInvitation.
  String? get linkedInvitationId {
    if (permissions == null) return null;
    final v = permissions!['invitation_id'];
    return v is String && v.isNotEmpty ? v : null;
  }

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
        emailMatchesSearchQuery,
        phoneMatchesSearchQueryExact,
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
    bool? emailMatchesSearchQuery,
    bool? phoneMatchesSearchQueryExact,
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
      emailMatchesSearchQuery:
          emailMatchesSearchQuery ?? this.emailMatchesSearchQuery,
      phoneMatchesSearchQueryExact:
          phoneMatchesSearchQueryExact ?? this.phoneMatchesSearchQueryExact,
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
      case GroupMemberRole.viewer:
        return 'Viewer';
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

  // Drives the payout scheduler. When true, the platform fires the
  // payout automatically once a receiver is set (at deadline / cycle
  // close, or immediately if the deadline already passed). When false,
  // the creator must press the manual-trigger CTA to release funds.
  // Distinct from autoPayEnabled (above) which controls MEMBER-side
  // auto-debiting of contribution payments.
  final bool autoPayoutEnabled;

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
    this.autoPayoutEnabled = false,
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
        autoPayoutEnabled,
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
    bool? autoPayoutEnabled,
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
      autoPayoutEnabled: autoPayoutEnabled ?? this.autoPayoutEnabled,
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
  /// Cumulative completed payments for the CURRENT cycle. ROSCA +
  /// allow_partial_payments members can pay their share in chunks;
  /// has_paid_current_cycle stays false until cumulative reaches
  /// regular_amount. Reset to 0 on cycle advance. Always 0 for
  /// one-time contributions.
  final double cyclePaidAmount;
  /// Number of cycles this member's row has missed (no completed
  /// payment by cycle close). Surfaced for the "X members behind"
  /// indicators on the contribution screen.
  final int missedCycles;
  /// Invite-first membership state. ACTIVE rows are full participants;
  /// PENDING_INVITE rows are shadow placeholders waiting on group
  /// invite acceptance and MUST be excluded from financial logic
  /// (member counts, cycle progress, receiver picker).
  final ContributionMembershipStatus membershipStatus;
  /// Linked GroupInvitation row ID when membership is pending. Lets
  /// the UI deep-link to the invite detail or surface "Invite Sent".
  final String? linkedInvitationId;

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
    this.cyclePaidAmount = 0,
    this.missedCycles = 0,
    this.membershipStatus = ContributionMembershipStatus.active,
    this.linkedInvitationId,
  });

  /// Convenience for filtering member lists down to active
  /// participants when computing financial roll-ups.
  bool get isActiveParticipant =>
      membershipStatus == ContributionMembershipStatus.active;

  /// True when this is a shadow row tracking a pending parent group
  /// invitation. UI uses this to render "Invite Sent" instead of
  /// payment progress.
  bool get isPendingInvite =>
      membershipStatus == ContributionMembershipStatus.pendingInvite;

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
        cyclePaidAmount,
        missedCycles,
        membershipStatus,
        linkedInvitationId,
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
    double? cyclePaidAmount,
    int? missedCycles,
    ContributionMembershipStatus? membershipStatus,
    String? linkedInvitationId,
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
      cyclePaidAmount: cyclePaidAmount ?? this.cyclePaidAmount,
      missedCycles: missedCycles ?? this.missedCycles,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      linkedInvitationId: linkedInvitationId ?? this.linkedInvitationId,
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
      case GroupMemberRole.viewer:
        return 'Viewer';
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
      case PaymentStatus.awaitingVerification:
        return 'Verifying';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      case PaymentStatus.refunding:
        return 'Refund pending';
      case PaymentStatus.refunded:
        return 'Refunded';
      case PaymentStatus.manualReview:
        return 'Under review';
    }
  }

  /// True when the status is in-flight at the backend (non-terminal).
  bool get isInFlight {
    switch (this) {
      case PaymentStatus.pending:
      case PaymentStatus.processing:
      case PaymentStatus.awaitingVerification:
      case PaymentStatus.refunding:
        return true;
      default:
        return false;
    }
  }

  /// True when the user has been (or will be) refunded — money is being
  /// returned, the contribution should NOT be considered paid.
  bool get isRefundPath {
    return this == PaymentStatus.refunding || this == PaymentStatus.refunded;
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
        return 'One time Goal';
      case ContributionType.rotatingSavings:
        return 'Rotating Savings (Susu)';
    }
  }

  String get description {
    switch (this) {
      case ContributionType.oneTime:
        return 'Collect money once for a specific goal';
      case ContributionType.rotatingSavings:
        return 'Members contribute regularly and take turns receiving payouts';
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

/// Domain mirror of PreviewMemberExitResponse. Drives the
/// confirmation modal so the user sees the refund / forfeit
/// breakdown before committing. Amounts are in MAJOR units already.
class MemberExitPreview {
  /// True if the saga can proceed. False means the contribution is
  /// in a terminal state (e.g. one-time settled — funds disbursed)
  /// and the actual exit RPC would reject.
  final bool exitAllowed;
  /// Server-provided text when [exitAllowed] is false.
  final String blockedReason;
  /// Saga decision label, e.g. "self_leave_rosca_pre_payout".
  final String removalReason;
  /// Credit the member will receive on exit.
  final double refundAmount;
  /// Money the member forfeits (already paid out to other
  /// recipients in historical ROSCA cycles).
  final double forfeitedAmount;
  final String currency;
  /// True when the member already received a payout. Refund is 0;
  /// UI shows "your share is already settled".
  final bool memberHasReceivedPayout;
  /// Cycle index used to compute the refund window. 0 for one-time.
  final int currentCycle;

  const MemberExitPreview({
    required this.exitAllowed,
    required this.blockedReason,
    required this.removalReason,
    required this.refundAmount,
    required this.forfeitedAmount,
    required this.currency,
    required this.memberHasReceivedPayout,
    required this.currentCycle,
  });
}

/// Lifecycle of a parent group invite. Mirrors the server's
/// GroupInvitationStatus enum.
enum GroupInvitationStatus {
  pending,
  accepted,
  declined,
  cancelled,
  expired,
  unknown;

  static GroupInvitationStatus fromString(String? s) {
    switch (s) {
      case 'pending':
        return GroupInvitationStatus.pending;
      case 'accepted':
        return GroupInvitationStatus.accepted;
      case 'declined':
        return GroupInvitationStatus.declined;
      case 'cancelled':
        return GroupInvitationStatus.cancelled;
      case 'expired':
        return GroupInvitationStatus.expired;
      default:
        return GroupInvitationStatus.unknown;
    }
  }

  String get wireValue {
    switch (this) {
      case GroupInvitationStatus.pending:
        return 'pending';
      case GroupInvitationStatus.accepted:
        return 'accepted';
      case GroupInvitationStatus.declined:
        return 'declined';
      case GroupInvitationStatus.cancelled:
        return 'cancelled';
      case GroupInvitationStatus.expired:
        return 'expired';
      case GroupInvitationStatus.unknown:
        return '';
    }
  }
}

/// Membership state for a contribution_members row. Drives the
/// "Invite Sent" chip on shadow rows + every active-only filter the
/// UI has to apply (member counts, cycle progress, receiver picker).
enum ContributionMembershipStatus {
  active,
  pendingInvite,
  declined;

  static ContributionMembershipStatus fromString(String? s) {
    switch (s) {
      case 'pending_invite':
        return ContributionMembershipStatus.pendingInvite;
      case 'declined':
        return ContributionMembershipStatus.declined;
      case 'active':
      default:
        return ContributionMembershipStatus.active;
    }
  }
}

/// Domain mirror of GroupInvitationMessage. Drives the Flutter
/// Invites tab + "Invite Sent" chips on member rosters.
class GroupInvitation {
  final String id;
  final String groupId;
  final String inviteeUserId;
  final String inviterUserId;
  final String role;
  final GroupInvitationStatus status;
  final DateTime invitedAt;
  final DateTime? decidedAt;
  final DateTime expiresAt;
  final String message;
  /// Group-side denormalised fields. Empty when not loaded.
  final String groupName;
  final String groupDescription;
  final String inviterName;

  const GroupInvitation({
    required this.id,
    required this.groupId,
    required this.inviteeUserId,
    required this.inviterUserId,
    required this.role,
    required this.status,
    required this.invitedAt,
    this.decidedAt,
    required this.expiresAt,
    this.message = '',
    this.groupName = '',
    this.groupDescription = '',
    this.inviterName = '',
  });

  bool get isPending => status == GroupInvitationStatus.pending;
  bool get isExpired =>
      expiresAt.isBefore(DateTime.now()) ||
      status == GroupInvitationStatus.expired;
}

/// Domain mirror of RemoveMemberFromContributionResponse.
class MemberExitResult {
  final bool success;
  final double refundAmount;
  final double forfeitedAmount;
  /// One of "none", "pending", "completed", "failed".
  final String refundStatus;
  final String removalReason;

  const MemberExitResult({
    required this.success,
    required this.refundAmount,
    required this.forfeitedAmount,
    required this.refundStatus,
    required this.removalReason,
  });
}
// =============================================================
// Cycle history entities.
// =============================================================

/// Lifecycle of a contribution cycle. Mirrors the server-side enum
/// in models.ContributionCycleStatus.
enum ContributionCycleStatus {
  /// The currently-active cycle. Only one per contribution at a
  /// time. Live counters drive its rendering until close.
  inProgress,

  /// Cycle closed with a successful payout (ROSCA) or goal-reached
  /// (one-time).
  closedSettled,

  /// Cycle closed without a successful payout — recipient declined,
  /// retries exhausted, etc. Pot may carry forward.
  closedFailed,

  /// Cycle stopped by admin action (e.g. early restart of a one-time
  /// before target reached).
  closedCancelled,
}

ContributionCycleStatus contributionCycleStatusFromString(String? raw) {
  switch (raw) {
    case 'closed_settled':
      return ContributionCycleStatus.closedSettled;
    case 'closed_failed':
      return ContributionCycleStatus.closedFailed;
    case 'closed_cancelled':
      return ContributionCycleStatus.closedCancelled;
    case 'in_progress':
    default:
      return ContributionCycleStatus.inProgress;
  }
}

/// Frozen-at-close summary of one cycle. Drives the history list
/// row and the bottom-sheet header. Amounts are MAJOR units (the
/// gRPC datasource converts from minor units at the boundary, same
/// pattern other monetary values use in this app).
class ContributionCycle extends Equatable {
  final String id;
  final String contributionId;
  final int cycleIndex;
  final ContributionCycleStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double targetAmount;
  final double raisedAmount;
  final double deficitAmount;
  final String? payoutTransactionId;
  final String? receiverUserId;
  final String receiverName;
  final int paymentCount;
  final int membersCount;
  final int pendingMembersCount;
  final int partialMembersCount;
  final String closeReason;
  final String currency;

  const ContributionCycle({
    required this.id,
    required this.contributionId,
    required this.cycleIndex,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.targetAmount,
    required this.raisedAmount,
    this.deficitAmount = 0,
    this.payoutTransactionId,
    this.receiverUserId,
    this.receiverName = '',
    this.paymentCount = 0,
    this.membersCount = 0,
    this.pendingMembersCount = 0,
    this.partialMembersCount = 0,
    this.closeReason = '',
    this.currency = '',
  });

  bool get isLive => status == ContributionCycleStatus.inProgress;
  bool get isSettled => status == ContributionCycleStatus.closedSettled;
  bool get isFailed => status == ContributionCycleStatus.closedFailed;
  bool get isCancelled =>
      status == ContributionCycleStatus.closedCancelled;

  double get progressPercent =>
      targetAmount > 0 ? (raisedAmount / targetAmount * 100).clamp(0.0, 999.0) : 0.0;

  @override
  List<Object?> get props => [
        id,
        contributionId,
        cycleIndex,
        status,
        startedAt,
        endedAt,
        targetAmount,
        raisedAmount,
        deficitAmount,
        payoutTransactionId,
        receiverUserId,
        receiverName,
        paymentCount,
        membersCount,
        pendingMembersCount,
        partialMembersCount,
        closeReason,
        currency,
      ];
}

/// Per-member snapshot for one cycle. Drives the Members tab in the
/// cycle-details bottom sheet.
class ContributionCycleMemberSnapshot extends Equatable {
  final String userId;
  final String userName;
  final String email;
  final double expectedAmount;
  final double paidAmount;
  final bool hasPaid;
  final bool wasReceiver;
  final int missedCyclesAtClose;
  final String statusAtClose;
  final DateTime? joinedAt;

  const ContributionCycleMemberSnapshot({
    required this.userId,
    required this.userName,
    this.email = '',
    this.expectedAmount = 0,
    this.paidAmount = 0,
    this.hasPaid = false,
    this.wasReceiver = false,
    this.missedCyclesAtClose = 0,
    this.statusAtClose = 'active',
    this.joinedAt,
  });

  /// Helpers for the UI's filter chips on the Members tab.
  bool get isPartial =>
      !hasPaid && paidAmount > 0 && paidAmount < expectedAmount;
  bool get isPending => !hasPaid && paidAmount == 0;
  bool get isFullyPaid => hasPaid;

  @override
  List<Object?> get props => [
        userId,
        userName,
        email,
        expectedAmount,
        paidAmount,
        hasPaid,
        wasReceiver,
        missedCyclesAtClose,
        statusAtClose,
        joinedAt,
      ];
}

/// Bundled payload for the cycle-details bottom sheet — one round
/// trip populates every tab.
class ContributionCycleDetails extends Equatable {
  final ContributionCycle summary;
  final List<ContributionCycleMemberSnapshot> members;
  final List<ContributionPayment> payments;

  const ContributionCycleDetails({
    required this.summary,
    this.members = const [],
    this.payments = const [],
  });

  @override
  List<Object?> get props => [summary, members, payments];
}
