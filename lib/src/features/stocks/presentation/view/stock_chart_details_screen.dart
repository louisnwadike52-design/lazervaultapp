import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../domain/entities/stock_entity.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../widgets/chart_painters.dart';
import '../widgets/drawing_elements.dart';
import '../widgets/drawings_painter.dart';
import '../widgets/professional_candlestick_painter.dart';
import '../widgets/indicators_painter.dart';
import '../widgets/crosshair_painter.dart';
import 'package:flutter/services.dart';
import '../widgets/price_overlay_indicators_painter.dart';
import '../widgets/bottom_indicators_painter.dart';

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

class StockChartDetailsScreen extends StatefulWidget {
  final Stock stock;

  const StockChartDetailsScreen({
    super.key,
    required this.stock,
  });

  @override
  State<StockChartDetailsScreen> createState() => _StockChartDetailsScreenState();
}

class _StockChartDetailsScreenState extends State<StockChartDetailsScreen> {
  ChartType _selectedChartType = ChartType.candlestick;
  DrawingTool _selectedDrawingTool = DrawingTool.none;
  String _selectedTimeframe = '1D';
  List<String> _selectedIndicators = [];
  List<Stock> _comparisonStocks = [];
  
  // Pan and zoom variables
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _currentPanX = 0.0;
  int _visibleDataPoints = 50;
  int _startIndex = 0;
  
  // Touch interaction
  bool _isDragging = false;
  bool _isScaling = false;
  double _lastPanX = 0.0;
  
  // Drawing data
  List<DrawingElement> _drawings = [];
  DrawingElement? _currentDrawing;
  bool _isDrawing = false;
  Offset? _drawingStartPoint;
  
  // Add these new variables for dragging functionality
  DrawingElement? _selectedDrawing;
  bool _isDraggingDrawing = false;
  Offset? _dragStartPoint;
  int? _selectedDrawingIndex;

  // Crosshair
  bool _showCrosshair = false;
  Offset? _crosshairPosition;

  final List<String> _timeframes = ['1m', '5m', '15m', '30m', '1H', '4H', '1D', '1W', '1M'];

  // Define indicator lists with proper constructor calls
  final List<IndicatorInfo> _trendIndicators = const [
    IndicatorInfo(
      name: 'Moving Average',
      description: 'Simple moving average line',
      parameters: '20, 50, 200',
    ),
    IndicatorInfo(
      name: 'EMA',
      description: 'Exponential moving average',
      parameters: '12, 26, 50',
    ),
    IndicatorInfo(
      name: 'VWAP',
      description: 'Volume weighted average price',
      parameters: 'Session',
    ),
    IndicatorInfo(
      name: 'Ichimoku',
      description: 'Ichimoku cloud indicator',
      parameters: '9, 26, 52',
    ),
    IndicatorInfo(
      name: 'Parabolic SAR',
      description: 'Stop and reverse indicator',
      parameters: '0.02, 0.2',
    ),
    IndicatorInfo(
      name: 'Supertrend',
      description: 'Trend following indicator',
      parameters: '10, 3.0',
    ),
  ];

  final List<IndicatorInfo> _momentumIndicators = const [
    IndicatorInfo(
      name: 'RSI',
      description: 'Relative strength index',
      parameters: '14',
    ),
    IndicatorInfo(
      name: 'MACD',
      description: 'Moving average convergence divergence',
      parameters: '12, 26, 9',
    ),
    IndicatorInfo(
      name: 'Stochastic',
      description: 'Stochastic oscillator',
      parameters: '14, 3, 3',
    ),
    IndicatorInfo(
      name: 'Williams %R',
      description: 'Williams percent range',
      parameters: '14',
    ),
    IndicatorInfo(
      name: 'CCI',
      description: 'Commodity channel index',
      parameters: '20',
    ),
    IndicatorInfo(
      name: 'ROC',
      description: 'Rate of change',
      parameters: '12',
    ),
  ];

  final List<IndicatorInfo> _volumeIndicators = const [
    IndicatorInfo(
      name: 'Volume',
      description: 'Trading volume bars',
      parameters: 'Session',
    ),
    IndicatorInfo(
      name: 'Volume Profile',
      description: 'Volume at price levels',
      parameters: 'Session',
    ),
    IndicatorInfo(
      name: 'OBV',
      description: 'On-balance volume',
      parameters: 'Cumulative',
    ),
    IndicatorInfo(
      name: 'A/D Line',
      description: 'Accumulation/distribution line',
      parameters: 'Cumulative',
    ),
    IndicatorInfo(
      name: 'Money Flow',
      description: 'Chaikin money flow',
      parameters: '20',
    ),
    IndicatorInfo(
      name: 'VWMA',
      description: 'Volume weighted moving average',
      parameters: '20',
    ),
  ];

  final List<IndicatorInfo> _volatilityIndicators = const [
    IndicatorInfo(
      name: 'Bollinger Bands',
      description: 'Price volatility bands',
      parameters: '20, 2.0',
    ),
    IndicatorInfo(
      name: 'ATR',
      description: 'Average true range',
      parameters: '14',
    ),
    IndicatorInfo(
      name: 'Keltner Channel',
      description: 'Volatility-based channel',
      parameters: '20, 2.0',
    ),
    IndicatorInfo(
      name: 'Donchian Channel',
      description: 'Price channel indicator',
      parameters: '20',
    ),
    IndicatorInfo(
      name: 'Standard Deviation',
      description: 'Price standard deviation',
      parameters: '20',
    ),
    IndicatorInfo(
      name: 'VIX',
      description: 'Volatility index',
      parameters: 'Market',
    ),
  ];

