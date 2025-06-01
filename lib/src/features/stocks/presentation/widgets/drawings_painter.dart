import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/entities/stock_entity.dart';
import 'drawing_elements.dart';

class DrawingsPainter extends CustomPainter {
  final List<DrawingElement> drawings;
  final DrawingElement? currentDrawing;
  final DrawingElement? selectedDrawing;
  final List<StockPrice> priceHistory;

  DrawingsPainter({
    required this.drawings,
    this.currentDrawing,
    this.selectedDrawing,
    required this.priceHistory,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty) return;

    try {
      final maxPrice = priceHistory.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b);
      
      if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) return;

      // Draw all completed drawings
      for (final drawing in drawings) {
        _drawElement(canvas, size, drawing, minPrice, maxPrice, priceHistory.length);
        
        // Add selection indicator for selected drawing
        if (drawing == selectedDrawing) {
          _drawSelectionIndicator(canvas, size, drawing, minPrice, maxPrice, priceHistory.length);
        }
      }

      // Draw current drawing being created
      if (currentDrawing != null) {
        _drawElement(canvas, size, currentDrawing!, minPrice, maxPrice, priceHistory.length);
      }
    } catch (e) {
      print('Error in DrawingsPainter: $e');
    }
  }

  void _drawElement(Canvas canvas, Size size, DrawingElement drawing, double minPrice, double maxPrice, int dataLength) {
    final paint = Paint()
      ..color = drawing.color
      ..strokeWidth = drawing.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    switch (drawing.tool) {
      case DrawingTool.trendline:
        _drawTrendLine(canvas, size, drawing, paint, minPrice, maxPrice, dataLength);
        break;
      case DrawingTool.horizontalLine:
        _drawHorizontalLine(canvas, size, drawing, paint, minPrice, maxPrice, dataLength);
        break;
      case DrawingTool.verticalLine:
        _drawVerticalLine(canvas, size, drawing, paint, minPrice, maxPrice, dataLength);
        break;
      case DrawingTool.measure:
        _drawMeasureTool(canvas, size, drawing, paint, minPrice, maxPrice, dataLength);
        break;
      case DrawingTool.fibonacciRetracement:
        _drawFibonacci(canvas, size, drawing, paint, minPrice, maxPrice, dataLength);
        break;
      case DrawingTool.elliottWave:
        _drawElliottWave(canvas, size, drawing, paint, minPrice, maxPrice, dataLength);
        break;
      case DrawingTool.none:
        break;
    }
  }

  void _drawTrendLine(Canvas canvas, Size size, DrawingElement element, Paint paint, double minPrice, double maxPrice, int dataLength) {
    if (element.points.length >= 2) {
      final start = element.points.first;
      final end = element.points.last;
      
      // Draw main line
      canvas.drawLine(start, end, paint);
      
      // Draw extension (dotted)
      _drawDottedExtension(canvas, size, start, end, paint, minPrice, maxPrice, dataLength);
      
      // Draw anchor points
      _drawAnchorPoint(canvas, start, paint);
      _drawAnchorPoint(canvas, end, paint);
    }
  }

  void _drawHorizontalLine(Canvas canvas, Size size, DrawingElement element, Paint paint, double minPrice, double maxPrice, int dataLength) {
    if (element.points.isNotEmpty) {
      final y = element.points.first.dy;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      
      // Draw price label
      _drawPriceLabel(canvas, Offset(size.width - 60, y), element.pricePoints.first, paint, minPrice, maxPrice);
    }
  }

  void _drawVerticalLine(Canvas canvas, Size size, DrawingElement element, Paint paint, double minPrice, double maxPrice, int dataLength) {
    if (element.points.isNotEmpty) {
      final x = element.points.first.dx;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      
      // Draw time label if available
      _drawTimeLabel(canvas, Offset(x, size.height - 20), element.timeIndices.first, paint, minPrice, maxPrice);
    }
  }

  void _drawMeasureTool(Canvas canvas, Size size, DrawingElement element, Paint paint, double minPrice, double maxPrice, int dataLength) {
    if (element.points.length >= 2) {
      final start = element.points.first;
      final end = element.points.last;
      
      // Draw line
      canvas.drawLine(start, end, paint);
      
      // Calculate measurements
      final priceDiff = (element.pricePoints.last - element.pricePoints.first).abs();
      final timeDiff = (element.timeIndices.last - element.timeIndices.first).abs();
      final distance = (end - start).distance;
      
      // Draw measurement labels
      final midPoint = Offset(
        (start.dx + end.dx) / 2,
        (start.dy + end.dy) / 2,
      );
      
      _drawMeasurementLabel(canvas, midPoint, priceDiff, timeDiff, paint, minPrice, maxPrice);
      
      // Draw anchor points
      _drawAnchorPoint(canvas, start, paint);
      _drawAnchorPoint(canvas, end, paint);
    }
  }

  void _drawFibonacci(Canvas canvas, Size size, DrawingElement element, Paint paint, double minPrice, double maxPrice, int dataLength) {
    if (element.points.length >= 2) {
      final start = element.points.first;
      final end = element.points.last;
      final height = (end.dy - start.dy).abs();
      
      // Fibonacci levels
      final levels = [0.0, 0.236, 0.382, 0.5, 0.618, 0.786, 1.0];
      final colors = [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.purple,
        Colors.red,
      ];
      
      for (int i = 0; i < levels.length; i++) {
        final level = levels[i];
        final y = start.dy + (height * level);
        final levelPaint = Paint()
          ..color = colors[i].withOpacity(0.8)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;
        
        // Draw level line
        canvas.drawLine(Offset(0, y), Offset(size.width, y), levelPaint);
        
        // Draw level label
        _drawFibLabel(canvas, Offset(10, y), level, levelPaint, minPrice, maxPrice);
      }
    }
  }

  void _drawElliottWave(Canvas canvas, Size size, DrawingElement element, Paint paint, double minPrice, double maxPrice, int dataLength) {
    if (element.points.length >= 2) {
      // For now, just draw a line - Elliott Wave would need more complex implementation
      canvas.drawLine(element.points.first, element.points.last, paint);
      
      // Add wave labels
      _drawWaveLabel(canvas, element.points.first, "1", paint, minPrice, maxPrice);
      _drawWaveLabel(canvas, element.points.last, "2", paint, minPrice, maxPrice);
    }
  }

  void _drawDottedExtension(Canvas canvas, Size size, Offset start, Offset end, Paint paint, double minPrice, double maxPrice, int dataLength) {
    final direction = (end - start);
    final length = direction.distance;
    if (length == 0) return;
    
    final normalizedDirection = direction / length;
    final extensionLength = size.width * 0.3; // Extend 30% of screen width
    final extensionEnd = end + (normalizedDirection * extensionLength);
    
    // Draw dotted line for extension
    final dottedPaint = Paint()
      ..color = paint.color.withOpacity(0.5)
      ..strokeWidth = paint.strokeWidth
      ..style = PaintingStyle.stroke;
    
    _drawDottedLine(canvas, end, extensionEnd, dottedPaint);
  }

  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLength = 5.0;
    const gapLength = 3.0;
    
    final direction = (end - start);
    final totalDistance = direction.distance;
    final normalizedDirection = direction / totalDistance;
    
    double currentDistance = 0;
    bool isDash = true;
    
    while (currentDistance < totalDistance) {
      final segmentLength = isDash ? dashLength : gapLength;
      final nextDistance = math.min(currentDistance + segmentLength, totalDistance);
      
      if (isDash) {
        final segmentStart = start + (normalizedDirection * currentDistance);
        final segmentEnd = start + (normalizedDirection * nextDistance);
        canvas.drawLine(segmentStart, segmentEnd, paint);
      }
      
      currentDistance = nextDistance;
      isDash = !isDash;
    }
  }

  void _drawAnchorPoint(Canvas canvas, Offset point, Paint paint) {
    final anchorPaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(point, 4, anchorPaint);
    
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    canvas.drawCircle(point, 4, borderPaint);
  }

  void _drawPriceLabel(Canvas canvas, Offset position, double price, Paint paint, double minPrice, double maxPrice) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '\$${price.toStringAsFixed(2)}',
        style: TextStyle(
          color: paint.color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    
    // Draw background
    final rect = Rect.fromLTWH(
      position.dx - 2,
      position.dy - textPainter.height / 2 - 2,
      textPainter.width + 4,
      textPainter.height + 4,
    );
    
    canvas.drawRect(rect, Paint()..color = Colors.black.withOpacity(0.8));
    textPainter.paint(canvas, Offset(position.dx, position.dy - textPainter.height / 2));
  }

  void _drawTimeLabel(Canvas canvas, Offset position, int timeIndex, Paint paint, double minPrice, double maxPrice) {
    if (timeIndex >= 0 && timeIndex < priceHistory.length) {
      final timestamp = priceHistory[timeIndex].timestamp;
      final timeStr = '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: timeStr,
          style: TextStyle(
            color: paint.color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      
      textPainter.layout();
      
      // Draw background
      final rect = Rect.fromLTWH(
        position.dx - textPainter.width / 2 - 2,
        position.dy - textPainter.height - 2,
        textPainter.width + 4,
        textPainter.height + 4,
      );
      
      canvas.drawRect(rect, Paint()..color = Colors.black.withOpacity(0.8));
      textPainter.paint(canvas, Offset(position.dx - textPainter.width / 2, position.dy - textPainter.height));
    }
  }

  void _drawMeasurementLabel(Canvas canvas, Offset position, double priceDiff, int timeDiff, Paint paint, double minPrice, double maxPrice) {
    final text = 'ΔPrice: \$${priceDiff.toStringAsFixed(2)}\nΔTime: ${timeDiff}pts';
    
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: paint.color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    
    // Draw background
    final rect = Rect.fromLTWH(
      position.dx - textPainter.width / 2 - 4,
      position.dy - textPainter.height / 2 - 4,
      textPainter.width + 8,
      textPainter.height + 8,
    );
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(4)),
      Paint()..color = Colors.black.withOpacity(0.8),
    );
    
    textPainter.paint(canvas, Offset(
      position.dx - textPainter.width / 2,
      position.dy - textPainter.height / 2,
    ));
  }

  void _drawFibLabel(Canvas canvas, Offset position, double level, Paint paint, double minPrice, double maxPrice) {
    final text = '${(level * 100).toStringAsFixed(1)}%';
    
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: paint.color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  void _drawWaveLabel(Canvas canvas, Offset position, String label, Paint paint, double minPrice, double maxPrice) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: paint.color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    
    // Draw circle background
    canvas.drawCircle(position, 10, Paint()..color = Colors.black.withOpacity(0.8));
    canvas.drawCircle(position, 10, Paint()
      ..color = paint.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1);
    
    textPainter.paint(canvas, Offset(
      position.dx - textPainter.width / 2,
      position.dy - textPainter.height / 2,
    ));
  }

  void _drawSelectionIndicator(Canvas canvas, Size size, DrawingElement drawing, double minPrice, double maxPrice, int dataLength) {
    final selectionPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw selection handles based on drawing type
    if (drawing is TrendlineElement || drawing is MeasureElement) {
      Offset startPoint, endPoint;
      
      if (drawing is TrendlineElement) {
        startPoint = drawing.startPoint;
        endPoint = drawing.endPoint;
      } else {
        final measure = drawing as MeasureElement;
        startPoint = measure.startPoint;
        endPoint = measure.endPoint;
      }
      
      // Draw selection handles at endpoints
      _drawSelectionHandle(canvas, startPoint, selectionPaint);
      _drawSelectionHandle(canvas, endPoint, selectionPaint);
      
    } else if (drawing is HorizontalLineElement) {
      final y = size.height - ((drawing.value - minPrice) / (maxPrice - minPrice)) * size.height;
      
      // Draw selection handles at both ends of the line
      _drawSelectionHandle(canvas, Offset(0, y), selectionPaint);
      _drawSelectionHandle(canvas, Offset(size.width, y), selectionPaint);
      
    } else if (drawing is VerticalLineElement) {
      final x = (drawing.index / dataLength) * size.width;
      
      // Draw selection handles at both ends of the line
      _drawSelectionHandle(canvas, Offset(x, 0), selectionPaint);
      _drawSelectionHandle(canvas, Offset(x, size.height), selectionPaint);
    }
  }

  void _drawSelectionHandle(Canvas canvas, Offset position, Paint paint) {
    const double handleRadius = 6.0;
    
    // Draw outer circle
    canvas.drawCircle(position, handleRadius, paint);
    
    // Draw inner filled circle
    final fillPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, handleRadius - 2, fillPaint);
  }

  @override
  bool shouldRepaint(covariant DrawingsPainter oldDelegate) {
    return oldDelegate.drawings != drawings ||
           oldDelegate.currentDrawing != currentDrawing ||
           oldDelegate.selectedDrawing != selectedDrawing ||
           oldDelegate.priceHistory != priceHistory;
  }
} 