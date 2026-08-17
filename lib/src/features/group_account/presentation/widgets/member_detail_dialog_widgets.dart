part of 'member_detail_dialog.dart';

/// Dialog for changing member role.
///
/// [currentUserRole] is the role of the operator opening the dialog.
/// When it's not admin, the `admin` option is hidden from the picker
/// (mirrors the server-side rule that only admins can promote to
/// admin). Defaults to **viewer** (least-privilege) so any call site
/// that forgets to pass it falls into the safest configuration —
/// the picker shows non-admin options only and the server still
/// rejects unauthorised submissions.
class ChangeRoleDialog extends StatefulWidget {
  final GroupMember member;
  final Function(GroupMemberRole) onRoleSelected;
  final GroupMemberRole currentUserRole;

  const ChangeRoleDialog({
    super.key,
    required this.member,
    required this.onRoleSelected,
    this.currentUserRole = GroupMemberRole.viewer,
  });

  @override
  State<ChangeRoleDialog> createState() => _ChangeRoleDialogState();
}

class _ChangeRoleDialogState extends State<ChangeRoleDialog> {
  late GroupMemberRole _selectedRole;

  String _getDisplayName() {
    if (widget.member.userName.isNotEmpty) return widget.member.userName;
    if (widget.member.userUsername != null && widget.member.userUsername!.isNotEmpty) {
      return '@${widget.member.userUsername}';
    }
    if (widget.member.email.isNotEmpty) {
      return widget.member.email.split('@').first;
    }
    return 'Unknown User';
  }

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.member.role;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    color: const Color(0xFFFB923C),
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change Role',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _getDisplayName(),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Role options — hide admin for non-admin operators (server
            // rejects promotion-to-admin from a moderator anyway, this
            // just keeps the UI honest).
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: GroupMemberRole.values
                    .where((role) =>
                        role != GroupMemberRole.admin ||
                        widget.currentUserRole == GroupMemberRole.admin)
                    .map((role) {
                  final isSelected = role == _selectedRole;
                  final roleColor = _getRoleColor(role);
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRole = role),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? roleColor.withValues(alpha: 0.15)
                            : const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(10.r),
                        border: isSelected
                            ? Border.all(
                                color: roleColor.withValues(alpha: 0.5),
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? roleColor
                                  : const Color(0xFF3D3D3D),
                              border: Border.all(
                                color: isSelected
                                    ? roleColor
                                    : const Color(0xFF4D4D4D),
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12.sp,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  role.displayName,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? roleColor : Colors.white,
                                  ),
                                ),
                                Text(
                                  _getRoleDescription(role),
                                  style: GoogleFonts.inter(
                                    fontSize: 11.sp,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Actions
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedRole != widget.member.role
                          ? () {
                              Navigator.pop(context);
                              widget.onRoleSelected(_selectedRole);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF3D3D3D),
                        disabledForegroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return const Color(0xFFEF4444);
      case GroupMemberRole.moderator:
        return const Color(0xFFFB923C);
      case GroupMemberRole.member:
        return const Color(0xFF10B981);
      case GroupMemberRole.viewer:
        return const Color(0xFF6B7280);
    }
  }

  String _getRoleDescription(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return 'Full control over group settings and members';
      case GroupMemberRole.moderator:
        return 'Add/remove members. Cannot delete the group, change admin roles, or initiate payouts.';
      case GroupMemberRole.member:
        return 'Can view and make payments';
      case GroupMemberRole.viewer:
        return 'Read-only access. Cannot contribute or modify anything.';
    }
  }
}

/// Confirmation dialog for removing a member
class RemoveMemberConfirmDialog extends StatelessWidget {
  final GroupMember member;
  final VoidCallback onConfirm;

  const RemoveMemberConfirmDialog({
    super.key,
    required this.member,
    required this.onConfirm,
  });

  String _getDisplayName() {
    if (member.userName.isNotEmpty) return member.userName;
    if (member.userUsername != null && member.userUsername!.isNotEmpty) {
      return '@${member.userUsername}';
    }
    if (member.email.isNotEmpty) {
      return member.email.split('@').first;
    }
    return 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_remove,
                      color: const Color(0xFFEF4444),
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Remove Member',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Are you sure you want to remove ${_getDisplayName()} from this group?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'This action cannot be undone',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: const Color(0xFF2D2D2D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Remove',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