  final List<IndicatorInfo> _supportResistanceIndicators = const [
    IndicatorInfo(
      name: 'Pivot Points',
      description: 'Standard pivot levels',
      parameters: 'Daily',
    ),
    IndicatorInfo(
      name: 'Fibonacci',
      description: 'Fibonacci retracement levels',
      parameters: 'High/Low',
    ),
    IndicatorInfo(
      name: 'Support/Resistance',
      description: 'Key price levels',
      parameters: 'Auto',
    ),
    IndicatorInfo(
      name: 'Camarilla',
      description: 'Camarilla pivot points',
      parameters: 'Daily',
    ),
    IndicatorInfo(
      name: 'Woodie Pivots',
      description: 'Woodie pivot points',
      parameters: 'Daily',
    ),
    IndicatorInfo(
      name: 'Floor Pivots',
      description: 'Floor trader pivots',
      parameters: 'Daily',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeChart();
  }

  void _initializeChart() {
    _visibleDataPoints = 50;
    _startIndex = 0;
    _currentScale = 1.0;
    _baseScale = 1.0;
    _currentPanX = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<StockCubit, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final priceHistory = _generateMockPriceHistory();
          
          return Stack(
            children: [
              // Full screen chart (90% height, 100% width)
              Positioned.fill(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  child: _buildFullScreenChart(priceHistory),
                ),
              ),
              
              // Top overlay with minimal info
              _buildTopOverlay(),
              
              // Bottom area with timeframe selector and controls
              _buildBottomControlsArea(),
              
              // Drawing tool indicator (moved to not cover chart)
              if (_selectedDrawingTool != DrawingTool.none)
                _buildDrawingToolIndicator(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopOverlay() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Stock symbol and name
            Expanded(
              child: GestureDetector(
                onTap: _showStockInfoBottomSheet,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.stock.symbol,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.stock.name,
                            style: GoogleFonts.inter(
                              color: Colors.grey[300],
                              fontSize: 12.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[300],
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Price info (moved to top bar)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: widget.stock.isPositive ? Colors.green : Colors.red,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${widget.stock.currentPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.stock.isPositive ? '+' : ''}${widget.stock.changePercent.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: widget.stock.isPositive ? Colors.green : Colors.red,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // More options button
            GestureDetector(
              onTap: _showMoreOptions,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawingToolIndicator() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 80.h, // Moved closer to top
      left: 16.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getDrawingToolIcon(_selectedDrawingTool),
              color: Colors.white,
              size: 16.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              _getDrawingToolName(_selectedDrawingTool),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDrawingTool = DrawingTool.none;
                });
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControlsArea() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
              Colors.black,
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildControlButton(
                Icons.schedule,
                _selectedTimeframe,
                () => _showTimeframeBottomSheet(),
                isSelected: true,
              ),
              _buildControlButton(
                Icons.timeline,
                _getChartTypeName(_selectedChartType),
                () => _showChartTypeBottomSheet(),
              ),
              _buildControlButton(
                Icons.add_chart,
                'Indicators${_selectedIndicators.isNotEmpty ? ' (${_selectedIndicators.length})' : ''}',
                () => _showIndicatorsBottomSheet(),
                hasNotification: _selectedIndicators.isNotEmpty,
              ),
              _buildControlButton(
                Icons.edit,
                'Draw',
                () => _showDrawingsBottomSheet(),
              ),
              _buildControlButton(
                Icons.analytics,
                'Analysis',
                () => _showAnalysisBottomSheet(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(
    IconData icon, 
    String label, 
    VoidCallback onTap, {
    bool isSelected = false,
    bool hasNotification = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected ? Border.all(color: Colors.blue, width: 1) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  icon, 
                  color: isSelected ? Colors.blue : Colors.white, 
                  size: 18.sp,
                ),
                if (hasNotification)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.blue : Colors.white,
                fontSize: 9.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showTimeframeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: Colors.blue, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Select Timeframe',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Current selection indicator
            if (_selectedTimeframe.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.blue, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Current: $_selectedTimeframe',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            
            // Timeframe categories
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeframeCategory(
                      'Minutes',
                      Icons.access_time,
                      Colors.green,
                      ['1m', '5m', '15m', '30m'],
                    ),
                    SizedBox(height: 20.h),
                    _buildTimeframeCategory(
                      'Hours',
                      Icons.schedule,
                      Colors.orange,
                      ['1H', '4H'],
                    ),
                    SizedBox(height: 20.h),
                    _buildTimeframeCategory(
                      'Days & Weeks',
                      Icons.calendar_today,
                      Colors.blue,
                      ['1D', '1W'],
                    ),
                    SizedBox(height: 20.h),
                    _buildTimeframeCategory(
                      'Months',
                      Icons.date_range,
                      Colors.purple,
                      ['1M'],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeframeCategory(
    String title,
    IconData icon,
    Color color,
    List<String> timeframes,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: color, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                if (timeframes.contains(_selectedTimeframe))
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: color),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: GoogleFonts.inter(
                        color: color,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Timeframe options
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: timeframes.map((timeframe) {
                final isSelected = _selectedTimeframe == timeframe;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTimeframe = timeframe;
                    });
                    
                    // Load new chart data
                    context.read<StockCubit>().loadStockChart(
                      widget.stock.symbol,
                      timeframe,
                    );
                    
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? color.withOpacity(0.2) 
                          : Colors.grey[700],
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(
                        color: isSelected ? color : Colors.grey[600]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected) ...[
                          Icon(
                            Icons.check,
                            color: color,
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                        ],
                        Text(
                          timeframe,
                          style: GoogleFonts.inter(
                            color: isSelected ? color : Colors.white,
                            fontSize: 14.sp,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) {
      return Center(
        child: Text(
          'Loading chart data...',
          style: GoogleFonts.inter(color: Colors.grey[400]),
        ),
      );
    }

    // Calculate space needed for bottom indicators
    final bottomIndicatorSpace = _calculateBottomIndicatorSpace();
    
    // Calculate bottom margin including controls and bottom indicators
    final bottomControlsHeight = 80.h; // Height of bottom controls area
    final totalBottomMargin = bottomControlsHeight + bottomIndicatorSpace + MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTapDown: (details) {
        // First check if we're tapping on an existing drawing
        if (_selectedDrawingTool == DrawingTool.none) {
          final tappedDrawing = _findDrawingAtPoint(details.localPosition, priceHistory);
          if (tappedDrawing != null) {
            setState(() {
              _selectedDrawing = tappedDrawing;
              _selectedDrawingIndex = _drawings.indexOf(tappedDrawing);
            });
            return;
          }
        }
        
        // Show crosshair if not drawing or dragging
        setState(() {
          _showCrosshair = true;
          _crosshairPosition = details.localPosition;
        });
      },
      onTapUp: (details) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _showCrosshair = false;
              _crosshairPosition = null;
            });
          }
        });
      },
      onScaleStart: (details) {
        // Check if we're starting to drag a selected drawing
        if (_selectedDrawing != null && _selectedDrawingTool == DrawingTool.none) {
          final isNearDrawing = _isPointNearDrawing(details.focalPoint, _selectedDrawing!, priceHistory);
          if (isNearDrawing) {
            setState(() {
              _isDraggingDrawing = true;
              _dragStartPoint = details.focalPoint;
            });
            return;
          }
        }
        
        // Check if we're starting to draw
        if (_selectedDrawingTool != DrawingTool.none) {
          _startDrawing(details.focalPoint, priceHistory);
          return;
        }
        
        // Default pan/zoom behavior
        _baseScale = _currentScale;
        _lastPanX = details.focalPoint.dx;
        setState(() {
          _isDragging = false;
          _isScaling = false;
        });
      },
      onScaleUpdate: (details) {
        // Handle dragging of selected drawing
        if (_isDraggingDrawing && _selectedDrawing != null && _dragStartPoint != null) {
          _updateDrawingPosition(details.focalPoint, priceHistory);
          return;
        }
        
        // Handle drawing update
        if (_selectedDrawingTool != DrawingTool.none && _isDrawing) {
          _updateDrawing(details.focalPoint, priceHistory);
          return;
        }

        // Default pan/zoom behavior
        setState(() {
          if ((details.scale - 1.0).abs() > 0.01) {
            _isScaling = true;
            _isDragging = false;
            
            final newScale = (_baseScale * details.scale).clamp(0.5, 5.0);
            final newVisiblePoints = (50 / newScale).round().clamp(10, priceHistory.length);
            final centerIndex = _startIndex + (_visibleDataPoints / 2).round();
            
            _currentScale = newScale;
            _visibleDataPoints = newVisiblePoints;
            _startIndex = (centerIndex - (_visibleDataPoints / 2).round())
                .clamp(0, priceHistory.length - _visibleDataPoints);
          } else if (!_isScaling) {
            _isDragging = true;
            
            final deltaX = details.focalPoint.dx - _lastPanX;
            final panSensitivity = _visibleDataPoints / 300;
            final indexChange = (-deltaX * panSensitivity).round();
            
            _startIndex = (_startIndex + indexChange).clamp(0, priceHistory.length - _visibleDataPoints);
            _lastPanX = details.focalPoint.dx;
          }
        });
      },
      onScaleEnd: (details) {
        // End dragging of drawing
        if (_isDraggingDrawing) {
          setState(() {
            _isDraggingDrawing = false;
            _dragStartPoint = null;
          });
          HapticFeedback.lightImpact();
          return;
        }
        
        // End drawing
        if (_selectedDrawingTool != DrawingTool.none && _isDrawing) {
          _endDrawing();
          return;
        }

        setState(() {
          _isDragging = false;
          _isScaling = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Stack(
          children: [
            // Main chart area (adjusts based on bottom indicators)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: totalBottomMargin,
              child: _buildMainChartArea(_getVisibleData(priceHistory)),
            ),
            
            // Bottom indicators area
            if (bottomIndicatorSpace > 0)
              Positioned(
                bottom: bottomControlsHeight + MediaQuery.of(context).padding.bottom,
                left: 0,
                right: 0,
                height: bottomIndicatorSpace,
                child: _buildBottomIndicatorsArea(_getVisibleData(priceHistory)),
              ),
            
            // Drawings overlay (covers entire chart area including indicators)
            _buildDrawingsOverlay(priceHistory),
            
            // Crosshair (covers entire chart area)
            if (_showCrosshair && _crosshairPosition != null)
              _buildCrosshair(_crosshairPosition!, _getVisibleData(priceHistory)),
            
            // Interaction indicators
            _buildInteractionIndicators(),
          ],
        ),
      ),
    );
  }

  // Calculate space needed for bottom indicators
  double _calculateBottomIndicatorSpace() {
    double totalSpace = 0;
    
    for (final indicator in _selectedIndicators) {
      switch (indicator) {
        case 'RSI':
          totalSpace += 120.h; // RSI panel height
          break;
        case 'MACD':
          totalSpace += 120.h; // MACD panel height
          break;
        case 'Stochastic':
          totalSpace += 100.h; // Stochastic panel height
          break;
        case 'ATR':
          totalSpace += 80.h; // ATR panel height
          break;
        case 'Volume':
          if (_selectedChartType != ChartType.volume) {
            totalSpace += 100.h; // Volume panel height
          }
          break;
      }
    }
    
    return totalSpace;
  }

  // Main chart area with price overlay indicators
  Widget _buildMainChartArea(List<StockPrice> priceHistory) {
    return Stack(
      children: [
        // Main price chart
        Positioned.fill(
          child: _buildSelectedChart(priceHistory),
        ),
        
        // Price overlay indicators (MA, EMA, Bollinger Bands, VWAP, SAR)
        _buildPriceOverlayIndicators(priceHistory),
      ],
    );
  }

  // Price overlay indicators that appear on the main chart
  Widget _buildPriceOverlayIndicators(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();

    // Filter for indicators that appear on the main chart
    final priceOverlayIndicators = _selectedIndicators.where((indicator) {
      return [
        'Moving Average',
        'EMA', 
        'Bollinger Bands',
        'VWAP',
        'Parabolic SAR'
      ].contains(indicator);
    }).toList();

    if (priceOverlayIndicators.isEmpty) return Container();

    try {
      final prices = priceHistory.where((p) => p.high > 0 && p.low > 0).toList();
      if (prices.isEmpty) return Container();
      
      final maxPrice = prices.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = prices.map((e) => e.low).reduce((a, b) => a < b ? a : b);
      
      if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) {
        return Container();
      }

      return Positioned.fill(
        child: CustomPaint(
          painter: PriceOverlayIndicatorsPainter(
            priceHistory: prices,
            selectedIndicators: priceOverlayIndicators,
            maxPrice: maxPrice,
            minPrice: minPrice,
          ),
        ),
      );
    } catch (e) {
      print('Error in price overlay indicators: $e');
      return Container();
    }
  }

  // Bottom indicators area for oscillators
  Widget _buildBottomIndicatorsArea(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();

    // Filter for indicators that appear at the bottom
    final bottomIndicators = _selectedIndicators.where((indicator) {
      return [
        'RSI',
        'MACD', 
        'Stochastic',
        'ATR',
        'Volume'
      ].contains(indicator) && !(indicator == 'Volume' && _selectedChartType == ChartType.volume);
    }).toList();

    if (bottomIndicators.isEmpty) return Container();

    try {
      final prices = priceHistory.where((p) => p.high > 0 && p.low > 0).toList();
      if (prices.isEmpty) return Container();

      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
          ),
        ),
        child: CustomPaint(
          painter: BottomIndicatorsPainter(
            priceHistory: prices,
            selectedIndicators: bottomIndicators,
          ),
        ),
      );
    } catch (e) {
      print('Error in bottom indicators: $e');
      return Container();
    }
  }

  // ... existing methods continue unchanged until _buildIndicatorsOverlayWithMargin which we can remove ...

  // Remove the old _buildIndicatorsOverlayWithMargin method since we're replacing it

  // ... rest of existing methods stay the same ...

  List<StockPrice> _generateMockPriceHistory() {
    return _generateRealisticPriceHistory();
  }

  double _calculateOptimalCandleWidth(int dataLength) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 40; // Account for margins
    
    // Calculate optimal width based on data density and zoom level
    final baseWidth = availableWidth / dataLength;
    final scaledWidth = baseWidth * 0.7; // 70% of available space per candle
    
    // Apply zoom scaling
    final zoomedWidth = scaledWidth * _currentScale;
    
    // Clamp to reasonable limits
    return zoomedWidth.clamp(2.0, 20.0);
  }

  List<StockPrice> _generateRealisticPriceHistory() {
    final now = DateTime.now();
    final prices = <StockPrice>[];
    double basePrice = widget.stock.currentPrice;
    
    // Get interval and data points based on timeframe
    int dataPoints;
    Duration interval;
    
    switch (_selectedTimeframe) {
      case '1m':
        dataPoints = 60;
        interval = Duration(minutes: 1);
        break;
      case '5m':
        dataPoints = 144;
        interval = Duration(minutes: 5);
        break;
      case '15m':
        dataPoints = 96;
        interval = Duration(minutes: 15);
        break;
      case '30m':
        dataPoints = 48;
        interval = Duration(minutes: 30);
        break;
      case '1H':
        dataPoints = 168;
        interval = Duration(hours: 1);
        break;
      case '4H':
        dataPoints = 42;
        interval = Duration(hours: 4);
        break;
      case '1D':
        dataPoints = 90;
        interval = Duration(days: 1);
        break;
      case '1W':
        dataPoints = 52;
        interval = Duration(days: 7);
        break;
      case '1M':
        dataPoints = 24;
        interval = Duration(days: 30);
        break;
      default:
        dataPoints = 60;
        interval = Duration(days: 1);
    }

    // Generate more realistic OHLC data with smaller price movements
    double currentPrice = basePrice;
    
    for (int i = dataPoints; i >= 0; i--) {
      final date = now.subtract(interval * i);
      
      // Create smaller, more realistic price movements
      final volatilityFactor = _getVolatilityForTimeframe(_selectedTimeframe);
      final trendFactor = math.sin(i * 0.02) * 0.001; // Smaller trend
      
      // Smaller random walk
      final randomChange = (math.Random().nextDouble() - 0.5) * volatilityFactor * 0.5;
      final meanReversion = (basePrice - currentPrice) * 0.0005;
      
      currentPrice *= (1 + randomChange + trendFactor + meanReversion);
      
      // Generate realistic OHLC with smaller intrabar movements
      final open = i == dataPoints ? basePrice : prices.isEmpty ? currentPrice : prices.last.close;
      
      // Reduced intrabar volatility for more realistic candlesticks
      final intrabarVolatility = volatilityFactor * 0.3; // Reduced from 0.5
      final highVariation = math.Random().nextDouble() * intrabarVolatility * 0.5;
      final lowVariation = math.Random().nextDouble() * intrabarVolatility * 0.5;
      
      final high = [open, currentPrice].reduce(math.max) * (1 + highVariation);
      final low = [open, currentPrice].reduce(math.min) * (1 - lowVariation);
      final close = currentPrice;
      
      // Ensure OHLC relationships
      final validHigh = math.max(math.max(open, close), high);
      final validLow = math.min(math.min(open, close), low);
      
      final volume = _generateRealisticVolume(i, dataPoints);
      
      prices.add(StockPrice(
        timestamp: date,
        open: open,
        high: validHigh,
        low: validLow,
        close: close,
        volume: volume,
      ));
    }
    
    return prices;
  }

  double _getVolatilityForTimeframe(String timeframe) {
    // Reduced volatility for more realistic movements
    switch (timeframe) {
      case '1m':
        return 0.002; // 0.2%
      case '5m':
        return 0.004; // 0.4%
      case '15m':
        return 0.006; // 0.6%
      case '30m':
        return 0.008; // 0.8%
      case '1H':
        return 0.012; // 1.2%
      case '4H':
        return 0.018; // 1.8%
      case '1D':
        return 0.025; // 2.5%
      case '1W':
        return 0.050; // 5%
      case '1M':
        return 0.080; // 8%
      default:
        return 0.012;
    }
  }

  double _generateRealisticVolume(int index, int totalPoints) {
    final baseVolume = widget.stock.volume;
    
    // Create volume patterns
    final timeOfDay = (index % 24) / 24.0; // Simulate time of day effect
    final marketHours = (timeOfDay > 0.375 && timeOfDay < 0.875) ? 1.0 : 0.3; // Market hours multiplier
    
    final randomFactor = 0.5 + (math.Random().nextDouble() * 1.5); // 0.5x to 2x
    final cyclicalFactor = 1 + (math.sin(index * 0.2) * 0.3); // Cyclical pattern
    
    return baseVolume * marketHours * randomFactor * cyclicalFactor;
  }

  // Keep all existing methods but add these helper methods
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

  String _getChartTypeName(ChartType type) {
    switch (type) {
      case ChartType.line:
        return 'Line';
      case ChartType.candlestick:
        return 'Candles';
      case ChartType.area:
        return 'Area';
      case ChartType.ohlc:
        return 'Bars';
      case ChartType.volume:
        return 'Volume';
      case ChartType.heikinAshi:
        return 'Heikin-Ashi';
      case ChartType.hollowCandles:
        return 'Hollow';
    }
  }

  String _getDrawingToolName(DrawingTool tool) {
    switch (tool) {
      case DrawingTool.none:
        return 'None';
      case DrawingTool.measure:
        return 'Measure';
      case DrawingTool.trendline:
        return 'Trendline';
      case DrawingTool.horizontalLine:
        return 'H-Line';
      case DrawingTool.verticalLine:
        return 'V-Line';
      case DrawingTool.fibonacciRetracement:
        return 'Fibonacci';
      case DrawingTool.elliottWave:
        return 'Elliott Wave';
    }
  }

  IconData _getDrawingToolIcon(DrawingTool tool) {
    switch (tool) {
      case DrawingTool.none:
        return Icons.disabled_by_default;
      case DrawingTool.measure:
        return Icons.straighten;
      case DrawingTool.trendline:
        return Icons.trending_up;
      case DrawingTool.horizontalLine:
        return Icons.horizontal_rule;
      case DrawingTool.verticalLine:
        return Icons.more_vert;
      case DrawingTool.fibonacciRetracement:
        return Icons.timeline;
      case DrawingTool.elliottWave:
        return Icons.waves;
    }
  }

  // Drawing methods - replace existing stub methods
  void _startDrawing(Offset point, List<StockPrice> priceHistory) {
    if (_selectedDrawingTool == DrawingTool.none || priceHistory.isEmpty) return;

    setState(() {
      _isDrawing = true;
      _drawingStartPoint = point;
      
      // Convert screen coordinates to price/time coordinates
      final priceValue = _screenToPrice(point, priceHistory);
      final timeIndex = _screenToTimeIndex(point, priceHistory);
      final color = _getDrawingToolColor(_selectedDrawingTool);
      
      // Create specific drawing element based on the selected tool
      switch (_selectedDrawingTool) {
        case DrawingTool.trendline:
          _currentDrawing = TrendlineElement(
            startPoint: point,
            endPoint: point, // Will be updated in _updateDrawing
            startValue: priceValue,
            endValue: priceValue, // Will be updated in _updateDrawing
            startIndex: timeIndex,
            endIndex: timeIndex, // Will be updated in _updateDrawing
            color: color,
          );
          break;
        case DrawingTool.horizontalLine:
          _currentDrawing = HorizontalLineElement(
            value: priceValue,
            yPosition: point.dy,
            color: color,
          );
          break;
        case DrawingTool.verticalLine:
          final timestamp = timeIndex < priceHistory.length 
              ? priceHistory[timeIndex].timestamp 
              : DateTime.now();
          _currentDrawing = VerticalLineElement(
            index: timeIndex,
            xPosition: point.dx,
            timestamp: timestamp,
            color: color,
          );
          break;
        case DrawingTool.measure:
          _currentDrawing = MeasureElement(
            startPoint: point,
            endPoint: point, // Will be updated in _updateDrawing
            startValue: priceValue,
            endValue: priceValue, // Will be updated in _updateDrawing
            startIndex: timeIndex,
            endIndex: timeIndex, // Will be updated in _updateDrawing
            color: color,
          );
          break;
        case DrawingTool.fibonacciRetracement:
          // For now, treat as trendline - you can implement specific Fibonacci logic later
          _currentDrawing = TrendlineElement(
            startPoint: point,
            endPoint: point,
            startValue: priceValue,
            endValue: priceValue,
            startIndex: timeIndex,
            endIndex: timeIndex,
            color: color,
          );
          break;
        case DrawingTool.elliottWave:
          // For now, treat as trendline - you can implement specific Elliott Wave logic later
          _currentDrawing = TrendlineElement(
            startPoint: point,
            endPoint: point,
            startValue: priceValue,
            endValue: priceValue,
            startIndex: timeIndex,
            endIndex: timeIndex,
            color: color,
          );
          break;
        case DrawingTool.none:
          _currentDrawing = null;
          break;
      }
    });
    
    // Provide haptic feedback
    HapticFeedback.selectionClick();
  }

  void _updateDrawing(Offset point, List<StockPrice> priceHistory) {
    if (!_isDrawing || _currentDrawing == null || priceHistory.isEmpty) return;

    setState(() {
      final priceValue = _screenToPrice(point, priceHistory);
      final timeIndex = _screenToTimeIndex(point, priceHistory);
      
      // Update the drawing based on its type
      switch (_selectedDrawingTool) {
        case DrawingTool.trendline:
        case DrawingTool.fibonacciRetracement:
        case DrawingTool.elliottWave:
          if (_currentDrawing is TrendlineElement) {
            final current = _currentDrawing as TrendlineElement;
            _currentDrawing = TrendlineElement(
              startPoint: current.startPoint,
              endPoint: point,
              startValue: current.startValue,
              endValue: priceValue,
              startIndex: current.startIndex,
              endIndex: timeIndex,
              color: current.color,
            );
          }
          break;
        case DrawingTool.measure:
          if (_currentDrawing is MeasureElement) {
            final current = _currentDrawing as MeasureElement;
            _currentDrawing = MeasureElement(
              startPoint: current.startPoint,
              endPoint: point,
              startValue: current.startValue,
              endValue: priceValue,
              startIndex: current.startIndex,
              endIndex: timeIndex,
              color: current.color,
            );
          }
          break;
        case DrawingTool.horizontalLine:
          if (_currentDrawing is HorizontalLineElement) {
            final current = _currentDrawing as HorizontalLineElement;
            _currentDrawing = HorizontalLineElement(
              value: priceValue,
              yPosition: point.dy,
              color: current.color,
            );
          }
          break;
        case DrawingTool.verticalLine:
          if (_currentDrawing is VerticalLineElement) {
            final current = _currentDrawing as VerticalLineElement;
            final timestamp = timeIndex < priceHistory.length 
                ? priceHistory[timeIndex].timestamp 
                : DateTime.now();
            _currentDrawing = VerticalLineElement(
              index: timeIndex,
              xPosition: point.dx,
              timestamp: timestamp,
              color: current.color,
            );
          }
          break;
        case DrawingTool.none:
          break;
      }
    });
  }

  void _endDrawing() {
    if (!_isDrawing || _currentDrawing == null) return;

    setState(() {
      _drawings.add(_currentDrawing!);
      _currentDrawing = null;
      _isDrawing = false;
      _drawingStartPoint = null;
      
      // Auto-deselect tool after drawing (except for measure tool)
      if (_selectedDrawingTool != DrawingTool.measure) {
        _selectedDrawingTool = DrawingTool.none;
      }
    });
    
    // Provide haptic feedback
    HapticFeedback.heavyImpact();
  }

  // Helper methods for coordinate conversion
  double _screenToPrice(Offset point, List<StockPrice> priceHistory) {
    try {
      final prices = priceHistory.where((p) => p.high > 0 && p.low > 0).toList();
      if (prices.isEmpty) return 0;
      
      final maxPrice = prices.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = prices.map((e) => e.low).reduce((a, b) => a < b ? a : b);
      
      // Get the main chart area height (excluding bottom indicators)
      final chartHeight = MediaQuery.of(context).size.height * 0.9 - 
                         _calculateBottomIndicatorSpace() - 
                         80.h - // Bottom controls
                         MediaQuery.of(context).padding.bottom;
      
      final normalizedY = point.dy / chartHeight;
      return maxPrice - (normalizedY * (maxPrice - minPrice));
    } catch (e) {
      print('Error converting screen to price: $e');
      return 0;
    }
  }

  int _screenToTimeIndex(Offset point, List<StockPrice> priceHistory) {
    try {
      final screenWidth = MediaQuery.of(context).size.width;
      final normalizedX = (point.dx / screenWidth).clamp(0.0, 1.0);
      final index = (normalizedX * (priceHistory.length - 1)).round();
      return index.clamp(0, priceHistory.length - 1);
    } catch (e) {
      print('Error converting screen to time index: $e');
      return 0;
    }
  }

  Color _getDrawingToolColor(DrawingTool tool) {
    switch (tool) {
      case DrawingTool.trendline:
        return Colors.yellow;
      case DrawingTool.horizontalLine:
        return Colors.red;
      case DrawingTool.verticalLine:
        return Colors.blue;
      case DrawingTool.measure:
        return Colors.green;
      case DrawingTool.fibonacciRetracement:
        return Colors.purple;
      case DrawingTool.elliottWave:
        return Colors.orange;
      case DrawingTool.none:
        return Colors.white;
    }
  }

  Widget _buildDrawingsOverlay(List<StockPrice> priceHistory) {
    if (_drawings.isEmpty && _currentDrawing == null) return Container();

    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: DrawingsPainter(
        drawings: _drawings,
        currentDrawing: _currentDrawing,
        selectedDrawing: _selectedDrawing, // Pass selected drawing to painter
        priceHistory: _getVisibleData(priceHistory),
      ),
    );
  }

  Widget _buildInteractionIndicators() {
    return Stack(
      children: [
        if (_isDragging)
          Positioned(
            top: 50.h,
            right: 16.w,
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
        
        if (_isScaling)
          Positioned(
            top: 50.h,
            left: 16.w,
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
        
        // Add indicator for dragging drawings
        if (_isDraggingDrawing)
          Positioned(
            top: 50.h,
            left: 50.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.open_with, color: Colors.white, size: 12.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Moving Drawing',
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
        
        // Add selection indicator
        if (_selectedDrawing != null && !_isDraggingDrawing)
          Positioned(
            top: 100.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.touch_app, color: Colors.white, size: 12.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Drawing Selected',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDrawing = null;
                        _selectedDrawingIndex = null;
                      });
                    },
                    child: Icon(Icons.close, color: Colors.white, size: 12.sp),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // Chart building methods
  Widget _buildSelectedChart(List<StockPrice> visibleData) {
    switch (_selectedChartType) {
      case ChartType.line:
        return _buildLineChart(visibleData);
      case ChartType.candlestick:
        return _buildProfessionalCandlestickChart(visibleData);
      case ChartType.area:
        return _buildAreaChart(visibleData);
      case ChartType.ohlc:
        return _buildOHLCChart(visibleData);
      case ChartType.volume:
        return _buildFullVolumeChart(visibleData);
      case ChartType.heikinAshi:
        return _buildHeikinAshiChart(visibleData);
      case ChartType.hollowCandles:
        return _buildHollowCandlesChart(visibleData);
    }
  }

  Widget _buildProfessionalCandlestickChart(List<StockPrice> priceHistory) {
    try {
      if (priceHistory.isEmpty) return _buildEmptyChart();
      
      // Filter out invalid price data
      final validPrices = priceHistory.where((p) => 
        p.high > 0 && p.low > 0 && p.open > 0 && p.close > 0 &&
        p.high >= p.low && p.high >= p.open && p.high >= p.close &&
        p.low <= p.open && p.low <= p.close
      ).toList();
      
      if (validPrices.isEmpty) return _buildEmptyChart();
      
      final maxPrice = validPrices.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = validPrices.map((e) => e.low).reduce((a, b) => a < b ? a : b);
      
      if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) {
        return _buildEmptyChart();
      }
      
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: ProfessionalCandlestickPainter(
            priceHistory: validPrices,
            maxPrice: maxPrice,
            minPrice: minPrice,
            candleWidth: _calculateOptimalCandleWidth(validPrices.length),
            showGrid: true,
            gridColor: Colors.grey.withOpacity(0.1),
            bullishColor: const Color(0xFF26C281),
            bearishColor: const Color(0xFFEF5350),
          ),
        ),
      );
    } catch (e) {
      print('Error in candlestick chart: $e');
      return _buildEmptyChart();
    }
  }

  Widget _buildEmptyChart() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.grey[600],
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'No chart data available',
              style: GoogleFonts.inter(
                color: Colors.grey[600],
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please try a different timeframe',
              style: GoogleFonts.inter(
                color: Colors.grey[700],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(List<StockPrice> priceHistory) {
    try {
      if (priceHistory.isEmpty) return _buildEmptyChart();
      
      final validPrices = priceHistory.where((p) => p.close > 0).toList();
      if (validPrices.isEmpty) return _buildEmptyChart();
      
      final spots = validPrices.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value.close);
      }).toList();

      final maxPrice = validPrices.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = validPrices.map((e) => e.low).reduce((a, b) => a < b ? a : b);

      if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) {
        return _buildEmptyChart();
      }

      return LineChart(
        LineChartData(
          minY: minPrice * 0.98,
          maxY: maxPrice * 1.02,
          minX: 0,
          maxX: validPrices.length.toDouble() - 1,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: (maxPrice - minPrice) / 8,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.1),
                strokeWidth: 0.5,
              );
            },
          ),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: widget.stock.isPositive ? const Color(0xFF26C281) : const Color(0xFFEF5350),
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error in line chart: $e');
      return _buildEmptyChart();
    }
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
        minY: minPrice * 0.98,
        maxY: maxPrice * 1.02,
        minX: 0,
        maxX: priceHistory.length.toDouble() - 1,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: widget.stock.isPositive ? const Color(0xFF26C281) : const Color(0xFFEF5350),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  (widget.stock.isPositive ? const Color(0xFF26C281) : const Color(0xFFEF5350)).withValues(alpha: 0.3),
                  (widget.stock.isPositive ? const Color(0xFF26C281) : const Color(0xFFEF5350)).withValues(alpha: 0.0),
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

