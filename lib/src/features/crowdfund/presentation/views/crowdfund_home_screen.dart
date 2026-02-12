import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../cubit/leaderboard_cubit.dart';
import '../cubit/leaderboard_state.dart';
import '../widgets/leaderboard_preview_card.dart';
import '../widgets/campaign_quick_view_bottom_sheet.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class CrowdfundHomeScreen extends StatefulWidget {
  const CrowdfundHomeScreen({super.key});

  @override
  State<CrowdfundHomeScreen> createState() => _CrowdfundHomeScreenState();
}

class _CrowdfundHomeScreenState extends State<CrowdfundHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load crowdfund statistics
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CrowdfundCubit>().loadCrowdfunds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMetricsCard(context),
                    SizedBox(height: 24.h),
                    _buildActionButtons(context),
                    SizedBox(height: 32.h),
                    _buildLeaderboardPreview(context),
                    SizedBox(height: 32.h),
                    _buildRecentActivity(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crowdfund',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Render your support to crowdfunds',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          MicroserviceChatIcon(
            serviceName: 'Crowdfund',
            sourceContext: 'financial_products',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF6366F1),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsCard(BuildContext context) {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      builder: (context, state) {
        if (state is CrowdfundLoading) {
          return _buildLoadingCard();
        }

        if (state is CrowdfundLoaded) {
          return _buildMetricsContent(state);
        }

        if (state is CrowdfundError) {
          return _buildErrorCard(state.message);
        }

        return _buildEmptyMetricsCard();
      },
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A3E),
            Color(0xFF0A0E27),
            Color(0xFF0F0F23),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF6366F1)),
        ),
      ),
    );
  }

  Widget _buildMetricsContent(CrowdfundLoaded state) {
    final totalCrowdfunds = state.crowdfunds.length;
    final activeCrowdfunds = state.crowdfunds.where((c) => c.isActive).length;
    final totalRaised = state.crowdfunds.fold<double>(
      0.0,
      (sum, crowdfund) => sum + crowdfund.currentAmount,
    );

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A3E),
            Color(0xFF0A0E27),
            Color(0xFF0F0F23),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.volunteer_activism,
            size: 48.sp,
            color: const Color(0xFF6366F1),
          ),
          SizedBox(height: 16.h),
          Text(
            'Your Impact',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem(
                label: 'Total',
                value: totalCrowdfunds.toString(),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              _buildMetricItem(
                label: 'Active',
                value: activeCrowdfunds.toString(),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              _buildMetricItem(
                label: 'Raised',
                value: CurrencySymbols.formatAmount(totalRaised),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to Load',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMetricsCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A3E),
            Color(0xFF0A0E27),
            Color(0xFF0F0F23),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.volunteer_activism,
            size: 48.sp,
            color: const Color(0xFF6366F1),
          ),
          SizedBox(height: 16.h),
          Text(
            'Start Crowdfunding',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create or support crowdfund campaigns',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.add_circle_outline,
                label: 'Create Campaign',
                color: const Color(0xFF6366F1),
                onTap: () => Get.toNamed(AppRoutes.createCrowdfund),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildActionButton(
                icon: Icons.favorite_outline,
                label: 'Fund a Campaign',
                color: const Color(0xFF8B5CF6),
                onTap: () => Get.toNamed(AppRoutes.crowdfundList),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: color,
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardPreview(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<LeaderboardCubit>()..loadLeaderboard(limit: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: const Color(0xFFFFD700),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Leaderboard',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.crowdfundLeaderboard),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6366F1),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 210.h,
            child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
              builder: (context, state) {
                if (state is LeaderboardLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6366F1),
                    ),
                  );
                }

                if (state is LeaderboardLoaded && state.entries.isNotEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.entries.length,
                    itemBuilder: (context, index) {
                      return LeaderboardPreviewCard(
                        entry: state.entries[index],
                        onTap: () {
                          CampaignQuickViewBottomSheet.show(
                            context,
                            state.entries[index].crowdfund,
                          );
                        },
                      );
                    },
                  );
                }

                if (state is LeaderboardError) {
                  return Center(
                    child: Text(
                      'Could not load leaderboard',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Campaigns',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (state is CrowdfundLoaded && state.crowdfunds.isNotEmpty)
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.crowdfundList),
                    child: Text(
                      'View All',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),

            if (state is CrowdfundLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(32.h),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF6366F1)),
                  ),
                ),
              )
            else if (state is CrowdfundError)
              _buildActivityError(state.message)
            else if (state is CrowdfundLoaded)
              state.crowdfunds.isEmpty
                  ? _buildEmptyActivity()
                  : Column(
                      children: state.crowdfunds.take(3).map((crowdfund) {
                        return _buildCrowdfundItem(crowdfund);
                      }).toList(),
                    )
            else
              _buildEmptyActivity(),
          ],
        );
      },
    );
  }

  Widget _buildActivityError(String error) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to Load Campaigns',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              context.read<CrowdfundCubit>().loadCrowdfunds();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyActivity() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 48.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Active Campaigns',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Create your first crowdfund or browse existing campaigns',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrowdfundItem(dynamic crowdfund) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.crowdfundDetails,
        arguments: crowdfund.id,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    crowdfund.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (crowdfund.creator.verified)
                  Icon(
                    Icons.verified,
                    size: 18.sp,
                    color: const Color(0xFF10B981),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'by ${crowdfund.creator.firstName} ${crowdfund.creator.lastName}',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: crowdfund.progressPercentage / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
              minHeight: 6.h,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${CurrencySymbols.getSymbol(crowdfund.currency)}${crowdfund.currentAmount.toStringAsFixed(0)} raised',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6366F1),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'of ${CurrencySymbols.getSymbol(crowdfund.currency)}${crowdfund.targetAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
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
