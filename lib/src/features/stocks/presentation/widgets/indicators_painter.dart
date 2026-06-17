import 'package:flutter/material.dart';
import '../../domain/entities/stock_entity.dart';
import 'dart:math' as math;

class IndicatorsPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final List<String> selectedIndicators;
  final double maxPrice;
  final double minPrice;
  final double bottomMargin;

  IndicatorsPainter({
    required this.priceHistory,
    required this.selectedIndicators,
    required this.maxPrice,
    required this.minPrice,
    this.bottomMargin = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty || selectedIndicators.isEmpty) return;
    if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) return;
    if (size.width <= 0 || size.height <= 0) return;

    try {
      // Draw each selected indicator with null safety
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
          case 'RSI':
            _drawRSI(canvas, size);
            break;
          case 'MACD':
            _drawMACD(canvas, size);
            break;
          case 'Volume':
            _drawVolumeOverlay(canvas, size);
            break;
          case 'VWAP':
            _drawVWAP(canvas, size);
            break;
          case 'Stochastic':
            _drawStochastic(canvas, size);
            break;
          case 'Parabolic SAR':
            _drawParabolicSAR(canvas, size);
            break;
          case 'ATR':
            _drawATR(canvas, size);
            break;
        }
      }
    } catch (e) {
      print('Error painting indicators: $e');
      _drawErrorIndicator(canvas, size);
    }
  }

  void _drawErrorIndicator(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(10, 10, 100, 30),
      paint,
    );
    
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Indicator Error',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(canvas, Offset(15, 18));
  }

  void _drawMovingAverage(Canvas canvas, Size size, int period, Color color) {
    if (priceHistory.length < period) return;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.8)
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

    // Draw legend
    _drawLegend(canvas, size, 'MA($period)', color, maValues.length * 20.0);
  }

  void _drawEMA(Canvas canvas, Size size, int period, Color color) {
    if (priceHistory.length < period) return;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.8)
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
    _drawLegend(canvas, size, 'EMA($period)', color, emaValues.length * 25.0);
  }

  void _drawBollingerBands(Canvas canvas, Size size) {
    if (priceHistory.length < 20) return;

    final sma = _calculateSMA(20);
    final stdDev = _calculateStandardDeviation(20);
    
    final upperBandPaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    final lowerBandPaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    final fillPaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.1)
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
    
    _drawLegend(canvas, size, 'BB(20,2)', Colors.purple, 30.0);
  }

  void _drawRSI(Canvas canvas, Size size) {
    final rsiValues = _calculateRSI(14);
    
    // Calculate available height excluding bottom margin
    final availableHeight = size.height - bottomMargin;
    final rsiHeight = availableHeight * 0.2; // Use 20% of available space
    final rsiTop = availableHeight - rsiHeight;
    
    // Draw RSI background
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(0, rsiTop, size.width, rsiHeight),
      bgPaint,
    );

    // Draw RSI levels (30, 50, 70)
    final levelPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    final oversoldY = rsiTop + (rsiHeight * 0.7); // 30 level
    final midY = rsiTop + (rsiHeight * 0.5); // 50 level
    final overboughtY = rsiTop + (rsiHeight * 0.3); // 70 level

    canvas.drawLine(Offset(0, oversoldY), Offset(size.width, oversoldY), levelPaint);
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), levelPaint);
    canvas.drawLine(Offset(0, overboughtY), Offset(size.width, overboughtY), levelPaint);

    // Draw RSI line
    final rsiPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    bool firstPoint = true;
    
    for (int i = 14; i < rsiValues.length; i++) {
      if (rsiValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final y = rsiTop + (rsiHeight * (1 - rsiValues[i]! / 100));
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, rsiPaint);
    _drawLegend(canvas, size, 'RSI(14)', Colors.yellow, rsiTop + 5);
  }

  void _drawMACD(Canvas canvas, Size size) {
    final macdData = _calculateMACD();
    
    // Calculate available height excluding bottom margin
    final availableHeight = size.height - bottomMargin;
    final macdHeight = availableHeight * 0.2;
    final macdTop = availableHeight - macdHeight;
    
    // Draw MACD background
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7);
    
    canvas.drawRect(
      Rect.fromLTWH(0, macdTop, size.width, macdHeight),
      bgPaint,
    );

    // Draw zero line
    final zeroLinePaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..strokeWidth = 1.0;
    
    final zeroY = macdTop + (macdHeight / 2);
    canvas.drawLine(Offset(0, zeroY), Offset(size.width, zeroY), zeroLinePaint);

    // Draw MACD line
    final macdPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw Signal line
    final signalPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Find MACD range for scaling
    final macdValues = macdData.map((e) => e['macd']).where((e) => e != null).cast<double>();
    final signalValues = macdData.map((e) => e['signal']).where((e) => e != null).cast<double>();
    
    if (macdValues.isEmpty || signalValues.isEmpty) return;
    
    final maxMacd = math.max(macdValues.reduce(math.max), signalValues.reduce(math.max));
    final minMacd = math.min(macdValues.reduce(math.min), signalValues.reduce(math.min));
    final macdRange = maxMacd - minMacd;
    
    if (macdRange == 0) return;

    final macdPath = Path();
    final signalPath = Path();
    bool firstMacdPoint = true;
    bool firstSignalPoint = true;
    
    for (int i = 0; i < macdData.length; i++) {
      final data = macdData[i];
      final macdValue = data['macd'];
      final signalValue = data['signal'];
      
      final x = (i / (priceHistory.length - 1)) * size.width;
      
      if (macdValue != null) {
        final y = macdTop + (macdHeight * (1 - (macdValue - minMacd) / macdRange));
        if (firstMacdPoint) {
          macdPath.moveTo(x, y);
          firstMacdPoint = false;
        } else {
          macdPath.lineTo(x, y);
        }
      }
      
      if (signalValue != null) {
        final y = macdTop + (macdHeight * (1 - (signalValue - minMacd) / macdRange));
        if (firstSignalPoint) {
          signalPath.moveTo(x, y);
          firstSignalPoint = false;
        } else {
          signalPath.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(macdPath, macdPaint);
    canvas.drawPath(signalPath, signalPaint);
    
    _drawLegend(canvas, size, 'MACD', Colors.blue, macdTop + 5);
  }

  void _drawVWAP(Canvas canvas, Size size) {
    final vwapValues = _calculateVWAP();
    
    final paint = Paint()
      ..color = Colors.cyan.withValues(alpha: 0.8)
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
    _drawLegend(canvas, size, 'VWAP', Colors.cyan, 45.0);
  }

  void _drawStochastic(Canvas canvas, Size size) {
    final stochData = _calculateStochastic();
    
    // Calculate available height excluding bottom margin
    final availableHeight = size.height - bottomMargin;
    final stochHeight = availableHeight * 0.15;
    final stochTop = availableHeight - stochHeight;
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7);
    
    canvas.drawRect(
      Rect.fromLTWH(0, stochTop, size.width, stochHeight),
      bgPaint,
    );

    // Draw overbought/oversold levels
    final levelPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    final overboughtY = stochTop + (stochHeight * 0.2); // 80 level
    final oversoldY = stochTop + (stochHeight * 0.8); // 20 level

    canvas.drawLine(Offset(0, overboughtY), Offset(size.width, overboughtY), levelPaint);
    canvas.drawLine(Offset(0, oversoldY), Offset(size.width, oversoldY), levelPaint);

    // Draw %K and %D lines
    final kPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final kPath = Path();
    final dPath = Path();
    bool firstKPoint = true;
    bool firstDPoint = true;
    
    for (int i = 0; i < stochData.length; i++) {
      final data = stochData[i];
      final kValue = data['%K'];
      final dValue = data['%D'];
      
      final x = (i / (priceHistory.length - 1)) * size.width;
      
      if (kValue != null) {
        final y = stochTop + (stochHeight * (1 - kValue / 100));
        if (firstKPoint) {
          kPath.moveTo(x, y);
          firstKPoint = false;
        } else {
          kPath.lineTo(x, y);
        }
      }
      
      if (dValue != null) {
        final y = stochTop + (stochHeight * (1 - dValue / 100));
        if (firstDPoint) {
          dPath.moveTo(x, y);
          firstDPoint = false;
        } else {
          dPath.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(kPath, kPaint);
    canvas.drawPath(dPath, dPaint);
    
    _drawLegend(canvas, size, 'Stoch', Colors.green, stochTop + 5);
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
    
    _drawLegend(canvas, size, 'SAR', Colors.pink, 55.0);
  }

  void _drawATR(Canvas canvas, Size size) {
    // ATR is typically shown as a separate indicator at the bottom
    final atrValues = _calculateATR(14);
    
    // Calculate available height excluding bottom margin
    final availableHeight = size.height - bottomMargin;
    final atrHeight = availableHeight * 0.1;
    final atrTop = availableHeight - atrHeight;
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7);
    
    canvas.drawRect(
      Rect.fromLTWH(0, atrTop, size.width, atrHeight),
      bgPaint,
    );

    // Find ATR range
    final validAtr = atrValues.where((e) => e != null).cast<double>();
    if (validAtr.isEmpty) return;
    
    final maxAtr = validAtr.reduce(math.max);
    final minAtr = validAtr.reduce(math.min);
    final atrRange = maxAtr - minAtr;
    
    if (atrRange == 0) return;

    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    bool firstPoint = true;
    
    for (int i = 0; i < atrValues.length; i++) {
      if (atrValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final y = atrTop + (atrHeight * (1 - (atrValues[i]! - minAtr) / atrRange));
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, paint);
    _drawLegend(canvas, size, 'ATR(14)', Colors.orange, atrTop + 5);
  }

  void _drawVolumeOverlay(Canvas canvas, Size size) {
    // Volume bars positioned above the bottom controls
    final availableHeight = size.height - bottomMargin;
    final volumeHeight = availableHeight * 0.15;
    final volumeTop = availableHeight - volumeHeight;
    
    final maxVolume = priceHistory.map((e) => e.volume).reduce(math.max);
    
    for (int i = 0; i < priceHistory.length; i++) {
      final x = (i / (priceHistory.length - 1)) * size.width;
      final volumePercent = priceHistory[i].volume / maxVolume;
      final barHeight = volumeHeight * volumePercent;
      
      final isUp = priceHistory[i].close >= priceHistory[i].open;
      final paint = Paint()
        ..color = (isUp ? Colors.green : Colors.red).withValues(alpha: 0.6);
      
      canvas.drawRect(
        Rect.fromLTWH(x - 1, volumeTop + volumeHeight - barHeight, 2, barHeight),
        paint,
      );
    }
    
    _drawLegend(canvas, size, 'Volume', Colors.grey, volumeTop + 5);
  }

  void _drawLegend(Canvas canvas, Size size, String text, Color color, double topOffset) {
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
    textPainter.paint(canvas, Offset(10, topOffset));
  }

  // Calculation methods
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

  List<double?> _calculateRSI(int period) {
    final result = List<double?>.filled(priceHistory.length, null);
    
    if (priceHistory.length < period + 1) return result;
    
    double avgGain = 0;
    double avgLoss = 0;
    
    // Calculate initial average gain and loss
    for (int i = 1; i <= period; i++) {
      final change = priceHistory[i].close - priceHistory[i - 1].close;
      if (change >= 0) {
        avgGain += change;
      } else {
        avgLoss += change.abs();
      }
    }
    
    avgGain /= period;
    avgLoss /= period;
    
    if (avgLoss == 0) {
      result[period] = 100;
    } else {
      final rs = avgGain / avgLoss;
      result[period] = 100 - (100 / (1 + rs));
    }
    
    // Calculate RSI for remaining periods
    for (int i = period + 1; i < priceHistory.length; i++) {
      final change = priceHistory[i].close - priceHistory[i - 1].close;
      final gain = change >= 0 ? change : 0;
      final loss = change < 0 ? change.abs() : 0;
      
      avgGain = ((avgGain * (period - 1)) + gain) / period;
      avgLoss = ((avgLoss * (period - 1)) + loss) / period;
      
      if (avgLoss == 0) {
        result[i] = 100;
      } else {
        final rs = avgGain / avgLoss;
        result[i] = 100 - (100 / (1 + rs));
      }
    }
    
    return result;
  }

  List<Map<String, double?>> _calculateMACD() {
    final ema12 = _calculateEMA(12);
    final ema26 = _calculateEMA(26);
    final result = <Map<String, double?>>[];
    
    // Calculate MACD line
    final macdLine = <double?>[];
    for (int i = 0; i < priceHistory.length; i++) {
      if (ema12[i] != null && ema26[i] != null) {
        macdLine.add(ema12[i]! - ema26[i]!);
      } else {
        macdLine.add(null);
      }
    }
    
    // Calculate Signal line (9-period EMA of MACD)
    final signalLine = List<double?>.filled(priceHistory.length, null);
    final validMacdIndices = <int>[];
    
    for (int i = 0; i < macdLine.length; i++) {
      if (macdLine[i] != null) {
        validMacdIndices.add(i);
      }
    }
    
    if (validMacdIndices.length >= 9) {
      // Start signal calculation
      final multiplier = 2.0 / 10;
      
      // First signal value (SMA of first 9 MACD values)
      double sum = 0;
      for (int j = 0; j < 9; j++) {
        sum += macdLine[validMacdIndices[j]]!;
      }
      signalLine[validMacdIndices[8]] = sum / 9;
      
      // Calculate remaining signal values
      for (int i = 9; i < validMacdIndices.length; i++) {
        final currentIndex = validMacdIndices[i];
        final prevIndex = validMacdIndices[i - 1];
        signalLine[currentIndex] = (macdLine[currentIndex]! * multiplier) + 
                                 (signalLine[prevIndex]! * (1 - multiplier));
      }
    }
    
    // Combine results
    for (int i = 0; i < priceHistory.length; i++) {
      result.add({
        'macd': macdLine[i],
        'signal': signalLine[i],
        'histogram': (macdLine[i] != null && signalLine[i] != null) 
                    ? macdLine[i]! - signalLine[i]! 
                    : null,
      });
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

  List<Map<String, double?>> _calculateStochastic() {
    const int kPeriod = 14;
    const int dPeriod = 3;
    final result = <Map<String, double?>>[];
    
    // Calculate %K
    final kValues = List<double?>.filled(priceHistory.length, null);
    
    for (int i = kPeriod - 1; i < priceHistory.length; i++) {
      double highestHigh = priceHistory[i - kPeriod + 1].high;
      double lowestLow = priceHistory[i - kPeriod + 1].low;
      
      for (int j = i - kPeriod + 2; j <= i; j++) {
        highestHigh = math.max(highestHigh, priceHistory[j].high);
        lowestLow = math.min(lowestLow, priceHistory[j].low);
      }
      
      if (highestHigh != lowestLow) {
        kValues[i] = ((priceHistory[i].close - lowestLow) / (highestHigh - lowestLow)) * 100;
      }
    }
    
    // Calculate %D (SMA of %K)
    final dValues = List<double?>.filled(priceHistory.length, null);
    
    for (int i = kPeriod + dPeriod - 2; i < priceHistory.length; i++) {
      double sum = 0;
      int count = 0;
      
      for (int j = 0; j < dPeriod; j++) {
        if (kValues[i - j] != null) {
          sum += kValues[i - j]!;
          count++;
        }
      }
      
      if (count > 0) {
        dValues[i] = sum / count;
      }
    }
    
    // Combine results
    for (int i = 0; i < priceHistory.length; i++) {
      result.add({
        '%K': kValues[i],
        '%D': dValues[i],
      });
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
        // Check for trend reversal
        if (currentLow <= sar) {
          // Trend reversal
          isUptrend = false;
          sar = extremePoint;
          extremePoint = currentLow;
          acceleration = accelerationStart;
        } else {
          // Continue uptrend
          if (currentHigh > extremePoint) {
            extremePoint = currentHigh;
            acceleration = math.min(acceleration + accelerationStep, accelerationMax);
          }
        }
      } else {
        // Check for trend reversal
        if (currentHigh >= sar) {
          // Trend reversal
          isUptrend = true;
          sar = extremePoint;
          extremePoint = currentHigh;
          acceleration = accelerationStart;
        } else {
          // Continue downtrend
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

  List<double?> _calculateATR(int period) {
    final result = List<double?>.filled(priceHistory.length, null);
    
    if (priceHistory.length < period + 1) return result;
    
    // Calculate True Range for each period
    final trueRanges = <double>[];
    
    for (int i = 1; i < priceHistory.length; i++) {
      final high = priceHistory[i].high;
      final low = priceHistory[i].low;
      final prevClose = priceHistory[i - 1].close;
      
      final tr1 = high - low;
      final tr2 = (high - prevClose).abs();
      final tr3 = (low - prevClose).abs();
      
      trueRanges.add(math.max(tr1, math.max(tr2, tr3)));
    }
    
    // Calculate initial ATR (simple average)
    if (trueRanges.length >= period) {
      double sum = 0;
      for (int i = 0; i < period; i++) {
        sum += trueRanges[i];
      }
      result[period] = sum / period;
      
      // Calculate subsequent ATR values (smoothed)
      for (int i = period + 1; i < priceHistory.length; i++) {
        result[i] = ((result[i - 1]! * (period - 1)) + trueRanges[i - 1]) / period;
      }
    }
    
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 