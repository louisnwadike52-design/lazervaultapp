import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The fingerprint glyph, drawn as a vector.
///
/// The companion to [FaceIdIcon] — `Icons.fingerprint` is a dense Material
/// glyph whose ridges merge into a blob at the sizes we use it (a 22sp tile
/// icon, a lock-screen button), and it sits badly next to the hand-drawn Face
/// ID mark. This draws fewer, cleaner ridges: concentric arcs of decreasing
/// span around a central core, which is what reads as "fingerprint" at a
/// glance. Being a path rather than a bitmap it takes any [color] and stays
/// crisp at any [size].
class FingerprintIcon extends StatelessWidget {
  const FingerprintIcon({
    super.key,
    this.size = 24,
    this.color = Colors.white,
    this.strokeWidth,
  });

  final double size;
  final Color color;

  /// Defaults to a proportion of [size] so the glyph keeps its weight when
  /// scaled, rather than looking spindly when large and clogged when small.
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _FingerprintPainter(
            color: color,
            strokeWidth: strokeWidth ?? (size * 0.085).clamp(1.4, 2.6),
          ),
        ),
      );
}

class _FingerprintPainter extends CustomPainter {
  const _FingerprintPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Centre sits slightly below the middle: the ridges open downward, so an
    // optically centred glyph needs the core lower than the geometric centre.
    final centre = Offset(size.width / 2, size.height * 0.54);
    final unit = size.width / 24;

    // Ridges, outermost first. Each is an arc rather than a full ellipse —
    // real fingerprint marks are open at the bottom, and the decreasing sweep
    // is what stops the inner ridges reading as concentric circles.
    // (radius, start angle, sweep) in units of `unit` and radians.
    const ridges = <List<double>>[
      [10.0, math.pi * 0.86, math.pi * 1.28],
      [7.6, math.pi * 0.92, math.pi * 1.16],
      [5.2, math.pi * 0.99, math.pi * 1.02],
      [2.8, math.pi * 1.06, math.pi * 0.88],
    ];

    for (final r in ridges) {
      final radius = r[0] * unit;
      canvas.drawArc(
        Rect.fromCenter(
          center: centre,
          width: radius * 2,
          // Slightly taller than wide — a fingertip is an oval, and a circular
          // version of this reads as a target/radar mark instead.
          height: radius * 2.16,
        ),
        r[1],
        r[2],
        false,
        paint,
      );
    }

    // The core: a short vertical tick rather than a dot, which is what keeps
    // the centre from looking like a bullseye.
    canvas.drawLine(
      Offset(centre.dx, centre.dy - unit * 1.1),
      Offset(centre.dx, centre.dy + unit * 0.9),
      paint,
    );
  }

  @override
  bool shouldRepaint(_FingerprintPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}
