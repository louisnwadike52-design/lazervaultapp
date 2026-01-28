import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/authentication/domain/entities/two_factor_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

/// Screen for setting up two-factor authentication
class TwoFactorSetupScreen extends StatefulWidget {
  const TwoFactorSetupScreen({super.key});

  @override
  State<TwoFactorSetupScreen> createState() => _TwoFactorSetupScreenState();
}

class _TwoFactorSetupScreenState extends State<TwoFactorSetupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TwoFactorMethod _selectedMethod = TwoFactorMethod.totp;
  bool _isLoading = false;
  bool _isVerifying = false;
  String _verificationCode = '';
  TwoFactorSetup? _setupData;
  bool _showBackupCodes = false;

  // For code input
  final List<TextEditingController> _codeControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _enableTwoFactor() async {
    setState(() => _isLoading = true);

    try {
      final cubit = context.read<AuthenticationCubit>();
      // Get user ID from current session
      final userId = cubit.currentProfile?.user.id ?? '';

      if (userId.isEmpty) {
        Get.snackbar(
          'Error',
          'User not authenticated. Please login first.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
        );
        setState(() => _isLoading = false);
        return;
      }

      final result = await cubit.enableTwoFactor(_selectedMethod);

      if (result.secret.isNotEmpty && mounted) {
        setState(() {
          _setupData = result;
          _isLoading = false;
        });

        // Show success message
        Get.snackbar(
          'Setup Initiated',
          _getSetupMessage(),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        Get.snackbar(
          'Error',
          'Failed to enable 2FA: ${e.toString()}',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
        );
      }
    }
  }

  String _getSetupMessage() {
    switch (_selectedMethod) {
      case TwoFactorMethod.totp:
        return 'Scan QR code with your authenticator app and save backup codes securely';
      case TwoFactorMethod.sms:
        return 'A verification code has been sent to your phone number';
      case TwoFactorMethod.email:
        return 'A verification code has been sent to your email';
    }
  }

  Future<void> _completeSetup() async {
    if (_verificationCode.length != 6) {
      Get.snackbar(
        'Invalid Code',
        'Please enter a 6-digit verification code',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final cubit = context.read<AuthenticationCubit>();
      final userId = cubit.currentProfile?.user.id ?? '';

      final success = await cubit.completeTwoFactorSetup(userId, _verificationCode);

      setState(() => _isVerifying = false);

      if (success && mounted) {
        Get.snackbar(
          'Success!',
          'Two-factor authentication enabled successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
        );

        // Navigate to settings or back
        Get.back(result: true);
      }
    } catch (e) {
      setState(() => _isVerifying = false);
      Get.snackbar(
        'Error',
        'Failed to complete setup: ${e.toString()}',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      'Code copied to clipboard',
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(15.w),
      borderRadius: 10.r,
    );
  }

  void _onCodeChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field
      if (index < 5 && _focusNodes[index].hasFocus) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }

    setState(() {
      // Update verification code
      final codeList = _codeControllers.map((c) => c.text).toList();
      _verificationCode = codeList.join();

      // Auto-submit when code is complete
      if (_verificationCode.length == 6) {
        // Give a small delay before auto-submitting
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && !_isVerifying) {
            _completeSetup();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two-Factor Authentication'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              SizedBox(height: 20.h),
              _buildMethodSelector(),
              SizedBox(height: 24.h),
              if (_setupData != null) _buildSetupContent(),
              if (_setupData == null && !_isLoading)
                _buildEnableButton(),
              if (_isLoading) _buildLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    final blue50 = Colors.blue.shade50;
    final blue200 = Colors.blue.shade200;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: blue50.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: blue200.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security_rounded,
            color: Colors.blue.shade700,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enhanced Security',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Add an extra layer of security to your account by requiring a verification code in addition to your password.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Authentication Method',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: TwoFactorMethodInfo.availableMethods.map((method) {
              final isSelected = _selectedMethod == method.method;
              return InkWell(
                onTap: _setupData == null
                    ? () {
                        setState(() => _selectedMethod = method.method);
                      }
                    : null,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.only(bottom: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade50
                        : Colors.transparent,
                    border: Border(
                      top: BorderSide(
                        color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                        width: isSelected ? 2 : 0,
                      ),
                      bottom: BorderSide(
                        color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                        width: isSelected ? 2 : 0,
                      ),
                      left: BorderSide(
                        color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                        width: isSelected ? 2 : 0,
                      ),
                      right: BorderSide(
                        color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                        width: isSelected ? 2 : 0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade700
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          _getIconData(method.icon),
                          color: isSelected ? Colors.white : Colors.grey.shade600,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.blue.shade900
                                    : Colors.grey.shade800,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              method.description,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: isSelected
                                    ? Colors.blue.shade700
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'shield':
        return Icons.shield_rounded;
      case 'message':
        return Icons.sms_rounded;
      case 'mail':
        return Icons.mail_rounded;
      default:
        return Icons.security_rounded;
    }
  }

  Widget _buildSetupContent() {
    switch (_selectedMethod) {
      case TwoFactorMethod.totp:
        return _buildTOTPSetup();
      case TwoFactorMethod.sms:
      case TwoFactorMethod.email:
        return _buildCodeVerification();
    }
  }

  Widget _buildTOTPSetup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQRCodeSection(),
        SizedBox(height: 24.h),
        _buildBackupCodesSection(),
        SizedBox(height: 24.h),
        _buildVerificationSection(),
      ],
    );
  }

  Widget _buildQRCodeSection() {
    Uint8List? qrImageBytes;

    try {
      if (_setupData?.qrCode != null && _setupData!.qrCode.isNotEmpty) {
        qrImageBytes = base64Decode(_setupData!.qrCode);
      }
    } catch (e) {
      qrImageBytes = null;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.qr_code_2_rounded, color: Colors.blue.shade700),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Scan with Authenticator App',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Use Google Authenticator, Microsoft Authenticator, or Authy',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 20.h),
          if (qrImageBytes != null)
            Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Image.memory(
                qrImageBytes,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Failed to load QR code',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  'QR Code will appear here',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          SizedBox(height: 16.h),
          if (_setupData?.secret != null && _setupData!.secret.isNotEmpty)
            _buildSecretSection(),
        ],
      ),
    );
  }

  Widget _buildSecretSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Or enter this code manually:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    _formatSecret(_setupData!.secret),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () => _copyToClipboard(_setupData!.secret),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.copy_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatSecret(String secret) {
    // Add spaces every 4 characters for readability
    final buffer = StringBuffer();
    for (int i = 0; i < secret.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(secret[i]);
    }
    return buffer.toString();
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
            children: [
              Icon(Icons.key_rounded, color: Colors.orange.shade700),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Backup Codes',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Save these codes in a secure location. Each code can only be used once.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showBackupCodes = !_showBackupCodes;
                  });
                },
                child: Text(_showBackupCodes ? 'Hide' : 'Show'),
              ),
            ],
          ),
          if (_showBackupCodes) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.amber.shade50.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    '⚠️ IMPORTANT: Save these codes now. You won\'t see them again!',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade900,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: List.generate(
                      _setupData!.backupCodes.length,
                      (index) => _buildBackupCodeChip(_setupData!.backupCodes[index]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBackupCodeChip(String code) {
    final formattedCode = '${code.substring(0, 4)}-${code.substring(4)}';
    return InkWell(
      onTap: () => _copyToClipboard(code),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          formattedCode,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationSection() {
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
              Icon(Icons.verified_user_rounded, color: Colors.green.shade700),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Verify Setup',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Enter the 6-digit code from your authenticator app to complete setup:',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => _buildCodeInputField(index, false),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _isVerifying ? null : _completeSetup,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.blue.shade700.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isVerifying
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      'Verify and Enable',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInputField(int index, bool isError) {
    return SizedBox(
      width: 45.w,
      height: 55.h,
      child: TextField(
        controller: _codeControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: isError ? Colors.red.shade50 : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade400,
              width: isError ? 2 : 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.blue.shade700,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) => _onCodeChanged(value, index),
      ),
    );
  }

  Widget _buildCodeVerification() {
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
              Icon(_selectedMethod == TwoFactorMethod.sms
                  ? Icons.sms_rounded
                  : Icons.mail_rounded,
                  color: Colors.blue.shade700),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Verification Code Sent',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _selectedMethod == TwoFactorMethod.sms
                ? 'Enter the 6-digit code sent to your phone number'
                : 'Enter the 6-digit code sent to your email',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => _buildCodeInputField(index, false),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn\'t receive the code? ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        try {
                          await context.read<AuthenticationCubit>().sendTwoFactorCode();
                          Get.snackbar(
                            'Code Sent',
                            'A new code has been sent',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(15.w),
                            borderRadius: 10.r,
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to send code: ${e.toString()}',
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(15.w),
                            borderRadius: 10.r,
                          );
                        }
                      },
                child: Text(
                  'Resend',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4E03D0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnableButton() {
    final primaryColor = const Color(0xFF4E03D0);
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _enableTwoFactor,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primaryColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                'Enable ${_selectedMethod.displayName}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
