part of 'group_entities.dart';

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
