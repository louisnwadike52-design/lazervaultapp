import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer skeleton for the Split Bills list (Incoming / Created tabs).
///
/// Mirrors `escrow_shimmer.dart` for colours/structure and matches the real
/// `split_bill_card.dart` shape: avatar circle, title + subtitle, amount +
/// "your share", a progress-bar block and a status-chip block.
class SplitBillListShimmer extends StatelessWidget {
  final int itemCount;
  const SplitBillListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: const Color(0xFF1A1A1A),
          highlightColor: const Color(0xFF2A2A2A),
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Bill avatar circle (radius 18 in the real card)
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Title + subtitle ("From @user" / "Created by you")
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bar(width: 150.w, height: 14.h),
                          SizedBox(height: 8.h),
                          _bar(width: 100.w, height: 12.h),
                        ],
                      ),
                    ),
                    // Amount + "Your share" caption
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _bar(width: 70.w, height: 16.h),
                        SizedBox(height: 8.h),
                        _bar(width: 48.w, height: 11.h),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                // Progress-bar block
                _bar(width: double.infinity, height: 8.h, radius: 4.r),
                SizedBox(height: 8.h),
                // Status-chip block
                _bar(width: 130.w, height: 20.h, radius: 6.r),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bar({required double width, required double height, double? radius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 4.r),
      ),
    );
  }
}
