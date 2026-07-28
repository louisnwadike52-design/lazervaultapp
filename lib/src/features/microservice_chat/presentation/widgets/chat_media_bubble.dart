import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lazervault/src/features/ai_chats/presentation/widgets/fullscreen_image_viewer.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_voice_note_player.dart';

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

/// Voice-note bubble. Stateless — it OWNS no player; it observes and drives the
/// shared [ChatVoiceNotePlayer] so playback survives this widget being disposed
/// when the list scrolls it off-screen. Only the currently-playing note rebuilds
/// on position ticks; every other bubble rebuilds only when the active note
/// changes.
class _VoiceNotePlayer extends StatelessWidget {
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

  /// Stable id for this note in the shared player (remote URL > local path).
  String get _noteId {
    final remote = mediaUrl;
    if (remote != null && remote.isNotEmpty) return remote;
    final local = localMediaPath;
    if (local != null && local.isNotEmpty) return local;
    return 'voice-${identityHashCode(this)}';
  }

  Duration get _fallbackDuration => audioDurationMs != null
      ? Duration(milliseconds: audioDurationMs!)
      : Duration.zero;

  String _formatDuration(Duration d) {
    final mins = d.inMinutes;
    final secs = d.inSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _onTap() {
    ChatVoiceNotePlayer.instance.toggle(
      _noteId,
      localPath: localMediaPath,
      mediaUrl: mediaUrl,
      fallbackDurationMs: audioDurationMs,
    );
  }

  void _seekAt(double localX, double width) {
    if (width <= 0) return;
    ChatVoiceNotePlayer.instance.seekTo(
      _noteId,
      localX / width,
      localPath: localMediaPath,
      mediaUrl: mediaUrl,
      fallbackDurationMs: audioDurationMs,
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = ChatVoiceNotePlayer.instance;
    final accentColor = isUser ? const Color(0xFF3B82F6) : const Color(0xFF10B981);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Outer: rebuild only when the ACTIVE note changes (rare).
        ValueListenableBuilder<String?>(
          valueListenable: player.currentId,
          builder: (context, currentId, _) {
            final isCurrent = currentId == _noteId;
            if (!isCurrent) {
              // Not the active note. Show the real clip length: prefer the
              // duration the sender provided, else the lazily-probed value from
              // the cache (fixes the "00:00 until played" bug on received
              // notes). Trigger a one-time probe when we still have nothing.
              return ValueListenableBuilder<Duration?>(
                valueListenable:
                    VoiceNoteDurationCache.instance.listenable(_noteId),
                builder: (context, cached, _) {
                  var dur = _fallbackDuration;
                  if (dur <= Duration.zero && cached != null) dur = cached;
                  if (dur <= Duration.zero) {
                    VoiceNoteDurationCache.instance.probe(
                      _noteId,
                      localPath: localMediaPath,
                      mediaUrl: mediaUrl,
                    );
                  }
                  return _buildRow(
                    accentColor: accentColor,
                    isPlaying: false,
                    progress: 0.0,
                    timeLabel: _formatDuration(dur),
                    hasError: false,
                  );
                },
              );
            }
            // This is the active note — reflect error / live position.
            return ValueListenableBuilder<String?>(
              valueListenable: player.errorId,
              builder: (context, errorId, _) {
                if (errorId == _noteId) {
                  return _buildRow(
                    accentColor: accentColor,
                    isPlaying: false,
                    progress: 0.0,
                    timeLabel: '',
                    hasError: true,
                  );
                }
                return AnimatedBuilder(
                  animation: Listenable.merge(
                      [player.playing, player.position, player.duration]),
                  builder: (context, _) {
                    final dur = player.duration.value > Duration.zero
                        ? player.duration.value
                        : _fallbackDuration;
                    final pos = player.position.value;
                    final isPlaying = player.playing.value;
                    final progress = dur.inMilliseconds > 0
                        ? (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0)
                        : 0.0;
                    return _buildRow(
                      accentColor: accentColor,
                      isPlaying: isPlaying,
                      progress: progress,
                      timeLabel:
                          isPlaying ? _formatDuration(pos) : _formatDuration(dur),
                      hasError: false,
                    );
                  },
                );
              },
            );
          },
        ),
        if (transcript != null && transcript!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            // Limit transcript display to 500 chars to prevent layout overflow
            transcript!.length > 500
                ? '${transcript!.substring(0, 500)}...'
                : transcript!,
            style: TextStyle(
              color: isUser ? Colors.white : const Color(0xFFD1D5DB),
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRow({
    required Color accentColor,
    required bool isPlaying,
    required double progress,
    required String timeLabel,
    required bool hasError,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: hasError ? null : _onTap,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: hasError ? const Color(0xFF4B5563) : accentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasError
                  ? Icons.error_outline
                  : (isPlaying ? Icons.pause : Icons.play_arrow),
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
              // Tap a position on the waveform to seek there (maps the local
              // x-offset to a 0..1 fraction, loading the note first if it isn't
              // active). Uses onTapUp — NOT a drag handler — so a horizontal
              // drag on the waveform is NOT consumed here and bubbles up to the
              // bubble's swipe-to-reply gesture. Disabled when the clip errored.
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp:
                    hasError ? null : (d) => _seekAt(d.localPosition.dx, 140),
                child: SizedBox(
                  height: 24,
                  width: 140,
                  child: CustomPaint(
                    painter: _WaveformPainter(
                      progress: progress,
                      activeColor: accentColor,
                      inactiveColor: const Color(0xFF4B5563),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              if (hasError)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off_outlined,
                        color: Color(0xFFEF4444), size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'Audio unavailable',
                      style: TextStyle(
                        color: isUser ? Colors.white70 : const Color(0xFFEF4444),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  timeLabel,
                  style: TextStyle(
                    color: isUser ? Colors.white70 : const Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
            ],
          ),
        ),
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
