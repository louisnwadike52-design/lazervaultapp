import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';

/// Phone OTP Verification Screen
///
/// This screen is shown after signup when the user needs to verify their phone number.
/// The OTP is automatically sent during signup, so this screen shows the OTP input directly.
///
/// Arguments:
/// - phoneNumber: The phone number to verify (required)
/// - codeSent: Whether the OTP was already sent (default: true when coming from signup)
/// - expiresIn: Seconds until the OTP expires (optional, default: 600 seconds / 10 minutes)
/// - isRequired: Whether verification is mandatory or can be skipped (default: true)
/// - secondaryEmail: Email for secondary verification after phone (optional)
class PhoneVerificationScreen extends StatelessWidget {
  final String? phoneNumber;
  final bool codeSent;
  final int? expiresIn;
  final bool isRequired;
  final String? secondaryEmail;

  const PhoneVerificationScreen({
    super.key,
    this.phoneNumber,
    this.codeSent = true, // Default true - OTP sent during signup
    this.expiresIn,
    this.isRequired = true,
    this.secondaryEmail,
  });

  @override
  Widget build(BuildContext context) {
    // Extract arguments if passed via route
    final args = Get.arguments;
    String? phone = phoneNumber;
    bool otpSent = codeSent;
    int? expiry = expiresIn;
    bool required = isRequired;
    String? secondaryEmailArg = secondaryEmail;

    if (args is Map<String, dynamic>) {
      phone = args['phoneNumber'] as String? ?? phone;
      otpSent = args['codeSent'] as bool? ?? otpSent;
      expiry = args['expiresIn'] as int? ?? expiry;
      required = args['isRequired'] as bool? ?? required;
      secondaryEmailArg = args['secondaryEmail'] as String?;
    } else if (args is String) {
      // Simple string argument (phone number only)
      phone = args;
    }

    return BlocProvider(
      create: (_) => serviceLocator<PhoneVerificationCubit>(),
      child: _PhoneOtpVerificationView(
        phoneNumber: phone ?? '',
        codeSent: otpSent,
        expiresIn: expiry ?? 600, // Default 10 minutes
        isRequired: required,
        secondaryEmail: secondaryEmailArg,
      ),
    );
  }
}

class _PhoneOtpVerificationView extends StatefulWidget {
  final String phoneNumber;
  final bool codeSent;
  final int expiresIn;
  final bool isRequired;
  final String? secondaryEmail;

  const _PhoneOtpVerificationView({
    required this.phoneNumber,
    required this.codeSent,
    required this.expiresIn,
    required this.isRequired,
    this.secondaryEmail,
  });

  @override
  State<_PhoneOtpVerificationView> createState() => _PhoneOtpVerificationViewState();
}

class _PhoneOtpVerificationViewState extends State<_PhoneOtpVerificationView> {
  Timer? _resendTimer;
  Timer? _expiryTimer;
  int _resendCooldown = 0;
  int _expiryCountdown = 0;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();

