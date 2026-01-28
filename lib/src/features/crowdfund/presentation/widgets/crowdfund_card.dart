import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/crowdfund_entities.dart';
import 'progress_indicator_widget.dart';

class CrowdfundCard extends StatelessWidget {
  final Crowdfund crowdfund;
  final VoidCallback? onTap;
  final VoidCallback? onCreatorTap;

  const CrowdfundCard({
    super.key,
    required this.crowdfund,
    this.onTap,
    this.onCreatorTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F), // Card background
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D), // Border color
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    crowdfund.crowdfundCode,
                    style: TextStyle(
                      color: const Color(0xFF4E03D0),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Creator info
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor:
                          const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      backgroundImage: crowdfund.creator.profilePicture != null
                          ? NetworkImage(crowdfund.creator.profilePicture!)
                          : null,
                      child: crowdfund.creator.profilePicture == null
                          ? Text(
                              '${crowdfund.creator.firstName[0]}${crowdfund.creator.lastName[0]}',
                              style: TextStyle(
                                color: const Color(0xFF4E03D0),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    if (crowdfund.creator.verified)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 10.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${crowdfund.creator.firstName} ${crowdfund.creator.lastName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (crowdfund.creator.verified) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.verified,
                              color: const Color(0xFF10B981),
                              size: 14.sp,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '@${crowdfund.creator.username}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Image (if available)
            if (crowdfund.imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  crowdfund.imageUrl!,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160.h,
                    color: const Color(0xFF0A0A0A),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[600],
                        size: 48.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
            // Title
            Text(
              crowdfund.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            // Description
            Text(
              crowdfund.description,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 13.sp,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12.h),
            // Category badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                crowdfund.category,
                style: TextStyle(
                  color: const Color(0xFF4E03D0),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Progress section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Raised',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: const Color(0xFF4E03D0),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Goal',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${crowdfund.currency} ${crowdfund.targetAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                CrowdfundProgressIndicator(
                  progressPercentage: crowdfund.progressPercentage,
                  height: 8,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Footer info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.grey[500],
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${crowdfund.donorCount} ${crowdfund.donorCount == 1 ? 'donor' : 'donors'}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                if (crowdfund.hasDeadline) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: crowdfund.daysRemaining < 7
                            ? const Color(0xFFF59E0B) // Warning orange
                            : Colors.grey[500],
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        crowdfund.isExpired
                            ? 'Expired'
                            : '${crowdfund.daysRemaining} ${crowdfund.daysRemaining == 1 ? 'day' : 'days'} left',
                        style: TextStyle(
                          color: crowdfund.daysRemaining < 7
                              ? const Color(0xFFF59E0B)
                              : Colors.grey[400],
                          fontSize: 12.sp,
                          fontWeight: crowdfund.daysRemaining < 7
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
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
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 14.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
