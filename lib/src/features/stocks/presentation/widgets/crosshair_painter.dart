import 'package:flutter/material.dart';
import '../../domain/entities/stock_entity.dart';

class CrosshairPainter extends CustomPainter {
  final Offset position;
  final List<StockPrice> priceHistory;
  final double maxPrice;
  final double minPrice;

  CrosshairPainter({
    required this.position,
    required this.priceHistory,
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty) return;

    final priceRange = maxPrice - minPrice;
    if (priceRange == 0) return;

    // Add padding
    final padding = priceRange * 0.1;
    final chartMinPrice = minPrice - padding;
    final chartMaxPrice = maxPrice + padding;
    final chartPriceRange = chartMaxPrice - chartMinPrice;

    final chartHeight = size.height * 0.85;
    final chartTop = size.height * 0.075;
    final chartLeft = size.width * 0.05;
    final chartWidth = size.width * 0.9;

    // Crosshair lines
    final crosshairPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Vertical line
    canvas.drawLine(
      Offset(position.dx, chartTop),
      Offset(position.dx, chartTop + chartHeight),
      crosshairPaint,
    );

    // Horizontal line
    canvas.drawLine(
      Offset(chartLeft, position.dy),
      Offset(chartLeft + chartWidth, position.dy),
      crosshairPaint,
    );

    // Calculate price at crosshair position
    final priceAtPosition = chartMaxPrice - ((position.dy - chartTop) / chartHeight) * chartPriceRange;
    
    // Calculate time index at crosshair position
    final indexAtPosition = ((position.dx - chartLeft) / chartWidth * (priceHistory.length - 1)).round();
    
    if (indexAtPosition >= 0 && indexAtPosition < priceHistory.length) {
      final priceData = priceHistory[indexAtPosition];
      
      // Draw price label
      _drawPriceLabel(canvas, size, position.dy, priceAtPosition);
      
      // Draw time label
      _drawTimeLabel(canvas, size, position.dx, priceData.timestamp);
      
      // Draw OHLC info box
      _drawOHLCInfo(canvas, size, position, priceData);
    }
  }

  void _drawPriceLabel(Canvas canvas, Size size, double y, double price) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: price.toStringAsFixed(2),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final labelX = size.width - textPainter.width - 8;
    final labelY = y - textPainter.height / 2;

    // Background
    final bgPaint = Paint()..color = Colors.black.withValues(alpha: 0.8);
    canvas.drawRect(
      Rect.fromLTWH(labelX - 4, labelY - 2, textPainter.width + 8, textPainter.height + 4),
      bgPaint,
    );

    // Border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(labelX - 4, labelY - 2, textPainter.width + 8, textPainter.height + 4),
      borderPaint,
    );

    textPainter.paint(canvas, Offset(labelX, labelY));
  }

  void _drawTimeLabel(Canvas canvas, Size size, double x, DateTime time) {
    final timeText = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    
    final textPainter = TextPainter(
      text: TextSpan(
        text: timeText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final labelX = x - textPainter.width / 2;
    final labelY = size.height - textPainter.height - 8;

    // Background
    final bgPaint = Paint()..color = Colors.black.withValues(alpha: 0.8);
    canvas.drawRect(
      Rect.fromLTWH(labelX - 4, labelY - 2, textPainter.width + 8, textPainter.height + 4),
      bgPaint,
    );

    // Border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(labelX - 4, labelY - 2, textPainter.width + 8, textPainter.height + 4),
      borderPaint,
    );

    textPainter.paint(canvas, Offset(labelX, labelY));
  }

  void _drawOHLCInfo(Canvas canvas, Size size, Offset position, StockPrice priceData) {
    final infoText = '''O: ${priceData.open.toStringAsFixed(2)}
H: ${priceData.high.toStringAsFixed(2)}
L: ${priceData.low.toStringAsFixed(2)}
C: ${priceData.close.toStringAsFixed(2)}
V: ${_formatVolume(priceData.volume)}''';

    final textPainter = TextPainter(
      text: TextSpan(
        text: infoText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Position the info box to avoid going off screen
    double infoX = position.dx + 10;
    double infoY = position.dy - textPainter.height - 10;

    if (infoX + textPainter.width > size.width - 20) {
      infoX = position.dx - textPainter.width - 10;
    }

    if (infoY < 20) {
      infoY = position.dy + 10;
    }

    // Background
    final bgPaint = Paint()..color = Colors.black.withValues(alpha: 0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(infoX - 8, infoY - 4, textPainter.width + 16, textPainter.height + 8),
        Radius.circular(4),
      ),
      bgPaint,
    );

    // Border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(infoX - 8, infoY - 4, textPainter.width + 16, textPainter.height + 8),
        Radius.circular(4),
      ),
      borderPaint,
    );

    textPainter.paint(canvas, Offset(infoX, infoY));
  }

  String _formatVolume(double volume) {
    if (volume >= 1000000000) {
      return '${(volume / 1000000000).toStringAsFixed(1)}B';
    } else if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    } else {
      return volume.toStringAsFixed(0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 