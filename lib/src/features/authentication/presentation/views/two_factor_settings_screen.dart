import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/authentication/domain/entities/two_factor_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/two_factor_widgets.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

/// Screen for managing two-factor authentication settings
class TwoFactorSettingsScreen extends StatefulWidget {
  const TwoFactorSettingsScreen({super.key});

  @override
  State<TwoFactorSettingsScreen> createState() => _TwoFactorSettingsScreenState();
}

class _TwoFactorSettingsScreenState extends State<TwoFactorSettingsScreen> {
  TwoFactorStatus? _status;
  bool _isLoading = true;
  TwoFactorMethod _selectedMethod = TwoFactorMethod.totp; // inline-enable picker
  bool _enabling = false;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    setState(() => _isLoading = true);

    try {
      final cubit = context.read<AuthenticationCubit>();
      final status = await cubit.getTwoFactorStatus();

      setState(() {
        _status = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        Get.snackbar(
          'Error',
          'Failed to load 2FA status: ${e.toString()}',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
        );
      }
    }
  }

  /// Enable the picked method entirely from THIS screen via bottom sheets — no
  /// separate setup screen. TOTP: enable → show the QR/secret/backup-codes +
  /// verify sheet. SMS/Email: enable (sends a code) → verify sheet. All finish
  /// by reloading status in place.
  Future<void> _enableSelected() async {
    final cubit = context.read<AuthenticationCubit>();

    // Authenticator (TOTP) enrollment is gated behind the transaction PIN: an
    // enrolled authenticator can RESET the transaction PIN (see ForgotPinScreen),
    // so enabling one must prove ownership of the current PIN first. This closes
    // the loop where a hijacked session could enroll its own authenticator and
    // use it to take over the PIN. Skipped when the user has no PIN yet (nothing
    // to protect — they can set one later, and the reset path needs a PIN to
    // exist anyway).
    if (_selectedMethod == TwoFactorMethod.totp) {
      final passed = await _confirmTransactionPinForEnrollment();
      if (!mounted || !passed) return;
    }

    setState(() => _enabling = true);
    final setup = await cubit.enableTwoFactor(_selectedMethod);
    if (!mounted) return;
    setState(() => _enabling = false);
    if (!setup.verificationRequired) return; // failure (cubit already snackbar'd)

    final bool? ok;
    if (_selectedMethod == TwoFactorMethod.totp) {
      // Authenticator: QR + manual key + backup codes + verify, all in one sheet.
      ok = await TotpSetupSheet.show(
        context,
        setup: setup,
        onVerify: (code) async {
          final userId = cubit.currentProfile?.user.id ?? '';
          return cubit.completeTwoFactorSetup(userId, code);
        },
      );
    } else {
      // SMS/Email: the code was just sent — collect + verify.
      ok = await TwoFactorVerifySheet.show(
        context,
        subtitle: 'Enter the 6-digit code we just sent you to finish.',
        onVerify: (code) async {
          final userId = cubit.currentProfile?.user.id ?? '';
          return cubit.completeTwoFactorSetup(userId, code);
        },
      );
    }
    if (ok == true && mounted) {
      // Refresh the cached profile so `user.twoFactorEnabled/twoFactorMethod`
      // reflect the new enrollment immediately — the transaction-PIN reset flow
      // reads them to decide whether the authenticator option is available.
      await cubit.refreshProfile();
      if (mounted) await _loadStatus();
    }
  }

  /// Gate authenticator enrollment behind the transaction PIN.
  ///
  /// Returns true if enrollment may proceed:
  ///   • the user has no transaction PIN yet (nothing to confirm), OR
  ///   • they entered the correct PIN (verified server-side via
  ///     [ITransactionPinService.verifyPin], which also enforces lockout).
  /// Returns false if they cancelled or failed verification.
  Future<bool> _confirmTransactionPinForEnrollment() async {
    final pinService = serviceLocator<ITransactionPinService>();

    bool hasPin;
    try {
      // Bounded — a stalled check must not hang enrollment. Fail-open (treat as
      // "no PIN" → skip the gate) on error/timeout, matching the existing catch.
      hasPin = await pinService
          .checkUserHasPin()
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      // If we can't determine PIN status, don't hard-block enabling 2FA.
      hasPin = false;
    }
    if (!hasPin) return true;
    if (!mounted) return false;

    final pin = await showTransactionPinModal(
      context,
      title: 'Confirm your PIN',
      message:
          'Enter your transaction PIN to enable an authenticator app. You can '
          'use it to reset your PIN later, so we confirm it now.',
    );
    if (pin == null || pin.length != 4) return false; // cancelled / dismissed

    try {
      // Bounded — on timeout the catch below fails CLOSED (aborts enrollment),
      // which is correct: if we can't verify the PIN we must not enroll.
      final res = await pinService
          .verifyPin(
            pin: pin,
            transactionId: '2fa-enroll',
            transactionType: '2fa_enrollment',
            amount: 0,
            currency: 'NGN',
          )
          .timeout(const Duration(seconds: 15));
      if (res.success) return true;

      if (mounted) {
        final locked = res.isLocked || res.isLockedUntil;
        _snack(
          locked
              ? 'Your PIN is temporarily locked. Try again later.'
              : (res.remainingAttempts > 0
                  ? 'Incorrect PIN. ${res.remainingAttempts} '
                      '${res.remainingAttempts == 1 ? "attempt" : "attempts"} remaining.'
                  : 'Incorrect PIN. Please try again.'),
          isError: true,
        );
      }
      return false;
    } catch (_) {
      if (mounted) {
        _snack('Could not verify your PIN. Please try again.', isError: true);
      }
      return false;
    }
  }

