import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

import 'package:lazervault/core/services/injection_container.dart';
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

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _primary = Color(0xFF3B82F6);

  final LocalAuthentication _localAuth = LocalAuthentication();
  final SecureStorageService _store = serviceLocator<SecureStorageService>();
  final FlutterSecureStorage _raw = serviceLocator<FlutterSecureStorage>();

  bool _loading = true;
  bool _fingerprintAvailable = false;
  bool _faceAvailable = false;
  bool _fingerprintOn = false;
  bool _faceOn = false;
  bool _voiceOn = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final types =
          canCheck ? await _localAuth.getAvailableBiometrics() : <BiometricType>[];
      _faceAvailable = types.contains(BiometricType.face);
      _fingerprintAvailable = types.contains(BiometricType.fingerprint) ||
          types.contains(BiometricType.strong) ||
          types.contains(BiometricType.weak);
    } catch (_) {
      _fingerprintAvailable = false;
      _faceAvailable = false;
    }
    _fingerprintOn = await _store.getFingerprintLoginEnabled();
    _faceOn = await _store.getFaceLoginEnabled();
    _voiceOn = await _store.getVoiceLoginEnabled();
    if (mounted) setState(() => _loading = false);
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

  Future<void> _toggleDeviceBiometric({
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
      setState(() {});
      return;
    }

    // Enabling requires a cached session to unlock, then a successful biometric.
    if (!await _hasCachedSession()) {
      _snack('Log in with your passcode first, then enable $label.',
          error: true);
      return;
    }
    try {
      final ok = await _localAuth.authenticate(
        localizedReason: 'Confirm your $label to enable $label login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (!ok) return;
    } on PlatformException {
      _snack('Could not verify $label. Try again.', error: true);
      return;
    }
    if (isFace) {
      _faceOn = true;
      await _store.setFaceLoginEnabled(true);
    } else {
      _fingerprintOn = true;
      await _store.setFingerprintLoginEnabled(true);
    }
    if (mounted) setState(() {});
    _snack('$label login enabled.');
  }

  Future<void> _toggleVoice(bool turnOn) async {
    if (!turnOn) {
      _voiceOn = false;
      await _store.setVoiceLoginEnabled(false);
      setState(() {});
      return;
    }
    final userId = await _store.getUserId();
    if (!mounted) return;
    // Run (or re-run) voice enrollment; only flip the flag on success.
    await Get.to(() => VoiceEnrollmentScreen(
          userId: userId,
          onEnrollmentComplete: () async {
            _voiceOn = true;
            await _store.setVoiceLoginEnabled(true);
            if (mounted) setState(() {});
          },
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
                SizedBox(height: 20.h),
                _tile(
                  icon: Icons.fingerprint,
                  title: 'Fingerprint',
                  subtitle: _fingerprintAvailable
                      ? 'Unlock with your fingerprint'
                      : 'Not available on this device',
                  enabled: _fingerprintAvailable,
                  value: _fingerprintOn,
                  onChanged: (v) =>
                      _toggleDeviceBiometric(isFace: false, turnOn: v),
                ),
                _tile(
                  icon: Icons.face_outlined,
                  title: 'Face ID',
                  subtitle: _faceAvailable
                      ? 'Unlock with face recognition'
                      : 'Not available on this device',
                  enabled: _faceAvailable,
                  value: _faceOn,
                  onChanged: (v) =>
                      _toggleDeviceBiometric(isFace: true, turnOn: v),
                ),
                _tile(
                  icon: Icons.record_voice_over_outlined,
                  title: 'Voice',
                  subtitle: _voiceOn
                      ? 'Voice login enabled — re-enroll anytime'
                      : 'Unlock with your voice (enrollment required)',
                  enabled: true,
                  value: _voiceOn,
                  onChanged: _toggleVoice,
                ),
              ],
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
  }) {
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
              color: (enabled && value ? _primary : _textSecondary)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon,
                color: enabled && value ? _primary : _textSecondary,
                size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: enabled ? Colors.white : _textSecondary,
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
