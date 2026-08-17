part of 'contribution_chat_bottom_sheet.dart';

class _ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String? body;
  final _MessageKind kind;
  final int? durationSeconds;
  final String? mediaUrl;
  final DateTime sentAt;

  const _ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.kind,
    required this.sentAt,
    this.body,
    this.durationSeconds,
    this.mediaUrl,
  });

  factory _ChatMessage.fromJson(Map<String, dynamic> j) {
    final kindStr = (j['kind'] ?? 'text') as String;
    _MessageKind k;
    switch (kindStr) {
      case 'voice':
        k = _MessageKind.voice;
        break;
      case 'image':
        k = _MessageKind.image;
        break;
      default:
        k = _MessageKind.text;
    }
    final createdAt = DateTime.tryParse((j['createdAt'] ?? '') as String) ??
        DateTime.now();
    final durMs = (j['durationMs'] is int)
        ? j['durationMs'] as int
        : int.tryParse('${j['durationMs'] ?? ''}') ?? 0;
    return _ChatMessage(
      id: (j['id'] ?? '') as String,
      senderId: (j['senderId'] ?? '') as String,
      senderName: (j['senderName'] ?? '') as String,
      kind: k,
      body: (j['body'] ?? '') as String,
      mediaUrl: (j['mediaUrl'] ?? '') as String,
      durationSeconds: durMs > 0 ? (durMs / 1000).round() : null,
      sentAt: createdAt,
    );
  }
}

enum _MessageKind { text, voice, image }

/// Local-only bubble shown for media that is uploading or just
/// failed. Lives in `_pending` (parallel to `_messages`) so we can
/// render an instant preview while the multipart round-trip is in
/// flight, and surface a tap-to-retry treatment when it errors.
///
/// Removed when the round-trip succeeds — the parent state then
/// relies on the canonical message returned by send (and any later
/// poll tick) for display. We deliberately don't try to merge the
/// two paths into one model: pending bubbles need a local file path
/// that real messages don't (and shouldn't) carry.
class _PendingBubble {
  final String clientId;
  final _MessageKind kind;
  final String? localPath;
  final int? durationMs;
  final DateTime sentAt;
  bool failed;
  String? errorMessage;

  _PendingBubble({
    required this.clientId,
    required this.kind,
    required this.sentAt,
    this.localPath,
    this.durationMs,
  })  : failed = false,
        errorMessage = null;
}

/// Paints a chat bubble background with an asymmetric "tail" protruding
/// at the bottom on the side belonging to the sender. The tail mimics
/// the speech-bubble pointer used by WhatsApp / iMessage / Telegram.
///
/// Geometry:
///   - The main rounded rect occupies the full width minus `tailSize`,
///     leaving a margin on the tail side for the triangular pointer.
///   - The tail is a small triangle anchored at the bottom corner of
///     the bubble, jutting outward toward the avatar / edge of the
///     screen.
///   - All four corners have radius `radius` except the tail-side
///     bottom corner, which is squared (`tailCornerRadius` = 2) so the
///     tail flows naturally out of the body.
class _BubblePainter extends CustomPainter {
  final Color color;
  final bool isMe;
  final double tailSize;
  final double radius;

  const _BubblePainter({
    required this.color,
    required this.isMe,
    required this.tailSize,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;
    const tailCornerRadius = 2.0;

    if (isMe) {
      // Body: occupy left/center, leave `tailSize` on the right edge.
      final body = Rect.fromLTWH(0, 0, w - tailSize, h);
      final rect = RRect.fromRectAndCorners(
        body,
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: const Radius.circular(tailCornerRadius),
      );
      canvas.drawRRect(rect, paint);

      // Tail: small right-leaning triangle anchored at body's
      // bottom-right edge. Sits below the rect so it appears as a
      // single connected shape.
      final tail = Path()
        ..moveTo(w - tailSize, h - tailSize - 2)
        ..lineTo(w, h)
        ..lineTo(w - tailSize, h)
        ..close();
      canvas.drawPath(tail, paint);
    } else {
      // Mirrored: leave `tailSize` on the left edge.
      final body = Rect.fromLTWH(tailSize, 0, w - tailSize, h);
      final rect = RRect.fromRectAndCorners(
        body,
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: const Radius.circular(tailCornerRadius),
        bottomRight: Radius.circular(radius),
      );
      canvas.drawRRect(rect, paint);

      final tail = Path()
        ..moveTo(tailSize, h - tailSize - 2)
        ..lineTo(0, h)
        ..lineTo(tailSize, h)
        ..close();
      canvas.drawPath(tail, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BubblePainter old) {
    return old.color != color ||
        old.isMe != isMe ||
        old.tailSize != tailSize ||
        old.radius != radius;
  }
}

/// Voice-note bubble with play/pause + waveform-stub progress bar.
/// Uses just_audio for streaming playback. Each bubble owns its own
/// player so multiple notes can be paused/resumed independently;
/// memory cost is bounded because just_audio releases buffers when
/// the player is disposed.
class _VoiceBubble extends StatefulWidget {
  final String url;
  final int? durationSeconds;
  final Color accent;

  const _VoiceBubble({
    required this.url,
    required this.accent,
    this.durationSeconds,
  });

  @override
  State<_VoiceBubble> createState() => _VoiceBubbleState();
}

class _VoiceBubbleState extends State<_VoiceBubble> {
  AudioPlayer? _player;
  bool _ready = false;
  Duration _position = Duration.zero;
  Duration? _duration;

  Future<void> _ensurePlayer() async {
    if (_player != null) return;
    final p = AudioPlayer();
    _player = p;
    p.positionStream.listen((d) {
      if (mounted) setState(() => _position = d);
    });
    p.playerStateStream.listen((s) {
      if (s.processingState == ProcessingState.completed && mounted) {
        setState(() => _position = Duration.zero);
        p.pause();
        p.seek(Duration.zero);
      }
    });
    try {
      _duration = await p.setUrl(widget.url);
      if (mounted) setState(() => _ready = true);
    } catch (_) {
      if (mounted) setState(() => _ready = false);
    }
  }

  Future<void> _toggle() async {
    await _ensurePlayer();
    final p = _player;
    if (p == null) return;
    if (p.playing) {
      await p.pause();
    } else {
      await p.play();
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playing = _player?.playing ?? false;
    final totalSec = (_duration?.inMilliseconds ?? 0) > 0
        ? _duration!.inMilliseconds / 1000
        : (widget.durationSeconds ?? 0).toDouble();
    final pct = totalSec > 0
        ? (_position.inMilliseconds / 1000 / totalSec).clamp(0.0, 1.0)
        : 0.0;
    final remainingLabel = totalSec > 0
        ? '${(totalSec - _position.inMilliseconds / 1000).clamp(0, totalSec).toStringAsFixed(0)}s'
        : '${widget.durationSeconds ?? 0}s';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: Icon(
            _player == null
                ? Icons.play_circle_outline
                : (playing ? Icons.pause_circle_filled : Icons.play_circle_filled),
            color: widget.accent,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: 110.w,
          height: 4.h,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.accent.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: pct,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.accent,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          _ready ? remainingLabel : '${widget.durationSeconds ?? 0}s',
          style: GoogleFonts.inter(color: widget.accent, fontSize: 11.sp),
        ),
      ],
    );
  }
}
