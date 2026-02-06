import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/share_contribution_bottom_sheet.dart';
import 'activity_log_screen.dart';
import 'edit_group_screen.dart';

class GroupAdminDashboard extends StatefulWidget {
  final GroupAccount group;
  final List<GroupMember> members;
  final List<Contribution> contributions;

  const GroupAdminDashboard({
    super.key,
    required this.group,
    required this.members,
    required this.contributions,
  });

  @override
  State<GroupAdminDashboard> createState() => _GroupAdminDashboardState();
}

class _GroupAdminDashboardState extends State<GroupAdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _navigateToEditGroup,
            icon: Icon(Icons.edit, color: Colors.white, size: 22.sp),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildOverviewStats(),
            SizedBox(height: 16.h),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildMembersTab(),
                  _buildContributionsTab(),
                  _buildActivityTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewStats() {
    final totalTarget = widget.contributions.fold<double>(0, (sum, c) => sum + c.targetAmount);
    final totalCurrent = widget.contributions.fold<double>(0, (sum, c) => sum + c.currentAmount);
    final activeContributions =
        widget.contributions.where((c) => c.status == ContributionStatus.active).length;
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            widget.group.name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildStatItem(
                label: 'Members',
                value: widget.members.length.toString(),
                icon: Icons.people,
              ),
              _buildStatItem(
                label: 'Active Goals',
                value: activeContributions.toString(),
                icon: Icons.flag,
              ),
              _buildStatItem(
                label: 'Collected',
                value: currencyFormat.format(totalCurrent / 100),
                icon: Icons.account_balance_wallet,
                isLarge: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    bool isLarge = false,
  }) {
    return Expanded(
      flex: isLarge ? 2 : 1,
      child: Column(
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
              color: Colors.white,
              fontSize: isLarge ? 16.sp : 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Members'),
          Tab(text: 'Goals'),
          Tab(text: 'Activity'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPendingActionsCard(),
          SizedBox(height: 16.h),
          _buildQuickActionsCard(),
          SizedBox(height: 16.h),
          _buildRecentActivityCard(),
        ],
      ),
    );
  }

  Widget _buildPendingActionsCard() {
    final overdueContributions =
        widget.contributions.where((c) => c.deadline.isBefore(DateTime.now()) && c.status == ContributionStatus.active).length;
    final pendingPayouts = widget.contributions
        .where((c) => c.type == ContributionType.rotatingSavings && c.currentAmount > 0)
        .length;
    final pendingMembers = widget.members.where((m) => m.status == GroupMemberStatus.pending).length;

    final hasPendingActions = overdueContributions > 0 || pendingPayouts > 0 || pendingMembers > 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: hasPendingActions ? const Color(0xFFFB923C) : Colors.grey[400],
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Pending Actions',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (!hasPendingActions)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 32.sp),
                    SizedBox(height: 8.h),
                    Text(
                      'All caught up!',
                      style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            if (overdueContributions > 0)
              _buildPendingActionItem(
                icon: Icons.warning,
                color: const Color(0xFFEF4444),
                title: '$overdueContributions Overdue Goals',
                subtitle: 'Review and take action',
                onTap: () {
                  _tabController.animateTo(2);
                },
              ),
            if (pendingPayouts > 0)
              _buildPendingActionItem(
                icon: Icons.account_balance_wallet,
                color: const Color(0xFF3B82F6),
                title: '$pendingPayouts Pending Payouts',
                subtitle: 'Process member payouts',
                onTap: () {
                  _tabController.animateTo(2);
                },
              ),
            if (pendingMembers > 0)
              _buildPendingActionItem(
                icon: Icons.person_add,
                color: const Color(0xFF10B981),
                title: '$pendingMembers Pending Members',
                subtitle: 'Approve or reject requests',
                onTap: () {
                  _tabController.animateTo(1);
                },
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildPendingActionItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildQuickActionButton(
                icon: Icons.person_add,
                label: 'Add Member',
                onTap: () {
                  // Show add member dialog
                },
              ),
              SizedBox(width: 12.w),
              _buildQuickActionButton(
                icon: Icons.add_chart,
                label: 'New Goal',
                onTap: () {
                  // Show create contribution
                },
              ),
              SizedBox(width: 12.w),
              _buildQuickActionButton(
                icon: Icons.download,
                label: 'Export',
                onTap: _showExportOptions,
              ),
              SizedBox(width: 12.w),
              _buildQuickActionButton(
                icon: Icons.share,
                label: 'Share',
                onTap: _showShareOptions,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: _navigateToActivityLog,
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 78, 3, 208),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Mock recent activity
          _buildActivityItem(
            icon: Icons.payment,
            title: 'Payment received',
            subtitle: 'John Doe paid \u20A65,000',
            time: '2 hours ago',
          ),
          _buildActivityItem(
            icon: Icons.person_add,
            title: 'New member',
            subtitle: 'Alex joined the group',
            time: '1 day ago',
          ),
          _buildActivityItem(
            icon: Icons.add_chart,
            title: 'Goal created',
            subtitle: 'House Fund was created',
            time: '3 days ago',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: Colors.grey[400], size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: widget.members.length,
      itemBuilder: (context, index) {
        final member = widget.members[index];
        return _buildMemberManagementCard(member);
      },
    );
  }

  Widget _buildMemberManagementCard(GroupMember member) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            backgroundImage: member.profileImage != null ? NetworkImage(member.profileImage!) : null,
            child: member.profileImage == null
                ? Text(
                    member.userName.isNotEmpty ? member.userName[0].toUpperCase() : '?',
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 78, 3, 208),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      member.userName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: _getRoleColor(member.role).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        _getRoleLabel(member.role),
                        style: GoogleFonts.inter(
                          color: _getRoleColor(member.role),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  member.email ?? 'No email',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 20.sp),
            color: const Color(0xFF2D2D2D),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'role', child: Text('Change Role', style: TextStyle(color: Colors.white))),
              if (member.role != GroupMemberRole.admin)
                const PopupMenuItem(value: 'remove', child: Text('Remove Member', style: TextStyle(color: Colors.red))),
            ],
            onSelected: (value) => _handleMemberAction(value, member),
          ),
        ],
      ),
    );
  }

  Widget _buildContributionsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: widget.contributions.length,
      itemBuilder: (context, index) {
        final contribution = widget.contributions[index];
        return _buildContributionManagementCard(contribution);
      },
    );
  }

  Widget _buildContributionManagementCard(Contribution contribution) {
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);
    final progress = contribution.targetAmount > 0
        ? (contribution.currentAmount / contribution.targetAmount).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contribution.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: _getStatusColor(contribution.status).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            _getStatusLabel(contribution.status),
                            style: GoogleFonts.inter(
                              color: _getStatusColor(contribution.status),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _getTypeLabel(contribution.type),
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 20.sp),
                color: const Color(0xFF2D2D2D),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit', style: TextStyle(color: Colors.white))),
                  const PopupMenuItem(value: 'share', child: Text('Share', style: TextStyle(color: Colors.white))),
                  if (contribution.type == ContributionType.rotatingSavings)
                    const PopupMenuItem(value: 'payout', child: Text('Process Payout', style: TextStyle(color: Colors.white))),
                  if (contribution.status == ContributionStatus.active)
                    const PopupMenuItem(value: 'pause', child: Text('Pause', style: TextStyle(color: Colors.orange))),
                  const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                ],
                onSelected: (value) => _handleContributionAction(value, contribution),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currencyFormat.format(contribution.currentAmount / 100),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                currencyFormat.format(contribution.targetAmount / 100),
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(
                _getStatusColor(contribution.status),
              ),
              minHeight: 8.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64.sp, color: Colors.grey[600]),
          SizedBox(height: 16.h),
          Text(
            'View Full Activity Log',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'See all actions taken in this group',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _navigateToActivityLog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'View Activity Log',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods

  Color _getRoleColor(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return const Color(0xFFEF4444);
      case GroupMemberRole.moderator:
        return const Color(0xFFFB923C);
      case GroupMemberRole.member:
        return const Color(0xFF10B981);
    }
  }

  String _getRoleLabel(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return 'Admin';
      case GroupMemberRole.moderator:
        return 'Moderator';
      case GroupMemberRole.member:
        return 'Member';
    }
  }

  Color _getStatusColor(ContributionStatus status) {
    switch (status) {
      case ContributionStatus.active:
        return const Color(0xFF10B981);
      case ContributionStatus.paused:
        return const Color(0xFFFB923C);
      case ContributionStatus.completed:
        return const Color(0xFF3B82F6);
      case ContributionStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  String _getStatusLabel(ContributionStatus status) {
    switch (status) {
      case ContributionStatus.active:
        return 'Active';
      case ContributionStatus.paused:
        return 'Paused';
      case ContributionStatus.completed:
        return 'Completed';
      case ContributionStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _getTypeLabel(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return 'One-Time';
      case ContributionType.rotatingSavings:
        return 'Rotating';
      case ContributionType.investmentPool:
        return 'Investment';
      case ContributionType.recurringGoal:
        return 'Recurring';
    }
  }

  // Navigation and actions

  void _navigateToEditGroup() {
    Get.to(() => EditGroupScreen(group: widget.group));
  }

  void _navigateToActivityLog() {
    Get.to(() => ActivityLogScreen(
          groupId: widget.group.id,
          title: '${widget.group.name} Activity',
        ));
  }

  void _showExportOptions() {
    // Show export options bottom sheet
  }

  void _showShareOptions() {
    if (widget.contributions.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ShareContributionBottomSheet(
          contribution: widget.contributions.first,
          groupName: widget.group.name,
          members: widget.members,
          payments: const [], // Would need to load payments
        ),
      );
    }
  }

  void _handleMemberAction(String action, GroupMember member) {
    switch (action) {
      case 'role':
        _showChangeRoleDialog(member);
        break;
      case 'remove':
        _showRemoveMemberDialog(member);
        break;
    }
  }

  void _handleContributionAction(String action, Contribution contribution) {
    switch (action) {
      case 'edit':
        // Navigate to edit contribution
        break;
      case 'share':
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ShareContributionBottomSheet(
            contribution: contribution,
            groupName: widget.group.name,
            members: widget.members,
            payments: const [],
          ),
        );
        break;
      case 'payout':
        // Process payout
        break;
      case 'pause':
        // Pause contribution
        break;
      case 'delete':
        _showDeleteContributionDialog(contribution);
        break;
    }
  }

  void _showChangeRoleDialog(GroupMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Change Role', style: GoogleFonts.inter(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: GroupMemberRole.values.map((role) {
            return RadioListTile<GroupMemberRole>(
              value: role,
              groupValue: member.role,
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null && value != member.role) {
                  context.read<GroupAccountCubit>().updateMemberRoleInGroup(
                        groupId: widget.group.id,
                        memberId: member.id,
                        newRole: value,
                      );
                }
              },
              title: Text(
                _getRoleLabel(role),
                style: GoogleFonts.inter(color: Colors.white),
              ),
              activeColor: const Color.fromARGB(255, 78, 3, 208),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showRemoveMemberDialog(GroupMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Remove Member', style: GoogleFonts.inter(color: Colors.white)),
        content: Text(
          'Are you sure you want to remove ${member.userName} from this group?',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<GroupAccountCubit>().removeMemberFromGroupAccount(
                    groupId: widget.group.id,
                    memberId: member.id,
                  );
            },
            child: Text('Remove', style: GoogleFonts.inter(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteContributionDialog(Contribution contribution) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Delete Contribution', style: GoogleFonts.inter(color: Colors.white)),
        content: Text(
          'Are you sure you want to delete "${contribution.title}"? This action cannot be undone.',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<GroupAccountCubit>().deleteContribution(contribution.id);
            },
            child: Text('Delete', style: GoogleFonts.inter(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
