import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/voice/presentation/screens/voice_verification_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:get/get.dart';

/// Voice Activation Guard
/// Ensures voice enrollment and verification for protected features
class VoiceActivationGuard {
  static const String _skipsKey = 'voice_activation_skips';
  static const int _maxSkips = 3;

  final VoiceActivationManager _voiceManager = VoiceActivationManager();
  final FlutterSecureStorage _storage = GetIt.I<FlutterSecureStorage>();

  /// Check if user can access a voice-protected feature
  ///
  /// Returns true if access is granted, false otherwise
  /// Shows appropriate dialogs/prompts if access is denied
  Future<bool> canAccessFeature({
    required BuildContext context,
    required String featureName,
    required String userId,
    VoiceFeatureLevel level = VoiceFeatureLevel.enrollmentRequired,
  }) async {
    try {
      // Check if user has enrolled voice
      final isEnrolled = await _voiceManager.isVoiceEnrolled(userId);

      if (!isEnrolled) {
        return await _handleNotEnrolled(context, userId, featureName, level);
      }

      // For high-risk operations, require verification
      if (level == VoiceFeatureLevel.verificationRequired) {
        return await _requireVerification(context, userId, featureName);
      }

      // Access granted
      return true;
    } catch (e) {
      // On error, allow access for better UX
      debugPrint('Error checking voice activation: $e');
      return true;
    }
  }

  /// Handle user who hasn't enrolled voice
  Future<bool> _handleNotEnrolled(
    BuildContext context,
    String userId,
    String featureName,
    VoiceFeatureLevel level,
  ) async {
    final skipsStr = await _storage.read(key: _skipsKey);
    final skips = int.tryParse(skipsStr ?? '0') ?? 0;
    final isMandatory = skips >= _maxSkips;

    if (isMandatory || level == VoiceFeatureLevel.verificationRequired) {
      // Show mandatory activation dialog
      return await _showMandatoryActivationDialog(context, userId, featureName);
    } else {
      // Show optional activation prompt
      return await _showOptionalActivationDialog(context, userId, featureName, skips);
    }
  }

  /// Show mandatory activation dialog (user can't skip)
  Future<bool> _showMandatoryActivationDialog(
    BuildContext context,
    String userId,
    String featureName,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.mic_rounded, color: Colors.orange[700], size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Voice Activation Required'),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For your security, voice activation is required to access this feature.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Voice activation adds an extra layer of security to protect your account.',
                      style: TextStyle(fontSize: 12, color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Setup only takes 2 minutes and you\'ll be able to use voice commands for secure banking.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
              // Navigate to voice activation
              Get.toNamed(AppRoutes.voiceActivationPrompt, arguments: {
                'userId': userId,
                'featureName': featureName,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Activate Now', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Show optional activation dialog (user can skip)
  Future<bool> _showOptionalActivationDialog(
    BuildContext context,
    String userId,
    String featureName,
    int currentSkips,
  ) async {
    final remainingSkips = _maxSkips - currentSkips;

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
            const Expanded(
              child: Text('Activate Voice Banking?'),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Voice activation makes this feature more secure and easier to use.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            if (remainingSkips > 0)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can skip $remainingSkips more time${remainingSkips == 1 ? '' : 's'} before voice activation becomes mandatory.',
                        style: TextStyle(fontSize: 12, color: Colors.orange[900]),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Setup only takes 2 minutes.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Increment skip count
              _incrementSkipCount();
              Navigator.of(dialogContext).pop(false); // Don't access feature
            },
            child: const Text('Skip'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
              // Navigate to voice activation
              Get.toNamed(AppRoutes.voiceActivationPrompt, arguments: {
                'userId': userId,
                'featureName': featureName,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Activate', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Require voice verification before granting access
  Future<bool> _requireVerification(
    BuildContext context,
    String userId,
    String featureName,
  ) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => VoiceVerificationScreen(
          userId: userId,
          onVerificationSuccess: () {
            Navigator.of(context).pop(true);
          },
          onEnrollmentRequired: () {
            // Navigate to enrollment if verification fails due to no enrollment
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VoiceVerificationScreen(
                  userId: userId,
                  onVerificationSuccess: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );

    return result ?? false;
  }

  /// Increment skip count
  Future<void> _incrementSkipCount() async {
    final skipsStr = await _storage.read(key: _skipsKey);
    final skips = int.tryParse(skipsStr ?? '0') ?? 0;
    await _storage.write(key: _skipsKey, value: '${skips + 1}');
  }

  /// Reset skip count (called after successful enrollment)
  Future<void> resetSkipCount() async {
    await _storage.delete(key: _skipsKey);
  }

  /// Get current skip count
  Future<int> getSkipCount() async {
    final skipsStr = await _storage.read(key: _skipsKey);
    return int.tryParse(skipsStr ?? '0') ?? 0;
  }
}

/// Feature security levels for voice activation
enum VoiceFeatureLevel {
  /// Feature works without voice but voice enhances security
  optional,

  /// Feature requires voice enrollment but no verification
  enrollmentRequired,

  /// Feature requires voice enrollment AND verification (high-risk operations)
  verificationRequired,
}

/// Predefined feature configurations
class VoiceProtectedFeatures {
  static const Map<String, VoiceFeatureLevel> featureLevels = {
    // High-risk operations requiring verification
    'send_funds': VoiceFeatureLevel.verificationRequired,
    'large_transfer': VoiceFeatureLevel.verificationRequired,
    'sell_stocks': VoiceFeatureLevel.verificationRequired,
    'delete_account': VoiceFeatureLevel.verificationRequired,
    'change_pin': VoiceFeatureLevel.verificationRequired,
    'international_transfer': VoiceFeatureLevel.verificationRequired,

    // Standard operations requiring enrollment
    'buy_stocks': VoiceFeatureLevel.enrollmentRequired,
    'pay_bills': VoiceFeatureLevel.enrollmentRequired,
    'manage_cards': VoiceFeatureLevel.enrollmentRequired,
    'create_invoice': VoiceFeatureLevel.enrollmentRequired,
    'buy_gift_card': VoiceFeatureLevel.enrollmentRequired,
    'buy_insurance': VoiceFeatureLevel.enrollmentRequired,
    'buy_airtime': VoiceFeatureLevel.enrollmentRequired,

    // Optional features
    'check_balance': VoiceFeatureLevel.optional,
    'transaction_history': VoiceFeatureLevel.optional,
    'view_portfolio': VoiceFeatureLevel.optional,
  };

  /// Get the security level for a feature
  static VoiceFeatureLevel getLevel(String featureName) {
    return featureLevels[featureName] ?? VoiceFeatureLevel.optional;
  }

  /// Check if a feature requires verification
  static bool requiresVerification(String featureName) {
    return getLevel(featureName) == VoiceFeatureLevel.verificationRequired;
  }

  /// Check if a feature requires enrollment
  static bool requiresEnrollment(String featureName) {
    final level = getLevel(featureName);
    return level == VoiceFeatureLevel.enrollmentRequired ||
           level == VoiceFeatureLevel.verificationRequired;
  }
}

/// Usage Example:
///
/// ```dart
/// // In your screen or button handler
/// final guard = VoiceActivationGuard();
/// final canAccess = await guard.canAccessFeature(
///   context: context,
///   featureName: 'send_funds',
///   userId: userId,
///   level: VoiceProtectedFeatures.getLevel('send_funds'),
/// );
///
/// if (canAccess) {
///   // Proceed with feature
/// } else {
///   // Access denied, user was shown appropriate dialog
/// }
/// ```
