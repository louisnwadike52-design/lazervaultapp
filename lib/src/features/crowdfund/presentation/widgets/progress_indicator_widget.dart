import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrowdfundProgressIndicator extends StatelessWidget {
  final double progressPercentage;
  final bool showMilestones;
  final double height;

  const CrowdfundProgressIndicator({
    super.key,
    required this.progressPercentage,
    this.showMilestones = false,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Background track
            Container(
              height: height.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(height.r / 2),
              ),
            ),
            // Progress bar
            FractionallySizedBox(
              widthFactor: (progressPercentage / 100).clamp(0.0, 1.0),
              child: Container(
                height: height.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4E03D0), // Primary purple
                      Color(0xFF6B21E0), // Lighter purple
                    ],
                  ),
                  borderRadius: BorderRadius.circular(height.r / 2),
                ),
              ),
            ),
            // Percentage overlay
            Positioned.fill(
              child: Center(
                child: Text(
                  '${progressPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showMilestones) ...[
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMilestone(25, progressPercentage >= 25),
              _buildMilestone(50, progressPercentage >= 50),
              _buildMilestone(75, progressPercentage >= 75),
              _buildMilestone(100, progressPercentage >= 100),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildMilestone(int milestone, bool reached) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: reached
                ? const Color(0xFF10B981) // Success green
                : const Color(0xFF2D2D2D),
            border: Border.all(
              color: reached
                  ? const Color(0xFF10B981)
                  : const Color(0xFF4E03D0),
              width: 1.5,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '$milestone%',
          style: TextStyle(
            color: reached ? const Color(0xFF10B981) : Colors.grey[500],
            fontSize: 10.sp,
            fontWeight: reached ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
