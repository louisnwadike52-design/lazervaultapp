import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized empty-state block for the Piggyvault surfaces.
///
/// One styled component so the "no activity", "no locks for this
/// filter" and similar empty states all look identical on the dark
/// theme instead of each screen rolling its own bare `Text`. Renders
/// a soft icon chip, a title and an optional subtitle, centered.
class LockFundsEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  /// Vertical padding around the block. Smaller (compact) suits an
  /// inline section like the activity log; the default suits a
  /// standalone card.
  final bool compact;

  const LockFundsEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.history_toggle_off_rounded,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: compact ? 20.h : 32.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: compact ? 52.w : 64.w,
              height: compact ? 52.w : 64.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6366F1).withValues(alpha: 0.2),
                    const Color.fromARGB(255, 78, 3, 208)
                        .withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(compact ? 26.r : 32.r),
              ),
              child: Icon(
                icon,
                size: compact ? 24.sp : 30.sp,
                color: const Color(0xFF8B5CF6),
              ),
            ),
            SizedBox(height: compact ? 12.h : 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: compact ? 14.sp : 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 6.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: compact ? 12.sp : 13.sp,
                  height: 1.4,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
