import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_carousel_screen.dart';

/// Voice Activation Manager
/// Orchestrates voice enrollment flow.
/// Verification happens automatically in the background during voice sessions.
class VoiceActivationManager {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();

  /// Check if the voice biometrics service is available
  Future<bool> isServiceAvailable() async {
    try {
      return await _voiceService.isServiceAvailable();
    } catch (e) {
      print('VoiceActivationManager: Service unavailable: $e');
      return false;
    }
  }
  /// Check if user has enrolled voice
  Future<bool> isVoiceEnrolled(String userId) async {
    try {
      final status = await _voiceService.checkEnrollmentStatus(userId);
      print('VoiceActivationManager: Enrollment status for $userId: ${status.isEnrolled}');
      return status.isEnrolled;
    } catch (e) {
      // Log the error for debugging
      print('VoiceActivationManager: Error checking enrollment status: $e');
      // On error, assume not enrolled to be safe
      return false;
    }
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
              Navigator.pop(context);
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

/// Bullet point widget for enrollment prompt
class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

/// Voice activation status for UI display
enum VoiceActivationStatus {
  notEnrolled,
  enrolled,
  error,
}

/// Widget for showing voice activation status
class VoiceActivationStatusBadge extends StatelessWidget {
  final VoiceActivationStatus status;
  final VoidCallback? onTap;

  const VoiceActivationStatusBadge({
    super.key,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case VoiceActivationStatus.notEnrolled:
        color = Colors.grey;
        label = 'Not Activated';
        icon = Icons.mic_off_rounded;
        break;
      case VoiceActivationStatus.enrolled:
        color = InvoiceThemeColors.primaryPurple;
        label = 'Voice Active';
        icon = Icons.mic_rounded;
        break;
      case VoiceActivationStatus.error:
        color = Colors.red;
        label = 'Error';
        icon = Icons.error_outline;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
