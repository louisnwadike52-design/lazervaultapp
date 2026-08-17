import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/src/features/app_status/widgets/maintenance_screen.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_carousel_screen.dart';
part 'voice_activation_manager_widgets.dart';


/// Voice Activation Manager
/// Orchestrates voice enrollment flow.
/// Verification happens automatically in the background during voice sessions.
class VoiceActivationManager {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();

  /// Short-lived enrollment-status cache, shared across instances (this
  /// manager is constructed fresh at each call site). Every voice button tap
  /// would otherwise re-hit the biometrics service. Keyed by userId; only
  /// genuine fetch results are cached (never the error fallback), and the
  /// entry is invalidated the moment enrollment completes or is reset.
  static const Duration _enrollmentTtl = Duration(seconds: 60);
  static final Map<String, _EnrollmentCacheEntry> _enrollmentCache = {};

  /// Drop the cached enrollment status for [userId] (or all users when null)
  /// so the next check re-fetches. Call after enrollment completes or resets.
  static void invalidateEnrollmentCache([String? userId]) {
    if (userId == null) {
      _enrollmentCache.clear();
    } else {
      _enrollmentCache.remove(userId);
    }
  }

  /// SINGLE consolidation point for "a voiceprint now exists for this user".
  /// The server voiceprint (Qdrant) is the source of truth, but the login lock
  /// screen also keeps a device preference (`voice_login_enabled`) for whether
  /// to OFFER voice at sign-in. Any enrollment — whether started from Settings
  /// (login) OR from a voice-agent activation — funnels through here so BOTH
  /// stay in sync: invalidate the status cache AND enable the login preference.
  /// Result: enroll once (from either place) → voice works for both auth + agents.
  static Future<void> markVoiceEnrolled(String userId) async {
    invalidateEnrollmentCache(userId);
    try {
      await GetIt.I<SecureStorageService>().setVoiceLoginEnabled(true);
    } catch (_) {}
  }

  /// Counterpart to [markVoiceEnrolled]: the voiceprint was deleted/reset, so
  /// clear the cache and turn the login preference off (no more stale "enabled"
  /// that would fail at verify).
  static Future<void> markVoiceUnenrolled(String userId) async {
    invalidateEnrollmentCache(userId);
    try {
      await GetIt.I<SecureStorageService>().setVoiceLoginEnabled(false);
    } catch (_) {}
  }

  /// Check if the voice biometrics service is available
  Future<bool> isServiceAvailable() async {
    try {
      return await _voiceService.isServiceAvailable();
    } catch (e) {
      print('VoiceActivationManager: Service unavailable: $e');
      return false;
    }
  }
  /// DEFINITIVE tri-state enrollment check. This is the SINGLE classification
  /// point the mic entry points use so an outage is never mistaken for
  /// "not enrolled".
  ///
  /// Only a real backend answer ([VoiceBiometricsService.checkEnrollmentStatus]
  /// resolves — which happens ONLY for a 200 or a 404) becomes
  /// [VoiceEnrollmentCheck.enrolled]/[notEnrolled] and is cached. Every failure
  /// mode the service throws — [VoiceBiometricsNetworkException] (offline /
  /// timeout / gRPC Unavailable / connection reset), [VoiceBiometricsServerException]
  /// (5xx), or a bare [VoiceBiometricsException] (unexpected 4xx / malformed /
  /// empty body) — and any unforeseen error map to [unavailable] and are NEVER
  /// cached (transient).
  Future<VoiceEnrollmentCheck> checkEnrollmentOutcome(String userId) async {
    final cached = _enrollmentCache[userId];
    if (cached != null && !cached.isExpired) {
      return cached.isEnrolled
          ? VoiceEnrollmentCheck.enrolled
          : VoiceEnrollmentCheck.notEnrolled;
    }
    try {
      final status = await _voiceService.checkEnrollmentStatus(userId);
      print('VoiceActivationManager: Enrollment status for $userId: ${status.isEnrolled}');
      _enrollmentCache[userId] = _EnrollmentCacheEntry(status.isEnrolled);
      return status.isEnrolled
          ? VoiceEnrollmentCheck.enrolled
          : VoiceEnrollmentCheck.notEnrolled;
    } catch (e) {
      // Transport error / 5xx / ambiguous — NOT a confirmed "not enrolled".
      // Report as temporarily unavailable and DO NOT cache.
      print('VoiceActivationManager: Enrollment check unavailable (transient): $e');
      return VoiceEnrollmentCheck.unavailable;
    }
  }

  /// Check if user has enrolled voice. Kept for existing callers that only need
  /// a bool; it now delegates to [checkEnrollmentOutcome] so behaviour stays
  /// identical (an [unavailable] outcome still reads as `false` for these older
  /// call sites). New mic entry points use [checkEnrollmentOutcome] directly so
  /// they can distinguish an outage from a genuine not-enrolled answer.
  Future<bool> isVoiceEnrolled(String userId) async {
    final outcome = await checkEnrollmentOutcome(userId);
    return outcome == VoiceEnrollmentCheck.enrolled;
  }

