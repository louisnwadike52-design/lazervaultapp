import 'package:equatable/equatable.dart';
import '../../domain/entities/group_entities.dart';

// Export for convenience
export '../../domain/entities/group_entities.dart';

abstract class GroupAccountState extends Equatable {
  const GroupAccountState();

  @override
  List<Object?> get props => [];
}

class GroupAccountInitial extends GroupAccountState {}

class GroupAccountLoading extends GroupAccountState {
  final String? message;
  
  const GroupAccountLoading({this.message});
  
  @override
  List<Object?> get props => [message];
}

class GroupAccountGroupsLoaded extends GroupAccountState {
  final List<GroupAccount> groups;
  final bool isStale;
  final bool isRevalidating;

  const GroupAccountGroupsLoaded(
    this.groups, {
    this.isStale = false,
    this.isRevalidating = false,
  });

  GroupAccountGroupsLoaded copyWith({
    List<GroupAccount>? groups,
    bool? isStale,
    bool? isRevalidating,
  }) {
    return GroupAccountGroupsLoaded(
      groups ?? this.groups,
      isStale: isStale ?? this.isStale,
      isRevalidating: isRevalidating ?? this.isRevalidating,
    );
  }

  @override
  List<Object?> get props => [groups, isStale, isRevalidating];
}

class GroupAccountGroupLoaded extends GroupAccountState {
  final GroupAccount group;
  final List<GroupMember> members;
  final List<Contribution> contributions;
  
  const GroupAccountGroupLoaded({
    required this.group,
    required this.members,
    required this.contributions,
  });
  
  @override
  List<Object?> get props => [group, members, contributions];
}

class GroupAccountGroupCreated extends GroupAccountState {
  final GroupAccount group;
  
  const GroupAccountGroupCreated(this.group);
  
  @override
  List<Object?> get props => [group];
}

class GroupAccountContributionCreated extends GroupAccountState {
  final Contribution contribution;
  
  const GroupAccountContributionCreated(this.contribution);
  
  @override
  List<Object?> get props => [contribution];
}

class GroupAccountPaymentCompleted extends GroupAccountState {
  final ContributionPayment payment;

  const GroupAccountPaymentCompleted(this.payment);

  @override
  List<Object?> get props => [payment];
}

/// Payment processing state - shown during payment
class ContributionPaymentProcessing extends GroupAccountState {
  final String contributionId;
  final double amount;
  final String? message;

  const ContributionPaymentProcessing({
    required this.contributionId,
    required this.amount,
    this.message,
  });

  @override
  List<Object?> get props => [contributionId, amount, message];
}

/// Payment success with detailed response
class ContributionPaymentSuccess extends GroupAccountState {
  final ContributionPayment payment;
  final String message;
  final Contribution? updatedContribution;

  const ContributionPaymentSuccess({
    required this.payment,
    required this.message,
    this.updatedContribution,
  });

  @override
  List<Object?> get props => [payment, message, updatedContribution];
}

/// Payment failed with specific error type
class ContributionPaymentFailed extends GroupAccountState {
  final String error;
  final bool isInsufficientBalance;
  final bool isPinInvalid;
  final bool isDuplicate;
  final double? requiredAmount;
  final double? availableBalance;

  const ContributionPaymentFailed({
    required this.error,
    this.isInsufficientBalance = false,
    this.isPinInvalid = false,
    this.isDuplicate = false,
    this.requiredAmount,
    this.availableBalance,
  });

  @override
  List<Object?> get props => [
        error,
        isInsufficientBalance,
        isPinInvalid,
        isDuplicate,
        requiredAmount,
        availableBalance,
      ];
}

class GroupAccountReceiptGenerated extends GroupAccountState {
  final ContributionReceipt receipt;
  
  const GroupAccountReceiptGenerated(this.receipt);
  
  @override
  List<Object?> get props => [receipt];
}

class GroupAccountTranscriptGenerated extends GroupAccountState {
  final ContributionTranscript transcript;
  
  const GroupAccountTranscriptGenerated(this.transcript);
  
  @override
  List<Object?> get props => [transcript];
}

class GroupAccountError extends GroupAccountState {
  final String message;
  
  const GroupAccountError(this.message);
  
  @override
  List<Object?> get props => [message];
}

class GroupAccountSuccess extends GroupAccountState {
  final String message;

  const GroupAccountSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Result of a generic user search initiated from the add-member flow.
class UsersFound extends GroupAccountState {
  final List<GroupMember> users;
  final String query;

  const UsersFound({required this.users, required this.query});

  @override
  List<Object?> get props => [users, query];
}

/// Member added successfully - includes the new member for reactive UI updates
class MemberAddedSuccess extends GroupAccountState {
  final GroupMember member;
  final String groupId;
  final String message;

  const MemberAddedSuccess({
    required this.member,
    required this.groupId,
    required this.message,
  });

  @override
  List<Object?> get props => [member, groupId, message];
}

/// User search result - found existing user
class UserSearchFound extends GroupAccountState {
  final String userId;
  final String userName;
  final String email;
  final String? profileImage;
  final String? lazerTag;

  const UserSearchFound({
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImage,
    this.lazerTag,
  });

  @override
  List<Object?> get props => [userId, userName, email, profileImage, lazerTag];
}

/// User search result - not found (for invite flow)
class UserSearchNotFound extends GroupAccountState {
  final String searchQuery;
  final UserSearchType searchType;

