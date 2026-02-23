import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

enum DrawingTool { 
  none, 
  measure, 
  trendline, 
  horizontalLine, 
  verticalLine, 
  fibonacciRetracement, 
  elliottWave 
}

abstract class DrawingElement {
  final DrawingTool tool;
  final List<Offset> points;
  final List<double> pricePoints;
  final List<int> timeIndices;
  final Color color;
  final double strokeWidth;
  final bool isCompleted;

  const DrawingElement({
    required this.tool,
    required this.points,
    required this.pricePoints,
    required this.timeIndices,
    required this.color,
    this.strokeWidth = 2.0,
    this.isCompleted = false,
  });

  DrawingElement copyWith({
    DrawingTool? tool,
    List<Offset>? points,
    List<double>? pricePoints,
    List<int>? timeIndices,
    Color? color,
    double? strokeWidth,
    bool? isCompleted,
  }) {
    // This will be implemented by subclasses
    throw UnimplementedError('copyWith must be implemented by subclasses');
  }

  void draw(Canvas canvas, Size size, double minPrice, double maxPrice, int dataLength);
}

class TrendlineElement extends DrawingElement {
  final Offset startPoint;
  final Offset endPoint;
  final double startValue;
  final double endValue;
  final int startIndex;
  final int endIndex;

  TrendlineElement({
    required this.startPoint,
    required this.endPoint,
    required this.startValue,
    required this.endValue,
    required this.startIndex,
    required this.endIndex,
    super.color = Colors.blue,
    super.strokeWidth,
  }) : super(
          tool: DrawingTool.trendline,
          points: [startPoint, endPoint],
          pricePoints: [startValue, endValue],
          timeIndices: [startIndex, endIndex],
        );

  @override
  DrawingElement copyWith({
    DrawingTool? tool,
    List<Offset>? points,
    List<double>? pricePoints,
    List<int>? timeIndices,
    Color? color,
    double? strokeWidth,
    bool? isCompleted,
  }) {
    final newPoints = points ?? this.points;
    final newPricePoints = pricePoints ?? this.pricePoints;
    final newTimeIndices = timeIndices ?? this.timeIndices;
    
    return TrendlineElement(
      startPoint: newPoints.isNotEmpty ? newPoints[0] : startPoint,
      endPoint: newPoints.length > 1 ? newPoints[1] : endPoint,
      startValue: newPricePoints.isNotEmpty ? newPricePoints[0] : startValue,
      endValue: newPricePoints.length > 1 ? newPricePoints[1] : endValue,
      startIndex: newTimeIndices.isNotEmpty ? newTimeIndices[0] : startIndex,
      endIndex: newTimeIndices.length > 1 ? newTimeIndices[1] : endIndex,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  void draw(Canvas canvas, Size size, double minPrice, double maxPrice, int dataLength) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final startY = size.height - ((startValue - minPrice) / (maxPrice - minPrice)) * size.height;
    final endY = size.height - ((endValue - minPrice) / (maxPrice - minPrice)) * size.height;
    final startX = (startIndex / dataLength) * size.width;
    final endX = (endIndex / dataLength) * size.width;

    canvas.drawLine(
      Offset(startX, startY),
      Offset(endX, endY),
      paint,
    );
  }
}

class HorizontalLineElement extends DrawingElement {
  final double value;
  final double yPosition;

  HorizontalLineElement({
    required this.value,
    required this.yPosition,
    super.color = Colors.orange,
    super.strokeWidth,
  }) : super(
          tool: DrawingTool.horizontalLine,
          points: [Offset(0, yPosition), Offset(double.infinity, yPosition)],
          pricePoints: [value],
          timeIndices: [0],
        );

  @override
  DrawingElement copyWith({
    DrawingTool? tool,
    List<Offset>? points,
    List<double>? pricePoints,
    List<int>? timeIndices,
    Color? color,
    double? strokeWidth,
    bool? isCompleted,
  }) {
    final newPricePoints = pricePoints ?? this.pricePoints;
    final newPoints = points ?? this.points;
    
    return HorizontalLineElement(
      value: newPricePoints.isNotEmpty ? newPricePoints[0] : value,
      yPosition: newPoints.isNotEmpty ? newPoints[0].dy : yPosition,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  void draw(Canvas canvas, Size size, double minPrice, double maxPrice, int dataLength) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final y = size.height - ((value - minPrice) / (maxPrice - minPrice)) * size.height;
    
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint,
    );

    // Draw price label
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toStringAsFixed(2),
        style: TextStyle(color: color, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 60, y - 10));
  }
}

class VerticalLineElement extends DrawingElement {
  final int index;
  final double xPosition;
  final DateTime timestamp;

  VerticalLineElement({
    required this.index,
    required this.xPosition,
    required this.timestamp,
    super.color = Colors.purple,
    super.strokeWidth,
  }) : super(
          tool: DrawingTool.verticalLine,
          points: [Offset(xPosition, 0), Offset(xPosition, double.infinity)],
          pricePoints: [0],
          timeIndices: [index],
        );

