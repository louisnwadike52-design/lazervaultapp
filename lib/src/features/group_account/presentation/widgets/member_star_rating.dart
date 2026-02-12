import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/member_rating_calculator.dart';

/// Displays AI-powered star rating for a group member.
///
/// Two modes:
/// - `compact`: Small inline row of stars + "AI Rating" label (for member cards)
/// - `expanded`: Larger stars + score + label + breakdown bars (for detail dialogs)
class MemberStarRating extends StatelessWidget {
  final MemberRating rating;
  final bool compact;

  const MemberStarRating({
    super.key,
    required this.rating,
    this.compact = true,
  });

  static const Color _filledStarColor = Color(0xFFFFD700);
  static const Color _emptyStarColor = Color(0xFF4D4D4D);

  @override
  Widget build(BuildContext context) {
    return compact ? _buildCompact() : _buildExpanded();
  }

  Widget _buildCompact() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) => Icon(
          index < rating.starCount ? Icons.star_rounded : Icons.star_border_rounded,
          color: index < rating.starCount ? _filledStarColor : _emptyStarColor,
          size: 12.sp,
        )),
        SizedBox(width: 4.w),
        Text(
          'AI Rating',
          style: GoogleFonts.inter(
            fontSize: 9.sp,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildExpanded() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: _filledStarColor,
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                'AI Member Rating',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Stars row with score and label
          Row(
            children: [
              ...List.generate(5, (index) => Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: Icon(
                  index < rating.starCount ? Icons.star_rounded : Icons.star_border_rounded,
                  color: index < rating.starCount ? _filledStarColor : _emptyStarColor,
                  size: 20.sp,
                ),
              )),
              SizedBox(width: 8.w),
              Text(
                rating.overallScore.toStringAsFixed(1),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: _getLabelColor(rating.label).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  rating.label,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: _getLabelColor(rating.label),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Factor breakdown bars
          _buildFactorBar('Payment Compliance', rating.complianceScore, const Color(0xFF3B82F6)),
          SizedBox(height: 8.h),
          _buildFactorBar('Consistency', rating.consistencyScore, const Color(0xFF10B981)),
          SizedBox(height: 8.h),
          _buildFactorBar('Contribution Breadth', rating.breadthScore, const Color(0xFFF59E0B)),
          SizedBox(height: 8.h),
          _buildFactorBar('Activity Tenure', rating.tenureScore, const Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildFactorBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.grey[400],
              ),
            ),
            Text(
              '${(value * 100).toStringAsFixed(0)}%',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          height: 4.h,
          decoration: BoxDecoration(
            color: const Color(0xFF3D3D3D),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getLabelColor(String label) {
    switch (label) {
      case 'Excellent':
        return const Color(0xFF10B981);
      case 'Good':
        return const Color(0xFF3B82F6);
      case 'Average':
        return const Color(0xFFF59E0B);
      case 'Fair':
        return const Color(0xFFFB923C);
      default:
        return Colors.grey;
    }
  }
}
