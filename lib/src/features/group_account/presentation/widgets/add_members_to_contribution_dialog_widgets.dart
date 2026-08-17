part of 'add_members_to_contribution_dialog.dart';

/// Helper class to track new members to add
class _NewMemberSelection {
  final UserSearchResultEntity? user;
  final String? email;
  final String? fullName;

  _NewMemberSelection({this.user, this.email, this.fullName});
}

/// Member details bottom sheet
class _MemberDetailsSheet extends StatelessWidget {
  final GroupMember member;

  const _MemberDetailsSheet({required this.member});

  /// Helper to get display name with fallback for empty names
  String _getDisplayName() {
    if (member.userName.isNotEmpty) return member.userName;
    if (member.userUsername != null && member.userUsername!.isNotEmpty) {
      return '@${member.userUsername}';
    }
    if (member.email.isNotEmpty) {
      final atIndex = member.email.indexOf('@');
      if (atIndex > 0) {
        return member.email.substring(0, atIndex);
      }
      return member.email;
    }
    return 'Unknown User';
  }

  /// Helper to get initials for avatar
  String _getInitials() {
    final displayName = _getDisplayName();
    if (displayName.startsWith('@')) {
      return displayName.length > 1 ? displayName[1].toUpperCase() : 'U';
    }
    return displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Avatar
          CircleAvatar(
            radius: 40.r,
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
            backgroundImage: member.profileImage != null
                ? NetworkImage(member.profileImage!)
                : null,
            child: member.profileImage == null
                ? Text(
                    _getInitials(),
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            _getDisplayName(),
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),

          // Email or username
          if (member.email.isNotEmpty)
            Text(
              member.email,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            )
          else if (member.userUsername != null && member.userUsername!.isNotEmpty)
            Text(
              '@${member.userUsername}',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color.fromARGB(255, 78, 3, 208),
              ),
            ),
          SizedBox(height: 8.h),

          // Role badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _getRoleColor(member.role).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              member.role.displayName,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _getRoleColor(member.role),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Details
          _buildDetailRow(Icons.calendar_today, 'Joined', _formatDate(member.joinedAt)),
          if (member.phoneNumber != null && member.phoneNumber!.isNotEmpty)
            _buildDetailRow(Icons.phone, 'Phone', member.phoneNumber!),
          if (member.userUsername != null && member.userUsername!.isNotEmpty)
            _buildDetailRow(Icons.alternate_email, 'Username', '@${member.userUsername}'),
          _buildDetailRow(
            Icons.check_circle,
            'Status',
            member.status.displayName,
            valueColor: member.status == GroupMemberStatus.active
                ? const Color(0xFF10B981)
                : Colors.grey[400],
          ),

          SizedBox(height: 24.h),

          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[500], size: 18.sp),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey[400],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return const Color(0xFFEF4444);
      case GroupMemberRole.moderator:
        return const Color(0xFFF59E0B);
      case GroupMemberRole.member:
        return const Color(0xFF10B981);
      case GroupMemberRole.viewer:
        return const Color(0xFF6B7280);
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
