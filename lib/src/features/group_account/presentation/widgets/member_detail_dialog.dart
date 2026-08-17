import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import '../../utils/member_rating_calculator.dart';
import 'member_star_rating.dart';
part 'member_detail_dialog_widgets.dart';


/// Dialog showing detailed member information with permission-based actions
class MemberDetailDialog extends StatelessWidget {
  final GroupMember member;
  final GroupAccount group;
  final String currentUserId;
  final List<Contribution> contributions;
  final ContributionMember? contributionMember;
  final Contribution? contribution;
  final VoidCallback? onChangeRole;
  final VoidCallback? onRemoveMember;
  final VoidCallback? onCancelInvite;

  const MemberDetailDialog({
    super.key,
    required this.member,
    required this.group,
    required this.currentUserId,
    this.contributions = const [],
    this.contributionMember,
    this.contribution,
    this.onChangeRole,
    this.onRemoveMember,
    this.onCancelInvite,
  });

  /// Whether the current user can change THIS member's role.
  /// Uses the canonical permission matrix (admin + moderator), blocks
  /// moderators from promoting/demoting another admin, and requires
  /// the operator's own membership to be active (a pending invite
  /// shouldn't manage anyone yet).
  bool get _canChangeRole {
    final currentMember = group.getMember(currentUserId);
    if (currentMember == null) return false;
    if (member.userId == currentUserId) return false; // not yourself
    if (member.userId == group.adminId) return false; // never the original admin
    if (!GroupRolePermissions.canMember(currentMember, GroupAction.changeMemberRole)) {
      return false;
    }
    // Moderators cannot change roles of other admins.
    if (currentMember.role == GroupMemberRole.moderator &&
        member.role == GroupMemberRole.admin) {
      return false;
    }
    return true;
  }

  /// Whether the current user can remove THIS member from the group.
  bool get _canRemoveMember {
    final currentMember = group.getMember(currentUserId);
    if (currentMember == null) return false;
    if (member.userId == currentUserId) return false;
    if (member.userId == group.adminId) return false;
    if (!GroupRolePermissions.canMember(currentMember, GroupAction.removeMember)) {
      return false;
    }
    // Moderators cannot remove admins.
    if (currentMember.role == GroupMemberRole.moderator &&
        member.role == GroupMemberRole.admin) {
      return false;
    }
    return true;
  }

  /// Whether the current user can cancel THIS pending invite.
  /// Mirrors the server-side rule in invitationService.Cancel: the
  /// original inviter or any active admin/moderator may pull the invite.
  bool get _canCancelInvite {
    if (!member.isPendingInvite) return false;
    if (member.linkedInvitationId == null) return false;
    if (onCancelInvite == null) return false;
    final currentMember = group.getMember(currentUserId);
    if (currentMember == null) return false;
    if (currentMember.status != GroupMemberStatus.active) return false;
    return GroupRolePermissions.canMember(currentMember, GroupAction.inviteMember);
  }

  /// Show the management section iff at least one action is available.
  /// For pending invites, only "Cancel Invite" is meaningful — Change
  /// Role / Remove Member don't apply until the user has joined.
  bool get _canManageMember =>
      _canCancelInvite ||
      (!member.isPendingInvite && (_canChangeRole || _canRemoveMember));

  /// Check if this member is the original group admin
  bool get _isGroupAdmin => member.userId == group.adminId;

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
            if (contributions.isNotEmpty) _buildAIRating(),
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
            _getDisplayName(),
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
    final initials = _getInitials(_getDisplayName());
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
          if (member.isPendingInvite) ...[
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
                    Icons.mail_outline,
                    color: const Color(0xFFFB923C),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Invite Sent — waiting for the user to accept',
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

  Widget _buildAIRating() {
    final rating = MemberRatingCalculator.calculateRating(member, contributions);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      child: MemberStarRating(
        rating: rating,
        compact: false,
      ),
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
          if (_canCancelInvite)
            // Pending-invite branch: Change Role / Remove are not
            // meaningful before acceptance, so we surface a single
            // full-width "Cancel Invite" CTA instead.
            _buildActionButton(
              icon: Icons.cancel_outlined,
              label: 'Cancel Invite',
              color: const Color(0xFFEF4444),
              onTap: () {
                Navigator.pop(context);
                onCancelInvite?.call();
              },
            )
          else
            Row(
              children: [
                if (_canChangeRole)
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
                if (_canChangeRole && _canRemoveMember) SizedBox(width: 12.w),
                if (_canRemoveMember)
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
