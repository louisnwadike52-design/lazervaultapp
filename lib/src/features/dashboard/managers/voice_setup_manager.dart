import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';

/// Voice Setup Manager
/// Manages voice setup prompts on dashboard with skip count logic
class VoiceSetupManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final VoiceActivationManager _voiceManager;

  VoiceSetupManager({
    required VoiceActivationManager voiceManager,
  }) : _voiceManager = voiceManager;

  /// Check voice setup status and determine if prompt should be shown
  Future<VoiceSetupStatus> checkVoiceSetupStatus() async {
    final userId = await _storage.read(key: 'user_id');
    if (userId == null) return VoiceSetupStatus.notApplicable;

    // Check if already enrolled
    final isEnrolled = await _voiceManager.isVoiceEnrolled(userId);
    if (isEnrolled) return VoiceSetupStatus.completed;

    // Check skip count
    final skipCountStr = await _storage.read(key: 'voice_setup_skips');
    final skipCount = int.tryParse(skipCountStr ?? '0') ?? 0;

    if (skipCount >= 3) return VoiceSetupStatus.mandatory;

    // Check if dismissed within 24 hours
    final lastDismissed = await _storage.read(key: 'voice_setup_last_dismissed');
    if (lastDismissed != null) {
      final dismissedDate = DateTime.tryParse(lastDismissed);
      if (dismissedDate != null &&
          DateTime.now().difference(dismissedDate).inHours < 24) {
        return VoiceSetupStatus.dismissed;
      }
    }

    return VoiceSetupStatus.pending;
  }

  /// Increment skip count when user dismisses the prompt
  Future<void> incrementSkipCount() async {
    final skipCountStr = await _storage.read(key: 'voice_setup_skips');
    final skipCount = int.tryParse(skipCountStr ?? '0') ?? 0;
    await _storage.write(key: 'voice_setup_skips', value: '${skipCount + 1}');
    await _storage.write(
      key: 'voice_setup_last_dismissed',
      value: DateTime.now().toIso8601String(),
    );
  }

  /// Get current skip count (for UI display)
  Future<int> getSkipCount() async {
    final skipCountStr = await _storage.read(key: 'voice_setup_skips');
    return int.tryParse(skipCountStr ?? '0') ?? 0;
  }

  /// Mark voice setup as completed
  Future<void> markAsCompleted() async {
    await _storage.write(key: 'voice_setup_completed', value: 'true');
    await _storage.delete(key: 'voice_setup_skips');
    await _storage.delete(key: 'voice_setup_last_dismissed');
  }

  /// Reset skip count (useful for debugging or user request)
  Future<void> resetSkipCount() async {
    await _storage.delete(key: 'voice_setup_skips');
    await _storage.delete(key: 'voice_setup_last_dismissed');
  }

  /// Check if voice setup should be shown on dashboard
  /// This is a convenience method that combines status check
  Future<bool> shouldShowPrompt() async {
    final status = await checkVoiceSetupStatus();
    return status == VoiceSetupStatus.pending ||
        status == VoiceSetupStatus.mandatory;
  }

  /// Check if prompt is mandatory (3+ skips)
  Future<bool> isMandatory() async {
    final status = await checkVoiceSetupStatus();
    return status == VoiceSetupStatus.mandatory;
  }
}

/// Voice setup status enum
enum VoiceSetupStatus {
  notApplicable, // Not logged in
  completed, // Already enrolled
  pending, // Should show prompt
  dismissed, // Dismissed within 24h
  mandatory, // 3+ skips, required
}