  @override
  DrawingElement copyWith({
    DrawingTool? tool,
    List<Offset>? points,
    List<double>? pricePoints,
    List<int>? timeIndices,
    Color? color,
    double? strokeWidth,
    bool? isCompleted,
  }) {
    final newTimeIndices = timeIndices ?? this.timeIndices;
    final newPoints = points ?? this.points;
    
    return VerticalLineElement(
      index: newTimeIndices.isNotEmpty ? newTimeIndices[0] : index,
      xPosition: newPoints.isNotEmpty ? newPoints[0].dx : xPosition,
      timestamp: timestamp,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  void draw(Canvas canvas, Size size, double minPrice, double maxPrice, int dataLength) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final x = (index / dataLength) * size.width;
    
    canvas.drawLine(
      Offset(x, 0),
      Offset(x, size.height),
      paint,
    );

    // Draw date label
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${timestamp.month}/${timestamp.day}',
        style: TextStyle(color: color, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - 20, size.height - 20));
  }
}

class MeasureElement extends DrawingElement {
  final Offset startPoint;
  final Offset endPoint;
  final double startValue;
  final double endValue;
  final int startIndex;
  final int endIndex;

  MeasureElement({
    required this.startPoint,
    required this.endPoint,
    required this.startValue,
    required this.endValue,
    required this.startIndex,
    required this.endIndex,
    super.color = Colors.cyan,
    super.strokeWidth,
  }) : super(
          tool: DrawingTool.measure,
          points: [startPoint, endPoint],
          pricePoints: [startValue, endValue],
          timeIndices: [startIndex, endIndex],
        );

  @override
  DrawingElement copyWith({
    DrawingTool? tool,
    List<Offset>? points,
    List<double>? pricePoints,
    List<int>? timeIndices,
    Color? color,
    double? strokeWidth,
    bool? isCompleted,
  }) {
    final newPoints = points ?? this.points;
    final newPricePoints = pricePoints ?? this.pricePoints;
    final newTimeIndices = timeIndices ?? this.timeIndices;
    
    return MeasureElement(
      startPoint: newPoints.isNotEmpty ? newPoints[0] : startPoint,
      endPoint: newPoints.length > 1 ? newPoints[1] : endPoint,
      startValue: newPricePoints.isNotEmpty ? newPricePoints[0] : startValue,
      endValue: newPricePoints.length > 1 ? newPricePoints[1] : endValue,
      startIndex: newTimeIndices.isNotEmpty ? newTimeIndices[0] : startIndex,
      endIndex: newTimeIndices.length > 1 ? newTimeIndices[1] : endIndex,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  void draw(Canvas canvas, Size size, double minPrice, double maxPrice, int dataLength) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final dashPaint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final startY = size.height - ((startValue - minPrice) / (maxPrice - minPrice)) * size.height;
    final endY = size.height - ((endValue - minPrice) / (maxPrice - minPrice)) * size.height;
    final startX = (startIndex / dataLength) * size.width;
    final endX = (endIndex / dataLength) * size.width;

    // Draw main line
    canvas.drawLine(
      Offset(startX, startY),
      Offset(endX, endY),
      paint,
    );

    // Draw crosshairs
    _drawDashedLine(canvas, Offset(startX, 0), Offset(startX, size.height), dashPaint);
    _drawDashedLine(canvas, Offset(endX, 0), Offset(endX, size.height), dashPaint);
    _drawDashedLine(canvas, Offset(0, startY), Offset(size.width, startY), dashPaint);
    _drawDashedLine(canvas, Offset(0, endY), Offset(size.width, endY), dashPaint);

    // Draw measurement info
    final priceDiff = (endValue - startValue).abs();
    final priceChange = ((endValue - startValue) / startValue * 100);
    final midX = (startX + endX) / 2;
    final midY = (startY + endY) / 2;

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${CurrencySymbols.formatAmountWithCurrency(priceDiff, 'USD')}\n${priceChange.toStringAsFixed(2)}%',
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    
    // Draw background for text
    final textRect = Rect.fromCenter(
      center: Offset(midX, midY),
      width: textPainter.width + 8,
      height: textPainter.height + 4,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(textRect, Radius.circular(4)),
      Paint()..color = Colors.black.withValues(alpha: 0.8),
    );
    
    textPainter.paint(canvas, Offset(midX - textPainter.width / 2, midY - textPainter.height / 2));
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double distance = (end - start).distance;
    double dashCount = (distance / (dashWidth + dashSpace)).floor().toDouble();
    
    for (int i = 0; i < dashCount; i++) {
      double startRatio = (i * (dashWidth + dashSpace)) / distance;
      double endRatio = ((i * (dashWidth + dashSpace)) + dashWidth) / distance;
      
      canvas.drawLine(
        Offset.lerp(start, end, startRatio)!,
        Offset.lerp(start, end, endRatio)!,
        paint,
      );
    }
  }
} 