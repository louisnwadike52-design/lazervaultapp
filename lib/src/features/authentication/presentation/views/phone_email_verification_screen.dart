import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/src/core/config/app_environment.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';

/// Step 5 (final signup step) of the phone+passcode flow: collect the email AND
/// verify it inline. Two phases on one slide:
///   1. EMAIL — enter the email (required for the account / KYC). On Continue the
///      account is created (which sends a verification code), then the code
///      section slides down.
///   2. CODE  — enter the 6-digit code. "Verify" confirms it; a "Skip for now"
///      CTA is offered when the admin has NOT made email verification mandatory
///      (`email_verification_required`, skippable by default — mirrors phone
///      verification). Either way the flow then continues to transaction-PIN
///      setup.
class PhoneEmailVerificationScreen extends StatefulWidget {
  const PhoneEmailVerificationScreen({super.key});

  @override
  State<PhoneEmailVerificationScreen> createState() =>
      _PhoneEmailVerificationScreenState();
}

enum _Phase { email, code }

class _PhoneEmailVerificationScreenState
    extends State<PhoneEmailVerificationScreen> {
  static const _brand = Color(0xFF4834D4);
  static const _ink = Color(0xFF1F2937);

  final _emailCtrl = TextEditingController();
  _Phase _phase = _Phase.email;
  String _code = '';
  int _resendInitial = 0;
  int _resendKey = 0;
  String? _error;

  bool get _required => FeatureFlags.isEmailVerificationRequired;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email);

  String _maskEmail(String email) {
    final at = email.indexOf('@');
    if (at <= 1) return email;
    final name = email.substring(0, at);
    final domain = email.substring(at);
    final keep = name.length <= 2 ? 1 : 2;
    return '${name.substring(0, keep)}${'*' * (name.length - keep)}$domain';
  }

  // ── Phase 1: submit email → create account (sends code) ──────────────────
  void _onPrimary() {
    if (_phase == _Phase.email) {
      final email = _emailCtrl.text.trim();
      if (email.isEmpty || !_isValidEmail(email)) {
        setState(() => _error = 'Please enter a valid email address.');
        return;
      }
      setState(() => _error = null);
      context.read<PhonePasscodeCubit>().submitSignup(email: email);
    } else {
      // Phase 2: verify the entered code.
      context.read<PhonePasscodeCubit>().verifyEmailCode(_code);
    }
  }

  void _onSkip() {
    // Account already created (email present, just unverified). The login gate
    // re-prompts later only if the admin flips email verification to required.
    Get.offAllNamed(AppRoutes.transactionPinSetup);
  }

  void _goToPin() => Get.offAllNamed(AppRoutes.transactionPinSetup);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        if (state is PhoneSignupSuccess) {
          // Account created + verification code dispatched → reveal the code
          // section and hydrate the shared profile for downstream screens.
          context.read<AuthenticationCubit>().hydrateProfile(state.profile);
          setState(() {
            _phase = _Phase.code;
            _resendInitial = 60;
            _resendKey++;
          });
          // Moving to the code phase IS the confirmation, and that screen
          // names the address the code went to.
        } else if (state is PhoneEmailVerified) {
          context.read<AuthenticationCubit>().hydrateProfile(state.profile);
          _goToPin();
        } else if (state is PhoneEmailCodeResent) {
          // Nothing to show: the ResendCodeButton owns its own countdown and
          // restarts it on tap, which already tells the user the resend went
          // through. A toast on top of that is noise.
        } else if (state is PhonePasscodeFailure) {
          if (state.restartFlow) {
            showAppSnackbar('Session expired', state.message,
                type: AppSnackbarType.error);
            Get.offAllNamed(AppRoutes.phoneEntry);
          } else {
            showAppSnackbar(
                _phase == _Phase.email
                    ? 'Couldn\'t use that email'
                    : 'Invalid code',
                state.message,
                type: AppSnackbarType.error);
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is PhonePasscodeLoading;
        final inCode = _phase == _Phase.code;
        return PhoneFlowScaffold(
          title: inCode ? 'Verify your email' : 'Your email',
          subtitle: inCode
              ? 'Enter the 6-digit code we sent to ${_maskEmail(_emailCtrl.text.trim())}.'
              : 'We\'ll send a code to confirm it\'s really you, so make sure it\'s valid.',
          step: 5,
          totalSteps: 5,
          // Email phase: allow back to edit the stashed details. Code phase: the
          // account already exists, so block back to avoid a re-create attempt.
          showBack: !inCode,
          primaryLabel: inCode ? 'Verify' : 'Continue',
          isLoading: isLoading,
          onPrimary: isLoading ? null : _onPrimary,
          // Skip is only offered once the account exists (code phase) and only
          // when the admin hasn't made email verification mandatory. Hidden on
          // PROD builds: email verification is mandatory in production, so the
          // "Skip for now" escape hatch is dev/staging only.
          secondaryAction: (inCode &&
                  !_required &&
                  !currentAppEnvironment.isProduction)
              ? Center(
                  child: TextButton(
                    onPressed: isLoading ? null : _onSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: _brand,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Skip for now',
                            style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: _brand)),
                        SizedBox(width: 6.w),
                        Icon(Icons.arrow_forward_rounded,
                            size: 18.sp, color: _brand),
                      ],
                    ),
                  ),
                )
              : null,
          children: [
            SizedBox(height: inCode ? 4.h : 8.h),
            Center(
              // Smaller badge once the code section is in, so the Verify + Skip
              // CTAs stay on the white body (not the bottom purple wave).
              child: VerificationBadgeIcon(
                  icon: Icons.email_rounded, size: (inCode ? 56 : 84).r),
            ),
            SizedBox(height: inCode ? 14.h : 20.h),
            BuildFormField(
              name: 'email',
              placeholder: 'Email',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              // Once the account is created the email is fixed — lock the field.
              readOnly: inCode,
              prefixIcon:
                  const Icon(Icons.email_outlined, color: Colors.black45),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            if (_error != null) ...[
              SizedBox(height: 8.h),
              Text(_error!,
                  style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500)),
            ],
            // The verification code section slides down once the account exists.
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: inCode
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 24.h),
                        Text('Verification code',
                            style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: _ink)),
                        SizedBox(height: 12.h),
                        VerificationCodeInput(
                          key: ValueKey('code-$_resendKey'),
                          onChanged: (v) => _code = v,
                          onCompleted: (v) {
                            _code = v;
                            if (!isLoading) _onPrimary();
                          },
                        ),
                        SizedBox(height: 16.h),
                        ResendCodeButton(
                          key: ValueKey('resend-$_resendKey'),
                          initialSeconds: _resendInitial,
                          prompt: 'Didn\'t get the code? ',
                          onResend: () async {
                            context
                                .read<PhonePasscodeCubit>()
                                .resendSignupEmailCode();
                            return 60;
                          },
                        ),
                      ],
                    )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
            // Reassurance shown while entering the email. Hidden in the code
            // phase to keep the slide compact so the Verify + "Skip for now"
            // CTAs land on the white body and stay visible.
            if (!inCode) ...[
              SizedBox(height: 28.h),
              const SecureVerificationNote(
                message:
                    'Your email is used to secure your account and recover access. '
                    'We only send a one-time code, never your password.',
              ),
              SizedBox(height: 8.h),
            ],
          ],
        );
      },
    );
  }
}
