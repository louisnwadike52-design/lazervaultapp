import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lazervault/src/features/ai_chats/presentation/widgets/fullscreen_image_viewer.dart';

/// Renders media content (image or voice note) inside a chat bubble.
class ChatMediaBubble extends StatelessWidget {
  final String? mediaType; // 'image' | 'voice'
  final String? localMediaPath;
  final String? mediaUrl;
  final int? audioDurationMs;
  final String? transcript;
  final bool isUser;

  const ChatMediaBubble({
    super.key,
    this.mediaType,
    this.localMediaPath,
    this.mediaUrl,
    this.audioDurationMs,
    this.transcript,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    if (mediaType == 'image') {
      return _buildImageBubble(context);
    } else if (mediaType == 'voice') {
      return _buildVoiceBubble();
    }
    // Gracefully render nothing for an unknown media type, but surface a debug
    // log when it's a non-null unexpected value so the drift is diagnosable
    // (a null mediaType is a normal text bubble and stays silent).
    if (mediaType != null) {
      debugPrint('[ChatMediaBubble] unexpected mediaType: "$mediaType" — rendering nothing');
    }
    return const SizedBox.shrink();
  }

  /// Stable Hero tag so the bubble image and the full-screen viewer animate
  /// as one element. Prefers the canonical remote URL; falls back to the
  /// local path.
  Object get _heroTag {
    final remote = mediaUrl;
    if (remote != null && remote.isNotEmpty) return 'chat-image-$remote';
    final local = localMediaPath;
    if (local != null && local.isNotEmpty) return 'chat-image-$local';
    return 'chat-image-${identityHashCode(this)}';
  }

  Widget _buildImageBubble(BuildContext context) {
    // RepaintBoundary isolates this bubble's painting so unrelated chat
    // state emits (e.g. the next typed message) don't repaint the image
    // — a major source of the previously-visible flicker.
    return GestureDetector(
      onTap: () => FullScreenImageViewer.open(
        context,
        mediaUrl: mediaUrl,
        localPath: localMediaPath,
        heroTag: _heroTag,
      ),
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220, maxHeight: 220),
            child: Hero(tag: _heroTag, child: _buildImage()),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Prefer the remote URL once the upload has produced one — it's the
    // canonical reference everyone else (other devices, chat history
    // replays, web) renders from. The local file path is used as a
    // *placeholder* while the network image is still loading so the
    // user sees their picture instantly, then a smooth crossfade to
    // the network image (no white-flash, no swap-and-reflow loop).
    final hasRemote = mediaUrl != null &&
        mediaUrl!.isNotEmpty &&
        (mediaUrl!.startsWith('http://') || mediaUrl!.startsWith('https://'));
    final hasLocal = localMediaPath != null && localMediaPath!.isNotEmpty;

    File? localFile;
    if (hasLocal) {
      try {
        final f = File(localMediaPath!);
        if (f.existsSync()) localFile = f;
      } catch (_) {
        // File access error (deleted, permissions) — fall through to
        // the remote-only or placeholder path.
      }
    }

    if (hasRemote) {
      return Image.network(
        mediaUrl!,
        fit: BoxFit.cover,
        gaplessPlayback: true, // hold the previous frame during reload
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          // Loading: render the local file underneath so the user sees
          // their picture immediately instead of a blank spinner.
          if (localFile != null) {
            return Image.file(
              localFile,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
            );
          }
          return _buildImagePlaceholder();
        },
        errorBuilder: (_, __, ___) {
          // Remote failed — fall back to the local file if we still
          // have it, otherwise the placeholder.
          if (localFile != null) {
            return Image.file(localFile, fit: BoxFit.cover);
          }
          return _buildImagePlaceholder();
        },
      );
    }

    if (localFile != null) {
      return Image.file(
        localFile,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
      );
    }

    return _buildImagePlaceholder();
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 220,
      height: 150,
      color: const Color(0xFF2D2D2D),
      child: const Center(
        child: Icon(Icons.image, color: Color(0xFF9CA3AF), size: 40),
      ),
    );
  }

  Widget _buildVoiceBubble() {
    return _VoiceNotePlayer(
      localMediaPath: localMediaPath,
      mediaUrl: mediaUrl,
      audioDurationMs: audioDurationMs,
      transcript: transcript,
      isUser: isUser,
    );
  }
}

class _VoiceNotePlayer extends StatefulWidget {
  final String? localMediaPath;
  final String? mediaUrl;
  final int? audioDurationMs;
  final String? transcript;
  final bool isUser;

  const _VoiceNotePlayer({
    this.localMediaPath,
    this.mediaUrl,
    this.audioDurationMs,
    this.transcript,
    required this.isUser,
  });

