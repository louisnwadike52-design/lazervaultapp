import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
      return _buildImageBubble();
    } else if (mediaType == 'voice') {
      return _buildVoiceBubble();
    }
    return const SizedBox.shrink();
  }

  Widget _buildImageBubble() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220, maxHeight: 220),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (localMediaPath != null && localMediaPath!.isNotEmpty) {
      final file = File(localMediaPath!);
      try {
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
          );
        }
      } catch (_) {
        // File access error (deleted, permissions)
      }
    }
    if (mediaUrl != null &&
        mediaUrl!.isNotEmpty &&
        (mediaUrl!.startsWith('http://') || mediaUrl!.startsWith('https://'))) {
      return Image.network(
        mediaUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Container(
            width: 220,
            height: 150,
            color: const Color(0xFF2D2D2D),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF3B82F6),
              ),
            ),
          );
        },
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
        await _player.setUrl(widget.mediaUrl!);
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
