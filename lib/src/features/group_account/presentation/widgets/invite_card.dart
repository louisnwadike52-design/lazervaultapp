import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';

/// One-row invite card for the Invites tab. Renders the group name +
/// inviter, an expiry countdown, the role being offered, optional
/// invite message, and Accept / Decline CTAs.
///
/// Both CTAs go through the parent screen via callbacks so the cubit
/// emit lands on the screen-level listener (snackbar + auto-refresh).
/// Loading state is owned per-card so a tap doesn't lock the whole
/// list.
class InviteCard extends StatelessWidget {
  final GroupInvitation invitation;
  final bool busy;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const InviteCard({
    super.key,
    required this.invitation,
    required this.busy,
    required this.onAccept,
    required this.onDecline,
  });

  /// Human-readable countdown to expiry. Returns null when the row is
  /// already expired or not pending — caller skips the field in that
  /// case.
  String? _expiryCountdown() {
    if (invitation.status != GroupInvitationStatus.pending) return null;
    final remaining = invitation.expiresAt.difference(DateTime.now());
    if (remaining.isNegative) return 'Expired';
    if (remaining.inDays > 0) {
      return 'Expires in ${remaining.inDays}d';
    }
    if (remaining.inHours > 0) {
      return 'Expires in ${remaining.inHours}h';
    }
    return 'Expires soon';
  }

  @override
  Widget build(BuildContext context) {
    final groupName = invitation.groupName.isNotEmpty
        ? invitation.groupName
        : 'Group invitation';
    final inviterName = invitation.inviterName.isNotEmpty
        ? invitation.inviterName
        : null;
    final countdown = _expiryCountdown();
    final formattedInvitedAt =
        DateFormat('MMM d, y · h:mm a').format(invitation.invitedAt.toLocal());

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: invitation.isPending
              ? const Color(0xFF6366F1).withValues(alpha: 0.4)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.groups,
                    color: const Color.fromARGB(255, 78, 3, 208),
                    size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (inviterName != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        'Invited by $inviterName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (countdown != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    countdown,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (invitation.message.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                invitation.message,
                style: GoogleFonts.inter(
                  color: Colors.grey[300],
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
            ),
          ],
          SizedBox(height: 10.h),
          Row(
            children: [
              _Chip(label: 'Role: ${invitation.role}', icon: Icons.badge),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  formattedInvitedAt,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          if (invitation.isPending) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: busy ? null : onDecline,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[300],
                      side: BorderSide(color: Colors.grey[700]!),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Decline',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: busy ? null : onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: busy
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Accept invite',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: 8.h),
            Text(
              'Status: ${invitation.status.wireValue}',
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Chip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey[400], size: 11.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
