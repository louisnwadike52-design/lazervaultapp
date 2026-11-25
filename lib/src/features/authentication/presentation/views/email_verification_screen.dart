import 'dart:async';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/core/config/app_environment.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/utils/pin_step_prefetch.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_state.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_otp_send_guard.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/signup_switch_account_cta.dart';
import 'package:lazervault/src/features/support/presentation/locked_out_support.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart';
part 'email_verification_screen_widgets.dart';

class _EmailOtpVerificationViewState extends State<_EmailOtpVerificationView> {
  /// Bumped to remount the code input so it comes back EMPTY and focused.
  ///
  /// THE BUG THIS FIXES — reported as "the number was pressing but not
  /// inputting" and "the cursor line just disappears".
  ///
  /// The input auto-submits on the sixth digit. When the server rejects the
  /// code, nothing cleared the field, so it sat holding six wrong digits — and
  /// a FULL pin field is inert by construction:
  ///
  ///   * `maxLength: 6` on the underlying TextField silently discards every
  ///     further keypress, so the keypad responds and no digit appears;
  ///   * the box decoration only paints a caret while `index < pinLength`, so
  ///     at six digits the cursor is not drawn at all — it "disappears";
  ///   * tapping a box changes nothing visible, because there is nothing to
  ///     move a caret to.
  ///
  /// The screen looked broken while behaving exactly as written. Every sibling
  /// OTP screen in this flow (phone_otp, phone_verification,
  /// forgot_passcode_phone, phone_email_verification) already carries a reset
  /// key for precisely this reason; this screen was the one that did not.
  int _codeResetKey = 0;

  /// Remounts [ResendCodeButton] when the server hands us a different wait
  /// (a rate-limit refusal), since its countdown is seeded on mount.
  int _resendKey = 0;

  /// THE ADMIN'S DIAL, not a number compiled in here.
  ///
  /// This was 60 while auth-service read `auth_otp_resend_cooldown_seconds`
  /// (90 at the time), so the button unlocked thirty seconds early and the
  /// server refused the tap — a control offered and then rejected. Both sides
  /// read the one key now.
  late int _resendInitialSeconds = endpointRegistry.otpResendCooldownSeconds;
  // Resolved email — widget.email when navigated with args, else recovered from
  // the persisted session on a cold-resume (app relaunched mid-onboarding, so
  // there are no route arguments).
  late String _email = widget.email;

  @override
  void initState() {
    super.initState();

    // Initialize the cubit with email for resending
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_email.isEmpty) {
        // Cold resume: recover the signup email from secure storage so the
        // verification screen isn't stranded without an address to verify.
        final storage = serviceLocator<FlutterSecureStorage>();
        _email =
            (await storage.read(key: 'stored_email')) ??
            (await storage.read(key: 'user_email')) ??
            '';
        if (mounted) setState(() {});
      }
      if (!mounted) return;
      context.read<EmailVerificationCubit>().initialize(_email);
      // NOT cleared here any more.
      //
      // This ran on every mount. On a RE-mount — the OS reclaimed the app while
      // the user was in their mail client, or the widget subtree was replaced —
      // the cubit survives, so this threw away digits the user had already
      // entered and the screen appeared to reset itself. It was also a no-op on
      // a genuinely fresh mount, where the code is already empty.

