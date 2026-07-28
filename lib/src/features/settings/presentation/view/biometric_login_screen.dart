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
    } else {
      _fingerprintOn = true;
      await _store.setFingerprintLoginEnabled(true);
    }
    // No durable token to arm: biometric unlock re-mints from the single
    // `refresh_token` already in storage (rotating it one-time-use). Enabling is
    // purely the per-method opt-in flag.
    if (mounted) setState(() {});
    _snack('$label login enabled.');
  }

  Future<void> _toggleVoice(bool turnOn) async {
    final userId = (await _store.getUserId()) ?? '';
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
                ),
                _tile(
                  icon: Icons.face_outlined,
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

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool enabled,
    required bool value,
    required ValueChanged<bool> onChanged,
    VoidCallback? onSetup,
  }) {
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
      child: Row(
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
            child: Icon(icon,
                color: (enabled && value) || onSetup != null
                    ? _primary
                    : _textSecondary,
                size: 22.sp),
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
        ],
      ),
    );
  }
}