  Widget _buildOHLCChart(List<StockPrice> priceHistory) {
    return _buildProfessionalCandlestickChart(priceHistory);
  }

  Widget _buildHeikinAshiChart(List<StockPrice> priceHistory) {
    return _buildProfessionalCandlestickChart(priceHistory);
  }

  Widget _buildHollowCandlesChart(List<StockPrice> priceHistory) {
    return _buildProfessionalCandlestickChart(priceHistory);
  }

  Widget _buildFullVolumeChart(List<StockPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final volumeBars = priceHistory.asMap().entries.map((entry) {
      final isUp = entry.value.close >= entry.value.open;
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.volume,
            color: isUp 
                ? const Color(0xFF26C281).withValues(alpha: 0.7)
                : const Color(0xFFEF5350).withValues(alpha: 0.7),
            width: _calculateOptimalCandleWidth(priceHistory.length) * 0.8,
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: priceHistory.map((e) => e.volume).reduce((a, b) => a > b ? a : b) * 1.1,
        barGroups: volumeBars,
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }

  Widget _buildVolumeChart(List<StockPrice> priceHistory) {
    return _buildFullVolumeChart(priceHistory);
  }

  Widget _buildCrosshair(Offset position, List<StockPrice> priceHistory) {
    try {
      if (priceHistory.isEmpty) return Container();
      
      final prices = priceHistory.where((p) => p.high > 0 && p.low > 0).toList();
      if (prices.isEmpty) return Container();
      
      final maxPrice = prices.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = prices.map((e) => e.low).reduce((a, b) => a < b ? a : b);
      
      if (maxPrice <= 0 || minPrice <= 0 || maxPrice == minPrice) {
        return Container();
      }
      
      return CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: CrosshairPainter(
          position: position,
          priceHistory: prices,
          maxPrice: maxPrice,
          minPrice: minPrice,
        ),
      );
    } catch (e) {
      print('Error in crosshair: $e');
      return Container();
    }
  }

  // Add placeholder bottom sheet methods
  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'More Options',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  ListTile(
                    leading: Icon(Icons.refresh, color: Colors.white),
                    title: Text('Reset View', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      _resetZoom();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
              ),
              child: Row(
                children: [
                  Text(
                    'Stock Information',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Stock info content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic info
                    Row(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              widget.stock.symbol.length >= 2 
                                  ? widget.stock.symbol.substring(0, 2)
                                  : widget.stock.symbol,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.stock.symbol,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.stock.name,
                                style: GoogleFonts.inter(
                                  color: Colors.grey[300],
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'NASDAQ',
                                style: GoogleFonts.inter(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Price info
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Price',
                            style: GoogleFonts.inter(
                              color: Colors.grey[400],
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                '\$${widget.stock.currentPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: (widget.stock.isPositive ? Colors.green : Colors.red).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  '${widget.stock.isPositive ? '+' : ''}${widget.stock.changePercent.toStringAsFixed(2)}%',
                                  style: GoogleFonts.inter(
                                    color: widget.stock.isPositive ? Colors.green : Colors.red,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Key metrics
                    Text(
                      'Key Metrics',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          _buildMetricRow('Market Cap', '\$${(widget.stock.marketCap / 1e9).toStringAsFixed(1)}B'),
                          _buildMetricRow('P/E Ratio', widget.stock.peRatio.toStringAsFixed(2)),
                          _buildMetricRow('Beta', widget.stock.beta.toStringAsFixed(2)),
                          _buildMetricRow('Volume', '${(widget.stock.volume / 1e6).toStringAsFixed(1)}M'),
                          _buildMetricRow('52W High', '\$${(widget.stock.currentPrice * 1.25).toStringAsFixed(2)}'),
                          _buildMetricRow('52W Low', '\$${(widget.stock.currentPrice * 0.75).toStringAsFixed(2)}'),
                          _buildMetricRow('Avg Volume', '${(widget.stock.volume * 0.85 / 1e6).toStringAsFixed(1)}M'),
                          _buildMetricRow('Market Value', '\$${(widget.stock.marketCap / 1e6).toStringAsFixed(0)}M'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showChartTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Chart Type',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                children: ChartType.values.map((type) => ListTile(
                  title: Text(_getChartTypeName(type), style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.timeline, color: Colors.white),
                  selected: _selectedChartType == type,
                  onTap: () {
                    setState(() {
                      _selectedChartType = type;
                    });
                    Navigator.pop(context);
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIndicatorsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add_chart, color: Colors.blue, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Technical Indicators',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    // Clear all button
                    if (_selectedIndicators.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndicators.clear();
                          });
                          setModalState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.inter(
                              color: Colors.red,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Active indicators section
              if (_selectedIndicators.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Indicators (${_selectedIndicators.length})',
                        style: GoogleFonts.inter(
                          color: Colors.blue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _selectedIndicators.map((indicator) => 
                          _buildActiveIndicatorChip(indicator, setModalState)
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              
              // Indicators categories
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      _buildIndicatorCategory(
                        'Trend Indicators',
                        Icons.trending_up,
                        Colors.green,
                        _trendIndicators,
                        setModalState,
                      ),
                      SizedBox(height: 16.h),
                      _buildIndicatorCategory(
                        'Momentum Indicators',
                        Icons.speed,
                        Colors.purple,
                        _momentumIndicators,
                        setModalState,
                      ),
                      SizedBox(height: 16.h),
                      _buildIndicatorCategory(
                        'Volume Indicators',
                        Icons.bar_chart,
                        Colors.orange,
                        _volumeIndicators,
                        setModalState,
                      ),
                      SizedBox(height: 16.h),
                      _buildIndicatorCategory(
                        'Volatility Indicators',
                        Icons.waves,
                        Colors.red,
                        _volatilityIndicators,
                        setModalState,
                      ),
                      SizedBox(height: 16.h),
                      _buildIndicatorCategory(
                        'Support & Resistance',
                        Icons.horizontal_rule,
                        Colors.blue,
                        _supportResistanceIndicators,
                        setModalState,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveIndicatorChip(String indicator, StateSetter setModalState) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            indicator,
            style: GoogleFonts.inter(
              color: Colors.blue,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndicators.remove(indicator);
              });
              setModalState(() {});
            },
            child: Icon(
              Icons.close,
              color: Colors.blue,
              size: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorCategory(
    String title,
    IconData icon,
    Color color,
    List<IndicatorInfo> indicators,
    StateSetter setModalState,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: color,
        collapsedIconColor: color,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${indicators.where((i) => _selectedIndicators.contains(i.name)).length}/${indicators.length}',
                style: GoogleFonts.inter(
                  color: color,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4, // Decreased from 2.0 to 1.4 for more height
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
            ),
            itemCount: indicators.length,
            itemBuilder: (context, index) {
              final indicator = indicators[index];
              return _buildIndicatorTile(indicator, color, setModalState);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorTile(IndicatorInfo indicator, Color categoryColor, StateSetter setModalState) {
    final isSelected = _selectedIndicators.contains(indicator.name);
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            // Haptic feedback
            HapticFeedback.lightImpact();
            
            setState(() {
              if (isSelected) {
                _selectedIndicators.remove(indicator.name);
              } else {
                _selectedIndicators.add(indicator.name);
              }
            });
            setModalState(() {});
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(14.w), // Increased padding from 12.w to 14.w
            decoration: BoxDecoration(
              color: isSelected 
                ? categoryColor.withValues(alpha: 0.2)
                : Colors.grey[700],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected 
                  ? categoryColor 
                  : Colors.grey[600]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header row with title and circular button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        indicator.name,
                        style: GoogleFonts.inter(
                          color: isSelected ? categoryColor : Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2, // Increased from 1 to 2 lines
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Circular gradient button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          if (isSelected) {
                            _selectedIndicators.remove(indicator.name);
                          } else {
                            _selectedIndicators.add(indicator.name);
                          }
                        });
                        setModalState(() {});
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          gradient: isSelected 
                            ? LinearGradient(
                                colors: [
                                  categoryColor,
                                  categoryColor.withValues(alpha: 0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey[600]!,
                                  Colors.grey[700]!,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                          shape: BoxShape.circle,
                          boxShadow: isSelected 
                            ? [
                                BoxShadow(
                                  color: categoryColor.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                        ),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          child: Icon(
                            isSelected ? Icons.check : Icons.add,
                            key: ValueKey(isSelected ? 'check' : 'add'),
                            color: Colors.white,
                            size: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 8.h), // Increased spacing from 6.h to 8.h
                
                // Description
                Expanded(
                  child: Text(
                    indicator.description,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp, // Increased from 9.sp to 10.sp for better readability
                      height: 1.4, // Increased line height for better spacing
                    ),
                    maxLines: 3, // Increased from 2 to 3 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                // Parameters at bottom
                if (indicator.parameters.isNotEmpty) ...[
                  SizedBox(height: 6.h), // Increased spacing
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h), // Increased padding
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? categoryColor.withValues(alpha: 0.2)
                        : Colors.grey[600]!.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: isSelected 
                          ? categoryColor.withValues(alpha: 0.4)
                          : Colors.grey[500]!.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      indicator.parameters,
                      style: GoogleFonts.inter(
                        color: isSelected ? categoryColor : Colors.grey[500],
                        fontSize: 9.sp, // Increased from 8.sp to 9.sp
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDrawingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.orange, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Drawing Tools',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    // Clear all drawings button
                    if (_drawings.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _drawings.clear();
                            _currentDrawing = null;
                          });
                          setModalState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.inter(
                              color: Colors.red,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Current tool indicator
              if (_selectedDrawingTool != DrawingTool.none)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getDrawingToolIcon(_selectedDrawingTool),
                        color: Colors.orange,
                        size: 20.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Active: ${_getDrawingToolName(_selectedDrawingTool)}',
                        style: GoogleFonts.inter(
                          color: Colors.orange,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDrawingTool = DrawingTool.none;
                          });
                          setModalState(() {});
                        },
                        child: Text(
                          'Deactivate',
                          style: GoogleFonts.inter(
                            color: Colors.orange,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Drawing tools categories
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      _buildDrawingCategory(
                        'Lines & Shapes',
                        Icons.timeline,
                        Colors.blue,
                        [
                          DrawingToolInfo(DrawingTool.trendline, 'Trend Line', 'Draw trend lines'),
                          DrawingToolInfo(DrawingTool.horizontalLine, 'Horizontal Line', 'Draw horizontal support/resistance'),
                          DrawingToolInfo(DrawingTool.verticalLine, 'Vertical Line', 'Draw vertical time lines'),
                          DrawingToolInfo(DrawingTool.measure, 'Measure Tool', 'Measure distance and price'),
                        ],
                        setModalState,
                      ),
                      SizedBox(height: 16.h),
                      _buildDrawingCategory(
                        'Advanced Tools',
                        Icons.architecture,
                        Colors.purple,
                        [
                          DrawingToolInfo(DrawingTool.fibonacciRetracement, 'Fibonacci', 'Fibonacci retracement levels'),
                          DrawingToolInfo(DrawingTool.elliottWave, 'Elliott Wave', 'Elliott wave patterns'),
                        ],
                        setModalState,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawingCategory(
    String title,
    IconData icon,
    Color color,
    List<DrawingToolInfo> tools,
    StateSetter setModalState,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: color,
        collapsedIconColor: color,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tools.length,
            itemBuilder: (context, index) {
              final tool = tools[index];
              return _buildDrawingToolTile(tool, color, setModalState);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawingToolTile(DrawingToolInfo tool, Color categoryColor, StateSetter setModalState) {
    final isSelected = _selectedDrawingTool == tool.tool;
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() {
              _selectedDrawingTool = isSelected ? DrawingTool.none : tool.tool;
            });
            setModalState(() {});
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected 
                ? categoryColor.withValues(alpha: 0.2)
                : Colors.grey[700]!.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected 
                  ? categoryColor 
                  : Colors.grey[600]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? categoryColor.withValues(alpha: 0.3)
                      : Colors.grey[600]!.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    _getDrawingToolIcon(tool.tool),
                    color: isSelected ? categoryColor : Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tool.name,
                        style: GoogleFonts.inter(
                          color: isSelected ? categoryColor : Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        tool.description,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: categoryColor,
                    size: 20.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAssetComparison() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Compare Assets',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Asset comparison feature coming soon',
                  style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAnalysisBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
              ),
              child: Row(
                children: [
                  Text(
                    'Technical Analysis',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Analysis content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overall recommendation
                    _buildOverallRecommendation(),
                    
                    SizedBox(height: 24.h),
                    
                    // Technical indicators
                    _buildTechnicalIndicatorsSection(),
                    
                    SizedBox(height: 24.h),
                    
                    // Support and resistance
                    _buildSupportResistanceSection(),
                    
                    SizedBox(height: 24.h),
                    
                    // Volume analysis
                    _buildVolumeAnalysisSection(),
                    
                    SizedBox(height: 24.h),
                    
                    // Price action analysis
                    _buildPriceActionSection(),
                    
                    SizedBox(height: 24.h),
                    
                    // Risk assessment
                    _buildRiskAssessmentSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRecommendation() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.green, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                'BULLISH',
                style: GoogleFonts.inter(
                  color: Colors.green,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'BUY',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Technical indicators suggest a bullish outlook with strong momentum. The stock is trading above key moving averages with increasing volume.',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildRecommendationBadge('Short Term', 'BUY', Colors.green),
              SizedBox(width: 8.w),
              _buildRecommendationBadge('Medium Term', 'HOLD', Colors.orange),
              SizedBox(width: 8.w),
              _buildRecommendationBadge('Long Term', 'BUY', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationBadge(String timeframe, String action, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              timeframe,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 10.sp,
              ),
            ),
            Text(
              action,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalIndicatorsSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Indicators',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          
          // RSI
          _buildIndicatorRow('RSI (14)', '67.3', 'Neutral', Colors.orange),
          SizedBox(height: 12.h),
          
          // MACD
          _buildIndicatorRow('MACD (12,26,9)', '0.45', 'Bullish', Colors.green),
          SizedBox(height: 12.h),
          
          // Moving Averages
          _buildIndicatorRow('MA (20)', '${widget.stock.currentPrice * 0.98}', 'Above', Colors.green),
          SizedBox(height: 12.h),
          
          _buildIndicatorRow('MA (50)', '${widget.stock.currentPrice * 0.95}', 'Above', Colors.green),
          SizedBox(height: 12.h),
          
          _buildIndicatorRow('MA (200)', '${widget.stock.currentPrice * 0.88}', 'Above', Colors.green),
          SizedBox(height: 12.h),
          
          // Bollinger Bands
          _buildIndicatorRow('Bollinger Bands', 'Upper Band', 'Near Upper', Colors.orange),
          SizedBox(height: 12.h),
          
          // Stochastic
          _buildIndicatorRow('Stochastic %K', '78.2', 'Overbought', Colors.red),
          SizedBox(height: 12.h),
          
          // Williams %R
          _buildIndicatorRow('Williams %R', '-25.6', 'Bullish', Colors.green),
        ],
      ),
    );
  }

  Widget _buildIndicatorRow(String name, String value, String signal, Color signalColor) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: signalColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              signal,
              style: GoogleFonts.inter(
                color: signalColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportResistanceSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support & Resistance',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          
          // Resistance levels
          Text(
            'Resistance Levels',
            style: GoogleFonts.inter(
              color: Colors.red,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          _buildPriceLevelRow('R3', widget.stock.currentPrice * 1.15, 'Strong'),
          _buildPriceLevelRow('R2', widget.stock.currentPrice * 1.08, 'Moderate'),
          _buildPriceLevelRow('R1', widget.stock.currentPrice * 1.03, 'Weak'),
          
          SizedBox(height: 16.h),
          
          // Current price
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: Colors.blue),
            ),
            child: Row(
              children: [
                Text(
                  'Current Price',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '\$${widget.stock.currentPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Support levels
          Text(
            'Support Levels',
            style: GoogleFonts.inter(
              color: Colors.green,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          _buildPriceLevelRow('S1', widget.stock.currentPrice * 0.97, 'Weak'),
          _buildPriceLevelRow('S2', widget.stock.currentPrice * 0.92, 'Moderate'),
          _buildPriceLevelRow('S3', widget.stock.currentPrice * 0.85, 'Strong'),
        ],
      ),
    );
  }

  Widget _buildPriceLevelRow(String level, double price, String strength) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
            child: Text(
              level,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
          Text(
            strength,
            style: GoogleFonts.inter(
              color: strength == 'Strong' ? Colors.green : 
                     strength == 'Moderate' ? Colors.orange : Colors.grey[400],
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeAnalysisSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Volume Analysis',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          
          Row(
            children: [
              Expanded(
                child: _buildVolumeMetric(
                  'Current Volume',
                  '${(widget.stock.volume / 1000000).toStringAsFixed(1)}M',
                  Colors.blue,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildVolumeMetric(
                  'Avg Volume (20d)',
                  '${(widget.stock.volume * 0.85 / 1000000).toStringAsFixed(1)}M',
                  Colors.grey[400]!,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          _buildVolumeIndicator('Volume Trend', 'Increasing', Colors.green),
          SizedBox(height: 8.h),
          _buildVolumeIndicator('Volume vs Price', 'Confirming', Colors.green),
          SizedBox(height: 8.h),
          _buildVolumeIndicator('Accumulation/Distribution', 'Accumulation', Colors.green),
          
          SizedBox(height: 12.h),
          
          Text(
            'Volume is above average, confirming the current price trend. Institutional buying activity detected.',
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeIndicator(String name, String status, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceActionSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Action Analysis',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          
          _buildPriceActionItem('Trend Direction', 'Uptrend', Colors.green),
          SizedBox(height: 8.h),
          _buildPriceActionItem('Trend Strength', 'Strong', Colors.green),
          SizedBox(height: 8.h),
          _buildPriceActionItem('Momentum', 'Bullish', Colors.green),
          SizedBox(height: 8.h),
          _buildPriceActionItem('Volatility', 'Moderate', Colors.orange),
          SizedBox(height: 8.h),
          _buildPriceActionItem('Pattern', 'Ascending Triangle', Colors.blue),
          
          SizedBox(height: 12.h),
          
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Observations',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '• Higher highs and higher lows pattern\n• Strong buying pressure at support levels\n• Breakout above previous resistance\n• Increasing volume on up moves',
                  style: GoogleFonts.inter(
                    color: Colors.grey[300],
                    fontSize: 11.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceActionItem(String label, String value, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRiskAssessmentSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Risk Assessment',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          
          Row(
            children: [
              Expanded(
                child: _buildRiskMetric('Risk Level', 'Moderate', Colors.orange),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildRiskMetric('Volatility', '${(widget.stock.beta * 15).toStringAsFixed(1)}%', Colors.blue),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          Text(
            'Risk Factors',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          
          _buildRiskFactor('Market Volatility', 'Medium', Colors.orange),
          _buildRiskFactor('Sector Risk', 'Low', Colors.green),
          _buildRiskFactor('Liquidity Risk', 'Low', Colors.green),
          _buildRiskFactor('Technical Risk', 'Medium', Colors.orange),
          
          SizedBox(height: 12.h),
          
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Risk Management',
                  style: GoogleFonts.inter(
                    color: Colors.orange,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Suggested stop-loss: \$${(widget.stock.currentPrice * 0.95).toStringAsFixed(2)} (-5%)\nSuggested take-profit: \$${(widget.stock.currentPrice * 1.10).toStringAsFixed(2)} (+10%)',
                  style: GoogleFonts.inter(
                    color: Colors.grey[300],
                    fontSize: 11.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskFactor(String factor, String level, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              factor,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              level,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add these new methods for drawing selection and dragging

  DrawingElement? _findDrawingAtPoint(Offset point, List<StockPrice> priceHistory) {
    // Check drawings in reverse order (last drawn first)
    for (int i = _drawings.length - 1; i >= 0; i--) {
      if (_isPointNearDrawing(point, _drawings[i], priceHistory)) {
        return _drawings[i];
      }
    }
    return null;
  }

  bool _isPointNearDrawing(Offset point, DrawingElement drawing, List<StockPrice> priceHistory) {
    const double hitRadius = 20.0; // Hit detection radius in pixels
    
    if (drawing is TrendlineElement) {
      return _isPointNearLine(point, drawing.startPoint, drawing.endPoint, hitRadius);
    } else if (drawing is HorizontalLineElement) {
      final y = _priceToScreen(drawing.value, priceHistory);
      return (point.dy - y).abs() < hitRadius;
    } else if (drawing is VerticalLineElement) {
      final x = _timeIndexToScreen(drawing.index, priceHistory);
      return (point.dx - x).abs() < hitRadius;
    } else if (drawing is MeasureElement) {
      return _isPointNearLine(point, drawing.startPoint, drawing.endPoint, hitRadius);
    }
    
    return false;
  }

  bool _isPointNearLine(Offset point, Offset start, Offset end, double radius) {
    // Calculate distance from point to line segment
    final A = point.dx - start.dx;
    final B = point.dy - start.dy;
    final C = end.dx - start.dx;
    final D = end.dy - start.dy;

    final dot = A * C + B * D;
    final lenSq = C * C + D * D;
    
    if (lenSq == 0) {
      // Start and end are the same point
      final distance = math.sqrt(A * A + B * B);
      return distance <= radius;
    }
    
    var param = dot / lenSq;
    param = param.clamp(0.0, 1.0);
    
    final xx = start.dx + param * C;
    final yy = start.dy + param * D;
    
    final dx = point.dx - xx;
    final dy = point.dy - yy;
    final distance = math.sqrt(dx * dx + dy * dy);
    
    return distance <= radius;
  }

  void _updateDrawingPosition(Offset newPoint, List<StockPrice> priceHistory) {
    if (_selectedDrawing == null || _dragStartPoint == null || _selectedDrawingIndex == null) return;

    final deltaX = newPoint.dx - _dragStartPoint!.dx;
    final deltaY = newPoint.dy - _dragStartPoint!.dy;

    setState(() {
      if (_selectedDrawing is TrendlineElement) {
        final current = _selectedDrawing as TrendlineElement;
        final newStartPoint = Offset(current.startPoint.dx + deltaX, current.startPoint.dy + deltaY);
        final newEndPoint = Offset(current.endPoint.dx + deltaX, current.endPoint.dy + deltaY);
        
        final newStartValue = _screenToPrice(newStartPoint, priceHistory);
        final newEndValue = _screenToPrice(newEndPoint, priceHistory);
        final newStartIndex = _screenToTimeIndex(newStartPoint, priceHistory);
        final newEndIndex = _screenToTimeIndex(newEndPoint, priceHistory);
        
        _selectedDrawing = TrendlineElement(
          startPoint: newStartPoint,
          endPoint: newEndPoint,
          startValue: newStartValue,
          endValue: newEndValue,
          startIndex: newStartIndex,
          endIndex: newEndIndex,
          color: current.color,
        );
        
        _drawings[_selectedDrawingIndex!] = _selectedDrawing!;
      } else if (_selectedDrawing is HorizontalLineElement) {
        final current = _selectedDrawing as HorizontalLineElement;
        final newYPosition = current.yPosition + deltaY;
        final newValue = _screenToPrice(Offset(0, newYPosition), priceHistory);
        
        _selectedDrawing = HorizontalLineElement(
          value: newValue,
          yPosition: newYPosition,
          color: current.color,
        );
        
        _drawings[_selectedDrawingIndex!] = _selectedDrawing!;
      } else if (_selectedDrawing is VerticalLineElement) {
        final current = _selectedDrawing as VerticalLineElement;
        final newXPosition = current.xPosition + deltaX;
        final newIndex = _screenToTimeIndex(Offset(newXPosition, 0), priceHistory);
        final newTimestamp = newIndex < priceHistory.length 
            ? priceHistory[newIndex].timestamp 
            : DateTime.now();
        
        _selectedDrawing = VerticalLineElement(
          index: newIndex,
          xPosition: newXPosition,
          timestamp: newTimestamp,
          color: current.color,
        );
        
        _drawings[_selectedDrawingIndex!] = _selectedDrawing!;
      } else if (_selectedDrawing is MeasureElement) {
        final current = _selectedDrawing as MeasureElement;
        final newStartPoint = Offset(current.startPoint.dx + deltaX, current.startPoint.dy + deltaY);
        final newEndPoint = Offset(current.endPoint.dx + deltaX, current.endPoint.dy + deltaY);
        
        final newStartValue = _screenToPrice(newStartPoint, priceHistory);
        final newEndValue = _screenToPrice(newEndPoint, priceHistory);
        final newStartIndex = _screenToTimeIndex(newStartPoint, priceHistory);
        final newEndIndex = _screenToTimeIndex(newEndPoint, priceHistory);
        
        _selectedDrawing = MeasureElement(
          startPoint: newStartPoint,
          endPoint: newEndPoint,
          startValue: newStartValue,
          endValue: newEndValue,
          startIndex: newStartIndex,
          endIndex: newEndIndex,
          color: current.color,
        );
        
        _drawings[_selectedDrawingIndex!] = _selectedDrawing!;
      }
      
      // Update drag start point for next frame
      _dragStartPoint = newPoint;
    });
  }

  // Helper methods for coordinate conversion (reverse of existing methods)
  double _priceToScreen(double price, List<StockPrice> priceHistory) {
    try {
      final prices = priceHistory.where((p) => p.high > 0 && p.low > 0).toList();
      if (prices.isEmpty) return 0;
      
      final maxPrice = prices.map((e) => e.high).reduce((a, b) => a > b ? a : b);
      final minPrice = prices.map((e) => e.low).reduce((a, b) => a < b ? a : b);
      
      final chartHeight = MediaQuery.of(context).size.height * 0.9 - 
                         _calculateBottomIndicatorSpace() - 
                         80.h - 
                         MediaQuery.of(context).padding.bottom;
      
      final normalizedPrice = (maxPrice - price) / (maxPrice - minPrice);
      return normalizedPrice * chartHeight;
    } catch (e) {
      print('Error converting price to screen: $e');
      return 0;
    }
  }

  double _timeIndexToScreen(int index, List<StockPrice> priceHistory) {
    try {
      final screenWidth = MediaQuery.of(context).size.width;
      final normalizedIndex = index / (priceHistory.length - 1);
      return normalizedIndex * screenWidth;
    } catch (e) {
      print('Error converting time index to screen: $e');
      return 0;
    }
  }
} 