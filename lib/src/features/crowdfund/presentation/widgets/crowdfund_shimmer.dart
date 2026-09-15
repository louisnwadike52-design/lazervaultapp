import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// Loading skeletons for the crowdfund surfaces.
//
// Lifted verbatim out of crowdfund_list_screen.dart (where it was a
// private `_buildCampaignListShimmer`) so the campaign DETAIL screen can
// use the same bars, palette and cadence instead of bottoming out at a
// bare spinner. Same convention as the sibling features'
// `<feature>_shimmer.dart` files (escrow, split_bills, invoice, tag_pay).

const _shimmerBase = Color(0xFF1F1F1F);
const _shimmerHighlight = Color(0xFF3D3D3D);
const _shimmerPeriod = Duration(milliseconds: 1200);

/// Single shimmer bar. `Shimmer.fromColors` paints over it, so the fill
/// is plain white by design.
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

/// Skeleton for the campaign list / browse feed.
class CrowdfundListShimmer extends StatelessWidget {
  const CrowdfundListShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBase,
      highlightColor: _shimmerHighlight,
      period: _shimmerPeriod,
      direction: ShimmerDirection.ltr,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) => const _CampaignCardSkeleton(),
      ),
    );
  }
}

class _CampaignCardSkeleton extends StatelessWidget {
  const _CampaignCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _shimmerBase,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bar(width: 70.w, height: 24.h),
              _bar(width: 80.w, height: 20.h),
            ],
          ),
          SizedBox(height: 12.h),
          // Creator row
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bar(width: 100.w, height: 12.h),
                  SizedBox(height: 4.h),
                  _bar(width: 70.w, height: 10.h),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Title
          _bar(width: double.infinity, height: 16.h),
          SizedBox(height: 8.h),
          // Description
          _bar(width: double.infinity, height: 12.h),
          SizedBox(height: 4.h),
          _bar(width: 200.w, height: 12.h),
          SizedBox(height: 16.h),
          // Progress
          _bar(width: double.infinity, height: 8.h),
          SizedBox(height: 12.h),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bar(width: 80.w, height: 12.h),
              _bar(width: 80.w, height: 12.h),
            ],
          ),
        ],
      ),
    );
  }
}

/// Just the donor rows. Used on the detail screen when the header has
/// been seeded from the list row but the donations page hasn't landed —
/// the server's denormalized `donorCount` already tells us donors exist,
/// so the "No donations yet" empty state would be a lie.
class CrowdfundDonorRowsShimmer extends StatelessWidget {
  const CrowdfundDonorRowsShimmer({super.key, this.rowCount = 3});

  final int rowCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBase,
      highlightColor: _shimmerHighlight,
      period: _shimmerPeriod,
      direction: ShimmerDirection.ltr,
      child: Column(
        children: List.generate(
          rowCount,
          (_) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _bar(width: double.infinity, height: 64.h, radius: 12.r),
          ),
        ),
      ),
    );
  }
}

/// Skeleton for the campaign DETAIL screen: hero, title block, progress
/// card, stat row, story paragraph and a couple of donor rows — laid out
/// to match what [CrowdfundDetailsScreen] paints once data lands, so the
/// page doesn't jump when it swaps in.
class CrowdfundDetailShimmer extends StatelessWidget {
  const CrowdfundDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBase,
      highlightColor: _shimmerHighlight,
      period: _shimmerPeriod,
      direction: ShimmerDirection.ltr,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image — matches the SliverAppBar's 180.h expanded slot.
            Container(width: double.infinity, height: 180.h, color: Colors.white),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bar(width: double.infinity, height: 20.h),
                  SizedBox(height: 8.h),
                  _bar(width: 180.w, height: 14.h),
                  SizedBox(height: 18.h),
                  // Progress / amount card
                  Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: _shimmerBase,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  // Stat row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (_) => _bar(width: 90.w, height: 56.h, radius: 12.r),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  // Story paragraph
                  _bar(width: 120.w, height: 14.h),
                  SizedBox(height: 10.h),
                  _bar(width: double.infinity, height: 12.h),
                  SizedBox(height: 6.h),
                  _bar(width: double.infinity, height: 12.h),
                  SizedBox(height: 6.h),
                  _bar(width: 220.w, height: 12.h),
                  SizedBox(height: 22.h),
                  // Donor rows
                  _bar(width: 100.w, height: 14.h),
                  SizedBox(height: 12.h),
                  ...List.generate(
                    3,
                    (_) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _bar(
                        width: double.infinity,
                        height: 56.h,
                        radius: 12.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
