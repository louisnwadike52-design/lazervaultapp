import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../cubit/leaderboard_cubit.dart';
import '../cubit/leaderboard_state.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class CrowdfundHomeScreen extends StatefulWidget {
  const CrowdfundHomeScreen({super.key});

  @override
  State<CrowdfundHomeScreen> createState() => _CrowdfundHomeScreenState();
}

class _CrowdfundHomeScreenState extends State<CrowdfundHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Data loading is triggered by the route's BlocProvider (..loadCrowdfunds())
    // Only reload if the cubit is in initial state (no data loaded yet)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<CrowdfundCubit>();
      final state = cubit.state;
      if (state is CrowdfundInitial) {
        cubit.loadCrowdfunds();
      }
      // Also load my campaigns and donations for the dashboard
      cubit.loadMyCrowdfunds();
      cubit.loadUserDonations();
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
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<CrowdfundCubit>().loadCrowdfunds();
                },
                color: const Color(0xFF6366F1),
                backgroundColor: const Color(0xFF1F1F1F),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Metrics hero — big and prominent at the top.
                      _buildMetricsCard(context),
                      SizedBox(height: 20.h),
                      _buildActionButtons(context),
                      // Each section below owns its own leading 24h spacer
                      // (rendered only when the section actually paints), so
                      // collapsing My Campaigns / My Donations doesn't leave
                      // a doubled gap between Action Buttons and Leaderboard.
                      _buildMyCampaignsSection(context),
                      _buildMyDonationsSection(context),
                      // Leaderboard preview — always visible so the page has
                      // a third "anchor" between the user's data and the
                      // platform-wide active campaigns list at the bottom.
                      _buildLeaderboardPreview(context),
                      SizedBox(height: 24.h),
                      _buildRecentActivity(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(19.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Crowdfund',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'crowdfund',
            iconColor: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF6366F1),
          ),
          SizedBox(width: 8.w),
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
      height: 168.h,
      padding: EdgeInsets.all(20.w),
      decoration: _heroDecoration,
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFF6366F1)),
      ),
    );
  }

  // Shared hero card decoration — used by loading, loaded, and empty
  // states so they share the same footprint and the section doesn't jump
  // height while data resolves.
  static const BoxDecoration _heroDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  Widget _buildMetricsContent(CrowdfundLoaded state) {
    final totalCrowdfunds = state.crowdfunds.length;
    final activeCrowdfunds = state.crowdfunds.where((c) => c.isActive).length;
    final totalRaised = state.crowdfunds.fold<double>(
      0.0,
      (sum, crowdfund) => sum + crowdfund.currentAmount,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 18.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top row: icon + title.
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.volunteer_activism,
                  size: 18.sp,
                  color: const Color(0xFF6366F1),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Total Raised',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Hero amount.
          Text(
            CurrencySymbols.formatAmount(totalRaised),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          SizedBox(height: 14.h),
          // Sub-metrics: Total + Active campaigns side-by-side.
          Row(
            children: [
              Expanded(
                child: _buildSubMetric(
                  icon: Icons.campaign_outlined,
                  label: 'Total',
                  value: totalCrowdfunds.toString(),
                ),
              ),
              Container(
                width: 1,
                height: 32.h,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              Expanded(
                child: _buildSubMetric(
                  icon: Icons.bolt,
                  label: 'Active',
                  value: activeCrowdfunds.toString(),
                  accent: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubMetric({
    required IconData icon,
    required String label,
    required String value,
    Color accent = const Color(0xFF6366F1),
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14.sp, color: accent),
        SizedBox(width: 6.w),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 28.sp, color: const Color(0xFFEF4444)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Failed to Load',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  message,
                  style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => context.read<CrowdfundCubit>().loadCrowdfunds(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text('Retry', style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMetricsCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 22.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.volunteer_activism,
              size: 26.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Crowdfunding',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Create your first campaign or fund one with a link',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add_circle_outline,
            label: 'Create Campaign',
            color: const Color(0xFF6366F1),
            onTap: () => Get.toNamed(AppRoutes.createCrowdfund),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.favorite_outline,
            label: 'Fund a Campaign',
            color: const Color.fromARGB(255, 78, 3, 208),
            onTap: () => Get.toNamed(AppRoutes.crowdfundList),
          ),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: color.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp, color: color),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardPreview(BuildContext context) {
    return BlocProvider(
      // Always pull at least 5 so the preview can render 3+ items even
      // if the backend returns fewer than the limit. The leaderboard
      // route renders the full list with sort tabs.
      create: (_) => serviceLocator<LeaderboardCubit>()..loadLeaderboard(limit: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.local_fire_department,
                      color: const Color(0xFFFFD700),
                      size: 14.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Leaderboard',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.crowdfundLeaderboard),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          BlocBuilder<LeaderboardCubit, LeaderboardState>(
            builder: (context, state) {
              if (state is LeaderboardLoading) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1))),
                );
              }
              if (state is LeaderboardLoaded && state.entries.isNotEmpty) {
                return Column(
                  children: state.entries.map(_buildLeaderboardItem).toList(),
                );
              }
              if (state is LeaderboardError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      'Could not load leaderboard',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(LeaderboardEntry entry) {
    final crowdfund = entry.crowdfund;
    final rank = entry.rank;
    final Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0);
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32);
    } else {
      rankColor = const Color(0xFF6B7280);
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.crowdfundDetails, arguments: crowdfund.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: rank <= 3
                ? rankColor.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.04),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: rankColor.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: rank <= 3
                    ? Icon(Icons.emoji_events, color: rankColor, size: 14.sp)
                    : Text('#$rank', style: GoogleFonts.inter(color: rankColor, fontSize: 11.sp, fontWeight: FontWeight.w700)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crowdfund.title,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'by ${crowdfund.creator.displayName}',
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${CurrencySymbols.getSymbol(crowdfund.currency)}${crowdfund.currentAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 12.sp, fontWeight: FontWeight.w700),
                ),
                Text(
                  '${crowdfund.progressPercentage.toStringAsFixed(0)}%',
                  style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                ),
              ],
            ),
            SizedBox(width: 2.w),
            Icon(Icons.chevron_right, color: const Color(0xFF6B7280), size: 16.sp),
          ],
        ),
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
                _buildSectionHeading(
                  'Active Campaigns',
                  icon: Icons.bolt,
                ),
                if (state is CrowdfundLoaded && state.crowdfunds.isNotEmpty)
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.crowdfundList),
                    child: Text(
                      'View All',
                      style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            if (state is CrowdfundLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(24.h),
                  child: const CircularProgressIndicator(color: Color(0xFF6366F1)),
                ),
              )
            else if (state is CrowdfundError)
              _buildActivityError(state.message)
            else if (state is CrowdfundLoaded)
              state.crowdfunds.isEmpty
                  ? _buildEmptyActivity()
                  : Column(
                      children: state.crowdfunds.take(3).map((crowdfund) => _buildCrowdfundItem(crowdfund)).toList(),
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 28.sp, color: const Color(0xFFEF4444)),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(error, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp), maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => context.read<CrowdfundCubit>().loadCrowdfunds(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(8.r)),
              child: Text('Retry', style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyActivity() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.campaign_outlined, size: 36.sp, color: const Color(0xFF6B7280)),
            SizedBox(height: 8.h),
            Text(
              'No Active Campaigns',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            Text(
              'Create your first crowdfund or browse existing campaigns',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyCampaignsSection(BuildContext context) {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      buildWhen: (prev, curr) => curr is MyCrowdfundsLoaded || curr is CrowdfundLoading,
      builder: (context, state) {
        if (state is! MyCrowdfundsLoaded || state.crowdfunds.isEmpty) {
          return const SizedBox.shrink();
        }
        final campaigns = state.crowdfunds;
        // Leading spacer is rendered here so the section's slot in the
        // page only takes vertical space when there's actually content.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeading(
                  'My Campaigns',
                  icon: Icons.campaign_outlined,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.crowdfundMyCampaigns),
                  child: Text('View All', style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ...campaigns.take(3).map((c) => _buildMyCampaignItem(c)),
          ],
        );
      },
    );
  }

  // Reusable section heading so titles look consistent across the page.
  Widget _buildSectionHeading(String label, {required IconData icon}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: const Color(0xFF6366F1), size: 14.sp),
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildMyCampaignItem(Crowdfund campaign) {
    final progress = campaign.progressPercentage;
    final statusColor = campaign.isActive
        ? const Color(0xFF10B981)
        : campaign.status == CrowdfundStatus.completed
            ? const Color(0xFF6366F1)
            : const Color(0xFF9CA3AF);
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.crowdfundDetails, arguments: campaign.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w, height: 36.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.campaign_outlined, color: statusColor, size: 18.sp),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(campaign.title, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 3.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: LinearProgressIndicator(
                      value: (progress / 100).clamp(0.0, 1.0),
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      minHeight: 3.h,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${CurrencySymbols.getSymbol(campaign.currency)}${campaign.currentAmount.toStringAsFixed(0)} / ${CurrencySymbols.getSymbol(campaign.currency)}${campaign.targetAmount.toStringAsFixed(0)} \u2022 ${progress.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: const Color(0xFF6B7280), size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildMyDonationsSection(BuildContext context) {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      buildWhen: (prev, curr) => curr is UserDonationsLoaded || curr is CrowdfundLoading,
      builder: (context, state) {
        if (state is! UserDonationsLoaded || state.donations.isEmpty) {
          return const SizedBox.shrink();
        }
        final donations = state.donations;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeading('My Donations', icon: Icons.favorite_outline),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.crowdfundMyDonations),
                  child: Text('View All', style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ...donations.take(3).map((d) => _buildDonationItem(d)),
          ],
        );
      },
    );
  }

  Widget _buildDonationItem(CrowdfundDonation donation) {
    final statusColor = donation.status == DonationStatus.completed
        ? const Color(0xFF10B981)
        : donation.status == DonationStatus.pending
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444);
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w, height: 32.w,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.favorite, color: statusColor, size: 16.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(donation.donor.displayName, style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(donation.message ?? donation.donationDate.toString().substring(0, 10),
                  style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text(
            '${CurrencySymbols.getSymbol(donation.currency)}${donation.amount.toStringAsFixed(0)}',
            style: GoogleFonts.inter(color: statusColor, fontSize: 13.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildCrowdfundItem(Crowdfund crowdfund) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.crowdfundDetails, arguments: crowdfund.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          crowdfund.title,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (crowdfund.creator.verified)
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Icon(Icons.verified, size: 14.sp, color: const Color(0xFF10B981)),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'by ${crowdfund.creator.firstName} ${crowdfund.creator.lastName}',
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                  ),
                  SizedBox(height: 6.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: LinearProgressIndicator(
                      value: (crowdfund.progressPercentage / 100).clamp(0.0, 1.0),
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                      minHeight: 4.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${CurrencySymbols.getSymbol(crowdfund.currency)}${crowdfund.currentAmount.toStringAsFixed(0)} raised',
                        style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'of ${CurrencySymbols.getSymbol(crowdfund.currency)}${crowdfund.targetAmount.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: const Color(0xFF6B7280), size: 18.sp),
          ],
        ),
      ),
    );
  }
}
