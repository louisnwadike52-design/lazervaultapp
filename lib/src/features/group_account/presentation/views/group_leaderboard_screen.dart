import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class GroupLeaderboardScreen extends StatefulWidget {
  const GroupLeaderboardScreen({super.key});

  @override
  State<GroupLeaderboardScreen> createState() => _GroupLeaderboardScreenState();
}

class _GroupLeaderboardScreenState extends State<GroupLeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _tabDebounceTimer;

  static const _tabs = [
    'Most Members',
    'Most Active',
    'Newest',
  ];

  static const _sortValues = [
    'most_members',
    'most_active',
    'newest',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadGroups(_sortValues[0]);
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
    if (!_tabController.indexIsChanging) return;
    _tabDebounceTimer?.cancel();
    _tabDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      _loadGroups(_sortValues[_tabController.index]);
    });
  }

  void _loadGroups(String sortBy) {
    context.read<GroupAccountCubit>().loadPublicGroups(sortBy: sortBy);
  }

  Future<void> _onRefresh() async {
    _loadGroups(_sortValues[_tabController.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Group Leaderboard',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF3B82F6),
          indicatorWeight: 2.5,
          labelColor: const Color(0xFF3B82F6),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          tabs: _tabs.map((label) => Tab(text: label)).toList(),
        ),
      ),
      body: BlocConsumer<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is GroupAccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GroupAccountLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (state is GroupAccountError) {
            return _buildErrorState(state.message);
          }

          if (state is PublicGroupsLoaded) {
            if (state.groups.isEmpty) {
              return _buildEmptyState();
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
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      itemCount: state.groups.length,
                      itemBuilder: (context, index) {
                        final group = state.groups[index];
                        return _buildLeaderboardEntry(group, index + 1);
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildLeaderboardEntry(GroupAccount group, int rank) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: rank <= 3
            ? Border.all(
                color: _getRankColor(rank).withValues(alpha: 0.3),
                width: 1,
              )
            : null,
      ),
      child: Row(
        children: [
          // Rank badge
          _buildRankBadge(rank),
          SizedBox(width: 12.w),
          // Group avatar
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3B82F6),
                  const Color(0xFF3B82F6).withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                group.name.isNotEmpty ? group.name[0].toUpperCase() : 'G',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group name
                Text(
                  group.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                // Stats row
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: const Color(0xFF9CA3AF),
                      size: 13.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${group.memberCount} members',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: const Color(0xFF9CA3AF),
                      size: 13.sp,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        '\$${group.totalRaised.toStringAsFixed(2)} collected',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: _getRankColor(rank).withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: rank <= 3
            ? Icon(
                Icons.emoji_events,
                color: _getRankColor(rank),
                size: 18.sp,
              )
            : Text(
                '#$rank',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
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
            message,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
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
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.leaderboard_outlined,
                size: 56.sp,
                color: const Color(0xFF9CA3AF),
              ),
              SizedBox(height: 16.h),
              Text(
                'No groups found',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }
}
