import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/escrow_theme.dart';

/// Numbered pagination: Back, a window of page numbers, Next.
///
/// WHY NUMBERS AND NOT INFINITE SCROLL. A list you can only reach by
/// scrolling has no address: you cannot say "it was on page 3", cannot get
/// back to where you were after opening an item, and cannot tell how much
/// there is. For records someone audits rather than browses, that matters
/// more than the smoother feel.
///
/// THE WINDOW. Every page number is unusable past a few dozen pages, so the
/// bar shows first, last, and a window around the current page with gaps
/// marked. The first and last are always reachable in one tap, because
/// "start again" and "the oldest one" are the two jumps people actually
/// make.
class PagedPaginationBar extends StatelessWidget {
  /// 1-based.
  final int page;
  final int totalPages;

  /// Null while a page is in flight, which disables the controls rather than
  /// letting a second tap queue a third request.
  final ValueChanged<int>? onGoTo;

  /// Reserve space on the right for a floating action button that overlaps
  /// this bar. Only the screens that actually have one pass true.
  final bool reserveFabGutter;

  const PagedPaginationBar({
    super.key,
    required this.page,
    required this.totalPages,
    required this.onGoTo,
    this.reserveFabGutter = false,
  });

  /// The page numbers to render, with 0 standing for a gap.
  ///
  /// Static and tested rather than computed inline: an off-by-one here shows
  /// a page that does not exist, and tapping it returns an empty list that
  /// looks like lost data.
  static List<int> windowFor(int page, int totalPages, {int span = 1}) {
    if (totalPages <= 0) return const [];
    if (totalPages <= 5 + span) {
      return [for (var i = 1; i <= totalPages; i++) i];
    }
    final out = <int>{1};
    for (var i = page - span; i <= page + span; i++) {
      if (i >= 1 && i <= totalPages) out.add(i);
    }
    out.add(totalPages);
    final sorted = out.toList()..sort();

    final withGaps = <int>[];
    for (var i = 0; i < sorted.length; i++) {
      if (i > 0 && sorted[i] - sorted[i - 1] > 1) withGaps.add(0);
      withGaps.add(sorted[i]);
    }
    return withGaps;
  }

  @override
  Widget build(BuildContext context) {
    // One page is not pagination; showing a lone "1" is noise.
    if (totalPages <= 1) return const SizedBox.shrink();
    final pages = windowFor(page, totalPages);
    final enabled = onGoTo != null;

    Widget arrow(IconData icon, int target, String tooltip) {
      final can = enabled && target >= 1 && target <= totalPages;
      return Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: can ? () => onGoTo!(target) : null,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.all(7.w),
            child: Icon(icon,
                size: 18.sp,
                color: can
                    ? EscrowTheme.primaryLight
                    : EscrowTheme.textSecondary.withValues(alpha: 0.35)),
          ),
        ),
      );
    }

    Widget number(int n) {
      if (n == 0) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text('…',
              style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary, fontSize: 12.sp)),
        );
      }
      final active = n == page;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: InkWell(
          onTap: enabled && !active ? () => onGoTo!(n) : null,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            constraints: BoxConstraints(minWidth: 30.w),
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
            decoration: BoxDecoration(
              color: active ? EscrowTheme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: active ? EscrowTheme.primary : EscrowTheme.border),
            ),
            child: Text('$n',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: active ? Colors.white : EscrowTheme.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
          ),
        ),
      );
    }

    // Left-aligned, with the right-hand gutter reserved for a floating action
    // in the same bottom corner. Centred, the last page numbers and the
    // forward arrows slid underneath the FAB and could not be tapped at all on
    // a 2+ page list.
    //
    // Only reserved where such an action actually exists ([reserveFabGutter]).
    // The offers list has no FAB, and spending 150.w there would squeeze the
    // controls for nothing — on a narrow phone enough to start scrolling the
    // page numbers that otherwise fit.
    return Padding(
      padding: EdgeInsets.only(
        left: 12.w,
        right: reserveFabGutter ? 150.w : 12.w,
        top: 8.h,
        bottom: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          arrow(Icons.keyboard_double_arrow_left_rounded, 1, 'First page'),
          arrow(Icons.chevron_left_rounded, page - 1, 'Previous page'),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [for (final n in pages) number(n)]),
            ),
          ),
          arrow(Icons.chevron_right_rounded, page + 1, 'Next page'),
          arrow(Icons.keyboard_double_arrow_right_rounded, totalPages,
              'Last page'),
        ],
      ),
    );
  }
}