  @override
  State<_VoiceNotePlayer> createState() => _VoiceNotePlayerState();
}

class _VoiceNotePlayerState extends State<_VoiceNotePlayer> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  bool _disposed = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _loadError = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      if (widget.localMediaPath != null && widget.localMediaPath!.isNotEmpty) {
        final file = File(widget.localMediaPath!);
        if (file.existsSync()) {
          await _player.setFilePath(widget.localMediaPath!);
        } else {
          _loadError = true;
        }
      } else if (widget.mediaUrl != null && widget.mediaUrl!.isNotEmpty) {
        // Guard the URL scheme the same way the image bubble does — an
        // expired tunnel URL, a relative path, or a non-http reference can
        // never be played, so treat it as a load error up front instead of
        // letting setUrl throw an opaque failure.
        final url = widget.mediaUrl!;
        if (url.startsWith('http://') || url.startsWith('https://')) {
          await _player.setUrl(url);
        } else {
          _loadError = true;
        }
      }

      if (_disposed) return;

      _duration = _player.duration ?? Duration.zero;
      if (_duration == Duration.zero && widget.audioDurationMs != null) {
        _duration = Duration(milliseconds: widget.audioDurationMs!);
      }

      _player.positionStream.listen((pos) {
        if (mounted && !_disposed) setState(() => _position = pos);
      });
      _player.playerStateStream.listen((state) {
        if (mounted && !_disposed) {
          setState(() => _isPlaying = state.playing);
          if (state.processingState == ProcessingState.completed) {
            _player.seek(Duration.zero);
            _player.pause();
          }
        }
      });
      if (mounted && !_disposed) setState(() {});
    } catch (_) {
      _loadError = true;
      // Audio load failed - show duration from metadata
      if (widget.audioDurationMs != null) {
        _duration = Duration(milliseconds: widget.audioDurationMs!);
        if (mounted && !_disposed) setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final mins = d.inMinutes;
    final secs = d.inSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.isUser ? const Color(0xFF3B82F6) : const Color(0xFF10B981);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _loadError
                  ? null
                  : () {
                      if (_isPlaying) {
                        _player.pause();
                      } else {
                        _player.play();
                      }
                    },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _loadError ? const Color(0xFF4B5563) : accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _loadError
                      ? Icons.error_outline
                      : (_isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Waveform visualization (simplified bars)
                  SizedBox(
                    height: 24,
                    width: 140,
                    child: CustomPaint(
                      painter: _WaveformPainter(
                        progress: _duration.inMilliseconds > 0
                            ? (_position.inMilliseconds / _duration.inMilliseconds)
                                .clamp(0.0, 1.0)
                            : 0.0,
                        activeColor: accentColor,
                        inactiveColor: const Color(0xFF4B5563),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (_loadError)
                    // Tell the user WHY the (disabled) play control won't
                    // respond — without this the duration still shows and the
                    // greyed button reads as "not yet tapped" rather than failed.
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.cloud_off_outlined,
                          color: Color(0xFFEF4444),
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Audio unavailable',
                          style: TextStyle(
                            color: widget.isUser
                                ? Colors.white70
                                : const Color(0xFFEF4444),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      _isPlaying
                          ? _formatDuration(_position)
                          : _formatDuration(_duration),
                      style: TextStyle(
                        color: widget.isUser ? Colors.white70 : const Color(0xFF9CA3AF),
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (widget.transcript != null && widget.transcript!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            // Limit transcript display to 500 chars to prevent layout overflow
            widget.transcript!.length > 500
                ? '${widget.transcript!.substring(0, 500)}...'
                : widget.transcript!,
            style: TextStyle(
              color: widget.isUser ? Colors.white : const Color(0xFFD1D5DB),
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  _WaveformPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const barCount = 28;
    final barWidth = size.width / (barCount * 2);
    // Pre-determined "waveform" heights for visual effect
    const heights = [
      0.3, 0.5, 0.7, 0.4, 0.9, 0.6, 0.8, 0.3, 0.7, 0.5,
      0.9, 0.4, 0.6, 0.8, 0.3, 0.7, 0.5, 0.9, 0.4, 0.6,
      0.8, 0.5, 0.3, 0.7, 0.9, 0.4, 0.6, 0.5,
    ];

    for (int i = 0; i < barCount; i++) {
      final x = i * barWidth * 2 + barWidth / 2;
      final h = heights[i % heights.length] * size.height;
      final top = (size.height - h) / 2;
      final isActive = i / barCount <= progress;

      final paint = Paint()
        ..color = isActive ? activeColor : inactiveColor
        ..strokeWidth = barWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(Offset(x, top), Offset(x, top + h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
