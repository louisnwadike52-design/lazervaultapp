part of 'stocks.dart';

// Custom painter for mini chart
class MiniChartPainter extends CustomPainter {
  final List<double> points;
  final bool isUp;

  MiniChartPainter({required this.points, required this.isUp});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isUp ? Colors.green : Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width / (points.length - 1);
    final max = points.reduce((a, b) => a > b ? a : b);
    final min = points.reduce((a, b) => a < b ? a : b);
    final range = max - min;

    if (range == 0) return;

    path.moveTo(0, size.height * (1 - (points[0] - min) / range));

    for (var i = 1; i < points.length; i++) {
      path.lineTo(
        width * i,
        size.height * (1 - (points[i] - min) / range),
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
