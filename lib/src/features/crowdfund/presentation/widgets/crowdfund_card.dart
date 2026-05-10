import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/crowdfund_entities.dart';
import 'progress_indicator_widget.dart';

class CrowdfundCard extends StatelessWidget {
  final Crowdfund crowdfund;
  final VoidCallback? onTap;
  final VoidCallback? onCreatorTap;
  /// Set when the authenticated user is the campaign creator. Drives
  /// a "Yours" badge on the card so the user can spot their own
  /// campaigns in the global Browse All feed at a glance.
  /// Computed by the parent (the list screen owns the auth state)
  /// so the card itself stays auth-agnostic.
  final bool isMine;

  const CrowdfundCard({
    super.key,
    required this.crowdfund,
    this.onTap,
    this.onCreatorTap,
    this.isMine = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: status + (optional) ownership badge + code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildStatusBadge(),
                      if (isMine) _buildOwnershipBadge(),
                    ],
                  ),
                ),
                Text(
                  crowdfund.crowdfundCode,
                  style: TextStyle(
                    color: const Color(0xFF4E03D0),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Creator + title row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      backgroundImage: crowdfund.creator.profilePicture != null
                          ? NetworkImage(crowdfund.creator.profilePicture!)
                          : null,
                      child: crowdfund.creator.profilePicture == null
                          ? Text(
                              crowdfund.creator.initials,
                              style: TextStyle(color: const Color(0xFF4E03D0), fontSize: 10.sp, fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    if (crowdfund.creator.verified)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1.w),
                          decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                          child: Icon(Icons.verified, color: Colors.white, size: 8.sp),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crowdfund.title,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${crowdfund.creator.firstName} ${crowdfund.creator.lastName}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 11.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Description (1 line)
            Text(
              crowdfund.description,
              style: TextStyle(color: Colors.grey[400], fontSize: 12.sp, height: 1.3),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            // Category + progress
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    crowdfund.category,
                    style: TextStyle(color: const Color(0xFF4E03D0), fontSize: 10.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Text(
                  '${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(0)}',
                  style: TextStyle(color: const Color(0xFF4E03D0), fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' / ${crowdfund.targetAmount.toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11.sp),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            CrowdfundProgressIndicator(progressPercentage: crowdfund.progressPercentage),
            SizedBox(height: 6.h),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.people, color: Colors.grey[500], size: 14.sp),
                    SizedBox(width: 3.w),
                    Text(
                      '${crowdfund.donorCount} ${crowdfund.donorCount == 1 ? 'donor' : 'donors'}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
                    ),
                  ],
                ),
                if (crowdfund.hasDeadline)
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: crowdfund.daysRemaining < 7 ? const Color(0xFFF59E0B) : Colors.grey[500],
                        size: 14.sp,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        crowdfund.isExpired
                            ? 'Expired'
                            : '${crowdfund.daysRemaining} ${crowdfund.daysRemaining == 1 ? 'day' : 'days'} left',
                        style: TextStyle(
                          color: crowdfund.daysRemaining < 7 ? const Color(0xFFF59E0B) : Colors.grey[400],
                          fontSize: 11.sp,
                          fontWeight: crowdfund.daysRemaining < 7 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String statusText;
    IconData icon;

    switch (crowdfund.status) {
      case CrowdfundStatus.active:
        backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
        textColor = const Color(0xFF10B981);
        statusText = 'Active';
        icon = Icons.check_circle;
        break;
      case CrowdfundStatus.completed:
        backgroundColor = const Color(0xFF4E03D0).withValues(alpha: 0.2);
        textColor = const Color(0xFF4E03D0);
        statusText = 'Completed';
        icon = Icons.celebration;
        break;
      case CrowdfundStatus.paused:
        backgroundColor = const Color(0xFFF59E0B).withValues(alpha: 0.2);
        textColor = const Color(0xFFF59E0B);
        statusText = 'Paused';
        icon = Icons.pause_circle;
        break;
      case CrowdfundStatus.cancelled:
        backgroundColor = const Color(0xFFEF4444).withValues(alpha: 0.2);
        textColor = const Color(0xFFEF4444);
        statusText = 'Cancelled';
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 12.sp),
          SizedBox(width: 3.w),
          Text(statusText, style: TextStyle(color: textColor, fontSize: 11.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  /// "Yours" pill rendered next to the status badge when the
  /// authenticated user owns the campaign. Uses the brand purple
  /// + a person-icon glyph so it reads at a glance against the
  /// other status colours and stays distinct from the verified
  /// (green) or active (green) palettes.
  Widget _buildOwnershipBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF4E03D0).withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_outline,
              color: const Color(0xFF8B5CF6), size: 12.sp),
          SizedBox(width: 3.w),
          Text(
            'Yours',
            style: TextStyle(
              color: const Color(0xFF8B5CF6),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
