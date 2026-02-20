import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/core/utils/edge_case_validator.dart';

/// Manage Card Tab - Primary card actions
class ManageCardTab extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final AccountDetailsEntity? accountDetails;
  final bool isLoading;

  const ManageCardTab({
    super.key,
    required this.accountArgs,
    this.accountDetails,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final status = accountDetails?.status ?? accountArgs['status'] ?? 'active';
    final isFrozen = status.toLowerCase() == 'frozen' ||
                     status.toString().contains('blocked');

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Status Section
          _buildCardStatusSection(context, isFrozen),
          SizedBox(height: 24.h),

          // Quick Actions
          Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          // Freeze/Unfreeze Toggle
          _buildFreezeCardAction(context, isFrozen),
          SizedBox(height: 12.h),

          // View Card Details
          _buildViewCardDetailsAction(context),
          SizedBox(height: 12.h),

          // View PIN
          _buildViewPINAction(context),
          SizedBox(height: 24.h),

          // Block Options Section
          Text(
            'Block Options',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          // Temporarily Block
          _buildBlockAction(
            context,
            icon: Icons.pause_circle_outline,
            title: 'Temporarily Block',
            subtitle: 'Can be unblocked anytime',
            onTap: () => _onTemporarilyBlock(context),
            isLoading: isLoading,
          ),
          SizedBox(height: 12.h),

          // Permanently Block
          _buildBlockAction(
            context,
            icon: Icons.block_outlined,
            title: 'Permanently Block',
            subtitle: 'Cannot be undone',
            isWarning: true,
            onTap: () => _onPermanentlyBlock(context),
            isLoading: isLoading,
          ),
          SizedBox(height: 12.h),

          // Report Lost/Stolen
          _buildBlockAction(
            context,
            icon: Icons.warning_amber_outlined,
            title: 'Report Lost/Stolen',
            subtitle: 'Block card and order replacement',
            isCritical: true,
            onTap: () => _onReportStolen(context),
            isLoading: isLoading,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildCardStatusSection(BuildContext context, bool isFrozen) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: isFrozen
                  ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                  : const Color(0xFF10B981).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFrozen ? Icons.lock_outlined : Icons.verified_outlined,
              color: isFrozen ? const Color(0xFFEF4444) : const Color(0xFF10B981),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Status',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isFrozen ? 'Frozen' : 'Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_outlined,
            color: Colors.white.withValues(alpha: 0.5),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildFreezeCardAction(BuildContext context, bool isFrozen) {
    return _buildActionButton(
      context,
      icon: isFrozen ? Icons.lock_open_outlined : Icons.lock_outlined,
      title: isFrozen ? 'Unfreeze Card' : 'Freeze Card',
      subtitle: isFrozen
          ? 'Unblock your card for transactions'
          : 'Temporarily freeze your card',
      onTap: () => isFrozen ? _onUnfreeze(context) : _onFreeze(context),
      isLoading: isLoading,
    );
  }

  Widget _buildViewCardDetailsAction(BuildContext context) {
    return _buildActionButton(
      context,
      icon: Icons.visibility_outlined,
      title: 'View Card Details',
      subtitle: 'See your card number, expiry, and CVV',
      onTap: () => _onViewCardDetails(context),
    );
  }

  Widget _buildViewPINAction(BuildContext context) {
    return _buildActionButton(
      context,
      icon: Icons.pin_outlined,
      title: 'View PIN',
      subtitle: 'Reveal your 4-digit security PIN',
      onTap: () => _onViewPIN(context),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
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
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF3B82F6),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF3B82F6),
                    ),
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlockAction(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isWarning = false,
    bool isCritical = false,
    bool isLoading = false,
  }) {
    final color = isCritical
        ? const Color(0xFFEF4444)
        : isWarning
            ? const Color(0xFFF59E0B)
            : const Color(0xFF6B7280);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: color,
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
                        color: color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFreeze(BuildContext context) {
    // Validate card status before freezing
    final statusValidation = CardStatusValidator.canPerformAction(
      accountDetails?.status ?? accountArgs['status']?.toString(),
      action: 'freeze',
    );

    if (!statusValidation.isValid) {
      ValidationDialog.show(
        context,
        title: 'Cannot Freeze Card',
        message: statusValidation.errorMessage ?? 'Unable to freeze card',
      );
      return;
    }

    // Validate account ID
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Account ID not found. Please try again.',
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Freeze Card?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Your card will be temporarily frozen. You can unfreeze it at any time from this screen.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
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
              Get.back();
              context.read<AccountActionsCubit>().freezeAccount(
                accountId: accountId,
                reason: 'User requested freeze via app',
              );
            },
            child: Text(
              'Freeze',
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

  void _onUnfreeze(BuildContext context) {
    // Validate card status before unfreezing
    final statusValidation = CardStatusValidator.canPerformAction(
      accountDetails?.status ?? accountArgs['status']?.toString(),
      action: 'unfreeze',
    );

    if (!statusValidation.isValid) {
      ValidationDialog.show(
        context,
        title: 'Cannot Unfreeze Card',
        message: statusValidation.errorMessage ?? 'Unable to unfreeze card',
      );
      return;
    }

    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Account ID not found. Please try again.',
      );
      return;
    }

    context.read<AccountActionsCubit>().unfreezeAccount(
      accountId: accountId,
    );
  }

  void _onTemporarilyBlock(BuildContext context) {
    // Validate card status before blocking
    final statusValidation = CardStatusValidator.canPerformAction(
      accountDetails?.status ?? accountArgs['status']?.toString(),
      action: 'block',
    );

    if (!statusValidation.isValid) {
      ValidationDialog.show(
        context,
        title: 'Cannot Block Card',
        message: statusValidation.errorMessage ?? 'Unable to block card',
      );
      return;
    }

    // Validate account ID
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Account ID not found. Please try again.',
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Temporarily Block Card?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Your card will be blocked but can be unblocked at any time. No new transactions will be possible.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
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
              Get.back();
              context.read<AccountActionsCubit>().temporarilyBlockCard(
                accountId: accountId,
              );
            },
            child: Text(
              'Block',
              style: TextStyle(
                color: const Color(0xFFF59E0B),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPermanentlyBlock(BuildContext context) {
    // Validate card status before blocking
    final statusValidation = CardStatusValidator.canPerformAction(
      accountDetails?.status ?? accountArgs['status']?.toString(),
      action: 'block',
    );

    if (!statusValidation.isValid) {
      ValidationDialog.show(
        context,
        title: 'Cannot Block Card',
        message: statusValidation.errorMessage ?? 'Unable to block card',
      );
      return;
    }

    // Validate account ID
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Account ID not found. Please try again.',
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Permanently Block Card?',
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
              'This action cannot be undone. Your card will be permanently blocked and you\'ll need to order a replacement.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: const Color(0xFFF59E0B),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'You can still access your account and funds, but card transactions will be disabled.',
                      style: TextStyle(
                        color: const Color(0xFFF59E0B),
                        fontSize: 11.sp,
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
              Get.back();
              context.read<AccountActionsCubit>().permanentlyBlockCard(
                accountId: accountId,
              );
            },
            child: Text(
              'Block',
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onReportStolen(BuildContext context) {
    // Validate account ID first
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Account ID not found. Please try again.',
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: const Color(0xFFEF4444),
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Report Card as Stolen',
                style: TextStyle(
                  color: const Color(0xFFEF4444),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This will immediately block your card and a new replacement will be shipped to your registered address.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'What happens next:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _buildStep('1', 'Your card is blocked immediately'),
            SizedBox(height: 4.h),
            _buildStep('2', 'New card ships to your address'),
            SizedBox(height: 4.h),
            _buildStep('3', 'Monitor account for suspicious activity'),
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
              Get.back();
              context.read<AccountActionsCubit>().reportStolenCard(
                accountId: accountId,
              );
            },
            child: Text(
              'Report Stolen',
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _onViewCardDetails(BuildContext context) {
    // Validate account ID first
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }

    final pinController = TextEditingController();
    final isValid = ValueNotifier<bool>(false);

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Authenticate to View',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fingerprint,
              color: const Color(0xFF3B82F6),
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Enter your transaction PIN to view card details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ValueListenableBuilder<bool>(
              valueListenable: isValid,
              builder: (context, isPinValid, _) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isPinValid
                          ? const Color(0xFF10B981).withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      letterSpacing: 8.w,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '••••',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      counterText: '',
                    ),
                    onChanged: (value) {
                      final validation = PinValidator.validateFormat(value);
                      isValid.value = validation.isValid;
                    },
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              pinController.dispose();
              isValid.dispose();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isValid,
            builder: (context, isPinValid, _) {
              return TextButton(
                onPressed: isPinValid
                    ? () {
                        Get.back();
                        context.read<AccountActionsCubit>().revealCardDetails(
                          accountId: accountId,
                          transactionPin: pinController.text,
                        );
                        pinController.dispose();
                        isValid.dispose();
                      }
                    : null,
                child: Text(
                  'View',
                  style: TextStyle(
                    color: isPinValid
                        ? const Color(0xFF3B82F6)
                        : Colors.white.withValues(alpha: 0.3),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onViewPIN(BuildContext context) {
    // Validate account ID first
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }

    final pinController = TextEditingController();
    final isValid = ValueNotifier<bool>(false);

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Authenticate to View PIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fingerprint,
              color: const Color(0xFF3B82F6),
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Enter your transaction PIN to reveal your card PIN',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ValueListenableBuilder<bool>(
              valueListenable: isValid,
              builder: (context, isPinValid, _) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isPinValid
                          ? const Color(0xFF10B981).withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      letterSpacing: 8.w,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '••••',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      counterText: '',
                    ),
                    onChanged: (value) {
                      final validation = PinValidator.validateFormat(value);
                      isValid.value = validation.isValid;
                    },
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              pinController.dispose();
              isValid.dispose();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isValid,
            builder: (context, isPinValid, _) {
              return TextButton(
                onPressed: isPinValid
                    ? () {
                        Get.back();
                        context.read<AccountActionsCubit>().revealPIN(
                          accountId: accountId,
                          transactionPin: pinController.text,
                        );
                        pinController.dispose();
                        isValid.dispose();
                      }
                    : null,
                child: Text(
                  'View',
                  style: TextStyle(
                    color: isPinValid
                        ? const Color(0xFF3B82F6)
                        : Colors.white.withValues(alpha: 0.3),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