  void _snack(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(15.w),
      borderRadius: 10.r,
    );
  }

  /// Where the current 2FA code comes from, phrased for the active method — the
  /// same wording used during setup ("from your authenticator app", etc.).
  String _codeSourceHint(TwoFactorMethod method) {
    switch (method) {
      case TwoFactorMethod.totp:
        return 'Enter the 6-digit code from your authenticator app to confirm.';
      case TwoFactorMethod.sms:
        return 'Enter the 6-digit code we sent to your phone to confirm.';
      case TwoFactorMethod.email:
        return 'Enter the 6-digit code we sent to your email to confirm.';
    }
  }

  /// Confirm-disable via a proper 6-box PIN sheet (matching the setup UI) with
  /// method-aware copy. On success flips the screen back to the disabled state.
  Future<void> _showDisableDialog() async {
    final cubit = context.read<AuthenticationCubit>();
    final method = _status?.method ?? TwoFactorMethod.totp;
    // SMS/Email: make sure a fresh code is on its way before we ask for it.
    if (method != TwoFactorMethod.totp) {
      await cubit.sendTwoFactorCode();
    }
    if (!mounted) return;

    final ok = await TwoFactorVerifySheet.show(
      context,
      title: 'Confirm disable',
      subtitle: _codeSourceHint(method),
      actionLabel: 'Disable 2FA',
      icon: Icons.gpp_bad_rounded,
      iconColor: Colors.red,
      destructive: true,
      onVerify: (code) async {
        try {
          return await cubit.disableTwoFactor(code);
        } catch (_) {
          return false;
        }
      },
    );

    if (ok == true && mounted) {
      // Keep the cached profile in sync so downstream flows (e.g. PIN reset)
      // no longer offer the authenticator as a verification option.
      await cubit.refreshProfile();
      if (!mounted) return;
      setState(() => _status = const TwoFactorStatus.disabled());
      Get.snackbar(
        'Success',
        'Two-factor authentication disabled',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  /// Only one 2FA method can be active at a time. If the user picks a different
  /// method while one is enabled, explain and offer to disable the active one
  /// first (which then reveals the picker so they can enable the new one).
  Future<void> _promptSwitchMethod(TwoFactorMethod target) async {
    final active = _status?.method;
    if (active == null || active == target) return;

    final proceed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.swap_horiz_rounded, color: Colors.orange.shade800, size: 22.sp),
            SizedBox(width: 10.w),
            const Expanded(child: Text('Switch 2FA method?')),
          ],
        ),
        content: Text(
          '${active.displayName} is currently active. Only one method can be on at '
          'a time — disable ${active.displayName} first, then set up ${target.displayName}.',
          style: TextStyle(fontSize: 14.sp, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Disable ${active.displayName}'),
          ),
        ],
      ),
    );
    if (proceed != true || !mounted) return;

    // Run the disable flow; on success the screen shows the disabled state with
    // the method picker, pre-selecting the target so the user just taps Enable.
    await _showDisableDialog();
    if (mounted && !(_status?.enabled ?? false)) {
      setState(() => _selectedMethod = target);
    }
  }

  Future<void> _regenerateBackupCodes() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Regenerate Backup Codes?'),
        content: const Text(
          'Your old backup codes will be invalidated. Make sure you have saved the new ones securely.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child: const Text('Regenerate'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    // Collect the current code via the same 6-box PIN sheet, then regenerate.
    final method = _status?.method ?? TwoFactorMethod.totp;
    if (method != TwoFactorMethod.totp) {
      await context.read<AuthenticationCubit>().sendTwoFactorCode();
      if (!mounted) return;
    }
    List<String>? newCodes;
    await TwoFactorVerifySheet.show(
      context,
      title: 'Confirm your identity',
      subtitle: _codeSourceHint(method),
      actionLabel: 'Regenerate codes',
      icon: Icons.key_rounded,
      iconColor: Colors.orange.shade700,
      onVerify: (code) async {
        try {
          final codes =
              await context.read<AuthenticationCubit>().regenerateBackupCodes(code);
          if (codes.isNotEmpty) {
            newCodes = codes;
            return true;
          }
          return false;
        } catch (_) {
          return false;
        }
      },
    );

    if (newCodes != null && mounted) {
      _showBackupCodesDialog(newCodes!);
    }
  }

  void _showBackupCodesDialog(List<String> codes) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('New Backup Codes'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Save these codes in a secure location. You won\'t be able to see them again!',
                style: TextStyle(color: Colors.orange),
              ),
              SizedBox(height: 20.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: codes.map((code) {
                  final formattedCode = '${code.substring(0, 4)}-${code.substring(4)}';
                  return InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: code));
                      Get.snackbar(
                        'Copied',
                        'Code copied to clipboard',
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        formattedCode,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child: const Text('I\'ve Saved Them'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: LazerVaultLoader.small(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Two-Factor Authentication'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusCard(),
              SizedBox(height: 24.h),
              if (_status?.enabled ?? false) ...[
                _buildCurrentMethodInfo(),
                SizedBox(height: 24.h),
                _buildOtherMethods(),
                SizedBox(height: 24.h),
                _buildBackupCodesSection(),
                SizedBox(height: 24.h),
                _buildDangerZone(),
              ] else
                _buildDisabledState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    final isEnabled = _status?.enabled ?? false;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isEnabled ? Colors.green.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isEnabled
              ? Colors.green.shade200
              : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isEnabled
                  ? Colors.green
                  : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEnabled ? Icons.check_rounded : Icons.lock_open_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnabled ? '2FA Enabled' : '2FA Disabled',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isEnabled
                        ? Colors.green.shade900
                        : Colors.grey.shade700,
                  ),
                ),
                if (_status?.method != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Method: ${_status!.method!.displayName}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isEnabled
                          ? Colors.green.shade700
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentMethodInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getMethodIcon(_status!.method!),
                color: Colors.blue.shade700,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Current Method',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _status!.method!.displayName,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _getMethodDescription(_status!.method!),
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getMethodIcon(TwoFactorMethod method) {
    switch (method) {
      case TwoFactorMethod.totp:
        return Icons.shield_rounded;
      case TwoFactorMethod.sms:
        return Icons.sms_rounded;
      case TwoFactorMethod.email:
        return Icons.mail_rounded;
    }
  }

  String _getMethodDescription(TwoFactorMethod method) {
    switch (method) {
      case TwoFactorMethod.totp:
        return 'Verification codes are generated by your authenticator app';
      case TwoFactorMethod.sms:
        return 'Verification codes are sent via SMS to your phone';
      case TwoFactorMethod.email:
        return 'Verification codes are sent via email';
    }
  }

  Widget _buildBackupCodesSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.key_rounded, color: Colors.orange.shade700),
                  SizedBox(width: 12.w),
                  Text(
                    'Backup Codes',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                '${_status!.backupCodesCount} remaining',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _status!.backupCodesCount > 3
                ? 'You have backup codes available if you lose access to your authenticator.'
                : 'You have low backup codes. Consider regenerating them.',
            style: TextStyle(
              fontSize: 13.sp,
              color: _status!.backupCodesCount > 3
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _regenerateBackupCodes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Regenerate Backup Codes',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shown while 2FA is enabled: lists every method with the active one marked,
  /// so the user can see and switch options in one place. Because only one
  /// method may be active at a time, tapping a different one opens the
  /// switch-method modal (disable active → enable new) rather than silently
  /// changing anything.
  Widget _buildOtherMethods() {
    final active = _status?.method;
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune_rounded, color: Colors.blue.shade700, size: 20.sp),
              SizedBox(width: 12.w),
              Text('Authentication methods',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Only one method can be active at a time. Tap another to switch — '
            'you\'ll disable the current one first.',
            style: TextStyle(fontSize: 12.5.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 12.h),
          ...TwoFactorMethod.values.map((m) {
            final isActive = m == active;
            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: isActive ? null : () => _promptSwitchMethod(m),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.shade50 : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isActive ? Colors.green.shade300 : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(_getMethodIcon(m),
                          color: isActive ? Colors.green.shade700 : Colors.grey.shade600,
                          size: 20.sp),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.displayName,
                                style: TextStyle(
                                    fontSize: 15.sp, fontWeight: FontWeight.w600)),
                            SizedBox(height: 2.h),
                            Text(_getMethodDescription(m),
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      if (isActive)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text('Active',
                              style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        )
                      else
                        Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.red.shade700,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Danger Zone',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Disabling 2FA will make your account vulnerable',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.red.shade700,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _showDisableDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Disable Two-Factor Authentication',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(
            Icons.security_rounded,
            size: 48.sp,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16.h),
          Text(
            'Two-factor authentication is not enabled',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose a method below to add an extra layer of security',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Options shown inline — no extra CTA to reveal them.
          TwoFactorMethodPicker(
            selected: _selectedMethod,
            enabled: !_enabling,
            onSelect: (m) => setState(() => _selectedMethod = m),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton.icon(
              icon: _enabling
                  ? const SizedBox.shrink()
                  : const Icon(Icons.add_rounded),
              label: _enabling
                  ? LazerVaultLoader.small()
                  : Text(
                      'Enable ${_selectedMethod.displayName}',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
              onPressed: _enabling ? null : _enableSelected,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4834D4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
