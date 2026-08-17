part of 'smart_trading_screen.dart';

// =============================================================================
// Fear & Greed Gauge Painter
// =============================================================================

class _FearGreedGaugePainter extends CustomPainter {
  final int value;
  final Color color;

  _FearGreedGaugePainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const startAngle = 2.35619; // 135 degrees in radians
    const sweepAngle = 4.71239; // 270 degrees in radians

    // Background arc
    final bgPaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Gradient arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: const [
        Color(0xFFEF4444), // Red (Extreme Fear)
        Color(0xFFFF6B35), // Orange
        Color(0xFFFBBF24), // Yellow (Neutral)
        Color(0xFF34D399), // Light green
        Color(0xFF10B981), // Green (Extreme Greed)
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final valueFraction = value / 100.0;
    final valueSweep = sweepAngle * valueFraction;

    final fgPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, valueSweep, false, fgPaint);

    // Needle dot at the end of the value arc
    final needleAngle = startAngle + valueSweep;
    final dotCenter = Offset(
      center.dx + radius * math.cos(needleAngle),
      center.dy + radius * math.sin(needleAngle),
    );
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(dotCenter, 6, dotPaint);
    final dotBorderPaint = Paint()
      ..color = _kBg
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(dotCenter, 6, dotBorderPaint);
  }

  @override
  bool shouldRepaint(covariant _FearGreedGaugePainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.color != color;
}
