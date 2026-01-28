import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../voice_session/widgets/voice_command_sheet.dart';
import 'voice_suggestions.dart';

/// Reusable voice button widget for service screens
///
/// This widget provides a consistent mic icon button across all service screens,
/// allowing users to interact with service-specific voice agents.
///
/// Usage:
/// ```dart
/// ServiceVoiceButton(
///   serviceName: 'stocks',
///   suggestions: ['Show my portfolio', 'Buy 10 shares of Apple'],
/// )
/// ```
class ServiceVoiceButton extends StatelessWidget {
  /// The service name (must match service names in voice agent system)
  final String serviceName;

  /// Optional custom suggestions for this service
  /// If not provided, will use default suggestions from VoiceSuggestions
  final List<String>? suggestions;

  /// Icon color (defaults to white)
  final Color? iconColor;

  /// Background color (defaults to white with opacity)
  final Color? backgroundColor;

  /// Icon size (defaults to 20.sp)
  final double? iconSize;

  /// Button size (defaults to 44.w)
  final double? buttonSize;

  const ServiceVoiceButton({
    super.key,
    required this.serviceName,
    this.suggestions,
    this.iconColor,
    this.backgroundColor,
    this.iconSize,
    this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = buttonSize ?? 44.w;
    final iconSz = iconSize ?? 20.sp;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: (backgroundColor ?? Colors.white).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.mic_rounded,
          color: iconColor ?? Colors.white,
          size: iconSz,
        ),
        onPressed: () => _showVoiceCommandSheet(context),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        tooltip: 'Voice commands for $serviceName',
      ),
    );
  }

  void _showVoiceCommandSheet(BuildContext context) async {
    // Check voice enrollment status before showing voice command sheet
    // TODO: Replace with actual enrollment status check from your backend
    final isEnrolled = await _checkVoiceEnrollment(context);

    if (!isEnrolled) {
      // Show enrollment required dialog
      if (context.mounted) {
        _showEnrollmentRequiredDialog(context);
      }
      return;
    }

    // Get service-specific suggestions
    final serviceSuggestions = suggestions ??
        VoiceSuggestions.getSuggestions(serviceName);

    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(
          serviceName: serviceName,
          suggestions: serviceSuggestions,
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Check if user has voice biometrics enrolled
  Future<bool> _checkVoiceEnrollment(BuildContext context) async {
    try {
      // TODO: Implement actual enrollment status check
      // This should call your voice biometrics service to check enrollment status
      // For now, return false to enforce enrollment requirement
      return false;
    } catch (e) {
      print('Error checking voice enrollment: $e');
      return false;
    }
  }

  // Show dialog prompting user to enroll voice
  void _showEnrollmentRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.mic_rounded,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 12),
            const Text('Voice Setup Required'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Before using voice commands, you need to set up voice recognition for secure access.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Voice enrollment takes about 30 seconds and:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ...const [
              '✓ Protects your account with voice biometrics',
              '✓ Required for all voice transactions',
              '✓ Quick one-time setup',
            ].map((text) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Text(
                text,
                style: const TextStyle(fontSize: 12),
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _navigateToEnrollment(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Set Up Voice'),
          ),
        ],
      ),
    );
  }

  // Navigate to voice enrollment screen
  void _navigateToEnrollment(BuildContext context) {
    Get.toNamed(AppRoutes.voiceEnrollment);
  }
}

/// Compact version of ServiceVoiceButton for use in smaller spaces
class ServiceVoiceButtonCompact extends StatelessWidget {
  final String serviceName;
  final List<String>? suggestions;
  final Color? iconColor;

  const ServiceVoiceButtonCompact({
    super.key,
    required this.serviceName,
    this.suggestions,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ServiceVoiceButton(
      serviceName: serviceName,
      suggestions: suggestions,
      iconColor: iconColor,
      buttonSize: 36.w,
      iconSize: 16.sp,
    );
  }
}
