import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../transaction_pin/presentation/utils/pin_step_prefetch.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_state.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/signup_switch_account_cta.dart';
import 'package:lazervault/src/features/support/presentation/locked_out_support.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart';
part 'phone_verification_screen_widgets.dart';

class _PhoneOtpVerificationViewState extends State<_PhoneOtpVerificationView> {
  /// Bumped on a refused code so the input remounts EMPTY and focused.
  ///
  /// Without it a rejected code stays in the boxes, and a full pin field is
  /// inert: `maxLength` discards every further keypress and the decoration
  /// stops painting a caret past the sixth box. The screen then looks broken —
  /// keypad responding, no digit appearing, no cursor — which is how this was
  /// reported from the field on the email screen. phone_otp,
  /// forgot_passcode_phone and phone_email_verification all carry this key;
  /// this screen and the email one were the two that did not.
  int _codeResetKey = 0;

  /// Holds the Verify CTA in its loading state while the PIN step is resolved.
  ///
  /// PhoneVerificationVerifying ends the moment the code is accepted, so
  /// without this the spinner stops and the screen looks idle for the length
  /// of one round trip — which is precisely the gap the PIN screen's own black
  /// loading page used to fill. See pin_step_prefetch.dart.
  bool _advancing = false;

  /// In-flight latch, set SYNCHRONOUSLY when a verify is dispatched.
  ///
  /// The guards on this screen read `isVerifying`, which is derived from the
  /// BlocBuilder's state — and that state only exists after the cubit emits.
  /// Between dispatching a verify and Verifying landing, `isVerifying` is
  /// still false, so the sixth digit auto-submitting while the Verify button
  /// is live could send two verifies for one user action. The server counts
  /// each, which is how three attempts were spent two at a time and a single
  /// wrong code reported "2 attempt(s) remaining".
  bool _verifySubmitted = false;

  /// SIX HUNDRED WHOLE-PAGE REBUILDS, REPLACED BY TWO.
  ///
  /// This screen ran TWO `Timer.periodic(1s)` timers on its own State — a
  /// resend cooldown and a ten-minute expiry countdown — each calling
  /// `setState`. So the entire page, pin field included, was rebuilt once a
  /// second for the whole ten minutes the user had to type their code. That is
  /// felt on a mid-range Android: input lags, keypresses look dropped, the
  /// caret stutters. It is the "typing is difficult / the screen is messy"
  /// report.
  ///
  /// [ResendCodeButton] owns its timer and repaints one line, so the page no
  /// longer rebuilds on a tick at all.
  ///
  /// THE EXPIRY COUNTDOWN IS GONE ENTIRELY — widget, flag and all. It counted
  /// a window the customer cannot influence, directly above a resend countdown
  /// that says when they MAY do something, and the pair was read as one number
  /// so people waited on the wrong one. The code still expires; the server
  /// still refuses a dead one and says so, which is the only part that ever
  /// changed what anyone did.

