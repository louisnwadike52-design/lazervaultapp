import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crowdfund_entities.dart';
import 'progress_indicator_widget.dart';

final _amountFormat = NumberFormat('#,##0.00');

class LeaderboardCrowdfundCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final VoidCallback? onTap;

  const LeaderboardCrowdfundCard({
    super.key,
    required this.entry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final crowdfund = entry.crowdfund;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: entry.rank <= 3
              ? Border.all(
                  color: _getRankColor(entry.rank).withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            // Rank badge
            _buildRankBadge(entry.rank),
            SizedBox(width: 12.w),
            // Campaign image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: crowdfund.imageUrl != null
                  ? Image.network(
                      crowdfund.imageUrl!,
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                    )
                  : _buildImagePlaceholder(),
            ),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    crowdfund.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  // Creator name + verified
                  Row(
                    children: [
                      Text(
                        crowdfund.creator.displayName,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                      if (crowdfund.creator.verified) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.verified,
                          color: const Color(0xFF10B981),
                          size: 12.sp,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Progress bar
                  CrowdfundProgressIndicator(
                    progressPercentage: crowdfund.progressPercentage,
                    height: 4,
                  ),
                  SizedBox(height: 6.h),
                  // Stats row
                  Row(
                    children: [
                      Text(
                        '${crowdfund.currency} ${_amountFormat.format(crowdfund.currentAmount)}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6366F1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 3.w,
                        height: 3.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4B5563),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${crowdfund.donorCount} ${crowdfund.donorCount == 1 ? 'donor' : 'donors'}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 3.w,
                        height: 3.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4B5563),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${crowdfund.progressPercentage.toStringAsFixed(0)}%',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: _getRankColor(rank).withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: rank <= 3
            ? Icon(
                Icons.emoji_events,
                color: _getRankColor(rank),
                size: 18.sp,
              )
            : Text(
                '#$rank',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.volunteer_activism,
        color: const Color(0xFF6366F1),
        size: 24.sp,
      ),
    );
  }

  static Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }
}
