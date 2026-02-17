import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/group_card.dart';
import '../widgets/create_group_bottom_sheet.dart';
import '../widgets/public_group_detail_bottom_sheet.dart';
import '../../../presentation/views/dashboard/dashboard_screen.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class GroupAccountListScreen extends StatefulWidget {
  const GroupAccountListScreen({super.key});

  @override
  State<GroupAccountListScreen> createState() => _GroupAccountListScreenState();
}

class _GroupAccountListScreenState extends State<GroupAccountListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _userIdSet = false;
  bool _navigatedToDetails = false;

  // Discover tab state
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.search();
  final Set<String> _joiningGroupIds = {};
  final Set<String> _joinedGroupIds = {};
  String _selectedSort = 'most_members';

  // Leaderboard tab state
  Timer? _leaderboardDebounceTimer;
  int _leaderboardTabIndex = 0;

  // My Groups tab state
  int _myGroupsTabIndex = 0; // 0 = Private, 1 = Public
  final TextEditingController _myGroupsSearchController = TextEditingController();
  String _myGroupsSearchQuery = '';

  static const _sortOptions = {
    'most_members': 'Most Members',
    'most_active': 'Most Active',
    'newest': 'Newest',
  };

  static const _leaderboardTabs = [
    'Most Members',
    'Most Active',
    'Newest',
  ];

  static const _leaderboardSortValues = [
    'most_members',
    'most_active',
    'newest',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserIdIfAuthenticated();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.dispose();
    _myGroupsSearchController.dispose();
    _debouncer.dispose();
    _leaderboardDebounceTimer?.cancel();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final cubit = context.read<GroupAccountCubit>();
    switch (_tabController.index) {
      case 0:
        // My Groups tab - restore cached groups
        cubit.restoreGroupsListState();
        break;
      case 1:
        // Discover tab - load public groups
        cubit.loadPublicGroups(sortBy: _selectedSort);
        break;
      case 2:
        // Leaderboard tab - load leaderboard
        cubit.loadPublicGroups(
            sortBy: _leaderboardSortValues[_leaderboardTabIndex]);
        break;
    }
  }

  void _initializeUserIdIfAuthenticated() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess && !_userIdSet) {
      _userIdSet = true;
      final user = authState.profile.user;
      context.read<GroupAccountCubit>().setUserId(
        user.id,
        userName: '${user.firstName} ${user.lastName}'.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthenticationSuccess && !_userIdSet) {
          _userIdSet = true;
          final user = authState.profile.user;
          context.read<GroupAccountCubit>().setUserId(
            user.id,
            userName: '${user.firstName} ${user.lastName}'.trim(),
          );
        }
      },
      builder: (context, authState) {
        if (authState is! AuthenticationSuccess) {
          return _buildAuthLoadingScreen();
        }
        return _buildGroupAccountScreen();
      },
    );
  }

  Widget _buildAuthLoadingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildMyGroupsLoadingView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupAccountScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMyGroupsTab(),
                  _buildDiscoverTab(),
                  _buildLeaderboardTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAll(() => const DashboardScreen()),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Group Funds',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Manage & discover group contributions',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          MicroserviceChatIcon(
            serviceName: 'Joint Funds',
            sourceContext: 'group_accounts',
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
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: const Color.fromARGB(255, 78, 3, 208),
          borderRadius: BorderRadius.circular(12.r),
        ),
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
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.groups, size: 16.sp),
                SizedBox(width: 6.w),
                Text('My Groups'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.explore, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Discover'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.leaderboard, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Leaderboard'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _showCreateGroupBottomSheet(),
      backgroundColor: const Color.fromARGB(255, 78, 3, 208),
      foregroundColor: Colors.white,
      icon: Icon(Icons.add, size: 20.sp),
      label: Text(
        'Create Group',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ===========================================================================
  // MY GROUPS TAB
  // ===========================================================================

  Widget _buildMyGroupsTab() {
    return BlocConsumer<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is GroupAccountError && _tabController.index == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is GroupAccountGroupCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Group created successfully'),
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<GroupAccountCubit>().loadUserGroups();
        }
      },
      buildWhen: (previous, current) {
        return current is GroupAccountGroupsLoaded ||
            current is GroupAccountLoading ||
            current is GroupAccountInitial ||
            (current is GroupAccountError && _tabController.index == 0);
      },
      builder: (context, state) {
        final cubit = context.read<GroupAccountCubit>();

        if (state is GroupAccountLoading || state is GroupAccountInitial) {
          return _buildMyGroupsLoadingView();
        }

        if (state is GroupAccountGroupsLoaded) {
          return _buildMyGroupsList(state.groups);
        }

        if (state is GroupAccountError && _tabController.index == 0) {
          return _buildMyGroupsErrorView(state.message);
        }

        // Use cached groups for any other state
        final cachedGroups = cubit.cachedGroups;
        if (cachedGroups != null && cachedGroups.isNotEmpty) {
          return _buildMyGroupsList(cachedGroups);
        }

        return _buildMyGroupsEmptyView();
      },
    );
  }

  Widget _buildMyGroupsLoadingView() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadUserGroups();
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            sliver: SliverToBoxAdapter(
              child: _buildStatsCard(null),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading your groups...',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyGroupsList(List<GroupAccount> groups) {
    if (groups.isEmpty) {
      return _buildMyGroupsEmptyView();
    }

    final privateGroups =
        groups.where((g) => g.visibility == GroupVisibility.private).toList();
    final publicGroups =
        groups.where((g) => g.visibility == GroupVisibility.public).toList();

    // Filter by search query
    final query = _myGroupsSearchQuery.toLowerCase();
    final filteredGroups = _myGroupsTabIndex == 0 ? privateGroups : publicGroups;
    final displayGroups = query.isEmpty
        ? filteredGroups
        : filteredGroups
            .where((g) =>
                g.name.toLowerCase().contains(query) ||
                g.description.toLowerCase().contains(query))
            .toList();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadUserGroups();
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            sliver: SliverToBoxAdapter(
              child: _buildStatsCard(groups),
            ),
          ),
          // Private / Public tabs (bottom-line style like leaderboard)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  _buildMyGroupsSubTab(
                    label: 'Private (${privateGroups.length})',
                    icon: Icons.lock_outline,
                    index: 0,
                  ),
                  SizedBox(width: 4.w),
                  _buildMyGroupsSubTab(
                    label: 'Public (${publicGroups.length})',
                    icon: Icons.public,
                    index: 1,
                  ),
                ],
              ),
            ),
          ),
          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 6.h),
              child: SizedBox(
                height: 40.h,
                child: TextField(
                  controller: _myGroupsSearchController,
                  onChanged: (value) {
                    setState(() => _myGroupsSearchQuery = value.trim());
                  },
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search ${_myGroupsTabIndex == 0 ? 'private' : 'public'} groups...',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color(0xFF9CA3AF),
                      size: 18.sp,
                    ),
                    suffixIcon: _myGroupsSearchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _myGroupsSearchController.clear();
                              setState(() => _myGroupsSearchQuery = '');
                            },
                            icon: Icon(
                              Icons.close,
                              color: const Color(0xFF9CA3AF),
                              size: 16.sp,
                            ),
                            padding: EdgeInsets.zero,
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 3, 208),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Groups list
          if (displayGroups.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      query.isNotEmpty ? Icons.search_off : (_myGroupsTabIndex == 0 ? Icons.lock_outline : Icons.public),
                      size: 40.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      query.isNotEmpty
                          ? 'No groups match "$_myGroupsSearchQuery"'
                          : 'No ${_myGroupsTabIndex == 0 ? 'private' : 'public'} groups yet',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final group = displayGroups[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GroupCard(
                        group: group,
                        onTap: () => _navigateToGroupDetails(group),
                      ),
                    );
                  },
                  childCount: displayGroups.length,
                ),
              ),
            ),
          SliverPadding(padding: EdgeInsets.only(bottom: 80.h)),
        ],
      ),
    );
  }

  Widget _buildMyGroupsSubTab({
    required String label,
    required IconData icon,
    required int index,
  }) {
    final isSelected = _myGroupsTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _myGroupsTabIndex = index;
            _myGroupsSearchController.clear();
            _myGroupsSearchQuery = '';
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color.fromARGB(255, 78, 3, 208)
                    : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14.sp,
                color: isSelected
                    ? const Color.fromARGB(255, 78, 3, 208)
                    : const Color(0xFF9CA3AF),
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? const Color.fromARGB(255, 78, 3, 208)
                      : const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(List<GroupAccount>? groups) {
    final totalGroups = groups?.length ?? 0;
    final activeGroups =
        groups?.where((g) => g.status == GroupAccountStatus.active).length ?? 0;
    final totalContributions =
        groups?.fold<int>(0, (sum, g) => sum + g.contributions.length) ?? 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color:
                const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              title: 'Groups',
              value: totalGroups.toString(),
              icon: Icons.group,
            ),
          ),
          Container(
            width: 1,
            height: 36.h,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              title: 'Active',
              value: activeGroups.toString(),
              icon: Icons.check_circle_outline,
            ),
          ),
          Container(
            width: 1,
            height: 36.h,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              title: 'Goals',
              value: totalContributions.toString(),
              icon: Icons.account_balance_wallet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.8),
              size: 14.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 10.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMyGroupsEmptyView() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadUserGroups();
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            sliver: SliverToBoxAdapter(
              child: _buildStatsCard(null),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208)
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.groups,
                        size: 48.sp,
                        color: const Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'No Groups Yet',
                      style: GoogleFonts.inter(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Create a group or discover public groups to join and contribute with others.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _showCreateGroupBottomSheet(),
                          icon: Icon(Icons.add, size: 18.sp),
                          label: Text(
                            'Create',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 78, 3, 208),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        OutlinedButton.icon(
                          onPressed: () {
                            _tabController.animateTo(1);
                          },
                          icon: Icon(Icons.explore, size: 18.sp),
                          label: Text(
                            'Discover',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF3B82F6),
                            side: const BorderSide(color: Color(0xFF3B82F6)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 80.h)),
        ],
      ),
    );
  }

  Widget _buildMyGroupsErrorView(String message) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadUserGroups();
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            sliver: SliverToBoxAdapter(
              child: _buildStatsCard(null),
            ),
          ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Oops! Something went wrong',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GroupAccountCubit>().loadUserGroups();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(bottom: 80.h)),
      ],
      ),
    );
  }

  // ===========================================================================
  // DISCOVER TAB
  // ===========================================================================

  Widget _buildDiscoverTab() {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: 'Search public groups...',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                      icon: Icon(
                        Icons.close,
                        color: const Color(0xFF9CA3AF),
                        size: 18.sp,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF2D2D2D),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF3B82F6),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        // Sort chips
        SizedBox(
          height: 40.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: _sortOptions.entries.map((entry) {
              final isSelected = entry.key == _selectedSort;
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () => _onSortChanged(entry.key),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      entry.value,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8.h),
        // Groups list
        Expanded(
          child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
            listener: (context, state) {
              if (state is JoinPublicGroupSuccess) {
                setState(() {
                  _joinedGroupIds.add(state.group.id);
                  _joiningGroupIds.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: const Color(0xFF10B981),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
                _onDiscoverRefresh();
              } else if (state is GroupAccountError &&
                  _joiningGroupIds.isNotEmpty) {
                setState(() => _joiningGroupIds.clear());
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
            buildWhen: (previous, current) {
              return current is PublicGroupsLoaded ||
                  (current is GroupAccountLoading && _tabController.index == 1);
            },
            builder: (context, state) {
              if (state is GroupAccountLoading && _tabController.index == 1) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                  ),
                );
              }

              if (state is PublicGroupsLoaded) {
                if (state.groups.isEmpty) {
                  return _buildDiscoverEmptyState();
                }
                return Column(
                  children: [
                    if (state.isStale)
                      const LinearProgressIndicator(
                        minHeight: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF3B82F6)),
                        backgroundColor: Color(0xFF1F1F1F),
                      ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onDiscoverRefresh,
                        color: const Color(0xFF3B82F6),
                        backgroundColor: const Color(0xFF1F1F1F),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          itemCount: state.groups.length,
                          itemBuilder: (context, index) {
                            final group = state.groups[index];
                            return _buildDiscoverGroupCard(group);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }

              return _buildDiscoverEmptyState();
            },
          ),
        ),
      ],
    );
  }

  void _onSearchChanged(String query) {
    setState(() {}); // Rebuild to show/hide clear button
    _debouncer.run(() {
      context.read<GroupAccountCubit>().loadPublicGroups(
            search: query.trim().isEmpty ? null : query.trim(),
            sortBy: _selectedSort,
          );
    });
  }

  void _onSortChanged(String sort) {
    _debouncer.cancel();
    setState(() {
      _selectedSort = sort;
    });
    context.read<GroupAccountCubit>().loadPublicGroups(
          search: _searchController.text.trim().isEmpty
              ? null
              : _searchController.text.trim(),
          sortBy: sort,
        );
  }

  Future<void> _onDiscoverRefresh() async {
    context.read<GroupAccountCubit>().loadPublicGroups(
          search: _searchController.text.trim().isEmpty
              ? null
              : _searchController.text.trim(),
          sortBy: _selectedSort,
        );
  }

  Widget _buildDiscoverGroupCard(GroupAccount group) {
    return GestureDetector(
      onTap: () => PublicGroupDetailBottomSheet.show(context, group.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group avatar
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6),
                    const Color(0xFF3B82F6).withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  group.name.isNotEmpty
                      ? group.name[0].toUpperCase()
                      : 'G',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Group info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(height: 4.h),
                  Text(
                    group.description,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        color: const Color(0xFF9CA3AF),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${group.memberCount} members',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Join button
            _buildJoinButton(group),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinButton(GroupAccount group) {
    final isJoining = _joiningGroupIds.contains(group.id);
    // Check if user already belongs to this group
    final cachedGroups = context.read<GroupAccountCubit>().cachedGroups;
    final isAlreadyMember = _joinedGroupIds.contains(group.id) ||
        (cachedGroups != null && cachedGroups.any((g) => g.id == group.id));

    if (isAlreadyMember) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: const Color(0xFF10B981),
              size: 14.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              'Joined',
              style: GoogleFonts.inter(
                color: const Color(0xFF10B981),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: isJoining
          ? null
          : () {
              setState(() => _joiningGroupIds.add(group.id));
              context
                  .read<GroupAccountCubit>()
                  .joinPublicGroupById(group.id);
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isJoining
            ? SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Join',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildDiscoverEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.groups_outlined,
                size: 56.sp,
                color: const Color(0xFF9CA3AF),
              ),
              SizedBox(height: 16.h),
              Text(
                'No public groups found',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Try adjusting your search or filters',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // LEADERBOARD TAB
  // ===========================================================================

  Widget _buildLeaderboardTab() {
    return Column(
      children: [
        // Leaderboard sort tabs
        Container(
          margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Row(
            children: List.generate(_leaderboardTabs.length, (index) {
              final isSelected = index == _leaderboardTabIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onLeaderboardTabChanged(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                    ),
                    child: Text(
                      _leaderboardTabs[index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 8.h),
        // Leaderboard list
        Expanded(
          child: BlocBuilder<GroupAccountCubit, GroupAccountState>(
            buildWhen: (previous, current) {
              return current is PublicGroupsLoaded ||
                  (current is GroupAccountLoading && _tabController.index == 2) ||
                  (current is GroupAccountError && _tabController.index == 2);
            },
            builder: (context, state) {
              if (state is GroupAccountLoading && _tabController.index == 2) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                  ),
                );
              }

              if (state is GroupAccountError && _tabController.index == 2) {
                return _buildLeaderboardErrorState(state.message);
              }

              if (state is PublicGroupsLoaded) {
                if (state.groups.isEmpty) {
                  return _buildLeaderboardEmptyState();
                }
                return Column(
                  children: [
                    if (state.isStale)
                      const LinearProgressIndicator(
                        minHeight: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF3B82F6)),
                        backgroundColor: Color(0xFF1F1F1F),
                      ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onLeaderboardRefresh,
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

              return _buildLeaderboardEmptyState();
            },
          ),
        ),
      ],
    );
  }

  void _onLeaderboardTabChanged(int index) {
    _leaderboardDebounceTimer?.cancel();
    setState(() {
      _leaderboardTabIndex = index;
    });
    _leaderboardDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      context
          .read<GroupAccountCubit>()
          .loadPublicGroups(sortBy: _leaderboardSortValues[index]);
    });
  }

  Future<void> _onLeaderboardRefresh() async {
    context
        .read<GroupAccountCubit>()
        .loadPublicGroups(sortBy: _leaderboardSortValues[_leaderboardTabIndex]);
  }

  Widget _buildLeaderboardEntry(GroupAccount group, int rank) {
    return GestureDetector(
      onTap: () => PublicGroupDetailBottomSheet.show(context, group.id),
      child: Container(
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
                          '${CurrencySymbols.formatAmount(group.totalRaised)} collected',
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

  Widget _buildLeaderboardErrorState(String message) {
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
            onPressed: _onLeaderboardRefresh,
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

  Widget _buildLeaderboardEmptyState() {
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

  // ===========================================================================
  // SHARED HELPERS
  // ===========================================================================

  void _showCreateGroupBottomSheet() {
    final cubit = context.read<GroupAccountCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: const CreateGroupBottomSheet(),
      ),
    );
  }

  void _navigateToGroupDetails(GroupAccount group) {
    _navigatedToDetails = true;
    Get.toNamed(AppRoutes.groupDetails, arguments: group.id)?.then((_) {
      if (mounted && _navigatedToDetails) {
        _navigatedToDetails = false;
        context.read<GroupAccountCubit>().restoreGroupsListState();
      }
    });
  }
}
