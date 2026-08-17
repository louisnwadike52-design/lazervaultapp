import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
part 'p2p_chat_input_bar_widgets.dart';


class P2PChatInputBar extends StatefulWidget {
  final Function(String content) onSend;

  /// Called when a media file (image or voice note) is ready to be sent.
  /// [mediaType] is 'image' | 'voice'. [contentType] is the MIME type.
  /// [caption] is an optional text the user attached to an image before sending.
  final Function(
    String mediaType,
    String localFilePath,
    String contentType, [
    String? caption,
  ])? onSendMedia;
  final Function(bool isTyping)? onTypingChanged;
  final bool enabled;

  /// When non-null the composer preloads this text (edit mode). Changing the
  /// value re-seeds the field; clearing it (null) empties the field.
  final String? prefill;

  /// When true, the send button commits an edit (checkmark) instead of sending.
  final bool isEditing;

  /// Tapped the quick emoji-burst button (fires a floating ❤️ over the chat).
  final void Function(String emoji)? onEmojiBurst;

  const P2PChatInputBar({
    super.key,
    required this.onSend,
    this.onSendMedia,
    this.onTypingChanged,
    this.enabled = true,
    this.prefill,
    this.isEditing = false,
    this.onEmojiBurst,
  });

  @override
  State<P2PChatInputBar> createState() => _P2PChatInputBarState();
}

