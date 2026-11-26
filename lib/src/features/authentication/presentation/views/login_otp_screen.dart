import 'dart:async';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';

import 'package:flutter/material.dart';
import 'package:lazervault/core/shared_widgets/otp_field_behaviour.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/server_status_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/post_login_navigator.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/widgets/sms_dnd_notice.dart';

/// Adaptive step-up login OTP screen. Shown when ANY login flow (email/password,
/// email/passcode, or phone+passcode incl. switch-user) reports that the risk
/// engine requires a one-time code (new device / location). Mode-agnostic: it
/// owns a fresh [AuthenticationCubit] so verifying never re-fires the originating
/// login screen's listener, and on success it loads the profile + routes to the
/// dashboard itself (a step-up user is an existing user who already has a
/// passcode/PIN, so the dashboard is the correct destination).
///
/// Navigation contract:
///  * launched via `Get.to` (push) over the originating login screen;
///  * this is a step-up SECURITY gate: no back button (showBack:false) and the
///    Android back gesture is blocked (PopScope canPop:false), so it cannot be
///    swiped away without a decision;
///  * the ONLY exit is the labelled "Use a different account",
///    which `Get.offAllNamed(freshLoginEntry)` to a clean login. They replace the
///    stack rather than pop precisely because the PopScope vetoes pops;
///  * SUCCESS = `Get.offAllNamed(dashboard)` — clears login + OTP off the stack.
/// Leaving is not a bypass: the device stays 'pending' server-side until an OTP
/// is verified, so the next login re-issues the challenge.
class LoginOtpScreen extends StatelessWidget {
  final String stepUpToken;
  final String method; // "email" | "sms"
  final String destination; // masked

  /// Code lifetime in seconds, from the login response. 0 = server did not
  /// say, in which case the screen uses its fallback.
  final int expiresInSeconds;

  /// Whether this identity has signed in on THIS INSTALL before. Wording only
  /// — it never decides whether the challenge appears. Defaults to false so an
  /// unconverted caller keeps the cautious copy.
  final bool knownDevice;

  /// THE OTHER CHANNEL, when the server says one is usable.
  ///
  /// Empty means offer no switch — the account has no second contact, or that
  /// channel cannot deliver right now. The client cannot work either out, so
  /// it is TOLD: an offered switch that then fails is worse than one never
  /// offered.
  final String altMethod;
  final String altDestination;

  const LoginOtpScreen({
    super.key,
    required this.stepUpToken,
    required this.method,
    required this.destination,
    this.expiresInSeconds = 0,
    this.knownDevice = false,
    this.altMethod = '',
    this.altDestination = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>.value(
      value: serviceLocator<AuthenticationCubit>(),
      child: _LoginOtpView(
        stepUpToken: stepUpToken,
        method: method,
        altMethod: altMethod,
        altDestination: altDestination,
        destination: destination,
        expiresInSeconds: expiresInSeconds,
        knownDevice: knownDevice,
      ),
    );
  }
}

class _LoginOtpView extends StatefulWidget {
  final String stepUpToken;
  final String method;
  final String destination;
  final int expiresInSeconds;
  final bool knownDevice;
  final String altMethod;
  final String altDestination;

  const _LoginOtpView({
    required this.stepUpToken,
    required this.method,
    required this.destination,
    required this.expiresInSeconds,
    required this.knownDevice,
    this.altMethod = '',
    this.altDestination = '',
  });

