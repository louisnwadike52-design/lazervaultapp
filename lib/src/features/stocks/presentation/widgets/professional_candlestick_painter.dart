import 'package:flutter/material.dart';
import '../../domain/entities/stock_entity.dart';

class ProfessionalCandlestickPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final double maxPrice;
  final double minPrice;
  final double candleWidth;
  final bool showGrid;
  final Color gridColor;
  final Color bullishColor;
  final Color bearishColor;

  ProfessionalCandlestickPainter({
    required this.priceHistory,
    required this.maxPrice,
    required this.minPrice,
    required this.candleWidth,
    this.showGrid = true,
    this.gridColor = Colors.grey,
    this.bullishColor = Colors.green,
    this.bearishColor = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty) return;

    // Calculate realistic price range with proper padding
    final actualPriceRange = maxPrice - minPrice;
    if (actualPriceRange == 0) return;

    // Add 10% padding top and bottom for better visualization
    final padding = actualPriceRange * 0.1;
    final chartMinPrice = minPrice - padding;
    final chartMaxPrice = maxPrice + padding;
    final chartPriceRange = chartMaxPrice - chartMinPrice;

    // Reserve space for price labels and margins
    final chartHeight = size.height * 0.85; // Use 85% of available height
    final chartTop = size.height * 0.075; // 7.5% margin at top
    
    // Draw grid first
    if (showGrid) {
      _drawGrid(canvas, size, chartTop, chartHeight);
    }

    // Calculate proper spacing and candlestick width
    final availableWidth = size.width * 0.9; // Use 90% of width for chart
    final chartLeft = size.width * 0.05; // 5% margin on left
    final candleSpacing = availableWidth / priceHistory.length;
    final actualCandleWidth = (candleSpacing * 0.6).clamp(1.0, 15.0); // Limit candle width
    final wickWidth = 1.0;

    // Paint objects
    final wickPaint = Paint()
      ..strokeWidth = wickWidth
      ..strokeCap = StrokeCap.round;
    
    final bodyPaint = Paint()
      ..strokeWidth = 1.0;

    for (int i = 0; i < priceHistory.length; i++) {
      final price = priceHistory[i];
      final x = chartLeft + (i + 0.5) * candleSpacing;
      
      // Calculate Y positions with proper scaling
      final highY = chartTop + chartHeight - ((price.high - chartMinPrice) / chartPriceRange) * chartHeight;
      final lowY = chartTop + chartHeight - ((price.low - chartMinPrice) / chartPriceRange) * chartHeight;
      final openY = chartTop + chartHeight - ((price.open - chartMinPrice) / chartPriceRange) * chartHeight;
      final closeY = chartTop + chartHeight - ((price.close - chartMinPrice) / chartPriceRange) * chartHeight;
      
      final isBullish = price.close >= price.open;
      final color = isBullish ? bullishColor : bearishColor;
      
      // Draw wick (high-low line) first
      wickPaint.color = color.withValues(alpha: 0.8);
      canvas.drawLine(
        Offset(x, highY),
        Offset(x, lowY),
        wickPaint,
      );
      
      // Calculate body dimensions
      final bodyTop = isBullish ? closeY : openY;
      final bodyBottom = isBullish ? openY : closeY;
      final bodyHeight = (bodyBottom - bodyTop).abs();
      
      // Ensure minimum body height for very small price movements
      final minBodyHeight = 1.5;
      final actualBodyHeight = bodyHeight < minBodyHeight ? minBodyHeight : bodyHeight;
      
      // Adjust body position if height was increased
      final adjustedBodyTop = bodyHeight < minBodyHeight 
          ? (bodyTop + bodyBottom) / 2 - minBodyHeight / 2
          : bodyTop;
      
      // Create body rectangle
      final bodyRect = Rect.fromLTWH(
        x - actualCandleWidth / 2,
        adjustedBodyTop,
        actualCandleWidth,
        actualBodyHeight,
      );
      
      // Draw candlestick body
      if (isBullish) {
        // Bullish candle - filled with light color or hollow
        bodyPaint.style = PaintingStyle.fill;
        bodyPaint.color = color.withValues(alpha: 0.1);
        canvas.drawRect(bodyRect, bodyPaint);
        
        // Draw border
        bodyPaint.style = PaintingStyle.stroke;
        bodyPaint.color = color;
        bodyPaint.strokeWidth = 1.5;
        canvas.drawRect(bodyRect, bodyPaint);
      } else {
        // Bearish candle - filled
        bodyPaint.style = PaintingStyle.fill;
        bodyPaint.color = color;
        canvas.drawRect(bodyRect, bodyPaint);
        
        // Optional subtle border for better definition
        bodyPaint.style = PaintingStyle.stroke;
        bodyPaint.strokeWidth = 0.5;
        bodyPaint.color = color.withValues(alpha: 0.9);
        canvas.drawRect(bodyRect, bodyPaint);
      }
    }

    // Draw price labels on the right
    _drawPriceLabels(canvas, size, chartTop, chartHeight, chartMinPrice, chartMaxPrice);
  }

  void _drawGrid(Canvas canvas, Size size, double chartTop, double chartHeight) {
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    // Horizontal grid lines (price levels) - fewer lines for cleaner look
    const horizontalLines = 8;
    for (int i = 0; i <= horizontalLines; i++) {
      final y = chartTop + (i / horizontalLines) * chartHeight;
      canvas.drawLine(
        Offset(size.width * 0.05, y),
        Offset(size.width * 0.95, y),
        gridPaint,
      );
    }

    // Vertical grid lines (time) - minimal for cleaner look
    final verticalLines = (priceHistory.length / 15).round().clamp(3, 6);
    for (int i = 1; i < verticalLines; i++) {
      final x = size.width * 0.05 + (i / verticalLines) * (size.width * 0.9);
      canvas.drawLine(
        Offset(x, chartTop),
        Offset(x, chartTop + chartHeight),
        gridPaint,
      );
    }
  }

  void _drawPriceLabels(Canvas canvas, Size size, double chartTop, double chartHeight, 
                       double chartMinPrice, double chartMaxPrice) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw price labels on the right side
    const labelCount = 5;
    for (int i = 0; i <= labelCount; i++) {
      final ratio = i / labelCount;
      final price = chartMaxPrice - (chartMaxPrice - chartMinPrice) * ratio;
      final y = chartTop + ratio * chartHeight;
      
      // Format price based on value
      String priceText;
      if (price >= 1000) {
        priceText = price.toStringAsFixed(0);
      } else if (price >= 100) {
        priceText = price.toStringAsFixed(1);
      } else {
        priceText = price.toStringAsFixed(2);
      }
      
      textPainter.text = TextSpan(
        text: priceText,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      );
      
      textPainter.layout();
      
      // Position label on the right edge
      final labelX = size.width - textPainter.width - 4;
      final labelY = y - textPainter.height / 2;
      
      // Draw background for better readability
      final bgRect = Rect.fromLTWH(
        labelX - 2,
        labelY - 1,
        textPainter.width + 4,
        textPainter.height + 2,
      );
      
      canvas.drawRect(
        bgRect,
        Paint()..color = Colors.black.withValues(alpha: 0.7),
      );
      
      textPainter.paint(canvas, Offset(labelX, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 