import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';

/// Dialog showing detailed member information with permission-based actions
class MemberDetailDialog extends StatelessWidget {
  final GroupMember member;
  final GroupAccount group;
  final String currentUserId;
  final ContributionMember? contributionMember;
  final Contribution? contribution;
  final VoidCallback? onChangeRole;
  final VoidCallback? onRemoveMember;

  const MemberDetailDialog({
    super.key,
    required this.member,
    required this.group,
    required this.currentUserId,
    this.contributionMember,
    this.contribution,
    this.onChangeRole,
    this.onRemoveMember,
  });

  /// Check if current user can manage this member (change role, remove)
  bool get _canManageMember {
    final currentMember = group.getMember(currentUserId);
    if (currentMember == null) return false;

    // Only admins can manage members
    if (!currentMember.isAdmin) return false;

    // Cannot remove the group admin (original creator)
    if (member.userId == group.adminId) return false;

    // Cannot manage yourself
    if (member.userId == currentUserId) return false;

    return true;
  }

  /// Check if this member is the original group admin
  bool get _isGroupAdmin => member.userId == group.adminId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: 360.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
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
            _buildHeader(context),
            _buildMemberInfo(),
            if (contributionMember != null && contribution != null)
              _buildContributionProgress(),
            if (_canManageMember) _buildActions(context),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Member Details',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Large avatar
          _buildAvatar(),
          SizedBox(height: 12.h),
          // Name
          Text(
            member.userName,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          if (member.userUsername != null && member.userUsername!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                '@${member.userUsername}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          SizedBox(height: 12.h),
          // Role and status badges
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoleBadge(),
              SizedBox(width: 8.w),
              _buildStatusBadge(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final initials = _getInitials(member.userName);
    final avatarColor = _getRoleColor();

    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarColor.withValues(alpha: 0.2),
        border: Border.all(
          color: avatarColor.withValues(alpha: 0.5),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: avatarColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: member.profileImage != null && member.profileImage!.isNotEmpty
          ? ClipOval(
              child: Image.network(
                member.profileImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildInitialsAvatar(initials),
              ),
            )
          : _buildInitialsAvatar(initials),
    );
  }

  Widget _buildInitialsAvatar(String initials) {
    return Center(
      child: Text(
        initials,
        style: GoogleFonts.inter(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: _getRoleColor(),
        ),
      ),
    );
  }

  Widget _buildRoleBadge() {
    final roleColor = _getRoleColor();
    final roleText = _isGroupAdmin ? 'Group Admin' : member.role.displayName;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: roleColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: roleColor.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getRoleIcon(),
            color: roleColor,
            size: 14.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            roleText,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: roleColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final statusColor = _getStatusColor();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            member.status.displayName,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberInfo() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: member.email,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Joined',
            value: DateFormat('MMM d, yyyy').format(member.joinedAt),
          ),
          if (member.phoneNumber != null && member.phoneNumber!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: member.phoneNumber!,
            ),
          ],
          if (member.isPartial) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    color: const Color(0xFFFB923C),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Pending invite - waiting to accept',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFFFB923C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: Colors.grey[400],
            size: 16.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContributionProgress() {
    final cm = contributionMember!;
    final c = contribution!;
    final progress = cm.expectedAmount > 0
        ? (cm.totalPaid / cm.expectedAmount).clamp(0.0, 1.0)
        : 0.0;
    final progressPercentage = (progress * 100).toStringAsFixed(0);

    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contribution Progress',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: cm.hasPaidCurrentCycle
                      ? const Color(0xFF10B981).withValues(alpha: 0.2)
                      : const Color(0xFFFB923C).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  cm.hasPaidCurrentCycle ? 'Paid' : 'Pending',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: cm.hasPaidCurrentCycle
                        ? const Color(0xFF10B981)
                        : const Color(0xFFFB923C),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF3D3D3D),
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1.0
                    ? const Color(0xFF10B981)
                    : const Color.fromARGB(255, 78, 3, 208),
              ),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_formatCurrency(cm.totalPaid, c.currency)} of ${_formatCurrency(cm.expectedAmount, c.currency)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                '$progressPercentage%',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Actions',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.admin_panel_settings,
                  label: 'Change Role',
                  color: const Color(0xFFFB923C),
                  onTap: () {
                    Navigator.pop(context);
                    onChangeRole?.call();
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.person_remove,
                  label: 'Remove',
                  color: const Color(0xFFEF4444),
                  onTap: () {
                    Navigator.pop(context);
                    onRemoveMember?.call();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  Color _getRoleColor() {
    if (_isGroupAdmin || member.isAdmin) return const Color(0xFFEF4444); // Red
    if (member.isModerator) return const Color(0xFFFB923C); // Orange
    return const Color(0xFF10B981); // Green
  }

  IconData _getRoleIcon() {
    if (_isGroupAdmin || member.isAdmin) return Icons.shield;
    if (member.isModerator) return Icons.admin_panel_settings;
    return Icons.person;
  }

  Color _getStatusColor() {
    switch (member.status) {
      case GroupMemberStatus.active:
        return const Color(0xFF10B981);
      case GroupMemberStatus.pending:
        return const Color(0xFFFB923C);
      case GroupMemberStatus.inactive:
        return Colors.grey;
      case GroupMemberStatus.removed:
        return const Color(0xFFEF4444);
    }
  }

  String _formatCurrency(double amount, String currency) {
    final symbols = {
      'NGN': '\u20A6',
      'USD': '\$',
      'EUR': '\u20AC',
      'GBP': '\u00A3',
      'GHS': '\u20B5',
    };
    final symbol = symbols[currency] ?? currency;
    return '$symbol${NumberFormat('#,###').format(amount)}';
  }
}

/// Dialog for changing member role
class ChangeRoleDialog extends StatefulWidget {
  final GroupMember member;
  final Function(GroupMemberRole) onRoleSelected;

  const ChangeRoleDialog({
    super.key,
    required this.member,
    required this.onRoleSelected,
  });

  @override
  State<ChangeRoleDialog> createState() => _ChangeRoleDialogState();
}

class _ChangeRoleDialogState extends State<ChangeRoleDialog> {
  late GroupMemberRole _selectedRole;

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
                          widget.member.userName,
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
            // Role options
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: GroupMemberRole.values.map((role) {
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
    }
  }

  String _getRoleDescription(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return 'Full control over group settings and members';
      case GroupMemberRole.moderator:
        return 'Can add members and manage contributions';
      case GroupMemberRole.member:
        return 'Can view and make payments';
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
                    'Are you sure you want to remove ${member.userName} from this group?',
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
