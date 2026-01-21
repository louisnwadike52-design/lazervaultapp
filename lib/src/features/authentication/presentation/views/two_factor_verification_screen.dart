import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

/// Screen for two-factor authentication verification during login
class TwoFactorVerificationScreen extends StatefulWidget {
  const TwoFactorVerificationScreen({
    super.key,
    required this.twoFactorToken,
    this.userEmail,
    this.userFirstName,
  });

  final String twoFactorToken;
  final String? userEmail;
  final String? userFirstName;

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {
  final List<TextEditingController> _codeControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  String _verificationCode = '';
  bool _showBackupCodeInput = false;

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyCode() async {
    if (_verificationCode.length != 6 && !_showBackupCodeInput) {
      Get.snackbar(
        'Invalid Code',
        'Please enter the complete 6-digit code',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final cubit = context.read<AuthenticationCubit>();
      final success = await cubit.verifyTwoFactor(widget.twoFactorToken, _verificationCode);

      setState(() => _isLoading = false);

      if (success && mounted) {
        // Login successful, navigate to dashboard
        Get.offAllNamed(AppRoutes.dashboard);
      } else if (mounted) {
        Get.snackbar(
          'Verification Failed',
          'Invalid verification code. Please try again.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
        );
        // Clear the code inputs
        for (var controller in _codeControllers) {
          controller.clear();
        }
        setState(() => _verificationCode = '');
        if (_focusNodes.isNotEmpty) {
          FocusScope.of(context).requestFocus(_focusNodes[0]);
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Get.snackbar(
        'Verification Failed',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
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
      if (_verificationCode.length == 6 && !_showBackupCodeInput) {
        // Give a small delay before auto-submitting
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && !_isLoading) {
            _verifyCode();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                SizedBox(height: 40.h),
                _buildIllustration(),
                SizedBox(height: 32.h),
                _buildInstructions(),
                SizedBox(height: 32.h),
                _buildCodeInput(),
                if (!_showBackupCodeInput) ...[
                  SizedBox(height: 24.h),
                  _buildBackupCodeOption(),
                ] else
                  _buildBackupCodeInput(),
                SizedBox(height: 32.h),
                _buildVerifyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_rounded,
            color: Colors.white,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Two-Factor Authentication',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        if (widget.userFirstName != null) ...[
          SizedBox(height: 4.h),
          Text(
            'Hi, ${widget.userFirstName}',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildIllustration() {
    return Container(
      width: 150.w,
      height: 150.w,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.smartphone,
        size: 80.sp,
        color: Colors.blue.shade300,
      ),
    );
  }

  Widget _buildInstructions() {
    return Column(
      children: [
        Text(
          'Enter the 6-digit verification code',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'We sent a code to ${widget.userEmail ?? 'your registered device'}',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCodeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 45.w,
          height: 60.h,
          child: TextField(
            controller: _codeControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 8,
            ),
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Colors.blue.shade700,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) => _onCodeChanged(value, index),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _verifyCode,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.blue.shade700.withValues(alpha: 0.5),
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
                'Verify',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildBackupCodeOption() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _showBackupCodeInput = true;
              // Clear TOTP code
              for (var controller in _codeControllers) {
                controller.clear();
              }
              _verificationCode = '';
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade600,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lost your device? ',
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                'Use backup code',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackupCodeInput() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.orange.shade50.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.orange.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.orange.shade700,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Using a backup code will invalidate it. You have ${_getRemainingBackupCodes()} backup codes remaining.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.orange.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 16.sp,
              letterSpacing: 4,
            ),
            decoration: InputDecoration(
              hintText: 'Enter 8-digit backup code (e.g., ABC12345)',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.orange.shade300),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _verificationCode = value;
              });
            },
          ),
          SizedBox(height: 16.h),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _showBackupCodeInput = false;
                // Clear backup code
                _verificationCode = '';
              });
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to TOTP'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  int _getRemainingBackupCodes() {
    // This should come from the API
    return 10;
  }
}
