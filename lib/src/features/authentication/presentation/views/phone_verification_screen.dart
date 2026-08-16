import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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
  final String? nextRoute;
  // Launched from Settings: request a fresh code on load, return to Settings on
  // success, hide Skip.
  final bool fromSettings;

  const PhoneVerificationScreen({
    super.key,
    this.phoneNumber,
    this.codeSent = true, // Default true - OTP sent during signup
    this.expiresIn,
    this.isRequired = true,
    this.secondaryEmail,
    this.nextRoute,
    this.fromSettings = false,
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
    String? nextRouteArg = nextRoute;
    // Whether this was launched from a logged-in profile surface (Settings / My
    // Account). MUST be parseable from route args so callers that push via
    // Get.toNamed can opt in — otherwise the screen falls into the onboarding
    // chain and "skip" routes to passcode setup, which is wrong post-login.
    bool settingsSource = fromSettings;

    if (args is Map) {
      final m = Map<String, dynamic>.from(args);
      phone = m['phoneNumber'] as String? ?? phone;
      otpSent = m['codeSent'] as bool? ?? otpSent;
      expiry = m['expiresIn'] as int? ?? expiry;
      required = m['isRequired'] as bool? ?? required;
      secondaryEmailArg = m['secondaryEmail'] as String?;
      nextRouteArg = m['nextRoute']?.toString() ?? nextRouteArg;
      settingsSource = m['fromSettings'] as bool? ?? settingsSource;
    } else if (args is String) {
      // Simple string argument (phone number only)
      phone = args;
    }

    return BlocProvider(
      create: (_) => serviceLocator<PhoneVerificationCubit>(),
      child: _PhoneOtpVerificationView(
        phoneNumber: phone ?? '',
        codeSent: settingsSource ? false : otpSent,
        expiresIn: expiry ?? 600, // Default 10 minutes
        isRequired: required,
        secondaryEmail: secondaryEmailArg,
        nextRoute: nextRouteArg,
        fromSettings: settingsSource,
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
  final String? nextRoute;
  final bool fromSettings;

  const _PhoneOtpVerificationView({
    required this.phoneNumber,
    required this.codeSent,
    required this.expiresIn,
    required this.isRequired,
    this.secondaryEmail,
    this.nextRoute,
    this.fromSettings = false,
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
  // Belt-and-braces for the DEFAULT next-step: whether the user already has a
  // passcode, so an entry path that didn't thread `nextRoute` (e.g. cold-boot
  // resume) still never re-asks for a passcode they already set.
  bool _hasPasscode = false;

  @override
  void initState() {
    super.initState();
    // Best-effort read of the persisted passcode flag (written on login/setup).
    () async {
      try {
        final v = await serviceLocator<FlutterSecureStorage>()
            .read(key: 'has_passcode');
        if (mounted && (v == 'true' || v == '1')) {
          setState(() => _hasPasscode = true);
        }
      } catch (_) {/* default false — worst case shows passcode setup */}
    }();

    // Initialize the cubit with the phone number
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<PhoneVerificationCubit>();
      cubit.updatePhoneNumber(widget.phoneNumber);
      cubit.updateVerificationCode('');
      // No code sent yet (e.g. launched from Settings) — request one now.
      if (!widget.codeSent && widget.phoneNumber.isNotEmpty) {
        cubit.requestPhoneVerification(phoneNumber: widget.phoneNumber);
        _startExpiryCountdown(widget.expiresIn);
        _startResendCooldown(60);
      }
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
    // Launched from Settings: return there (caller refreshes the badge). Never
    // route into onboarding/passcode setup.
    if (widget.fromSettings) {
      Navigator.of(context).pop(true);
      return;
    }
    // A caller-supplied nextRoute (re-verification gate / phone-flow chaining)
    // takes priority over the default onboarding chain.
    if (widget.nextRoute != null && widget.nextRoute!.isNotEmpty) {
      Get.offAllNamed(widget.nextRoute!);
      return;
    }
    // Check if there's secondary email verification needed
    if (widget.secondaryEmail != null && widget.secondaryEmail!.isNotEmpty) {
      Get.offAllNamed(AppRoutes.emailVerification, arguments: {
        'email': widget.secondaryEmail,
        'codeSent': true,
        'isRequired': false, // Secondary verification is skippable
        'secondaryPhone': null,
      });
    } else if (_hasPasscode) {
      // Already has a passcode — never re-ask for it. Go to the transaction-PIN
      // setup gate (which itself no-ops if a PIN is already set), matching the
      // resume resolver's post-verify routing.
      Get.offAllNamed(AppRoutes.transactionPinSetup, arguments: {
        'fromLoginFlow': true,
      });
    } else {
      // No passcode yet — genuine passcode setup.
      Get.offAllNamed(AppRoutes.passcodeSetup);
    }
  }

  void _skipVerification() {
    // Phone verification is always skippable during onboarding — the user can
    // defer the SMS OTP to Settings if their network can't deliver the code
    // right now. Skipping does NOT mark the phone verified; it only advances
    // the flow to the same next step a successful verification reaches.
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    final maskedPhone = _maskPhoneNumber(widget.phoneNumber);

    return PopScope(
      canPop: true, // Verification is skippable, so back navigation is allowed
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

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // From Settings this is a normal sub-screen → real back
                      // button. Onboarding (no fromSettings) stays forward-only.
                      if (widget.fromSettings)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: IconButton(
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
                              tooltip: 'Back',
                            ),
                          ),
                        ),
                      SizedBox(height: widget.fromSettings ? 12.h : 60.h),

                      // Shared gradient badge icon (same as the phone_passcode
                      // OTP screen + email verification).
                      const VerificationBadgeIcon(
                          icon: Icons.phone_android_rounded),
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

                      // Skip CTA — onboarding only; hidden when from Settings.
                      if (!widget.fromSettings) SizedBox(height: 12.h),
                      if (!widget.fromSettings) Center(
                        child: TextButton(
                          onPressed: _skipVerification,
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF4834D4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Skip for now',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF4834D4),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18.sp,
                                color: const Color(0xFF4834D4),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 48.h),

                      // Shared "Secure Verification" note.
                      const SecureVerificationNote(
                        message:
                            'We sent a 6-digit code via SMS to verify your phone number. Standard message rates may apply.',
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
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
