import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/leaderboard_cubit.dart';
import '../cubit/leaderboard_state.dart';
import '../widgets/leaderboard_crowdfund_card.dart';
import '../widgets/leaderboard_loading_skeleton.dart';
import '../widgets/campaign_quick_view_bottom_sheet.dart';

class CrowdfundLeaderboardScreen extends StatefulWidget {
  const CrowdfundLeaderboardScreen({super.key});

  @override
  State<CrowdfundLeaderboardScreen> createState() =>
      _CrowdfundLeaderboardScreenState();
}

class _CrowdfundLeaderboardScreenState
    extends State<CrowdfundLeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _tabDebounceTimer;

  static const _tabs = [
    'Trending',
    'Most Funded',
    'Most Donors',
    'Newest',
  ];

  static const _sortValues = [
    LeaderboardSortBy.trending,
    LeaderboardSortBy.mostFunded,
    LeaderboardSortBy.mostDonors,
    LeaderboardSortBy.newest,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLeaderboard(_sortValues[0]);
    });
  }

  @override
  void dispose() {
    _tabDebounceTimer?.cancel();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    _tabDebounceTimer?.cancel();
    _tabDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      _loadLeaderboard(_sortValues[_tabController.index]);
    });
  }

  void _loadLeaderboard(LeaderboardSortBy sortBy) {
    context.read<LeaderboardCubit>().loadLeaderboard(sortBy: sortBy);
  }

  Future<void> _onRefresh() async {
    _loadLeaderboard(_sortValues[_tabController.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            _buildStaleIndicator(),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
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
            child: Text(
              'Leaderboard',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        tabs: _tabs.map((label) => Tab(text: label)).toList(),
      ),
    );
  }

  Widget _buildStaleIndicator() {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoaded && state.isStale) {
          return const LinearProgressIndicator(
            minHeight: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            backgroundColor: Color(0xFF1F1F1F),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent() {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: const LeaderboardLoadingSkeleton(),
          );
        }

        if (state is LeaderboardError) {
          return _buildErrorState(state.message);
        }

        if (state is LeaderboardLoaded) {
          if (state.entries.isEmpty) {
            return _buildEmptyState();
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: state.entries.length,
              itemBuilder: (context, index) {
                final entry = state.entries[index];
                return LeaderboardCrowdfundCard(
                  entry: entry,
                  onTap: () => CampaignQuickViewBottomSheet.show(
                    context,
                    entry.crowdfund,
                  ),
                );
              },
            ),
          );
        }

        // Default / initial state
        return _buildEmptyState();
      },
    );
  }

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 40.h),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: _onRefresh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(36.r),
                  ),
                  child: Icon(
                    Icons.emoji_events_outlined,
                    size: 32.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No crowdfunds found',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Check back soon for leaderboard updates',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
