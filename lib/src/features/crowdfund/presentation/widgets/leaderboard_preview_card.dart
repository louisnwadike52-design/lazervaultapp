import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crowdfund_entities.dart';

final _amountFormat = NumberFormat('#,##0.00');

class LeaderboardPreviewCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final VoidCallback? onTap;

  const LeaderboardPreviewCard({
    super.key,
    required this.entry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final crowdfund = entry.crowdfund;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rank badge
              Row(
                children: [
                  _buildRankBadge(entry.rank),
                  const Spacer(),
                  if (crowdfund.category.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        crowdfund.category,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6366F1),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10.h),
              // Campaign image or icon
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: crowdfund.imageUrl != null
                    ? Image.network(
                        crowdfund.imageUrl!,
                        height: 60.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                      )
                    : _buildImagePlaceholder(),
              ),
              SizedBox(height: 8.h),
              // Title
              Text(
                crowdfund.title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: LinearProgressIndicator(
                  value: (crowdfund.progressPercentage / 100).clamp(0.0, 1.0),
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF6366F1),
                  ),
                  minHeight: 3.h,
                ),
              ),
              SizedBox(height: 6.h),
              // Amount raised
              Text(
                '${crowdfund.currency} ${_amountFormat.format(crowdfund.currentAmount)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6366F1),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    final Color color;
    if (rank == 1) {
      color = const Color(0xFFFFD700);
    } else if (rank == 2) {
      color = const Color(0xFFC0C0C0);
    } else if (rank == 3) {
      color = const Color(0xFFCD7F32);
    } else {
      color = const Color(0xFF6B7280);
    }

    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: rank <= 3
            ? Icon(Icons.emoji_events, color: color, size: 14.sp)
            : Text(
                '#$rank',
                style: GoogleFonts.inter(
                  color: color,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.volunteer_activism,
        color: const Color(0xFF6366F1),
        size: 24.sp,
      ),
    );
  }
}
