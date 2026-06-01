import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/src/features/dashboard/managers/voice_setup_manager.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/guards/voice_setup_guard.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/voice/screens/per_service_voice_settings_screen.dart';

import '../voice_session/widgets/voice_command_sheet.dart';

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
      // Tap → voice command sheet. Long-press → per-service voice
      // settings (language, voice, prompt hint). Long-press is a
      // discoverable shortcut for users who want to configure WITHOUT
      // going through the mic interaction first (Phase 9 user-facing
      // direct route to PerServiceVoiceSettingsScreen).
      child: GestureDetector(
        onLongPress: () => _openVoiceSettings(context),
        child: IconButton(
          icon: Icon(
            Icons.mic_rounded,
            color: iconColor ?? Colors.white,
            size: iconSz,
          ),
          onPressed: () => _showVoiceCommandSheet(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          tooltip: 'Voice commands for $serviceName (long-press for settings)',
        ),
      ),
    );
  }

  void _openVoiceSettings(BuildContext context) {
    // Direct path to PerServiceVoiceSettingsScreen without going through
    // the command sheet. Same construction the gear icon inside
    // VoiceCommandSheet uses — single canonical entry path keeps
    // settings cubit lifecycle predictable.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PerServiceVoiceSettingsCubit>(
          create: (_) {
            final cubit = PerServiceVoiceSettingsCubit(
              serviceName: serviceName,
              storage: SharedPrefsPerServiceVoiceSettingsStorage(),
            );
            cubit.load();
            return cubit;
          },
          child: PerServiceVoiceSettingsScreen(serviceName: serviceName),
        ),
      ),
    );
  }

  void _showVoiceCommandSheet(BuildContext context) async {
    // Gate every per-service voice session on the SAME setup guard the
    // general dashboard mic uses. Mirrors:
    //   1. logged-in check
    //   2. biometric-enrollment check (voice-biometrics-service)
    //   3. high-risk feature → mandatory voice verification before entry
    //
    // The guard's dialog handles "not enrolled" → navigate to enrollment
    // → re-check on return. We only open the command sheet when canAccess
    // returns true, so dropouts at any step abort cleanly without burning
    // a half-loaded voice session.
    final guard = _resolveGuard();
    final allowed = await guard.canAccessVoiceFeature(context, serviceName);
    if (!allowed) return;
    if (!context.mounted) return;

    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(
          serviceName: serviceName,
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Resolve the shared VoiceSetupGuard from GetIt, lazy-constructing it
  /// the first time. Mirrors how `DashboardScreen` builds the guard
  /// today (`VoiceSetupManager(voiceManager: VoiceActivationManager())`),
  /// so this widget keeps working in any host without requiring a
  /// dedicated DI registration.
  VoiceSetupGuard _resolveGuard() {
    if (GetIt.I.isRegistered<VoiceSetupGuard>()) {
      return GetIt.I<VoiceSetupGuard>();
    }
    final manager = VoiceActivationManager();
    final setupMgr = VoiceSetupManager(voiceManager: manager);
    final guard = VoiceSetupGuard(
      voiceManager: manager,
      setupManager: setupMgr,
    );
    GetIt.I.registerSingleton<VoiceSetupGuard>(guard);
    return guard;
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
