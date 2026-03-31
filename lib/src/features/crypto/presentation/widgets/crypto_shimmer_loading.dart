import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Full-page shimmer loading skeleton for the Crypto landing page.
/// Each section mirrors the real widget layout so the user sees a
/// recognisable placeholder while data loads.
class CryptoShimmerLoading extends StatelessWidget {
  const CryptoShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1F1F1F),
      highlightColor: const Color(0xFF3D3D3D),
      period: const Duration(milliseconds: 1200),
      direction: ShimmerDirection.ttb, // diagonal feel: top-to-bottom sweep
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPortfolioShimmer(),
          SizedBox(height: 12.h),
          _buildQuickActionsShimmer(),
          SizedBox(height: 12.h),
          _buildWarningShimmer(),
          SizedBox(height: 12.h),
          _buildMarketOverviewShimmer(),
          SizedBox(height: 12.h),
          _buildSectionCardShimmer(title: true, itemCount: 3), // watchlist
          SizedBox(height: 12.h),
          _buildSectionCardShimmer(title: true, itemCount: 3), // transactions
          SizedBox(height: 12.h),
          _buildServicesGridShimmer(),
          SizedBox(height: 12.h),
          _buildSectionCardShimmer(title: true, itemCount: 1), // price alerts
          SizedBox(height: 12.h),
          _buildBannerShimmer(), // lazervault card
          SizedBox(height: 12.h),
          _buildCryptoCardsRowShimmer(),
          SizedBox(height: 12.h),
          _buildTopMoversShimmer(),
          SizedBox(height: 12.h),
          _buildFooterShimmer(),
        ],
      ),
    );
  }

  // ──────────────────────── Portfolio Overview ────────────────────────
  Widget _buildPortfolioShimmer() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _box(width: 140.w, height: 14.h),
          SizedBox(height: 12.h),
          Row(
            children: [
              _box(width: 180.w, height: 32.h),
              SizedBox(width: 12.w),
              _box(width: 70.w, height: 28.h, radius: 20.r),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (_) => _buildStatShimmer()),
          ),
        ],
      ),
    );
  }

  Widget _buildStatShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _box(width: 50.w, height: 12.h),
        SizedBox(height: 6.h),
        _box(width: 70.w, height: 14.h),
      ],
    );
  }

  // ──────────────────────── Quick Actions ─────────────────────────────
  Widget _buildQuickActionsShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: List.generate(
          3,
          (i) => Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i < 2 ? 12.w : 0),
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ──────────────────────── Warning Banner ────────────────────────────
  Widget _buildWarningShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _box(width: double.infinity, height: 12.h),
          SizedBox(height: 8.h),
          _box(width: double.infinity, height: 12.h),
          SizedBox(height: 8.h),
          _box(width: 200.w, height: 12.h),
        ],
      ),
    );
  }

  // ──────────────────────── Market Overview ───────────────────────────
  Widget _buildMarketOverviewShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(width: 130.w, height: 20.h),
              _box(width: 100.w, height: 28.h, radius: 20.r),
            ],
          ),
          SizedBox(height: 20.h),
          // 3 stat columns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (_) => _buildStatShimmer()),
          ),
          SizedBox(height: 24.h),
          // trending coins header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(width: 110.w, height: 16.h),
              _box(width: 60.w, height: 14.h),
            ],
          ),
          SizedBox(height: 16.h),
          // 3 trending coin rows
          ...List.generate(3, (i) => Padding(
            padding: EdgeInsets.only(bottom: i < 2 ? 12.h : 0),
            child: _buildListItemShimmer(),
          )),
        ],
      ),
    );
  }

  // ──────────────────────── Generic section card ─────────────────────
  Widget _buildSectionCardShimmer({bool title = false, int itemCount = 3}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(width: 140.w, height: 20.h),
                _box(width: 50.w, height: 14.h),
              ],
            ),
            SizedBox(height: 16.h),
          ],
          ...List.generate(itemCount, (i) => Padding(
            padding: EdgeInsets.only(bottom: i < itemCount - 1 ? 12.h : 0),
            child: _buildListItemShimmer(),
          )),
        ],
      ),
    );
  }

  // ──────────────────────── Services 2x2 Grid ────────────────────────
  Widget _buildServicesGridShimmer() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _box(width: 150.w, height: 20.h),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16.w,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.1,
            children: List.generate(
              4,
              (_) => Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(width: 40.w, height: 40.w, radius: 20.r),
                    const Spacer(),
                    _box(width: 100.w, height: 18.h),
                    SizedBox(height: 6.h),
                    _box(width: 80.w, height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────── Banner / Card promo ──────────────────────
  Widget _buildBannerShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 140.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(width: 130.w, height: 20.h),
                  SizedBox(height: 6.h),
                  _box(width: 170.w, height: 14.h),
                ],
              ),
              _box(width: 48.w, height: 48.w, radius: 12.r),
            ],
          ),
          const Spacer(),
          _box(width: 90.w, height: 32.h, radius: 20.r),
        ],
      ),
    );
  }

  // ──────────────────────── BTC / ETH Cards Row ─────────────────────
  Widget _buildCryptoCardsRowShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: List.generate(
          2,
          (i) => Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.all(16.w),
              height: 140.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(width: 50.w, height: 16.h),
                  SizedBox(height: 8.h),
                  _box(width: 90.w, height: 24.h),
                  SizedBox(height: 6.h),
                  _box(width: 60.w, height: 14.h),
                  const Spacer(),
                  // sparkline placeholder
                  _box(width: double.infinity, height: 30.h, radius: 4.r),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ──────────────────────── Top Movers ───────────────────────────────
  Widget _buildTopMoversShimmer() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(width: 100.w, height: 16.h),
              _box(width: 20.w, height: 20.w, radius: 10.r),
            ],
          ),
          SizedBox(height: 16.h),
          // toggle tabs
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...List.generate(3, (i) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildListItemShimmer(),
          )),
        ],
      ),
    );
  }

  // ──────────────────────── Footer ───────────────────────────────────
  Widget _buildFooterShimmer() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Center(child: _box(width: 260.w, height: 12.h)),
    );
  }

  // ──────────────────────── Reusable list row ────────────────────────
  Widget _buildListItemShimmer() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _box(width: 36.w, height: 36.w, radius: 18.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(width: 100.w, height: 14.h),
                SizedBox(height: 6.h),
                _box(width: 60.w, height: 12.h),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _box(width: 80.w, height: 14.h),
              SizedBox(height: 6.h),
              _box(width: 50.w, height: 12.h),
            ],
          ),
        ],
      ),
    );
  }

  // ──────────────────────── Primitive box ─────────────────────────────
  static Widget _box({
    required double width,
    required double height,
    double radius = 6,
  }) {
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