  const UserSearchNotFound({
    required this.searchQuery,
    required this.searchType,
  });

  @override
  List<Object?> get props => [searchQuery, searchType];
}

/// User search in progress
class UserSearchLoading extends GroupAccountState {
  const UserSearchLoading();
}

/// User search cleared
class UserSearchCleared extends GroupAccountState {
  const UserSearchCleared();
}

/// Search type enum
enum UserSearchType { email, lazerTag, phone }

/// User already a member
class UserAlreadyMember extends GroupAccountState {
  final String userName;

  const UserAlreadyMember(this.userName);

  @override
  List<Object?> get props => [userName];
}

/// Invite sent successfully
class InviteSentSuccess extends GroupAccountState {
  final String message;
  final String identifier;

  const InviteSentSuccess({
    required this.message,
    required this.identifier,
  });

  @override
  List<Object?> get props => [message, identifier];
}

/// Members added to contribution successfully
class ContributionMembersAdded extends GroupAccountState {
  final List<ContributionMember> members;
  final String message;

  const ContributionMembersAdded({
    required this.members,
    required this.message,
  });

  @override
  List<Object?> get props => [members, message];
}

/// Activity logs loaded for a group
class GroupActivityLogsLoaded extends GroupAccountState {
  final List<ActivityLogEntry> logs;
  final String groupId;

  const GroupActivityLogsLoaded({
    required this.logs,
    required this.groupId,
  });

  @override
  List<Object?> get props => [logs, groupId];
}

/// Activity logs loaded for a contribution
class ContributionActivityLogsLoaded extends GroupAccountState {
  final List<ActivityLogEntry> logs;
  final String contributionId;

  const ContributionActivityLogsLoaded({
    required this.logs,
    required this.contributionId,
  });

  @override
  List<Object?> get props => [logs, contributionId];
}

/// Activity logs loading state
class ActivityLogsLoading extends GroupAccountState {
  const ActivityLogsLoading();
}

/// Member removed from group successfully
class MemberRemovedSuccess extends GroupAccountState {
  final String memberId;
  final String groupId;
  final String message;

  const MemberRemovedSuccess({
    required this.memberId,
    required this.groupId,
    required this.message,
  });

  @override
  List<Object?> get props => [memberId, groupId, message];
}

/// Member role updated successfully
class MemberRoleUpdatedSuccess extends GroupAccountState {
  final String memberId;
  final String groupId;
  final GroupMemberRole newRole;
  final String message;

  const MemberRoleUpdatedSuccess({
    required this.memberId,
    required this.groupId,
    required this.newRole,
    required this.message,
  });

  @override
  List<Object?> get props => [memberId, groupId, newRole, message];
}

/// Report generation in progress
class GroupAccountReportLoading extends GroupAccountState {
  final String? message;

  const GroupAccountReportLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Report generated successfully
class GroupAccountReportGenerated extends GroupAccountState {
  final GroupAccountReport report;
  final GroupAccount group;
  final List<Contribution> contributions;
  final String? groupUrl;

  const GroupAccountReportGenerated({
    required this.report,
    required this.group,
    required this.contributions,
    this.groupUrl,
  });

  @override
  List<Object?> get props => [report, group, contributions, groupUrl];
}

/// Report shared successfully
class GroupAccountReportShared extends GroupAccountState {
  final String? message;

  const GroupAccountReportShared({this.message});

  @override
  List<Object?> get props => [message];
}

/// Report share error
class GroupAccountReportShareError extends GroupAccountState {
  final String message;

  const GroupAccountReportShareError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Public groups loaded for discovery
class PublicGroupsLoaded extends GroupAccountState {
  final List<GroupAccount> groups;
  final int totalCount;
  final bool isStale;

  const PublicGroupsLoaded({
    required this.groups,
    required this.totalCount,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [groups, totalCount, isStale];
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

// =============================================================
// Cycle history states.
// =============================================================

class ContributionCyclesLoading extends GroupAccountState {
  final String contributionId;
  const ContributionCyclesLoading({required this.contributionId});
  @override
  List<Object?> get props => [contributionId];
}

class ContributionCyclesLoaded extends GroupAccountState {
  final String contributionId;
  final List<ContributionCycle> cycles;
  final int total;
  const ContributionCyclesLoaded({
    required this.contributionId,
    required this.cycles,
    required this.total,
  });
  @override
  List<Object?> get props => [contributionId, cycles, total];
}

class ContributionCycleDetailsLoading extends GroupAccountState {
  final String contributionId;
  final int cycleIndex;
  const ContributionCycleDetailsLoading({
    required this.contributionId,
    required this.cycleIndex,
  });
  @override
  List<Object?> get props => [contributionId, cycleIndex];
}

class ContributionCycleDetailsLoaded extends GroupAccountState {
  final ContributionCycleDetails details;
  const ContributionCycleDetailsLoaded({required this.details});
  @override
  List<Object?> get props => [details];
}

class ContributionRestarted extends GroupAccountState {
  final Contribution contribution;
  final String message;
  const ContributionRestarted({
    required this.contribution,
    this.message = 'Contribution restarted',
  });
  @override
  List<Object?> get props => [contribution, message];
}
