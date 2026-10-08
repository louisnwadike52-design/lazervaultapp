import 'package:flutter/foundation.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';
import 'package:flutter/material.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/account_locked_modal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/authentication/presentation/views/login_otp_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_verification_screen.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/services/server_status_service.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/widgets/oauth_sign_in_buttons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/session_login_completer.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/voice_login_sheet.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen>
    with SessionLoginCompleter {
  static const Color _accent = Color(0xFF4834D4);
  late ResponsiveController _responsiveController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _storage = serviceLocator<FlutterSecureStorage>();
  bool _hasPasscodeSetup = false;
  // Guards the Voice-login flow against re-entrancy. (Fingerprint/Face ID are
  // deliberately NOT offered here — they're a LOCAL gate over a cached session,
  // which only exists for a returning user, i.e. the passcode LOCK screen. The
  // fresh email login uses email+password or server-verified Voice.)
  bool _altAuthInProgress = false;
  // The identifier field accepts an email OR a phone number. We detect which as
  // the user types: when a phone is detected we reveal a selectable country-code
  // pill beside the field and validate/format per that country (default Nigeria).
  bool _isPhone = false;
  String _selectedCountryIso = 'NG';
  // One-shot guard: the async AuthenticationSuccess listener can re-fire
  // (success snackbar + getUserProfile re-entrancy), which navigated to the
  // dashboard twice (the "double swipe"). Navigate exactly once.
  bool _navigated = false;

  // Google/Apple sign-in are not wired to a real backend yet (the repository's
  // signInWithGoogle/Apple are stubs), so hide the buttons for store review —
  // shipping non-functional auth buttons is a common review rejection. Flip this
  // to true once the OAuth integration lands; nothing else needs to change (the
  // buttons + handlers stay in place, just not rendered).
  // Google/Apple sign-in. Platform availability comes from [OAuthProviders];
  // the Settings → Sign-in methods toggles can hide either one (default on).
  bool _googleLoginOn = true;
  bool _appleLoginOn = true;

  // Shown only when the OS can complete it, the admin left it enabled
  // (FeatureFlags, from GetAuthenticationConfig), and the user didn't hide it.
  bool get _showGoogle =>
      OAuthProviders.googleAvailable &&
      FeatureFlags.isGoogleLoginEnabled &&
      _googleLoginOn;
  bool get _showApple =>
      OAuthProviders.appleAvailable &&
      FeatureFlags.isAppleLoginEnabled &&
      _appleLoginOn;
  bool get _socialSignInEnabled => _showGoogle || _showApple;

  /// The provider buttons, in platform order.
  ///
  /// iOS puts Apple first; every other platform puts Google first. Built as a
  /// list so the separator sits BETWEEN whichever two are actually shown —
  /// the previous inline form hard-coded Google-then-Apple and hung the gap
  /// off Google, so a build showing only Apple still reserved Google's spacing.
  List<Widget> _socialButtons(BuildContext context) {
    // Just the provider name. The divider directly above already says "or
    // continue with", so "Continue with Google" repeated it — and at half
    // width the repetition is what clipped the labels mid-word.
    final google = _showGoogle
        ? GoogleSignInButton(
            label: 'Google',
            onPressed: () =>
                context.read<AuthenticationCubit>().signInWithGoogle(),
          )
        : null;
    final apple = _showApple
        ? AppleSignInButtonFull(
            label: 'Apple',
            onPressed: () =>
                context.read<AuthenticationCubit>().signInWithApple(),
          )
        : null;

    final ordered = <Widget>[
      for (final w in (defaultTargetPlatform == TargetPlatform.iOS
          ? [apple, google]
          : [google, apple]))
        if (w != null) w,
    ];

    // SIDE BY SIDE when both providers are shown.
    //
    // They used to stack full-width, which — with the Voice button on its own
    // row above — pushed "or continue with" and Google clean off the bottom of
    // the screen behind the background wave. Equal widths keep Sign in with
    // Apple at least as prominent as Google, which is what Apple's guidance
    // actually requires; the thing that failed review before was compact
    // ICON-ONLY squares, not an equal-width labelled pair.
    //
    // A single provider stays full-width: half a row with nothing beside it
    // would just look broken.
    if (ordered.length == 2) {
      return <Widget>[
        Row(
          children: [
            Expanded(child: ordered[0]),
            SizedBox(width: 10.w),
            Expanded(child: ordered[1]),
          ],
        ),
      ];
    }

    return <Widget>[
      for (var i = 0; i < ordered.length; i++) ...[
        if (i > 0) SizedBox(height: 12.h),
        ordered[i],
      ],
    ];
  }

  Future<void> _loadSocialLoginPrefs() async {
    final store = serviceLocator<SecureStorageService>();
    final googleOn = await store.getGoogleLoginEnabled();
    final appleOn = await store.getAppleLoginEnabled();
    if (!mounted) return;
    setState(() {
      _googleLoginOn = googleOn;
      _appleLoginOn = appleOn;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSocialLoginPrefs();
    _responsiveController = ResponsiveController(context);
    // Set status bar icons to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _checkPasscodeAvailability();
    // Reflect an armed self-lock / emergency lock proactively (countdown modal)
    // on arrival — this is where an email-mode lock lands the user.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => maybeShowSelfLockOnLaunch(context));
  }

  Future<void> _checkPasscodeAvailability() async {
    try {
      final loginMethod = await _storage.read(key: 'login_method');
      final hasPasscode = await _storage.read(key: 'has_passcode');
      final storedEmail = await _storage.read(key: 'stored_email');
      final userEmail = await _storage.read(key: 'user_email');

      final hasEmail = (storedEmail != null && storedEmail.isNotEmpty) ||
          (userEmail != null && userEmail.isNotEmpty);

      if (mounted) {
        setState(() {
          // Offer "Use Passcode Instead" whenever the account actually HAS a
          // passcode — driven by the mirrored has_passcode flag (canonical) with
          // the legacy login_method as a fallback. Consistent with the resolver.
          _hasPasscodeSetup = hasPasscode == 'true' ||
              (loginMethod == 'passcode' && hasEmail) ||
              loginMethod == 'phone_passcode';
        });
      }
    } catch (e) {
      print('Error checking passcode availability: $e');
    }
  }

  Future<void> _switchToPasscodeLogin() async {
    // passcodeLogin is the LOCK screen, and LoginFlowResolver is explicit that
    // it is a dead end without a cached passcode user — fresh installs, wiped
    // accounts and email/password-only accounts all bounce straight back to
    // the full login screen. Which is THIS screen, so tapping Passcode simply
    // reloaded the email form and looked like a dead button.
    //
    // Resolve it properly: the lock only when a returning passcode user is
    // actually cached, otherwise the full phone+passcode login where they can
    // enter both.
    final returning = await LoginFlowResolver.hasCachedReturningUser();
    if (!mounted) return;
    Get.offAllNamed(
      returning ? AppRoutes.passcodeLogin : AppRoutes.phonePasscodeLogin,
    );
  }

  /// Voice sign-in keyed off the EMAIL: check the account (entered email, else
  /// the stored one) is configured for voice, then record + server-verify the
  /// voiceprint and mint a session (persisted → hydrated by the shared completer).
  Future<void> _onVoiceLogin() async {
    if (_altAuthInProgress) return;
    _altAuthInProgress = true;
    try {
      var email = _emailController.text.trim();
      if (!email.contains('@')) {
        email = (await _storage.read(key: 'stored_email')) ?? '';
      }
      if (!mounted) return;
      if (email.isEmpty || !email.contains('@')) {
        _altSnack(
            'Voice Login', 'Enter your email first, then use Voice login.');
        return;
      }

      final voice = serviceLocator<VoiceBiometricsService>();
      VoiceEnrollmentStatus status;
      try {
        status = await voice.checkEnrollmentByEmail(email);
      } on VoiceBiometricsNetworkException {
        if (mounted) {
          _altSnack('Voice Login',
              'Network problem — check your connection and try again.');
        }
        return;
      } catch (_) {
        if (mounted) {
          _altSnack('Voice Login', 'Voice login is unavailable right now.');
        }
        return;
      }
      if (!mounted) return;
      if (!status.isEnrolled) {
        _altSnack('Voice Login',
            'This account hasn\'t set up Voice login. Sign in, then enroll it in Settings → Security → Biometric Login.');
        return;
      }

      final result = await VoiceLoginSheet.showForEmail(context, email: email);
      if (result == null || !result.hasSession || !mounted) return;

      // Persist the freshly-minted tokens, THEN finish login using them.
      await _storage.write(key: 'access_token', value: result.accessToken!);
      await _storage.write(key: 'refresh_token', value: result.refreshToken!);
      if (result.userId != null && result.userId!.isNotEmpty) {
        await _storage.write(key: 'user_id', value: result.userId!);
      }
      if (!mounted) return;
      final outcome = await completeSessionLogin(flow: 'voice_login');
      if (!mounted) return;
      if (outcome == SessionLoginOutcome.network) {
        _altSnack('Connection problem',
            'Signed in, but couldn\'t load your profile. Check your connection.');
      }
      // success → BlocConsumer navigates.
    } finally {
      _altAuthInProgress = false;
    }
  }

  void _altSnack(String title, String message) {
    if (!mounted || Get.isSnackbarOpen) return;
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(15.w),
      borderRadius: 10.r,
    );
  }

  /// "Or sign in with" — Voice only. Voice is server-verified (works for a fresh
  /// email login with no cached session); it's offered to everyone and gated on
  /// tap by whether the account actually enrolled a voiceprint. Fingerprint/Face
  /// ID are intentionally NOT here — they live on the passcode LOCK screen, the
  /// only place a cached session exists for a local OS gate to unlock.
  Widget _buildAlternateAuthRow() {
    // Voice sits INLINE now. As its own centred column with a heading it cost
    // roughly 110dp of vertical space on a screen that was already overflowing,
    // which is what pushed the social buttons off the bottom. The row keeps it
    // beside the passcode link so both alternatives read as one choice.
    return Padding(
      padding: EdgeInsets.only(top: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _altAuthButton(
            icon: Icons.mic_none_rounded,
            label: 'Voice',
            onTap: _onVoiceLogin,
          ),
          if (_hasPasscodeSetup) ...[
            SizedBox(width: 28.w),
            _altAuthButton(
              icon: Icons.password_rounded,
              label: 'Passcode',
              onTap: _switchToPasscodeLogin,
            ),
          ],
        ],
      ),
    );
  }

  Widget _altAuthButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _altAuthInProgress ? null : onTap,
          borderRadius: BorderRadius.circular(30.r),
          child: Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _accent.withValues(alpha: 0.08),
              border:
                  Border.all(color: _accent.withValues(alpha: 0.4), width: 1.4),
            ),
            child: Icon(icon, color: _accent, size: 26.w),
          ),
        ),
        SizedBox(height: 6.h),
        Text(label,
            style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments from navigation
    final arguments = Get.arguments as Map<String, dynamic>?;
    final fromForgotPasscode = arguments?['fromForgotPasscode'] == true;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg/up-down-curve-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocListener<AuthenticationCubit, AuthenticationState>(
            // Only react on a real transition INTO a terminal login state.
            // AuthenticationSuccess is re-emitted from ~15 cubit sites (e.g.
            // getUserProfile() -> updateCurrentUser() re-entrancy), which used
            // to re-fire this listener repeatedly. Gate on an actual transition
            // so post-login profile refreshes never re-trigger navigation.
            listenWhen: (prev, curr) {
              // React ONLY on a genuine transition INTO a terminal state. Both
              // AuthenticationSuccess and AuthenticationFailure can be re-emitted
              // (profile-refresh re-entrancy, rebuilds, repeated identical
              // errors), which previously re-fired navigation / the error
              // snackbar multiple times. Gating on the transition means a
              // re-emit of the SAME terminal state never re-triggers the handler.
              if (curr is AuthenticationSuccess)
                return prev is! AuthenticationSuccess;
              if (curr is AuthenticationFailure)
                return prev is! AuthenticationFailure;
              return true;
            },
            listener: (context, state) async {
              switch (state) {
                case LoginTwoFactorRequired(
                    twoFactorToken: final tfToken,
                    method: final tfMethod,
                  ):
                  Get.to(() => BlocProvider.value(
                        value: serviceLocator<AuthenticationCubit>(),
                        child: TwoFactorVerificationScreen(
                          twoFactorToken: tfToken,
                          method: tfMethod,
                        ),
                      ));
                  break;
                case LoginStepUpRequired(
                    stepUpToken: final token,
                    method: final method,
                    destination: final dest,
                    expiresInSeconds: final ttl,
                  ):
                  // Risk-based step-up: collect the OTP. The screen is self-
                  // contained (owns a fresh cubit + routes to dashboard on success).
                  Get.to(() => LoginOtpScreen(
                        stepUpToken: token,
                        method: method,
                        destination: dest,
                        expiresInSeconds: ttl,
                      ));
                  break;
                case AuthenticationSuccess(profile: final profile):
                  // Guard against a duplicate navigation if the listener re-fires.
                  if (_navigated) break;
                  _navigated = true;
                  // Load user profile after successful authentication
                  context.read<ProfileCubit>().getUserProfile();

                  if (fromForgotPasscode) {
                    // Go to passcode setup when resetting — pass hasTransactionPin
                    // so user isn't routed to TX PIN setup if they already have one
                    Get.offAllNamed(AppRoutes.passcodeSetup, arguments: {
                      'fromLoginFlow': true,
                      'hasTransactionPin': profile.user.hasTransactionPin,
                      'fromForgotPasscode': true,
                    });
                    break;
                  }

                  // Resume from any incomplete signup step — the backend
                  // is source of truth (users.current_signup_step + users.
                  // signup_status). If the user logged in mid-signup
                  // (e.g. they signed up, didn't verify their phone, and
                  // came back days later), drop them at the right resume
                  // route instead of the dashboard. `null` / empty / the
                  // "complete" status means signup is done → fall through
                  // to the usual dashboard-or-passcode-setup branch.
                  final resumeRoute = signupResumeRoute(
                    profile.user.currentSignupStep,
                    profile.user.signupStatus,
                    email: profile.user.email,
                    phone: profile.user.phoneNumber,
                    hasPasscode: profile.user.hasPasscode,
                    hasTransactionPin: profile.user.hasTransactionPin,
                  );
                  if (resumeRoute != null) {
                    Get.offAllNamed(resumeRoute.name,
                        arguments: resumeRoute.args);
                    break;
                  }

                  // Backend is source of truth — use login response data
                  if (profile.user.hasPasscode) {
                    // Passcode already set — persist login method.
                    await _storage.write(
                        key: 'login_method', value: 'passcode');
                    if (!profile.user.hasTransactionPin) {
                      // No transaction PIN yet — resume the (skippable) PIN setup
                      // before the dashboard, mirroring the KYC onboarding gate.
                      Get.offAllNamed(AppRoutes.transactionPinSetup,
                          arguments: {'fromLoginFlow': true});
                    } else {
                      Get.offAllNamed(AppRoutes.dashboard);
                    }
                  } else {
                    // No passcode — route to setup, pass hasTransactionPin for downstream
                    Get.offAllNamed(AppRoutes.passcodeSetup, arguments: {
                      'fromLoginFlow': true,
                      'hasTransactionPin': profile.user.hasTransactionPin,
                    });
                  }
                  break;
                case AuthenticationFailure(message: final msg):
                  // Self-lock / failed-login lockout: show the blocking countdown
                  // modal instead of a transient snackbar (there's no early unlock).
                  final lockUntil = parseAccountLockUntil(msg);
                  if (lockUntil != null) {
                    showAccountLockedModal(context, lockUntil,
                        selfLock: isSelfLock(msg),
                        fraudFreeze: isFraudFreeze(msg));
                    break;
                  }
                  // Never stack error snackbars — GetX queues them, so a fast
                  // retry (or any re-fire) would show several. Close any open one
                  // first so at most a single login-error toast is visible.
                  if (Get.isSnackbarOpen) {
                    Get.closeAllSnackbars();
                  }
                  // A connectivity/edge failure is NOT a bad credential — don't
                  // say "Login Error" (reads as wrong password). Poke the health
                  // gate to re-probe (a genuine outage surfaces the maintenance
                  // modal; the user's own offline network stays this snackbar).
                  final ml = msg.toLowerCase();
                  final looksNetwork = isNetworkError(msg) ||
                      ml.contains('network error') ||
                      ml.contains('check your connection');
                  if (looksNetwork) {
                    ServerHealthNotifier.instance.pokeRecheck();
                  }
                  Get.snackbar(
                    looksNetwork ? 'Connection problem' : 'Login Error',
                    looksNetwork
                        ? "We couldn't reach our servers. Please try again in a moment."
                        : msg,
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                    margin: EdgeInsets.all(15.w),
                    borderRadius: 10.r,
                  );
                  break;
                default:
                  break;
              }
            },
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                final isLoading = state is AuthenticationLoading;

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // Bottom padding clears the background wave AND the home
                    // indicator. With only 16dp the last element sat under the
                    // curve, which is why "or continue with" and the provider
                    // buttons appeared cut off.
                    padding: EdgeInsets.only(
                      top: 16.0.h,
                      left: 16.0.w,
                      right: 16.0.w,
                      bottom: 48.0.h + MediaQuery.of(context).padding.bottom,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Was 10% of screen height — pure dead space on a
                          // screen whose content already overflows.
                          SizedBox(
                              height:
                                  _responsiveController.screenHeight * 0.04),
                          Center(
                            child: UniversalImageLoader(
                              imagePath: AppData.appLogo,
                              height: 70.0.h,
                              width: 70.0.w,
                            ),
                          ),
                          SizedBox(height: 16.0.h),
                          Text(
                            fromForgotPasscode
                                ? "Reset Your Passcode"
                                : "Welcome Back!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          Text(
                            fromForgotPasscode
                                ? "Sign in with email/password to reset your passcode"
                                : "Sign in to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 42.0.h),
                          _buildSignInForm(context),
                          SizedBox(height: 24.0.h),
                          isLoading
                              ? const Center(child: LazerVaultLoader.small())
                              : SizedBox(
                                  width: double.infinity,
                                  height: 54.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4834D4),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      // Pill-rounded edges — half-height radius
                                      // gives a true capsule shape regardless of
                                      // device scale.
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<AuthenticationCubit>()
                                          .loginUser(
                                            email: _emailController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                            countryIso: _selectedCountryIso,
                                          );
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                          if (!isLoading) _buildAlternateAuthRow(),
                          SizedBox(height: 12.0.h),
                          // "Use Passcode Instead" moved into
                          // _buildAlternateAuthRow beside Voice — two ways to
                          // sign in without a password belong together, and
                          // separating them cost another full row.

                          // Google/Apple sign-in — full-width buttons in each
                          // brand's official treatment (the compact grey
                          // squares failed both style guides). Hidden while a
                          // login is in flight so the provider sheet can't
                          // stack on a submit.
                          if (_socialSignInEnabled && !isLoading) ...[
                            SizedBox(height: 16.0.h),
                            Row(children: [
                              const Expanded(child: Divider(thickness: 0.6)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Text(
                                  'or continue with',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.black54),
                                ),
                              ),
                              const Expanded(child: Divider(thickness: 0.6)),
                            ]),
                            SizedBox(height: 16.0.h),
                            // APPLE LEADS ON iOS.
                            //
                            // Order is platform-dependent, not fixed: on iOS
                            // Sign in with Apple takes the leading position and
                            // Google follows; everywhere else Google leads.
                            // This is also what Apple's own guidance requires —
                            // Sign in with Apple must appear at least as
                            // prominently as other providers, and on their
                            // platform "first" is what prominent means.
                            //
                            // NOTE: these are the brands' official FULL-WIDTH
                            // treatments, stacked, so "leading" is the TOP
                            // slot rather than the left of a row. The compact
                            // side-by-side squares were tried and failed both
                            // style guides.
                            ..._socialButtons(context),
                            SizedBox(height: 24.h),
                          ] else
                            SizedBox(height: 32.h),
                          // Sign-up link moved OUT of this column and pinned
                          // to the bottom of the Stack — see below. Its height
                          // is reserved here so the last control can still be
                          // scrolled clear of it.
                          SizedBox(height: 56.h),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // PINNED TO THE BOTTOM, not floated at the end of the content.
          //
          // The link is white, because the background wave is purple down
          // here. As the last item in the scrolling column its position
          // depended on content height, so it landed ON the wave's edge —
          // the right half legible over purple, the left half white-on-white
          // and effectively invisible. Pinning it keeps it wholly inside the
          // purple band whatever the column above does.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _buildSignUpLink(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Email-or-phone identifier detection + country selection ---

  /// True when [raw] looks like the start of a phone number (only digits and an
  /// optional leading "+", no "@"). Lighter than [isPhoneIdentifier] so the
  /// country pill appears as soon as the user starts typing digits.
  bool _looksLikePhone(String raw) {
    final v = raw.trim();
    if (v.isEmpty || v.contains('@')) return false;
    final cleaned = v.replaceAll(RegExp(r'[\s\-()]'), '');
    return RegExp(r'^\+?[0-9]+$').hasMatch(cleaned);
  }

  bool _startsWithPlus() => _emailController.text
      .trim()
      .replaceAll(RegExp(r'[\s\-()]'), '')
      .startsWith('+');

  /// National digits (dial code stripped when the user typed a leading "+",
  /// national trunk "0" dropped) for the current identifier.
  String _nationalDigits() {
    final cleaned =
        _emailController.text.trim().replaceAll(RegExp(r'[\s\-()]'), '');
    if (cleaned.startsWith('+')) return cleaned.substring(1);
    return cleaned.replaceFirst(RegExp(r'^0+'), '');
  }

  /// National significant number length for the selected country (NG=10, etc.).
  int _expectedNationalLength() =>
      CountryConfigs.getByCode(_selectedCountryIso)?.nationalNumberLength ?? 10;

  /// Max characters accepted while typing a national number: national length + 1
  /// so a single leading "0" trunk can be entered before it's stripped.
  int _phoneMaxInputLength() => _expectedNationalLength() + 1;

  /// Live phone validity for the selected country. Returns an error string when
  /// the typed national number is too long, `null` when it is valid or still
  /// incomplete (incomplete is not surfaced as an error while typing).
  String? _phoneLiveError() {
    final national = _nationalDigits();
    if (national.isEmpty) return null;
    final expected = _expectedNationalLength();
    if (national.length > expected) {
      final name =
          CountryConfigs.getByCode(_selectedCountryIso)?.name ?? 'this country';
      return 'Too long for $name — $expected digits';
    }
    return null;
  }

  bool _phoneComplete() =>
      _nationalDigits().length == _expectedNationalLength();

  void _onIdentifierChanged(String value) {
    final phone = _looksLikePhone(value);
    if (phone != _isPhone) {
      setState(() => _isPhone = phone);
    } else if (phone) {
      // keep the hint's live E.164 preview in sync as digits change
      setState(() {});
    }
  }

  Widget _buildCountryPill() {
    final cfg = CountryConfigs.getByCode(_selectedCountryIso);
    return GestureDetector(
      onTap: _openCountryPicker,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(cfg?.flag ?? '🇳🇬', style: TextStyle(fontSize: 18.sp)),
          SizedBox(width: 4.w),
          Text(
            cfg?.dialingCode ?? '+234',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.black54),
        ],
      ),
    );
  }

  void _openCountryPicker() {
    FocusScope.of(context).unfocus();
    final countries = CountryConfigs.activeCountries;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select country',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              ...countries.map((c) {
                final selected = c.code == _selectedCountryIso;
                return ListTile(
                  leading: Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                  title: Text(
                    c.name,
                    style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                  ),
                  trailing: Text(
                    c.dialingCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? const Color(0xFF4834D4)
                          : Colors.grey.shade600,
                    ),
                  ),
                  selected: selected,
                  onTap: () {
                    setState(() => _selectedCountryIso = c.code);
                    Navigator.of(sheetCtx).pop();
                  },
                );
              }),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetectionHint() {
    final raw = _emailController.text.trim();
    if (raw.isEmpty) return const SizedBox.shrink();

    IconData icon;
    Color color;
    String text;

    if (_isPhone) {
      final liveError = _startsWithPlus() ? null : _phoneLiveError();
      if (liveError != null) {
        icon = Icons.error_outline;
        color = const Color(0xFFEF4444); // error red
        text = liveError;
      } else if (!_startsWithPlus() && _phoneComplete()) {
        icon = Icons.check_circle_outline;
        color = const Color(0xFF10B981); // success green
        text = 'Phone number detected';
      } else {
        icon = Icons.phone_iphone;
        color = Colors.black54;
        text = 'Phone number detected';
      }
    } else if (isEmailIdentifier(raw)) {
      icon = Icons.check_circle_outline;
      color = const Color(0xFF10B981); // success green
      text = 'Email address detected';
    } else if (isUsernameIdentifier(raw)) {
      icon = Icons.alternate_email;
      color = const Color(0xFF10B981); // success green
      text = 'Username detected';
    } else {
      icon = Icons.alternate_email;
      color = Colors.black54;
      text = 'Email or username';
    }

    return Padding(
      padding: EdgeInsets.only(top: 6.h, left: 12.w, right: 8.w),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.sp, color: color),
            ),
          ),
        ],
      ),
    );
  }

  /// Type-aware validation: per-country length for phone (lenient — length only,
  /// leading-zero tolerant), standard email check otherwise.
  String? _validateIdentifier(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) {
      Haptics.error();
      return 'Please enter your email, phone or username';
    }
    if (_looksLikePhone(v)) {
      final cleaned = v.replaceAll(RegExp(r'[\s\-()]'), '');
      if (cleaned.startsWith('+')) {
        // Explicit international number — just require a plausible length.
        final digits = cleaned.substring(1);
        if (digits.length < 7 || digits.length > 15) {
          Haptics.error();
          return 'Enter a valid phone number';
        }
        return null;
      }
      final national = cleaned.replaceFirst(RegExp(r'^0+'), '');
      final cfg = CountryConfigs.getByCode(_selectedCountryIso);
      final expected = cfg?.nationalNumberLength ?? 10;
      if (national.length != expected) {
        Haptics.error();
        return 'Enter a valid ${cfg?.name ?? 'phone'} number';
      }
      return null;
    }
    if (!isEmailIdentifier(v) && !isUsernameIdentifier(v)) {
      Haptics.error();
      return 'Enter a valid email, phone or username';
    }
    return null;
  }

  Widget _buildSignInForm(BuildContext context) {
    return Column(
      children: [
        BuildFormField(
          name: "email",
          placeholder: "Email, phone or username",
          keyboardType: TextInputType.emailAddress,
          prefixIcon:
              _isPhone ? null : const Icon(Icons.person, color: Colors.black45),
          leading:
              (_isPhone && !_startsWithPlus()) ? _buildCountryPill() : null,
          controller: _emailController,
          onChanged: _onIdentifierChanged,
          validator: _validateIdentifier,
          // Cap the number of characters accepted while a national phone number
          // is being typed, based on the selected country (national length + 1
          // for an optional leading "0"). No cap in email mode or for an
          // explicit "+" international number.
          inputFormatters: (_isPhone && !_startsWithPlus())
              ? [LengthLimitingTextInputFormatter(_phoneMaxInputLength())]
              : null,
        ),
        _buildDetectionHint(),
        SizedBox(height: 8.0.h),
        BuildFormField(
          name: "password",
          placeholder: "Password",
          obscureText: true,
          prefixIcon: const Icon(Icons.lock, color: Colors.black45),
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              Haptics.error();
              return 'Please enter your password';
            }
            return null;
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed(AppRoutes.passwordRecovery),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        SizedBox(width: 4.w),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // AppRoutes.signupEntry follows the PLATFORM default, which is
          // right for onboarding where no flow is in play — but wrong here.
          // Somebody reading an email+password form and tapping Sign Up means
          // the email signup; sending them to the phone flow discards the
          // screen they chose. The platform default still governs every
          // context-free entry point.
          onPressed: () => Get.toNamed(AppRoutes.signUp),
        )
      ],
    );
  }
}

/// Resolve where to send a user who logs in mid-signup, based on the
/// server-tracked `users.current_signup_step` and `users.signup_status`.
///
/// Step names mirror the backend `models.Step*` constants
/// (account_created / email_verify / phone_verify / passcode_setup /
/// identity_verify). Returns `null` for a fully-complete signup so
/// the caller's normal post-login routing runs.
///
/// **MUST stay in sync with `_getRouteForSignupStep` in main.dart** —
/// both files resolve the same set of step strings to GetX routes; one
/// for cold-start resume, the other for post-login resume.
