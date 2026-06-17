import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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

      if (widget.codeSent) {
        // Code was already sent before navigation - just show snackbar
        Get.snackbar(
          'Email Sent',
          'A 6-digit verification code has been sent to your email.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          duration: const Duration(seconds: 4),
        );
        _startResendCooldown(60);
      } else {
        // Code was NOT sent before navigation - send it in the background (non-blocking)
        _sendVerificationEmailOnLoad();
        // Start cooldown immediately while email is being sent
        _startResendCooldown(60);
      }
    });
  }

  /// Send verification email when the page loads (if not already sent)
  /// This runs in the background and doesn't block the UI
  void _sendVerificationEmailOnLoad() {
    if (widget.email.isEmpty) return;

    // Fire and forget - send email in background without blocking
    context.read<EmailVerificationCubit>().resendVerificationEmail().then((_) {
      if (mounted) {
        Get.snackbar(
          'Email Sent',
          'A 6-digit verification code has been sent to your email.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          duration: const Duration(seconds: 4),
        );
      }
    }).catchError((e) {
      if (mounted) {
        Get.snackbar(
          "Couldn't send email",
          'We could not send your verification code. Tap "Resend Code" to try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          duration: const Duration(seconds: 4),
        );
      }
    });
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
    // Phone is now captured at the bottom of signup page 2 (with country
    // chip + SIM-hint prefill + length validation), so by the time we
    // reach email verification a phone always exists. Go straight to OTP
    // entry. (The standalone AddPhoneNumber screen has been removed.) If
    // the phone is somehow missing — defensive only — fall through to
    // passcode setup so the user isn't stranded.
    final preExistingPhone = widget.secondaryPhone;
    if (preExistingPhone != null && preExistingPhone.isNotEmpty) {
      // Phone verification is skippable (parity with email verify) — the
      // user can defer SMS OTP to Settings if their network refuses to
      // deliver the code right now. They still proceed to passcode setup.
      Get.offAllNamed(AppRoutes.phoneVerification, arguments: {
        'phoneNumber': preExistingPhone,
        'codeSent': false, // request OTP fresh — page sends on load
        'expiresIn': 600,
        'isRequired': false,
        'secondaryEmail': null,
      });
    } else {
      Get.offAllNamed(AppRoutes.passcodeSetup);
    }
  }

  void _skipVerification() {
    // Email verification is always skippable during onboarding — the user can
    // defer the OTP to Settings if their inbox/network can't deliver the code
    // right now. Skipping does NOT mark the email verified; it only advances
    // the flow to the same next step a successful verification reaches.
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    final maskedEmail = _maskEmail(widget.email);

    return PopScope(
      canPop: true, // Verification is skippable, so back navigation is allowed
      child: Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocListener(
          listeners: [
            // Email verification listener
            BlocListener<EmailVerificationCubit, EmailVerificationState>(
              listener: (context, state) {
                if (state is EmailVerificationSuccess) {
                  // Update AuthenticationCubit with the verified profile
                  // This ensures the user remains logged in after email verification
                  context.read<AuthenticationCubit>().updateProfileAfterVerification(state.profile);

                  // Navigate to next screen on successful verification
                  _navigateToNextScreen();
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
            ),
          ],
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
                            colors: [Color(0xFF4834D4), Color(0xFF7C3AED)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4834D4).withValues(alpha: 0.3),
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

                      // 6-Digit OTP Input
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
                            backgroundColor: const Color(0xFF4834D4),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFF4834D4).withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: isVerifying
                              ? LazerVaultLoader.small()
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
                                ? LazerVaultLoader.tiny()
                                : Text(
                                    _resendCooldown > 0
                                        ? 'Resend in ${_resendCooldown}s'
                                        : 'Resend Code',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: _resendCooldown > 0
                                          ? const Color(0xFF9CA3AF)
                                          : const Color(0xFF4834D4),
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      // Skip Button — always available; advances onboarding
                      // without marking the email verified.
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
                                color: const Color(0xFF4834D4).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.security_rounded,
                                color: const Color(0xFF4834D4),
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
                                    'Check your inbox and spam folder for the 6-digit verification code. The code expires in 15 minutes.',
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
