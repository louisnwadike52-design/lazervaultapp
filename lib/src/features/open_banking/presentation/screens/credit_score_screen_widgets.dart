part of 'credit_score_screen.dart';

class _FactorData {
  final String label;
  final double score;
  final int weight;
  final IconData icon;

  const _FactorData(this.label, this.score, this.weight, this.icon);
}

class _CreditScoreGaugePainter extends CustomPainter {
  final int score;
  final double animationValue;
  final Color ratingColor;

  _CreditScoreGaugePainter({
    required this.score,
    required this.animationValue,
    required this.ratingColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 12;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    const startAngle = 2.4; // ~137 degrees
    const sweepAngle = 4.3; // ~246 degrees (total arc)

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Score arc
    final scorePercent = ((score - 300) / 550).clamp(0.0, 1.0);
    final scoreSweep = sweepAngle * scorePercent * animationValue;

    final scorePaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        colors: [
          ratingColor.withValues(alpha: 0.6),
          ratingColor,
        ],
        startAngle: startAngle,
        endAngle: startAngle + scoreSweep,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    if (scoreSweep > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        scoreSweep,
        false,
        scorePaint,
      );
    }

    // Scale labels
    final textStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.4),
      fontSize: 10,
    );
    final labels = ['300', '450', '600', '750', '850'];
    final angles = [startAngle, startAngle + sweepAngle * 0.27, startAngle + sweepAngle * 0.545, startAngle + sweepAngle * 0.818, startAngle + sweepAngle];
    final labelRadius = radius + 20;

    for (var i = 0; i < labels.length; i++) {
      final x = center.dx + labelRadius * math.cos(angles[i]);
      final y = center.dy + labelRadius * math.sin(angles[i]);
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _CreditScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.ratingColor != ratingColor;
  }
}
