import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/core/utils/edge_case_validator.dart';

/// Security Settings Tab - Toggle switches for card security
class SecuritySettingsTab extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final AccountDetailsEntity? accountDetails;
  final bool isLoading;

  const SecuritySettingsTab({
    super.key,
    required this.accountArgs,
    this.accountDetails,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final details = accountDetails;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Control how your card can be used for transactions',
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

          // Security toggles
          Text(
            'Transaction Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          _buildToggleRow(
            context,
            icon: Icons.security_outlined,
            title: '3D Secure',
            subtitle: 'Extra verification for online payments',
            value: details?.enable3DSecure ?? false,
            onChanged: (value) => _onToggleChanged(context, '3DSecure', value, details),
          ),
          SizedBox(height: 12.h),

          _buildToggleRow(
            context,
            icon: Icons.nfc_outlined,
            title: 'Contactless Payments',
            subtitle: 'Tap to pay at checkout',
            value: details?.enableContactless ?? false,
            onChanged: (value) => _onToggleChanged(context, 'Contactless', value, details),
          ),
          SizedBox(height: 12.h),

          _buildToggleRow(
            context,
            icon: Icons.atm_outlined,
            title: 'ATM Withdrawals',
            subtitle: 'Cash withdrawals at ATMs',
            value: details?.enableATMWithdrawals ?? false,
            onChanged: (value) => _onToggleChanged(context, 'ATMWithdrawals', value, details),
          ),
          SizedBox(height: 12.h),

          _buildToggleRow(
            context,
            icon: Icons.shopping_cart_outlined,
            title: 'Online Payments',
            subtitle: 'E-commerce and in-app purchases',
            value: details?.enableOnlinePayments ?? false,
            onChanged: (value) => _onToggleChanged(context, 'OnlinePayments', value, details),
          ),
          SizedBox(height: 12.h),

          _buildToggleRow(
            context,
            icon: Icons.public_outlined,
            title: 'International Payments',
            subtitle: 'Transactions outside your country',
            value: details?.enableInternationalPayments ?? false,
            onChanged: (value) => _onToggleChanged(context, 'InternationalPayments', value, details),
          ),
          SizedBox(height: 32.h),

          // Security notice
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: const Color(0xFF10B981),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Your card is protected by our fraud detection system. You\'ll be notified of any suspicious activity.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
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
              color: value
                  ? const Color(0xFF6366F1).withValues(alpha: 0.15)
                  : const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: value ? const Color(0xFF6366F1) : const Color(0xFF9CA3AF),
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
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF6366F1),
            inactiveThumbColor: const Color(0xFF9CA3AF),
            inactiveTrackColor: const Color(0xFF2D2D2D),
          ),
        ],
      ),
    );
  }

  void _onToggleChanged(
    BuildContext context,
    String setting,
    bool value,
    AccountDetailsEntity? details,
  ) {
    if (details == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Loading account details...'),
          backgroundColor: Color(0xFFF59E0B),
        ),
      );
      return;
    }

    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }

    final new3DSecure = setting == '3DSecure' ? value : details.enable3DSecure;
    final newContactless = setting == 'Contactless' ? value : details.enableContactless;
    final newOnlinePayments = setting == 'OnlinePayments' ? value : details.enableOnlinePayments;
    final newATMWithdrawals = setting == 'ATMWithdrawals' ? value : details.enableATMWithdrawals;
    final newInternationalPayments = setting == 'InternationalPayments' ? value : details.enableInternationalPayments;

    final validation = SecuritySettingsValidator.validateSettings(
      enable3DSecure: new3DSecure,
      enableContactless: newContactless,
      enableOnlinePayments: newOnlinePayments,
      enableATMWithdrawals: newATMWithdrawals,
    );

    if (!validation.isValid) {
      ValidationDialog.show(
        context,
        title: 'Cannot Disable',
        message: validation.errorMessage ?? 'At least one payment method must remain enabled.',
      );
      return;
    }

    context.read<AccountActionsCubit>().updateSecuritySettings(
      accountId: accountId,
      enable3DSecure: new3DSecure,
      enableContactless: newContactless,
      enableOnlinePayments: newOnlinePayments,
      enableATMWithdrawals: newATMWithdrawals,
      enableInternationalPayments: newInternationalPayments,
    );
  }
}