class _P2PChatInputBarState extends State<P2PChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;
  Timer? _typingTimer;
  bool _isTyping = false;

  // Media: image picking + voice recording
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isPickingMedia = false;
  bool _isRecording = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  static const Duration _maxRecordingDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    if (widget.prefill != null && widget.prefill!.isNotEmpty) {
      _controller.text = widget.prefill!;
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
      _hasText = true;
    }
  }

  @override
  void didUpdateWidget(covariant P2PChatInputBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Entering/leaving edit mode re-seeds the field with the message being
    // edited (or clears it when edit is cancelled).
    if (widget.prefill != oldWidget.prefill) {
      final text = widget.prefill ?? '';
      _controller.text = text;
      _controller.selection = TextSelection.collapsed(offset: text.length);
      if (widget.prefill != null && widget.prefill!.isNotEmpty) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _focusNode.requestFocus());
      }
      setState(() => _hasText = text.trim().isNotEmpty);
    }
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }

    // Typing indicator
    if (hasText && !_isTyping) {
      _isTyping = true;
      widget.onTypingChanged?.call(true);
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        widget.onTypingChanged?.call(false);
      }
    });
  }

  bool _isSending = false;

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || _isSending) return;

    // Rapid-tap protection
    _isSending = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      _isSending = false;
    });

    widget.onSend(text);
    _controller.clear();

    // Reset typing
    _isTyping = false;
    widget.onTypingChanged?.call(false);
    _typingTimer?.cancel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _typingTimer?.cancel();
    _recordingTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  // ---- Media: image picking ------------------------------------------------

  Future<void> _pickImage(ImageSource source) async {
    if (_isPickingMedia || !widget.enabled) return;
    _isPickingMedia = true;
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (picked != null && mounted) {
        // Preview the picked image + let the user attach a caption before it
        // actually sends (WhatsApp-style). Returns the caption ('' allowed) or
        // null if the user backed out.
        final caption = await Navigator.of(context).push<String?>(
          MaterialPageRoute(
            builder: (_) => _ImageCaptionPreview(imagePath: picked.path),
            fullscreenDialog: true,
          ),
        );
        if (caption == null || !mounted) return; // cancelled
        widget.onSendMedia?.call(
          'image',
          picked.path,
          picked.mimeType ?? _inferImageMime(picked.path),
          caption.trim().isEmpty ? null : caption.trim(),
        );
      }
    } catch (_) {
      // Picker cancelled or permission denied — fail quietly.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not access photos. Check app permissions.'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      _isPickingMedia = false;
    }
  }

  String _inferImageMime(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }

  void _showAttachMenu() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF3B82F6)),
              title: Text('Gallery',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF10B981)),
              title: Text('Camera',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---- Media: voice recording ---------------------------------------------

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording(send: true);
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_isRecording || !widget.enabled) return;
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Microphone permission is required for voice notes'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
      return;
    }
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/p2p_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      // Mono capture is correct for voice notes and — unlike the package
      // default of stereo @ 44.1kHz — is universally supported by Android's
      // AudioRecord. Stereo silently fails to initialise on most Android
      // mics/emulators, which recorded an empty clip and made voice notes
      // "not send" on Android while iOS (lenient AVAudioRecorder) worked.
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          numChannels: 1,
          sampleRate: 44100,
          bitRate: 128000,
        ),
        path: path,
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not start recording. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
      return;
    }
    if (!mounted) return;
    setState(() {
      _isRecording = true;
      _recordingDuration = Duration.zero;
    });
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _recordingDuration += const Duration(seconds: 1));
      if (_recordingDuration >= _maxRecordingDuration) {
        _stopRecording(send: true);
      }
    });
  }

  /// Stop the recording. When [send] is true and the clip is long enough,
  /// hand it off via [onSendMedia]; when false (cancel), discard it.
  Future<void> _stopRecording({required bool send}) async {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    if (!_isRecording) return;
    final durationMs = _recordingDuration.inMilliseconds;
    final path = await _audioRecorder.stop();
    if (mounted) {
      setState(() {
        _isRecording = false;
        _recordingDuration = Duration.zero;
      });
    }
    if (send && path != null && mounted && durationMs > 500) {
      // Guard against a silently-failed capture producing an empty/corrupt
      // clip: never hand an empty file to the upload/send pipeline.
      var hasAudio = false;
      try {
        hasAudio = await File(path).length() > 1024;
      } catch (_) {
        hasAudio = false;
      }
      if (!mounted) return;
      if (!hasAudio) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not record audio. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
        return;
      }
      widget.onSendMedia?.call('voice', path, 'audio/mp4');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 8.w,
        top: 8.h,
        bottom: MediaQuery.of(context).padding.bottom + 8.h,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D), width: 0.5),
        ),
      ),
      child: _isRecording ? _buildRecordingRow() : _buildInputRow(),
    );
  }

  Widget _buildInputRow() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Attach (image) button — LEFT of the text field
          _buildCircleButton(
            icon: Icons.add_photo_alternate_outlined,
            onTap: widget.enabled ? _showAttachMenu : null,
          ),
          SizedBox(width: 6.w),
          // Voice-note button
          _buildCircleButton(
            icon: Icons.mic_none_rounded,
            onTap: widget.enabled ? _toggleRecording : null,
          ),
          SizedBox(width: 6.w),
          // Text input
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: 120.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                maxLines: null,
                maxLength: 5000,
                textInputAction: TextInputAction.newline,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        required maxLength}) =>
                    null,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Trailing action: SEND (or ✓ when editing) with text; otherwise a
          // heart button that fires an ephemeral floating-emoji burst.
          if (_hasText)
            GestureDetector(
              onTap: widget.enabled ? _onSend : null,
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4E03D0), // brand purple
                ),
                child: Icon(
                  widget.isEditing ? Icons.check_rounded : Icons.send,
                  color: Colors.white,
                  size: 20.w,
                ),
              ),
            )
          else
            _buildCircleButton(
              icon: Icons.favorite_rounded,
              onTap: widget.enabled && widget.onEmojiBurst != null
                  ? () => widget.onEmojiBurst!('❤️')
                  : null,
            ),
        ],
    );
  }

  /// A small circular icon button used for the attach / mic actions.
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF2D2D2D),
        ),
        child: Icon(
          icon,
          color: onTap != null
              ? const Color(0xFF9CA3AF)
              : const Color(0xFF6B7280),
          size: 20.w,
        ),
      ),
    );
  }

  /// Recording state row — replaces the input row while a voice note is being
  /// captured. Shows the elapsed timer with a cancel (discard) and a send
  /// (stop + send) action.
  Widget _buildRecordingRow() {
    final minutes =
        _recordingDuration.inMinutes.toString().padLeft(2, '0');
    final seconds =
        (_recordingDuration.inSeconds % 60).toString().padLeft(2, '0');
    return Row(
      children: [
        // Cancel — discard the recording
        GestureDetector(
          onTap: () => _stopRecording(send: false),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEF4444).withOpacity(0.15),
            ),
            child: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 10.w,
          height: 10.w,
          decoration: const BoxDecoration(
            color: Color(0xFFEF4444),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          'Recording  $minutes:$seconds',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        // Send — stop + send the recording
        GestureDetector(
          onTap: () => _stopRecording(send: true),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF3B82F6),
            ),
            child: Icon(Icons.send, color: Colors.white, size: 20.w),
          ),
        ),
      ],
    );
  }
}
