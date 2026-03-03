import 'package:flutter/material.dart';

/// Row of media action buttons for chat input (camera, gallery, mic).
class ChatMediaInputBar extends StatelessWidget {
  final VoidCallback onImagePick;
  final VoidCallback onCameraCapture;
  final VoidCallback onVoiceRecord;
  final bool isRecording;

  const ChatMediaInputBar({
    super.key,
    required this.onImagePick,
    required this.onCameraCapture,
    required this.onVoiceRecord,
    this.isRecording = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(
          icon: Icons.camera_alt_outlined,
          onTap: onCameraCapture,
          tooltip: 'Camera',
        ),
        _buildIconButton(
          icon: Icons.photo_outlined,
          onTap: onImagePick,
          tooltip: 'Gallery',
        ),
        _buildIconButton(
          icon: isRecording ? Icons.stop : Icons.mic_outlined,
          onTap: onVoiceRecord,
          tooltip: isRecording ? 'Stop recording' : 'Voice note',
          color: isRecording ? const Color(0xFFEF4444) : null,
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          icon,
          color: color ?? const Color(0xFF9CA3AF),
          size: 22,
        ),
      ),
    );
  }
}

/// Recording indicator overlay shown during voice note recording.
class RecordingIndicator extends StatelessWidget {
  final Duration duration;
  final VoidCallback onStop;

  const RecordingIndicator({
    super.key,
    required this.duration,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final mins = duration.inMinutes;
    final secs = duration.inSeconds % 60;
    final timeStr = '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            timeStr,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onStop,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.stop, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
