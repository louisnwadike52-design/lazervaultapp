import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

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
  final FamilyAccountCubit _transactionsCubit = serviceLocator<FamilyAccountCubit>();
  late TabController _tabController;
  FamilyTransactionType? _transactionFilter;
  String? _memberFilter; // memberId to filter by
  bool _activityLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadFamilyAccount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.index == 2 && !_activityLoaded) {
      _activityLoaded = true;
      _loadTransactions();
    }
  }

  void _loadTransactions() {
    _transactionsCubit.loadTransactions(
      familyId: widget.familyId,
      memberId: _memberFilter,
      type: _transactionFilter,
    );
  }

  void _loadFamilyAccount() {
    _cubit.loadFamilyAccount(widget.familyId);
  }

  void _showAddMemberSheet() {
    // Navigate directly to the new invite member flow screen
    Get.toNamed(AppRoutes.familyInviteMemberFlow, arguments: {
      'familyId': widget.familyId,
    })?.then((result) {
      // Reload the family account if a member was added
      if (result == true) {
        _loadFamilyAccount();
      }
    });
  }

  void _showMemberOptions(FamilyMember member) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
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
                color: Colors.white.withValues(alpha: 0.3),
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
                        const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        const Color(0xFF60A5FA).withValues(alpha: 0.1),
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
                              ? const Color(0xFF3B82F6)
                              : Colors.white.withValues(alpha: 0.6),
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
                _showMemberDetailSheet(member);
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
        backgroundColor: const Color(0xFF0A0A0A),
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
                labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
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
                labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
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
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
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
              backgroundColor: const Color(0xFF3B82F6),
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

  void _showMemberDetailSheet(FamilyMember member) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Avatar + Name + Role
              Center(
                child: Container(
                  width: 72.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        const Color(0xFF60A5FA).withValues(alpha: 0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: member.avatarUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(36.r),
                          child: Image.network(member.avatarUrl!, fit: BoxFit.cover),
                        )
                      : Icon(Icons.person, size: 36.sp, color: Colors.white),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  member.fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: member.isAdmin
                        ? Colors.orange.withValues(alpha: 0.2)
                        : const Color(0xFF3B82F6).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    member.role.displayName,
                    style: TextStyle(
                      color: member.isAdmin ? Colors.orange : const Color(0xFF3B82F6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Contact info
              if (member.email != null || member.phone != null || member.username != null) ...[
                Center(
                  child: Text(
                    member.username ?? member.email ?? member.phone ?? '',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],

              // Balance Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF3B82F6).withValues(alpha: 0.15),
                      const Color(0xFF60A5FA).withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailStat(
                            'Allocated',
                            '\$${member.allocatedBalance.toStringAsFixed(2)}',
                          ),
                        ),
                        Expanded(
                          child: _buildDetailStat(
                            'Remaining',
                            '\$${member.remainingBalance.toStringAsFixed(2)}',
                            valueColor: member.remainingBalance > 0
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailStat(
                            'Spent Today',
                            '\$${member.spentToday.toStringAsFixed(2)}',
                          ),
                        ),
                        Expanded(
                          child: _buildDetailStat(
                            'Spent This Month',
                            '\$${member.spentThisMonth.toStringAsFixed(2)}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Limits Section
              Text(
                'Spending Limits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              if (member.hasDailyLimit)
                _buildLimitBar(
                  'Daily Limit',
                  member.spentToday,
                  member.dailySpendingLimit,
                ),
              if (member.hasMonthlyLimit) ...[
                SizedBox(height: 10.h),
                _buildLimitBar(
                  'Monthly Limit',
                  member.spentThisMonth,
                  member.monthlySpendingLimit,
                ),
              ],
              if (member.hasPerTransactionLimit) ...[
                SizedBox(height: 10.h),
                _buildInfoRow(
                  Icons.payment,
                  'Per Transaction',
                  '\$${member.perTransactionLimit.toStringAsFixed(2)}',
                ),
              ],
              if (!member.hasDailyLimit && !member.hasMonthlyLimit && !member.hasPerTransactionLimit)
                Text(
                  'No spending limits set',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13.sp,
                  ),
                ),
              SizedBox(height: 20.h),

              // Card Info
              if (member.hasCard) ...[
                Text(
                  'Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildInfoRow(
                  Icons.credit_card,
                  'Card',
                  '**** ${member.cardLastFour ?? '----'}',
                ),
                SizedBox(height: 20.h),
              ],

              // Actions
              if (member.role != FamilyMemberRole.admin) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.familyEditMemberLimits,
                            arguments: {
                              'familyId': widget.familyId,
                              'member': member,
                            },
                          );
                        },
                        icon: Icon(Icons.edit, size: 18.sp),
                        label: Text('Edit Limits', style: TextStyle(fontSize: 13.sp)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                          _showAllocateFundsDialog(member);
                        },
                        icon: Icon(Icons.account_balance_wallet, size: 18.sp),
                        label: Text('Allocate', style: TextStyle(fontSize: 13.sp)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailStat(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLimitBar(String label, double used, double limit) {
    final percentage = limit > 0 ? (used / limit).clamp(0.0, 1.0) : 0.0;
    final percentText = (percentage * 100).toStringAsFixed(0);
    final barColor = percentage > 0.8
        ? const Color(0xFFEF4444)
        : percentage > 0.5
            ? const Color(0xFFFB923C)
            : const Color(0xFF10B981);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
              ),
            ),
            Text(
              '\$${used.toStringAsFixed(2)} / \$${limit.toStringAsFixed(2)} ($percentText%)',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmRemoveMember(FamilyMember member) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
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
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
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

  void _showContributeDialog(FamilyAccount account) {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Contribute to Pool',
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
              'Add funds to the family pool for everyone to use.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
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
                labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
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
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                Get.back();
                // Find current user's member ID from auth state
                String memberId = '';
                final authState = context.read<AuthenticationCubit>().state;
                if (authState is AuthenticationSuccess) {
                  final currentUserId = authState.profile.userId;
                  final currentMember = account.members
                      .where((m) => m.userId == currentUserId)
                      .firstOrNull;
                  memberId = currentMember?.id ?? '';
                }
                if (memberId.isEmpty && account.members.isNotEmpty) {
                  memberId = account.members.first.id;
                }
                _cubit.contributeToPool(
                  familyId: widget.familyId,
                  memberId: memberId,
                  amount: amount,
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Contribute',
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
          color: const Color(0xFF0A0A0A),
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
                color: Colors.white.withValues(alpha: 0.3),
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
        backgroundColor: const Color(0xFF0A0A0A),
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
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _cubit.freezeAccount(familyId: widget.familyId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
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
        backgroundColor: const Color(0xFF0A0A0A),
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
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: confirmationController,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Type "DELETE" to confirm',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
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
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
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
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
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
            } else if (state is MemberContributionProcessed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contribution processed successfully'),
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
                child: CircularProgressIndicator(color: const Color(0xFF3B82F6)),
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
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelColor: const Color(0xFF3B82F6),
                      unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
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
                  const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  const Color(0xFF60A5FA).withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
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
                      color: const Color(0xFF3B82F6),
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
                                color: Colors.white.withValues(alpha: 0.6),
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
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: account.status == FamilyAccountStatus.active
                    ? Colors.green.withValues(alpha: 0.3)
                    : Colors.blue.withValues(alpha: 0.3),
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
          if (account.allowMemberContributions) ...[
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () => _showContributeDialog(account),
                icon: Icon(Icons.volunteer_activism, size: 20.sp),
                label: Text(
                  'Contribute to Pool',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
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
                backgroundColor: const Color(0xFF3B82F6),
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
    final activeMembers = account.members
        .where((m) => m.invitationStatus == InvitationStatus.accepted)
        .toList();

    return Column(
      children: [
        // Member filter
        if (activeMembers.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                _buildMemberChip('All Members', null),
                ...activeMembers.map((m) => Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: _buildMemberChip(
                        m.fullName.isNotEmpty ? m.fullName : (m.username ?? 'Member'),
                        m.id,
                      ),
                    )),
              ],
            ),
          ),
        // Type filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          child: Row(
            children: [
              _buildFilterChip('All', null),
              SizedBox(width: 8.w),
              _buildFilterChip('Allocation', FamilyTransactionType.allocation),
              SizedBox(width: 8.w),
              _buildFilterChip('Spending', FamilyTransactionType.spending),
              SizedBox(width: 8.w),
              _buildFilterChip('Refund', FamilyTransactionType.refund),
              SizedBox(width: 8.w),
              _buildFilterChip('Contribution', FamilyTransactionType.contribution),
            ],
          ),
        ),
        // Transaction list
        Expanded(
          child: BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
            bloc: _transactionsCubit,
            builder: (context, state) {
              if (state is FamilyAccountLoading) {
                return Center(
                  child: CircularProgressIndicator(color: const Color(0xFF3B82F6)),
                );
              }
              if (state is FamilyTransactionsLoaded) {
                if (state.transactions.isEmpty) {
                  return _buildEmptyActivityState();
                }
                return RefreshIndicator(
                  onRefresh: () async => _loadTransactions(),
                  color: const Color(0xFF3B82F6),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      return _buildTransactionCard(state.transactions[index]);
                    },
                  ),
                );
              }
              return _buildEmptyActivityState();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, FamilyTransactionType? type) {
    final isSelected = _transactionFilter == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _transactionFilter = type;
        });
        _loadTransactions();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.white.withValues(alpha: 0.6),
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildMemberChip(String label, String? memberId) {
    final isSelected = _memberFilter == memberId;
    return GestureDetector(
      onTap: () {
        setState(() {
          _memberFilter = memberId;
        });
        _loadTransactions();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF10B981).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF10B981)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (memberId != null) ...[
              Icon(
                Icons.person,
                size: 14.sp,
                color: isSelected ? const Color(0xFF10B981) : Colors.white.withValues(alpha: 0.6),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF10B981) : Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(FamilyTransaction transaction) {
    final isCredit = transaction.type == FamilyTransactionType.allocation ||
        transaction.type == FamilyTransactionType.refund ||
        transaction.type == FamilyTransactionType.contribution;
    final amountColor = isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final amountPrefix = isCredit ? '+' : '-';

    IconData typeIcon;
    switch (transaction.type) {
      case FamilyTransactionType.allocation:
        typeIcon = Icons.account_balance_wallet;
      case FamilyTransactionType.spending:
        typeIcon = Icons.shopping_cart;
      case FamilyTransactionType.refund:
        typeIcon = Icons.replay;
      case FamilyTransactionType.adjustment:
        typeIcon = Icons.tune;
      case FamilyTransactionType.removal:
        typeIcon = Icons.person_remove;
      case FamilyTransactionType.contribution:
        typeIcon = Icons.volunteer_activism;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(typeIcon, color: amountColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.memberName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  transaction.description ?? transaction.type.displayName,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountPrefix\$${transaction.amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  color: amountColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${transaction.createdAt.day}/${transaction.createdAt.month}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyActivityState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Icon(
          Icons.history,
          size: 48.sp,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        SizedBox(height: 16.h),
        Center(
          child: Text(
            'No transactions yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            'Transactions will appear here as members use the account',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF3B82F6),
            size: 18.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
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
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: member.invitationStatus == InvitationStatus.accepted
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFF3B82F6).withValues(alpha: 0.3),
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
                        const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        const Color(0xFF60A5FA).withValues(alpha: 0.1),
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
                                color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                member.invitationStatus.name.toUpperCase(),
                                style: TextStyle(
                                  color: const Color(0xFF3B82F6),
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
                                color: Colors.orange.withValues(alpha: 0.2),
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
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white.withValues(alpha: 0.6),
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
                          color: Colors.white.withValues(alpha: 0.6),
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
                      color: Colors.white.withValues(alpha: 0.1),
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
                  color: const Color(0xFF3B82F6),
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
            color: Colors.white.withValues(alpha: 0.5),
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
          color: Colors.white.withValues(alpha: 0.6),
          size: 18.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
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
              color: color ?? Colors.white.withValues(alpha: 0.6),
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
                        color: color?.withValues(alpha: 0.7) ?? Colors.white.withValues(alpha: 0.5),
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
