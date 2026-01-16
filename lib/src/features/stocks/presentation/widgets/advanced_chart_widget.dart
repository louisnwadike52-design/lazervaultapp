import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/stock_entity.dart';
import 'chart_painters.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';

enum ChartType { line, candlestick, area, ohlc, volume }

class AdvancedChartWidget extends StatefulWidget {
  final List<StockPrice> priceHistory;
  final Stock stock;
  final List<String> selectedIndicators;
  final String timeframe;

  const AdvancedChartWidget({
    super.key,
    required this.priceHistory,
    required this.stock,
    required this.selectedIndicators,
    required this.timeframe,
  });

  @override
  State<AdvancedChartWidget> createState() => _AdvancedChartWidgetState();
}

class _AdvancedChartWidgetState extends State<AdvancedChartWidget> {
  ChartType _selectedChartType = ChartType.line;
  
  // Pan and zoom variables
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _currentPanX = 0.0;
  int _visibleDataPoints = 30;
  int _startIndex = 0;
  
  // Touch interaction
  bool _isDragging = false;
  bool _isScaling = false;
  double _lastPanX = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeChart();
  }

  @override
  void didUpdateWidget(AdvancedChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.priceHistory.length != widget.priceHistory.length) {
      _initializeChart();
    }
  }

  void _initializeChart() {
    final priceHistory = widget.priceHistory.isNotEmpty 
        ? widget.priceHistory 
        : _generateMockPriceHistory();
    
    _visibleDataPoints = (priceHistory.length * 0.8).round().clamp(10, 50);
    _startIndex = (priceHistory.length - _visibleDataPoints).clamp(0, priceHistory.length - 1);
    _currentScale = 1.0;
    _baseScale = 1.0;
    _currentPanX = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.priceHistory.isEmpty) {
      return SizedBox(
        height: 300.h,
        child: Center(
          child: Text(
            'Loading chart data...',
            style: GoogleFonts.inter(color: Colors.grey[400]),
          ),
        ),
      );
    }

    final priceHistory = widget.priceHistory.isNotEmpty 
        ? widget.priceHistory 
        : _generateMockPriceHistory();

    return Column(
      children: [
        _buildChartTypeSelector(),
        SizedBox(height: 16.h),
        _buildChartInfo(),
        SizedBox(height: 8.h),
        SizedBox(
          height: 300.h,
          child: Stack(
            children: [
              _buildInteractiveChart(priceHistory),
              if (widget.selectedIndicators.contains('Volume') && _selectedChartType != ChartType.volume)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60.h,
                  child: _buildVolumeChart(_getVisibleData(priceHistory)),
                ),
              _buildPriceLabels(_getVisibleData(priceHistory)),
              _buildInteractionIndicators(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartInfo() {
    return Row(
      children: [
        Text(
          'Zoom: ${_currentScale.toStringAsFixed(1)}x',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          'Showing: ${_startIndex + 1}-${(_startIndex + _visibleDataPoints).clamp(0, widget.priceHistory.length)}',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.stockChartDetails, arguments: widget.stock),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fullscreen, color: Colors.white, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  'Expand',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: _resetZoom,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.center_focus_strong, color: Colors.white, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  'Reset',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionIndicators() {
    return Stack(
      children: [
        // Pan indicator
        if (_isDragging)
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.pan_tool, color: Colors.white, size: 12.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Panning',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        
        // Zoom indicator
        if (_isScaling)
          Positioned(
            top: 10.h,
            left: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.zoom_in, color: Colors.white, size: 12.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Zooming',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInteractiveChart(List<StockPrice> priceHistory) {
    return GestureDetector(
      onScaleStart: (details) {
        _baseScale = _currentScale;
        _lastPanX = details.focalPoint.dx;
        setState(() {
          _isDragging = false;
          _isScaling = false;
        });
      },
      onScaleUpdate: (details) {
        setState(() {
          // Detect if this is a zoom gesture (scale != 1.0) or pan gesture
          if ((details.scale - 1.0).abs() > 0.01) {
            // This is a zoom gesture
            _isScaling = true;
            _isDragging = false;
            
            final newScale = (_baseScale * details.scale).clamp(0.3, 8.0);
            final scaleDelta = newScale / _currentScale;
            
            // Calculate new visible data points based on scale
            final newVisiblePoints = (priceHistory.length / newScale).round().clamp(5, priceHistory.length);
            
            // Maintain center position during zoom
            final centerIndex = _startIndex + (_visibleDataPoints / 2).round();
            
            _currentScale = newScale;
            _visibleDataPoints = newVisiblePoints;
            _startIndex = (centerIndex - (_visibleDataPoints / 2).round())
                .clamp(0, priceHistory.length - _visibleDataPoints);
          } else if (!_isScaling) {
            // This is a pan gesture (only if not currently scaling)
            _isDragging = true;
            
            final deltaX = details.focalPoint.dx - _lastPanX;
            final panSensitivity = _visibleDataPoints / 400; // Adjust sensitivity based on zoom level
            final indexChange = (-deltaX * panSensitivity).round();
            
            _startIndex = (_startIndex + indexChange).clamp(0, priceHistory.length - _visibleDataPoints);
            _lastPanX = details.focalPoint.dx;
          }
        });
      },
      onScaleEnd: (details) {
        setState(() {
          _isDragging = false;
          _isScaling = false;
        });
        
        // Add some momentum to panning if desired
        if (details.velocity.pixelsPerSecond.distance > 500) {
          _applyPanMomentum(details.velocity.pixelsPerSecond.dx, priceHistory.length);
        }
      },
      child: _buildSelectedChart(_getVisibleData(priceHistory)),
    );
  }

  void _applyPanMomentum(double velocityX, int dataLength) {
    // Apply momentum-based panning for smooth scrolling
    final momentum = -velocityX / 1000; // Adjust momentum factor
    final indexChange = (momentum * _visibleDataPoints / 100).round();
    
    setState(() {
      _startIndex = (_startIndex + indexChange).clamp(0, dataLength - _visibleDataPoints);
    });
  }

  List<StockPrice> _getVisibleData(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return [];
    final endIndex = (_startIndex + _visibleDataPoints).clamp(0, priceHistory.length);
    return priceHistory.sublist(_startIndex, endIndex);
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _baseScale = 1.0;
      _currentPanX = 0.0;
      _isDragging = false;
      _isScaling = false;
      _initializeChart();
    });
  }

  Widget _buildChartTypeSelector() {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          _buildChartTypeButton(ChartType.line, Icons.show_chart, 'Line'),
          _buildChartTypeButton(ChartType.candlestick, Icons.candlestick_chart, 'Candle'),
          _buildChartTypeButton(ChartType.area, Icons.area_chart, 'Area'),
          _buildChartTypeButton(ChartType.ohlc, Icons.bar_chart, 'OHLC'),
          _buildChartTypeButton(ChartType.volume, Icons.bar_chart_outlined, 'Volume'),
        ],
      ),
    );
  }

  Widget _buildChartTypeButton(ChartType type, IconData icon, String label) {
    final isSelected = _selectedChartType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedChartType = type;
          });
        },
        child: Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.black : Colors.grey[400],
                size: 16.sp,
              ),
              SizedBox(height: 2.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.black : Colors.grey[400],
                  fontSize: 8.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedChart(List<StockPrice> visibleData) {
    switch (_selectedChartType) {
      case ChartType.line:
        return _buildLineChart(visibleData);
      case ChartType.candlestick:
        return _buildCandlestickChart(visibleData);
      case ChartType.area:
        return _buildAreaChart(visibleData);
      case ChartType.ohlc:
        return _buildOHLCChart(visibleData);
      case ChartType.volume:
        return _buildFullVolumeChart(visibleData);
    }
  }

  Widget _buildLineChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final spots = priceHistory.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.close);
    }).toList();

    final maxPrice = priceHistory.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b);

    return LineChart(
      LineChartData(
        minY: minPrice * 0.95,
        maxY: maxPrice * 1.05,
        minX: 0,
        maxX: priceHistory.length.toDouble() - 1,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (maxPrice - minPrice) / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                if (value.toInt() % (priceHistory.length ~/ 4).clamp(1, priceHistory.length) == 0 && 
                    value.toInt() < priceHistory.length) {
                  final date = priceHistory[value.toInt()].timestamp;
                  return Text(
                    '${date.month}/${date.day}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: false, // Disable built-in touch to avoid conflicts
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                if (spot.spotIndex < priceHistory.length) {
                  final price = priceHistory[spot.spotIndex];
                  return LineTooltipItem(
                    '\$${price.close.toStringAsFixed(2)}\n${price.timestamp.month}/${price.timestamp.day}',
                    GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return null;
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                widget.stock.isPositive ? Colors.green : Colors.red,
                widget.stock.isPositive ? Colors.green.withValues(alpha: 0.3) : Colors.red.withValues(alpha: 0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          ...widget.selectedIndicators.map((indicator) => _buildIndicatorLine(indicator, priceHistory)).where((line) => line.spots.isNotEmpty),
        ],
      ),
    );
  }

  Widget _buildAreaChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final spots = priceHistory.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.close);
    }).toList();

    final maxPrice = priceHistory.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b);

    return LineChart(
      LineChartData(
        minY: minPrice * 0.95,
        maxY: maxPrice * 1.05,
        minX: 0,
        maxX: priceHistory.length.toDouble() - 1,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (maxPrice - minPrice) / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: widget.stock.isPositive ? Colors.green : Colors.red,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  widget.stock.isPositive ? Colors.green.withValues(alpha: 0.4) : Colors.red.withValues(alpha: 0.4),
                  widget.stock.isPositive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandlestickChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final maxPrice = priceHistory.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b);

    return CustomPaint(
      size: Size(double.infinity, 300.h),
      painter: CandlestickPainter(
        priceHistory: priceHistory,
        maxPrice: maxPrice,
        minPrice: minPrice,
      ),
    );
  }

  Widget _buildOHLCChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final maxPrice = priceHistory.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b);

    return CustomPaint(
      size: Size(double.infinity, 300.h),
      painter: OHLCPainter(
        priceHistory: priceHistory,
        maxPrice: maxPrice,
        minPrice: minPrice,
      ),
    );
  }

  Widget _buildFullVolumeChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final volumeBars = priceHistory.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.volume,
            color: priceHistory[entry.key].close > 
                   (entry.key > 0 ? priceHistory[entry.key - 1].close : entry.value.close)
                ? Colors.green.withValues(alpha: 0.8)
                : Colors.red.withValues(alpha: 0.8),
            width: 3,
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: priceHistory.map((e) => e.volume).reduce((a, b) => a > b ? a : b) * 1.2,
        barGroups: volumeBars,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() % 5 == 0 && value.toInt() < priceHistory.length) {
                  final date = priceHistory[value.toInt()].timestamp;
                  return Text(
                    '${date.month}/${date.day}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Text(
                  _formatVolume(value),
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 10.sp,
                  ),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
      ),
    );
  }

  String _formatVolume(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }
    return volume.toStringAsFixed(0);
  }

  List<StockPrice> _generateMockPriceHistory() {
    final now = DateTime.now();
    final prices = <StockPrice>[];
    double basePrice = widget.stock.currentPrice;
    
    for (int i = 60; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final variation = (i % 5 - 2) * 0.02;
      final price = basePrice * (1 + variation);
      
      prices.add(StockPrice(
        timestamp: date,
        open: price * 0.99,
        high: price * 1.02,
        low: price * 0.98,
        close: price,
        volume: 1000000 + (i * 50000),
      ));
    }
    
    return prices;
  }

  LineChartBarData _buildIndicatorLine(String indicator, List<StockPrice> priceHistory) {
    List<FlSpot> spots = [];
    Color color = Colors.blue;

    switch (indicator) {
      case 'SMA':
        spots = _calculateSMA(20, priceHistory);
        color = Colors.orange;
        break;
      case 'EMA':
        spots = _calculateEMA(20, priceHistory);
        color = Colors.purple;
        break;
      case 'Bollinger Bands':
        return _buildBollingerBands(priceHistory);
      default:
        return LineChartBarData(spots: []);
    }

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 1.5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
    );
  }

  List<FlSpot> _calculateSMA(int period, List<StockPrice> priceHistory) {
    List<FlSpot> smaSpots = [];
    for (int i = period - 1; i < priceHistory.length; i++) {
      double sum = 0;
      for (int j = i - period + 1; j <= i; j++) {
        sum += priceHistory[j].close;
      }
      double sma = sum / period;
      smaSpots.add(FlSpot(i.toDouble(), sma));
    }
    return smaSpots;
  }

  List<FlSpot> _calculateEMA(int period, List<StockPrice> priceHistory) {
    List<FlSpot> emaSpots = [];
    double multiplier = 2.0 / (period + 1);
    double ema = priceHistory[0].close;

    for (int i = 0; i < priceHistory.length; i++) {
      if (i == 0) {
        ema = priceHistory[i].close;
      } else {
        ema = (priceHistory[i].close * multiplier) + (ema * (1 - multiplier));
      }
      emaSpots.add(FlSpot(i.toDouble(), ema));
    }
    return emaSpots;
  }

  LineChartBarData _buildBollingerBands(List<StockPrice> priceHistory) {
    final sma = _calculateSMA(20, priceHistory);
    return LineChartBarData(
      spots: sma,
      color: Colors.cyan,
      barWidth: 1,
      dotData: FlDotData(show: false),
    );
  }

  Widget _buildVolumeChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final volumeBars = priceHistory.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.volume,
            color: priceHistory[entry.key].close > 
                   (entry.key > 0 ? priceHistory[entry.key - 1].close : entry.value.close)
                ? Colors.green.withValues(alpha: 0.6)
                : Colors.red.withValues(alpha: 0.6),
            width: 2,
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: priceHistory.map((e) => e.volume).reduce((a, b) => a > b ? a : b) * 1.2,
        barGroups: volumeBars,
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }

  Widget _buildPriceLabels(List<StockPrice> priceHistory) {
    if (_selectedChartType == ChartType.volume || priceHistory.isEmpty) return Container();
    
    final maxPrice = priceHistory.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    final minPrice = priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b);
    final currentPrice = priceHistory.last.close;

    return Positioned(
      right: 8.w,
      top: 0,
      bottom: widget.selectedIndicators.contains('Volume') && _selectedChartType != ChartType.volume ? 60.h : 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            maxPrice.toStringAsFixed(2),
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: widget.stock.isPositive ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              currentPrice.toStringAsFixed(2),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            minPrice.toStringAsFixed(2),
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
} 