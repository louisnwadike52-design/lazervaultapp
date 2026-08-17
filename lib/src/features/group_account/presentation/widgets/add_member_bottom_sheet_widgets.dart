part of 'add_member_bottom_sheet.dart';

/// Helper class to track selected users with their assigned roles
class _SelectedMember {
  final UserSearchResultEntity user;
  GroupMemberRole role;

  _SelectedMember({required this.user, required this.role});
}

/// Helper class to track pending invites (users not on LazerVault)
class _PendingInvite {
  final String email;
  final String fullName;
  GroupMemberRole role;

  _PendingInvite({required this.email, required this.fullName, required this.role});
}