  @override
  State<_LoginOtpView> createState() => _LoginOtpViewState();
}

class _LoginOtpViewState extends State<_LoginOtpView>
    with WidgetsBindingObserver {
  // THE LIVE CHANNEL, which the widget params only SEED.
  //
  // A resend can move the code to the other channel, after which
  // widget.method/widget.destination describe where the FIRST code went — so
  // every piece of copy that names the channel reads these instead. Getting
  // that wrong points the user at the wrong inbox, which is the exact failure
  // the switch exists to prevent.
  late String _method = widget.method;
  late String _destination = widget.destination;
  late String _altMethod = widget.altMethod;
  late String _altDestination = widget.altDestination;

  /// True while a channel switch is in flight, so the affordance can show its
  /// own progress without the main Resend button appearing to be the one
  /// working.
  bool _switching = false;

  // This screen sits INSIDE the phone-login flow — it is the step immediately
  // after "Log in" — so it wears that flow's chrome (PhoneFlowScaffold: curved
  // background, back button, title/subtitle, pill CTA) rather than the dark
  // one-off palette it used to carry. Colours below mirror PhoneFlowScaffold's
  // light body so the two screens read as one journey.
  static const _brandPurple = Color(0xFF4834D4);
  static const _ink = Color(0xFF262626);
  static const _textSecondary = Color(0xFF6B7280);
  static const _field = Color(0xFFF3F4F6); // filled input on the light body
  static const _divider = Color(0xFFE5E7EB);
  static const _errorColor = Color(0xFFDC2626); // AA on a light background

  // Fallback only. The real lifetime comes from the login response
  // (LoginResponse.step_up_expires_in), which auth-service fills from the
  // admin-tunable auth_login_otp_ttl_seconds. The screen used to hardcode its
  // own 10 minutes and "mirror" the server by hand, so retuning the server
  // silently left every installed app counting down from the old number.
  /// There is DELIBERATELY no fallback lifetime any more.
  ///
  /// This used to be 90 seconds, chosen to match the server at the time. The
  /// server's TTL is admin-tunable and has since moved to five minutes, and
  /// nothing made the two move together — so an app that never heard a TTL
  /// confidently counted down from a number that was wrong by more than 3x.
  /// A second hardcoded lifetime is exactly the drift the server field exists
  /// to remove, so re-adding one here would recreate the bug.
  ///
  /// When the server does not state a lifetime the app now states none: it
  /// shows no countdown rather than a guess, and never declares a code expired
  /// on the strength of one. See [_lifetimeKnown].

  static const int _boxes = 6;
  final List<TextEditingController> _controllers =
      List.generate(_boxes, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_boxes, (_) => FocusNode());

  Timer? _ticker;
  int _remaining = 0;
  bool _submitting = false;

  /// Re-arms the keypad if no answer ever arrives.
  ///
  /// THE BUG THIS ENDS. `_submitting` disables every box
  /// (`enabled: !_expired && !_submitting`) and is cleared ONLY from the state
  /// listener, which handles exactly three states: AuthenticationSuccess,
  /// AuthenticationError and AuthenticationFailure. Anything else — a state
  /// the cubit adds later, an exception swallowed upstream, or a request that
  /// simply never completes on a bad link — leaves the flag true and the
  /// screen permanently unable to accept a digit. Reported repeatedly as "the
  /// OTP screen won't let me type".
  ///
  /// Enumerating states is what failed, so this does not enumerate them. It
  /// bounds the wait instead: whatever happens or fails to happen, the keypad
  /// comes back.
  ///
  /// 25 seconds, sized like ServerStatusService's probe for the same reason —
  /// the userbase is on Nigerian mobile data where a round trip through
  /// Cloudflare to a tunnelled origin can genuinely take most of ten seconds,
  /// and re-arming under a real in-flight verify would invite a double submit.
  Timer? _submitWatchdog;
  static const Duration _submitWatchdogTimeout = Duration(seconds: 25);

  /// Clears the in-flight flag and stops the watchdog. Every path that ends a
  /// submit goes through here so the two can never disagree.
  void _endSubmit() {
    _submitWatchdog?.cancel();
    _submitWatchdog = null;
    _submitting = false;
  }

  String? _errorText;

  /// Kept so dispose can remove them — a focus listener outliving its node is
  /// a leak per visit to this screen.
  final List<VoidCallback> _selectAllListeners = <VoidCallback>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // FOCUSING A BOX SELECTS IT, so the next input REPLACES rather than
    // appends. Required now that every box accepts a full-length paste: a box
    // holding "3" that the customer taps and types "9" into would otherwise
    // report "39", which the paste path reads as a pasted code and spreads
    // across the boxes — wiping the rest of what they had entered. See
    // selectAllOnFocus.
    for (var i = 0; i < _boxes; i++) {
      _selectAllListeners
          .add(selectAllOnFocus(_controllers[i], _focusNodes[i]));
    }
    _startTicker();
  }

