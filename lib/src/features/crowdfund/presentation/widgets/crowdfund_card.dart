import 'package:flutter/material.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_progress.dart';
import 'package:lazervault/src/features/crowdfund/presentation/widgets/crowdfund_ownership_badge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../utils/crowdfund_status_display.dart';
import 'progress_indicator_widget.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

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
    final progress = CrowdfundProgress.of(crowdfund);
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
                      if (isMine) const CrowdfundOwnershipBadge(),
                    ],
                  ),
                ),
                Text(
                  crowdfund.crowdfundCode,
                  style: TextStyle(
                    color: PayFlowTheme.accentOnDark,
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
                      backgroundColor:
                          const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      backgroundImage: crowdfund.creator.profilePicture != null
                          ? NetworkImage(crowdfund.creator.profilePicture!)
                          : null,
                      child: crowdfund.creator.profilePicture == null
                          ? Text(
                              crowdfund.creator.initials,
                              style: TextStyle(
                                  color: PayFlowTheme.accentOnDark,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    if (crowdfund.creator.verified)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1.w),
                          decoration: const BoxDecoration(
                              color: Color(0xFF10B981), shape: BoxShape.circle),
                          child: Icon(Icons.verified,
                              color: Colors.white, size: 8.sp),
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${crowdfund.creator.firstName} ${crowdfund.creator.lastName}',
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 11.sp),
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
              style: TextStyle(
                  color: Colors.grey[400], fontSize: 12.sp, height: 1.3),
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
                    style: TextStyle(
                        color: PayFlowTheme.accentOnDark,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                // WHAT IT RAISED, NOT WHAT IS LEFT IN THE POT. Drawing
                // currentAmount made a fully withdrawn campaign report that
                // it had raised nothing — "NGN 0 / 500 · 0.0%" under a green
                // Completed badge. See CrowdfundProgress.
                Text(
                  '${crowdfund.currency} ${progress.raised.toStringAsFixed(0)}',
                  style: TextStyle(
                      color: PayFlowTheme.accentOnDark,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' / ${progress.target.toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            CrowdfundProgressIndicator(progressPercentage: progress.percent),
            SizedBox(height: 6.h),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // A READABLE PILL, NOT GREY-ON-DARK. grey[500] on grey[400]
                // over a #1a1030 card is close to invisible, and it is the
                // one number that says whether anyone backed this at all.
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: 13.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${crowdfund.donorCount} ${crowdfund.donorCount == 1 ? 'donor' : 'donors'}',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                // The clock line. `daysRemaining < 7` drove the amber
                // urgency colour, and it is 0 for every finished campaign,
                // so completed and cancelled cards wore a "hurry" colour
                // forever; and `isExpired ? 'Expired'` reported a campaign
                // cancelled a month early as having reached its deadline.
                // No longer gated on hasDeadline: an open-ended
                // campaign now has a label of its own ("No deadline")
                // and hiding it made that case look like missing data.
                if (_clockLabel.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: _clockUrgent
                            ? const Color(0xFFF59E0B)
                            : Colors.grey[500],
                        size: 14.sp,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        _clockLabel,
                        style: TextStyle(
                          color: _clockUrgent
                              ? const Color(0xFFF59E0B)
                              : Colors.grey[400],
                          fontSize: 11.sp,
                          fontWeight:
                              _clockUrgent ? FontWeight.w600 : FontWeight.w400,
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

  String get _clockLabel => crowdfundDeadlineLabel(crowdfund);
  bool get _clockUrgent => crowdfundDeadlineIsUrgent(crowdfund);

  Widget _buildStatusBadge() {
    // Shared with the detail screen and the home-screen row. The six-arm
    // switch this replaced was correct but duplicated, and only this copy
    // was ever updated when `expired` and `cancelling` were added.
    final v = crowdfundStatusVisual(crowdfund);
    final backgroundColor = v.color.withValues(alpha: 0.2);
    final textColor = v.color;
    final statusText = v.label;
    final icon = v.icon;

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
          Text(statusText,
              style: TextStyle(
                  color: textColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
