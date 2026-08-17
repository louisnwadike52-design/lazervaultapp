part of 'group_account_state.dart';

/// Public groups loaded for discovery
class PublicGroupsLoaded extends GroupAccountState {
  final List<GroupAccount> groups;
  final int totalCount;
  final bool isStale;

  /// IDs of the groups (from this list) the current user is ALREADY a
  /// member of. Sourced from the server-provided `GroupAccount.isMember`
  /// flag on the `ListPublicGroups` response (with a zero-cost fallback
  /// against the user's own cached groups for backend-rollout skew).
  /// Drives the "Joined" vs "Join" affordance and the tap destination
  /// (full details vs public preview) so we never show a Join CTA for a
  /// group the user already belongs to.
  final Set<String> memberGroupIds;

  const PublicGroupsLoaded({
    required this.groups,
    required this.totalCount,
    this.isStale = false,
    this.memberGroupIds = const <String>{},
  });

  /// True when the caller is already a member of [groupId].
  bool isMemberOf(String groupId) => memberGroupIds.contains(groupId);

  @override
  List<Object?> get props => [groups, totalCount, isStale, memberGroupIds];
}

/// Public group detail loading. Distinct from the global GroupAccountLoading
/// so the bottom sheet's loading spinner doesn't clobber the leaderboard
/// list behind it. Carries the requested groupId so the sheet can ignore
/// stale loads if the user taps a different row.
class PublicGroupDetailLoading extends GroupAccountState {
  final String groupId;

  const PublicGroupDetailLoading(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

/// Public group detail loaded
class PublicGroupDetailLoaded extends GroupAccountState {
  final PublicGroupDetail detail;

  const PublicGroupDetailLoaded(this.detail);

  @override
  List<Object?> get props => [detail];
}

/// Public group detail failed to load. Separate from GroupAccountError so
/// the leaderboard list doesn't pick up the bottom sheet's failure.
class PublicGroupDetailError extends GroupAccountState {
  final String groupId;
  final String message;

  const PublicGroupDetailError({required this.groupId, required this.message});

  @override
  List<Object?> get props => [groupId, message];
}

/// Successfully joined a public group
class JoinPublicGroupSuccess extends GroupAccountState {
  final GroupAccount group;
  final String message;

  const JoinPublicGroupSuccess({
    required this.group,
    this.message = 'Successfully joined group',
  });

  @override
  List<Object?> get props => [group, message];
}

// =====================================================================
// Invite-first membership states (slice 5)
// =====================================================================

class GroupAccountMyInvitationsLoaded extends GroupAccountState {
  final List<GroupInvitation> invitations;
  const GroupAccountMyInvitationsLoaded(this.invitations);

  @override
  List<Object?> get props => [invitations];

  /// Convenience for the Invites-tab badge — count rows that still
  /// need the user's decision.
  int get pendingCount =>
      invitations.where((i) => i.status == GroupInvitationStatus.pending).length;
}

class GroupAccountInvitationResponded extends GroupAccountState {
  final GroupInvitation invitation;
  /// True if the user accepted; false if they declined. Drives the
  /// success-snackbar copy without the listener having to inspect
  /// the invitation status.
  final bool accepted;
  const GroupAccountInvitationResponded({
    required this.invitation,
    required this.accepted,
  });

  @override
  List<Object?> get props => [invitation, accepted];
}

class GroupAccountInvitationCancelled extends GroupAccountState {
  final String invitationId;
  const GroupAccountInvitationCancelled(this.invitationId);
  @override
  List<Object?> get props => [invitationId];
}

class GroupAccountInvitationCreated extends GroupAccountState {
  final GroupInvitation invitation;
  const GroupAccountInvitationCreated(this.invitation);
  @override
  List<Object?> get props => [invitation];
}

class GroupAccountGroupInvitationsLoaded extends GroupAccountState {
  final String groupId;
  final List<GroupInvitation> invitations;
  const GroupAccountGroupInvitationsLoaded({
    required this.groupId,
    required this.invitations,
  });
  @override
  List<Object?> get props => [groupId, invitations];
}
