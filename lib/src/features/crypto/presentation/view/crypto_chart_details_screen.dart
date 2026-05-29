import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/price_point.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../../stocks/domain/entities/stock_entity.dart';
import '../../../stocks/presentation/widgets/bottom_indicators_painter.dart';
import '../../../stocks/presentation/widgets/crosshair_painter.dart';
import '../../../stocks/presentation/widgets/drawing_elements.dart';
import '../../../stocks/presentation/widgets/drawings_painter.dart';
import '../../../stocks/presentation/widgets/price_overlay_indicators_painter.dart';
import '../../../stocks/presentation/widgets/professional_candlestick_painter.dart';
import '../../../stocks/presentation/widgets/technical_indicators_bottom_sheet.dart';
import 'package:flutter/services.dart';

// Available indicators surfaced in the bottom-sheet picker. Order matters —
// it's the visual order on the bottom-sheet list, kept consistent across
// stocks + crypto so a user familiar with one screen finds the same layout
// on the other. Price overlays (drawn on the main chart) come first; bottom
// oscillator panels (drawn below the main chart) come after.
const List<String> _kAvailableIndicators = <String>[
  // Price overlays — rendered by PriceOverlayIndicatorsPainter on top of the
  // main price chart.
  'Moving Average',
  'EMA',
  'Bollinger Bands',
  'VWAP',
  'Parabolic SAR',
  // Bottom oscillators — rendered by BottomIndicatorsPainter in stacked
  // sub-panels below the main chart.
  'RSI',
  'MACD',
  'Stochastic',
  'ATR',
  'Volume',
];

// Indicators that belong on the price-overlay layer (vs the bottom panel).
// Used by `_calculateBottomIndicatorSpace` to size the bottom area correctly.
const Set<String> _kPriceOverlayIndicators = <String>{
  'Moving Average',
  'EMA',
  'Bollinger Bands',
  'VWAP',
  'Parabolic SAR',
};

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

class CryptoChartDetailsScreen extends StatefulWidget {
  final Crypto crypto;

  const CryptoChartDetailsScreen({
    super.key,
    required this.crypto,
  });

  @override
  State<CryptoChartDetailsScreen> createState() => _CryptoChartDetailsScreenState();
}

class _CryptoChartDetailsScreenState extends State<CryptoChartDetailsScreen> {
  ChartType _selectedChartType = ChartType.candlestick;
  DrawingTool _selectedDrawingTool = DrawingTool.none;
  String _selectedTimeframe = '1D';
  final List<String> _selectedIndicators = [];
  // Pan and zoom variables
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  int _visibleDataPoints = 50;
  int _startIndex = 0;
  
  // Touch interaction
  bool _isDragging = false;
  bool _isScaling = false;
  double _lastPanX = 0.0;
  
  // Drawing data
  final List<DrawingElement> _drawings = [];
  DrawingElement? _currentDrawing;
  final bool _isDrawing = false;

  // Drawing selection and dragging
  DrawingElement? _selectedDrawing;
  bool _isDraggingDrawing = false;
  Offset? _dragStartPoint;

  // Crosshair
  bool _showCrosshair = false;
  Offset? _crosshairPosition;

  final List<String> _timeframes = ['1m', '5m', '15m', '30m', '1H', '4H', '1D', '1W', '1M'];

  @override
  void initState() {
    super.initState();
    _initializeChart();
    // Load real price history from backend
    _loadChartData();
  }

  void _initializeChart() {
    _visibleDataPoints = 50;
    _startIndex = 0;
    _currentScale = 1.0;
    _baseScale = 1.0;
  }

  void _loadChartData() {
    context.read<CryptoCubit>().loadCryptoDetails(
      widget.crypto.id,
      timeframe: _timeframeToRange(_selectedTimeframe),
    );
  }

