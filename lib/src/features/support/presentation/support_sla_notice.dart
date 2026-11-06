import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Tells a customer when to expect a reply, on every support surface.
///
/// WHY THE TEXT IS NOT IN THIS FILE. "24–48 hours" is a promise the support
/// team has to keep, and the people who keep it must be able to change it —
/// over a holiday, during an incident, when staffing changes — without
/// shipping a mobile release and waiting on an app-store review. The copy is
/// served by support-service from the same row the admin console writes, so
/// what the team commits to is exactly what the customer reads, with no
/// second copy to drift out of step.
///
/// WHY IT RENDERS NOTHING WHILE LOADING. A reassurance banner that appears a
/// beat late, after the list has already drawn, reads as an error that just
/// appeared. Nothing is better than a flash, and the fetch is one small GET
/// alongside the screen's own load.
///
/// The notice is reassurance, not content: if the fetch fails the screen
/// shows the tickets and no banner, and nothing about support stops working.
class SupportSlaNotice extends StatelessWidget {
  /// The server-supplied copy. Null or blank renders nothing.
  final String? text;

  /// Matches the hosting screen's card colour so the notice reads as part of
  /// the page rather than as an alert dropped on top of it.
  final Color background;
  final Color accent;
  final Color textColor;
  final EdgeInsetsGeometry? margin;

  const SupportSlaNotice({
    super.key,
    required this.text,
    this.background = const Color(0xFF1F1F1F),
    this.accent = const Color(0xFF4E03D0),
    this.textColor = const Color(0xFF9CA3AF),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final copy = text?.trim() ?? '';
    if (copy.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.r),
        // A hairline in the brand colour rather than a filled "warning"
        // treatment: this is an expectation being set, not a problem.
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.schedule_rounded, size: 18.sp, color: accent),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              copy,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
