import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/group_card.dart';
import '../widgets/create_group_bottom_sheet.dart';
import '../../../presentation/views/dashboard/dashboard_screen.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';

class GroupAccountListScreen extends StatefulWidget {
  const GroupAccountListScreen({super.key});

  @override
  State<GroupAccountListScreen> createState() => _GroupAccountListScreenState();
}

class _GroupAccountListScreenState extends State<GroupAccountListScreen> {
  bool _userIdSet = false;
  bool _navigatedToDetails = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserIdIfAuthenticated();
    });
  }

  void _initializeUserIdIfAuthenticated() {
    final authState = context.read<AuthenticationCubit>().state;
    print('🔵 GroupAccountListScreen: _initializeUserIdIfAuthenticated - authState: ${authState.runtimeType}, _userIdSet: $_userIdSet');
    if (authState is AuthenticationSuccess && !_userIdSet) {
      _userIdSet = true;
      print('🟢 GroupAccountListScreen: Setting userId: ${authState.profile.user.id}');
      context.read<GroupAccountCubit>().setUserId(authState.profile.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthenticationSuccess && !_userIdSet) {
          _userIdSet = true;
          context.read<GroupAccountCubit>().setUserId(authState.profile.user.id);
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
              Expanded(child: _buildLoadingView()),
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
            Expanded(child: _buildContent()),
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
                  'Group Accounts',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Manage your group contributions',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showOptionsMenu(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24.sp,
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

  Widget _buildContent() {
    return BlocConsumer<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is GroupAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is GroupAccountGroupCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Group created successfully'),
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<GroupAccountCubit>().loadUserGroups();
        }
      },
      builder: (context, state) {
        final cubit = context.read<GroupAccountCubit>();

        // Show loading for initial/loading states
        if (state is GroupAccountLoading || state is GroupAccountInitial) {
          return _buildLoadingView();
        }

        // Show groups list
        if (state is GroupAccountGroupsLoaded) {
          return _buildGroupsList(state.groups);
        }

        // Show error
        if (state is GroupAccountError) {
          return _buildErrorView(state.message);
        }

        // For any other state (like GroupAccountGroupLoaded from detail screen),
        // show cached groups if available, otherwise show loading and restore
        final cachedGroups = cubit.cachedGroups;
        if (cachedGroups != null && cachedGroups.isNotEmpty) {
          // Show cached groups - don't trigger any state changes from builder
          return _buildGroupsList(cachedGroups);
        }

        return _buildEmptyView();
      },
    );
  }

  Widget _buildLoadingView() {
    return Center(
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
    );
  }

  Widget _buildGroupsList(List<GroupAccount> groups) {
    if (groups.isEmpty) {
      return _buildEmptyView();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadUserGroups();
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsCard(groups),
                  SizedBox(height: 24.h),
                  Text(
                    'Your Groups (${groups.length})',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final group = groups[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: GroupCard(
                      group: group,
                      onTap: () => _navigateToGroupDetails(group),
                    ),
                  );
                },
                childCount: groups.length,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 80.h)),
        ],
      ),
    );
  }

  Widget _buildStatsCard(List<GroupAccount> groups) {
    final totalGroups = groups.length;
    final activeGroups = groups.where((g) => g.status == GroupAccountStatus.active).length;
    final totalContributions = groups.fold<int>(0, (sum, g) => sum + g.contributions.length);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Overview',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.groups,
                color: Colors.white,
                size: 24.sp,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  title: 'Total Groups',
                  value: totalGroups.toString(),
                  icon: Icons.group,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildStatItem(
                  title: 'Active',
                  value: activeGroups.toString(),
                  icon: Icons.check_circle_outline,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildStatItem(
                  title: 'Contributions',
                  value: totalContributions.toString(),
                  icon: Icons.account_balance_wallet,
                ),
              ),
            ],
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
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.8),
          size: 20.sp,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmptyView() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadUserGroups();
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
                  'Create your first group account to start managing shared contributions with friends and family.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Pull down to refresh',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 32.h),
                ElevatedButton.icon(
                  onPressed: () => _showCreateGroupBottomSheet(),
                  icon: Icon(Icons.add, size: 20.sp),
                  label: Text(
                    'Create Group',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
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
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsMenu() {
    // Add options menu functionality if needed
  }

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
      // When returning from details, restore groups list state
      if (mounted && _navigatedToDetails) {
        _navigatedToDetails = false;
        print('🔵 GroupAccountListScreen: Returned from details, restoring groups');
        context.read<GroupAccountCubit>().restoreGroupsListState();
      }
    });
  }
}
