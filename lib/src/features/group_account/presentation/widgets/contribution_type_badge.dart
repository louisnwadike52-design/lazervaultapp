import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/group_entities.dart';
import '../utils/group_funds_palette.dart';

/// Compact pill that labels a contribution as ROSCA or one-time so a
/// glance at the list (or the detail header) tells you which payout
/// semantics apply. Width is intrinsic; the label clips with ellipsis
/// inside a Flexible so the badge never blows out a tight row.
class ContributionTypeBadge extends StatelessWidget {
  final ContributionType type;

  /// Tighter, for a row that already carries another badge.
  ///
  /// The card puts this beside "Created by you"; at full size the pair wrapped
  /// to two lines on a narrow phone, which is the stacking this was meant to
  /// remove.
  final bool compact;

  const ContributionTypeBadge({
    super.key,
    required this.type,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isRosca = type == ContributionType.rotatingSavings;
    // Violet-400, not the brand purple: this pill only ever sits on a
    // near-black surface, where #4E03D0 as INK disappeared into the card.
    // See GroupFundsPalette.
    final color = isRosca ? GroupFundsPalette.onDark : const Color(0xFF10B981);
    final label = isRosca ? 'Esusu · Rotating' : 'One-time';
    final icon = isRosca ? Icons.sync : Icons.flag_outlined;

    // Lighter than it was (0.15 fill / 0.4 border). This is a quiet label
    // saying which payout rules apply, sitting next to a status badge and a
    // "Created by you" badge — three saturated pills in a row made the card
    // read as three alerts rather than one goal.
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: compact ? 6.w : 8.w, vertical: compact ? 2.h : 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.38)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: compact ? 10.sp : 12.sp),
          SizedBox(width: compact ? 3.w : 4.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: compact ? 9.sp : 11.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
