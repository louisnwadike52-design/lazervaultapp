import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer skeleton for the Escrow deal list. Mirrors invoice_shimmer.dart.
class EscrowListShimmer extends StatelessWidget {
  final int itemCount;
  const EscrowListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Deal icon circle
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Title + subtitle
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
                    // Amount + status badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _bar(width: 70.w, height: 16.h),
                        SizedBox(height: 8.h),
                        _bar(width: 54.w, height: 18.h, radius: 8.r),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                // Progress / waiting line
                _bar(width: double.infinity, height: 11.h),
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

/// Shimmer skeleton for the Escrow deal detail screen.
class EscrowDetailShimmer extends StatelessWidget {
  const EscrowDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF1A1A1A),
        highlightColor: const Color(0xFF2A2A2A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header / amount card
            Container(
              width: double.infinity,
              height: 170.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            SizedBox(height: 20.h),
            // Parties section title
            _bar(width: 120.w, height: 16.h),
            SizedBox(height: 12.h),
            ...List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.only(bottom: 8.h),
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Timeline / events title
            _bar(width: 100.w, height: 16.h),
            SizedBox(height: 12.h),
            ...List.generate(
              3,
              (index) => Container(
                margin: EdgeInsets.only(bottom: 8.h),
                width: double.infinity,
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Action button
            Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
