part of 'deposit_success_screen.dart';

class CheckmarkPainter extends CustomPainter {
  final double progress;

  CheckmarkPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final checkPath = Path();
    
    // Define checkmark points
    final startPoint = Offset(center.dx - 15, center.dy);
    final middlePoint = Offset(center.dx - 5, center.dy + 10);
    final endPoint = Offset(center.dx + 15, center.dy - 10);

    if (progress <= 0.5) {
      // First half: draw line from start to middle
      final currentProgress = progress * 2;
      final currentPoint = Offset.lerp(startPoint, middlePoint, currentProgress)!;
      checkPath.moveTo(startPoint.dx, startPoint.dy);
      checkPath.lineTo(currentPoint.dx, currentPoint.dy);
    } else {
      // Second half: draw line from middle to end
      final currentProgress = (progress - 0.5) * 2;
      final currentPoint = Offset.lerp(middlePoint, endPoint, currentProgress)!;
      checkPath.moveTo(startPoint.dx, startPoint.dy);
      checkPath.lineTo(middlePoint.dx, middlePoint.dy);
      checkPath.lineTo(currentPoint.dx, currentPoint.dy);
    }

    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
