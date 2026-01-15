import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/dashboard/managers/voice_setup_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Voice Setup Guard
/// Middleware to protect features requiring voice enrollment
/// Shows setup prompt when user tries to access voice/microphone features
class VoiceSetupGuard {
  final VoiceActivationManager _voiceManager;
  final VoiceSetupManager _setupManager;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  VoiceSetupGuard({
    required VoiceActivationManager voiceManager,
    required VoiceSetupManager setupManager,
  })  : _voiceManager = voiceManager,
        _setupManager = setupManager;

  /// Check if user can access voice feature
  /// Returns true if enrolled, false otherwise
  /// Shows appropriate dialogs if not enrolled
  Future<bool> canAccessVoiceFeature(
    BuildContext context,
    String featureName,
  ) async {
    final userId = await _storage.read(key: 'user_id');
    if (userId == null) {
      _showNotLoggedInDialog(context);
      return false;
    }

    // Check if enrolled
    final isEnrolled = await _voiceManager.isVoiceEnrolled(userId);

    if (!isEnrolled) {
      // Show setup required prompt
      final shouldSetup = await _showVoiceSetupRequired(
        context,
        featureName: featureName,
      );

      if (!shouldSetup) return false;

      // Navigate to voice setup
      final result = await Get.toNamed(AppRoutes.voiceActivationPrompt);

      // Check if setup was completed
      return await _voiceManager.isVoiceEnrolled(userId);
    }

    // Check if verification required for high-risk features
    if (_isHighRiskFeature(featureName)) {
      return await _verifyVoice(context, userId);
    }

    return true;
  }

  /// Show dialog when user is not logged in
  void _showNotLoggedInDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Login Required'),
        content: const Text(
          'You need to be logged in to use voice features.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show dialog prompting user to set up voice
  Future<bool> _showVoiceSetupRequired(
    BuildContext context, {
    required String featureName,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic_rounded,
                    color: Color(0xFF6366F1),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Voice Setup Required',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To use $featureName, you need to set up voice banking first.',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: Color(0xFF6366F1),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This adds an extra layer of security to your transactions',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Not Now'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Setup Voice Banking'),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Check if feature is high-risk and requires verification
  bool _isHighRiskFeature(String featureName) {
    const highRiskFeatures = [
      'send_funds',
      'large_transfer',
      'sell_stocks',
      'delete_account',
      'change_pin',
      'international_transfer',
      'withdraw_funds',
      'investment_transaction',
    ];
    return highRiskFeatures.contains(featureName);
  }

  /// Verify voice for high-risk operations
  Future<bool> _verifyVoice(BuildContext context, String userId) async {
    // Show verification requirement dialog
    final shouldVerify = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(
              Icons.verified_user_rounded,
              color: Color(0xFF6366F1),
              size: 28,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Verification Required',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This is a sensitive operation that requires voice verification for your security.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 12),
            Text(
              'Please verify your identity using your voice.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Verify Now'),
          ),
        ],
      ),
    );

    if (shouldVerify != true) return false;

    // Navigate to voice verification screen
    final result = await Get.toNamed(AppRoutes.voiceVerification);

    return result == true;
  }

  /// Quick check if user is enrolled (no dialogs)
  /// Use this for UI state management
  Future<bool> isEnrolled() async {
    final userId = await _storage.read(key: 'user_id');
    if (userId == null) return false;
    return await _voiceManager.isVoiceEnrolled(userId);
  }
}