  /// Seconds before a resend is allowed; same remount-to-restart pattern.
  int _resendSeconds = 0;
  int _resendKey = 0;
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
        final v = await serviceLocator<FlutterSecureStorage>().read(
          key: 'has_passcode',
        );
        if (mounted && (v == 'true' || v == '1')) {
          setState(() => _hasPasscode = true);
        }
      } catch (_) {
        /* default false — worst case shows passcode setup */
      }
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
        _startResendCooldown(_kResendCooldownSeconds);
      }
    });

    // Start expiry countdown if OTP was already sent
    if (widget.codeSent) {
      // Start with a cooldown if code was just sent
      _startResendCooldown(_kResendCooldownSeconds);
    }
  }

  /// Seconds before a resend is offered.
  ///
  /// Matches the server's own throttle on this flow, so the button cannot
  /// become tappable before the request it would make can succeed. Named
  /// rather than repeated: it was written as a bare 60 in three places, and a
  /// value that governs whether a control is usable should not be a literal
  /// somebody can change in two of them.
  ///
  /// NO LONGER A CONSTANT. 60 was compiled in here while auth-service read its
  /// own admin-tunable dial, so an operator raising the cooldown unlocked this
  /// button early and the server refused the request — a control that is
  /// offered and then rejected. Both sides now read
  /// `auth_otp_resend_cooldown_seconds`; 60 survives only as the fallback for
  /// an unreadable settings snapshot, which is what the server defaults to too.
  int get _kResendCooldownSeconds => endpointRegistry.otpResendCooldownSeconds;

  void _startResendCooldown(int seconds) {
    if (!mounted) return;
    setState(() {
      _resendSeconds = seconds;
      _resendKey++;
    });
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

  /// Requests a new code. [ResendCodeButton] owns the cooldown, so it will not
  /// call this while one is running — the local-counter guard this used to
  /// carry was the same check in a second place, and the two could disagree.
  ///
  /// Returns the next cooldown so the button can arm itself.
  Future<int?> _resendCode() async {
    // AWAITED, and the ANSWER decides the cooldown.
    //
    // This used to fire the request and immediately return a hard 60, so the
    // countdown started before the server had said anything — and kept
    // running when the answer was a refusal. A customer who had spent their
    // resend budget saw "too many codes requested. Please try again in 24
    // minutes" sitting directly above "Resend in 57s". Two numbers, both from
    // us, disagreeing about the same thing.
    final cubit = context.read<PhoneVerificationCubit>();
    await cubit.resendVerificationCode(phoneNumber: widget.phoneNumber);
    if (!mounted) return null;

    // A refusal sends no code, so there is no cooldown to run. Returning null
    // leaves the button tappable and lets the server's message stand on its
    // own — it already says how long the wait is.
    final st = cubit.state;
    final refused =
        st is PhoneVerificationFailure ||
        (st is PhoneVerificationInProgress &&
            st.errorMessage.trim().isNotEmpty);
    if (refused) return null;
    // NO LOCAL GUESS AT THE EXPIRY. The listener restarts the countdown from
    // PhoneVerificationCodeSent, which carries the real value.
    //
    // This used to call _startExpiryCountdown(600) here — the very
    // substitution the render guard below was added to stop, left behind at
    // the one call site that still made it. It painted a confident "expires
    // in 10:00" against a server TTL that is not ten minutes, for however
    // long the resend took to answer.
    //
    // THE SAME DIAL THE SERVER READS, not a second number compiled in here.
    // 60 was hardcoded while the initial cooldown used
    // `auth_otp_resend_cooldown_seconds` — so the first wait was 90s and a
    // resend said 60s, and at 60 the button unlocked against a server that
    // was still refusing. One source for both.
    return _kResendCooldownSeconds;
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
      // The args travel with the route: a passcode-setup or PIN-setup
      // destination needs its `fromLoginFlow` to know it is NOT first-run
      // signup (no skip, no local draft written).
      Get.offAllNamed(widget.nextRoute!, arguments: widget.nextRouteArgs);
      return;
    }
    // Check if there's secondary email verification needed
    if (widget.secondaryEmail != null && widget.secondaryEmail!.isNotEmpty) {
      Get.offAllNamed(
        AppRoutes.emailVerification,
        arguments: {
          'email': widget.secondaryEmail,
          'codeSent': true,
          'isRequired': false, // Secondary verification is skippable
          'secondaryPhone': null,
        },
      );
    } else if (_hasPasscode) {
      // Already has a passcode — never re-ask for it. Go to the transaction-PIN
      // setup gate (which itself no-ops if a PIN is already set), matching the
      // resume resolver's post-verify routing.
      //
      // Resolved under THIS screen's spinner rather than behind the PIN
      // screen's black loading page — see pin_step_prefetch.dart. Note this is
      // exactly the branch where a PIN most plausibly already exists, so it is
      // also the branch that benefits most: the answer arrives before the PIN
      // screen mounts, and it moves straight on instead of flashing a loader
      // and then vanishing.
      unawaited(_advanceToPinSetup());
    } else {
      // No passcode yet — genuine passcode setup.
      Get.offAllNamed(AppRoutes.passcodeSetup);
    }
  }

  /// Resolve the PIN step, holding this screen's spinner, then move on.
  Future<void> _advanceToPinSetup() async {
    if (!mounted) return;
    setState(() => _advancing = true);
    try {
      final hasPin = await prefetchHasTransactionPin();
      if (!mounted) return;
      await Get.offAllNamed(
        AppRoutes.transactionPinSetup,
        arguments: pinSetupArgs(hasPin, {'fromLoginFlow': true}),
      );
    } finally {
      if (mounted) setState(() => _advancing = false);
    }
  }

  /// Whether "Skip for now" is offered.
  ///
  /// SKIP IS AN ESCAPE HATCH, NOT A CHOICE. Operator directive: when the SMS
  /// provider is ACTIVE and this screen is showing, there is no skip — the
  /// code is on its way, and the two honest paths are to enter it or to use a
  /// different number. Offering a third was reading as an invitation to dodge
  /// verification the platform had just decided to require.
  ///
  /// It stays for the one case that genuinely needs it: the provider being
  /// unavailable while the screen is open. `phoneVerificationStepRoute` keeps
  /// the step out of the journey when SMS is off, so that is not the usual
  /// entry — but an admin can switch the provider off while a user sits here
  /// (the settings poll refreshes the flag), and the first flag snapshot can
  /// resolve after the route. Both leave a screen waiting for a code that will
  /// never arrive, and skip is the only way out of it.
  ///
  /// `isPhoneVerificationRequired` still vetoes: when the backend will reject
  /// an unverified signup there is no skip path to offer, whatever SMS is
  /// doing.
  bool get _allowSkip => !widget.fromSettings && SmsPolicy.showOtpSkip;

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
            // RELEASED ON EVERY OUTCOME, not just failure. A latch cleared on
            // one branch is the login screen's stuck-keypad bug in a different
            // file: any state the cubit emits that nobody anticipated would
            // leave this screen unable to submit for the rest of its life.
            if (state is! PhoneVerificationVerifying) _verifySubmitted = false;

            if (state is PhoneVerificationCodeSent) {
              // No "Code Sent" toast: the screen already states a code went to
              // this number, and a banner over the input is in the way of the
              // one thing the user is here to do. The expiry countdown below
              // is the feedback that a NEW code replaced the old one.
              // Restart expiry countdown when new code is sent
              if (state.expiresIn != null) {}
              // AND THE RESEND COOLDOWN, which this listener used to leave
              // alone — the reason the control rendered as a bare "Resend
              // code" link instead of "Resend in 54s".
              //
              // A cooldown belongs to the moment a code was SENT, and this
              // state is that moment for every path that reaches it: the
              // initial request from Settings, the automatic request on a
              // resumption, and a retry after a failure. Seeding it only in
              // initState covered the first paint and nothing after, so any
              // code sent later left the screen offering an immediate resend
              // — which the server refuses anyway, so the button was both
              // wrong and useless.
              _startResendCooldown(_kResendCooldownSeconds);
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
              // Clear the refused digits so the user can simply retype.
              context.read<PhoneVerificationCubit>().updateVerificationCode('');
              setState(() => _codeResetKey++);
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
            }
            // NO SNACKBAR FOR PhoneVerificationInProgress.
            //
            // THE DOUBLE TOAST. Every failing path in PhoneVerificationCubit
            // emits TWO states in a row — PhoneVerificationFailure to
            // announce it, then PhoneVerificationInProgress carrying the SAME
            // string in `errorMessage` to restore the form for another try.
            // All four sites are paired that way (requestPhoneVerification and
            // verifyPhoneNumber, each on both the failure and the
            // success:false branch), and `errorMessage` is never set without a
            // Failure immediately before it — `resendVerificationCode` sets
            // `successMessage`, not this.
            //
            // This listener handled both, so one refusal produced one toast
            // per state: the user saw the identical message twice, from the
            // top, on every error. The Failure branch above is the
            // announcement; the InProgress state is the FORM state, and its
            // errorMessage is there to be rendered beside the input, not
            // thrown again.
          },
          child: BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
            builder: (context, state) {
              final isVerifying =
                  state is PhoneVerificationVerifying || _advancing;

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
                        SizedBox(height: widget.fromSettings ? 16.h : 56.h),

                        // Shared gradient badge icon (same as the phone_passcode
                        // OTP screen + email verification).
                        const VerificationBadgeIcon(
                          icon: Icons.phone_android_rounded,
                        ),
                        SizedBox(height: 24.h),

                        // Title
                        Text(
                          'Verify Your Phone',
                          style: GoogleFonts.inter(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        SizedBox(height: 8.h),

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
                        SizedBox(height: 32.h),

                        // OTP Input
                        VerificationCodeInput(
                          key: ValueKey('code-$_codeResetKey'),
                          // THE SIXTH DIGIT SUBMITS, like every other OTP
                          // screen in the app and like every OTP screen
                          // anywhere else.
                          //
                          // This one stored the code and waited for a tap. A
                          // customer who has just typed six digits has already
                          // said what they came to say; asking them to confirm
                          // it is a step with nothing in it — and on this
                          // screen in particular, reached on a RESUMPTION with
                          // the keyboard covering the lower half, the button
                          // they are being asked to find is often not even on
                          // screen.
                          //
                          // Guarded on the same two states the button is:
                          // nothing is submitted while a verify is already in
                          // flight, or after the code has expired. Without the
                          // first guard, SMS autofill landing a code that the
                          // user is also typing fires two verifies and the
                          // second spends an attempt against a code the first
                          // has already consumed.
                          onCompleted: (code) {
                            final cubit = context
                                .read<PhoneVerificationCubit>();
                            cubit.updateVerificationCode(code);
                            // Both guards: the latch closes the window the
                            // bloc-state one leaves open.
                            if (isVerifying || _verifySubmitted) return;
                            _verifySubmitted = true;
                            cubit.verifyPhoneNumber(
                              phoneNumber: widget.phoneNumber,
                              verificationCode: code,
                            );
                          },
                          onChanged: (code) {
                            context
                                .read<PhoneVerificationCubit>()
                                .updateVerificationCode(code);
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Verify Button
                        SizedBox(
                          width: double.infinity,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: isVerifying
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
                                      // Same latch as the auto-submit path —
                                      // the two race each other, which is the
                                      // whole reason it exists.
                                      if (_verifySubmitted) return;
                                      _verifySubmitted = true;
                                      context
                                          .read<PhoneVerificationCubit>()
                                          .verifyPhoneNumber(
                                            phoneNumber: widget.phoneNumber,
                                            verificationCode:
                                                state.verificationCode,
                                          );
                                    }
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
                        // The shared control, like every other OTP screen:
                        // it owns its countdown, so the tick repaints one line
                        // instead of the page.
                        ResendCodeButton(
                          // SMS screen: DND can block the code once it is
                          // actually delivered over a downgraded route.
                          showSmsDndHelp: true,
                          key: ValueKey('resend-$_resendKey'),
                          initialSeconds: _resendSeconds,
                          prompt: "Didn't receive the code?",
                          onResend: _resendCode,
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
                              stuckOn: 'Verify your phone',
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

                        // Skip CTA — onboarding only; hidden when from
                        // Settings, and hidden when the admin has made phone
                        // verification mandatory. One setting governs
                        // skippability everywhere the screen appears (signup,
                        // the post-login gate), mirroring the email screen.
                        if (_allowSkip) SizedBox(height: 16.h),
                        if (_allowSkip)
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

                        SizedBox(height: 32.h),

                        // Shared "Secure Verification" note.
                        const SecureVerificationNote(
                          message:
                              'We sent a 6-digit code via SMS to verify your phone number.',
                        ),
                        SizedBox(height: 16.h),
                        // Only renders on a RESUMED signup — see
                        // SignupSwitchAccountCta. Invisible on a first run, and
                        // on the Settings entry (fromSettings), where there is
                        // no signup to leave.
                        if (!widget.fromSettings)
                          const SignupSwitchAccountCta(bottomPadding: 8),

                        // The SAME trap the email screen has, reached the same
                        // way: the post-login router sends an authenticated
                        // holder here with `Get.offAllNamed`, which is not a
                        // signup-draft resume — so the CTA above renders
                        // nothing — and the stack it would pop back to is
                        // gone.
                        //
                        // Here the skip is the usual escape, but it is not
                        // always there: `_allowSkip` is false whenever
                        // SmsPolicy says the step may not be skipped. With no
                        // skip, no stack and no draft, there is no exit at all.
                        //
                        // Shown only when genuinely trapped, so a holder who
                        // can skip or go back never sees a sign-out button
                        // inviting them to lose their session.
                        if (!widget.fromSettings &&
                            !_allowSkip &&
                            !SignupStateService.wasResumedThisLaunch &&
                            !Navigator.of(context).canPop())
                          const KycGateExitCta(
                            blockedBy: 'Verifying your phone number',
                            onLightSurface: true,
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
