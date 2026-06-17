import 'package:flutter/material.dart';

/// Row of media action buttons for chat input. Collapses camera + gallery
/// behind a single attachment icon (ChatGPT pattern) so the first-view
/// toolbar stays at two icons — attach + mic — instead of three.
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
          icon: Icons.attach_file,
          onTap: () => _openAttachmentSheet(context),
          tooltip: 'Attach',
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

  Future<void> _openAttachmentSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _AttachmentOption(
                icon: Icons.camera_alt_outlined,
                label: 'Take Photo',
                subtitle: 'Use the camera',
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onCameraCapture();
                },
              ),
              _AttachmentOption(
                icon: Icons.photo_library_outlined,
                label: 'Upload from Gallery',
                subtitle: 'Pick an existing photo',
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onImagePick();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    Color? color,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            icon,
            color: color ?? const Color(0xFF9CA3AF),
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
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
