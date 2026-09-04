import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/authentication/presentation/views/login_otp_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_verification_screen.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:lazervault/src/features/ai_chats/presentation/widgets/fullscreen_image_viewer.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/voice_login_sheet.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/account_locked_modal.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/services/biometric_service.dart';
import 'package:lazervault/core/utils/logger.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/session_login_completer.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/biometric/biometric_setup_dialog.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'dart:io' show Platform;
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PasscodeSignIn extends StatefulWidget {
  const PasscodeSignIn({super.key});

  @override
  State<PasscodeSignIn> createState() => _PasscodeSignInState();
}

class _PasscodeSignInState extends State<PasscodeSignIn>
    with WidgetsBindingObserver, SessionLoginCompleter {
  final int _passcodeLength = 6;

  // Revolut-style "wrong passcode" shake: the dots row shakes + a heavy haptic
  // fires whenever a new passcode error arrives. _lastError de-dupes so we
  // shake once per distinct error, not on every rebuild.
  final GlobalKey<ShakeWidgetState> _passcodeShakeKey =
      GlobalKey<ShakeWidgetState>();
  String? _lastError;

  final _secureStorage = serviceLocator<FlutterSecureStorage>();
  final BiometricService _bio = BiometricService();

  bool _biometricFlowInProgress = false; // guards against re-entrant taps
  bool _autoPromptAttempted = false; // auto-logon fires the OS prompt once only
  bool _canCheckBiometrics = false; // device supports + has an enrolled biometric
  bool _canEnrollBiometric = false; // sensor present but nothing enrolled yet
  bool _biometricEnabled = false; // opted-in for the device's biometric in Settings
  bool _voiceEnabled = false; // voice login opted-in via Settings → Biometric Login
  IconData _biometricIcon = Icons.fingerprint;
  String _biometricTooltip = 'Use Biometrics';
  BiometricType? _availableBiometricType;

  // Stored user data
  String? _storedFirstName;
  String? _storedLastName;
  String? _storedAvatarUrl;

  // One-shot guard: the AuthenticationSuccess listener can re-fire because the
  // post-login getUserProfile() → AuthenticationCubit.updateCurrentUser() loop
  // re-emits AuthenticationSuccess. Without this the dashboard route was pushed
  // multiple times ("dashboard slides in multiple times"). Navigate exactly once.
  bool _navigated = false;

  // True when this account/platform is passwordless (phone+passcode): there is
  // no email/password to fall back to, so the alternate login is email+passcode
  // and recovery is a phone-OTP passcode reset. Driven by the active platform
  // mode (the user's "if active is phone and passcode") OR a stored phone
  // account, so a phone account still shows the right CTAs even if an admin
  // later flips the platform to email mode.
  // Default from the canonical flow (default phone_passcode → passwordless);
  // corrected from the mirrored has_password flag once storage loads.
  bool _isPasswordless = !FeatureFlags.isEmailPasswordLogin;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Detect capability first, then (once) auto-fire the OS biometric prompt for
    // opted-in returning users — the admin-toggleable "auto logon". Chained off
    // the detection future so the readiness flags are populated before we decide.
    _checkBiometricCapabilities().then((_) => _maybeAutoLogon());
    _loadStoredUserData();
    _refreshAuthMode();

    // Initialize passcode login state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationCubit>().startPasscodeLogin();
      // Reflect an armed self-lock / emergency lock proactively (countdown).
      maybeShowSelfLockOnLaunch(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-detect biometric capability when returning to the lock screen: the
    // user may have just enrolled a fingerprint/face in the OS settings (e.g.
    // via our "Set up" prompt), or removed one — so the button reflects reality
    // without needing an app restart. Detection only; we never auto-prompt on
    // resume (dismissing the OS prompt itself fires a resume, which would loop).
    if (state == AppLifecycleState.resumed && mounted) {
      _checkBiometricCapabilities();
    }
  }

  Future<void> _checkBiometricCapabilities() async {
    // Centralized detection: distinguishes enrolled vs not-enrolled vs
    // no-hardware (Android via native BiometricManager, iOS via local_auth).
    final status = await _bio.status();

    // Only offer biometric unlock for methods the user opted into in
    // Settings → Biometric Login (opt-in, per method).
    final store = serviceLocator<SecureStorageService>();
    final faceOn = await store.getFaceLoginEnabled();
    final fingerprintOn = await store.getFingerprintLoginEnabled();
    final voiceOn = await store.getVoiceLoginEnabled();

    if (!mounted) return;

    setState(() {
      _voiceEnabled = voiceOn;
      // Hardware present but nothing enrolled → we still let the button show so
      // the tap can send the user to OS enrollment.
      _canEnrollBiometric = status.canEnroll;
      // NOTE: Android reports face unlock as strong/weak (NOT BiometricType.face),
      // so a strong/weak-only device is treated as "fingerprint" here.
      if (status.isAvailable && status.hasFace) {
        _availableBiometricType = BiometricType.face;
        _biometricIcon = Icons.face;
        _biometricTooltip = 'Face ID';
        _canCheckBiometrics = true;
        // Enabled when the user opted into Face ID. On the (rare) device that
        // also exposes fingerprint, a fingerprint opt-in counts too — the OS
        // prompt uses whichever modality is enrolled, so either preference
        // should unlock rather than dead-ending on "Face ID not set up".
        _biometricEnabled = faceOn || (status.hasFingerprint && fingerprintOn);
      } else if (status.isAvailable && status.hasFingerprint) {
        _availableBiometricType = BiometricType.fingerprint;
        _biometricIcon = Icons.fingerprint;
        _biometricTooltip = 'Fingerprint';
        _canCheckBiometrics = true;
        _biometricEnabled = fingerprintOn;
      } else {
        _availableBiometricType = null;
        _canCheckBiometrics = false;
        _biometricEnabled = false;
      }
    });
  }

  Future<void> _loadStoredUserData() async {
    try {
      // Defense-in-depth: the passcode LOCK screen is only meaningful for a
      // returning user cached on this device. If a fresh user reached it (e.g.
      // via AppRoutes.loginEntry), redirect to the correct full-login screen for
      // the mode instead of dead-ending on a lock with no identity to unlock.
      if (!await LoginFlowResolver.hasCachedReturningUser(
          storage: _secureStorage)) {
        // Log WHICH signal was missing so a wrongful bounce-to-login is
        // diagnosable instead of silent (the previous behaviour gave no clue).
        final phone = await _secureStorage.read(key: 'stored_phone');
        final email = await _secureStorage.read(key: 'stored_email');
        final uid = await _secureStorage.read(key: 'user_id');
        final method = await _secureStorage.read(key: 'login_method');
        final hasPass = await _secureStorage.read(key: 'has_passcode');
        debugPrint('🔒 passcode lock → login: not a cached returning user '
            '(phone=${phone?.isNotEmpty}, email=${email?.isNotEmpty}, '
            'userId=${uid?.isNotEmpty}, login_method=$method, '
            'has_passcode=$hasPass)');
        if (mounted) Get.offNamed(AppRoutes.freshLoginEntry);
        return;
      }

      final firstName = await _secureStorage.read(key: 'user_first_name');
      final lastName = await _secureStorage.read(key: 'user_last_name');
      final avatarUrl = await _secureStorage.read(key: 'user_avatar_url');
      final preferred = await _secureStorage.read(key: 'preferred_login_method');
      final hasPassword = await _secureStorage.read(key: 'has_password');

      if (mounted) {
        setState(() {
          _storedFirstName = firstName;
          _storedLastName = lastName;
          _storedAvatarUrl = avatarUrl;
          // Offer the "use email/password" fallback ONLY when the account
          // EXPLICITLY prefers email (and actually has a password) or the whole
          // platform is in email mode. In the phone_passcode default we keep the
          // passcode screen passwordless — the alternate CTA is "switch user", not
          // "use email/password" — even if the account also happens to have a
          // password. This stops the email fallback from showing under the
          // phone_passcode default.
          final prefersEmail =
              preferred == 'email_password' && hasPassword == 'true';
          _isPasswordless =
              !(prefersEmail || FeatureFlags.isEmailPasswordLogin);
        });
      }
    } catch (e) {
      print('Error loading stored user data: $e');
    }
  }

  bool get _hasAvatar =>
      _storedAvatarUrl != null && _storedAvatarUrl!.isNotEmpty;

  /// Opens the profile picture full-screen (Hero animation in; tap/close/swipe
  /// to animate back to position). Only when a real avatar is set.
  void _openAvatarFullScreen() {
    final url = _storedAvatarUrl;
    if (url == null || url.isEmpty) return;
    final isRemote = url.startsWith('http://') || url.startsWith('https://');
    FullScreenImageViewer.open(
      context,
      mediaUrl: isRemote ? url : null,
      localPath: isRemote ? null : url,
      heroTag: 'passcode-avatar',
    );
  }

  // Note: the key-tap haptic now fires inside the shared PasscodeKeypad, so
  // these callbacks must NOT also call Haptics.keyTap() (would double-buzz).
  void _onNumberPressed(String number) {
    context.read<AuthenticationCubit>().passcodeLoginDigitEntered(number);
  }

  void _onBackspacePressed() {
    context.read<AuthenticationCubit>().passcodeLoginBackspace();
  }

  /// Auto-logon: the instant the lock screen mounts, fire the native OS biometric
  /// prompt ONCE for a returning user who already opted into biometric login and
  /// has an enrolled sensor. This is a convenience trigger only — it reuses the
  /// exact same [_onBiometricPressed] path a manual tap would, so it can never
  /// bypass the OS secure-enclave check. It silently no-ops (leaving the passcode
  /// keypad) when biometric isn't ready, when the admin flag is off, or when a
  /// login is already under way. Only ever called from initState (never on
  /// lifecycle resume) so dismissing the OS sheet — which fires a resume — can't
  /// loop it, and [_autoPromptAttempted] guards a second attempt within the session.
  Future<void> _maybeAutoLogon() async {
    if (_autoPromptAttempted || !mounted) return;
    if (!FeatureFlags.autoBiometricLoginOnLaunch) return;
    // Only proceed to the native prompt when fully READY: enrolled sensor AND
    // opted-in for Lazervault. Never auto-open the OS-setup / enable-in-app
    // guidance dialogs — those must be user-initiated so launch never nags.
    if (!_biometricEnabled ||
        !_canCheckBiometrics ||
        _availableBiometricType == null) {
      return;
    }
    // Biometric unlock is only a LOCAL gate over the cached session — it rotates
    // the stored `refresh_token`. If the user is genuinely LOGGED OUT (no cached
    // session), auto-prompting would pop Face ID and then dead-end on "Sign in
    // required". So only auto-logon when there's a session to unlock; otherwise
    // leave the passcode keypad for a real re-auth.
    final refresh = await _secureStorage.read(key: 'refresh_token');
    if (!mounted || refresh == null || refresh.isEmpty) return;
    // Don't hijack a self-lock countdown or an in-flight authentication.
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is PasscodeLoginInProgress && authState.isAuthenticating) {
      return;
    }
    _autoPromptAttempted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _onBiometricPressed();
    });
  }

  void _onBiometricPressed() async {
    final currentState = context.read<AuthenticationCubit>().state;
    final isAuthenticating = currentState is PasscodeLoginInProgress &&
        currentState.isAuthenticating;
    if (isAuthenticating) return;
    // Re-entrancy guard: a double-tap must not stack two sheets/dialogs.
    if (_biometricFlowInProgress) return;
    _biometricFlowInProgress = true;
    try {
      await _runBiometricFlow();
    } finally {
      _biometricFlowInProgress = false;
    }
  }

  Future<void> _runBiometricFlow() async {
    // Re-detect fresh: the user may have just enrolled/removed a biometric in
    // the OS since this screen was built, so the decision tree acts on reality.
    await _checkBiometricCapabilities();
    if (!mounted) return;

    final label = _availableBiometricType == BiometricType.face
        ? 'Face ID'
        : 'Fingerprint';

    // Observability: record the detection decision so a store device that never
    // reaches the OS prompt is diagnosable in Loki.
    AppLogger.event('biometric_login', 'flow_start', screen: 'passcode_lock',
        fields: {
          'can_check': _canCheckBiometrics,
          'type': _availableBiometricType?.name ?? 'none',
          'enabled': _biometricEnabled,
        });

    // 1) No usable, enrolled sensor → modal guiding OS setup (screen lock +
    // enrol). Covers both "sensor present, nothing enrolled" and "no sensor".
    if (!_canCheckBiometrics || _availableBiometricType == null) {
      await _showOsSetupDialog(label);
      return;
    }

    // 2) Enrolled in the OS but not switched on for Lazervault → point at the
    // passcode keypad (Settings needs a live session to arm it).
    if (!_biometricEnabled) {
      await _showEnableInAppDialog(label);
      return;
    }

    // 3) Ready → fire the NATIVE OS prompt DIRECTLY. No wrapper sheet, no scan
    // animation, no artificial success delay — the whole point is speed: the
    // instant the OS (secure enclave) approves, we sign in. We only ever get a
    // yes/no from the OS; there is no in-app match to render.
    final reason = _availableBiometricType == BiometricType.face
        ? 'Look at your device to sign in to Lazervault'
        : 'Place your finger on the sensor to sign in to Lazervault';
    final result = await _bio.authenticate(reason: reason);
    if (!mounted) return;
    AppLogger.event('biometric_login', 'os_prompt_outcome',
        screen: 'passcode_lock', fields: {'outcome': result.outcome.name});
    switch (result.outcome) {
      case BiometricAuthOutcome.success:
        // OS approved → log in immediately.
        await _completeBiometricLogin();
        break;
      case BiometricAuthOutcome.notEnrolled:
      case BiometricAuthOutcome.passcodeNotSet:
        // Enrolment/screen-lock removed since detection → OS-setup guidance.
        await _showOsSetupDialog(label);
        break;
      case BiometricAuthOutcome.failed:
        // Cancelled or didn't match — the OS already gave its own feedback and
        // the passcode keypad is right in front of the user. Say nothing.
        break;
      case BiometricAuthOutcome.lockedOut:
      case BiometricAuthOutcome.permanentlyLockedOut:
      case BiometricAuthOutcome.notAvailable:
      case BiometricAuthOutcome.error:
        _showErrorSnackbar(
            label,
            BiometricService.messageFor(result, label: label.toLowerCase()) ??
                'Please use your passcode.');
        break;
    }
  }

  /// Modal: hardware present but nothing enrolled (or no device passcode).
  Future<void> _showOsSetupDialog(String label) async {
    final action = await BiometricSetupDialog.show(
      context,
      kind: BiometricSetupKind.notEnrolledInOs,
      label: label,
    );
    if (action == BiometricSetupAction.primary) {
      await _bio.openOsEnrollment();
      // didChangeAppLifecycleState re-detects on return, flipping the button live.
    }
  }

  /// Enrolled in the OS but biometric login isn't switched on for Lazervault
  /// yet. It can ONLY be turned on from an authenticated session (Settings →
  /// Biometric Login arms the durable token from the live session), so from
  /// this pre-login screen we do NOT deep-link to the settings toggle — that
  /// screen can't do anything without a session and would dead-end. Instead we
  /// point the user at the passcode keypad that's already in front of them;
  /// after they sign in once they can enable $label in Settings.
  Future<void> _showEnableInAppDialog(String label) async {
    _showErrorSnackbar('$label not turned on yet',
        'Sign in with your passcode, then turn on $label in Settings → Biometric Login.');
  }

  void _onVoicePressed() async {
    final currentState = context.read<AuthenticationCubit>().state;
    final isAuthenticating = currentState is PasscodeLoginInProgress && currentState.isAuthenticating;
    if (isAuthenticating) return;

    // "Voice = password": the cached identity (from a prior login on this
    // device) tells us WHO to verify + mint for; the voice IS the credential.
    // We need user_id (to look up the voiceprint) + the account phone (to mint
    // via the trusted admin path). Unlike the old flow, this does NOT need a
    // still-valid cached session — the minted session is fresh.
    final userId = await _secureStorage.read(key: 'user_id');
    final phone = await _secureStorage.read(key: 'stored_phone');
    if (!mounted) return;
    if (userId == null || userId.isEmpty) {
      _showErrorSnackbar('Voice Login',
          'Please log in with your passcode first to set up voice login.');
      return;
    }
    if (phone == null || phone.isEmpty) {
      // Voice login mints via the phone-based admin path; phone-primary
      // (passwordless) accounts always cache a phone. Rare email-only accounts
      // have none → guide to the passcode.
      _showErrorSnackbar('Voice Login',
          'Voice login needs a phone number on your account. Use your passcode.');
      return;
    }

    // SINGLE SOURCE OF TRUTH: the SERVER voiceprint (shared with the voice
    // agents), not the local `voice_login_enabled` flag. Enrolled anywhere
    // (login setup OR a voice agent, on any device) ⇒ usable here.
    final mgr = VoiceActivationManager();
    final enrolled = await mgr.isVoiceEnrolled(userId);
    if (!mounted) return;

    if (!enrolled) {
      // Not enrolled yet → enroll right here via the SAME flow the voice agents
      // use (enroll-on-first-use). Its completion syncs the login preference +
      // status cache. If the user backs out, don't proceed.
      final activated = await mgr.activateVoice(context, userId);
      if (!activated || !mounted) return;
    } else if (!_voiceEnabled) {
      // Enrolled on the server but the local "offer voice at login" preference
      // was off (e.g. enrolled via a voice agent) → self-heal it so the two
      // flows agree.
      try {
        await serviceLocator<SecureStorageService>().setVoiceLoginEnabled(true);
      } catch (_) {}
      _voiceEnabled = true;
    }

    // SERVER-attested voice login → a REAL, fresh session (the server verifies
    // the voiceprint + mints; a tampered client can't bypass it).
    final result =
        await VoiceLoginSheet.show(context, userId: userId, phone: phone);
    if (result == null || !result.hasSession || !mounted) return;

    // Persist the freshly-minted tokens, THEN complete login using them (this
    // is what makes voice a primary credential — it works even if the old
    // cached session was expired/revoked).
    await _secureStorage.write(key: 'access_token', value: result.accessToken!);
    await _secureStorage.write(key: 'refresh_token', value: result.refreshToken!);
    await _secureStorage.write(key: 'user_id', value: result.userId ?? userId);
    if (!mounted) return;
    await _completeBiometricLogin();
  }

  /// Shared post-biometric/voice success path.
  ///
  /// IMPORTANT: fingerprint/Face-ID/voice are only a LOCAL gate — they don't
  /// identify a user by themselves. The actual account is the one whose session
  /// (refresh_token) is cached on this device from the last passcode login. So
  /// we (1) rotate that cached session with the backend (catches a revoked
  /// device/session), then (2) HYDRATE the real user profile from the rotated
  /// token. Without step 2 the app opened on a valid session but with no
  /// in-memory profile → the dashboard greeted a nameless "guest".
  ///
  /// `refreshProfile()` emits AuthenticationSuccess, which this screen's
  /// BlocConsumer listener handles exactly like a passcode login (loads the
  /// ProfileCubit, runs the signup-resume / verification / transaction-PIN
  /// gates, then navigates) — so biometric login lands as the REAL user and
  /// takes the same post-login path.
  Future<void> _completeBiometricLogin() async {
    // The whole "load profile via the cached session → hydrate → BlocConsumer
    // navigates" tail (+ network-vs-revoked classification) lives in the shared
    // SessionLoginCompleter mixin, reused by the email sign-in screen too.
    final outcome = await completeSessionLogin(flow: 'biometric_login');
    if (!mounted) return;
    switch (outcome) {
      case SessionLoginOutcome.success:
        break; // AuthenticationSuccess → BlocConsumer runs gates + navigates.
      case SessionLoginOutcome.revoked:
        _showErrorSnackbar(
            'Sign in required', 'Please sign in with your passcode.');
        break;
      case SessionLoginOutcome.network:
        _showErrorSnackbar('Connection problem',
            'Couldn\'t reach Lazervault. Check your connection and try again.');
        break;
    }
  }

  /// Refresh the active platform auth mode from the backend so the "Sign Up"
  /// CTA (via [AppRoutes.signupEntry]) routes to the correct signup screen even
  /// if the cached value is stale (e.g. first launch after an admin flip).
  Future<void> _refreshAuthMode() async {
    try {
      final res = await serviceLocator<IAuthRepository>()
          .getAuthenticationMode()
          .timeout(const Duration(seconds: 3));
      res.fold((_) {}, (mode) {
        FeatureFlags.setAuthenticationMode(mode);
        if (mounted) setState(() {});
      });
    } catch (_) {/* best-effort — keep cached value */}
  }

  /// Bottom CTA. Passwordless (phone+passcode) accounts "Switch User" via a
  /// phone+passcode login for a DIFFERENT user (which updates the cached user);
  /// email/password accounts switch via the full email+password login.
  void _switchToAlternateLogin() {
    if (_isPasswordless) {
      Get.toNamed(AppRoutes.phonePasscodeLogin);
    } else {
      Get.offAllNamed(AppRoutes.emailSignIn);
    }
  }

  /// "Forgot your passcode?": passwordless accounts reset via a phone-OTP flow;
  /// email/password accounts recover by logging in with their password first.
  void _onForgotPasscode() {
    if (_isPasswordless) {
      Get.toNamed(AppRoutes.forgotPasscodePhone);
    } else {
      Get.toNamed(AppRoutes.emailSignIn, arguments: {'fromForgotPasscode': true});
    }
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Determine display name
    String displayName = 'Welcome Back 👋';
    if (_storedFirstName != null && _storedFirstName!.isNotEmpty) {
      displayName = 'Hey ${_storedFirstName!} 👋';
    }

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      // Only react on a real transition INTO AuthenticationSuccess. The
      // re-entrant getUserProfile→updateCurrentUser loop re-emits it, which
      // previously re-ran the dashboard navigation (multiple slide-ins).
      listenWhen: (prev, curr) {
        // React only on a genuine transition INTO a terminal state, so a re-emit
        // of the same success/failure never re-runs navigation or re-shows the
        // error snackbar (matches email_sign_in_screen).
        if (curr is AuthenticationSuccess) return prev is! AuthenticationSuccess;
        if (curr is AuthenticationFailure) return prev is! AuthenticationFailure;
        return true;
      },
      listener: (context, state) {
        if (state is LoginTwoFactorRequired) {
          // 2FA enabled: collect the 2FA code (self-contained screen + cubit).
          // On SUCCESS the 2FA screen does offAllNamed (this route is torn down,
          // mounted==false below). On BACK-OUT it returns here with the app-wide
          // cubit still parked in LoginTwoFactorRequired — re-arm a clean
          // PasscodeLoginInProgress so the keypad shows and digits work again
          // (otherwise the lock screen is stuck on a spinner). Capture the cubit
          // synchronously so we don't touch context across the async gap.
          final authCubit = context.read<AuthenticationCubit>();
          Get.to(() => BlocProvider.value(
                value: serviceLocator<AuthenticationCubit>(),
                child: TwoFactorVerificationScreen(
                  twoFactorToken: state.twoFactorToken,
                  method: state.method,
                ),
              ))?.then((_) {
            if (mounted) authCubit.startPasscodeLogin();
          });
          return;
        }
        if (state is LoginStepUpRequired) {
          // Risk-based step-up: collect the OTP (self-contained screen).
          // Same re-arm-on-return as the 2FA branch above.
          final authCubit = context.read<AuthenticationCubit>();
          Get.to(() => LoginOtpScreen(
                stepUpToken: state.stepUpToken,
                method: state.method,
                destination: state.destination,
              ))?.then((_) {
            if (mounted) authCubit.startPasscodeLogin();
          });
          return;
        }
        if (state is AuthenticationSuccess) {
          // Navigate exactly once — guards against any late re-emission slipping
          // past listenWhen (e.g. before this route is torn down by offAllNamed).
          if (_navigated) return;
          _navigated = true;
          // Load user profile after successful authentication
          context.read<ProfileCubit>().getUserProfile();
          final user = state.profile.user;
          // Backend-authoritative resume: if the BACKEND says this user's signup
          // is incomplete (users.current_signup_step / signup_status, returned in
          // the login response), drop them at the right step rather than the
          // dashboard — robust to quitting mid-onboarding / reinstalling, since
          // it does not depend on local signup-draft state. Same logic the email
          // sign-in uses, so resumption is identical on both login surfaces.
          final resume = signupResumeRoute(
            user.currentSignupStep,
            user.signupStatus,
            email: user.email,
            phone: user.phoneNumber,
            hasPasscode: user.hasPasscode,
            hasTransactionPin: user.hasTransactionPin,
          );
          if (resume != null) {
            Get.offAllNamed(resume.name, arguments: resume.args);
          } else if (FeatureFlags.isPhoneVerificationRequired &&
              (user.phoneNumber?.isNotEmpty ?? false) &&
              !user.verified) {
            // Re-verification gate: a user who onboarded while phone verification
            // was off (admin later turned it on) is guided to verify before the
            // dashboard. Email is gated server-side at login, so success implies a
            // verified (or not-required) email already.
            Get.offAllNamed(AppRoutes.phoneVerification, arguments: {
              'phoneNumber': user.phoneNumber,
              'isRequired': true,
              'nextRoute': AppRoutes.dashboard,
            });
          } else if (!user.hasTransactionPin) {
            // Backend says this user never finished transaction-PIN setup —
            // resume the (skippable) PIN flow before the dashboard, mirroring
            // the KYC onboarding gate. `fromLoginFlow` makes Skip/Done route
            // forward to the dashboard (and if a PIN actually exists, the setup
            // screen detects it and proceeds straight through).
            Get.offAllNamed(AppRoutes.transactionPinSetup,
                arguments: {'fromLoginFlow': true});
          } else {
            Get.offAllNamed(AppRoutes.dashboard);
          }
        } else if (state is PasscodeLoginInProgress) {
          if (state.errorMessage != null &&
              state.errorMessage != _lastError) {
            _lastError = state.errorMessage;
            // Login blocked because email verification is required + pending →
            // guide to the (public) email-verify screen, which returns to login.
            final lockUntil = parseAccountLockUntil(state.errorMessage);
            if (lockUntil != null) {
              // Account is locked (self-lock or failed-login lockout) → show a
              // blocking countdown modal instead of a wrong-passcode shake.
              showAccountLockedModal(context, lockUntil,
                  selfLock: isSelfLock(state.errorMessage),
                  fraudFreeze: isFraudFreeze(state.errorMessage));
            } else if (state.errorMessage!.toLowerCase().contains('email_not_verified')) {
              Get.toNamed(AppRoutes.emailVerification, arguments: {
                'isRequired': true,
                'codeSent': true,
                'nextRoute': AppRoutes.passcodeLogin,
              });
            } else {
              // Wrong passcode → shake the dots + a heavy haptic, once per error.
              _passcodeShakeKey.currentState?.shake();
              Haptics.error();
            }
          } else if (state.errorMessage == null) {
            _lastError = null;
          }
        }
      },
      builder: (context, state) {
        // Handle non-passcode login states
        if (state is! PasscodeLoginInProgress) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.65)),
              ),
              const Center(child: LazerVaultLoader.small()),
            ],
          );
        }

        final passcodeState = state;
        final enteredPasscode = passcodeState.enteredPasscode;
        final isAuthenticating = passcodeState.isAuthenticating;

        return Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.65)),
            ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: availableHeight,
                  ),
                  child: Column(
                    // OS-lock-screen layout: the identity + passcode dots are
                    // pinned to the TOP, and the keypad + its actions are
                    // anchored to the BOTTOM (the keypad sits low like a system
                    // keyboard). The flexible gap between the two groups is what
                    // visually separates the "who you are" zone from the "enter
                    // your code" zone. On short screens the content grows past
                    // the viewport and the SingleChildScrollView scrolls, so
                    // nothing is ever clipped.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ================= TOP ZONE: identity + dots =================
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            // Smaller top inset so the identity block sits just
                            // below the status bar without crowding it.
                            padding: EdgeInsets.only(top: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Per spec: passcode screen shows the app logo on
                                // a brand-purple halo when no profile picture is
                                // set (NOT initials — we don't want to flash a
                                // stranger's initials before they've signed in).
                                // Compact sign-in avatar inside a styled ring so
                                // it reads as a framed element, not a plain
                                // circle — consistent with the drawer / account /
                                // settings avatars.
                                GestureDetector(
                                  // Tap the profile picture to view it
                                  // full-screen (Hero in; tap/close/swipe to
                                  // animate back). Only when a real avatar is
                                  // set — no-op for the logo.
                                  onTap:
                                      _hasAvatar ? _openAvatarFullScreen : null,
                                  child: Hero(
                                    tag: 'passcode-avatar',
                                    child: Container(
                                      padding: EdgeInsets.all(3.r),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white.withValues(alpha: 0.35),
                                            const Color(0xFF4834D4)
                                                .withValues(alpha: 0.5),
                                          ],
                                        ),
                                        border: Border.all(
                                          color:
                                              Colors.white.withValues(alpha: 0.3),
                                          width: 2,
                                        ),
                                      ),
                                      child: UserAvatar(
                                        size: 52.r,
                                        imageUrl: _storedAvatarUrl,
                                        firstName: _storedFirstName,
                                        lastName: _storedLastName,
                                        fallbackMode: UserAvatarFallback.appLogo,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  displayName,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Enter your Passcode',
                            textAlign: TextAlign.center,
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          SizedBox(height: 28.h),
                          ShakeWidget(
                            key: _passcodeShakeKey,
                            child: PasscodeDots(
                              length: _passcodeLength,
                              filled: enteredPasscode.length,
                            ),
                          ),
                        ],
                      ),

                      // =========== BOTTOM ZONE: keypad + actions ===========
                      // Kept together at the bottom so the keypad reads as the
                      // primary, always-at-the-bottom input surface.
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PasscodeKeypad(
                            onDigit: _onNumberPressed,
                            onBackspace: _onBackspacePressed,
                            disabled: isAuthenticating,
                          ),
                          SizedBox(height: 16.h),
                          // "Forgot passcode" (left) and "Switch user" (right)
                          // flank the keypad's edges — secondary actions that
                          // belong to the keypad, aligned under its outer
                          // columns like an OS lock screen's corner actions.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: _buildFlankAction(
                                  text: 'Forgot your passcode?',
                                  onPressed: isAuthenticating
                                      ? null
                                      : _onForgotPasscode,
                                  align: TextAlign.left,
                                  isAuthenticating: isAuthenticating,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Flexible(
                                child: _buildFlankAction(
                                  text: _isPasswordless
                                      ? 'Switch user'
                                      : 'Use email/password',
                                  onPressed: isAuthenticating
                                      ? null
                                      : _switchToAlternateLogin,
                                  align: TextAlign.right,
                                  isAuthenticating: isAuthenticating,
                                  emphasized: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          // Alternate auth (biometrics + voice), dropped to the
                          // lower part of the screen — or the submit loader in
                          // its place while a passcode is being verified.
                          isAuthenticating
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.h),
                                  child: const Center(
                                      child: LazerVaultLoader.small()),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if ((_canCheckBiometrics &&
                                            _availableBiometricType != null) ||
                                        (Platform.isAndroid &&
                                            _canEnrollBiometric))
                                      _buildIconButton(
                                        icon: _biometricIcon,
                                        onPressed: _onBiometricPressed,
                                        iconColor: Colors.white,
                                        colorScheme: colorScheme,
                                        tooltip: _biometricTooltip,
                                      ),
                                    if ((_canCheckBiometrics &&
                                            _availableBiometricType != null) ||
                                        (Platform.isAndroid &&
                                            _canEnrollBiometric))
                                      SizedBox(width: 24.w),
                                    _buildIconButton(
                                      icon: Icons.mic_none_outlined,
                                      onPressed: _onVoicePressed,
                                      iconColor: Colors.white,
                                      colorScheme: colorScheme,
                                      tooltip: 'Voice login',
                                    ),
                                  ],
                                ),
                          SizedBox(height: 14.h),
                          // Sign up — the very bottom action.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              TextButton(
                                onPressed: isAuthenticating
                                    ? null
                                    : () =>
                                        Get.offAllNamed(AppRoutes.signupEntry),
                                // Shrink the tap padding so "Sign Up" sits inline
                                // with the question text instead of floating high.
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 4.h),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color:
                                        isAuthenticating ? Colors.grey : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Bottom breathing room so the signup row clears the
                          // device gesture bar / screen edge (outer SafeArea
                          // already accounts for the system inset).
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ],
        );
      },
    );
  }

  /// A compact secondary action that flanks an edge of the keypad ("Forgot
  /// your passcode?" left, "Switch user" right). Hugs its outer edge, shrinks
  /// its tap padding so it aligns under the keypad's outer column, and
  /// ellipsizes rather than overflowing the row on narrow screens.
  Widget _buildFlankAction({
    required String text,
    required VoidCallback? onPressed,
    required TextAlign align,
    required bool isAuthenticating,
    bool emphasized = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: align == TextAlign.left
            ? Alignment.centerLeft
            : Alignment.centerRight,
      ),
      child: Text(
        text,
        textAlign: align,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodySmall?.copyWith(
          fontSize: 13.sp,
          color: isAuthenticating
              ? Colors.white.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: emphasized ? 0.95 : 0.8),
          fontWeight: emphasized ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required ColorScheme colorScheme,
    required Color iconColor,
    String? tooltip,
  }) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      iconSize: 30.sp,
      color: onPressed == null ? Colors.grey : iconColor,
      onPressed: onPressed,
      splashRadius: 28.r,
    );
  }
}
