import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tiny coloured pill used across the contribution / group surfaces
/// for short status labels (e.g. "Refunded — Cycle 3", "Partial",
/// "Pending"). Extracted from the `_badge` helper that lived inside
/// contribution_details_screen.dart so the past-contributions screens
/// can render the same pill without copy-pasting the styling.
class StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const StatusPill({
    super.key,
    required this.text,
    required this.color,
    this.icon,
  });

  /// Maps a refund_status string (none|pending|completed|failed) to a
  /// pill the user can scan at a glance. Caller passes through the
  /// string straight off the API; unknown / empty values render
  /// nothing so legacy / pre-saga rows stay clean.
  static Widget? refund({required String status, int? cycleIndex}) {
    final s = status.toLowerCase();
    switch (s) {
      case 'completed':
        return StatusPill(
          text: cycleIndex != null && cycleIndex > 0
              ? 'Refunded — Cycle $cycleIndex'
              : 'Refunded',
          color: const Color(0xFF10B981),
          icon: Icons.undo,
        );
      case 'pending':
        return StatusPill(
          text: cycleIndex != null && cycleIndex > 0
              ? 'Refund pending — Cycle $cycleIndex'
              : 'Refund pending',
          color: const Color(0xFFF59E0B),
          icon: Icons.hourglass_top,
        );
      case 'failed':
        return StatusPill(
          text: cycleIndex != null && cycleIndex > 0
              ? 'Refund failed — Cycle $cycleIndex'
              : 'Refund failed',
          color: const Color(0xFFEF4444),
          icon: Icons.error_outline,
        );
      case 'none':
      case '':
        return null;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11.sp, color: color),
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
