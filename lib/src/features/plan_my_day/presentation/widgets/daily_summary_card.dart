import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';

class DailySummaryCard extends StatelessWidget {
  final DailySummary summary;

  const DailySummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getProductivityColor(summary.productivityScore).withOpacity(0.2),
            _getProductivityColor(summary.productivityScore).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _getProductivityColor(summary.productivityScore).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    _getProductivityIcon(summary.productivityScore),
                    color: _getProductivityColor(summary.productivityScore),
                    size: 24,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Progress',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        summary.productivityLabel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getProductivityColor(summary.productivityScore).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${summary.completionRate.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: _getProductivityColor(summary.productivityScore),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: summary.completionRate / 100,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProductivityColor(summary.productivityScore),
              ),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 16.h),
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '${summary.tasksCompleted}/${summary.tasksTotal}',
                'Tasks',
                Icons.check_circle_outline,
              ),
              _buildStatItem(
                '${summary.eventsAttended}',
                'Events',
                Icons.event_available,
              ),
              _buildStatItem(
                '${(summary.focusMinutes / 60).toStringAsFixed(1)}h',
                'Focus',
                Icons.psychology_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey[400],
            ),
            SizedBox(width: 4.w),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Color _getProductivityColor(String score) {
    switch (score) {
      case 'high':
        return const Color(0xFF10B981); // Green
      case 'medium':
        return const Color(0xFFF59E0B); // Orange
      case 'low':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  IconData _getProductivityIcon(String score) {
    switch (score) {
      case 'high':
        return Icons.emoji_events;
      case 'medium':
        return Icons.trending_up;
      case 'low':
        return Icons.trending_down;
      default:
        return Icons.show_chart;
    }
  }
}
