import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/member_card.dart';
import '../widgets/contribution_card.dart';
import '../widgets/add_member_bottom_sheet.dart';
import '../widgets/create_contribution_bottom_sheet.dart';

class GroupDetailsScreen extends StatefulWidget {
  final String groupId;

  const GroupDetailsScreen({
    super.key,
    required this.groupId,
  });

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Load group details if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
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
            } else if (state is GroupAccountContributionCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contribution "${state.contribution.title}" created successfully!'),
                  backgroundColor: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GroupAccountLoading) {
              return _buildLoadingView();
            } else if (state is GroupAccountGroupLoaded) {
              return _buildGroupDetailsView(
                state.group,
                state.members,
                state.contributions,
              );
            } else if (state is GroupAccountError) {
              return _buildErrorView(state.message);
            }
            
            return _buildLoadingView();
          },
        ),
      ),
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
            'Loading group details...',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[400],
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
              'Failed to load group',
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
                context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
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

  Widget _buildGroupDetailsView(
    GroupAccount group,
    List<GroupMember> members,
    List<Contribution> contributions,
  ) {
    return Column(
      children: [
        _buildHeader(group),
        _buildGroupOverview(group, members, contributions),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMembersTab(members, group),
              _buildContributionsTab(contributions, group),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(GroupAccount group) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
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
                  group.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  group.description,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24.sp,
            ),
            color: const Color(0xFF1F1F1F),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Edit Group',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'leave',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.red, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Leave Group',
                      style: GoogleFonts.inter(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) => _handleMenuAction(value, group),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupOverview(
    GroupAccount group,
    List<GroupMember> members,
    List<Contribution> contributions,
  ) {
    final totalTarget = contributions.fold<double>(0, (sum, c) => sum + c.targetAmount);
    final totalCurrent = contributions.fold<double>(0, (sum, c) => sum + c.currentAmount);
    final progressPercentage = totalTarget > 0 ? (totalCurrent / totalTarget) * 100 : 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildOverviewStat(
                title: 'Members',
                value: members.length.toString(),
                icon: Icons.people,
              ),
              SizedBox(width: 20.w),
              _buildOverviewStat(
                title: 'Contributions',
                value: contributions.length.toString(),
                icon: Icons.account_balance_wallet,
              ),
              SizedBox(width: 20.w),
              _buildOverviewStat(
                title: 'Progress',
                value: '${progressPercentage.toStringAsFixed(0)}%',
                icon: Icons.trending_up,
              ),
            ],
          ),
          if (contributions.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Progress',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      '\$${totalCurrent.toStringAsFixed(2)} / \$${totalTarget.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: progressPercentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewStat({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 24.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color.fromARGB(255, 78, 3, 208),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: 'Members'),
          Tab(text: 'Contributions'),
        ],
      ),
    );
  }

  Widget _buildMembersTab(List<GroupMember> members, GroupAccount group) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${members.length} Members',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddMemberBottomSheet(group),
                icon: Icon(Icons.add, size: 16.sp),
                label: Text(
                  'Add Member',
                  style: GoogleFonts.inter(fontSize: 12.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: MemberCard(
                  member: member,
                  group: group,
                  onTap: () => _showMemberOptions(member, group),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContributionsTab(List<Contribution> contributions, GroupAccount group) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${contributions.length} Contributions',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateContributionBottomSheet(group),
                icon: Icon(Icons.add, size: 16.sp),
                label: Text(
                  'New Goal',
                  style: GoogleFonts.inter(fontSize: 12.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: contributions.isEmpty
              ? _buildEmptyContributions()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: contributions.length,
                  itemBuilder: (context, index) {
                    final contribution = contributions[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ContributionCard(
                        contribution: contribution,
                        onTap: () => _navigateToContributionDetails(contribution),
                        onPayment: () => _navigateToMakePayment(contribution),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyContributions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No Contributions Yet',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create the first contribution goal for this group',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action, GroupAccount group) {
    switch (action) {
      case 'edit':
        // Navigate to edit group screen
        break;
      case 'leave':
        _showLeaveGroupDialog(group);
        break;
    }
  }

  void _showLeaveGroupDialog(GroupAccount group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Leave Group',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to leave "${group.name}"? You won\'t be able to rejoin unless invited again.',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement leave group logic
              Get.back(); // Go back to groups list
            },
            child: Text(
              'Leave',
              style: GoogleFonts.inter(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMemberBottomSheet(GroupAccount group) {
    final cubit = context.read<GroupAccountCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AddMemberBottomSheet(group: group),
      ),
    ).then((_) {
      // Reload group details after bottom sheet closes to ensure members list is updated
      context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
    });
  }

  void _showCreateContributionBottomSheet(GroupAccount group) {
    final cubit = context.read<GroupAccountCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: CreateContributionBottomSheet(
          groupId: group.id,
          groupMembers: group.members,
        ),
      ),
    ).then((_) {
      // Reload group details after bottom sheet closes to ensure contributions list is updated
      context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
    });
  }

  void _showMemberOptions(GroupMember member, GroupAccount group) {
    // Show member options like change role, remove, etc.
  }

  void _navigateToContributionDetails(Contribution contribution) {
    // Navigate to contribution details screen
    Get.toNamed(
      AppRoutes.contributionDetails,
      arguments: {
        'contributionId': contribution.id,
        'contribution': contribution,
      },
    );
  }

  void _navigateToMakePayment(Contribution contribution) {
    // Navigate to make payment screen
    Get.toNamed(
      AppRoutes.makePayment,
      arguments: {
        'contributionId': contribution.id,
        'contribution': contribution,
      },
    );
  }
} 