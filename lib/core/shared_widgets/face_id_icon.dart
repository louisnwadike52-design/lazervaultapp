import 'package:flutter/material.dart';

/// The Face ID glyph, drawn as a vector.
///
/// Material has no real Face ID icon — `Icons.face` is a filled cartoon head
/// and `Icons.face_outlined` a smiley, neither of which reads as face
/// authentication next to a passcode keypad. This draws the shape people
/// actually recognise: four corner brackets framing a face, with eyes, nose
/// and smile. Being a path rather than a bitmap it takes any [color] and stays
/// crisp at any [size], which the PNGs in assets/images cannot do.
class FaceIdIcon extends StatelessWidget {
  const FaceIdIcon({
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
          painter: _FaceIdPainter(
            color: color,
            strokeWidth: strokeWidth ?? (size * 0.085).clamp(1.4, 2.6),
          ),
        ),
      );
}

class _FaceIdPainter extends CustomPainter {
  const _FaceIdPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;
    // Corner brackets: an arm's length and corner radius proportional to the
    // box, so the frame reads the same at 18px in a button and 64px on a
    // settings header.
    final arm = w * 0.26;
    final r = w * 0.20;
    final inset = w * 0.045;

    final l = inset, t = inset, rt = w - inset, b = h - inset;

    // top-left
    canvas.drawPath(
      Path()
        ..moveTo(l, t + arm)
        ..lineTo(l, t + r)
        ..arcToPoint(Offset(l + r, t), radius: Radius.circular(r))
        ..lineTo(l + arm, t),
      p,
    );
    // top-right
    canvas.drawPath(
      Path()
        ..moveTo(rt - arm, t)
        ..lineTo(rt - r, t)
        ..arcToPoint(Offset(rt, t + r), radius: Radius.circular(r))
        ..lineTo(rt, t + arm),
      p,
    );
    // bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(rt, b - arm)
        ..lineTo(rt, b - r)
        ..arcToPoint(Offset(rt - r, b), radius: Radius.circular(r))
        ..lineTo(rt - arm, b),
      p,
    );
    // bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(l + arm, b)
        ..lineTo(l + r, b)
        ..arcToPoint(Offset(l, b - r), radius: Radius.circular(r))
        ..lineTo(l, b - arm),
      p,
    );

    // Face. Slightly lighter stroke than the frame so the brackets stay the
    // dominant shape and the features don't crowd them at small sizes.
    final f = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.92
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    // Eyes — short vertical strokes, the detail that makes it read as Face ID
    // rather than a generic frame.
    final eyeTop = h * 0.35;
    final eyeBottom = h * 0.45;
    canvas.drawLine(Offset(w * 0.35, eyeTop), Offset(w * 0.35, eyeBottom), f);
    canvas.drawLine(Offset(w * 0.65, eyeTop), Offset(w * 0.65, eyeBottom), f);

    // Nose — down-stroke with a small hook to the right.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.50, h * 0.38)
        ..lineTo(w * 0.50, h * 0.55)
        ..lineTo(w * 0.565, h * 0.55),
      f,
    );

    // Smile.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.34, h * 0.64)
        ..quadraticBezierTo(w * 0.50, h * 0.755, w * 0.66, h * 0.64),
      f,
    );
  }

  @override
  bool shouldRepaint(covariant _FaceIdPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}
