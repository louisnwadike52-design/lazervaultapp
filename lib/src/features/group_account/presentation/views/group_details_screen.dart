import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/member_card.dart';
import '../widgets/contribution_card.dart';
import '../widgets/add_member_bottom_sheet.dart';
import '../widgets/create_contribution_bottom_sheet.dart';
import '../widgets/edit_group_bottom_sheet.dart';
import '../widgets/member_detail_dialog.dart';
import '../views/group_account_report_screen.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';

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
            } else if (state is MemberAddedSuccess && state.groupId == widget.groupId) {
              // Reload group details to get updated members list
              // This is a single reload after successful member add
              context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
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
    // Get current user ID from the cubit
    final currentUserId = context.read<GroupAccountCubit>().currentUserId;
    final currentUserMember = currentUserId != null
        ? members.where((m) => m.userId == currentUserId).firstOrNull
        : null;

    return Column(
      children: [
        _buildHeader(group),
        _buildGroupOverview(group, members, contributions),
        if (currentUserMember != null)
          _buildCompactRoleChip(currentUserMember, group),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMembersTab(members, group, contributions),
              _buildContributionsTab(contributions, group),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactRoleChip(GroupMember currentMember, GroupAccount group) {
    final role = currentMember.role;

    Color roleColor;
    IconData roleIcon;
    switch (role) {
      case GroupMemberRole.admin:
        roleColor = const Color(0xFFEF4444);
        roleIcon = Icons.admin_panel_settings;
      case GroupMemberRole.moderator:
        roleColor = const Color(0xFFF59E0B);
        roleIcon = Icons.shield;
      case GroupMemberRole.member:
        roleColor = const Color(0xFF10B981);
        roleIcon = Icons.person;
    }

    return GestureDetector(
      onTap: () => _showRoleDetailsDialog(currentMember, group),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: roleColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(roleIcon, color: roleColor, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              'Your Role: ',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.grey[400],
              ),
            ),
            Text(
              role.displayName,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: roleColor,
              ),
            ),
            if (group.adminId == currentMember.userId) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Creator',
                  style: GoogleFonts.inter(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
            const Spacer(),
            Icon(
              Icons.info_outline,
              color: Colors.grey[500],
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showRoleDetailsDialog(GroupMember currentMember, GroupAccount group) {
    final role = currentMember.role;
    final isAdmin = role == GroupMemberRole.admin;
    final isModerator = role == GroupMemberRole.moderator;

    Color roleColor;
    IconData roleIcon;
    switch (role) {
      case GroupMemberRole.admin:
        roleColor = const Color(0xFFEF4444);
        roleIcon = Icons.admin_panel_settings;
      case GroupMemberRole.moderator:
        roleColor = const Color(0xFFF59E0B);
        roleIcon = Icons.shield;
      case GroupMemberRole.member:
        roleColor = const Color(0xFF10B981);
        roleIcon = Icons.person;
    }

    final permissions = <String>[];
    if (isAdmin) {
      permissions.addAll([
        'Manage all group settings',
        'Add & remove members',
        'Manage all contributions',
        'Change member roles',
      ]);
    } else if (isModerator) {
      permissions.addAll([
        'Add new members',
        'Create contributions',
        'Manage your contributions',
      ]);
    } else {
      permissions.addAll([
        'View group details',
        'Create contributions',
        'Make payments',
      ]);
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: 340.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: roleColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(roleIcon, color: roleColor, size: 22.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Role',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                role.displayName,
                                style: GoogleFonts.inter(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: roleColor,
                                ),
                              ),
                              if (group.adminId == currentMember.userId) ...[
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'Creator',
                                    style: GoogleFonts.inter(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D3D3D),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(Icons.close, color: Colors.white70, size: 18.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permissions',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ...permissions.map((permission) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: roleColor, size: 16.sp),
                          SizedBox(width: 8.w),
                          Text(
                            permission,
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(GroupAccount group) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Check if we can pop, otherwise navigate to groups list explicitly
              // This handles the case when coming from receipt screen which clears the stack
              if (Get.previousRoute.isNotEmpty) {
                Get.back();
              } else {
                Get.offAllNamed(AppRoutes.groupAccount);
              }
            },
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
                value: 'share_report',
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: const Color.fromARGB(255, 78, 3, 208), size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Generate Report',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
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
    // Get the primary currency from contributions (use first contribution's currency)
    final primaryCurrency = contributions.isNotEmpty ? contributions.first.currency : 'NGN';
    final currencySymbol = _getCurrencySymbol(primaryCurrency);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Progress',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      '$currencySymbol${totalCurrent.toStringAsFixed(2)} / $currencySymbol${totalTarget.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
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
          SizedBox(height: 10.h),
          // External Social Media Links
          if (group.hasExternalLinks) _buildExternalLinksSection(group),
        ],
      ),
    );
  }

  Widget _buildExternalLinksSection(GroupAccount group) {
    final links = group.externalLinks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.link,
                color: Colors.white.withValues(alpha: 0.8),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Join our community',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            if (links['whatsapp'] != null && links['whatsapp']!.isNotEmpty) ...[
              _buildSocialButton(
                label: 'WhatsApp',
                icon: Icons.message,
                color: const Color(0xFF25D366),
                onTap: () => _launchLink(links['whatsapp']!),
              ),
              SizedBox(width: 12.w),
            ],
            if (links['telegram'] != null && links['telegram']!.isNotEmpty) ...[
              _buildSocialButton(
                label: 'Telegram',
                icon: Icons.send,
                color: const Color(0xFF0088CC),
                onTap: () => _launchLink(links['telegram']!),
              ),
              SizedBox(width: 12.w),
            ],
            if (links['facebook'] != null && links['facebook']!.isNotEmpty) ...[
              _buildSocialButton(
                label: 'Facebook',
                icon: Icons.facebook,
                color: const Color(0xFF1877F2),
                onTap: () => _launchLink(links['facebook']!),
              ),
              SizedBox(width: 12.w),
            ],
            if (links['discord'] != null && links['discord']!.isNotEmpty) ...[
              _buildSocialButton(
                label: 'Discord',
                icon: Icons.gamepad, // Using gamepad as alternative for Discord
                color: const Color(0xFF5865F2),
                onTap: () => _launchLink(links['discord']!),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not open link',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
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
            color: Colors.white.withValues(alpha: 0.8),
            size: 18.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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

  Widget _buildMembersTab(List<GroupMember> members, GroupAccount group, List<Contribution> contributions) {
    // Check if current user can add members
    final currentUserId = context.read<GroupAccountCubit>().currentUserId;
    final currentMember = currentUserId != null
        ? members.where((m) => m.userId == currentUserId).firstOrNull
        : null;
    final canAddMembers = currentMember != null &&
        (currentMember.role == GroupMemberRole.admin ||
         currentMember.role == GroupMemberRole.moderator);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
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
                  if (canAddMembers)
                    ElevatedButton.icon(
                      onPressed: () => _showAddMemberBottomSheet(group, members),
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
                    )
                  else
                    // Show a disabled button or nothing for non-privileged users
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_outline, size: 14.sp, color: Colors.grey[500]),
                          SizedBox(width: 4.w),
                          Text(
                            'Member',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 16.h, left: 20.w, right: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final member = members[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MemberCard(
                      member: member,
                      group: group,
                      contributions: contributions,
                      onTap: () => _showMemberOptions(member, group),
                    ),
                  );
                },
                childCount: members.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributionsTab(List<Contribution> contributions, GroupAccount group) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
      },
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: contributions.isEmpty
          ? _buildEmptyContributions(group)
          : CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
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
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 16.h, left: 20.w, right: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                      childCount: contributions.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyContributions(GroupAccount group) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 60.h),
        Center(
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
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () => _showCreateContributionBottomSheet(group),
                icon: Icon(Icons.add, size: 20.sp),
                label: Text(
                  'Create Contribution',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Pull down to refresh',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleMenuAction(String action, GroupAccount group) {
    switch (action) {
      case 'share_report':
        _showShareReportScreen(group);
        break;
      case 'edit':
        _showEditGroupBottomSheet(group);
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

  void _showShareReportScreen(GroupAccount group) {
    // Get current state to access contributions and members
    final state = context.read<GroupAccountCubit>().state;
    List<Contribution> contributions = [];
    List<GroupMember> members = [];

    if (state is GroupAccountGroupLoaded) {
      contributions = state.contributions;
      members = state.members;
    }

    Navigator.of(context).push(
      GroupAccountReportScreen.route(
        group: group,
        contributions: contributions,
        members: members,
        groupUrl: 'https://lazervault.app/groups/${group.id}',
      ),
    );
  }

  void _showAddMemberBottomSheet(GroupAccount group, List<GroupMember> existingMembers) {
    final cubit = context.read<GroupAccountCubit>();

    showModalBottomSheet<GroupMember?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AddMemberBottomSheet(
          group: group,
          existingMembers: existingMembers,
        ),
      ),
    ).then((newMember) {
      if (!mounted) return;
      // Only reload if no member was returned (e.g., for invites or cancelled)
      // For successful member adds, the state is already updated reactively via MemberAddedSuccess
      if (newMember == null) {
        // Check if this was an invite that succeeded (not a member add)
        // For invites, we don't need to reload either
        return;
      }
      // Member was added - no reload needed, UI updates reactively via BlocListener
    });
  }

  void _showCreateContributionBottomSheet(GroupAccount group) {
    final cubit = context.read<GroupAccountCubit>();

    // Get user's currency from auth state
    String userCurrency = 'NGN'; // Default
    String currencySymbol = '₦';
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final currency = authState.profile.user.currency;
      if (currency != null && currency.isNotEmpty) {
        userCurrency = currency.toUpperCase();
        currencySymbol = _getCurrencySymbol(userCurrency);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: CreateContributionBottomSheet(
          groupId: group.id,
          groupMembers: group.members,
          currency: userCurrency,
          currencySymbol: currencySymbol,
        ),
      ),
    ).then((_) {
      if (!mounted) return;
      // Reload group details after bottom sheet closes to ensure contributions list is updated
      context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
    });
  }

  void _showEditGroupBottomSheet(GroupAccount group) {
    final cubit = context.read<GroupAccountCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: EditGroupBottomSheet(group: group),
      ),
    ).then((_) {
      if (!mounted) return;
      // Reload group details after edit to ensure UI is updated
      context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
    });
  }

  String _getCurrencySymbol(String currency) {
    const symbols = {
      'NGN': '₦',
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'GHS': '₵',
      'ZAR': 'R',
      'KES': 'KSh',
      'XOF': 'CFA',
      'XAF': 'FCFA',
    };
    return symbols[currency] ?? currency;
  }

  void _showMemberOptions(GroupMember member, GroupAccount group) {
    final currentUserId = context.read<GroupAccountCubit>().currentUserId ?? '';

    // Get contributions from current state
    List<Contribution> contributions = [];
    final state = context.read<GroupAccountCubit>().state;
    if (state is GroupAccountGroupLoaded) {
      contributions = state.contributions;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => MemberDetailDialog(
        member: member,
        group: group,
        currentUserId: currentUserId,
        contributions: contributions,
        onChangeRole: () => _showChangeRoleDialog(member, group),
        onRemoveMember: () => _showRemoveMemberConfirmation(member, group),
      ),
    );
  }

  void _showChangeRoleDialog(GroupMember member, GroupAccount group) {
    showDialog(
      context: context,
      builder: (dialogContext) => ChangeRoleDialog(
        member: member,
        onRoleSelected: (newRole) {
          context.read<GroupAccountCubit>().updateMemberRoleInGroup(
            groupId: group.id,
            memberId: member.id,
            newRole: newRole,
          );
        },
      ),
    );
  }

  void _showRemoveMemberConfirmation(GroupMember member, GroupAccount group) {
    showDialog(
      context: context,
      builder: (dialogContext) => RemoveMemberConfirmDialog(
        member: member,
        onConfirm: () {
          context.read<GroupAccountCubit>().removeMemberFromGroupAccount(
            groupId: group.id,
            memberId: member.id,
          );
        },
      ),
    );
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