import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// SHIMMER SKELETON FOR A USER SEARCH.
///
/// Replaces the centred spinner the search sheets used while results loaded. A
/// spinner in the middle of an empty sheet says only "wait"; a skeleton in the
/// SHAPE of the rows about to appear says "results are coming, here is where" —
/// and because the geometry matches the real tile, the list does not jump when
/// the rows land on top of it.
///
/// Every search surface shares this one widget, so a sheet opened from send
/// funds, batch transfer, TagPay, SprayMe or crypto cannot look different from
/// the others while loading.
///
/// GEOMETRY IS COPIED FROM THE REAL ROW, not approximated: a 44.w circle, a
/// 12.w gap, then a name line over a shorter subtitle line, inside the same
/// 10.h / 4.w padding as _resultTile. Changing the tile without changing this
/// is what makes a skeleton read as a glitch.
class UserSearchSkeleton extends StatelessWidget {
  const UserSearchSkeleton(
      {super.key, this.rows = 6, this.showSectionHeader = true});

  /// How many placeholder rows to draw.
  ///
  /// Six fills a sheet without implying a result count — the list is clipped by
  /// the sheet anyway, and drawing more is work nobody sees.
  final int rows;

  /// Whether to lead with a section-header placeholder, matching the
  /// "Your contacts" / "Everyone else" headings the real list renders.
  final bool showSectionHeader;

  // The project's shimmer palette — same base, highlight and period as the
  // crypto and statistics skeletons, so one loading state never looks like a
  // different app from another.
  static const Color _base = Color(0xFF1F1F1F);
  static const Color _highlight = Color(0xFF3D3D3D);
  static const Duration _period = Duration(milliseconds: 1200);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _base,
      highlightColor: _highlight,
      period: _period,
      // One Shimmer wrapping the whole list rather than one per row: the
      // highlight then sweeps across the list as a single motion instead of
      // every row pulsing in lockstep, which reads as a progress cue rather
      // than a row of blinking boxes.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showSectionHeader) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 6.h, 4.w, 8.h),
              child: _box(92.w, 10.h, radius: 4),
            ),
          ],
          for (int i = 0; i < rows; i++) _skeletonRow(i),
        ],
      ),
    );
  }

  Widget _skeletonRow(int index) {
    // The name line varies in width per row. A column of identical bars reads
    // as a loading GRAPHIC; slightly ragged ones read as text that has not
    // arrived yet, which is what this is standing in for.
    const widths = <double>[140, 112, 158, 126, 148, 104];
    final nameWidth = widths[index % widths.length];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
      child: Row(
        children: [
          // The avatar: a circle, matching _resultTile's 44.w.
          Container(
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _box(nameWidth.w, 12.h),
                SizedBox(height: 6.h),
                // The subtitle (account number / username) is always shorter
                // than the name above it.
                _box((nameWidth * 0.62).w, 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// A single shimmer block.
  ///
  /// White on purpose: Shimmer.fromColors paints the gradient over whatever it
  /// wraps, so the child's own colour only has to be opaque — a themed colour
  /// here would be tinted twice and come out muddy.
  Widget _box(double width, double height, {double radius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
