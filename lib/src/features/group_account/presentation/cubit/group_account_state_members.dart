part of 'group_account_state.dart';

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
