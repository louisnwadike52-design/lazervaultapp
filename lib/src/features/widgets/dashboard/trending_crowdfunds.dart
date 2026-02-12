import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/leaderboard_cubit.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/leaderboard_state.dart';

class TrendingCrowdfunds extends StatefulWidget {
  const TrendingCrowdfunds({super.key});

  @override
  State<TrendingCrowdfunds> createState() => _TrendingCrowdfundsState();
}

class _TrendingCrowdfundsState extends State<TrendingCrowdfunds> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    context.read<LeaderboardCubit>().loadLeaderboard(
          sortBy: LeaderboardSortBy.trending,
          limit: 5,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoading) {
          return _buildShimmer();
        }
        if (state is LeaderboardLoaded) {
          final entries = state.entries;
          if (entries.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              if (state.isStale)
                const LinearProgressIndicator(
                  minHeight: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                  backgroundColor: Color(0xFF1F1F1F),
                ),
              _buildContent(entries),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(List<LeaderboardEntry> entries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Crowdfunds',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.crowdfundLeaderboard),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Horizontal scrolling cards
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _buildCrowdfundCard(entries[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Crowdfunds',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 3,
            itemBuilder: (_, __) => _buildShimmerCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        width: 200.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 80.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 6.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 100.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrowdfundCard(LeaderboardEntry entry) {
    final crowdfund = entry.crowdfund;
    final progress = (crowdfund.progressPercentage / 100).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: _isNavigating
          ? null
          : () {
              setState(() => _isNavigating = true);
              Get.toNamed(
                AppRoutes.crowdfundDetails,
                arguments: {'crowdfundId': crowdfund.id},
              )?.then((_) {
                if (mounted) setState(() => _isNavigating = false);
              });
              // Safety fallback in case .then doesn't fire
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) setState(() => _isNavigating = false);
              });
            },
      child: Container(
        width: 200.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            Text(
              crowdfund.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Creator name
            Text(
              'by ${crowdfund.creator.displayName}',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: const Color(0xFF2D2D2D),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF3B82F6),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            // Raised amount and percentage
            Text(
              '${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(0)} raised',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF10B981),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Donor count and percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 14.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${crowdfund.donorCount} donors',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${crowdfund.progressPercentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
