part of 'voice_command_sheet.dart';

/// Three dots that bounce in sequence — the classic "typing…" indicator.
class _TypingDots extends StatefulWidget {
  final Color color;
  const _TypingDots({required this.color});

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            // Stagger each dot's phase so they bounce in sequence.
            final phase = (_controller.value + (i * 0.2)) % 1.0;
            // Bounce: rise then fall over the first ~60% of the phase.
            final t = phase < 0.6 ? (phase / 0.6) : 0.0;
            final lift = (t == 0.0 ? 0.0 : (1 - (2 * t - 1).abs())) * 4.0;
            return Padding(
              padding: EdgeInsets.only(right: i < 2 ? 4.w : 0),
              child: Transform.translate(
                offset: Offset(0, -lift),
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.45 + (lift / 4.0) * 0.55),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Identity for the "Your Voice" (cloned voice) row in the voice picker.
class _YourVoiceInfo {
  final String name;
  final String? username;
  final String? avatarUrl;

  const _YourVoiceInfo({
    required this.name,
    this.username,
    this.avatarUrl,
  });
}

/// Static, full-bleed watermark drawn behind the sheet content: a set of faint
/// flowing topographic-style curves in near-white at very low opacity
/// (alpha ~0.03–0.06). Non-animated so it never competes with the live
/// conversation; the dark gradient scrim in front keeps content readable.
class _VoiceWatermarkPainter extends CustomPainter {
  const _VoiceWatermarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    const int lineCount = 12;
    const int segments = 5;
    for (int i = 0; i < lineCount; i++) {
      final double progress = i / (lineCount - 1);
      final double baseY = size.height * (0.06 + progress * 0.9);
      // Amplitude peaks toward the middle of the sheet for a gentle topographic
      // bulge, tapering near the top/bottom edges.
      final double amplitude =
          size.height * (0.02 + 0.032 * sin(progress * pi));
      // Clearly visible (was a near-invisible 0.03–0.06 white). Branded lavender
      // purple, opacity peaks mid-sheet (~0.10–0.20) so the flowing topographic
      // lines read as an intentional voice-conversation backdrop.
      final double alpha = 0.10 + 0.10 * sin(progress * pi);
      paint.color = const Color(0xFF9B87F5).withValues(alpha: alpha);

      final path = Path()..moveTo(-24, baseY);
      for (int s = 0; s < segments; s++) {
        final double cx = size.width * ((s + 0.5) / segments);
        final double cy = baseY + amplitude * (s.isEven ? -1.0 : 1.0);
        final double ex = size.width * ((s + 1) / segments) + 24;
        final double ey = baseY + amplitude * (s.isEven ? 1.0 : -1.0) * 0.35;
        path.quadraticBezierTo(cx, cy, ex, ey);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _VoiceWatermarkPainter oldDelegate) => false;
}
