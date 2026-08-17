part of 'group_entities.dart';

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