  /// Snap the countdown the moment the app comes back.
  ///
  /// This screen's whole purpose is to be left — the code arrives in email or
  /// SMS, so the user backgrounds the app to go and read it. That is the
  /// reported journey ("once I leave the app to check my email the code
  /// expires"), and it is the one moment the timer must not lie.
  ///
  /// The deadline design already keeps it HONEST: every tick re-reads the
  /// clock, so a suspended timer can never run the display slow. What it
  /// cannot do is update the instant the user returns — a platform that
  /// froze the timer leaves up to a full second of stale digits on screen
  /// before the next tick lands, and on a code with seconds left that is the
  /// difference between typing it and being told it died. Re-reading on
  /// resume costs nothing and removes the gap.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || !mounted) return;
    final left = _secondsLeft();
    if (left == _remaining) return;
    setState(() => _remaining = left);
    if (_lifetimeKnown && left <= 0) {
      // Expired while we were away. Enter the expired state cleanly rather
      // than leaving dead digits above a "get a new code" prompt.
      _ticker?.cancel();
      _clearBoxes(refocus: false);
      setState(() => _errorText = null);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    _submitWatchdog?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (var i = 0; i < _focusNodes.length; i++) {
      if (i < _selectAllListeners.length) {
        _focusNodes[i].removeListener(_selectAllListeners[i]);
      }
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  /// When the code actually dies. Everything reads from this.
  ///
  /// The countdown used to DECREMENT once per second, which only tells the
  /// truth while the app is foregrounded and the timer is firing. Backgrounding
  /// the app, or any stall, left the display ahead of reality and the user
  /// entering a code the screen still showed as live. At ninety seconds that
  /// gap is most of the window, so the deadline is fixed once and the tick just
  /// re-reads the clock.
  DateTime? _deadline;

  /// Whether the SERVER told us how long this code lives. Everything that
  /// claims a deadline is gated on it.
  bool _lifetimeKnown = false;

  void _startTicker() => _restartTicker(widget.expiresInSeconds);

  /// No server TTL: run the resend cooldown only.
  ///
  /// The user still needs a way out if the code never arrives, but the screen
  /// shows no countdown and never expires the code locally, because it
  /// genuinely does not know when the code dies.
  void _startCooldownOnlyTicker() {
    _lifetimeKnown = false;
    _deadline = null;
    _remaining = 0;
    _ticker?.cancel();
    // Not `const`: the cooldown is read from settings now, so the Duration is
    // built at runtime from whatever the operator has configured.
    _resendDeadline =
        DateTime.now().add(Duration(seconds: _resendCooldownSeconds));
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_canResend) {
        t.cancel();
        // One more cooldown waited out. The DND notice compares this against
        // the admin threshold (sms_dnd_help_after_attempts) rather than this
        // screen deciding when troubleshooting is warranted.
        setState(() => _cooldownsElapsed += 1);
        return;
      }
      setState(() {});
    });
  }

  /// When a resend becomes possible. SEPARATE from the expiry deadline: the
  /// server's cooldown is shorter than the code's life, so a user who never
  /// received the SMS had to sit through the WHOLE window before the button
  /// appeared. The countdown is not the same question as "may I ask again".
  DateTime? _resendDeadline;

  /// Resend cooldowns this screen has fully waited out.
  int _cooldownsElapsed = 0;

  /// Server-enforced anyway — this only decides when the affordance is shown,
  /// so a stale value can never let a request through early.
  /// Read from settings rather than compiled in, for the same reason the TTL
  /// is: a client counting 60 against a server enforcing 90 shows an unlocked
  /// button the next request is refused by.
  int get _resendCooldownSeconds => endpointRegistry.otpResendCooldownSeconds;

  /// Set once the SERVER has successfully sent this customer an SMS on this
  /// challenge — i.e. a channel switch to SMS that came back accepted.
  ///
  /// SMS IS NO LONGER A SINGLE PLATFORM-WIDE FACT. While the provider is being
  /// investigated the master switch is off for everyone and a short operator
  /// whitelist keeps it for named testers, resolved SERVER-SIDE from the
  /// account's own email and phone. The app deliberately does not hold that
  /// list — it would have to be published to every handset on an
  /// unauthenticated poll to be readable here — so `SmsPolicy.available` can
  /// say "no SMS" while this particular user is being texted perfectly well.
  ///
  /// A send the server accepted is the one piece of per-user evidence the
  /// client can honestly act on, so it is recorded rather than inferred.
  bool _smsConfirmedForThisUser = false;

  /// Whether a code can actually reach this customer on this challenge's
  /// channel. See the skip affordance below for why it decides visibility.
  ///
  /// The per-user proof wins over the global flag, and only in the permissive
  /// direction: it can reveal that SMS works for someone the flag says it does
  /// not, never hide a dead end from someone it would have warned.
  bool get _codeCanBeDelivered =>
      _method != 'sms' || _smsConfirmedForThisUser || SmsPolicy.available;

  /// Seconds until a resend is offered, or 0 when it already is.
  ///
  /// THE NUMBER, NOT JUST "SHORTLY". This screen had the deadline all along
  /// and said only "Resend shortly" — which tells someone to wait without
  /// saying how long, so they tap, nothing happens, and they tap again. The
  /// other OTP screens show the seconds through ResendCodeButton; this one
  /// rolls its own row and was the odd one out.
  ///
  /// This is the countdown that stayed when the expiry one was removed: it
  /// counts down to something the customer may DO, which is the whole
  /// difference between the two.
  int get _resendSecondsLeft {
    final d = _resendDeadline;
    if (d == null) return 0;
    final left = d.difference(DateTime.now()).inSeconds;
    return left > 0 ? left : 0;
  }

  bool get _canResend =>
      !_resendChannelClosed &&
      (_resendDeadline == null || !DateTime.now().isBefore(_resendDeadline!));

  void _restartTicker(int seconds) {
    // A NON-POSITIVE LIFETIME IS "THE SERVER DID NOT SAY", NOT "ZERO SECONDS".
    //
    // Both entry points can hand this a 0. The first build does when the login
    // response omitted step_up_expires_in, and RESEND does whenever the resend
    // response omits it — resendLoginOtp returns the server's number
    // unexamined. Taking 0 literally set the deadline to NOW, so a code the
    // server had just issued was announced as "Code expired." the instant it
    // arrived, and the keypad locked. That is the same false claim this
    // screen's whole TTL rework exists to remove, reached from the one path
    // that does not read widget.expiresInSeconds.
    if (seconds <= 0) {
      _startCooldownOnlyTicker();
      return;
    }
    _lifetimeKnown = true;
    _ticker?.cancel();
    _deadline = DateTime.now().add(Duration(seconds: seconds));
    // Never past the expiry: if the code dies first, resend is already offered
    // by the expired branch and a later cooldown would contradict it.
    final cooldown =
        seconds < _resendCooldownSeconds ? seconds : _resendCooldownSeconds;
    _resendDeadline = DateTime.now().add(Duration(seconds: cooldown));
    _remaining = seconds;
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      final left = _secondsLeft();
      if (left <= 0) {
        t.cancel();
        // Transition INTO the expired state cleanly: dead digits and stale
        // errors would otherwise sit on top of the "get a new code" prompt.
        _clearBoxes(refocus: false);
        setState(() {
          _remaining = 0;
          _errorText = null;
        });
        return;
      }
      setState(() => _remaining = left);
    });
  }

  int _secondsLeft() {
    final d = _deadline;
    if (d == null) return 0;
    final left = d.difference(DateTime.now()).inSeconds;
    return left > 0 ? left : 0;
  }

  /// Expired only when the SERVER gave us a deadline and it has passed. With
  /// no server TTL this stays false: locking the keypad and announcing "Code
  /// expired" off a guess would strand someone holding a perfectly valid code.
  bool get _expired => _lifetimeKnown && _remaining <= 0;

  String get _code => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (_errorText != null) setState(() => _errorText = null);

    // Paste / autofill of the whole code into one box: distribute across boxes.
    if (value.length > 1) {
      // Shared with every other multi-box code screen, and it sets each
      // controller's SELECTION explicitly — assigning `.text` alone leaves
      // selection at the invalid default (-1), which on Android is a caret the
      // input connection cannot place, so the next keypress has nowhere to go.
      // That is the "field went dead" failure this screen has already had.
      final digits = applyOtpPaste(_controllers, value);
      final next = digits.length >= _boxes ? _boxes - 1 : digits.length;
      _focusNodes[next].requestFocus();
      // Deferred for the same reason as the last-digit path above: this runs
      // inside onChanged, having just rewritten every controller, and
      // submitting synchronously from there races the edit it is reading.
      if (digits.length >= _boxes) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _code.length == _boxes) _submit();
        });
      }
      return;
    }

    if (value.isNotEmpty && index < _boxes - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isNotEmpty && index == _boxes - 1) {
      // THE SIXTH DIGIT WAS BEING EATEN, AND unfocus() WAS EATING IT.
      //
      // This called FocusScope.unfocus() SYNCHRONOUSLY, from inside onChanged
      // — i.e. while the text input client is still mid-update for the very
      // keystroke that triggered it. Closing the IME connection there makes
      // the platform revert the in-flight editing value on Android, so the
      // last box ended up empty: the digit appeared and vanished, `_code` was
      // five characters, the `== _boxes` guard below never passed, and the
      // screen sat there having visibly accepted a keypress it then discarded.
      // Reported as "it's not inserting the last value before validating".
      //
      // Deferring to after the frame lets the controller commit first. The
      // unfocus still happens — dropping the keyboard is what makes the
      // "Verifying…" state readable — just not during the edit that caused it.
      //
      // The 120ms settle is kept on top: it is what stops the submit racing
      // the final repaint, so the user sees their sixth digit land before the
      // screen changes under them.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 120), () {
          if (mounted && _code.length == _boxes) _submit();
        });
      });
    }
  }

  void _onBackspace(int index) {
    // Empty box + backspace → hop to the previous box and clear it, so the user
    // can correct digits fluidly.
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  void _clearBoxes({bool refocus = true}) {
    for (final c in _controllers) {
      c.clear();
    }
    if (refocus) _focusNodes[0].requestFocus();
  }

  void _submit() {
    if (_submitting) return;
    final code = _code;
    if (code.length != _boxes) {
      setState(() => _errorText = 'Enter the $_boxes-digit code');
      return;
    }
    if (_expired) {
      // NOT terminal: the same session can mint a fresh code. The primary
      // button has already flipped to "Send me a new code".
      setState(() {
        _errorText = 'That code has expired, tap "Send me a new code" below.';
      });
      return;
    }
    setState(() {
      _submitting = true;
      _errorText = null;
    });
    _submitWatchdog?.cancel();
    _submitWatchdog = Timer(_submitWatchdogTimeout, () {
      if (!mounted || !_submitting) return;
      setState(() {
        _endSubmit();
        // Says what happened and what to do. "Verifying…" forever says
        // neither, and the user cannot even retype the code to try again.
        _errorText =
            'That took too long. Check your connection and tap Verify again.';
      });
      // Put the caret back where they left it, so retrying is one tap.
      final firstEmpty = _controllers.indexWhere((c) => c.text.isEmpty);
      _focusNodes[firstEmpty < 0 ? _boxes - 1 : firstEmpty].requestFocus();
    });
    FocusScope.of(context).unfocus();
    context.read<AuthenticationCubit>().verifyLoginOtp(
          stepUpToken: widget.stepUpToken,
          code: code,
        );
  }

  /// A step-up code can only be re-minted by re-authenticating (the risk engine
  /// issues a fresh code per login attempt — there is no standalone resend RPC,
  /// which also keeps a stolen step-up token from being replayed for new codes).
  /// So "send a new code" pops back to the still-mounted login screen where the
  /// user re-enters their passcode/password and a new challenge is issued.
  bool _resending = false;

  /// Requests a fresh code for the SAME step-up session.
  ///
  /// The server replaces the code in place, so the step-up token this screen
  /// already holds keeps working and the countdown simply restarts from the
  /// new lifetime it returns. Refusals (cooldown, resend cap) arrive as
  /// AuthenticationError with a stable code and are handled there.
  // "Skip for now" was removed entirely in 2026-09 on the reasoning that a
  // step-up gate offers exactly two honest paths — verify, or leave via "Use a
  // different account" — and a third soft-exit read as an invitation to dodge
  // verification.
  //
  // It is back, but ONLY when an admin has explicitly turned email verification
  // off, and it is hidden by default. Two things make that safe, and they are
  // the same two that were true when it was removed:
  //   * leaving is not a bypass. The backend keeps the device 'pending' until
  //     an OTP is verified, so the very next login re-issues this challenge.
  //   * the default is REQUIRED. A fresh install, a cleared cache or an
  //     unreachable backend all render no skip, so being wrong fails towards
  //     asking for the code.
  // The operator who switches it off is making a deliberate, server-side,
  // reversible choice — which is what "admin-tunable" has to mean to be worth
  // anything.
  Widget _buildSkipButton() => TextButton(
        onPressed:
            (_submitting || _resending) ? null : _onSkipDeviceVerification,
        child: Text(
          'Skip for now',
          style: TextStyle(
              color: _textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
        ),
      );

  void _onSkipDeviceVerification() {
    // WAS: Get.offAllNamed(freshLoginEntry) — which sent the user BACK to the
    // login screen they had just come through. Not a workaround: there was no
    // server path to complete a step-up without a code, because the step-up
    // token is the OTP row id, not a session. The button could not work no
    // matter what this screen did.
    //
    // SkipLoginOtp now exchanges that token for a real session, and emits the
    // same AuthenticationSuccess a verify does — so the listener above lands
    // the user on the dashboard through one code path, not two.
    //
    // The ticker keeps running on purpose. If the server refuses (the operator
    // turned skipping off between render and tap) the listener shows the error
    // and the user is still on a live challenge with a countdown that means
    // something. Cancelling here would leave a working code looking expired.
    context
        .read<AuthenticationCubit>()
        .skipLoginOtp(stepUpToken: widget.stepUpToken);
  }

  /// Asks for a fresh code, optionally ON THE OTHER CHANNEL.
  ///
  /// [method] is "" for "same channel" — the plain Resend. Anything else is a
  /// switch, and the server may refuse it (no second contact, or that channel
  /// cannot deliver): the refusal arrives through the cubit's error state and
  /// leaves the EXISTING code untouched, because the server checks before it
  /// replaces anything.
  Future<void> _requestNewCode({String method = ''}) async {
    if (_resending || _switching) return;
    final switching = method.isNotEmpty && method != _method;
    setState(() {
      if (switching) {
        _switching = true;
      } else {
        _resending = true;
      }
      _errorText = null;
    });

    final resend = await context
        .read<AuthenticationCubit>()
        .resendLoginOtp(stepUpToken: widget.stepUpToken, method: method);

    if (!mounted) return;
    if (resend == null) {
      // The cubit emitted the reason; the listener has already shown it.
      // Nothing about the live code changed, so the countdown keeps running.
      setState(() {
        _resending = false;
        _switching = false;
      });
      return;
    }
    final seconds = resend.expiresInSeconds;

    setState(() {
      _resending = false;
      _switching = false;
      _terminal = false;
      _errorText = null;
      // THE SERVER'S ANSWER, not what we asked for. A refused switch comes
      // back on the original channel, and the copy below must say so rather
      // than sending the user to an inbox nothing arrived in.
      _method = resend.method.isNotEmpty ? resend.method : _method;
      _destination =
          resend.destination.isNotEmpty ? resend.destination : _destination;
      // The server just sent an SMS to THIS account, so SMS demonstrably
      // reaches them whatever the platform-wide flag says. Without this the
      // skip hatch appears immediately after a successful switch to phone —
      // offering to abandon a step that is working.
      if (_method == 'sms') _smsConfirmedForThisUser = true;
      // Recomputed against the channel actually used, so after a switch the
      // affordance offers the way back.
      _altMethod = resend.altMethod;
      _altDestination = resend.altDestination;
    });
    _clearBoxes();
    // Restart from the lifetime the server just told us, not the original one:
    // an admin may have retuned it between the first send and this resend.
    _restartTicker(seconds);
    _focusNodes.first.requestFocus();

    Get.snackbar(
      'New code sent',
      'We sent a fresh code to your ${_method == 'sms' ? 'phone' : 'email'}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _ink,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  /// A connectivity/edge failure is NOT a wrong code — surface it as a connection
  /// problem (and poke the health gate) rather than raw transport text. Wrong /
  /// expired-code messages pass through as an inline error under the boxes.
  /// Set when the code can never work again (expired, used, attempts spent, or
  /// the step-up session itself died). The only way forward is a fresh sign-in,
  /// so the screen stops pretending the boxes are useful.
  bool _terminal = false;

  /// The delivery channel itself cannot send another code, while the code
  /// ALREADY in the user's hands remains valid.
  ///
  /// Deliberately NOT [_terminal]. Terminal means "the boxes are useless, sign
  /// in again"; this means the opposite — typing the code they already have is
  /// the one thing that still works, and only the resend affordance is dead.
  /// The server refuses the resend BEFORE replacing the stored code precisely
  /// so that stays true, so blanking the session here would throw away a
  /// working credential.
  bool _resendChannelClosed = false;

  void _handleFailure(String message, {String code = ''}) {
    final m = message.toLowerCase();
    final looksNetwork = isNetworkError(message) ||
        m.contains('network error') ||
        m.contains('check your connection');
    if (looksNetwork) {
      ServerHealthNotifier.instance.pokeRecheck();
      setState(() {
        _endSubmit();
        _errorText =
            "Connection problem, couldn't reach our servers. Try again.";
      });
      return;
    }
    // Branch on the server's stable code, never on its prose.
    switch (code) {
      case 'OTP_EXPIRED':
        // The CODE died but the SESSION is alive — flip straight into the
        // expired state so the resend affordance is the next tap. Passing the
        // server prose through here used to read as "session expired".
        _ticker?.cancel();
        _clearBoxes(refocus: false);
        setState(() {
          _endSubmit();
          _remaining = 0;
          _errorText = 'That code has expired, tap "Send me a new code" below.';
        });
        return;
      case 'OTP_ATTEMPTS_EXCEEDED':
        // Attempts are per-code; a fresh code gets a fresh budget. Same
        // resolution as an expired code: get a new one.
        _ticker?.cancel();
        _clearBoxes(refocus: false);
        setState(() {
          _endSubmit();
          _remaining = 0;
          _errorText =
              'Too many wrong tries for that code, tap "Send me a new code" below.';
        });
        return;
      case 'RESEND_TOO_SOON':
        // The current code is still the live one; just relay the wait.
        setState(() {
          _endSubmit();
          _errorText = message.isNotEmpty
              ? message
              : 'Please wait a moment before asking for another code.';
        });
        return;
      case 'STEP_UP_CHANNEL_UNAVAILABLE':
        // The provider cannot deliver another SMS. Without this case the code
        // fell through to the generic branch below and told the user "That
        // code is incorrect" — which is both false and actively misleading,
        // since the code they hold is fine and the thing that failed was the
        // resend.
        //
        // So: relay the server's reason, hide the resend affordance, and leave
        // the boxes live.
        _ticker?.cancel();
        setState(() {
          _endSubmit();
          _resendChannelClosed = true;
          _errorText = message.isNotEmpty
              ? message
              : 'We cannot send another code to your phone right now. '
                  'If you already have a code, enter it below.';
        });
        return;
      case 'OTP_USED':
      case 'STEP_UP_SESSION_EXPIRED':
      case 'RESEND_LIMIT_REACHED':
      case 'STEP_UP_UNAVAILABLE':
        _ticker?.cancel();
        setState(() {
          _endSubmit();
          _terminal = true;
          _remaining = 0;
          _errorText = message.isNotEmpty
              ? message
              : 'That code can no longer be used. Please sign in again.';
        });
        _clearBoxes();
        return;
    }

    setState(() {
      _endSubmit();
      _errorText = message.isNotEmpty ? message : 'That code is incorrect.';
    });
    _clearBoxes();
  }

  @override
  Widget build(BuildContext context) {
    final channel = _method == 'sms' ? 'SMS' : 'email';
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          _ticker?.cancel();
          try {
            context.read<ProfileCubit>().getUserProfile();
          } catch (_) {/* dashboard loads it */}
          // Was an unconditional jump to the dashboard. Passing a step-up OTP
          // is still a login, so it owes the same gates as any other: an
          // unverified email, an unfinished signup, a never-set transaction
          // PIN and now identity verification were all walked past here.
          goAfterLogin(state.profile.user);
        } else if (state is AuthenticationError) {
          _handleFailure(state.message, code: state.code);
        } else if (state is AuthenticationFailure) {
          _handleFailure(state.message);
        }
      },
      child: PhoneFlowScaffold(
        title: 'Verify it\'s you',
        subtitle: 'We sent a 6-digit code to your $channel '
            '($_destination). Enter it to continue.',
        showHeadingLogo: false,
        // This is a step-up SECURITY gate, so it has no back button and the
        // Android system-back gesture is inert (onBack is a no-op; the scaffold
        // wraps a non-null onBack in PopScope(canPop:false)). A silent back would
        // let the user slip past device verification. The deliberate way out is
        // the labeled "Use a different account" (and admin-tunable "Skip for
        // now") below — and even those no longer bypass anything: the backend
        // keeps the device 'pending' until the OTP is verified, so any later
        // login re-issues the challenge.
        showBack: false,
        onBack: () {},
        // A disabled "Code expired" button was a dead end: the one thing the
        // user needs at that moment is a way to get a new code, and the button
        // they are already looking at became unusable. With a ninety second
        // window this is a routine outcome, not an edge case.
        primaryLabel: _resending
            ? 'Sending a new code…'
            : ((_expired || _terminal)
                ? 'Send me a new code'
                : 'Verify & continue'),
        onPrimary: (_submitting || _resending)
            ? null
            : ((_expired || _terminal) ? _requestNewCode : _submit),
        isLoading: _submitting,
        secondaryAction: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                // Get.offAllNamed, NOT maybePop — the PopScope(canPop:false) on
                // this step-up gate vetoes pops (that is why this button did
                // nothing), so leave by replacing the stack with a fresh login.
                onPressed: () {
                  _ticker?.cancel();
                  Get.offAllNamed(AppRoutes.freshLoginEntry);
                },
                child: Text(
                  'Use a different account',
                  style: TextStyle(
                      color: _textSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Shown only when an operator has enabled the escape hatch.
              // Defaults to hidden, so a config-read failure renders no skip
              // and being wrong fails towards asking for the code.
              //
              // EndpointRegistry.otpSkipButtonVisible, NOT
              // FeatureFlags.isEmailVerificationRequired.
              //
              // The button was gated on the ONBOARDING email-verification
              // setting, which is a different control for a different
              // question. auth_otp_skip_button_visible exists for exactly this
              // and is the same key the SERVER checks before honouring a skip
              // — so the control and the capability can no longer disagree,
              // and a visible button is always one the backend will accept.
              // Rebuilt on the registry's changeTick, because on a NEW DEVICE
              // the snapshot is not there yet when this screen first paints.
              //
              // ensureReady() seeds the cache from SharedPreferences and then
              // refreshes in the background. A fresh install has no prefs, so
              // the first read falls to the 'false' default and the button is
              // hidden — on precisely the login that raises a device
              // challenge, which is the only time it is offered. Listening
              // means it appears the moment the snapshot lands instead of
              // staying hidden for that whole session.
              //
              // AND ONLY WHEN THE CODE CANNOT ACTUALLY ARRIVE.
              //
              // Skip is an ESCAPE HATCH, not a preference: it exists because
              // a code the customer can never receive is a dead end. Once a
              // channel is genuinely delivering, offering to skip the step
              // undermines the step — the honest instruction is "enter the
              // code", and there is a resend beside it for a code that is
              // slow.
              //
              // Deliverability, not the SMS switch alone: this challenge can
              // be issued over EMAIL (adaptive_otp.go defaults to it and only
              // falls to SMS for a phone-only account), and email is always
              // deliverable. So the hatch appears only for an SMS challenge
              // with no active provider — which is also the only combination
              // that can strand someone.
              ValueListenableBuilder<int>(
                valueListenable: EndpointRegistry.instance.changeTick,
                builder: (context, _, __) =>
                    EndpointRegistry.instance.otpSkipButtonVisible &&
                            !_codeCanBeDelivered
                        ? _buildSkipButton()
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        children: [
          _buildWhyBanner(),
          SizedBox(height: 24.h),
          _buildBoxes(),
          SizedBox(height: 14.h),
          _buildStatusRow(),
          SizedBox(height: 28.h),
          _buildSecurityNote(),
        ],
      ),
    );
  }

  /// Why the user is seeing this at all. It used to be a bare shield glyph over
  /// a heading; saying "new device" is what actually reassures someone who did
  /// just sign in somewhere new — and warns someone who didn't.
  ///
  /// But it said exactly that EVERY time, including to someone unlocking the
  /// phone they have used daily for months. A security banner that cries wolf
  /// on every sign-in is worse than no banner: it teaches people to swipe past
  /// the one warning that should stop them. So the claim is now made only when
  /// this install has never signed this identity in before.
  ///
  /// The softer copy is still honest about what is happening — the server did
  /// raise a challenge, for a risk reason the app is not told — it just does
  /// not invent "new device" as the reason.
  Widget _buildWhyBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _brandPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _brandPurple.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: _brandPurple, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              widget.knownDevice
                  ? 'Extra verification is needed to continue.'
                  : 'New sign-in detected on this device.',
              style: TextStyle(
                color: _ink,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: _textSecondary, size: 15.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            widget.knownDevice
                ? "Didn't request this? Don't share the code with anyone."
                : "Didn't request this? Don't share the code, close the app "
                    'and change your password.',
            style:
                TextStyle(color: _textSecondary, fontSize: 12.sp, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxes() {
    // The boxes were a fixed 48px each inside a spaceBetween Row, so on a narrow
    // screen the sixth one ran off the edge — the code was literally not fully
    // enterable. Sizing them from the ACTUAL available width makes the row fit
    // any device and stay evenly spaced.
    return LayoutBuilder(
      builder: (context, constraints) {
        final gutter = 8.w;
        final boxWidth =
            (constraints.maxWidth - gutter * (_boxes - 1)) / _boxes;
        // AN AutofillGroup IS REQUIRED for the hint on box one to reach the
        // platform at all — Flutter forwards autofillHints only when one is an
        // ancestor, so without it the tag is inert and looks done.
        return AutofillGroup(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_boxes, (i) {
            return SizedBox(
              width: boxWidth,
              child: KeyboardListener(
                focusNode: FocusNode(skipTraversal: true),
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace) {
                    _onBackspace(i);
                  }
                },
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  enabled: !_expired && !_submitting,
                  autofocus: i == 0,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // EVERY BOX ACCEPTS A FULL PASTE, not just the first.
                  //
                  // This was `i == 0 ? _boxes : 1`, so a paste only survived
                  // if the customer happened to have pressed box one: pasting
                  // six digits into box three was truncated to a single
                  // character, `_onDigitChanged` never saw a multi-character
                  // value, and the distribution below never ran. It looked
                  // like paste worked, for one box out of six.
                  maxLength: _boxes,
                  // THE HINT GOES ON BOX ONE ONLY, and that is deliberate.
                  //
                  // It is the autofocused box, so the platform's one-time-code
                  // suggestion appears the moment the screen opens, which is
                  // when it is wanted. Tagging all six would invite the OS to
                  // fill each of them with the whole code — harmless, because
                  // the distribution is idempotent, but it would run six times
                  // for one autofill.
                  autofillHints: i == 0 ? otpAutofillHints : null,
                  // Paste needs BOTH of these: the pin packages and a bare
                  // TextField alike give no long-press menu without a
                  // contextMenuBuilder, and nothing to long-press without
                  // interactive selection.
                  enableInteractiveSelection: true,
                  contextMenuBuilder: otpContextMenu,
                  style: TextStyle(
                      color: _ink,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (v) => _onDigitChanged(i, v),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: _field,
                    // Symmetric padding only — the width now comes from the
                    // LayoutBuilder, so horizontal padding here would fight it.
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(
                          color: _errorText != null ? _errorColor : _divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(
                          color:
                              _errorText != null ? _errorColor : _brandPurple,
                          width: 1.6),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: const BorderSide(color: _divider),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
      },
    );
  }

  /// "Send it to my phone instead" — the way out when the default channel is
  /// one the user cannot reach.
  ///
  /// Email is the default for step-up because it is the channel every account
  /// has; someone locked out of their inbox, or on a handset where mail does
  /// not arrive, has no other route without this.
  ///
  /// ONLY WHEN THE SERVER SAYS THERE IS ONE. _altMethod is empty unless the
  /// account carries a second contact AND that channel can deliver right now —
  /// neither of which this screen can work out for itself. An affordance that
  /// appears and then fails is worse than one that never appears.
  ///
  /// Sits under the resend row rather than beside it: this is the rarer
  /// action, and crowding the countdown is how a user taps the wrong one.
  Widget _buildChannelSwitch() {
    if (_altMethod.isEmpty) return const SizedBox.shrink();
    final toPhone = _altMethod == 'sms';
    final label =
        toPhone ? 'Send it to my phone instead' : 'Send it to my email instead';

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          // Disabled while EITHER request is in flight: two codes racing would
          // leave the user holding whichever arrived second with no way to know.
          onPressed: (_submitting || _resending || _switching || _terminal)
              ? null
              : () => _requestNewCode(method: _altMethod),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: _switching
              ? SizedBox(
                  width: 14.sp,
                  height: 14.sp,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  toPhone
                      ? Icons.smartphone_rounded
                      : Icons.mail_outline_rounded,
                  size: 16.sp,
                ),
          label: Text(
            // The masked destination is shown so the user can confirm it is a
            // number or address they can actually reach BEFORE spending a
            // resend on it.
            _switching ? 'Sending…' : '$label ($_altDestination)',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  /// One line under the boxes carrying whichever of the three states applies:
  /// an inline error, the expired state, or the countdown + resend. Kept to a
  /// single row so the boxes and the CTA never shift position between states.
  Widget _buildStatusRow() {
    if (_errorText != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: _errorColor, size: 15.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(_errorText!,
                style: TextStyle(color: _errorColor, fontSize: 12.5.sp)),
          ),
        ],
      );
    }
    if (_expired) {
      return Row(
        children: [
          Icon(Icons.timer_off_outlined, color: _errorColor, size: 15.sp),
          SizedBox(width: 6.w),
          Text('Code expired.',
              style: TextStyle(color: _errorColor, fontSize: 12.5.sp)),
          const Spacer(),
          _linkButton('Get a new code', _requestNewCode),
        ],
      );
    }
    // Once the COOLDOWN has passed, offer the resend even though the code is
    // still live. Waiting for expiry stranded anyone whose SMS never arrived:
    // they could see a running timer and no way to act on it for the whole
    // window. The server enforces the cooldown regardless, so showing the
    // button can only ever be as permissive as the backend already is.
    // THE EXPIRY COUNTDOWN IS GONE, DELIBERATELY.
    //
    // It counted a window the customer cannot influence, beside a resend
    // countdown that says when they MAY do something. Two live numbers at
    // different rates, and only one of them actionable — people read the wrong
    // one and waited. The code still expires; the server still refuses a dead
    // one, and the expired branch below still says so, which is the only part
    // that ever changed what anyone did.
    final row = Row(
      children: [
        const Spacer(),
        if (_canResend)
          _linkButton('Get a new code', _requestNewCode)
        else
          Text(
              _resendSecondsLeft > 0
                  ? "Didn't get it? Resend in ${_resendSecondsLeft}s"
                  : "Didn't get it? Resend shortly",
              style: TextStyle(color: _textSecondary, fontSize: 11.5.sp)),
      ],
    );

    // This login code is delivered by SMS ("to your phone"), so once the first
    // cooldown has elapsed and resend is offered, DND is a real and
    // customer-fixable reason nothing arrived. Gated on _canResend so it never
    // appears while a code may still be in flight.
    if (!_canResend) return row;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        row,
        _buildChannelSwitch(),
        SmsDndNotice(cooldownsElapsed: _cooldownsElapsed),
      ],
    );
  }

  /// A tap target that reads as a link. The old bare GestureDetector on a 13px
  /// label gave a target well under the 44px minimum and sat right against the
  /// screen edge, which is how "Resend" ended up clipped.
  Widget _linkButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        child: Text(
          label,
          style: TextStyle(
              color: _brandPurple,
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