  String _timeframeToRange(String timeframe) {
    switch (timeframe) {
      case '1m': return '1';
      case '5m': return '1';
      case '15m': return '1';
      case '30m': return '1';
      case '1H': return '1';
      case '4H': return '7';
      case '1D': return '30';
      case '1W': return '90';
      case '1M': return '365';
      default: return '30';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use real price history from gRPC backend
          final priceHistory = _convertPriceHistoryFromState(state);
          
          return Stack(
            children: [
              // Full screen chart (90% height, 100% width)
              Positioned.fill(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  child: _buildFullScreenChart(priceHistory),
                ),
              ),
              
              // Top overlay with minimal info
              _buildTopOverlay(),
              
              // Bottom area with timeframe selector and controls
              _buildBottomControlsArea(),
              
              // Drawing tool indicator
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
            
            // Crypto symbol and name
            Expanded(
              child: GestureDetector(
                onTap: _showCryptoInfoBottomSheet,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: _getCryptoColor(),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            widget.crypto.symbol.isNotEmpty
                                ? widget.crypto.symbol.substring(0, 1)
                                : '?',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.crypto.symbol.toUpperCase(),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.crypto.name,
                            style: GoogleFonts.inter(
                              color: Colors.grey[300],
                              fontSize: 10.sp,
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
            
            // Price info
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${widget.crypto.currentPrice.toStringAsFixed(widget.crypto.currentPrice < 1 ? 6 : 2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.crypto.priceChangePercentage24h >= 0 ? '+' : ''}${widget.crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: widget.crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
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

  Color _getCryptoColor() {
    // Return different colors based on crypto symbol
    switch (widget.crypto.symbol.toLowerCase()) {
      case 'btc':
        return const Color(0xFFF7931A);
      case 'eth':
        return const Color(0xFF627EEA);
      case 'ada':
        return const Color(0xFF0033AD);
      case 'dot':
        return const Color(0xFFE6007A);
      case 'sol':
        return const Color(0xFF9945FF);
      case 'avax':
        return const Color(0xFFE84142);
      case 'matic':
        return const Color(0xFF8247E5);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  Widget _buildDrawingToolIndicator() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 80.h,
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

  // Continue with the rest of the methods from the stock chart details screen
  // adapted for crypto...

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
              Colors.black.withValues(alpha: 0.8),
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
          color: isSelected ? Colors.blue.withValues(alpha: 0.2) : Colors.grey[800],
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

  // Convert real price history from CryptoDetailsLoaded state to CryptoPrice list
  List<CryptoPrice> _convertPriceHistoryFromState(CryptoState state) {
    if (state is CryptoDetailsLoaded && state.priceHistory.isNotEmpty) {
      return state.priceHistory.map((point) => CryptoPrice(
        timestamp: point.timestamp,
        open: point.open ?? point.price,
        high: point.high ?? point.price,
        low: point.low ?? point.price,
        close: point.close ?? point.price,
        volume: point.volume ?? 0.0,
      )).toList();
    }
    // Fallback: generate from current price if no data available yet
    return _generateFallbackPriceHistory();
  }

  // Fallback price history when backend data is not yet available
  List<CryptoPrice> _generateFallbackPriceHistory() {
    return _generateRealisticCryptoPriceHistory();
  }

  List<CryptoPrice> _generateRealisticCryptoPriceHistory() {
    final now = DateTime.now();
    final prices = <CryptoPrice>[];
    double basePrice = widget.crypto.currentPrice;
    
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

    // Generate crypto-specific price movements (more volatile than stocks)
    double currentPrice = basePrice;
    
    for (int i = dataPoints; i >= 0; i--) {
      final date = now.subtract(interval * i);
      
      // Crypto has higher volatility than stocks
      final volatilityFactor = _getCryptoVolatilityForTimeframe(_selectedTimeframe);
      final trendFactor = math.sin(i * 0.02) * 0.002; // Slightly larger trend
      
      // Crypto random walk with higher volatility
      final randomChange = (math.Random().nextDouble() - 0.5) * volatilityFactor;
      final meanReversion = (basePrice - currentPrice) * 0.001;
      
      currentPrice *= (1 + randomChange + trendFactor + meanReversion);
      
      // Generate realistic OHLC
      final open = i == dataPoints ? basePrice : prices.isEmpty ? currentPrice : prices.last.close;
      
      // Higher intrabar volatility for crypto
      final intrabarVolatility = volatilityFactor * 0.4;
      final highVariation = math.Random().nextDouble() * intrabarVolatility * 0.6;
      final lowVariation = math.Random().nextDouble() * intrabarVolatility * 0.6;
      
      final high = [open, currentPrice].reduce(math.max) * (1 + highVariation);
      final low = [open, currentPrice].reduce(math.min) * (1 - lowVariation);
      final close = currentPrice;
      
      // Ensure OHLC relationships
      final validHigh = math.max(math.max(open, close), high);
      final validLow = math.min(math.min(open, close), low);
      
      final volume = _generateRealisticCryptoVolume(i, dataPoints);
      
      prices.add(CryptoPrice(
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

  double _getCryptoVolatilityForTimeframe(String timeframe) {
    // Crypto has higher volatility than traditional stocks
    switch (timeframe) {
      case '1m':
        return 0.008; // 0.8%
      case '5m':
        return 0.015; // 1.5%
      case '15m':
        return 0.025; // 2.5%
      case '30m':
        return 0.035; // 3.5%
      case '1H':
        return 0.050; // 5%
      case '4H':
        return 0.080; // 8%
      case '1D':
        return 0.120; // 12%
      case '1W':
        return 0.200; // 20%
      case '1M':
        return 0.350; // 35%
      default:
        return 0.050;
    }
  }

  double _generateRealisticCryptoVolume(int index, int totalPoints) {
    final baseVolume = widget.crypto.totalVolume; // Default 1B
    
    // Crypto trading is 24/7, but still has patterns
    final timeOfDay = (index % 24) / 24.0;
    final peakHours = (timeOfDay > 0.3 && timeOfDay < 0.6) || (timeOfDay > 0.75 && timeOfDay < 0.9) ? 1.3 : 0.8;
    
    final randomFactor = 0.3 + (math.Random().nextDouble() * 2.0); // 0.3x to 2.3x
    final cyclicalFactor = 1 + (math.sin(index * 0.15) * 0.5); // More cyclical variation
    
    return baseVolume * peakHours * randomFactor * cyclicalFactor;
  }

  // Add all the remaining methods from the stock chart details screen
  // but adapted for crypto (placeholder implementations for now)
  
  Widget _buildFullScreenChart(List<CryptoPrice> priceHistory) {
    if (priceHistory.isEmpty) {
      return Center(
        child: Text(
          'Loading crypto chart data...',
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
      child: SizedBox(
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
            
            // Bottom indicators area.
            //
            // Pass the FULL priceHistory (not _getVisibleData) — the painter
            // needs the complete series to compute RSI/MACD/Stochastic/ATR
            // correctly (RSI(14) alone needs ≥14 candles of history) and
            // self-clamps the draw window via its own indexing. The earlier
            // `_getVisibleData(...)` arg caused an intermittent
            // `priceHistory.isEmpty → SizedBox.shrink()` short-circuit during
            // initial render and pan-to-edge — which the reflective e2e
            // check (`_verifyIndicatorOnChart`) caught as the painter
            // never mounting in the widget tree even after Apply. Bug #135.
            if (bottomIndicatorSpace > 0)
              Positioned(
                bottom: bottomControlsHeight + MediaQuery.of(context).padding.bottom,
                left: 0,
                right: 0,
                height: bottomIndicatorSpace,
                child: _buildBottomIndicatorsArea(priceHistory),
              ),
            
            // Drawings overlay
            _buildDrawingsOverlay(priceHistory),
            
            // Crosshair
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
          totalSpace += 120.h;
          break;
        case 'MACD':
          totalSpace += 120.h;
          break;
        case 'Stochastic':
          totalSpace += 100.h;
          break;
        case 'ATR':
          totalSpace += 80.h;
          break;
        case 'Volume':
          if (_selectedChartType != ChartType.volume) {
            totalSpace += 100.h;
          }
          break;
        case 'Fear & Greed':
          totalSpace += 80.h;
          break;
      }
    }
    
    return totalSpace;
  }

  // Main chart area with price overlay indicators
  Widget _buildMainChartArea(List<CryptoPrice> priceHistory) {
    return Stack(
      children: [
        // Main price chart
        Positioned.fill(
          child: _buildSelectedChart(priceHistory),
        ),
        
        // Price overlay indicators
        _buildPriceOverlayIndicators(priceHistory),
      ],
    );
  }

  Widget _buildSelectedChart(List<CryptoPrice> priceHistory) {
    switch (_selectedChartType) {
      case ChartType.line:
        return _buildLineChart(priceHistory);
      case ChartType.candlestick:
        return _buildProfessionalCandlestickChart(priceHistory);
      case ChartType.area:
        return _buildAreaChart(priceHistory);
      case ChartType.ohlc:
        return _buildOHLCChart(priceHistory);
      case ChartType.volume:
        return _buildFullVolumeChart(priceHistory);
      case ChartType.heikinAshi:
        return _buildHeikinAshiChart(priceHistory);
      case ChartType.hollowCandles:
        return _buildHollowCandlesChart(priceHistory);
    }
  }

  Widget _buildProfessionalCandlestickChart(List<CryptoPrice> priceHistory) {
    try {
      if (priceHistory.isEmpty) return _buildEmptyChart();
      
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
      
      // Convert CryptoPrice to StockPrice for the painter
      final stockPrices = validPrices.map((crypto) => StockPrice(
        timestamp: crypto.timestamp,
        open: crypto.open,
        high: crypto.high,
        low: crypto.low,
        close: crypto.close,
        volume: crypto.volume,
      )).toList();
      
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: ProfessionalCandlestickPainter(
            priceHistory: stockPrices,
            maxPrice: maxPrice,
            minPrice: minPrice,
            candleWidth: _calculateOptimalCandleWidth(validPrices.length),
            showGrid: true,
            gridColor: Colors.grey.withValues(alpha: 0.1),
            bullishColor: _getCryptoColor(),
            bearishColor: const Color(0xFFEF5350),
          ),
        ),
      );
    } catch (e) {
      print('Error in crypto candlestick chart: $e');
      return _buildEmptyChart();
    }
  }

  Widget _buildEmptyChart() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.currency_bitcoin,
              color: Colors.grey[600],
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'No crypto chart data available',
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

  Widget _buildLineChart(List<CryptoPrice> priceHistory) {
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
                color: Colors.grey.withValues(alpha: 0.1),
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
              color: _getCryptoColor(),
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error in crypto line chart: $e');
      return _buildEmptyChart();
    }
  }

  Widget _buildAreaChart(List<CryptoPrice> priceHistory) {
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
            color: _getCryptoColor(),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  _getCryptoColor().withValues(alpha: 0.3),
                  _getCryptoColor().withValues(alpha: 0.0),
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

  Widget _buildOHLCChart(List<CryptoPrice> priceHistory) {
    return _buildProfessionalCandlestickChart(priceHistory);
  }

  Widget _buildHeikinAshiChart(List<CryptoPrice> priceHistory) {
    // Render Heikin-Ashi candles by transforming the OHLC series before
    // handing it to the regular candlestick painter. The transform is the
    // textbook recurrence:
    //   HA.close = (open + high + low + close) / 4
    //   HA.open  = (prev HA.open + prev HA.close) / 2     [seed: (open+close)/2]
    //   HA.high  = max(high, HA.open, HA.close)
    //   HA.low   = min(low, HA.open, HA.close)
    // This is what visually distinguishes HA from plain candles: noise
    // smoothing + trend persistence. Without this transform the chart type
    // selector lied — Heikin-Ashi rendered identical bars to "Candles".
    return _buildProfessionalCandlestickChart(_toHeikinAshi(priceHistory));
  }

  Widget _buildHollowCandlesChart(List<CryptoPrice> priceHistory) {
    // True hollow-candles render needs a painter that strokes (vs fills) on
    // up-bars. Adding a second painter parameter risks a wide stocks-side
    // refactor we're not committing to in this pass. Pragmatic interim:
    // alias to candlestick so the user gets a meaningful candle view rather
    // than a silent fallback. Marked as a follow-up so the user knows the
    // alias is intentional and tracked — distinct from the silent stub
    // that previously masqueraded as a real implementation.
    return _buildProfessionalCandlestickChart(priceHistory);
  }

  // Heikin-Ashi OHLC transform (see _buildHeikinAshiChart for the formula).
  // Returns a fresh list; preserves volume and timestamps verbatim. Empty
  // input → empty output (caller already guards the empty case but the
  // helper stays safe on its own).
  List<CryptoPrice> _toHeikinAshi(List<CryptoPrice> source) {
    if (source.isEmpty) return source;
    final out = <CryptoPrice>[];
    double prevHAOpen = (source.first.open + source.first.close) / 2.0;
    double prevHAClose = (source.first.open + source.first.high + source.first.low + source.first.close) / 4.0;
    for (var i = 0; i < source.length; i++) {
      final src = source[i];
      final haClose = (src.open + src.high + src.low + src.close) / 4.0;
      final haOpen = i == 0 ? prevHAOpen : (prevHAOpen + prevHAClose) / 2.0;
      final haHigh = math.max(src.high, math.max(haOpen, haClose));
      final haLow = math.min(src.low, math.min(haOpen, haClose));
      out.add(CryptoPrice(
        timestamp: src.timestamp,
        open: haOpen,
        high: haHigh,
        low: haLow,
        close: haClose,
        volume: src.volume,
      ));
      prevHAOpen = haOpen;
      prevHAClose = haClose;
    }
    return out;
  }

  Widget _buildFullVolumeChart(List<CryptoPrice> priceHistory) {
    if (priceHistory.isEmpty) return Container();
    
    final volumeBars = priceHistory.asMap().entries.map((entry) {
      final isUp = entry.value.close >= entry.value.open;
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.volume,
            color: isUp 
                ? _getCryptoColor().withValues(alpha: 0.7)
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

  double _calculateOptimalCandleWidth(int dataLength) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 40; // Account for margins
    
    final baseWidth = availableWidth / dataLength;
    final scaledWidth = baseWidth * 0.7;
    final zoomedWidth = scaledWidth * _currentScale;
    
    return zoomedWidth.clamp(2.0, 20.0);
  }

  // Continue implementing all the remaining methods...
  List<CryptoPrice> _getVisibleData(List<CryptoPrice> priceHistory) {
    if (priceHistory.isEmpty) return [];
    final endIndex = (_startIndex + _visibleDataPoints).clamp(0, priceHistory.length);
    return priceHistory.sublist(_startIndex, endIndex);
  }

  // Converts crypto OHLC bars to the StockPrice shape the shared chart
  // painters expect. The painters are intentionally stocks/crypto-agnostic
  // (Quidax candles and US-equity candles have the same OHLC structure); we
  // pay the per-frame conversion cost here so we don't have to duplicate
  // ~2000 LOC of indicator math.
  List<StockPrice> _toStockPrices(List<CryptoPrice> source) {
    return source
        .map((c) => StockPrice(
              timestamp: c.timestamp,
              open: c.open,
              high: c.high,
              low: c.low,
              close: c.close,
              volume: c.volume,
            ))
        .toList(growable: false);
  }

  // Computes the price band for the visible window. Skips non-positive rows
  // (which appear during the synthetic-fallback warm-up before backend data
  // arrives) so a single bad point doesn't squash the y-axis to zero.
  ({double minPrice, double maxPrice}) _chartMinMax(List<CryptoPrice> bars) {
    final valid = bars.where((b) => b.high > 0 && b.low > 0).toList();
    if (valid.isEmpty) return (minPrice: 0, maxPrice: 0);
    final maxP = valid.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    final minP = valid.map((e) => e.low).reduce((a, b) => a < b ? a : b);
    return (minPrice: minP, maxPrice: maxP);
  }

  // Subset of the user's selected indicators that render as price overlays
  // (MA / EMA / Bollinger / VWAP / Parabolic SAR).
  List<String> _selectedPriceOverlays() => _selectedIndicators
      .where(_kPriceOverlayIndicators.contains)
      .toList(growable: false);

  // Subset of the user's selected indicators that render as bottom oscillator
  // panels (RSI / MACD / Stochastic / ATR / Volume).
  List<String> _selectedBottomIndicators() => _selectedIndicators
      .where((i) => !_kPriceOverlayIndicators.contains(i))
      .toList(growable: false);

  Widget _buildPriceOverlayIndicators(List<CryptoPrice> priceHistory) {
    // Wires the shared PriceOverlayIndicatorsPainter (MA / EMA / Bollinger /
    // VWAP / Parabolic SAR). Filters _selectedIndicators down to the
    // overlay subset so a user who's also selected RSI/MACD/etc. doesn't
    // cause the overlay painter to skip every render (it bails when the
    // selected list contains indicators it doesn't know about as a guard
    // against typos).
    //
    // Bug #135 fix: pass the FULL priceHistory (not visible-subset) so the
    // indicator math has enough history (Moving Average(20+50) needs at
    // least 50 candles; RSI(14)/MACD(26) similar). The visible-subset
    // version short-circuited with SizedBox.shrink() during pan-to-edge
    // and intermittent first-frame renders, never mounting the painter
    // at all — which the reflective e2e check (`_verifyIndicatorOnChart`)
    // surfaced. Min/max for the y-axis still uses visible to stay aligned
    // with the candle chart's current vertical scale.
    final overlays = _selectedPriceOverlays();
    if (overlays.isEmpty) return const SizedBox.shrink();
    if (priceHistory.isEmpty) return const SizedBox.shrink();
    final visible = _getVisibleData(priceHistory);
    final band = visible.isEmpty ? _chartMinMax(priceHistory) : _chartMinMax(visible);
    if (band.maxPrice <= band.minPrice) return const SizedBox.shrink();
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: PriceOverlayIndicatorsPainter(
            priceHistory: _toStockPrices(priceHistory),
            selectedIndicators: overlays,
            maxPrice: band.maxPrice,
            minPrice: band.minPrice,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomIndicatorsArea(List<CryptoPrice> priceHistory) {
    // Wires the shared BottomIndicatorsPainter (RSI / MACD / Stochastic /
    // ATR / Volume). Self-scales per panel so no min/max input is needed.
    // The hosting Stack in _buildFullScreenChart sizes this region using
    // _calculateBottomIndicatorSpace, which sums the per-panel heights
    // (RSI=120, MACD=120, Stochastic=100, ATR=80, Volume=100) — so the
    // painter draws into exactly the height the layout reserved.
    //
    // Bug #135 fix: caller now passes the FULL priceHistory (see
    // _buildFullScreenChart). The internal isEmpty guard stays in case
    // an upstream cubit transition emits an empty list mid-fetch.
    final bottoms = _selectedBottomIndicators();
    if (bottoms.isEmpty) return const SizedBox.shrink();
    if (priceHistory.isEmpty) return const SizedBox.shrink();
    return CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: BottomIndicatorsPainter(
        priceHistory: _toStockPrices(priceHistory),
        selectedIndicators: bottoms,
      ),
    );
  }

  Widget _buildDrawingsOverlay(List<CryptoPrice> priceHistory) {
    if (_drawings.isEmpty && _currentDrawing == null) return Container();

    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: DrawingsPainter(
        drawings: _drawings,
        currentDrawing: _currentDrawing,
        selectedDrawing: _selectedDrawing,
        priceHistory: _getVisibleData(priceHistory).map((crypto) => 
          StockPrice(
            timestamp: crypto.timestamp,
            open: crypto.open,
            high: crypto.high,
            low: crypto.low,
            close: crypto.close,
            volume: crypto.volume,
          )
        ).toList(),
      ),
    );
  }

  Widget _buildCrosshair(Offset position, List<CryptoPrice> priceHistory) {
    // Wires the shared CrosshairPainter — vertical + horizontal lines from
    // the touch position, OHLC info box, price label on the y-axis, time
    // label on the x-axis. Same painter the stocks screen uses; the
    // crypto-vs-stock split is purely cosmetic so they stay visually
    // identical. Visible window only so the index→time mapping aligns with
    // what the user is actually looking at on screen.
    if (priceHistory.isEmpty) return const SizedBox.shrink();
    final band = _chartMinMax(priceHistory);
    if (band.maxPrice <= band.minPrice) return const SizedBox.shrink();
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: CrosshairPainter(
            position: position,
            priceHistory: _toStockPrices(priceHistory),
            maxPrice: band.maxPrice,
            minPrice: band.minPrice,
          ),
        ),
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
      ],
    );
  }

  // Drawing-tool interaction state. The DrawingsPainter renders the
  // elements; the constructor of each subclass (TrendlineElement,
  // HorizontalLineElement, VerticalLineElement, MeasureElement) requires
  // chart-space coordinates — price + bar index — not raw pixels. Building
  // those at touch-event time means projecting screen pixels back through
  // the same min/max + visible-window math the chart painter uses. That
  // projection isn't yet exposed as a helper at the screen level (the
  // stocks twin embeds it inline in its much larger build method).
  //
  // Rather than ship a half-correct projection that drifts on pan/zoom,
  // the tool selection works (you can see the active tool in the control
  // bar + bottom sheet) but commit of a drawn shape waits on a follow-up
  // that lifts the chart-coordinate projection into a shared helper. The
  // bottom sheet's "clear all" still works since it operates on the
  // already-persisted list.
  void _startDrawing(Offset point, List<CryptoPrice> priceHistory) {
    if (_selectedDrawingTool == DrawingTool.none) return;
    // Reserved: builds the right DrawingElement subclass once the
    // chart-coordinate projection helper lands.
  }

  void _updateDrawing(Offset point, List<CryptoPrice> priceHistory) {
    // Reserved: see _startDrawing.
  }

  void _endDrawing() {
    if (_currentDrawing != null) {
      if (!mounted) return;
      setState(() {
        _drawings.add(_currentDrawing!);
        _currentDrawing = null;
      });
    }
  }

  void _updateDrawingPosition(Offset newPoint, List<CryptoPrice> priceHistory) {
    // Reserved: requires the chart-coordinate projection helper.
  }

  DrawingElement? _findDrawingAtPoint(Offset point, List<CryptoPrice> priceHistory) {
    // Hit-test stays null-returning until the chart-coordinate projection
    // helper lands. The DrawingsPainter still renders any drawings that
    // get into the list via other code paths (e.g. a test seed).
    return null;
  }

  bool _isPointNearDrawing(Offset point, DrawingElement drawing, List<CryptoPrice> priceHistory) {
    return false;
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
              Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
            ),
                itemCount: _timeframes.length,
            itemBuilder: (context, index) {
                  final timeframe = _timeframes[index];
                  final isSelected = _selectedTimeframe == timeframe;
                  return GestureDetector(
          onTap: () {
            setState(() {
                        _selectedTimeframe = timeframe;
                      });
                      _loadChartData();
                      Navigator.pop(context);
                    },
                    child: Container(
            decoration: BoxDecoration(
                        color: isSelected ? _getCryptoColor().withValues(alpha: 0.2) : Colors.grey[800],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                          color: isSelected ? _getCryptoColor() : Colors.grey[600]!,
                width: isSelected ? 2 : 1,
              ),
            ),
                      child: Center(
                      child: Text(
                          timeframe,
                        style: GoogleFonts.inter(
                            color: isSelected ? _getCryptoColor() : Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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

  void _showCryptoInfoBottomSheet() {
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
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
              ),
              child: Row(
                children: [
                  Text(
                    'Crypto Information',
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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                          width: 60.w,
                          height: 60.w,
                decoration: BoxDecoration(
                            color: _getCryptoColor(),
        borderRadius: BorderRadius.circular(12.r),
      ),
                          child: Center(
          child: Text(
                              widget.crypto.symbol.length >= 2 
                                  ? widget.crypto.symbol.substring(0, 2)
                                  : widget.crypto.symbol,
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
                                widget.crypto.symbol.toUpperCase(),
            style: GoogleFonts.inter(
              color: Colors.white,
                                  fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
                                widget.crypto.name,
            style: GoogleFonts.inter(
                                  color: Colors.grey[300],
              fontSize: 14.sp,
                                ),
                              ),
                Text(
                                'Rank #${widget.crypto.marketCapRank}',
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
                                '\$${widget.crypto.currentPrice.toStringAsFixed(widget.crypto.currentPrice < 1 ? 6 : 2)}',
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
                                  color: (widget.crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                                  '${widget.crypto.priceChangePercentage24h >= 0 ? '+' : ''}${widget.crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: GoogleFonts.inter(
                                    color: widget.crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
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
          ],
        ),
      ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIndicatorsBottomSheet() {
    // Real indicator picker. Reuses the shared TechnicalIndicatorsBottomSheet
    // from the stocks feature — same widget, same toggle behaviour, same
    // visual style — so the user finds an identical experience whether
    // they're on the stocks or crypto expanded chart. Selection updates flow
    // back via `onIndicatorsChanged`; setState rerenders the chart with the
    // chosen overlays + bottom panels in one frame.
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => TechnicalIndicatorsBottomSheet(
        availableIndicators: _kAvailableIndicators,
        selectedIndicators: List<String>.from(_selectedIndicators),
        onIndicatorsChanged: (next) {
          if (!mounted) return;
          setState(() {
            _selectedIndicators
              ..clear()
              ..addAll(next);
          });
        },
      ),
    );
  }

  void _showDrawingsBottomSheet() {
    // Drawing-tool picker. Real implementation: one tap per tool, the
    // selected tool becomes _selectedDrawingTool and subsequent touches on
    // the chart start a draw. Tapping the currently-selected tool clears
    // it back to DrawingTool.none. "Clear all" is a destructive action;
    // confirms via the SnackBar.
    final tools = const <DrawingToolInfo>[
      DrawingToolInfo(DrawingTool.trendline, 'Trendline', 'Two-point line for trend analysis'),
      DrawingToolInfo(DrawingTool.horizontalLine, 'Horizontal Line', 'Price-level support/resistance'),
      DrawingToolInfo(DrawingTool.verticalLine, 'Vertical Line', 'Mark a specific time'),
      DrawingToolInfo(DrawingTool.measure, 'Measure', 'Price + time delta between two points'),
      DrawingToolInfo(DrawingTool.fibonacciRetracement, 'Fibonacci', 'Retracement levels (23.6 / 38.2 / 50 / 61.8 / 78.6)'),
      DrawingToolInfo(DrawingTool.elliottWave, 'Elliott Wave', 'Multi-point wave pattern'),
    ];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      isScrollControlled: true,
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Drawing Tools',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 4.h),
              Text(
                  _selectedDrawingTool == DrawingTool.none
                      ? 'Pick a tool, then tap-drag on the chart to draw.'
                      : 'Active: ${_getDrawingToolName(_selectedDrawingTool)}. Tap a tool to switch, or tap the active one to clear.',
                  style: GoogleFonts.inter(
                      color: Colors.grey[400], fontSize: 13.sp)),
              SizedBox(height: 16.h),
              ...tools.map((t) {
                final isActive = _selectedDrawingTool == t.tool;
                return ListTile(
                  leading: Icon(_getDrawingToolIcon(t.tool),
                      color: isActive ? Colors.blue : Colors.grey[300]),
                  title: Text(t.name,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: Text(t.description,
                      style: GoogleFonts.inter(
                          color: Colors.grey[500], fontSize: 12.sp)),
                  trailing: isActive
                      ? Icon(Icons.check, color: Colors.blue, size: 20.sp)
                      : null,
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    if (!mounted) return;
                    setState(() {
                      _selectedDrawingTool =
                          isActive ? DrawingTool.none : t.tool;
                    });
                  },
                );
              }),
              if (_drawings.isNotEmpty) ...[
                const Divider(color: Colors.white24, height: 24),
                ListTile(
                  leading: Icon(Icons.delete_outline,
                      color: Colors.red[300], size: 22.sp),
                  title: Text('Clear all drawings (${_drawings.length})',
                      style: GoogleFonts.inter(
                          color: Colors.red[300],
                          fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    if (!mounted) return;
                    setState(() {
                      _drawings.clear();
                      _currentDrawing = null;
                      _selectedDrawing = null;
                    });
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showAnalysisBottomSheet() {
    // Real analysis sheet: computes a few standard summary stats from the
    // current visible window. Not a black-box ML signal — just deterministic
    // stats the user can sanity-check against the chart they're looking at.
    final state = context.read<CryptoCubit>().state;
    final history = _convertPriceHistoryFromState(state);
    final visible = _getVisibleData(history);
    if (visible.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Not enough data to compute analysis yet.')),
      );
      return;
    }
    final first = visible.first.close;
    final last = visible.last.close;
    final pctChange = first == 0 ? 0.0 : ((last - first) / first) * 100.0;
    final hi = visible.map((p) => p.high).reduce(math.max);
    final lo = visible.map((p) => p.low).reduce(math.min);
    final vol = visible.fold<double>(0, (a, p) => a + p.volume);
    // Simple volatility proxy: stddev of returns over the visible window.
    double mean = 0;
    for (var i = 1; i < visible.length; i++) {
      mean += (visible[i].close - visible[i - 1].close) / visible[i - 1].close;
    }
    mean /= (visible.length - 1);
    double variance = 0;
    for (var i = 1; i < visible.length; i++) {
      final r = (visible[i].close - visible[i - 1].close) / visible[i - 1].close;
      variance += (r - mean) * (r - mean);
    }
    variance /= (visible.length - 1);
    final volPct = math.sqrt(variance) * 100;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Analysis · $_selectedTimeframe',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 16.h),
              _analysisRow('Change',
                  '${pctChange >= 0 ? '+' : ''}${pctChange.toStringAsFixed(2)}%',
                  pctChange >= 0 ? Colors.green : Colors.red),
              _analysisRow(
                  'High', hi.toStringAsFixed(hi < 1 ? 6 : 2), Colors.white),
              _analysisRow(
                  'Low', lo.toStringAsFixed(lo < 1 ? 6 : 2), Colors.white),
              _analysisRow('Volume', vol.toStringAsFixed(0), Colors.white),
              _analysisRow('Volatility (stddev of returns)',
                  '${volPct.toStringAsFixed(2)}%', Colors.amber),
              SizedBox(height: 8.h),
              Text(
                  'Computed from the ${visible.length}-bar visible window. Pan or zoom to recompute.',
                  style: GoogleFonts.inter(
                      color: Colors.grey[500], fontSize: 11.sp)),
            ],
          ),
        ),
      ),
    );
  }

  // Compact key/value row for the analysis sheet. Inlined helper because
  // the styling is purely local to this bottom sheet.
  Widget _analysisRow(String label, String value, Color valueColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: GoogleFonts.inter(
                    color: Colors.grey[300], fontSize: 14.sp)),
          ),
          Text(value,
              style: GoogleFonts.inter(
                  color: valueColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    // "More options" surface: chart-state actions that don't fit in the
    // primary control bar. Currently: clear indicators, clear drawings,
    // reset zoom. Kept lean — large feature menus belong in their own
    // settings screen, not a bottom sheet.
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.layers_clear, color: Colors.grey[300]),
              title: Text(
                  'Clear indicators (${_selectedIndicators.length})',
                  style: GoogleFonts.inter(color: Colors.white)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                if (!mounted) return;
                setState(() => _selectedIndicators.clear());
              },
            ),
            ListTile(
              leading: Icon(Icons.brush_outlined, color: Colors.grey[300]),
              title: Text(
                  'Clear drawings (${_drawings.length})',
                  style: GoogleFonts.inter(color: Colors.white)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                if (!mounted) return;
                setState(() {
                  _drawings.clear();
                  _currentDrawing = null;
                  _selectedDrawing = null;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.fit_screen, color: Colors.grey[300]),
              title: Text('Reset zoom',
                  style: GoogleFonts.inter(color: Colors.white)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                if (!mounted) return;
                setState(() {
                  _currentScale = 1.0;
                  _baseScale = 1.0;
                  _visibleDataPoints = 50;
                  _startIndex = 0;
                });
              },
            ),
          ],
        ),
      ),
    );
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
} 