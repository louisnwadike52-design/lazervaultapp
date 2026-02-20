import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/core/utils/edge_case_validator.dart';

/// Spending Limits Tab - View and edit spending limits
class SpendingLimitsTab extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final AccountDetailsEntity? accountDetails;
  final bool isLoading;

  const SpendingLimitsTab({
    super.key,
    required this.accountArgs,
    this.accountDetails,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final details = accountDetails;
    final dailyLimit = details?.dailyLimit ?? 0.0;
    final monthlyLimit = details?.monthlyLimit ?? 0.0;
    final singleLimit = details?.singleTransactionLimit;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFFF59E0B),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Set limits to control your spending. Transactions above these limits will be declined.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Daily Limit
          _buildLimitSection(
            context,
            icon: Icons.today_outlined,
            title: 'Daily Limit',
            limit: dailyLimit,
            subtitle: 'Per calendar day',
            onTap: () => _onEditLimit(context, 'daily', dailyLimit),
          ),
          SizedBox(height: 16.h),

          // Monthly Limit
          _buildLimitSection(
            context,
            icon: Icons.calendar_month_outlined,
            title: 'Monthly Limit',
            limit: monthlyLimit,
            subtitle: 'Per calendar month',
            onTap: () => _onEditLimit(context, 'monthly', monthlyLimit),
          ),
          SizedBox(height: 16.h),

          // Single Transaction Limit
          _buildLimitSection(
            context,
            icon: Icons.payment_outlined,
            title: 'Single Transaction',
            limit: singleLimit,
            subtitle: 'Maximum per transaction',
            onTap: () => _onEditLimit(context, 'single', singleLimit),
            placeholder: 'Not set',
          ),
          SizedBox(height: 32.h),

          // Progress bars
          if (details?.balance != null)
            _buildUsageSection(details!),
        ],
      ),
    );
  }

  Widget _buildLimitSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double? limit,
    required String subtitle,
    required VoidCallback onTap,
    String placeholder = 'No limit set',
  }) {
    final currencySymbol = _getCurrencySymbol();
    final hasLimit = limit != null && limit > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF8B5CF6),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      hasLimit ? '$currencySymbol${limit.toStringAsFixed(2)}' : placeholder,
                      style: TextStyle(
                        color: hasLimit ? Colors.white : Colors.white.withValues(alpha: 0.5),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit_outlined,
                color: Colors.white.withValues(alpha: 0.5),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageSection(AccountDetailsEntity details) {
    final dailyLimit = details.dailyLimit;
    final balance = details.balance;

    // Calculate percentage (assuming balance is daily spend for demo)
    final usedPercentage = dailyLimit > 0 ? (balance / dailyLimit).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Usage',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: usedPercentage,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6),
                    const Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_getCurrencySymbol()}${balance.toStringAsFixed(2)} spent',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
              ),
            ),
            Text(
              '${_getCurrencySymbol()}${dailyLimit.toStringAsFixed(2)} limit',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onEditLimit(BuildContext context, String limitType, double? currentValue) {
    final TextEditingController controller = TextEditingController(
      text: currentValue != null && currentValue > 0
          ? currentValue.toStringAsFixed(2)
          : '',
    );

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Edit ${_formatLimitName(limitType)} Limit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter 0 to remove the limit.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    _getCurrencySymbol(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Validate the amount
              final (validation, value) = AmountValidator.validateSpendingLimit(
                controller.text,
                limitType: limitType,
              );

              if (!validation.isValid) {
                // Show error and keep dialog open
                return;
              }

              Get.back();
              final accountId = AccountIdValidator.extractFromArgs(accountArgs);
              if (accountId == null) {
                ValidationDialog.show(
                  context,
                  title: 'Error',
                  message: 'Account ID not found. Please try again.',
                );
                return;
              }

              // Call cubit to update limit
              switch (limitType) {
                case 'daily':
                  context.read<AccountActionsCubit>().updateSpendingLimits(
                    accountId: accountId,
                    dailyLimit: value,
                  );
                  break;
                case 'monthly':
                  context.read<AccountActionsCubit>().updateSpendingLimits(
                    accountId: accountId,
                    monthlyLimit: value,
                  );
                  break;
                case 'single':
                  context.read<AccountActionsCubit>().updateSpendingLimits(
                    accountId: accountId,
                    singleTransactionLimit: value,
                  );
                  break;
              }
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLimitName(String type) {
    switch (type) {
      case 'daily':
        return 'Daily';
      case 'monthly':
        return 'Monthly';
      case 'single':
        return 'Single Transaction';
      default:
        return type;
    }
  }

  String _getCurrencySymbol() {
    final currency = accountArgs['currency'] as String? ?? 'NGN';
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return '₦';
    }
  }
}
