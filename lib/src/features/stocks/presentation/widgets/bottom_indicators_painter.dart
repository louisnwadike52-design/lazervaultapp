import 'package:flutter/material.dart';
import '../../domain/entities/stock_entity.dart';
import 'dart:math' as math;

class BottomIndicatorsPainter extends CustomPainter {
  final List<StockPrice> priceHistory;
  final List<String> selectedIndicators;

  BottomIndicatorsPainter({
    required this.priceHistory,
    required this.selectedIndicators,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (priceHistory.isEmpty || selectedIndicators.isEmpty) return;
    if (size.width <= 0 || size.height <= 0) return;

    try {
      double currentTop = 0;
      
      // Draw each bottom indicator in separate panels
      for (final indicator in selectedIndicators) {
        double panelHeight = 0;
        
        switch (indicator) {
          case 'RSI':
            panelHeight = _drawRSI(canvas, size, currentTop, 120);
            break;
          case 'MACD':
            panelHeight = _drawMACD(canvas, size, currentTop, 120);
            break;
          case 'Stochastic':
            panelHeight = _drawStochastic(canvas, size, currentTop, 100);
            break;
          case 'ATR':
            panelHeight = _drawATR(canvas, size, currentTop, 80);
            break;
          case 'Volume':
            panelHeight = _drawVolume(canvas, size, currentTop, 100);
            break;
        }
        
        currentTop += panelHeight;
        
        // Draw separator line between indicators
        if (currentTop < size.height) {
          final separatorPaint = Paint()
            ..color = Colors.grey.withOpacity(0.3)
            ..strokeWidth = 1.0;
          
          canvas.drawLine(
            Offset(0, currentTop), 
            Offset(size.width, currentTop), 
            separatorPaint
          );
        }
      }
    } catch (e) {
      print('Error painting bottom indicators: $e');
    }
  }

  double _drawRSI(Canvas canvas, Size size, double top, double height) {
    final rsiValues = _calculateRSI(14);
    final panelRect = Rect.fromLTWH(0, top, size.width, height);
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);
    canvas.drawRect(panelRect, bgPaint);

    // Draw title
    _drawPanelTitle(canvas, 'RSI (14)', Colors.yellow, top + 5);

    // Draw RSI levels (30, 50, 70)
    final levelPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 0.5;

    final oversoldY = top + (height * 0.7); // 30 level
    final midY = top + (height * 0.5); // 50 level
    final overboughtY = top + (height * 0.3); // 70 level

    canvas.drawLine(Offset(0, oversoldY), Offset(size.width, oversoldY), levelPaint);
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), levelPaint);
    canvas.drawLine(Offset(0, overboughtY), Offset(size.width, overboughtY), levelPaint);

    // Draw level labels
    _drawLevelLabel(canvas, '70', Colors.grey, size.width - 25, overboughtY - 5);
    _drawLevelLabel(canvas, '50', Colors.grey, size.width - 25, midY - 5);
    _drawLevelLabel(canvas, '30', Colors.grey, size.width - 25, oversoldY - 5);

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
        final y = top + (height * 0.9) - ((height * 0.8) * (rsiValues[i]! / 100));
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, rsiPaint);
    return height;
  }

  double _drawMACD(Canvas canvas, Size size, double top, double height) {
    final macdData = _calculateMACD();
    final panelRect = Rect.fromLTWH(0, top, size.width, height);
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);
    canvas.drawRect(panelRect, bgPaint);

    // Draw title
    _drawPanelTitle(canvas, 'MACD (12,26,9)', Colors.blue, top + 5);

    // Find MACD range for scaling
    final macdValues = macdData.map((e) => e['macd'] as double?).where((e) => e != null).cast<double>();
    final signalValues = macdData.map((e) => e['signal'] as double?).where((e) => e != null).cast<double>();
    
    if (macdValues.isEmpty || signalValues.isEmpty) return height;
    
    final maxMacd = math.max(macdValues.reduce(math.max), signalValues.reduce(math.max));
    final minMacd = math.min(macdValues.reduce(math.min), signalValues.reduce(math.min));
    final macdRange = maxMacd - minMacd;
    
    if (macdRange == 0) return height;

    // Draw zero line
    final zeroY = top + (height * 0.5);
    final zeroLinePaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0, zeroY), Offset(size.width, zeroY), zeroLinePaint);

    // Draw MACD and Signal lines
    final macdPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final signalPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final macdPath = Path();
    final signalPath = Path();
    bool firstMacdPoint = true;
    bool firstSignalPoint = true;
    
    for (int i = 0; i < macdData.length; i++) {
      final data = macdData[i];
      final macdValue = data['macd'] as double?;
      final signalValue = data['signal'] as double?;
      
      final x = (i / (priceHistory.length - 1)) * size.width;
      
      if (macdValue != null) {
        final normalizedY = (macdValue - minMacd) / macdRange;
        final y = top + height - (normalizedY * height * 0.8) - (height * 0.1);
        
        if (firstMacdPoint) {
          macdPath.moveTo(x, y);
          firstMacdPoint = false;
        } else {
          macdPath.lineTo(x, y);
        }
      }
      
      if (signalValue != null) {
        final normalizedY = (signalValue - minMacd) / macdRange;
        final y = top + height - (normalizedY * height * 0.8) - (height * 0.1);
        
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
    
    return height;
  }

  double _drawStochastic(Canvas canvas, Size size, double top, double height) {
    final stochData = _calculateStochastic();
    final panelRect = Rect.fromLTWH(0, top, size.width, height);
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);
    canvas.drawRect(panelRect, bgPaint);

    // Draw title
    _drawPanelTitle(canvas, 'Stochastic (14,3,3)', Colors.green, top + 5);

    // Draw overbought/oversold levels
    final levelPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 0.5;

    final overboughtY = top + (height * 0.2); // 80 level
    final oversoldY = top + (height * 0.8); // 20 level

    canvas.drawLine(Offset(0, overboughtY), Offset(size.width, overboughtY), levelPaint);
    canvas.drawLine(Offset(0, oversoldY), Offset(size.width, oversoldY), levelPaint);

    // Draw level labels
    _drawLevelLabel(canvas, '80', Colors.grey, size.width - 25, overboughtY - 5);
    _drawLevelLabel(canvas, '20', Colors.grey, size.width - 25, oversoldY - 5);

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
      final kValue = data['%K'] as double?;
      final dValue = data['%D'] as double?;
      
      final x = (i / (priceHistory.length - 1)) * size.width;
      
      if (kValue != null) {
        final y = top + (height * 0.9) - ((height * 0.8) * (kValue / 100));
        if (firstKPoint) {
          kPath.moveTo(x, y);
          firstKPoint = false;
        } else {
          kPath.lineTo(x, y);
        }
      }
      
      if (dValue != null) {
        final y = top + (height * 0.9) - ((height * 0.8) * (dValue / 100));
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
    
    return height;
  }

  double _drawATR(Canvas canvas, Size size, double top, double height) {
    final atrValues = _calculateATR(14);
    final panelRect = Rect.fromLTWH(0, top, size.width, height);
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);
    canvas.drawRect(panelRect, bgPaint);

    // Draw title
    _drawPanelTitle(canvas, 'ATR (14)', Colors.orange, top + 5);

    // Find ATR range
    final validAtr = atrValues.where((e) => e != null).cast<double>();
    if (validAtr.isEmpty) return height;
    
    final maxAtr = validAtr.reduce(math.max);
    final minAtr = validAtr.reduce(math.min);
    final atrRange = maxAtr - minAtr;
    
    if (atrRange == 0) return height;

    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    bool firstPoint = true;
    
    for (int i = 0; i < atrValues.length; i++) {
      if (atrValues[i] != null) {
        final x = (i / (priceHistory.length - 1)) * size.width;
        final normalizedY = (atrValues[i]! - minAtr) / atrRange;
        final y = top + height - (normalizedY * height * 0.8) - (height * 0.1);
        
        if (firstPoint) {
          path.moveTo(x, y);
          firstPoint = false;
        } else {
          path.lineTo(x, y);
        }
      }
    }

    canvas.drawPath(path, paint);
    return height;
  }

  double _drawVolume(Canvas canvas, Size size, double top, double height) {
    final panelRect = Rect.fromLTWH(0, top, size.width, height);
    
    // Draw background
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);
    canvas.drawRect(panelRect, bgPaint);

    // Draw title
    _drawPanelTitle(canvas, 'Volume', Colors.grey, top + 5);

    final maxVolume = priceHistory.map((e) => e.volume).reduce(math.max);
    
    for (int i = 0; i < priceHistory.length; i++) {
      final x = (i / (priceHistory.length - 1)) * size.width;
      final volumePercent = priceHistory[i].volume / maxVolume;
      final barHeight = (height * 0.8) * volumePercent;
      
      final isUp = priceHistory[i].close >= priceHistory[i].open;
      final paint = Paint()
        ..color = (isUp ? Colors.green : Colors.red).withOpacity(0.7);
      
      canvas.drawRect(
        Rect.fromLTWH(x - 1, top + height - barHeight - (height * 0.1), 2, barHeight),
        paint,
      );
    }
    
    return height;
  }

  void _drawPanelTitle(Canvas canvas, String title, Color color, double topOffset) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, topOffset));
  }

  void _drawLevelLabel(Canvas canvas, String label, Color color, double x, double y) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color,
          fontSize: 10,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));
  }

  // Calculation methods
  List<double?> _calculateRSI(int period) {
    final result = List<double?>.filled(priceHistory.length, null);
    
    if (priceHistory.length < period + 1) return result;
    
    double avgGain = 0;
    double avgLoss = 0;
    
    // Calculate initial average gain and loss
    for (int i = 1; i <= period; i++) {
      final change = priceHistory[i].close - priceHistory[i - 1].close;
      if (change > 0) {
        avgGain += change;
      } else {
        avgLoss += (-change);
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
      final gain = change > 0 ? change : 0;
      final loss = change < 0 ? (-change) : 0;
      
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
    final result = <Map<String, double?>>[];
    
    // Calculate EMA12 and EMA26
    final ema12 = _calculateEMA(12);
    final ema26 = _calculateEMA(26);
    
    // Calculate MACD line
    final macdLine = <double?>[];
    for (int i = 0; i < priceHistory.length; i++) {
      if (ema12[i] != null && ema26[i] != null) {
        macdLine.add(ema12[i]! - ema26[i]!);
      } else {
        macdLine.add(null);
      }
    }
    
    // Calculate signal line (EMA9 of MACD)
    final signalLine = _calculateEMAFromValues(macdLine, 9);
    
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

  List<Map<String, double?>> _calculateStochastic() {
    const int kPeriod = 14;
    const int dPeriod = 3;
    
    final result = <Map<String, double?>>[];
    final kValues = <double?>[];
    
    // Calculate %K
    for (int i = 0; i < priceHistory.length; i++) {
      if (i < kPeriod - 1) {
        kValues.add(null);
      } else {
        double highestHigh = priceHistory[i].high;
        double lowestLow = priceHistory[i].low;
        
        for (int j = i - kPeriod + 1; j <= i; j++) {
          highestHigh = math.max(highestHigh, priceHistory[j].high);
          lowestLow = math.min(lowestLow, priceHistory[j].low);
        }
        
        if (highestHigh == lowestLow) {
          kValues.add(50);
        } else {
          final k = ((priceHistory[i].close - lowestLow) / (highestHigh - lowestLow)) * 100;
          kValues.add(k);
        }
      }
    }
    
    // Calculate %D (SMA of %K)
    final dValues = _calculateSMAFromValues(kValues, dPeriod);
    
    for (int i = 0; i < priceHistory.length; i++) {
      result.add({
        '%K': kValues[i],
        '%D': dValues[i],
      });
    }
    
    return result;
  }

  List<double?> _calculateATR(int period) {
    final result = List<double?>.filled(priceHistory.length, null);
    final trueRanges = <double>[];
    
    if (priceHistory.length < 2) return result;
    
    // Calculate true ranges
    for (int i = 1; i < priceHistory.length; i++) {
      final high = priceHistory[i].high;
      final low = priceHistory[i].low;
      final prevClose = priceHistory[i - 1].close;
      
      final tr1 = high - low;
      final tr2 = (high - prevClose).abs();
      final tr3 = (low - prevClose).abs();
      
      trueRanges.add(math.max(tr1, math.max(tr2, tr3)));
    }
    
    // Calculate ATR
    if (trueRanges.length >= period) {
      // First ATR is SMA of true ranges
      double sum = 0;
      for (int i = 0; i < period; i++) {
        sum += trueRanges[i];
      }
      result[period] = sum / period;
      
      // Subsequent ATRs are smoothed
      for (int i = period + 1; i < priceHistory.length; i++) {
        final prevATR = result[i - 1]!;
        final currentTR = trueRanges[i - 1];
        result[i] = ((prevATR * (period - 1)) + currentTR) / period;
      }
    }
    
    return result;
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

  List<double?> _calculateEMAFromValues(List<double?> values, int period) {
    final result = List<double?>.filled(values.length, null);
    final multiplier = 2.0 / (period + 1);
    
    // Find first non-null value
    int startIndex = -1;
    for (int i = 0; i < values.length; i++) {
      if (values[i] != null) {
        startIndex = i;
        break;
      }
    }
    
    if (startIndex == -1 || startIndex + period > values.length) return result;
    
    // Start with SMA for the first value
    double sum = 0;
    int count = 0;
    for (int i = startIndex; i < startIndex + period && i < values.length; i++) {
      if (values[i] != null) {
        sum += values[i]!;
        count++;
      }
    }
    
    if (count > 0) {
      result[startIndex + period - 1] = sum / count;
    }
    
    // Calculate EMA for the rest
    for (int i = startIndex + period; i < values.length; i++) {
      if (values[i] != null && result[i - 1] != null) {
        result[i] = (values[i]! * multiplier) + (result[i - 1]! * (1 - multiplier));
      }
    }
    
    return result;
  }

  List<double?> _calculateSMAFromValues(List<double?> values, int period) {
    final result = List<double?>.filled(values.length, null);
    
    for (int i = period - 1; i < values.length; i++) {
      double sum = 0;
      int count = 0;
      
      for (int j = i - period + 1; j <= i; j++) {
        if (values[j] != null) {
          sum += values[j]!;
          count++;
        }
      }
      
      if (count == period) {
        result[i] = sum / period;
      }
    }
    
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 