import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/core/utils/edge_case_validator.dart';

/// Account Controls Tab — real, account-level transaction controls for the
/// virtual account (Lazervault has no card product). Replaces the old card-only
/// "Security" toggles (3D Secure / contactless / ATM / online payments) which
/// were backend stubs. The two controls here are both enforced server-side:
///   • Freeze account   → accounts-service blocks every outgoing debit/hold.
///   • International transfers → exchange-service refuses send-abroad when off.
class AccountControlsTab extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final AccountDetailsEntity? accountDetails;
  final bool isLoading;

  const AccountControlsTab({
    super.key,
    required this.accountArgs,
    this.accountDetails,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final details = accountDetails;
    final isFrozen = details?.isFrozen ?? false;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.tune_outlined,
                    color: const Color(0xFF4E03D0), size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Control how money can move out of this account',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Text(
            'Transaction controls',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          // Freeze account — blocks all outgoing transfers and payments.
          _buildToggleRow(
            context,
            icon: isFrozen ? Icons.ac_unit : Icons.lock_outline,
            title: 'Freeze account',
            subtitle: isFrozen
                ? 'Outgoing transfers and payments are blocked'
                : 'Instantly block all outgoing transfers and payments',
            value: isFrozen,
            activeColor: const Color(0xFFEF4444),
            onChanged: details == null
                ? null
                : (value) => _onFreezeChanged(context, value, details),
          ),
          SizedBox(height: 12.h),

          // International transfers — gates the send-abroad / exchange flow.
          _buildToggleRow(
            context,
            icon: Icons.public_outlined,
            title: 'Allow international transfers',
            subtitle: 'Let this account send money abroad',
            value: details?.allowInternationalTransfers ?? true,
            onChanged: details == null
                ? null
                : (value) => _onInternationalChanged(context, value, details),
          ),
          SizedBox(height: 24.h),

          // Notice
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.shield_outlined,
                    color: const Color(0xFF10B981), size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'These controls apply only to this account and take effect immediately. Incoming money is never blocked.',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        height: 1.5),
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
    required ValueChanged<bool>? onChanged,
    Color activeColor = const Color(0xFF4E03D0),
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
                  ? activeColor.withValues(alpha: 0.15)
                  : const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: value ? activeColor : const Color(0xFF9CA3AF),
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
            activeTrackColor: activeColor,
            inactiveThumbColor: const Color(0xFF9CA3AF),
            inactiveTrackColor: const Color(0xFF2D2D2D),
          ),
        ],
      ),
    );
  }

  String? _accountId(BuildContext context) {
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
    }
    return accountId;
  }

  void _onFreezeChanged(
    BuildContext context,
    bool freeze,
    AccountDetailsEntity details,
  ) {
    final accountId = _accountId(context);
    if (accountId == null) return;
    final cubit = context.read<AccountActionsCubit>();

    if (!freeze) {
      cubit.unfreezeAccount(accountId: accountId);
      return;
    }

    // Freezing is disruptive — confirm before blocking outgoing money.
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Color(0xFF2A2A2D)),
        ),
        title: Text(
          'Freeze this account?',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600),
        ),
        content: Text(
          'While frozen, you can\'t send transfers or make payments from this account. Money can still come in. You can unfreeze it anytime.',
          style: TextStyle(
              color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              cubit.freezeAccount(
                accountId: accountId,
                reason: 'User froze account in app',
              );
            },
            child: Text('Freeze',
                style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  void _onInternationalChanged(
    BuildContext context,
    bool allowed,
    AccountDetailsEntity details,
  ) {
    final accountId = _accountId(context);
    if (accountId == null) return;
    context.read<AccountActionsCubit>().setInternationalTransfers(
          accountId: accountId,
          allowed: allowed,
        );
  }
}
