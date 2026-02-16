import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';
import '../../utils/member_rating_calculator.dart';
import 'member_star_rating.dart';

class MemberCard extends StatelessWidget {
  final GroupMember member;
  final GroupAccount group;
  final List<Contribution> contributions;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.member,
    required this.group,
    this.contributions = const [],
    this.onTap,
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
    final displayName = _getDisplayName();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  displayName.startsWith('@') && displayName.length > 1
                      ? displayName[1].toUpperCase()
                      : displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Member Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    member.email,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      _buildRoleBadge(member.role),
                      SizedBox(width: 8.w),
                      _buildStatusBadge(member.status),
                      if (member.isPartial) ...[
                        SizedBox(width: 8.w),
                        _buildInviteBadge(),
                      ],
                    ],
                  ),
                  if (contributions.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    MemberStarRating(
                      rating: MemberRatingCalculator.calculateRating(member, contributions),
                      compact: true,
                    ),
                  ],
                ],
              ),
            ),
            
            // Joined Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Joined',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _formatDate(member.joinedAt),
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBadge(GroupMemberRole role) {
    Color backgroundColor;
    Color textColor;
    
    switch (role) {
      case GroupMemberRole.admin:
        backgroundColor = const Color(0xFFEF4444).withValues(alpha: 0.2);
        textColor = const Color(0xFFEF4444);
        break;
      case GroupMemberRole.moderator:
        backgroundColor = const Color(0xFFF59E0B).withValues(alpha: 0.2);
        textColor = const Color(0xFFF59E0B);
        break;
      case GroupMemberRole.member:
        backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
        textColor = const Color(0xFF10B981);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Text(
        role.displayName,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(GroupMemberStatus status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case GroupMemberStatus.active:
        backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
        textColor = const Color(0xFF10B981);
        break;
      case GroupMemberStatus.inactive:
        backgroundColor = Colors.grey.withValues(alpha: 0.2);
        textColor = Colors.grey;
        break;
      case GroupMemberStatus.pending:
        backgroundColor = const Color(0xFFF59E0B).withValues(alpha: 0.2);
        textColor = const Color(0xFFF59E0B);
        break;
      case GroupMemberStatus.removed:
        backgroundColor = const Color(0xFFEF4444).withValues(alpha: 0.2);
        textColor = const Color(0xFFEF4444);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInviteBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mail_outline,
            size: 10.sp,
            color: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 4.w),
          Text(
            'Invited',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
} 