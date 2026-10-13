import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/group_funds_palette.dart';

/// "Created by you" — shown on a group or contribution the signed-in user
/// started.
///
/// In a list of joint funds, the ones you run and the ones you merely belong
/// to look identical, yet they are not: you can edit, invite, and close the
/// ones you created. Marking them is the difference between scanning a list
/// and having to open each row to remember which is which.
///
/// Deliberately placed on its OWN line beneath the title and description
/// rather than beside the status pill. The card's top row is already
/// avatar + name + status, and adding a fourth item there is what pushes
/// content into neighbouring elements — the same overflow the member rows had.
/// Inside the title column it is bounded by the column's width and cannot
/// collide with anything.
class CreatedByYouBadge extends StatelessWidget {
  const CreatedByYouBadge({super.key, this.compact = false});

  /// Tighter padding for dense list rows.
  final bool compact;

  // Violet-400. This badge only ever paints on #1F1F1F cards; violet-500 as
  // INK at 10% fill was reported as invisible there. See GroupFundsPalette.
  static const _accent = GroupFundsPalette.onDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 5.w : 6.w,
        vertical: compact ? 1.5.h : 2.h,
      ),
      decoration: BoxDecoration(
        // Lighter, with the rest of the badge row: this is a quiet
        // provenance marker, not an alert.
        color: _accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: _accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded,
              size: compact ? 9.sp : 10.sp, color: _accent),
          SizedBox(width: 3.w),
          Text(
            'Created by you',
            style: GoogleFonts.inter(
              fontSize: compact ? 8.5.sp : 9.sp,
              fontWeight: FontWeight.w600,
              color: _accent,
            ),
          ),
        ],
      ),
    );
  }
}
