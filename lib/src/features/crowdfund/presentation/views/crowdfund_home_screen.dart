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

  /// Force-pop the entire crowdfund sub-stack and land on the main
  /// app dashboard. Plain Get.back gets stuck after the user has
  /// drilled through several screens (campaign list → details →
  /// donate → receipt → home), because each push left a route on
  /// the stack. Same fix as the autosave dashboard.
  void _exitToDashboard() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.popUntil((r) =>
          r.isFirst ||
          r.settings.name == AppRoutes.dashboard ||
          r.settings.name == AppRoutes.home);
    }
    if (Get.currentRoute != AppRoutes.dashboard &&
        Get.currentRoute != AppRoutes.home) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  /// Refresh every data source the landing page renders so a single
  /// pull on the page brings the metrics card, my campaigns, my
  /// donations, leaderboard, and the active campaigns list all in
  /// sync. Previously only the global crowdfund list was refreshed.
  Future<void> _refreshAll() async {
    final cubit = context.read<CrowdfundCubit>();
    cubit.loadCrowdfunds();
    cubit.loadMyCrowdfunds();
    cubit.loadUserDonations();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Hardware-back also flushes the sub-stack rather than popping
      // a single (often-orphaned) route.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _exitToDashboard();
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshAll,
                color: const Color(0xFF4E03D0),
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            // Always exit the sub-stack — see _exitToDashboard for why
            // a plain Get.back was getting stuck after several pushes.
            onTap: _exitToDashboard,
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
            iconColor: const Color(0xFF4E03D0),
            backgroundColor: const Color(0xFF4E03D0),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Crowdfund',
            sourceContext: 'financial_products',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF4E03D0),
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
        child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
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
    final fundedCount = state.crowdfunds
        .where((c) => c.targetAmount > 0 && c.currentAmount >= c.targetAmount)
        .length;
    final avgPerCampaign = totalCrowdfunds > 0
        ? totalRaised / totalCrowdfunds
        : 0.0;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 18.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.volunteer_activism,
                  size: 18.sp,
                  color: const Color(0xFF4E03D0),
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
          Row(
            children: [
              Expanded(
                child: _buildSubMetric(
                  icon: Icons.campaign_outlined,
                  label: 'Total',
                  value: totalCrowdfunds.toString(),
                ),
              ),
              _buildSubMetricDivider(),
              Expanded(
                child: _buildSubMetric(
                  icon: Icons.bolt,
                  label: 'Active',
                  value: activeCrowdfunds.toString(),
                  accent: const Color(0xFF10B981),
                ),
              ),
              _buildSubMetricDivider(),
              Expanded(
                child: _buildSubMetric(
                  icon: Icons.verified_outlined,
                  label: 'Funded',
                  value: fundedCount.toString(),
                  accent: const Color(0xFFF59E0B),
                ),
              ),
              _buildSubMetricDivider(),
              Expanded(
                child: _buildSubMetric(
                  icon: Icons.trending_up,
                  label: 'Avg',
                  value: CurrencySymbols.formatAmount(avgPerCampaign),
                  accent: const Color(0xFF38BDF8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubMetricDivider() => Container(
        width: 1,
        height: 32.h,
        color: Colors.white.withValues(alpha: 0.08),
      );

  Widget _buildSubMetric({
    required IconData icon,
    required String label,
    required String value,
    Color accent = const Color(0xFF4E03D0),
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14.sp, color: accent),
        SizedBox(height: 4.h),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            maxLines: 1,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 10.sp,
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
                color: const Color(0xFF4E03D0),
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.volunteer_activism,
              size: 26.sp,
              color: const Color(0xFF4E03D0),
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
    // Three lanes side-by-side, mirroring the autosave dashboard CTA
    // row. Splits the user-driven actions cleanly:
    //   Create     — start a new campaign
    //   Browse     — fund any campaign (was "Fund a Campaign")
    //   My Activity — quick jump to my campaigns + donations
    // The third CTA replaces the buried "View All" links by giving
    // the user a one-tap route to their own activity from the top.
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add_circle_outline,
            label: 'Create',
            color: const Color(0xFF4E03D0),
            onTap: () => Get.toNamed(AppRoutes.createCrowdfund),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.favorite_outline,
            label: 'Browse',
            color: const Color(0xFF10B981),
            onTap: () => Get.toNamed(AppRoutes.crowdfundList),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.bar_chart_outlined,
            label: 'My Activity',
            color: const Color(0xFFFB923C),
            onTap: () => Get.toNamed(AppRoutes.crowdfundMyCampaigns),
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
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
        decoration: BoxDecoration(
          // Elevation in place of border — matches the autosave list
          // card pattern. The accent colour bleeds into the shadow so
          // each lane keeps its own identity without a flat stroke.
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.22),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22.sp, color: color),
            SizedBox(height: 6.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                  style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 13.sp, fontWeight: FontWeight.w600),
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
                  child: const Center(child: CircularProgressIndicator(color: Color(0xFF4E03D0))),
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
                  style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 12.sp, fontWeight: FontWeight.w700),
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
                      style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            if (state is CrowdfundLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(24.h),
                  child: const CircularProgressIndicator(color: Color(0xFF4E03D0)),
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
              decoration: BoxDecoration(color: const Color(0xFF4E03D0), borderRadius: BorderRadius.circular(8.r)),
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
        if (state is! MyCrowdfundsLoaded) {
          return const SizedBox.shrink();
        }
        final campaigns = state.crowdfunds;
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
                if (campaigns.isNotEmpty)
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.crowdfundMyCampaigns),
                    child: Text('View All', style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            if (campaigns.isEmpty)
              _buildSectionEmpty(
                icon: Icons.campaign_outlined,
                title: 'No campaigns yet',
                subtitle: 'Create one to start raising funds.',
                ctaLabel: 'Create campaign',
                onTap: () => Get.toNamed(AppRoutes.createCrowdfund),
              )
            else
              ...campaigns.take(3).map((c) => _buildMyCampaignItem(c)),
          ],
        );
      },
    );
  }

  Widget _buildSectionEmpty({
    required IconData icon,
    required String title,
    required String subtitle,
    required String ctaLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 18.sp, color: const Color(0xFF4E03D0)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 2.h),
                  Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                ctaLabel,
                style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 11.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable section heading so titles look consistent across the page.
  Widget _buildSectionHeading(String label, {required IconData icon}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: const Color(0xFF4E03D0), size: 14.sp),
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
            ? const Color(0xFF4E03D0)
            : const Color(0xFF9CA3AF);
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.crowdfundDetails, arguments: campaign.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          // Elevation in place of border for visual continuity with
          // the autosave list cards. Subtle indigo glow keeps the
          // crowdfund accent without a flat stroke.
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color:
                  const Color(0xFF4E03D0).withValues(alpha: 0.18),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
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
        if (state is! UserDonationsLoaded) {
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
                if (donations.isNotEmpty)
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.crowdfundMyDonations),
                    child: Text('View All', style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            if (donations.isEmpty)
              _buildSectionEmpty(
                icon: Icons.favorite_outline,
                title: 'No donations yet',
                subtitle: 'Browse open campaigns and pledge to a cause.',
                ctaLabel: 'Browse',
                onTap: () => Get.toNamed(AppRoutes.crowdfundList),
              )
            else
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
    final statusLabel = donation.status == DonationStatus.completed
        ? 'Completed'
        : donation.status == DonationStatus.pending
            ? 'Pending'
            : donation.status == DonationStatus.processing
                ? 'Processing'
                : 'Failed';
    final primary = (donation.message != null && donation.message!.trim().isNotEmpty)
        ? donation.message!.trim()
        : 'Donation';
    final dateLabel =
        '${donation.donationDate.year.toString().padLeft(4, '0')}-'
        '${donation.donationDate.month.toString().padLeft(2, '0')}-'
        '${donation.donationDate.day.toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.crowdfundDetails, arguments: donation.crowdfundId),
      child: Container(
        margin: EdgeInsets.only(bottom: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
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
                  Text(primary,
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(statusLabel,
                          style: GoogleFonts.inter(color: statusColor, fontSize: 10.sp, fontWeight: FontWeight.w600)),
                      Text('  ·  ',
                          style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 10.sp)),
                      Flexible(
                        child: Text(dateLabel,
                            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '${CurrencySymbols.getSymbol(donation.currency)}${donation.amount.toStringAsFixed(0)}',
              style: GoogleFonts.inter(color: statusColor, fontSize: 13.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
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
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
                      minHeight: 4.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${CurrencySymbols.getSymbol(crowdfund.currency)}${crowdfund.currentAmount.toStringAsFixed(0)} raised',
                        style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 12.sp, fontWeight: FontWeight.w600),
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
