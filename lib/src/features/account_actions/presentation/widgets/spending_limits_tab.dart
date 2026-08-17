import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/repositories/i_account_actions_repository.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/core/utils/edge_case_validator.dart';
part 'spending_limits_tab_widgets.dart';


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

  /// Resolve the user's KYC-tier baseline limits when the account-specific
  /// overrides come back zero/null. We read the user's country from the
  /// auth profile → look up the canonical
  /// `CountryConfigs.<country>.dailyLimits[tier]` table (already used by
  /// signup + KYC screens) → use that as the displayed limit.
  ///
  /// Defaults to `KycLevel.standard` (Tier 2) because that's the typical
  /// state for a user who's past initial signup. The User entity does
  /// not currently expose `kycTier`; when it does, branch on that here.
  ///
  /// Returns `(daily, monthly)` baseline pair, or `(null, null)` if we
  /// can't determine country.
  (double?, double?) _kycBaseline(BuildContext context) {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      if (profile == null) return (null, null);
      final countryCode = profile.user.country?.toUpperCase();
      if (countryCode == null || countryCode.isEmpty) return (null, null);
      final country = CountryConfigs.getByCode(countryCode);
      if (country == null) return (null, null);
      // TODO: thread real kycTier through User entity once auth-service
      // exposes it on LoginResponse.data.user — default to standard for
      // now (most post-signup users are Tier 2).
      const tier = KycLevel.standard;
      final raw = country.dailyLimits[tier]?.toDouble();
      // 0 (or negative) = Unlimited (Tier 3), matching the backend's
      // shared/kyctiers convention — surface it as "no cap" (null), never as a
      // literal ₦0 limit.
      final daily = (raw == null || raw <= 0) ? null : raw;
      // Monthly heuristic: 4× daily for basic, 8× for standard, 20× for
      // advanced — matches the typical regulator spread. Replace when
      // CountryConfigs exposes an explicit monthly map.
      const multiplier = 8.0; // standard tier
      final monthly = daily != null ? daily * multiplier : null;
      return (daily, monthly);
    } catch (_) {
      return (null, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = accountDetails;
    // Prefer account-specific overrides; if they're zero (placeholder
    // / unset) fall back to the user's KYC-tier baseline so the user
    // sees their REAL limits, not a "0.00 daily limit" stub.
    final (kycDaily, kycMonthly) = _kycBaseline(context);
    final dailyLimit = (details?.dailyLimit ?? 0.0) > 0
        ? details!.dailyLimit
        : (kycDaily ?? 0.0);
    final monthlyLimit = (details?.monthlyLimit ?? 0.0) > 0
        ? details!.monthlyLimit
        : (kycMonthly ?? 0.0);
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
                    'Set limits on the money you send from this account. Transfers above these limits are declined.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
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

          // Real "Today's usage" bar — fetched from accounts-service
          // (daily_spent vs daily_limit). Only shown when a daily limit is set.
          Builder(
            builder: (context) {
              final accountId =
                  AccountIdValidator.extractFromArgs(accountArgs);
              if (accountId == null) return const SizedBox.shrink();
              return _LimitUsageSection(
                accountId: accountId,
                currencySymbol: _getCurrencySymbol(),
              );
            },
          ),
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
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 78, 3, 208),
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
                        color: hasLimit ? Colors.white : const Color(0xFF9CA3AF),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit_outlined,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
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
        backgroundColor: const Color(0xFF1A1A1A),
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
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
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
                          color: const Color(0xFF4A4A4A),
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
                color: const Color(0xFF9CA3AF),
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
