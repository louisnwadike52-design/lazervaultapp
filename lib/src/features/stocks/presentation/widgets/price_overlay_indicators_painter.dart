import 'package:flutter/material.dart';
import '../../domain/entities/stock_entity.dart';
import 'dart:math' as math;

class PriceOverlayIndicatorsPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final List<String> selectedIndicators;
  final double maxPrice;
  final double minPrice;

  PriceOverlayIndicatorsPainter({
    required this.priceHistory,
    required this.selectedIndicators,
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty || selectedIndicators.isEmpty) return;
    if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) return;
    if (size.width <= 0 || size.height <= 0) return;

    try {
      // Draw each price overlay indicator
      for (final indicator in selectedIndicators) {
        switch (indicator) {
          case 'Moving Average':
            _drawMovingAverage(canvas, size, 20, Colors.blue);
            _drawMovingAverage(canvas, size, 50, Colors.orange);
            break;
          case 'EMA':
            _drawEMA(canvas, size, 12, Colors.purple);
            _drawEMA(canvas, size, 26, Colors.cyan);
            break;
          case 'Bollinger Bands':
            _drawBollingerBands(canvas, size);
            break;
          case 'VWAP':
            _drawVWAP(canvas, size);
            break;
          case 'Parabolic SAR':
            _drawParabolicSAR(canvas, size);
            break;
        }
      }
    } catch (e) {
      print('Error painting price overlay indicators: $e');
    }
  }

  void _drawMovingAverage(Canvas canvas, Size size, int period, Color color) {
    if (priceHistory.length < period) return;

    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final maValues = _calculateSMA(period);
    
    bool firstPoint = true;
    for (int i = 0; i < maValues.length; i++) {
      if (maValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final y = ((maxPrice - maValues[i]!) / (maxPrice - minPrice)) * size.height;
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, paint);
    _drawLegend(canvas, 'MA($period)', color, selectedIndicators.length * 20.0);
  }

  void _drawEMA(Canvas canvas, Size size, int period, Color color) {
    if (priceHistory.length < period) return;

    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final emaValues = _calculateEMA(period);
    
    bool firstPoint = true;
    for (int i = 0; i < emaValues.length; i++) {
      if (emaValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final y = ((maxPrice - emaValues[i]!) / (maxPrice - minPrice)) * size.height;
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, paint);
    _drawLegend(canvas, 'EMA($period)', color, selectedIndicators.length * 25.0);
  }

  void _drawBollingerBands(Canvas canvas, Size size) {
    if (priceHistory.length < 20) return;

    final sma = _calculateSMA(20);
    final stdDev = _calculateStandardDeviation(20);
    
    final upperBandPaint = Paint()
      ..color = Colors.purple.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    final lowerBandPaint = Paint()
      ..color = Colors.purple.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    final fillPaint = Paint()
      ..color = Colors.purple.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final upperPath = Path();
    final lowerPath = Path();
    final fillPath = Path();
    
    bool firstPoint = true;
    for (int i = 0; i < sma.length; i++) {
      if (sma[i] != null && stdDev[i] != null) {
        final upperBand = sma[i]! + (2 * stdDev[i]!);
        final lowerBand = sma[i]! - (2 * stdDev[i]!);
        
        final x = (i / (priceHistory.length - 1)) * size.width;
        final upperY = ((maxPrice - upperBand) / (maxPrice - minPrice)) * size.height;
        final lowerY = ((maxPrice - lowerBand) / (maxPrice - minPrice)) * size.height;
        
        if (firstPoint) {
          upperPath.moveTo(x, upperY);
          lowerPath.moveTo(x, lowerY);
          fillPath.moveTo(x, upperY);
          firstPoint = false;
        } else {
          upperPath.lineTo(x, upperY);
          lowerPath.lineTo(x, lowerY);
          fillPath.lineTo(x, upperY);
        }
      }
    }

    // Close the fill path
    for (int i = sma.length - 1; i >= 0; i--) {
      if (sma[i] != null && stdDev[i] != null) {
        final lowerBand = sma[i]! - (2 * stdDev[i]!);
        final x = (i / (priceHistory.length - 1)) * size.width;
        final lowerY = ((maxPrice - lowerBand) / (maxPrice - minPrice)) * size.height;
        fillPath.lineTo(x, lowerY);
      }
    }
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(upperPath, upperBandPaint);
    canvas.drawPath(lowerPath, lowerBandPaint);
    
    _drawLegend(canvas, 'BB(20,2)', Colors.purple, 30.0);
  }

  void _drawVWAP(Canvas canvas, Size size) {
    final vwapValues = _calculateVWAP();
    
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    bool firstPoint = true;
    
    for (int i = 0; i < vwapValues.length; i++) {
      if (vwapValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final y = ((maxPrice - vwapValues[i]!) / (maxPrice - minPrice)) * size.height;
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, paint);
    _drawLegend(canvas, 'VWAP', Colors.cyan, 45.0);
  }

  void _drawParabolicSAR(Canvas canvas, Size size) {
    final sarValues = _calculateParabolicSAR();
    
    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    for (int i = 0; i < sarValues.length; i++) {
      if (sarValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final y = ((maxPrice - sarValues[i]!) / (maxPrice - minPrice)) * size.height;
        
        canvas.drawCircle(Offset(x, y), 2.0, paint);
      }
    }
    
    _drawLegend(canvas, 'SAR', Colors.pink, 55.0);
  }

  void _drawLegend(Canvas canvas, String text, Color color, double leftOffset) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(canvas, Offset(10 + leftOffset, 10));
  }

  // Calculation methods (same as before)
  List<double?> _calculateSMA(int period) {
    try {
      if (priceHistory.length < period || period <= 0) {
        return List<double?>.filled(priceHistory.length, null);
      }
      
      final result = List<double?>.filled(priceHistory.length, null);
      
      for (int i = period - 1; i < priceHistory.length; i++) {
        double sum = 0;
        bool hasValidData = true;
        
        for (int j = 0; j < period; j++) {
          final price = priceHistory[i - j].close;
          if (price <= 0) {
            hasValidData = false;
            break;
          }
          sum += price;
        }
        
        if (hasValidData) {
          result[i] = sum / period;
        }
      }
      
      return result;
    } catch (e) {
      print('Error calculating SMA: $e');
      return List<double?>.filled(priceHistory.length, null);
    }
  }

  List<double?> _calculateEMA(int period) {
    final result = List<double?>.filled(priceHistory.length, null);
    final multiplier = 2.0 / (period + 1);
    
    if (priceHistory.length < period) return result;
    
    // Start with SMA for the first value
    double sum = 0;
    for (int i = 0; i < period; i++) {
      sum += priceHistory[i].close;
    }
    result[period - 1] = sum / period;
    
    // Calculate EMA for the rest
    for (int i = period; i < priceHistory.length; i++) {
      result[i] = (priceHistory[i].close * multiplier) + (result[i - 1]! * (1 - multiplier));
    }
    
    return result;
  }

  List<double?> _calculateStandardDeviation(int period) {
    final sma = _calculateSMA(period);
    final result = List<double?>.filled(priceHistory.length, null);
    
    for (int i = period - 1; i < priceHistory.length; i++) {
      if (sma[i] != null) {
        double sumSquaredDeviations = 0;
        for (int j = 0; j < period; j++) {
          final deviation = priceHistory[i - j].close - sma[i]!;
          sumSquaredDeviations += deviation * deviation;
        }
        result[i] = math.sqrt(sumSquaredDeviations / period);
      }
    }
    
    return result;
  }

  List<double?> _calculateVWAP() {
    final result = List<double?>.filled(priceHistory.length, null);
    double cumulativeVolumePrice = 0;
    double cumulativeVolume = 0;
    
    for (int i = 0; i < priceHistory.length; i++) {
      final typical = (priceHistory[i].high + priceHistory[i].low + priceHistory[i].close) / 3;
      cumulativeVolumePrice += typical * priceHistory[i].volume;
      cumulativeVolume += priceHistory[i].volume;
      
      if (cumulativeVolume > 0) {
        result[i] = cumulativeVolumePrice / cumulativeVolume;
      }
    }
    
    return result;
  }

  List<double?> _calculateParabolicSAR() {
    final result = List<double?>.filled(priceHistory.length, null);
    
    if (priceHistory.length < 2) return result;
    
    const double accelerationStart = 0.02;
    const double accelerationStep = 0.02;
    const double accelerationMax = 0.2;
    
    bool isUptrend = priceHistory[1].close > priceHistory[0].close;
    double acceleration = accelerationStart;
    double extremePoint = isUptrend ? priceHistory[1].high : priceHistory[1].low;
    double sar = priceHistory[0].close;
    
    result[0] = sar;
    
    for (int i = 1; i < priceHistory.length; i++) {
      final currentHigh = priceHistory[i].high;
      final currentLow = priceHistory[i].low;
      
      // Calculate new SAR
      sar = sar + acceleration * (extremePoint - sar);
      
      if (isUptrend) {
        if (currentLow <= sar) {
          isUptrend = false;
          sar = extremePoint;
          extremePoint = currentLow;
          acceleration = accelerationStart;
        } else {
          if (currentHigh > extremePoint) {
            extremePoint = currentHigh;
            acceleration = math.min(acceleration + accelerationStep, accelerationMax);
          }
        }
      } else {
        if (currentHigh >= sar) {
          isUptrend = true;
          sar = extremePoint;
          extremePoint = currentHigh;
          acceleration = accelerationStart;
        } else {
          if (currentLow < extremePoint) {
            extremePoint = currentLow;
            acceleration = math.min(acceleration + accelerationStep, accelerationMax);
          }
        }
      }
      
      result[i] = sar;
    }
    
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 