      if (widget.codeSent) {
        // NO ARRIVAL TOAST. The screen's own heading already says "Enter the
        // 6-digit code sent to lo***@gmail.com" — a green banner repeating it
        // the instant the page opens tells the customer nothing they are not
        // already reading, covers the top of the screen, and (reported
        // 2026-11-10) reads as if something just happened when nothing did.
        //
        // The cooldown IS still armed: a code really was sent moments ago,
        // and the Resend control stays disabled until it elapses — so the only
        // way to learn about the wait is to want a resend, which is exactly
        // when it is worth saying.
        //
        // THE SERVER'S NUMBER, NOT A LITERAL. This said 60 while the live dial
        // said 90, so the button unlocked thirty seconds early; every tap in
        // that gap was refused AND spent a resend from the budget, until the
        // budget was exhausted and resend stopped working altogether. Measured
        // on prod 2026-11-25 against a customer who reported exactly that.
        _armResendCooldown(_resendInitialSeconds);
      } else {
        // Code was NOT sent before navigation — send it, UNLESS one was sent
        // for this address moments ago.
        //
        // A re-mount of this screen used to auto-send unconditionally, and the
        // server DELETES the previous row when it issues a new code — so a
        // re-mount invalidated the very code the user had switched apps to go
        // and read. See EmailOtpSendGuard.
        if (await EmailOtpSendGuard.mayAutoSend(_email)) {
          _sendVerificationEmailOnLoad();
          unawaited(EmailOtpSendGuard.markSent(_email));
        }
        // Cooldown either way: a code IS live, so the button must stay disabled
        // for the same period whether or not we just sent one — and for the
        // server's period, not a literal. See the note above.
        _armResendCooldown(_resendInitialSeconds);
      }
    });
  }

  /// Send verification email when the page loads (if not already sent)
  /// This runs in the background and doesn't block the UI
  void _sendVerificationEmailOnLoad() {
    if (_email.isEmpty) return;

    // Fire and forget. The success "code sent" snackbar is shown exactly ONCE
    // by the BlocListener below (on the cubit's successMessage emit) — which
    // also covers the "Resend Code" button. Do NOT also show one here or two
    // snackbars (same meaning, different text) appear on load.
    unawaited(EmailOtpSendGuard.markSent(_email));
    context.read<EmailVerificationCubit>().resendVerificationEmail().catchError((
      e,
    ) {
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
      // The handler has to answer the Future<int?>: nothing was sent, so
      // no countdown is armed — the Resend control stays tappable.
      return null;
    });
  }

  /// "60 seconds" / "2 minutes" / "1 minute 30 seconds", from a second count.
  ///
  /// Mirrors notifications-service's expiryPhrase so the sentence on this
  /// screen and the sentence in the email agree — the two are read minutes
  /// apart by the same person, and disagreeing about the same code is worse
  /// than either wording alone.
  static String _expiryPhrase(int seconds) {
    // Seconds up to two minutes, matching notifications-service's expiryPhrase
    // exactly. The two are read minutes apart by the same person — the screen
    // and then the email — and disagreeing about the same code ("90 seconds"
    // here, "2 minutes" there) is worse than either wording alone.
    if (seconds <= 120) return '$seconds seconds';
    final m = seconds ~/ 60;
    final rem = seconds % 60;
    final mins = m == 1 ? '1 minute' : '$m minutes';
    if (rem == 0) return mins;
    return '$mins $rem seconds';
  }

  /// Arms the resend countdown for [seconds].
  ///
  /// This replaced a `Timer.periodic` that lived on THIS State and called
  /// `setState` once a second. Two things were wrong with that:
  ///
  ///  1. It rebuilt the whole page — the pin field included — sixty times
  ///     while the user was trying to type into it. [ResendCodeButton] owns
  ///     its own timer, so the tick now repaints one line of text.
  ///  2. It was re-armed from a STICKY state flag, so a later unrelated emit
  ///     that still carried the old `successMessage` restarted the full wait.
  ///     That is the "the timing resets" complaint. It is now armed from
  ///     discrete events only: the initial send, and the server's answer to an
  ///     actual resend.
  void _armResendCooldown(int seconds) {
    if (!mounted) return;
    setState(() {
      _resendInitialSeconds = seconds;
      _resendKey++;
    });
  }

  /// Clears the digits the server just rejected and puts the caret back in the
  /// first box, so the user can simply retype. See [_codeResetKey].
  void _resetCodeInput() {
    if (!mounted) return;
    context.read<EmailVerificationCubit>().updateVerificationCode('');
    setState(() => _codeResetKey++);
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
    final visibleEnd = localPart.length > 4
        ? localPart.substring(localPart.length - 1)
        : '';
    final maskedLength = localPart.length - 2 - (visibleEnd.isEmpty ? 0 : 1);
    final masked = '*' * (maskedLength > 0 ? maskedLength : 1);

    return '$visibleStart$masked$visibleEnd@$domain';
  }

  Future<void> _navigateToNextScreen() async {
    // Launched from Settings: just return there (the caller refreshes the
    // verified badge). Never route into the onboarding/passcode-setup chain.
    if (widget.fromSettings) {
      Navigator.of(context).pop(true);
      return;
    }
    // Phone+passcode flow: a caller-supplied nextRoute overrides the default
    // email-onboarding chain (the user already has a passcode + verified phone,
    // so continue straight to the next step, e.g. transaction-PIN setup).
    if (widget.nextRoute != null && widget.nextRoute!.isNotEmpty) {
      Get.offAllNamed(widget.nextRoute!, arguments: widget.nextRouteArgs);
      return;
    }
    // Phone is now captured at the bottom of signup page 2 (with country
    // chip + SIM-hint prefill + length validation), so by the time we
    // reach email verification a phone always exists. Go straight to OTP
    // entry. (The standalone AddPhoneNumber screen has been removed.) If
    // the phone is somehow missing — defensive only — fall through to
    // passcode setup so the user isn't stranded.
    //
    // Phone verification is skippable (parity with email verify) — the user
    // can defer SMS OTP to Settings if their network refuses to deliver the
    // code right now. They still proceed to passcode setup.
    //
    // ROUTED THROUGH phoneVerificationStepRoute so this hop cannot show an
    // OTP screen while no provider is active: `codeSent: false` means the
    // screen requests a code ON LOAD, so an undeliverable channel turns this
    // into a dead end rather than a skippable step. It also covers the
    // missing-phone case the old `else` handled.
    // NO PHONE-OTP HOP AFTER EMAIL. Removed 2026-11-10.
    //
    // The live flow is auth_mode = phone_passcode, whose order is:
    //
    //   phone number -> PHONE OTP -> passcode -> details -> email + OTP -> PIN
    //
    // so the phone is verified at step 2, long before this screen. Hopping to
    // phone verification here asked for the SAME code a second time, on a
    // SECOND screen built for it (phone_verification_screen, route
    // /auth/phone-verification) that duplicates the signup one
    // (phone_otp_screen, /auth/phone-otp) — and it did so with no check on
    // whether the phone was already verified, because there never was one.
    //
    // Reported 2026-11-10: "Verify Your Email" at 3:22, then "Verify Your
    // Phone" at 3:24, for a number already confirmed minutes earlier.
    //
    // continueToPinSetup is what the phone flow's own email screen
    // (phone_email_verification_screen) already calls at this exact point, so
    // both email screens now converge on one next step instead of
    // disagreeing.
    await continueToPinSetup();
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
    final maskedEmail = _maskEmail(_email);

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
                  context
                      .read<AuthenticationCubit>()
                      .updateProfileAfterVerification(state.profile);

                  // Navigate to next screen on successful verification
                  _navigateToNextScreen();
                } else if (state is EmailVerificationInProgress) {
                  // AN ERROR IS NO LONGER AN `else if` BEHIND SUCCESS.
                  //
                  // These were chained, and the cubit's failure path used to
                  // emit a state that still carried the previous resend's
                  // `successMessage`. So a wrong code took the FIRST branch:
                  // the countdown restarted at 60 and the user was told
                  // nothing at all about why their code had not worked. The
                  // cubit no longer carries a stale success message, and these
                  // are independent now so neither outcome can hide the other.
                  //
                  // No "code sent" toast here. This screen's whole job is to
                  // say a code was sent to this address, and it says so in the
                  // heading — a banner repeating it covers the input the user
                  // is trying to type into. The countdown is the real feedback
                  // that a resend took effect.
                  if (state.errorMessage.isNotEmpty) {
                    // The six digits the server rejected are cleared, or the
                    // field stays full and inert — see [_codeResetKey].
                    _resetCodeInput();
                  }
                  // Handle resend error with cooldown (rate limit scenario)
                  if (state.errorMessage.isNotEmpty &&
                      state.cooldownSeconds != null &&
                      state.cooldownSeconds! > 0) {
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
                    _armResendCooldown(state.cooldownSeconds!);
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
            // ONE REBUILD PER THING THIS BUILDER ACTUALLY RENDERS.
            //
            // `updateVerificationCode` emits on EVERY keystroke, so without
            // this the whole page — pin field included — was rebuilt six times
            // on the way to a six-digit code, on top of the per-second
            // countdown tick that used to live on this State. The builder
            // reads exactly one thing from the state: whether a verify is in
            // flight. Everything else here is driven by the listener or by
            // widgets that own their own state.
            buildWhen: (prev, next) {
              bool loading(EmailVerificationState s) =>
                  s is EmailVerificationInProgress && s.isLoading;
              return loading(prev) != loading(next) ||
                  prev.runtimeType != next.runtimeType;
            },
            builder: (context, state) {
              final isVerifying =
                  state is EmailVerificationInProgress && state.isLoading;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // When launched from Settings this is a normal sub-screen,
                        // so give it a real back button. The onboarding flow (no
                        // fromSettings) stays forward-only with no back affordance.
                        if (widget.fromSettings)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: IconButton(
                                onPressed: () =>
                                    Navigator.of(context).maybePop(),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFF1F2937),
                                ),
                                tooltip: 'Back',
                              ),
                            ),
                          ),
                        SizedBox(height: widget.fromSettings ? 12.h : 60.h),

                        // Shared gradient badge icon (same widget the phone
                        // verification + phone_passcode OTP screens use).
                        const VerificationBadgeIcon(icon: Icons.email_rounded),
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
                              TextSpan(
                                text: maskedEmail.isEmpty
                                    // NEVER A BLANK LINE. This screen opened
                                    // with nothing under the heading when it
                                    // was reached from a phone+passcode login,
                                    // because the client had never seen the
                                    // address (reported 2026-11-25). The
                                    // backend now sends it with the refusal;
                                    // this is what the customer reads if it
                                    // still cannot be resolved.
                                    ? 'Enter the 6-digit code we sent to the email address on your account'
                                    : 'Enter the 6-digit code sent to\n',
                              ),
                              if (maskedEmail.isNotEmpty)
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
                          // Remounted empty + focused when a code is rejected.
                          key: ValueKey('code-$_codeResetKey'),
                          // No SMS autofill on an EMAIL code. This screen can
                          // never receive one, and leaving it on starts
                          // Android's SMS retriever — and a second listener on
                          // top of the one PinFieldAutoFill registers itself —
                          // for a channel that will never deliver.
                          enableSmsAutofill: false,
                          onCompleted: (code) {
                            context
                                .read<EmailVerificationCubit>()
                                .updateVerificationCode(code);
                            // Auto-submit when complete
                            context
                                .read<EmailVerificationCubit>()
                                .verifyEmail();
                          },
                          onChanged: (code) {
                            context
                                .read<EmailVerificationCubit>()
                                .updateVerificationCode(code);
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
                                    context
                                        .read<EmailVerificationCubit>()
                                        .verifyEmail();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4834D4),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: const Color(
                                0xFF4834D4,
                              ).withValues(alpha: 0.5),
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

                        // Resend Code Section — the SHARED control every other
                        // OTP screen in this flow already uses.
                        //
                        // It owns its countdown, so the per-second tick
                        // repaints this line instead of the whole page (the
                        // pin field above was being rebuilt sixty times while
                        // the user typed into it), and it only ever counts from
                        // an actual resend outcome rather than from a flag that
                        // lingers on the state.
                        ResendCodeButton(
                          key: ValueKey('resend-$_resendKey'),
                          initialSeconds: _resendInitialSeconds,
                          prompt: "Didn't receive the code?",
                          onResend: () => context
                              .read<EmailVerificationCubit>()
                              .resendVerificationEmail(),
                        ),

                        // NEED HELP — the resumption state that will not
                        // resume.
                        //
                        // Someone whose code never arrives has waited out a
                        // cooldown, resent, and waited again. The next thing
                        // they need is a person, and every support route in
                        // the app needs the session this screen is standing
                        // between them and. This one does not.
                        Center(
                          child: TextButton(
                            onPressed: () => LockedOutSupport.open(
                              context,
                              stuckOn: 'Verify your email',
                            ),
                            child: Text(
                              'Still stuck? Message support',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF6B7280),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        // Skip CTA — onboarding only. From Settings there's nothing
                        // to skip to, so it's hidden. Also hidden on PROD builds:
                        // email verification is mandatory in production, so the
                        // "Skip for now" escape hatch is dev/staging only.
                        // The environment check already hid this in
                        // production; the admin flag is added so ONE setting
                        // governs skippability everywhere, rather than this
                        // screen following a different rule from the signup one.
                        if (!widget.fromSettings &&
                            !currentAppEnvironment.isProduction &&
                            !FeatureFlags.isEmailVerificationRequired)
                          SizedBox(height: 12.h),
                        // The environment check already hid this in
                        // production; the admin flag is added so ONE setting
                        // governs skippability everywhere, rather than this
                        // screen following a different rule from the signup one.
                        if (!widget.fromSettings &&
                            !currentAppEnvironment.isProduction &&
                            !FeatureFlags.isEmailVerificationRequired)
                          Center(
                            child: TextButton(
                              onPressed: _skipVerification,
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF4834D4),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
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

                        // THE EXPIRY IS BACK IN THIS COPY, read from the
                        // setting rather than written as a literal.
                        //
                        // It once ended "The code expires in 15 minutes",
                        // which was a literal while the real window was an
                        // admin setting — true only until somebody touched it.
                        // Removing the sentence fixed that, and was the right
                        // call at FIFTEEN minutes: nobody racing a quarter-hour
                        // deadline needs a timer, and a second countdown beside
                        // the resend one competes for attention.
                        //
                        // The default is now ONE minute
                        // (otp_ttl.go, 2026-11-18). At that length silence is
                        // the wrong answer: a holder who switches to their mail
                        // app, waits for delivery and switches back can spend
                        // the whole window without ever being told there was
                        // one, and a code that dies unannounced reads as a
                        // broken product rather than an expired code.
                        //
                        // So the window is STATED, and sourced from
                        // `auth_otp_ttl_email_seconds` — the same key
                        // auth-service mints against — so it cannot go stale
                        // the way the old literal did. Still no second ticking
                        // timer: the sentence answers "how long have I got"
                        // without competing with the resend countdown.
                        SecureVerificationNote(
                          message:
                              'Check your inbox and spam folder for the 6-digit verification code. '
                              'It expires in ${_expiryPhrase(endpointRegistry.otpTtlEmailSeconds)}.',
                        ),
                        SizedBox(height: 32.h),
                        // A WAY OUT OF A RESUMED SIGNUP.
                        //
                        // main.dart parks an email-flow draft at `email_verify`
                        // on THIS screen, and the only back affordance here is
                        // gated on `fromSettings` — so a resumed signup had no
                        // exit at all. Renders nothing on a first run or from
                        // Settings: the widget is gated on
                        // wasResumedThisLaunch.
                        if (!widget.fromSettings)
                          const SignupSwitchAccountCta(bottomPadding: 8),

                        // THE OTHER WAY TO ARRIVE HERE TRAPPED, which the CTA
                        // above does not cover.
                        //
                        // SignupSwitchAccountCta is gated on
                        // `wasResumedThisLaunch` — a LOCAL SIGNUP DRAFT that
                        // main.dart reopened. But the commonest way onto this
                        // screen is not that at all: it is the post-login
                        // router, which sends any AUTHENTICATED holder whose
                        // email is unverified here with `Get.offAllNamed`.
                        // There is no draft in that case, so the flag is false
                        // and the widget renders nothing.
                        //
                        // Combine that with production — where "Skip for now"
                        // is deliberately hidden because email verification is
                        // mandatory — and the screen has NO exit whatsoever:
                        //
                        //   * no skip, because prod requires verification;
                        //   * a back gesture that pops an empty stack, because
                        //     offAllNamed cleared it;
                        //   * and no sign-out.
                        //
                        // Anyone who cannot reach that inbox — a typo in the
                        // address, an account they no longer control, someone
                        // else's handset — had the app rendered unusable with
                        // no route even back to login. Reported from
                        // production 2026-11-11.
                        //
                        // Signing out is NOT a bypass: it does not verify the
                        // address or advance the flow. It ends the session so a
                        // different account can be used, exactly as the KYC
                        // gate does for the same shape of trap.
                        //
                        // Shown only when genuinely trapped: nothing to pop,
                        // not from Settings, and not already covered by the
                        // draft CTA above — two "Not you?" buttons would be
                        // worse than one.
                        if (!widget.fromSettings &&
                            !SignupStateService.wasResumedThisLaunch &&
                            !Navigator.of(context).canPop())
                          const KycGateExitCta(
                            blockedBy: 'Verifying your email',
                            onLightSurface: true,
                          ),
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
