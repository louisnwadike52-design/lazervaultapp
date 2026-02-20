import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import 'package:pinput/pinput.dart';

class VerifyPasswordResetOTP extends StatefulWidget {
  const VerifyPasswordResetOTP({super.key});

  @override
  State<VerifyPasswordResetOTP> createState() => _VerifyPasswordResetOTPState();
}

class _VerifyPasswordResetOTPState extends State<VerifyPasswordResetOTP> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isLoading = false;
  bool _isResending = false;
  bool _isCodeComplete = false;
  String? _errorMessage;
  int _expiresInSeconds = 900; // 15 minutes default
  String _maskedContact = '';
  String _phone = '';
  String _deliveryMethod = 'sms';
  Timer? _expiryTimer;
  int _remainingSeconds = 900;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _phone = args['phone'] as String? ?? '';
          _maskedContact = args['maskedContact'] as String? ?? '';
          _deliveryMethod = args['deliveryMethod'] as String? ?? 'sms';
          _expiresInSeconds = args['expiresInSeconds'] as int? ?? 900;
          _remainingSeconds = _expiresInSeconds;
        });
        _startExpiryTimer();
      }
    });

    _pinController.addListener(() {
      setState(() {
        _isCodeComplete = _pinController.text.length == 6;
        if (_errorMessage != null && _pinController.text.length == 6) {
          _errorMessage = null; // Clear error when user completes entering code
        }
      });
    });

    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _expiryTimer?.cancel();
    super.dispose();
  }

  void _startExpiryTimer() {
    _expiryTimer?.cancel();
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        if (mounted) {
          setState(() {
            _errorMessage = 'Code has expired. Please request a new code.';
          });
        }
      }
    });
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _showErrorSnackbar(String title, String message) {
    if (mounted && Get.isSnackbarOpen == false) {
      Get.snackbar(
        title,
        message,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  Future<void> _verifyOTP() async {
    if (_pinController.text.length != 6) {
      setState(() {
        _errorMessage = 'Please enter the complete 6-digit code';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final cubit = context.read<AuthenticationCubit>();

    try {
      final result = await cubit.verifyPasswordResetCode(
        contact: _phone,
        code: _pinController.text,
        deliveryMethod: _deliveryMethod,
      );

      if (!mounted) return;

      result.fold(
        (failure) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
          });
          // Shake animation for wrong code
          _focusNode.unfocus();
          Future.delayed(const Duration(milliseconds: 100), () {
            _focusNode.requestFocus();
          });
        },
        (data) {
          setState(() {
            _isLoading = false;
          });
          // Navigate to new password screen with reset token
          Get.toNamed(
            AppRoutes.createNewPassword,
            arguments: {
              'resetToken': data.resetToken,
              'requireToken': false,
              'deliveryMethod': _deliveryMethod,
              'phone': _phone,
              'email': '',
              'maskedContact': _maskedContact,
            },
          );
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to verify code. Please try again.';
          _isLoading = false;
        });
        _showErrorSnackbar('Error', _errorMessage!);
      }
    }
  }

  Future<void> _resendCode() async {
    setState(() {
      _isResending = true;
      _errorMessage = null;
    });

    final cubit = context.read<AuthenticationCubit>();

    try {
      final result = await cubit.requestPasswordResetV2(
        phone: _phone,
        deliveryMethod: _deliveryMethod == 'sms'
            ? auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_SMS
            : auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_EMAIL,
      );

      if (!mounted) return;

      result.fold(
        (failure) {
          Get.snackbar(
            'Error',
            failure.message,
            backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        },
        (data) {
          Get.snackbar(
            'Code Sent',
            data.message,
            backgroundColor: Colors.green.withValues(alpha: 0.8),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          setState(() {
            _expiresInSeconds = data.expiresInSeconds;
            _remainingSeconds = data.expiresInSeconds;
            _pinController.clear();
            _isCodeComplete = false;
          });
          _startExpiryTimer();
        },
      );
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar('Error', 'Failed to resend code. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
    );

    return Column(
      children: [
        // Icon
        Center(
          child: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _deliveryMethod == 'email' ? Icons.email_outlined : Icons.sms_outlined,
              size: 32.w,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 24.h),

        // Title
        Text(
          'Enter Verification Code',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppColors.primaryFont,
          ),
        ),
        SizedBox(height: 12.h),

        // Subtitle with masked contact
        Text(
          'Enter the 6-digit code sent to $_maskedContact',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondaryFont,
          ),
        ),
        SizedBox(height: 8.h),

        // Expiry timer
        Text(
          _remainingSeconds > 0
              ? 'Code expires in ${_formatDuration(_remainingSeconds)}'
              : 'Code has expired',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            color: _remainingSeconds > 300
                ? AppColors.secondaryFont.withValues(alpha: 0.8)
                : Colors.orange.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(height: 32.h),

        // PIN Input
        Pinput(
          controller: _pinController,
          focusNode: _focusNode,
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue, width: 2),
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue),
            ),
          ),
          errorPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.red),
            ),
          ),
          enabled: !_isLoading && _remainingSeconds > 0,
          autofocus: true,
          // SMS autofill handled by platform
        ),

        // Error message
        if (_errorMessage != null) ...[
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 20.w),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        SizedBox(height: 32.h),

        // Verify Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: const StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            minimumSize: Size(double.infinity, 48.h),
          ),
          onPressed: (_isLoading || _remainingSeconds <= 0) ? null : _verifyOTP,
          child: _isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'Verify Code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
        ),

        SizedBox(height: 16.h),

        // Resend Button
        TextButton(
          onPressed: (_isResending || _isLoading) ? null : _resendCode,
          child: _isResending
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: const CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Sending...',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Resend Code',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),

        SizedBox(height: 8.h),

        // Help text
        Text(
          'Didn\'t receive the code? Check your spam folder or make sure your phone number is verified.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.secondaryFont.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
