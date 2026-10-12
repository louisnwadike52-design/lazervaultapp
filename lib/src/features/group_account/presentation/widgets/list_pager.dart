import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Numbered pager: ‹ 1 2 3 … 9 ›.
///
/// WHY NUMBERS
/// -----------
/// A member asked for this because the dashboard had become a scroll they
/// could not navigate. A numbered pager gives a POSITION — "my active groups
/// are on page 1, the old ones are on 3" — which is exactly what infinite
/// scroll takes away. It also makes the size of the list visible, which a
/// scroll never does.
///
/// WHY A WINDOW
/// ------------
/// Twenty page buttons do not fit on a phone and would not be useful if they
/// did. The window keeps the current page in the middle where possible, and
/// always shows the first and last so "go to the end" is one tap from
/// anywhere.
class ListPager extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;

  /// Disables every control while a page is in flight, so a double tap
  /// cannot queue two page changes and land on the wrong one.
  final bool busy;

  const ListPager({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    this.busy = false,
  });

  /// Page numbers to draw, with 0 standing for an ellipsis.
  ///
  /// Static and pure so it can be tested directly — an off-by-one here puts
  /// the user on the wrong page, which is worse than it looking wrong.
  static List<int> windowFor(int current, int total, {int maxButtons = 5}) {
    if (total <= 0) return const [];
    if (total <= maxButtons) {
      return [for (var i = 1; i <= total; i++) i];
    }
    // Always the first and the last; the rest is a window around current.
    final span = maxButtons - 2; // minus first and last
    var start = current - (span ~/ 2);
    var end = start + span - 1;
    if (start < 2) {
      start = 2;
      end = start + span - 1;
    }
    if (end > total - 1) {
      end = total - 1;
      start = end - span + 1;
      if (start < 2) start = 2;
    }

    final pages = <int>[1];
    if (start > 2) pages.add(0);
    for (var i = start; i <= end; i++) {
      pages.add(i);
    }
    if (end < total - 1) pages.add(0);
    pages.add(total);
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    // One page is not a pager. Drawing "1" alone is chrome that tells the
    // user nothing and takes a row of their screen.
    if (totalPages <= 1) return const SizedBox.shrink();

    final pages = windowFor(currentPage, totalPages);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _arrow(
            icon: Icons.chevron_left,
            enabled: !busy && currentPage > 1,
            onTap: () => onPageSelected(currentPage - 1),
            semantic: 'Previous page',
          ),
          SizedBox(width: 6.w),
          for (final p in pages) ...[
            if (p == 0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text('…',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280), fontSize: 13.sp)),
              )
            else
              _pageButton(p),
            SizedBox(width: 4.w),
          ],
          SizedBox(width: 2.w),
          _arrow(
            icon: Icons.chevron_right,
            enabled: !busy && currentPage < totalPages,
            onTap: () => onPageSelected(currentPage + 1),
            semantic: 'Next page',
          ),
        ],
      ),
    );
  }

  Widget _pageButton(int page) {
    final selected = page == currentPage;
    return Semantics(
      selected: selected,
      button: true,
      label: 'Page $page',
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        // Tapping the page you are on is a no-op, not a reload: it would
        // otherwise look like a broken button that flashes a spinner.
        onTap: busy || selected ? null : () => onPageSelected(page),
        child: Container(
          constraints: BoxConstraints(minWidth: 32.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: selected
                ? const Color.fromARGB(255, 78, 3, 208)
                : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: selected
                  ? const Color.fromARGB(255, 78, 3, 208)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          child: Text(
            '$page',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.5.sp,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? Colors.white : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _arrow({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
    required String semantic,
  }) {
    return Semantics(
      button: true,
      enabled: enabled,
      label: semantic,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: enabled ? onTap : null,
        child: Container(
          padding: EdgeInsets.all(7.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Icon(
            icon,
            size: 17.sp,
            // Dimmed rather than hidden: a control that disappears at the
            // ends makes the row jump and the other buttons move under the
            // user's finger.
            color: enabled ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }
}
