import 'package:flutter/material.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/signup_switch_account_cta.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';
import 'package:lazervault/src/features/authentication/domain/signup_steps.dart';

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

  /// In-flight latch, set SYNCHRONOUSLY the instant a verify is dispatched.
  ///
  /// WHY NOT `isLoading`. Both submit paths guarded on the bloc state —
  /// `onPrimary: isLoading ? null : _verify` and `if (!isLoading) _verify()`.
  /// That state only arrives after the cubit emits, so between dispatching a
  /// verify and the Loading state landing, `isLoading` is still false and a
  /// second submit passes straight through. The sixth digit auto-submits while
  /// the Verify button is still live, so one user action could send two
  /// verifies — and the server counts each one.
  ///
  /// That is what "incorrect code. 2 attempt(s) remaining" after a single
  /// wrong entry was: three attempts spent two at a time. A latch set before
  /// the await closes the window the state round-trip leaves open.
  bool _verifying = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<PhonePasscodeCubit>().state;
    if (state is PhoneOtpSent) {
      _resendInitial = state.resendAfterSeconds;
    }
  }

  void _verify() {
    if (_verifying) return;
    if (_code.length != 6) {
      showAppSnackbar('Incomplete', 'Enter the 6-digit code.',
          type: AppSnackbarType.error);
      return;
    }
    _verifying = true;
    final cubit = context.read<PhonePasscodeCubit>();
    cubit.verifyOtp(phone: cubit.phone, code: _code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        // Released on EVERY outcome, not just failure: a verified code that
        // navigates away still has to clear the latch, or coming back to this
        // screen finds it permanently unable to submit.
        if (state is! PhonePasscodeLoading) _verifying = false;

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
          showAppSnackbar('Error', state.message, type: AppSnackbarType.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<PhonePasscodeCubit>();
        final isLoading = state is PhonePasscodeLoading;
        return PhoneFlowScaffold(
          title: 'Verify your number',
          subtitle: 'Enter the 6-digit code we sent to ${cubit.phone}.',
          step: signupStepNumber(SignupStep.phoneOtp),
          totalSteps: signupStepTotal(SignupStep.phoneOtp),
          primaryLabel: 'Verify',
          isLoading: isLoading,
          onPrimary: isLoading ? null : _verify,
          // SKIP IS AN ESCAPE HATCH, NOT A CHOICE — see
          // phone_verification_screen's `_allowSkip`, which this mirrors.
          //
          // Operator directive: with the SMS provider ACTIVE and this screen
          // showing, there is no skip. The code is on its way; the honest paths
          // are to enter it or to use a different number.
          //
          // Kept for the one case that needs it: the provider going
          // unavailable while the screen is open (an admin switching it off
          // mid-flow, or the first flag snapshot resolving after the route),
          // which leaves a screen waiting for a code that will never arrive.
          // `isPhoneVerificationRequired` still vetoes, because then the
          // backend rejects an unverified SignupWithPhone and there is no skip
          // path to offer at all.
          // THE WAY OUT OF A RESUMED SIGNUP — in the FOOTER, not the body.
          //
          // Entered two ways and only one has an exit: direct signup is pushed
          // from phone entry so the stack pops and the scaffold derives a back
          // arrow, while a RESUMPTION arrives as the initial route with an
          // empty stack — correctly no arrow, and with SMS live no skip
          // either. That left nothing to tap.
          //
          // IT BELONGS IN THE FOOTER AND I PUT IT IN THE BODY FIRST, WHICH IS
          // WHY IT COULD NOT BE SEEN. `children` render above the primary CTA
          // on the light part of the curve; the footer is the slot this
          // scaffold designed for the purple band at the bottom, and it
          // expects WHITE text there. Rendering the light-surface (grey)
          // variant into the body put #6B7280 against the purple wave — the
          // "items at the bottom are not visible" report. The footer is also
          // hidden while the keyboard is up, so it can never cover the input.
          //
          // The widget gates itself on wasResumedThisLaunch, so first-run
          // signup is untouched and nobody mid-signup is invited to abandon it.
          footer: const SignupSwitchAccountCta(bottomPadding: 2),
          secondaryAction: !SmsPolicy.showOtpSkip
              ? null
              : TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context
                          .read<PhonePasscodeCubit>()
                          .skipPhoneVerification(),
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
                // SMS screen: DND can block the code once it is
                // actually delivered over a downgraded route.
                showSmsDndHelp: true,
                key: ValueKey('resend-$_resendKey'),
                initialSeconds: _resendInitial,
                onResend: () async {
                  context.read<PhonePasscodeCubit>().resendPhoneOtp();
                  // The SERVER's cooldown, not a literal. auth-service reads
                  // `auth_otp_resend_cooldown_seconds` (otp_resend.go) and
                  // refuses an earlier request, so a hardcoded 60 here unlocks
                  // the button at the wrong moment the instant an operator
                  // changes it.
                  return endpointRegistry.otpResendCooldownSeconds;
                },
              ),
            ),
            SizedBox(height: 28.h),
            // Bottom "Secure Verification" reassurance note — shared widget.
            const SecureVerificationNote(
              message:
                  'We sent a 6-digit code via SMS to verify your phone number.',
            ),
          ],
        );
      },
    );
  }
}
