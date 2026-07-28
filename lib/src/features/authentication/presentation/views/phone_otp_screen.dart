import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';

/// Step 2: enter the 6-digit SMS OTP. Supports SMS autofill (via
/// [VerificationCodeInput]) and a resend with cooldown driven by the
/// [PhoneOtpSent] state's `resendAfterSeconds`.
class PhoneOtpScreen extends StatefulWidget {
  const PhoneOtpScreen({super.key});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  String _code = '';
  // Bumped on a failed verify so the code input rebuilds cleared.
  int _resetKey = 0;
  // Initial resend cooldown + a key to reset the shared ResendCodeButton (e.g.
  // when an expired code lets the user resend immediately).
  int _resendInitial = 0;
  int _resendKey = 0;

  @override
  void initState() {
    super.initState();
    final state = context.read<PhonePasscodeCubit>().state;
    if (state is PhoneOtpSent) {
      _resendInitial = state.resendAfterSeconds;
    }
  }

  void _verify() {
    if (_code.length != 6) {
      showAppSnackbar('Incomplete', 'Enter the 6-digit code.',
          type: AppSnackbarType.error);
      return;
    }
    final cubit = context.read<PhonePasscodeCubit>();
    cubit.verifyOtp(phone: cubit.phone, code: _code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        if (state is PhoneOtpVerified) {
          Get.toNamed(AppRoutes.phonePasscodeCreate);
        } else if (state is PhonePasscodeFailure) {
          // Clear the boxes so the user can re-enter; if the code lapsed, reset
          // the resend control so they can request a fresh one immediately.
          _code = '';
          final lower = state.message.toLowerCase();
          if (lower.contains('expired') || lower.contains('no attempts')) {
            _resendInitial = 0;
            _resendKey++;
          }
          setState(() => _resetKey++);
          showAppSnackbar('Error', state.message,
              type: AppSnackbarType.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<PhonePasscodeCubit>();
        final isLoading = state is PhonePasscodeLoading;
        return PhoneFlowScaffold(
          title: 'Verify your number',
          subtitle: 'Enter the 6-digit code we sent to ${cubit.phone}.',
          step: 2,
          totalSteps: 5,
          primaryLabel: 'Verify',
          isLoading: isLoading,
          onPrimary: isLoading ? null : _verify,
          // Skip is offered ONLY when the admin hasn't made phone verification
          // required. When required, the backend also rejects an unverified
          // SignupWithPhone, so there is no skip path.
          secondaryAction: FeatureFlags.isPhoneVerificationRequired
              ? null
              : TextButton(
                  onPressed: isLoading
                      ? null
                      : () =>
                          context.read<PhonePasscodeCubit>().skipPhoneVerification(),
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
          children: [
            SizedBox(height: 8.h),
            // Top badge icon — matches the email_password verification screens.
            const Center(
                child: VerificationBadgeIcon(icon: Icons.sms_outlined)),
            SizedBox(height: 28.h),
            VerificationCodeInput(
              key: ValueKey(_resetKey),
              onChanged: (code) => _code = code,
              onCompleted: (code) {
                _code = code;
                if (!isLoading) _verify();
              },
            ),
            SizedBox(height: 28.h),
            Center(
              child: ResendCodeButton(
                key: ValueKey('resend-$_resendKey'),
                initialSeconds: _resendInitial,
                onResend: () async {
                  context.read<PhonePasscodeCubit>().resendPhoneOtp();
                  return 60;
                },
              ),
            ),
            SizedBox(height: 28.h),
            // Bottom "Secure Verification" reassurance note — shared widget.
            const SecureVerificationNote(
              message:
                  'We sent a 6-digit code via SMS to verify your phone number. Standard message rates may apply.',
            ),
          ],
        );
      },
    );
  }
}
