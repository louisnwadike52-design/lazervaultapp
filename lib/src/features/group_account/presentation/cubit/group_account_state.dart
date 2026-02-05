import 'package:equatable/equatable.dart';
import '../../domain/entities/group_entities.dart';

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

