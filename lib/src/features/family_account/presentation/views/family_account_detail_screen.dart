import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// Family Account Detail Screen
/// Shows:
/// - Family account overview
/// - Member list with allocations and spending
/// - Recent transactions
/// - Manage members button
/// - Account settings
class FamilyAccountDetailScreen extends StatefulWidget {
  const FamilyAccountDetailScreen({
    super.key,
    required this.familyId,
  });

  final String familyId;

  @override
  State<FamilyAccountDetailScreen> createState() => _FamilyAccountDetailScreenState();
}

class _FamilyAccountDetailScreenState extends State<FamilyAccountDetailScreen>
    with SingleTickerProviderStateMixin {
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadFamilyAccount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadFamilyAccount() {
    _cubit.loadFamilyAccount(widget.familyId);
  }

  void _showAddMemberSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              'Add Family Member',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),

            // Options
            _buildSheetOption(
              Icons.email,
              'Invite by Email',
              'Send invitation via email',
              () {
                Get.back();
                Get.toNamed(AppRoutes.familyAddMember, arguments: {
                  'familyId': widget.familyId,
                  'invitationMethod': 'email',
                });
              },
            ),
            SizedBox(height: 12.h),
            _buildSheetOption(
              Icons.sms,
              'Invite by SMS',
              'Send invitation via text message',
              () {
                Get.back();
                Get.toNamed(AppRoutes.familyAddMember, arguments: {
                  'familyId': widget.familyId,
                  'invitationMethod': 'sms',
                });
              },
            ),
            SizedBox(height: 12.h),
            _buildSheetOption(
              Icons.person,
              'Invite by Username',
              'Send invitation to username',
              () {
                Get.back();
                Get.toNamed(AppRoutes.familyAddMember, arguments: {
                  'familyId': widget.familyId,
                  'invitationMethod': 'username',
                });
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showMemberOptions(FamilyMember member) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),

            // Member info
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C5CE7).withOpacity(0.3),
                        const Color(0xFFA29BFE).withOpacity(0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: member.avatarUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25.r),
                          child: Image.network(
                            member.avatarUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.fullName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        member.role.name.toUpperCase(),
                        style: TextStyle(
                          color: member.role == FamilyMemberRole.admin
                              ? const Color(0xFF6C5CE7)
                              : Colors.white.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Options
            if (member.role != FamilyMemberRole.admin) ...[
              _buildOption(
                Icons.edit,
                'Edit Limits',
                'Update spending limits',
                () {
                  Get.back();
                  Get.toNamed(
                    AppRoutes.familyEditMemberLimits,
                    arguments: {
                      'familyId': widget.familyId,
                      'member': member,
                    },
                  );
                },
              ),
              SizedBox(height: 12.h),
              _buildOption(
                Icons.account_balance_wallet,
                'Allocate Funds',
                'Add more funds to member',
                () {
                  Get.back();
                  _showAllocateFundsDialog(member);
                },
              ),
              SizedBox(height: 12.h),
            ],
            _buildOption(
              Icons.info_outline,
              'View Details',
                'See member activity',
              () {
                Get.back();
                // Navigate to member details
              },
            ),
            if (member.role != FamilyMemberRole.admin) ...[
              SizedBox(height: 12.h),
              _buildOption(
                Icons.remove_circle_outline,
                'Remove Member',
                'Remove from family account',
                () {
                  Get.back();
                  _confirmRemoveMember(member);
                },
                color: Colors.red,
              ),
            ],
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showAllocateFundsDialog(FamilyMember member) {
    final amountController = TextEditingController(text: '0');
    final descriptionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Allocate Funds to ${member.fullName}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  color: const Color(0xFF6C5CE7),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                Get.back();
                _cubit.allocateFundsToMember(
                  familyId: widget.familyId,
                  memberId: member.id,
                  amount: amount,
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Allocate',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmRemoveMember(FamilyMember member) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Remove ${member.fullName}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will remove ${member.fullName} from the family account. Their remaining balance will be returned to the pool.',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.removeMember(
                familyId: widget.familyId,
                memberId: member.id,
                reason: 'Removed by admin',
                returnBalanceToPool: true,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Remove',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _showAccountSettings(FamilyAccount account) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              'Account Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),

            _buildOption(
              account.status == FamilyAccountStatus.active
                  ? Icons.ac_unit
                  : Icons.wb_sunny,
              account.status == FamilyAccountStatus.active ? 'Freeze Account' : 'Unfreeze Account',
              account.status == FamilyAccountStatus.active
                  ? 'Temporarily freeze all spending'
                  : 'Reactivate account',
              () {
                Get.back();
                if (account.status == FamilyAccountStatus.active) {
                  _confirmFreezeAccount(account);
                } else {
                  _cubit.unfreezeAccount(widget.familyId);
                }
              },
            ),
            SizedBox(height: 12.h),
            _buildOption(
              Icons.delete_outline,
              'Delete Account',
              'Permanently delete family account',
              () {
                Get.back();
                _confirmDeleteAccount(account);
              },
              color: Colors.red,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _confirmFreezeAccount(FamilyAccount account) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Freeze ${account.name}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will temporarily freeze all spending on this family account. You can unfreeze it at any time.',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.freezeAccount(familyId: widget.familyId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Freeze',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(FamilyAccount account) {
    final confirmationController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete ${account.name}?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This action cannot be undone. All remaining funds will be returned to your account.',
              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: confirmationController,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Type "DELETE" to confirm',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (confirmationController.text.trim() == 'DELETE') {
                Get.back();
                _cubit.deleteAccount(
                  familyId: widget.familyId,
                  confirmationCode: 'USER_CONFIRMED',
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E2E),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E1E2E),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20.sp,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Family Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is FamilyAccountLoaded) {
                  return IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                    onPressed: () => _showAccountSettings(state.familyAccount),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is FamilyAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is FamilyMemberAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Member added successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FamilyMemberRemoved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Member removed. \$${state.returnedBalance.toStringAsFixed(2)} returned to pool'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FundsAllocated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Funds allocated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FamilyAccountFrozen) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account frozen successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FamilyAccountUnfrozen) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account unfrozen successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              _loadFamilyAccount();
            } else if (state is FamilyAccountDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deleted. \$${state.returnedBalance.toStringAsFixed(2)} returned'),
                  backgroundColor: Colors.green,
                ),
              );
              Get.back(); // Go back to previous screen
            }
          },
          builder: (context, state) {
            if (state is FamilyAccountLoading) {
              return Center(
                child: CircularProgressIndicator(color: const Color(0xFF6C5CE7)),
              );
            }

            if (state is FamilyAccountLoaded) {
              final account = state.familyAccount;
              return Column(
                children: [
                  // Tab Bar
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelColor: const Color(0xFF6C5CE7),
                      unselectedLabelColor: Colors.white.withOpacity(0.6),
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Members'),
                        Tab(text: 'Activity'),
                      ],
                    ),
                  ),

                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildOverviewTab(account),
                        _buildMembersTab(account),
                        _buildActivityTab(account),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text(
                'Unable to load account',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverviewTab(FamilyAccount account) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Overview Card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6C5CE7).withOpacity(0.2),
                  const Color(0xFFA29BFE).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF6C5CE7).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.family_restroom,
                      color: const Color(0xFF6C5CE7),
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (account.description != null && account.description!.isNotEmpty)
                            Text(
                              account.description!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Pool',
                        '\$${account.totalPoolBalance.toStringAsFixed(2)}',
                        Icons.account_balance_wallet,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildStatCard(
                        'Allocated',
                        '\$${account.totalAllocatedBalance.toStringAsFixed(2)}',
                        Icons.pie_chart,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Balance',
                        '\$${account.totalBalance.toStringAsFixed(2)}',
                        Icons.monetization_on,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildStatCard(
                        'Members',
                        '${account.activeMemberCount}',
                        Icons.people,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Account Status
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: account.status == FamilyAccountStatus.active
                  ? Colors.green.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: account.status == FamilyAccountStatus.active
                    ? Colors.green.withOpacity(0.3)
                    : Colors.blue.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  account.status == FamilyAccountStatus.active
                      ? Icons.check_circle
                      : Icons.ac_unit,
                  color: account.status == FamilyAccountStatus.active
                      ? Colors.green
                      : Colors.blue,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  account.status == FamilyAccountStatus.active
                      ? 'Account Active'
                      : 'Account Frozen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Settings Info
          Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            Icons.people_outline,
            'Member Contributions',
            account.allowMemberContributions ? 'Enabled' : 'Disabled',
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.person,
            'Created by',
            account.creatorName,
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.calendar_today,
            'Created',
            '${account.createdAt.day}/${account.createdAt.month}/${account.createdAt.year}',
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMembersTab(FamilyAccount account) {
    return Column(
      children: [
        // Add Member Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: _showAddMemberSheet,
              icon: Icon(Icons.add, size: 20.sp),
              label: Text(
                'Add Family Member',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ),

        // Members List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: account.members.length,
            itemBuilder: (context, index) {
              final member = account.members[index];
              return _buildMemberCard(member);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTab(FamilyAccount account) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 48.sp,
            color: Colors.white.withOpacity(0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'Transaction History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Coming soon',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF6C5CE7),
            size: 18.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(FamilyMember member) {
    final utilizationPercentage = member.utilizationPercentage;
    final remainingPercentage = member.allocatedBalance > 0
        ? ((member.remainingBalance / member.allocatedBalance) * 100)
        : 0;

    return GestureDetector(
      onTap: () => _showMemberOptions(member),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: member.invitationStatus == InvitationStatus.accepted
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFF6C5CE7).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                // Avatar
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C5CE7).withOpacity(0.3),
                        const Color(0xFFA29BFE).withOpacity(0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: member.avatarUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Image.network(
                            member.avatarUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                ),
                SizedBox(width: 12.w),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              member.fullName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Status Badge
                          if (member.invitationStatus != InvitationStatus.accepted)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C5CE7).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                member.invitationStatus.name.toUpperCase(),
                                style: TextStyle(
                                  color: const Color(0xFF6C5CE7),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          // Role Badge
                          if (member.role == FamilyMemberRole.admin)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'ADMIN',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        member.role == FamilyMemberRole.admin ? 'Administrator' : 'Member',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white.withOpacity(0.6),
                  size: 20.sp,
                ),
              ],
            ),

            // Stats
            if (member.invitationStatus == InvitationStatus.accepted) ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _buildMemberStat(
                      'Allocated',
                      '\$${member.allocatedBalance.toStringAsFixed(2)}',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildMemberStat(
                      'Remaining',
                      '\$${member.remainingBalance.toStringAsFixed(2)}',
                      isPositive: remainingPercentage > 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildMemberStat(
                      'Spent Today',
                      '\$${member.spentToday.toStringAsFixed(2)}',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildMemberStat(
                      'This Month',
                      '\$${member.spentThisMonth.toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),

              // Progress Bar
              SizedBox(height: 12.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Utilization',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 11.sp,
                        ),
                      ),
                      Text(
                        '${utilizationPercentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: utilizationPercentage > 80
                              ? Colors.red
                              : utilizationPercentage > 50
                                  ? Colors.orange
                                  : Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: utilizationPercentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: utilizationPercentage > 80
                              ? Colors.red
                              : utilizationPercentage > 50
                                  ? Colors.orange
                                  : Colors.green,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else
              // Invitation Status Info
              SizedBox(height: 8.h),
              Text(
                'Invitation ${member.invitationStatus.name}',
                style: TextStyle(
                  color: const Color(0xFF6C5CE7),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberStat(String label, String value, {bool isPositive = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            color: isPositive ? Colors.green[300] : Colors.orange[300],
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.6),
          size: 18.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildSheetOption(
    IconData icon,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.4),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    IconData icon,
    String title,
    String description,
    VoidCallback onTap, {
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? Colors.white.withOpacity(0.6),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color ?? Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (description.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      description,
                      style: TextStyle(
                        color: color?.withOpacity(0.7) ?? Colors.white.withOpacity(0.5),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