  /// Show the shared "temporarily unavailable" modal for the voice assistant,
  /// reusing the backend-maintenance [MaintenanceModal] component + styling for
  /// visual consistency. Returns `true` if the user tapped Try again (the
  /// caller should re-run the flow), `false` if they dismissed it.
  static Future<bool> showVoiceUnavailableModal(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent, // the modal draws its own scrim
      builder: (dialogContext) => MaintenanceModal(
        icon: Icons.mic_off_rounded,
        title: 'Voice is temporarily unavailable',
        message:
            'We couldn\'t reach the voice assistant just now. Your account and '
            'money are safe — please try again in a moment.',
        retryLabel: 'Try again',
        onRetry: () async => Navigator.of(dialogContext).pop(true),
        onClose: () => Navigator.of(dialogContext).pop(false),
      ),
    );
    return result ?? false;
  }

  /// Activate voice features - check enrollment and prompt if needed.
  /// Returns true if enrolled, false if enrollment is required.
  ///
  /// Note: Voice verification now happens automatically in the background
  /// during voice sessions via the voice-agent-gateway. The user will only
  /// be notified if verification fails.
  Future<bool> activateVoice(
    BuildContext context,
    String userId, {
    VoidCallback? onSuccess,
  }) async {
    // Check enrollment status
    final isEnrolled = await isVoiceEnrolled(userId);

    if (!isEnrolled) {
      if (!context.mounted) return false;
      // User needs to enroll first — awaits dialog + enrollment flow
      return await _showEnrollmentPrompt(context, userId, onSuccess);
    }

    // User is enrolled - verification will happen in background during session
    if (onSuccess != null) onSuccess();
    return true;
  }

  /// Show enrollment prompt with explanation.
  /// Returns true if user completed enrollment, false if cancelled or backed out.
  Future<bool> _showEnrollmentPrompt(
    BuildContext context,
    String userId,
    VoidCallback? onEnrollmentSuccess,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.mic_rounded, color: InvoiceThemeColors.primaryPurple, size: 24),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Voice Activation',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set up voice commands for secure, hands-free banking.',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.h),
            _buildFeatureRow(Icons.shield_rounded, 'Verify your identity by voice'),
            SizedBox(height: 10.h),
            _buildFeatureRow(Icons.send_rounded, 'Send money with voice commands'),
            SizedBox(height: 10.h),
            _buildFeatureRow(Icons.account_balance_wallet_rounded, 'Check balances hands-free'),
            SizedBox(height: 10.h),
            _buildFeatureRow(Icons.receipt_long_rounded, 'Pay bills and manage investments'),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, color: Color(0xFF9CA3AF), size: 16),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Takes less than a minute — just 3 voice samples.',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Later',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            icon: const Icon(Icons.mic_rounded, size: 18),
            label: Text(
              'Activate Now',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ],
      ),
    );

    // User pressed "Later" or dialog was dismissed
    if (result != true || !context.mounted) {
      return false;
    }

    // Track whether enrollment actually completed via the callback
    bool enrollmentCompleted = false;

    // Navigate to enrollment screen and await it closing
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => GetIt.I<VoiceEnrollmentCubit>(),
          child: VoiceEnrollmentCarouselScreen(
            userId: userId,
            onEnrollmentComplete: () {
              enrollmentCompleted = true;
              // Enrolled via the voice-agent path → sync BOTH the status cache
              // and the login preference so voice login also works now.
              markVoiceEnrolled(userId);
              // NOTE: do NOT pop here. Every carousel completion path already
              // pops itself (success X / done-false) or clears the stack
              // (done-true via offAllNamed). Popping again double-pops and
              // removes the launcher screen underneath.
              if (onEnrollmentSuccess != null) {
                onEnrollmentSuccess();
              }
            },
          ),
        ),
      ),
    );

    // User may have backed out without completing enrollment
    return enrollmentCompleted;
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: InvoiceThemeColors.primaryPurple, size: 18),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  /// Quick check enrollment without prompting
  /// Use this for showing enrollment status in UI
  Future<VoiceEnrollmentStatus?> getEnrollmentStatus(String userId) async {
    try {
      return await _voiceService.checkEnrollmentStatus(userId);
    } catch (e) {
      return null;
    }
  }

  /// Re-enroll user (delete existing enrollment and start fresh)
  Future<bool> reEnroll(BuildContext context, String userId) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Re-activate Voice?'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This will delete your existing voice profile and you will need to record new voice samples.',
            ),
            SizedBox(height: 12),
            Text(
              'Reasons to re-activate:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: 'Voice verification keeps failing'),
            BulletPoint(text: 'Your voice has changed significantly'),
            BulletPoint(text: 'You want to improve recognition accuracy'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Re-activate'),
          ),
        ],
      ),
    );

    if (confirmed != true) return false;

    // Delete existing enrollment
    try {
      await _voiceService.deleteVoiceEnrollment(userId);
    } catch (e) {
      // Ignore error, continue to enrollment
    }
    // Voiceprint removed — clear cache AND the login preference (kept in sync).
    await markVoiceUnenrolled(userId);

    // Navigate to enrollment screen
    if (context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => GetIt.I<VoiceEnrollmentCubit>(),
            child: VoiceEnrollmentCarouselScreen(
              userId: userId,
            ),
          ),
        ),
      );
    }

    return true;
  }
}
