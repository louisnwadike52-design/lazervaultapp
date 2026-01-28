import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:lazervault/src/features/voice/presentation/screens/voice_verification_screen.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_screen.dart';

/// Voice Activation Manager
/// Orchestrates the complete voice activation flow:
/// 1. Check enrollment status
/// 2. Prompt for enrollment if not enrolled
/// 3. Verify voice before granting access
class VoiceActivationManager {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();

  /// Check if user has enrolled voice
  Future<bool> isVoiceEnrolled(String userId) async {
    try {
      final status = await _voiceService.checkEnrollmentStatus(userId);
      return status.isEnrolled;
    } catch (e) {
      // On error, assume not enrolled to be safe
      return false;
    }
  }

  /// Activate voice features with complete flow
  /// Returns true if voice is activated/verified, false otherwise
  Future<bool> activateVoice(
    BuildContext context,
    String userId, {
    bool forceVerification = false,
    VoidCallback? onSuccess,
  }) async {
    // Check enrollment status
    final isEnrolled = await isVoiceEnrolled(userId);

    if (!isEnrolled) {
      if (!context.mounted) return false;
      // User needs to enroll first
      return _showEnrollmentPrompt(context, userId);
    }

    // User is enrolled, verify voice
    if (forceVerification) {
      if (!context.mounted) return false;
      return _showVerificationScreen(context, userId, onSuccess);
    }

    // Allow access (caller can decide if they want to verify)
    return true;
  }

  /// Show enrollment prompt with explanation
  bool _showEnrollmentPrompt(BuildContext context, String userId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.mic_rounded, color: Colors.blue[700], size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(child: Text('Voice Activation Required')),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To use voice commands for secure banking, you need to activate your voice first.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Voice activation allows you to:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            SizedBox(height: 8),
            BulletPoint(text: 'Securely verify your identity'),
            BulletPoint(text: 'Execute banking commands by voice'),
            BulletPoint(text: 'Check balances and make transfers'),
            BulletPoint(text: 'Pay bills and manage investments'),
            SizedBox(height: 16),
            Text(
              'The process takes about 2 minutes and requires recording 5 voice samples.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // Signal that activation was canceled
            },
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // Navigate to enrollment screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoiceEnrollmentScreen(
                    userId: userId,
                    onEnrollmentComplete: () {
                      // Navigate back after enrollment
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Activate Now'),
          ),
        ],
      ),
    );

    return false;
  }

  /// Show verification screen
  bool _showVerificationScreen(
    BuildContext context,
    String userId,
    VoidCallback? onSuccess,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoiceVerificationScreen(
          userId: userId,
          onVerificationSuccess: onSuccess,
          onEnrollmentRequired: () {
            // Navigate to enrollment if verification fails due to no enrollment
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VoiceEnrollmentScreen(
                  userId: userId,
                  onEnrollmentComplete: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );

    return false; // Will return true via callback if successful
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
          builder: (context) => VoiceEnrollmentScreen(
            userId: userId,
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
  verified,
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
        color = Colors.blue;
        label = 'Voice Active';
        icon = Icons.mic_rounded;
        break;
      case VoiceActivationStatus.verified:
        color = Colors.green;
        label = 'Verified';
        icon = Icons.verified_rounded;
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
