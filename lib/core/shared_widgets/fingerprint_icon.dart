import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The fingerprint glyph, drawn as a vector.
///
/// The companion to [FaceIdIcon] — `Icons.fingerprint` is a dense Material
/// glyph whose ridges merge into a blob at the sizes we use it (a 22sp tile
/// icon, a lock-screen button), and it sits badly next to the hand-drawn Face
/// ID mark. Being a path rather than a bitmap it takes any [color] and stays
/// crisp at any [size].
///
/// WHY IT IS DRAWN THE WAY IT IS
/// -----------------------------
/// The first version of this painter was reported from the field as looking
/// like a Wi-Fi symbol, and it did. Wi-Fi is: concentric arcs, all struck from
/// one centre, opening DOWNWARD, each inner arc SHORTER than the one outside
/// it, with a mark at the bottom centre. That was an exact description of the
/// old geometry — four concentric arcs with sweeps shrinking 230°, 209°, 184°,
/// 158°, and a tick at the core.
///
/// A fingerprint is the opposite on every one of those points, so this draws:
///
///   * ridges that WRAP FURTHER as they go inward, not less — the single
///     strongest cue, because it inverts the Wi-Fi silhouette outright;
///   * a gap at the bottom that NARROWS inward, so the eye reads nested
///     fingertip ridges rather than a broadcast fan;
///   * centres that drift upward as the ridges tighten, so they are not
///     concentric — concentric rings read as radar or a target;
///   * a whorl at the core, a small hooked curve, instead of a dot or a
///     straight tick. A straight mark at the centre of nested arcs is the
///     Wi-Fi emitter; a hook is unmistakably a fingerprint.
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
          size: Size(size, size),
          painter: _FingerprintPainter(
            color: color,
            strokeWidth: strokeWidth ?? (size * 0.085).clamp(1.4, 2.6),
          ),
        ),
      );
}

/// The ridge table: `radius` · `bottomGapDegrees` · `centreLiftUnits`,
/// outermost first.
///
/// Exposed so the property that stops this glyph reading as Wi-Fi can be
/// asserted by a test rather than only described in a comment: the bottom gap
/// must shrink inward, i.e. inner ridges wrap FURTHER than outer ones. Wi-Fi
/// is the exact inverse, and that inversion is what the field report was
/// seeing. See fingerprint_icon_test.dart.
@visibleForTesting
const List<List<double>> kFingerprintRidges = <List<double>>[
  [10.0, 56.0, 0.00],
  [7.7, 44.0, 0.35],
  [5.4, 34.0, 0.70],
  [3.2, 26.0, 1.05],
];

class _FingerprintPainter extends CustomPainter {
  const _FingerprintPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  static const double _deg = math.pi / 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Centre sits slightly below the middle: the ridges open downward, so an
    // optically centred glyph needs the core lower than the geometric centre.
    final centre = Offset(size.width / 2, size.height * 0.54);
    final unit = size.width / 24;

    // Ridges, outermost first:
    //   radius · bottom gap (degrees) · how far the centre lifts (units)
    //
    // Flutter angles run clockwise from 3 o'clock with y downward, so 90° is
    // straight down. Each ridge is centred on that bottom point and the gap is
    // carved out of it, which is what keeps the opening square at the base
    // instead of listing to one side.
    //
    // The gap SHRINKS inward (56° → 26°) so inner ridges wrap further, and the
    // centre lifts as it tightens so the ridges nest rather than sit concentric.
    for (final r in kFingerprintRidges) {
      final radius = r[0] * unit;
      final gap = r[1];
      final lift = r[2] * unit;
      // Start just past the bottom gap and sweep clockwise all the way round
      // to its other edge.
      final start = (90.0 + gap / 2) * _deg;
      final sweep = (360.0 - gap) * _deg;
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(centre.dx, centre.dy - lift),
          width: radius * 2,
          // Taller than wide — a fingertip is an oval, and a circular version
          // reads as a target/radar mark instead.
          height: radius * 2.16,
        ),
        start,
        sweep,
        false,
        paint,
      );
    }

    // The core whorl: a hook, not a dot and not a straight tick. It starts
    // inside the innermost ridge and curls back on itself, which is the detail
    // that finally separates this glyph from anything broadcast-shaped.
    final whorl = Path()
      ..moveTo(centre.dx + unit * 1.1, centre.dy - unit * 1.5)
      ..cubicTo(
        centre.dx - unit * 1.4, centre.dy - unit * 2.2, // pull left and up
        centre.dx - unit * 1.5, centre.dy + unit * 0.6, // round the bottom
        centre.dx + unit * 0.5, centre.dy + unit * 0.2, // hook back right
      );
    canvas.drawPath(whorl, paint);
  }

  @override
  bool shouldRepaint(_FingerprintPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}
