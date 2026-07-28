import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Which guidance the dialog gives.
enum BiometricSetupKind {
  /// Hardware present but nothing enrolled (or no device screen lock) — send
  /// the user DOWN to the OS to enrol a fingerprint/face + set a screen lock.
  notEnrolledInOs,

  /// Enrolled in the OS but not switched on for Lazervault — send the user to
  /// the in-app Biometric Login settings.
  notEnabledInApp,
}

/// What the user chose. The caller owns navigation so this widget stays pure
/// (no imports of settings screens / services → no circular deps).
enum BiometricSetupAction { primary, dismiss }

/// A themed modal dialog (NOT a snackbar) that guides the user to finish setting
/// up biometric login — either in the phone's OS settings or in Lazervault's own
/// Biometric Login screen. Replaces the old transient snackbars so the message
/// is clear, dismissible on the user's terms, and paired with an obvious CTA.
class BiometricSetupDialog {
  static const Color _bg = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _primary = Color(0xFF3B82F6);

  /// Shows the dialog and resolves with the user's choice (defaults to
  /// [BiometricSetupAction.dismiss] if dismissed by tapping outside / back).
  static Future<BiometricSetupAction> show(
    BuildContext context, {
    required BiometricSetupKind kind,
    required String label, // 'Fingerprint' | 'Face ID'
  }) async {
    final result = await showDialog<BiometricSetupAction>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (ctx) => _DialogBody(kind: kind, label: label),
    );
    return result ?? BiometricSetupAction.dismiss;
  }
}

class _DialogBody extends StatelessWidget {
  const _DialogBody({required this.kind, required this.label});

  final BiometricSetupKind kind;
  final String label;

  bool get _isOs => kind == BiometricSetupKind.notEnrolledInOs;

  IconData get _icon =>
      _isOs ? Icons.settings_suggest_rounded : Icons.fingerprint;

  String get _title => _isOs
      ? 'Set up $label on your phone first'
      : 'Turn on $label login';

  String get _body => _isOs
      ? 'To sign in with $label, your phone needs a screen lock (PIN, pattern '
          'or password) and at least one $label enrolled. Open your phone '
          "settings to add them, then come back — we'll pick up where you left off."
      : "You've set up $label on this phone. Switch it on in Lazervault to sign "
          'in with it from now on.';

  String get _primaryLabel =>
      _isOs ? 'Open phone settings' : 'Go to biometric settings';

  String get _secondaryLabel => _isOs ? 'Not now' : 'Use passcode';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: BiometricSetupDialog._bg,
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BiometricSetupDialog._primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(_icon,
                  color: BiometricSetupDialog._primary, size: 28.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              _title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              _body,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: BiometricSetupDialog._textSecondary,
                fontSize: 13.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 22.h),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(BiometricSetupAction.primary),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BiometricSetupDialog._primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(_primaryLabel,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 6.h),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(BiometricSetupAction.dismiss),
              style: TextButton.styleFrom(
                foregroundColor: BiometricSetupDialog._textSecondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(_secondaryLabel,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 2.h),
            // Hairline for visual grounding on very small screens.
            Divider(color: BiometricSetupDialog._divider, height: 1, thickness: 0),
          ],
        ),
      ),
    );
  }
}
