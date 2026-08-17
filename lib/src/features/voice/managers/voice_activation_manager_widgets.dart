part of 'voice_activation_manager.dart';

/// Classified result of an enrollment-status check. The mic entry points MUST
/// branch on this instead of a bare bool, because "not enrolled" and "we could
/// not find out" are completely different outcomes:
///   - [enrolled]     → a DEFINITIVE backend 200/404 says a voiceprint exists.
///   - [notEnrolled]  → a DEFINITIVE backend 200/404 says no voiceprint exists.
///                      ONLY this shows the "set up / re-enroll voice" prompt.
///   - [unavailable]  → ANY transport error (offline/timeout/DNS), 5xx, gRPC
///                      Unavailable, or an otherwise ambiguous/unknown response.
///                      Shows "Voice is temporarily unavailable" — NEVER the
///                      enrollment prompt (an enrolled user must never be told
///                      to re-enroll because of an outage).
enum VoiceEnrollmentCheck { enrolled, notEnrolled, unavailable }

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

/// One cached enrollment answer with its capture time, used by
/// [VoiceActivationManager]'s short-lived enrollment-status cache.
class _EnrollmentCacheEntry {
  final bool isEnrolled;
  final DateTime fetchedAt;
  _EnrollmentCacheEntry(this.isEnrolled) : fetchedAt = DateTime.now();
  bool get isExpired =>
      DateTime.now().difference(fetchedAt) > VoiceActivationManager._enrollmentTtl;
}
