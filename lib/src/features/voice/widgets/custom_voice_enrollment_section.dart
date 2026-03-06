import 'package:flutter/material.dart';
import '../../models/voice_settings_models.dart';

/// Widget for custom voice enrollment flow
class CustomVoiceEnrollmentSection extends StatelessWidget {
  final VoiceEnrollmentSession? enrollmentStatus;
  final List<double> qualityScores;
  final VoidCallback onStartEnrollment;
  final VoidCallback onGenerateVoice;

  const CustomVoiceEnrollmentSection({
    super.key,
    this.enrollmentStatus,
    this.qualityScores = const [],
    required this.onStartEnrollment,
    required this.onGenerateVoice,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = enrollmentStatus?.isCompleted ?? false;
    final isInProgress = enrollmentStatus != null && !isCompleted;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Custom Voice',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '5 phrases to train your voice',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress or Start button
          if (!isCompleted && !isInProgress)
            ElevatedButton.icon(
              onPressed: onStartEnrollment,
              icon: const Icon(Icons.mic, size: 18),
              label: const Text('Start Voice Training'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                minimumSize: const Size.fromHeight(48),
              ),
            )
          else if (isInProgress)
            _buildProgressIndicator()
          else if (isCompleted)
            _buildCompletedSection(context),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final progress = enrollmentStatus?.progress ?? 0;
    final currentStep = enrollmentStatus?.currentStep ?? 0;
    final totalSteps = enrollmentStatus?.totalSteps ?? 5;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFF2D2D2D),
          color: const Color(0xFF3B82F6),
        ),
        const SizedBox(height: 8),
        Text(
          'Recording... $currentStep of $totalSteps phrases',
          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCompletedSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF10B981),
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Voice samples collected!',
              style: TextStyle(
                color: Color(0xFF10B981),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onGenerateVoice,
          icon: const Icon(Icons.auto_awesome, size: 18),
          label: const Text('Generate Custom Voice'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ],
    );
  }
}