    // Initialize the cubit with the phone number
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<PhoneVerificationCubit>();
      cubit.updatePhoneNumber(widget.phoneNumber);
      cubit.updateVerificationCode('');
    });

    // Start expiry countdown if OTP was already sent
    if (widget.codeSent) {
      _startExpiryCountdown(widget.expiresIn);
      // Start with a cooldown if code was just sent
      _startResendCooldown(60);
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _expiryTimer?.cancel();
    super.dispose();
  }

  void _startResendCooldown(int seconds) {
    setState(() {
      _resendCooldown = seconds;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _startExpiryCountdown(int seconds) {
    setState(() {
      _expiryCountdown = seconds;
      _isExpired = false;
    });

    _expiryTimer?.cancel();
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_expiryCountdown > 0) {
        setState(() {
          _expiryCountdown--;
        });
      } else {
        setState(() {
          _isExpired = true;
        });
        timer.cancel();
      }
    });
  }

  String _formatCountdown(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _maskPhoneNumber(String phone) {
    if (phone.isEmpty) return '';
    if (phone.length < 4) return phone;

    // Keep first 3 characters (country code) and last 4 digits
    // Mask everything in between
    final visibleStart = phone.length > 6 ? 3 : 2;
    final visibleEnd = 4;

    if (phone.length <= visibleStart + visibleEnd) {
      return phone;
    }

    final start = phone.substring(0, visibleStart);
    final end = phone.substring(phone.length - visibleEnd);
    final maskedLength = phone.length - visibleStart - visibleEnd;
    final masked = '*' * maskedLength;

    return '$start$masked$end';
  }

  void _resendCode() {
    if (_resendCooldown > 0) return;

    context.read<PhoneVerificationCubit>().resendVerificationCode(
      phoneNumber: widget.phoneNumber,
    );

    // Restart countdown
    _startResendCooldown(60);
    _startExpiryCountdown(600); // Reset expiry to 10 minutes
  }

  void _navigateToNextScreen() {
    // Check if there's secondary email verification needed
    if (widget.secondaryEmail != null && widget.secondaryEmail!.isNotEmpty) {
      Get.offAllNamed(AppRoutes.emailVerification, arguments: {
        'email': widget.secondaryEmail,
        'codeSent': true,
        'isRequired': false, // Secondary verification is skippable
        'secondaryPhone': null,
      });
    } else {
      // No secondary verification, go to passcode setup
      Get.offAllNamed(AppRoutes.passcodeSetup);
    }
  }

  void _skipVerification() {
    if (!widget.isRequired) {
      _navigateToNextScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maskedPhone = _maskPhoneNumber(widget.phoneNumber);

    return PopScope(
      canPop: !widget.isRequired, // Allow back only if not required
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<PhoneVerificationCubit, PhoneVerificationState>(
          listener: (context, state) {
            if (state is PhoneVerificationCodeSent) {
              Get.snackbar(
                'Code Sent',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 3),
              );
              // Restart expiry countdown when new code is sent
              if (state.expiresIn != null) {
                _startExpiryCountdown(state.expiresIn!);
              }
            } else if (state is PhoneVerificationSuccess) {
              Get.snackbar(
                'Verified!',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 2),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                _navigateToNextScreen();
              });
            } else if (state is PhoneVerificationFailure) {
              Get.snackbar(
                'Verification Failed',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 3),
              );
            } else if (state is PhoneVerificationInProgress) {
              if (state.errorMessage.isNotEmpty) {
                Get.snackbar(
                  'Error',
                  state.errorMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                  duration: const Duration(seconds: 3),
                );
              }
            }
          },
          child: BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
            builder: (context, state) {
              final isVerifying = state is PhoneVerificationVerifying;
              final isSending = state is PhoneVerificationSending;

              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60.h),

                      // Phone icon with gradient background
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.phone_android_rounded,
                          size: 48.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Title
                      Text(
                        'Verify Your Phone',
                        style: GoogleFonts.inter(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Subtitle with masked phone
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: const Color(0xFF6B7280),
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Enter the 6-digit code sent to\n',
                            ),
                            TextSpan(
                              text: maskedPhone,
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // OTP Input
                      VerificationCodeInput(
                        onCompleted: (code) {
                          context.read<PhoneVerificationCubit>().updateVerificationCode(code);
                        },
                        onChanged: (code) {
                          context.read<PhoneVerificationCubit>().updateVerificationCode(code);
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Expiry countdown
                      if (!_isExpired && _expiryCountdown > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 18.sp,
                              color: _expiryCountdown < 60
                                  ? Colors.red
                                  : const Color(0xFF6B7280),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Code expires in ${_formatCountdown(_expiryCountdown)}',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: _expiryCountdown < 60
                                    ? Colors.red
                                    : const Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      else if (_isExpired)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                size: 18.sp,
                                color: Colors.red,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Code expired. Please request a new one.',
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 32.h),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: (isVerifying || _isExpired)
                              ? null
                              : () {
                                  if (state is PhoneVerificationInProgress) {
                                    if (state.verificationCode.length != 6) {
                                      Get.snackbar(
                                        'Invalid Code',
                                        'Please enter the complete 6-digit code',
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                        margin: EdgeInsets.all(16.w),
                                        borderRadius: 12.r,
                                      );
                                      return;
                                    }
                                    context.read<PhoneVerificationCubit>().verifyPhoneNumber(
                                      phoneNumber: widget.phoneNumber,
                                      verificationCode: state.verificationCode,
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4E03D0),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: isVerifying
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  'Verify Phone Number',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Resend Code Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code?",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          TextButton(
                            onPressed: (_resendCooldown > 0 || isSending)
                                ? null
                                : _resendCode,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: isSending
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF4E03D0),
                                    ),
                                  )
                                : Text(
                                    _resendCooldown > 0
                                        ? 'Resend in ${_resendCooldown}s'
                                        : 'Resend Code',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: _resendCooldown > 0
                                          ? const Color(0xFF9CA3AF)
                                          : const Color(0xFF4E03D0),
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      // Skip Button (only shown if not required)
                      if (!widget.isRequired) ...[
                        SizedBox(height: 16.h),
                        TextButton(
                          onPressed: _skipVerification,
                          child: Text(
                            'Skip for now',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 48.h),

                      // Info Card
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.security_rounded,
                                color: const Color(0xFF4E03D0),
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Secure Verification',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'We sent a 6-digit code via SMS to verify your phone number. Standard message rates may apply.',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF6B7280),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
