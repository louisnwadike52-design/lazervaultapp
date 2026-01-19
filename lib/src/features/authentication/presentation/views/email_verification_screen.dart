import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';

/// Email OTP Verification Screen
///
/// This screen is shown after signup when the user needs to verify their email.
/// The OTP is automatically sent during signup.
///
/// Arguments:
/// - email: The email address to verify (required)
/// - codeSent: Whether the OTP was already sent (default: true)
/// - isRequired: Whether verification is mandatory or can be skipped (default: true)
/// - secondaryPhone: Phone number for secondary verification after email (optional)
class EmailVerificationScreen extends StatelessWidget {
  final String? email;
  final bool codeSent;
  final bool isRequired;
  final String? secondaryPhone;

  const EmailVerificationScreen({
    super.key,
    this.email,
    this.codeSent = true,
    this.isRequired = true,
    this.secondaryPhone,
  });

  @override
  Widget build(BuildContext context) {
    // Extract arguments if passed via route
    final args = Get.arguments;
    String? emailArg = email;
    bool otpSent = codeSent;
    bool required = isRequired;
    String? secondaryPhoneArg = secondaryPhone;

    // Handle Map arguments - check for general Map type to handle both
    // Map<String, dynamic> and Map<String, Object> from route arguments
    if (args is Map) {
      final mapArgs = Map<String, dynamic>.from(args);
      emailArg = mapArgs['email']?.toString() ?? emailArg;
      otpSent = mapArgs['codeSent'] as bool? ?? otpSent;
      required = mapArgs['isRequired'] as bool? ?? required;
      secondaryPhoneArg = mapArgs['secondaryPhone']?.toString();
    } else if (args is String) {
      // Simple string argument (email only)
      emailArg = args;
    }

    return _EmailOtpVerificationView(
      email: emailArg ?? '',
      codeSent: otpSent,
      isRequired: required,
      secondaryPhone: secondaryPhoneArg,
    );
  }
}

class _EmailOtpVerificationView extends StatefulWidget {
  final String email;
  final bool codeSent;
  final bool isRequired;
  final String? secondaryPhone;

  const _EmailOtpVerificationView({
    required this.email,
    required this.codeSent,
    required this.isRequired,
    this.secondaryPhone,
  });

  @override
  State<_EmailOtpVerificationView> createState() => _EmailOtpVerificationViewState();
}

class _EmailOtpVerificationViewState extends State<_EmailOtpVerificationView> {
  Timer? _resendTimer;
  int _resendCooldown = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the cubit with email for resending
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmailVerificationCubit>().initialize(widget.email);
      context.read<EmailVerificationCubit>().updateVerificationCode('');
    });

    // Start with a cooldown if code was just sent
    if (widget.codeSent) {
      _startResendCooldown(60);
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
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

  String _maskEmail(String email) {
    if (email.isEmpty) return '';
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final localPart = parts[0];
    final domain = parts[1];

    if (localPart.length <= 2) {
      return '$localPart@$domain';
    }

    final visibleStart = localPart.substring(0, 2);
    final visibleEnd = localPart.length > 4 ? localPart.substring(localPart.length - 1) : '';
    final maskedLength = localPart.length - 2 - (visibleEnd.isEmpty ? 0 : 1);
    final masked = '*' * (maskedLength > 0 ? maskedLength : 1);

    return '$visibleStart$masked$visibleEnd@$domain';
  }

  void _navigateToNextScreen() {
    // Check if there's secondary phone verification needed
    if (widget.secondaryPhone != null && widget.secondaryPhone!.isNotEmpty) {
      Get.offAllNamed(AppRoutes.phoneVerification, arguments: {
        'phoneNumber': widget.secondaryPhone,
        'codeSent': true,
        'expiresIn': 600,
        'isRequired': false, // Secondary verification is skippable
        'secondaryEmail': null,
      });
    } else {
      // No secondary verification, go to passcode setup
      Get.offAllNamed(AppRoutes.passcodeSetup);
    }
  }

  void _skipVerification() {
    // Allow skip if not required OR in development mode
    if (!widget.isRequired || kDebugMode) {
      _navigateToNextScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maskedEmail = _maskEmail(widget.email);

    return PopScope(
      canPop: !widget.isRequired || kDebugMode, // Allow back if not required OR in dev mode
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<EmailVerificationCubit, EmailVerificationState>(
          listener: (context, state) {
            if (state is EmailVerificationSuccess) {
              // Navigate to next screen on successful verification
              Future.delayed(const Duration(milliseconds: 300), () {
                _navigateToNextScreen();
              });
            } else if (state is EmailVerificationInProgress) {
              // Handle resend success - show feedback and restart cooldown
              if (state.successMessage.isNotEmpty) {
                Get.snackbar(
                  'Code Sent',
                  state.successMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                  duration: const Duration(seconds: 2),
                );
                // Start cooldown from backend response (default 60s if not provided)
                _startResendCooldown(state.cooldownSeconds ?? 60);
              }
              // Handle resend error with cooldown (rate limit scenario)
              else if (state.errorMessage.isNotEmpty && state.cooldownSeconds != null && state.cooldownSeconds! > 0) {
                Get.snackbar(
                  'Please Wait',
                  state.errorMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                  duration: const Duration(seconds: 2),
                );
                _startResendCooldown(state.cooldownSeconds!);
              }
              // Handle verification error (wrong code)
              else if (state.errorMessage.isNotEmpty) {
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
          child: BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
            builder: (context, state) {
              final isVerifying = state is EmailVerificationInProgress && state.isLoading;
              final isResending = state is EmailVerificationInProgress && state.isResending;

              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60.h),

                      // Email icon with gradient background
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
                          Icons.email_rounded,
                          size: 48.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Title
                      Text(
                        'Verify Your Email',
                        style: GoogleFonts.inter(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Subtitle with masked email
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
                              text: maskedEmail,
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
                          context.read<EmailVerificationCubit>().updateVerificationCode(code);
                          // Auto-submit when complete
                          context.read<EmailVerificationCubit>().verifyEmail();
                        },
                        onChanged: (code) {
                          context.read<EmailVerificationCubit>().updateVerificationCode(code);
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: isVerifying
                              ? null
                              : () {
                                  context.read<EmailVerificationCubit>().verifyEmail();
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
                                  'Verify Email',
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
                            onPressed: (_resendCooldown > 0 || isResending)
                                ? null
                                : () {
                                    context.read<EmailVerificationCubit>().resendVerificationEmail();
                                  },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: isResending
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

                      // Skip Button (shown if not required OR in development mode)
                      if (!widget.isRequired || kDebugMode) ...[
                        SizedBox(height: 16.h),
                        TextButton(
                          onPressed: _skipVerification,
                          child: Text(
                            'Skip for now',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
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
                                    'Check your inbox and spam folder for the verification code. The code expires in 24 hours.',
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
