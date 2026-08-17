part of 'crypto_chart_details_screen.dart';

enum ChartType { line, candlestick, area, ohlc, volume, heikinAshi, hollowCandles }

// CryptoPrice data model for chart
class CryptoPrice {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  CryptoPrice({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}

// IndicatorInfo class
class IndicatorInfo {
  final String name;
  final String description;
  final String parameters;

  const IndicatorInfo({
    required this.name,
    required this.description,
    required this.parameters,
  });
}

// DrawingToolInfo class
class DrawingToolInfo {
  final DrawingTool tool;
  final String name;
  final String description;

  const DrawingToolInfo(this.tool, this.name, this.description);
}
