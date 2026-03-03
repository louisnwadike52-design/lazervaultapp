import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/referral_cubit.dart';
import '../cubit/referral_state.dart';
import '../widgets/referral_code_card.dart';
import '../widgets/how_it_works_card.dart';
import '../widgets/referral_stats_card.dart';
import '../widgets/leaderboard_list.dart';
import '../widgets/recent_referrals_list.dart';

class ReferralDashboardScreen extends StatefulWidget {
  const ReferralDashboardScreen({super.key});

  @override
  State<ReferralDashboardScreen> createState() => _ReferralDashboardScreenState();
}

class _ReferralDashboardScreenState extends State<ReferralDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReferralCubit>().loadDashboard();
  }

  Future<void> _onRefresh() async {
    await context.read<ReferralCubit>().refreshDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text(
          'Referral Program',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: BlocConsumer<ReferralCubit, ReferralState>(
        listener: (context, state) {
          if (state is ReferralCodeCopied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Referral code copied to clipboard!'),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }

          if (state is ReferralError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ReferralLoading) {
            return _buildLoadingState();
          }

          if (state is ReferralError) {
            return _buildErrorState(state.message);
          }

          if (state is ReferralLoaded) {
            return _buildLoadedState(state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF3B82F6)),
          SizedBox(height: 16.h),
          Text(
            'Loading referral data...',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.read<ReferralCubit>().loadDashboard(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(ReferralLoaded state) {
    final cubit = context.read<ReferralCubit>();

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // Referral Code Card
            ReferralCodeCard(
              code: state.myCode.code,
              onCopy: () => cubit.copyReferralCode(state.myCode.code),
              onShare: () => cubit.shareReferralCode(
                state.myCode.code,
                currency: state.stats.currency,
              ),
            ),

            // LazerPoints quick access card
            _buildLazerPointsCard(),

            // How It Works
            const HowItWorksCard(),

            // Stats
            ReferralStatsCard(
              totalReferrals: state.stats.totalReferrals,
              totalRewardsEarned: state.stats.totalRewardsEarned,
              pendingRewards: state.stats.pendingRewards,
              currency: state.stats.currency,
            ),

            // Leaderboard
            if (state.leaderboard.isNotEmpty)
              LeaderboardList(
                entries: state.leaderboard,
                currentUserId: state.myCode.userId,
              ),

            // Recent Referrals with "View All" header
            _buildRecentReferralsSection(state),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLazerPointsCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.lazerPoints),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.stars_rounded,
                  color: Colors.white, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LazerPoints',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Earn points for referrals, transactions & more',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.7), size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentReferralsSection(ReferralLoaded state) {
    return Column(
      children: [
        // Header with "View All" button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Referrals',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.allReferrals),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
        ),
        RecentReferralsList(
          referrals: state.recentReferrals,
          currency: state.stats.currency,
        ),
      ],
    );
  }
}
