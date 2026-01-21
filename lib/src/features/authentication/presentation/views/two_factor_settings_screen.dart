import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/entities/two_factor_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

/// Screen for managing two-factor authentication settings
class TwoFactorSettingsScreen extends StatefulWidget {
  const TwoFactorSettingsScreen({super.key});

  @override
  State<TwoFactorSettingsScreen> createState() => _TwoFactorSettingsScreenState();
}

class _TwoFactorSettingsScreenState extends State<TwoFactorSettingsScreen> {
  TwoFactorStatus? _status;
  bool _isLoading = true;
  bool _isDisabling = false;
  String _disableCode = '';

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

  Future<void> _disableTwoFactor() async {
    if (_disableCode.length != 6) {
      Get.snackbar(
        'Invalid Code',
        'Please enter a valid 6-digit verification code',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Disable Two-Factor Authentication?'),
        content: const Text(
          'Your account will be less secure without 2FA. Are you sure you want to disable it?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Disable'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isDisabling = true);

    try {
      final cubit = context.read<AuthenticationCubit>();
      final success = await cubit.disableTwoFactor(_disableCode);

      setState(() => _isDisabling = false);

      if (success && mounted) {
        setState(() {
          _status = const TwoFactorStatus.disabled();
          _disableCode = '';
        });

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
    } catch (e) {
      setState(() => _isDisabling = false);
      Get.snackbar(
        'Error',
        'Failed to disable 2FA: ${e.toString()}',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
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

    if (confirmed != true) return;

    // Show code input dialog
    final code = await _showCodeInputDialog(
      'Enter Current 2FA Code',
      'Enter your current 6-digit verification code to confirm:',
    );

    if (code == null) return;

    try {
      final cubit = context.read<AuthenticationCubit>();
      final newCodes = await cubit.regenerateBackupCodes(code);

      if (mounted) {
        _showBackupCodesDialog(newCodes);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to regenerate codes: ${e.toString()}',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  Future<String?> _showCodeInputDialog(
    String title,
    String message,
  ) async {
    String code = '';
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            SizedBox(height: 16.h),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: '000000',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              onChanged: (value) => code = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    return confirmed == true ? code : null;
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
            child: const Text('I\'ve Saved Them'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
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
          child: CircularProgressIndicator(),
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
              onPressed: _isDisabling ? null : _showDisableDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDisabling ? Colors.red.shade400 : Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isDisabling
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
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
            'Enable 2FA to add an extra layer of security to your account',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_rounded),
              label: Text(
                'Enable Two-Factor Authentication',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => Get.toNamed(AppRoutes.twoFactorSetup),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
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

  Future<void> _showDisableDialog() async {
    final code = await _showCodeInputDialog(
      'Confirm Disable',
      'Enter your 6-digit 2FA code to confirm:',
    );

    if (code != null) {
      setState(() => _disableCode = code);
      _disableTwoFactor();
    }
  }
}
