import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'statistics_shimmer_loading.dart' show Shimmer;

/// Content-region loading skeleton for the AI Budgeting screen.
///
/// Rendered ONLY in the area below the header + source tabs while the
/// statistics content (re)loads, so a source / bank / period switch never
/// tears the header or tabs down to a black screen. The sheen sweeps
/// DIAGONALLY (top-left -> bottom-right) over dark blocks shaped like the
/// real content (overview stat row, a tall chart, a couple of list rows),
/// matching the page's dark theme instead of the old light-grey shimmer.
class StatisticsContentSkeleton extends StatelessWidget {
  const StatisticsContentSkeleton({super.key});

  // Dark base + slightly lighter highlight so the diagonal sheen reads on the
  // near-black page background without the jarring light-grey flash.
  static const Color _base = Color(0xFF1F1F1F);
  static const Color _highlight = Color(0xFF2E2E2E);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_base, _highlight, _base],
        stops: [0.1, 0.5, 0.9],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview: two stat tiles side by side.
            Row(children: [
              _block(height: 96.h, expanded: true),
              SizedBox(width: 12.w),
              _block(height: 96.h, expanded: true),
            ]),
            SizedBox(height: 20.h),
            // A tall analytics chart block.
            _block(height: 180.h, width: double.infinity),
            SizedBox(height: 20.h),
            // A couple of list/category rows.
            _block(height: 56.h, width: double.infinity),
            SizedBox(height: 12.h),
            _block(height: 56.h, width: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _block({
    required double height,
    double? width,
    bool expanded = false,
  }) {
    final box = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: _base,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
    return expanded ? Expanded(child: box) : box;
  }
}
