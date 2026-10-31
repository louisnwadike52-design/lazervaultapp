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
  const UserSearchSkeleton({
    super.key,
    this.rows = 6,
    this.showSectionHeader = true,
    this.onDark = false,
  });

  /// How many placeholder rows to draw.
  ///
  /// Six fills a sheet without implying a result count — the list is clipped by
  /// the sheet anyway, and drawing more is work nobody sees.
  final int rows;

  /// Whether to lead with a section-header placeholder, matching the
  /// "Your contacts" / "Everyone else" headings the real list renders.
  final bool showSectionHeader;

  /// Whether this skeleton is drawn on a DARK surface.
  ///
  /// It used to have no choice: the palette was hardcoded to the crypto and
  /// statistics shimmer values (#1F1F1F / #3D3D3D) on the reasoning that one
  /// loading state should never look like a different app from another. But
  /// those two skeletons sit on dark screens, and almost every user-search
  /// sheet is `Colors.white` — so the "consistent" palette painted near-black
  /// bars onto a white sheet. Consistency is with the SURFACE, not with the
  /// other file.
  ///
  /// Defaults to false because the search sheets that use this are light
  /// (send funds, bank transfer, TagPay, invoice, crypto recipient pick); only
  /// SprayMe's tag sheet is dark.
  final bool onDark;

  // Dark palette: unchanged, for the surfaces that genuinely are dark.
  static const Color _darkBase = Color(0xFF1F1F1F);
  static const Color _darkHighlight = Color(0xFF3D3D3D);

  // Light palette. Base is visible against white without reading as content,
  // highlight is close to white so the sweep is a soft pass rather than a
  // flash — the same relationship the dark pair has to its own ground.
  static const Color _lightBase = Color(0xFFE4E6EB);
  static const Color _lightHighlight = Color(0xFFF7F8FA);

  static const Duration _period = Duration(milliseconds: 1200);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: onDark ? _darkBase : _lightBase,
      highlightColor: onDark ? _darkHighlight : _lightHighlight,
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
  /// The child's colour only has to be OPAQUE: Shimmer.fromColors paints its
  /// gradient over whatever it wraps, so the bar you see is baseColor →
  /// highlightColor, never this value. Kept white because that is what the
  /// shimmer package's own examples use and it makes the intent obvious; the
  /// palette above is the thing that decides how the bar reads.
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
