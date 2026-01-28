import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Real-time Connection Indicator Widget
/// Shows real-time connection status with visual feedback
/// WCAG AA compliant colors
class RealtimeIndicator extends StatelessWidget {
  final bool isConnected;
  final VoidCallback onToggle;

  const RealtimeIndicator({
    super.key,
    required this.isConnected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isConnected
            ? const Color(0xFF10B981).withValues(alpha: 0.1)
            : const Color(0xFF6B7280).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isConnected
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFF6B7280).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Status Indicator
          Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: isConnected
                  ? const Color(0xFF10B981) // Green - WCAG AA
                  : const Color(0xFF6B7280), // Gray - WCAG AA
              shape: BoxShape.circle,
              boxShadow: isConnected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Real-time Updates',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  isConnected ? 'Live connection active' : 'Updates when refreshed',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          // Toggle Switch
          Switch(
            value: isConnected,
            onChanged: (_) => onToggle(),
            activeThumbColor: const Color(0xFF10B981),
            activeTrackColor: const Color(0xFF10B981).withValues(alpha: 0.3),
            inactiveThumbColor: const Color(0xFF6B7280),
            inactiveTrackColor: const Color(0xFF6B7280).withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
