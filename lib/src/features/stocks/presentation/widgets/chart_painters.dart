import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/stock_entity.dart';

class CandlestickPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final double maxPrice;
  final double minPrice;

  CandlestickPainter({
    required this.priceHistory,
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1.5;
    final bodyPaint = Paint();
    
    final priceRange = maxPrice - minPrice;
    final candleWidth = (size.width / priceHistory.length) * 0.7;
    final spacing = size.width / priceHistory.length;

    for (int i = 0; i < priceHistory.length; i++) {
      final price = priceHistory[i];
      final isPositive = price.close >= price.open;
      
      // Colors
      final color = isPositive ? Colors.green : Colors.red;
      paint.color = color;
      bodyPaint.color = isPositive ? color.withValues(alpha: 0.8) : color;
      
      // Positions
      final x = (i + 0.5) * spacing;
      final highY = size.height - ((price.high - minPrice) / priceRange) * size.height;
      final lowY = size.height - ((price.low - minPrice) / priceRange) * size.height;
      final openY = size.height - ((price.open - minPrice) / priceRange) * size.height;
      final closeY = size.height - ((price.close - minPrice) / priceRange) * size.height;
      
      // Draw high-low line
      canvas.drawLine(
        Offset(x, highY),
        Offset(x, lowY),
        paint,
      );
      
      // Draw candle body
      final bodyTop = isPositive ? closeY : openY;
      final bodyBottom = isPositive ? openY : closeY;
      final bodyHeight = (bodyBottom - bodyTop).abs();
      
      if (bodyHeight < 1) {
        // Draw line for doji
        canvas.drawLine(
          Offset(x - candleWidth / 2, bodyTop),
          Offset(x + candleWidth / 2, bodyTop),
          paint,
        );
      } else {
        // Draw rectangle for body
        final rect = Rect.fromLTWH(
          x - candleWidth / 2,
          bodyTop,
          candleWidth,
          bodyHeight,
        );
        
        if (isPositive) {
          canvas.drawRect(rect, bodyPaint);
          canvas.drawRect(rect, paint..style = PaintingStyle.stroke);
        } else {
          canvas.drawRect(rect, bodyPaint);
        }
      }
      
      paint.style = PaintingStyle.fill;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class OHLCPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final double maxPrice;
  final double minPrice;

  OHLCPainter({
    required this.priceHistory,
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1.5;
    
    final priceRange = maxPrice - minPrice;
    final spacing = size.width / priceHistory.length;
    final tickWidth = spacing * 0.3;

    for (int i = 0; i < priceHistory.length; i++) {
      final price = priceHistory[i];
      final isPositive = price.close >= price.open;
      
      // Color
      paint.color = isPositive ? Colors.green : Colors.red;
      
      // Positions
      final x = (i + 0.5) * spacing;
      final highY = size.height - ((price.high - minPrice) / priceRange) * size.height;
      final lowY = size.height - ((price.low - minPrice) / priceRange) * size.height;
      final openY = size.height - ((price.open - minPrice) / priceRange) * size.height;
      final closeY = size.height - ((price.close - minPrice) / priceRange) * size.height;
      
      // Draw high-low line
      canvas.drawLine(
        Offset(x, highY),
        Offset(x, lowY),
        paint,
      );
      
      // Draw open tick (left)
      canvas.drawLine(
        Offset(x - tickWidth / 2, openY),
        Offset(x, openY),
        paint,
      );
      
      // Draw close tick (right)
      canvas.drawLine(
        Offset(x, closeY),
        Offset(x + tickWidth / 2, closeY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HollowCandlestickPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final double maxPrice;
  final double minPrice;

  HollowCandlestickPainter({
    required this.priceHistory,
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty) return;

    final priceRange = maxPrice - minPrice;
    final candleWidth = size.width / priceHistory.length * 0.8;

    for (int i = 0; i < priceHistory.length; i++) {
      final price = priceHistory[i];
      final x = (i + 0.5) * (size.width / priceHistory.length);

      // Calculate Y positions
      final openY = size.height - ((price.open - minPrice) / priceRange) * size.height;
      final closeY = size.height - ((price.close - minPrice) / priceRange) * size.height;
      final highY = size.height - ((price.high - minPrice) / priceRange) * size.height;
      final lowY = size.height - ((price.low - minPrice) / priceRange) * size.height;

      final isUpCandle = price.close > price.open;
      final color = isUpCandle ? Colors.green : Colors.red;

      // Draw high-low line
      final linePaint = Paint()
        ..color = color
        ..strokeWidth = 1.0;

      canvas.drawLine(Offset(x, highY), Offset(x, lowY), linePaint);

      // Draw hollow candle body
      final bodyPaint = Paint()
        ..color = isUpCandle ? Colors.transparent : color
        ..style = isUpCandle ? PaintingStyle.stroke : PaintingStyle.fill
        ..strokeWidth = 1.0;

      final rect = Rect.fromLTRB(
        x - candleWidth / 2,
        openY < closeY ? openY : closeY,
        x + candleWidth / 2,
        openY > closeY ? openY : closeY,
      );

      canvas.drawRect(rect, bodyPaint);

      // Draw border for up candles
      if (isUpCandle) {
        final borderPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawRect(rect, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(HollowCandlestickPainter oldDelegate) {
    return priceHistory != oldDelegate.priceHistory ||
           maxPrice != oldDelegate.maxPrice ||
           minPrice != oldDelegate.minPrice;
  }
} 