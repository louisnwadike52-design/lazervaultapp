import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lazervault/core/shared_widgets/otp_field_behaviour.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import 'package:pinput/pinput.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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
  String? _errorMessage;
  String _maskedContact = '';
  String _phone = '';
  String _deliveryMethod = 'sms';
  Timer? _expiryTimer;
  int _remainingSeconds = 0;

  /// Whether the SERVER has told us how long this code lives.
  ///
  /// Without this, an expiry of 0 — which is what an unset field decodes to —
  /// was indistinguishable from a code that had genuinely run out, and the
  /// screen greeted a freshly-sent code with "Code has expired". Unknown now
  /// renders NOTHING, which is the same rule phone_verification_screen
  /// applies (`if (_expirySeconds > 0)`).
  bool _expiryKnown = false;

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
          // 0 is what an unset proto field decodes to, so it must NOT be
          // treated as a real lifetime — and must not fall back to a
          // fabricated 900 either, which would count down from fifteen
          // minutes against a TTL nobody checked.
          final ttl = args['expiresInSeconds'] as int? ?? 0;
          _remainingSeconds = ttl;
          _expiryKnown = ttl > 0;
        });
        if (_expiryKnown) _startExpiryTimer();
      }
    });

    _pinController.addListener(() {
      if (_errorMessage != null && _pinController.text.length == 6) {
        setState(() {
          _errorMessage = null;
        });
      }
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
    // Guard against a double-submit: auto-verify (onCompleted) and a manual
    // "Verify" tap can race in the window before the button/input disable.
    if (_isLoading) return;
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
          // Clear and refocus for retry
          _pinController.clear();
          _focusNode.unfocus();
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) _focusNode.requestFocus();
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
          // No confirmation toast — the expiry countdown restarting below is
          // the visible proof a fresh code was issued. Failures still toast
          // (the Left branch above).
          setState(() {
            _remainingSeconds = data.expiresInSeconds;
            _expiryKnown = data.expiresInSeconds > 0;
            _pinController.clear();
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
        // Icon — brand purple accent
        Center(
          child: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4834D4).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _deliveryMethod == 'email'
                  ? Icons.email_outlined
                  : Icons.sms_outlined,
              size: 32.w,
              color: const Color(0xFF4834D4),
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

        // Expiry line.
        //
        // THREE STATES, NOT TWO. Unknown renders nothing: a lifetime the
        // server never sent is not an expired code, and saying so on a code
        // that was just delivered is the worst of the three.
        //
        // The running countdown also honours the admin switch — these screens
        // already carry a resend timer, which is the number a user can act
        // on. A code that has genuinely RUN OUT still says so either way,
        // because that explains why the button stopped working.
        // ONLY THE EXPIRED NOTICE, never a live countdown.
        //
        // "Code has expired" explains why the button stopped working, which is
        // a fact the customer has to act on. A running "expires in 14:43" is a
        // window they cannot influence, sitting beside a resend countdown that
        // says when they may actually do something — the pair was read as one
        // number and people waited on the wrong one.
        if (_expiryKnown && _remainingSeconds <= 0)
          Text(
            'Code has expired',
            textAlign: TextAlign.center,
            // ORANGE, UNCONDITIONALLY. The branch here read
            // `_remainingSeconds > 300 ? muted : orange`, inside a widget that
            // only renders when `_remainingSeconds <= 0` — so the muted arm
            // was unreachable. It was also a leftover of the old five-minute
            // window: with the code lifetime now an admin dial (90 seconds in
            // production) a 300-second threshold could never be crossed even
            // if the branch were reachable. An expired code is a thing the
            // customer must act on, so it is always the warning colour.
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.orange.withValues(alpha: 0.8),
            ),
          ),
        SizedBox(height: 32.h),

        // PIN Input
        //
        // AN AutofillGroup IS REQUIRED EVEN THOUGH Pinput ALREADY SETS THE
        // HINT. It defaults `autofillHints` to `[AutofillHints.oneTimeCode]`,
        // which is why the comment below used to say autofill was "handled by
        // the platform" — but Pinput does NOT wrap itself in an AutofillGroup,
        // and Flutter forwards hints to the platform only when one is an
        // ancestor. So the tag was there, correct, and inert: no "From
        // Messages" suggestion on iOS, and the field never offered to
        // Android's autofill framework.
        AutofillGroup(
          child: Pinput(
            controller: _pinController,
            focusNode: _focusNode,
            length: 6,
            // PASTE. Pinput defaults this to false, so a long press produced no
            // handles and no menu — there was no way to paste a code the
            // customer had copied out of their messages. Its contextMenuBuilder
            // already defaults to a real toolbar, so this is the only half that
            // was missing.
            enableInteractiveSelection: true,
            // And the paste has to survive being pasted: people paste the whole
            // line they copied, so digits are extracted before the length limit
            // can cut "Your code is 123456" down to its first six characters.
            inputFormatters: otpInputFormatters(6),
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF4834D4), width: 2),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                color: const Color(0xFF4834D4).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF4834D4)),
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
            // Validate as soon as the 6th digit lands — the code is verified with
            // the backend and we only advance to the new-password screen on
            // success (invalid/expired codes never proceed). The button remains
            // for manual retry.
            onCompleted: (_) {
              if (!_isLoading && _remainingSeconds > 0) _verifyOTP();
            },
          ),
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

        // Verify Button — brand purple primary
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4834D4),
            foregroundColor: Colors.white,
            disabledBackgroundColor:
                const Color(0xFF4834D4).withValues(alpha: 0.4),
            disabledForegroundColor: Colors.white70,
            elevation: 0,
            shape: const StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            minimumSize: Size(double.infinity, 48.h),
          ),
          onPressed: (_isLoading || _remainingSeconds <= 0) ? null : _verifyOTP,
          child: _isLoading
              ? LazerVaultLoader.small()
              : Text(
                  'Verify Code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
        ),

        SizedBox(height: 16.h),

        // Resend Button — brand purple accent
        TextButton(
          onPressed: (_isResending || _isLoading) ? null : _resendCode,
          child: _isResending
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LazerVaultLoader(size: 14),
                    SizedBox(width: 8.w),
                    Text(
                      'Sending...',
                      style: TextStyle(
                        color: const Color(0xFF4834D4),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Resend Code',
                  style: TextStyle(
                    color: const Color(0xFF4834D4),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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
