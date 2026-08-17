import 'package:equatable/equatable.dart';
part 'group_entities_enums.dart';
part 'group_entities_contribution.dart';
part 'group_entities_payout.dart';
part 'group_entities_activity.dart';


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

  // True when the CURRENT user is an active member of this group.
  // Populated by discovery/list endpoints (e.g. ListPublicGroups) so
  // the UI can render "Joined" vs "Join" without a per-group detail
  // fetch. Defaults false on endpoints that don't resolve membership
  // (the `members` list is not preloaded on list responses, so it
  // can't be inferred client-side).
  final bool isMember;

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
    this.isMember = false,
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
        isMember,
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
    bool? isMember,
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
      isMember: isMember ?? this.isMember,
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
