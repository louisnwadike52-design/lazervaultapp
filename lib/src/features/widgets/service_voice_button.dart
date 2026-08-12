import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
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

  /// Optional scoped context id (e.g. a P2P conversation id) forwarded to the
  /// voice session so the agent is pinned to that record.
  final String? conversationId;

  const ServiceVoiceButton({
    super.key,
    required this.serviceName,
    this.suggestions,
    this.iconColor,
    this.backgroundColor,
    this.iconSize,
    this.buttonSize,
    this.conversationId,
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
    // ONE activation experience platform-wide: this is the exact gate the
    // general dashboard mic runs (dashboard_header._showVoiceCommandSheetInner)
    // — availability check → enrollment check → the shared "Voice Activation"
    // dialog (VoiceActivationManager.activateVoice → enrollment carousel) —
    // NOT a per-service variant. A user who hasn't activated voice sees the
    // same prompt here as on the dashboard.
    if (Get.isBottomSheetOpen ?? false) return;

    final activationManager = VoiceActivationManager();

    final isAvailable = await activationManager.isServiceAvailable();
    if (!isAvailable) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'The voice assistant is currently turned off. Please use chat instead.',
            style: GoogleFonts.inter(fontSize: 13),
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    if (!context.mounted) return;
    final userId = await _resolveUserId(context);
    if (userId == null || userId.isEmpty) return;
    if (!context.mounted) return;

    // SAME tri-state classification the dashboard mic runs. A connection /
    // server / LiveKit / timeout failure (or an ambiguous status) shows the
    // shared temporarily-unavailable modal — NOT the enrollment prompt — so an
    // already-enrolled user is never wrongly told to re-enroll during an outage.
    while (true) {
      final outcome = await activationManager.checkEnrollmentOutcome(userId);
      if (!context.mounted) return;

      if (outcome == VoiceEnrollmentCheck.unavailable) {
        final retry =
            await VoiceActivationManager.showVoiceUnavailableModal(context);
        if (retry && context.mounted) {
          continue; // re-check (unavailable was never cached)
        }
        return;
      }

      if (outcome == VoiceEnrollmentCheck.notEnrolled) {
        // The SAME enrollment prompt the dashboard mic shows.
        final activated = await activationManager.activateVoice(context, userId);
        if (!activated || !context.mounted) return;
      }
      break; // enrolled, or enrollment just completed
    }

    // Activation confirmed above, so the sheet skips its own re-check —
    // identical to how the dashboard opens the general session. Self-sizing
    // sheet (DraggableScrollableSheet: 90% → full screen); enableDrag false
    // so the outer Get sheet doesn't fight drag-to-resize.
    Get.bottomSheet(
      VoiceCommandSheet(
        serviceName: serviceName,
        conversationId: conversationId,
        skipActivationCheck: true,
      ),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }

  /// The user id, from the app-root AuthenticationCubit when hydrated
  /// (same source the dashboard mic reads), else the secure-storage copy.
  Future<String?> _resolveUserId(BuildContext context) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      return authState.profile.userId;
    }
    return serviceLocator<FlutterSecureStorage>().read(key: 'user_id');
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
