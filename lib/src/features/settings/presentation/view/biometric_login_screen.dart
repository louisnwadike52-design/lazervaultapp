import 'package:lazervault/core/shared_widgets/face_id_icon.dart';
import 'package:lazervault/core/shared_widgets/fingerprint_icon.dart';
import 'package:lazervault/src/features/widgets/oauth_sign_in_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/biometric_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_screen.dart';

/// Settings → Security → Biometric Login.
///
/// Enable signing in with fingerprint, Face ID, or voice. Fingerprint/Face are
/// device-local gates that unlock the cached session (refresh token) — so they
/// require having logged in once on this device. Voice login uses the voice-
/// biometrics enrollment. Each method's opt-in is persisted in secure storage
/// and read by the passcode/login screen to show the matching unlock options.
class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen>
    with WidgetsBindingObserver {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _primary = Color(0xFF3B82F6);

  final BiometricService _bio = BiometricService();
  final SecureStorageService _store = serviceLocator<SecureStorageService>();
  final FlutterSecureStorage _raw = serviceLocator<FlutterSecureStorage>();

  bool _loading = true;
  BiometricStatus _status = const BiometricStatus(BiometricAvailability.unavailable);
  bool _fingerprintOn = false;
  bool _faceOn = false;
  bool _voiceOn = false;
  bool _googleOn = true;
  bool _appleOn = true;
  /// Fire the OS prompt as the lock screen appears, or wait for a tap —
  /// answered separately per method, since a device can offer both.
  bool _autoPromptFace = true;
  bool _autoPromptFingerprint = true;
  /// Shake twice on the lock screen to leave automatic mode. One switch for
  /// both methods: it is a property of automatic mode, not of a modality.
  bool _shakeEscape = true;
  /// Swipe up on the lock screen to offer the biometric.
  bool _swipeUp = true;
  /// Whether each tile's unlock-mode body is open. Starts open so turning a
  /// biometric on reveals the choice that comes with it rather than hiding it
  /// behind a chevron nobody looks for.
  bool _faceExpanded = true;
  bool _fingerprintExpanded = true;

  bool get _fingerprintAvailable => _status.isAvailable && _status.hasFingerprint;
  bool get _faceAvailable => _status.isAvailable && _status.hasFace;
  // Hardware present but nothing enrolled — offer to open OS enrollment.
  bool get _canEnroll => _status.canEnroll;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bootstrap();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-read after returning from the OS enrollment screen so a just-added
    // fingerprint/face flips the tiles from "Set up" to a live toggle.
    if (state == AppLifecycleState.resumed) _bootstrap(silent: true);
  }

  Future<void> _bootstrap({bool silent = false}) async {
    if (!silent && mounted) setState(() => _loading = true);
    _status = await _bio.status();
    _fingerprintOn = await _store.getFingerprintLoginEnabled();
    _faceOn = await _store.getFaceLoginEnabled();
    _voiceOn = await _store.getVoiceLoginEnabled();
    _googleOn = await _store.getGoogleLoginEnabled();
    _appleOn = await _store.getAppleLoginEnabled();
    _autoPromptFace = await _store.getBiometricAutoPrompt(isFace: true);
    _autoPromptFingerprint = await _store.getBiometricAutoPrompt(isFace: false);
    _shakeEscape = await _store.getBiometricShakeEscape();
    _swipeUp = await _store.getBiometricSwipeUp();
    // If a biometric was removed at the OS level, drop the stale opt-in so we
    // never show an "on" toggle the OS can no longer satisfy.
    if (!_status.isAvailable) {
      if (_fingerprintOn) {
        _fingerprintOn = false;
        await _store.setFingerprintLoginEnabled(false);
      }
      if (_faceOn) {
        _faceOn = false;
        await _store.setFaceLoginEnabled(false);
      }
      // The OS biometric was removed → the durable token can no longer be used;
      // drop it so no orphaned refresh token lingers in secure storage.
      await _store.clearBiometricSession();
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _openEnrollment() async {
    final opened = await _bio.openOsEnrollment();
    if (!opened && mounted) {
      _snack('Open your device settings to add a fingerprint or face.',
          error: true);
    }
    // didChangeAppLifecycleState refreshes when the user returns.
  }

  Future<bool> _hasCachedSession() async {
    final t = await _raw.read(key: 'refresh_token');
    return t != null && t.isNotEmpty;
  }

  void _snack(String msg, {bool error = false}) {
    Get.snackbar(
      error ? 'Biometric Login' : 'Biometric Login',
      msg,
      backgroundColor: error ? const Color(0xFFEF4444) : _card,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(12.w),
    );
  }

  bool _toggleInProgress = false; // guards against re-entrant toggle taps

  Future<void> _toggleDeviceBiometric({
    required bool isFace,
    required bool turnOn,
  }) async {
    if (_toggleInProgress) return;
    _toggleInProgress = true;
    try {
      await _toggleDeviceBiometricInner(isFace: isFace, turnOn: turnOn);
    } finally {
      _toggleInProgress = false;
    }
  }

  Future<void> _toggleDeviceBiometricInner({
    required bool isFace,
    required bool turnOn,
  }) async {
    final label = isFace ? 'Face ID' : 'Fingerprint';
    if (!turnOn) {
      if (isFace) {
        _faceOn = false;
        await _store.setFaceLoginEnabled(false);
      } else {
        _fingerprintOn = false;
        await _store.setFingerprintLoginEnabled(false);
      }
      // With no biometric method left on, drop the durable biometric session so
      // a fingerprint can no longer re-mint a login the user turned off.
      if (!_fingerprintOn && !_faceOn) {
        await _store.clearBiometricSession();
      }
      setState(() {});
      return;
    }

    // Enabling requires a cached session to unlock, then a successful biometric.
    if (!await _hasCachedSession()) {
      _snack('Sign in with your passcode first, then enable $label.',
          error: true);
      return;
    }

    // Confirm with the NATIVE OS prompt directly (no wrapper sheet). Only flip
    // the opt-in on a real match.
    final reason = isFace
        ? 'Confirm with Face ID to enable Face ID login'
        : 'Confirm with your fingerprint to enable fingerprint login';
    final result = await _bio.authenticate(reason: reason);
    if (!mounted) return;
    switch (result.outcome) {
      case BiometricAuthOutcome.success:
        break; // matched → enable below
      case BiometricAuthOutcome.notEnrolled:
      case BiometricAuthOutcome.passcodeNotSet:
        // Race: OS enrollment / screen lock removed between detection and prompt.
        _snack('No $label is set up. Add one in your device settings first.',
            error: true);
        await _bootstrap(silent: true);
        await _openEnrollment();
        return;
      case BiometricAuthOutcome.failed:
        return; // cancelled / didn't match — leave the toggle off
      case BiometricAuthOutcome.lockedOut:
      case BiometricAuthOutcome.permanentlyLockedOut:
      case BiometricAuthOutcome.notAvailable:
      case BiometricAuthOutcome.error:
        _snack(
            BiometricService.messageFor(result, label: label.toLowerCase()) ??
                'Could not enable $label.',
            error: true);
        return;
    }
    if (isFace) {
      _faceOn = true;
      await _store.setFaceLoginEnabled(true);
      // Reveal the unlock-mode options with the toggle that unlocks them —
      // that choice arrives WITH the method, so a body the user collapsed on
      // a previous visit must not hide it the next time they switch it on.
      _faceExpanded = true;
    } else {
      _fingerprintOn = true;
      await _store.setFingerprintLoginEnabled(true);
      _fingerprintExpanded = true;
    }
    // No durable token to arm: biometric unlock re-mints from the single
    // `refresh_token` already in storage (rotating it one-time-use). Enabling is
    // purely the per-method opt-in flag.
    if (mounted) setState(() {});
    _snack('$label login enabled.');
  }

  Future<void> _toggleGoogle(bool turnOn) async {
    _googleOn = turnOn;
    await _store.setGoogleLoginEnabled(turnOn);
    if (mounted) setState(() {});
    _snack(turnOn
        ? 'Google sign-in shown on your login screens.'
        : 'Google sign-in hidden.');
  }

  Future<void> _toggleApple(bool turnOn) async {
    _appleOn = turnOn;
    await _store.setAppleLoginEnabled(turnOn);
    if (mounted) setState(() {});
    _snack(turnOn
        ? 'Apple sign-in shown on your login screens.'
        : 'Apple sign-in hidden.');
  }

  Future<void> _toggleVoice(bool turnOn) async {
    // Resolve from the CURRENT session (access-token sub), never the possibly
    // stale cached user_id key — so enabling voice login always binds to the
    // account signed in right now, not a previously-signed-in one.
    final userId = (await _store.getCurrentUserId()) ?? '';
    if (!turnOn) {
      _voiceOn = false;
      // Turning the login preference off does NOT delete the server voiceprint
      // (the user may still want it for voice-agent recognition); it only stops
      // OFFERING voice at sign-in.
      await _store.setVoiceLoginEnabled(false);
      setState(() {});
      return;
    }
    if (!mounted) return;
    // Run (or re-run) voice enrollment; only flip the flag on success.
    // VoiceEnrollmentScreen reads VoiceEnrollmentCubit from context, so it must
    // be pushed UNDER its provider — otherwise it throws ProviderNotFound.
    await Get.to(() => BlocProvider<VoiceEnrollmentCubit>(
          create: (_) => serviceLocator<VoiceEnrollmentCubit>(),
          child: VoiceEnrollmentScreen(
            userId: userId,
            onEnrollmentComplete: () async {
              _voiceOn = true;
              // Single sync point: enables the login pref AND invalidates the
              // shared enrollment-status cache, so the voice-agent path sees the
              // new voiceprint immediately (consolidated with the agent flow).
              await VoiceActivationManager.markVoiceEnrolled(userId);
              if (mounted) setState(() {});
            },
          ),
        ));
    // Reflect any state set by the callback.
    _voiceOn = await _store.getVoiceLoginEnabled();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Biometric Login',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _primary))
          : ListView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              children: [
                Text('Sign in faster',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6.h),
                Text(
                  'Use your fingerprint, face, or voice to unlock Lazervault. '
                  'Fingerprint and Face ID work after you’ve signed in once on '
                  'this device.',
                  style: GoogleFonts.inter(
                      color: _textSecondary, fontSize: 12.sp, height: 1.4),
                ),
                if (_canEnroll) ...[
                  SizedBox(height: 16.h),
                  _enrollBanner(),
                ],
                SizedBox(height: 20.h),
                _tile(
                  icon: Icons.fingerprint,
                  iconBuilder: (c) => FingerprintIcon(size: 22.sp, color: c),
                  title: 'Fingerprint',
                  subtitle: _fingerprintAvailable
                      ? 'Unlock with your fingerprint'
                      : _canEnroll
                          ? 'No fingerprint set up on this device yet'
                          : 'Not available on this device',
                  enabled: _fingerprintAvailable,
                  value: _fingerprintOn,
                  onChanged: (v) =>
                      _toggleDeviceBiometric(isFace: false, turnOn: v),
                  onSetup: _canEnroll ? _openEnrollment : null,
                  expansion: _unlockModeSelector(isFace: false),
                  expanded: _fingerprintExpanded,
                  onToggleExpand: () => setState(
                      () => _fingerprintExpanded = !_fingerprintExpanded),
                ),
                _tile(
                  icon: Icons.face_outlined,
                  iconBuilder: (c) => FaceIdIcon(size: 22.sp, color: c),
                  title: 'Face ID',
                  subtitle: _faceAvailable
                      ? 'Unlock with face recognition'
                      : _canEnroll
                          ? 'No face set up on this device yet'
                          : 'Not available on this device',
                  enabled: _faceAvailable,
                  value: _faceOn,
                  onChanged: (v) =>
                      _toggleDeviceBiometric(isFace: true, turnOn: v),
                  onSetup: _canEnroll ? _openEnrollment : null,
                  // Lives INSIDE the Face ID tile now. It used to float below
                  // both toggles as a loose block, which read as a separate
                  // setting rather than part of the one that enables it.
                  expansion: _unlockModeSelector(isFace: true),
                  expanded: _faceExpanded,
                  onToggleExpand: () =>
                      setState(() => _faceExpanded = !_faceExpanded),
                ),
                _tile(
                  icon: Icons.record_voice_over_outlined,
                  title: 'Voice',
                  subtitle: _voiceOn
                      ? 'Voice login enabled. Re-enroll anytime'
                      : 'Unlock with your voice (enrollment required)',
                  enabled: true,
                  value: _voiceOn,
                  onChanged: _toggleVoice,
                ),
                // ── Google / Apple sign-in ─────────────────────────────
                // Entry-point toggles, not security gates: the server
                // verifies every provider token regardless. Off simply
                // hides the buttons on the lock and sign-in screens.
                SizedBox(height: 22.h),
                Text('Sign-in methods',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(
                  'Show or hide Google and Apple sign-in on your login screens.',
                  style: GoogleFonts.inter(
                      color: _textSecondary, fontSize: 12.sp, height: 1.4),
                ),
                SizedBox(height: 12.h),
                if (OAuthProviders.googleAvailable)
                  _tile(
                    icon: Icons.g_mobiledata_rounded,
                    iconBuilder: (c) => GoogleGIcon(size: 20.sp),
                    title: 'Google sign-in',
                    subtitle: _googleOn
                        ? 'Shown on your login screens'
                        : 'Hidden from your login screens',
                    enabled: true,
                    value: _googleOn,
                    onChanged: _toggleGoogle,
                  ),
                if (OAuthProviders.appleAvailable)
                  _tile(
                    icon: Icons.apple,
                    title: 'Apple sign-in',
                    subtitle: _appleOn
                        ? 'Shown on your login screens'
                        : 'Hidden from your login screens',
                    enabled: true,
                    value: _appleOn,
                    onChanged: _toggleApple,
                  ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 14.sp, color: const Color(0xFF9CA3AF)),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'Only methods your device supports can be turned on. '
                          'Options with no sensor — or none enrolled in your phone '
                          'settings — appear greyed out and are not switchable.',
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  /// Prominent call-to-action when the device has a biometric sensor but the
  /// user hasn't enrolled anything — take them straight to the OS enrollment.
  Widget _enrollBanner() {
    return InkWell(
      onTap: _openEnrollment,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Icon(Icons.settings_suggest_outlined, color: _primary, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set up fingerprint or Face ID',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 3.h),
                  Text(
                    'No biometric is set up on this device yet. Add one in your '
                    'device settings, then come back to switch it on here.',
                    style: GoogleFonts.inter(
                        color: _textSecondary, fontSize: 11.sp, height: 1.35),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.chevron_right, color: _primary, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _setAutoPrompt(bool v, {required bool isFace}) async {
    setState(() {
      if (isFace) {
        _autoPromptFace = v;
      } else {
        _autoPromptFingerprint = v;
      }
    });
    await _store.setBiometricAutoPrompt(v, isFace: isFace);
  }

  Future<void> _setShakeEscape(bool v) async {
    setState(() => _shakeEscape = v);
    await _store.setBiometricShakeEscape(v);
  }

  Future<void> _setSwipeUp(bool v) async {
    setState(() => _swipeUp = v);
    await _store.setBiometricSwipeUp(v);
  }

  /// How the unlock biometric fires. Kept inside the toggle that enables it,
  /// because "Face ID is on" and "Face ID opens by itself" are different
  /// decisions and the second is the one people notice.
  Widget _unlockModeSelector({required bool isFace}) {
    final auto = isFace ? _autoPromptFace : _autoPromptFingerprint;
    final noun = isFace ? 'Face ID' : 'your fingerprint';
    Widget option({
      required bool selected,
      required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
    }) =>
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFA78BFA).withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFA78BFA).withValues(alpha: 0.5)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(icon,
                        size: 16.sp,
                        color: selected
                            ? const Color(0xFFA78BFA)
                            : _textSecondary),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(title,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ]),
                  SizedBox(height: 4.h),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          color: _textSecondary,
                          fontSize: 11.sp,
                          height: 1.35)),
                ],
              ),
            ),
          ),
        );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('WHEN TO ASK',
              style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8)),
          SizedBox(height: 8.h),
          Row(children: [
            option(
              selected: !auto,
              icon: Icons.touch_app_outlined,
              title: 'When I tap',
              subtitle: 'Open the lock screen first, then unlock with $noun '
                  'by tapping the button.',
              onTap: () => _setAutoPrompt(false, isFace: isFace),
            ),
            SizedBox(width: 10.w),
            option(
              selected: auto,
              icon: Icons.bolt_outlined,
              title: 'Automatically',
              subtitle: 'Ask as soon as the lock screen opens.',
              onTap: () => _setAutoPrompt(true, isFace: isFace),
            ),
          ]),
          // NOT gated on the mode above. A swipe is an explicit request, so it
          // stays available to someone on "When I tap" — that setting exists to
          // stop the prompt opening BY ITSELF, not to stop them asking for it.
          _swipeUpRow(isFace: isFace),
          // Only meaningful in automatic mode — there is nothing to escape
          // from when the prompt already waits for a tap.
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: _shakeEscapeRow(),
            crossFadeState:
                auto ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeOut,
          ),
        ],
      ),
    );
  }

  /// Swipe up on the lock screen to unlock. The OS lock screen trained
  /// everyone to swipe up, so people try it here regardless — this makes the
  /// attempt do the obvious thing instead of nothing.
  Widget _swipeUpRow({required bool isFace}) {
    final noun = isFace ? 'Face ID' : 'your fingerprint';
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.swipe_up_rounded, size: 16.sp, color: _textSecondary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Swipe up to unlock',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 3.h),
                Text(
                  _swipeUp
                      ? 'Swipe up on the lock screen to unlock with $noun. '
                          'Works whichever option you picked above.'
                      : 'Off. Unlock with the button on the lock screen.',
                  style: GoogleFonts.inter(
                      color: _textSecondary, fontSize: 11.sp, height: 1.35),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Switch(
            value: _swipeUp,
            activeThumbColor: Colors.white,
            activeTrackColor: _primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: _divider,
            onChanged: _setSwipeUp,
          ),
        ],
      ),
    );
  }

  /// The way out of automatic mode that does not require getting past the lock
  /// screen first. Presented here, under the option it qualifies, because it
  /// only makes sense as a property of "Automatically".
  Widget _shakeEscapeRow() {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.vibration, size: 16.sp, color: _textSecondary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shake twice to stop it',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 3.h),
                Text(
                  _shakeEscape
                      ? 'On the lock screen, shake your phone twice to switch '
                          'to “When I tap”. Useful when your face will not '
                          'verify and you just want the keypad.'
                      : 'Off. If automatic unlock ever traps you, you will '
                          'need to sign in before you can change it here.',
                  style: GoogleFonts.inter(
                      color: _textSecondary, fontSize: 11.sp, height: 1.35),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Switch(
            value: _shakeEscape,
            activeThumbColor: Colors.white,
            activeTrackColor: _primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: _divider,
            onChanged: _setShakeEscape,
          ),
        ],
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    /// Prebuilt glyph for icons Material has no good version of (Face ID).
    /// Receives the resolved colour, since a painted child cannot inherit it.
    Widget Function(Color color)? iconBuilder,
    required String title,
    required String subtitle,
    required bool enabled,
    required bool value,
    required ValueChanged<bool> onChanged,
    VoidCallback? onSetup,

    /// Settings that only exist because this toggle is on — revealed inside
    /// the tile rather than floated beside it, so the dependency is obvious
    /// and turning the toggle off takes them away with it.
    Widget? expansion,
    bool expanded = false,
    VoidCallback? onToggleExpand,
  }) {
    // The body is only reachable when the toggle is actually on; a disabled or
    // off tile has nothing to expand.
    final hasExpansion = expansion != null && enabled && value;
    // In "set up" mode (hardware present, nothing enrolled) the tile is active
    // and its trailing control is a Set-up button that deep-links to the OS.
    final active = enabled || onSetup != null;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _divider),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: ((enabled && value) || onSetup != null
                      ? _primary
                      : _textSecondary)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Builder(builder: (_) {
              final c = (enabled && value) || onSetup != null
                  ? _primary
                  : _textSecondary;
              return iconBuilder?.call(c) ?? Icon(icon, color: c, size: 22.sp);
            }),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: active ? Colors.white : _textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        color: _textSecondary, fontSize: 11.sp, height: 1.35)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (onSetup != null)
            TextButton(
              onPressed: onSetup,
              style: TextButton.styleFrom(
                foregroundColor: _primary,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Set up',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w700)),
            )
          else
            Switch(
              value: value,
              activeThumbColor: Colors.white,
              activeTrackColor: _primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: _divider,
              onChanged: enabled ? onChanged : null,
            ),
          // Chevron only when there is a body to open, so a plain tile does
          // not grow an affordance that does nothing.
          if (hasExpansion)
            GestureDetector(
              onTap: onToggleExpand,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: AnimatedRotation(
                  turns: expanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      color: _primary, size: 22.sp),
                ),
              ),
            ),
        ],
      ),
          // Same 200ms crossfade the settings accordions use. Collapsing to a
          // zero-height first child keeps the tile's padding from reserving
          // space for a body that is not there.
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: hasExpansion
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 12.h),
                      Divider(height: 1, thickness: 1, color: _divider),
                      expansion,
                    ],
                  )
                : const SizedBox(width: double.infinity, height: 0),
            crossFadeState: hasExpansion && expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeOut,
          ),
        ],
      ),
    );
  }
}
