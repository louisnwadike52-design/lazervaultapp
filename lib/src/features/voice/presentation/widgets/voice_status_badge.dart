import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/voice_biometrics_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_carousel_screen.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Voice Status Badge - Shows voice enrollment status and allows navigation to registration
class VoiceStatusBadge extends StatefulWidget {
  final String userId;
  final VoidCallback? onEnrollmentChanged;

  const VoiceStatusBadge({
    super.key,
    required this.userId,
    this.onEnrollmentChanged,
  });

  @override
  State<VoiceStatusBadge> createState() => _VoiceStatusBadgeState();
}

class _VoiceStatusBadgeState extends State<VoiceStatusBadge> {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();
  VoiceEnrollmentStatus? _status;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final status = await _voiceService.checkEnrollmentStatus(widget.userId);
      if (mounted) {
        setState(() {
          _status = status;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _status = null;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _navigateToRegistration() async {
    // Route to the SHARED, cubit-backed enrollment screen (single source of
    // truth) rather than the divergent VoiceRegistrationScreen — same
    // VoiceEnrollmentCubit + VoiceBiometricsService backend as every other
    // enrollment entry point. openVoiceSheetOnComplete:false so finishing
    // returns here instead of jumping to the dashboard voice sheet.
    var enrolled = false;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider<VoiceEnrollmentCubit>(
          create: (_) => GetIt.I<VoiceEnrollmentCubit>(),
          child: VoiceEnrollmentCarouselScreen(
            userId: widget.userId,
            openVoiceSheetOnComplete: false,
            onEnrollmentComplete: () {
              enrolled = true;
              VoiceActivationManager.markVoiceEnrolled(widget.userId);
            },
          ),
        ),
      ),
    );

    if (enrolled) {
      // Voice was registered successfully
      await _checkStatus();
      widget.onEnrollmentChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LazerVaultLoader.tiny(),
            SizedBox(width: 8),
            Text(
              'Checking voice...',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }

    final isEnrolled = _status?.isEnrolled ?? false;
    final qualityScore = _status?.qualityScore ?? 0.0;

    return GestureDetector(
      onTap: isEnrolled ? null : _navigateToRegistration,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isEnrolled ? Colors.green.shade50 : Colors.orange.shade50,
          border: Border.all(
            color: isEnrolled ? Colors.green.shade200 : Colors.orange.shade200,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isEnrolled ? Icons.verified_user : Icons.warning_amber_rounded,
              size: 18,
              color: isEnrolled ? Colors.green.shade700 : Colors.orange.shade700,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEnrolled ? 'Voice Verified' : 'Voice Not Registered',
                  style: TextStyle(
                    color: isEnrolled ? Colors.green.shade800 : Colors.orange.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                if (isEnrolled && qualityScore > 0)
                  Text(
                    'Quality: ${(qualityScore * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
            if (!isEnrolled) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.orange.shade700,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Compact version of voice status badge
class VoiceStatusBadgeCompact extends StatelessWidget {
  final String userId;
  final VoidCallback? onTap;

  const VoiceStatusBadgeCompact({
    super.key,
    required this.userId,
    this.onTap,
  });

  Future<VoiceEnrollmentStatus> _checkStatus() async {
    final service = GetIt.I<VoiceBiometricsService>();
    return await service.checkEnrollmentStatus(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VoiceEnrollmentStatus>(
      future: _checkStatus(),
      builder: (context, snapshot) {
        final isEnrolled = snapshot.data?.isEnrolled ?? false;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isEnrolled ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isEnrolled ? Icons.check_circle : Icons.mic_off,
                  size: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  isEnrolled ? 'Voice OK' : 'Setup Voice',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
