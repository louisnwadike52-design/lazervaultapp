import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// THE "VIEW ALL" LINK, WITH A TAP TARGET BIG ENOUGH TO HIT.
///
/// THE PROBLEM. Every service's recent-transactions strip rendered this as a
/// bare `GestureDetector` wrapped directly around a 13sp `Text`. A
/// GestureDetector's hit area is exactly its child, so the tappable region was
/// the glyphs themselves — roughly 56 x 16 logical pixels, and only 16 tall.
/// Both Material (48dp) and the iOS HIG (44pt) put the minimum at nearly three
/// times that height. In practice the link was missed, repeatedly, on a strip
/// whose whole purpose is to get the user to the full history.
///
/// WHAT FIXES IT, and why each part is needed:
///
///   * PADDING INSIDE the gesture detector, not outside. Padding applied
///     around a GestureDetector enlarges the gap, not the target; it has to be
///     the detector's child for the hit area to grow with it.
///   * `HitTestBehavior.opaque`, so taps land on the padding too. Without it
///     the transparent padding is not hit-tested and the whole exercise is
///     decorative — the single most common way this fix gets written and
///     silently does nothing.
///   * A minimum box via `ConstrainedBox`, so the target stays compliant even
///     when a short label or a small text scale would otherwise shrink it.
///   * A chevron, so it reads as a destination rather than a label. Affordance
///     is half of why it was being missed.
///
/// ONE WIDGET because there are eight of these strips (airtime, data, cable,
/// internet, electricity, water, betting, beneficiaries) and a per-screen fix
/// is a fix that lands on seven of eight. The next service gets it for free.
class ViewAllButton extends StatelessWidget {
  const ViewAllButton({
    super.key,
    required this.onTap,
    this.label = 'View All',
    this.color = const Color(0xFFA78BFA),
    this.fontSize,
  });

  final VoidCallback onTap;
  final String label;
  final Color color;

  /// Overridable for the few strips that use a slightly different scale; the
  /// hit area does NOT shrink with it, which is the point of the constraint.
  final double? fontSize;

  /// Material's minimum. Not 44: taking the larger of the two platform floors
  /// satisfies both, and the extra 4dp is invisible next to a 16sp heading.
  static const double minTapDimension = 48;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Opaque so the PADDING is tappable, not just the glyphs. This is the
      // line that actually enlarges the target.
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minTapDimension.h,
          minWidth: minTapDimension.w,
        ),
        child: Padding(
          // Asymmetric on purpose: these sit at the right edge of a row, so
          // the right inset is trimmed to keep the text visually aligned with
          // the content below while the tappable box still reaches the edge.
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 4.w, 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: fontSize ?? 13.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              SizedBox(width: 2.w),
              Icon(Icons.chevron_right_rounded, size: 16.sp, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
