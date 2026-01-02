import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    // Load dashboard data when screen opens
    context.read<ReferralCubit>().loadDashboard();
  }

  Future<void> _onRefresh() async {
    await context.read<ReferralCubit>().refreshDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Referral Program'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
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

          // Initial state
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
          const CircularProgressIndicator(
            color: Color(0xFF4E03D0),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading referral data...',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
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
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.read<ReferralCubit>().loadDashboard(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
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
      color: const Color(0xFF4E03D0),
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

            // Recent Referrals
            RecentReferralsList(
              referrals: state.recentReferrals,
              currency: state.stats.currency,
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
