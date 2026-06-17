import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';

/// Circular arc gauge showing time elapsed for a subscription.
/// Uses CustomPaint with Canvas.drawArc.
class SubscriptionExpiryGauge extends StatelessWidget {
  final ActiveSubscriptionEntity subscription;
  final double size;

  const SubscriptionExpiryGauge({
    super.key,
    required this.subscription,
    this.size = 200,
  });

  Color get _gaugeColor {
    if (!subscription.hasExpiry) return const Color(0xFF9CA3AF);
    if (subscription.isExpired) return const Color(0xFFEF4444);
    if (subscription.daysRemaining <= 3) return const Color(0xFFFB923C);
    return const Color(0xFF10B981);
  }

  double get _progress {
    if (!subscription.hasExpiry) return 1.0;
    if (subscription.validityDays <= 0) return 0.0;
    return (subscription.progressPercentage / 100).clamp(0.0, 1.0);
  }

  String get _centerText {
    if (!subscription.hasExpiry) return 'No expiry';
    if (subscription.isExpired) return 'Expired';
    return '${subscription.daysRemaining}';
  }

  String get _subText {
    if (!subscription.hasExpiry) return '';
    if (subscription.isExpired) return '';
    return 'days left';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ExpiryGaugePainter(
          progress: _progress,
          color: _gaugeColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _centerText,
                style: TextStyle(
                  color: _gaugeColor,
                  fontSize: size * 0.18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_subText.isNotEmpty)
                Text(
                  _subText,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: size * 0.08,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpiryGaugePainter extends CustomPainter {
  final double progress;
  final Color color;

  _ExpiryGaugePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 12;
    const strokeWidth = 10.0;
    const startAngle = 2.35619; // 135 degrees in radians
    const sweepTotal = 4.71239; // 270 degrees in radians

    // Background track
    final bgPaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepTotal,
      false,
      bgPaint,
    );

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepTotal * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ExpiryGaugePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
