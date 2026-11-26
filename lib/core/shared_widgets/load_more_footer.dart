import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// SCROLL-TO-BOTTOM PAGINATION, ONCE.
///
/// Every paginated list in the app had rolled its own, and the same handful of
/// mistakes was spread across them. Collected here so a list can be made to
/// paginate correctly by adding two widgets instead of forty lines:
///
///   * [ScrollEndLoader] — fires [ScrollEndLoader.onReachEnd] as the list nears
///     its end.
///   * [LoadMoreFooter] — the last row: a spinner while a page is in flight, a
///     PRESSABLE control when there are more rows and nothing has been asked
///     for yet.
///
/// THE FOUR MISTAKES IT EXISTS TO PREVENT, each of which was live somewhere:
///
///  1. A ScrollController shared by two scroll views. `controller.position`
///     is `_positions.single` and throws the moment a second view attaches —
///     which is what happens when a sheet opens over a list that is still
///     mounted. A notification listener has no such state, so it cannot be
///     mis-shared.
///  2. Emitting a page-level "loading" state to append. Screens render that as
///     a skeleton over the whole list: the rows are torn down, the scroll
///     offset resets, and the listener — which only runs while the list is on
///     screen — can never ask for the page after. One page is then all anybody
///     can reach.
///  3. A spinner as the only footer. If a page fails while the reader is
///     already at the bottom, the extent does not change, so no further scroll
///     notification is ever generated. With nothing to press, the list is
///     stuck behind a spinner that spins for good.
///  4. Firing on every frame. Scroll notifications arrive continuously, so
///     without a guard the same page is requested dozens of times. Pass the
///     caller's in-flight flag as [ScrollEndLoader.loading].

/// Calls [onReachEnd] when the list scrolls within [threshold] of its end.
///
/// Uses a notification rather than a `ScrollController` deliberately — see the
/// header's first point. It also means a caller does not have to own, attach
/// and dispose anything, which is what the sheets were skipping.
class ScrollEndLoader extends StatelessWidget {
  const ScrollEndLoader({
    super.key,
    required this.child,
    required this.onReachEnd,
    required this.hasMore,
    required this.loading,
    this.threshold = 240,
  });

  final Widget child;
  final VoidCallback onReachEnd;

  /// Whether the server has more rows. No notification does anything when the
  /// list is complete.
  final bool hasMore;

  /// Whether a page is already in flight. THE GUARD — without it every scroll
  /// frame near the bottom starts another identical fetch.
  final bool loading;

  /// How close to the end counts as "the end", in logical pixels. Fires before
  /// the reader actually lands on the last row so the next page is usually
  /// there by the time they arrive.
  final double threshold;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (!hasMore || loading) return false;
        // Depth 0 only: a horizontal rail or a nested list inside a row would
        // otherwise report its own end and pull a page of the OUTER list.
        if (n.depth != 0) return false;
        final m = n.metrics;
        if (!m.hasContentDimensions || m.axis != Axis.vertical) return false;
        if (m.pixels >= m.maxScrollExtent - threshold) onReachEnd();
        // Never swallow it — a RefreshIndicator or an outer listener upstream
        // is entitled to the same notification.
        return false;
      },
      child: child,
    );
  }
}

/// The last row of a paginated list.
class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({
    super.key,
    required this.loading,
    required this.onLoadMore,
    this.error,
    this.label = 'Load more',
    this.onDark = true,
    this.remaining,
  });

  final bool loading;
  final VoidCallback onLoadMore;

  /// How many rows are still to come, when the caller knows.
  ///
  /// THE COUNT IS THE POINT when it is available: "Load more" alone leaves the
  /// reader guessing whether a tap is worth it, while "Show 12 more" answers
  /// it. Cursor-paginated lists do not know a total, which is why it is
  /// optional rather than required.
  final int? remaining;

  /// The previous attempt's message, when there was one. Shown quietly: the
  /// rows already on screen are still true, and a page that failed to append
  /// does not deserve a dialog.
  final String? error;
  final String label;

  /// Sheets in this app are white and screens are near-black, and the control
  /// has to be visible on both.
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 22.h),
        child: const Center(child: LazerVaultLoader.small()),
      );
    }

    final failed = error != null && error!.isNotEmpty;
    final count = remaining;
    final text = failed
        ? 'Try again'
        : count == null
            ? label
            : count == 1
                ? 'Show 1 more'
                : 'Show $count more';
    final fg = onDark ? Colors.white : const Color(0xFF4E03D0);
    final bg = onDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFF4E03D0).withValues(alpha: 0.07);

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 22.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (failed)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "Couldn't load more. $error",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w400,
                    color: onDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                  ),
                ),
              ),
            // A pill, not a bare text button: it is the only control on the
            // row and has to read as pressable on either ground.
            Material(
              color: bg,
              borderRadius: BorderRadius.circular(999.r),
              child: InkWell(
                onTap: onLoadMore,
                borderRadius: BorderRadius.circular(999.r),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.inter(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: fg,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        failed
                            ? Icons.refresh_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 15.sp,
                        color: fg,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
