part of 'payment_success_screen.dart';

class _ConfettiParticle {
  final Color color;
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double size;
  final double rotation;
  final double rotationSpeed;

  _ConfettiParticle({
    required this.color,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final x = size.width * (p.startX + (p.endX - p.startX) * progress);
      final y = size.height * (p.startY + (p.endY - p.startY) * progress);
      final opacity = (1.0 - progress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity * 0.8)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation + p.rotationSpeed * progress);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5),
          const Radius.circular(1),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
