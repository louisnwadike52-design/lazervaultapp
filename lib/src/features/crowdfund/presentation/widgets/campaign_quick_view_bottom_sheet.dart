import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/crowdfund_entities.dart';
import 'progress_indicator_widget.dart';

final _amountFormat = NumberFormat('#,##0.00');

class CampaignQuickViewBottomSheet extends StatelessWidget {
  final Crowdfund crowdfund;

  const CampaignQuickViewBottomSheet({
    super.key,
    required this.crowdfund,
  });

  static void show(BuildContext context, Crowdfund crowdfund) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CampaignQuickViewBottomSheet(crowdfund: crowdfund),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          // Campaign image
          if (crowdfund.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                crowdfund.imageUrl!,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        crowdfund.title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        crowdfund.category,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6366F1),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Creator profile row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor:
                          const Color(0xFF6366F1).withValues(alpha: 0.2),
                      backgroundImage: crowdfund.creator.profilePicture != null
                          ? NetworkImage(crowdfund.creator.profilePicture!)
                          : null,
                      child: crowdfund.creator.profilePicture == null
                          ? Text(
                              _getInitials(crowdfund.creator),
                              style: TextStyle(
                                color: const Color(0xFF6366F1),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      crowdfund.creator.displayName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
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
                SizedBox(height: 16.h),
                // Progress section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${crowdfund.currency} ${_amountFormat.format(crowdfund.currentAmount)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'of ${crowdfund.currency} ${_amountFormat.format(crowdfund.targetAmount)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                CrowdfundProgressIndicator(
                  progressPercentage: crowdfund.progressPercentage,
                  height: 6,
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${crowdfund.progressPercentage.toStringAsFixed(1)}% funded',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat(
                      Icons.people,
                      '${crowdfund.donorCount}',
                      'donors',
                    ),
                    _buildStat(
                      Icons.access_time,
                      crowdfund.hasDeadline
                          ? '${crowdfund.daysRemaining}'
                          : '--',
                      'days left',
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Description
                Text(
                  crowdfund.description,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 24.h),
                // Donate Now button
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: (crowdfund.isActive && !crowdfund.isExpired)
                        ? () {
                            Navigator.pop(context);
                            Get.toNamed(
                              AppRoutes.donationPayment,
                              arguments: crowdfund,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      disabledBackgroundColor: const Color(0xFF2D2D2D),
                      disabledForegroundColor: const Color(0xFF9CA3AF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      (crowdfund.isActive && !crowdfund.isExpired)
                          ? 'Donate Now'
                          : 'Campaign Ended',
                      style: GoogleFonts.inter(
                        color: (crowdfund.isActive && !crowdfund.isExpired)
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // View Details text button
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.toNamed(
                        AppRoutes.crowdfundDetails,
                        arguments: crowdfund.id,
                      );
                    },
                    child: Text(
                      'View Full Details',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _getInitials(CrowdfundCreator creator) {
    final first = creator.firstName.isNotEmpty ? creator.firstName[0] : '';
    final last = creator.lastName.isNotEmpty ? creator.lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
