part of 'stock_chart_details_screen.dart';

enum ChartType { line, candlestick, area, ohlc, volume, heikinAshi, hollowCandles }

// Move IndicatorInfo class to top level
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

// Add this near the top of the file with other classes
class DrawingToolInfo {
  final DrawingTool tool;
  final String name;
  final String description;

  const DrawingToolInfo(this.tool, this.name, this.description);
}
