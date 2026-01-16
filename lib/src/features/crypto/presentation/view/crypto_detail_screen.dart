import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../cubit/crypto_cubit.dart';
import '../../domain/entities/crypto_entity.dart';
import 'buy_crypto_screen.dart';
import 'sell_crypto_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';

class CryptoDetailScreen extends StatefulWidget {
  final Crypto crypto;

  const CryptoDetailScreen({super.key, required this.crypto});

  @override
  State<CryptoDetailScreen> createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  
  final List<String> _timeframes = ['1H', '4H', '1D', '1W', '1M', '3M', '6M', '1Y', 'ALL'];
  String _selectedTimeframe = '1D';
  bool _isInWatchlist = false;
  
  // Technical Indicators
  final List<String> _selectedIndicators = [];
  final List<String> _availableIndicators = [
    'SMA', 'EMA', 'MACD', 'RSI', 'Bollinger Bands', 'Volume', 'Stochastic'
  ];

  // Mock data for demonstration
  final List<FlSpot> _mockPriceData = [
    FlSpot(0, 65000), FlSpot(1, 65200), FlSpot(2, 65800), FlSpot(3, 66100),
    FlSpot(4, 66500), FlSpot(5, 66200), FlSpot(6, 66800), FlSpot(7, 67200),
    FlSpot(8, 67000), FlSpot(9, 67500), FlSpot(10, 67800), FlSpot(11, 68200),
    FlSpot(12, 68000), FlSpot(13, 68500), FlSpot(14, 68900), FlSpot(15, 69200),
    FlSpot(16, 69000), FlSpot(17, 69400), FlSpot(18, 69800), FlSpot(19, 70200),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupTabController();
    _loadCryptoDetails();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _animationController.forward();
  }

  void _setupTabController() {
    _tabController = TabController(length: 3, vsync: this);
  }

  void _loadCryptoDetails() {
    // Load crypto details, price history, etc.
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOverviewTab(),
                    _buildAnalysisTab(),
                    _buildNewsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.crypto.symbol.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.crypto.name,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isInWatchlist = !_isInWatchlist;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: _isInWatchlist ? _getCryptoColor().withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Icon(
                  _isInWatchlist ? Icons.bookmark : Icons.bookmark_border,
                  color: _isInWatchlist ? _getCryptoColor() : Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(4.w),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Analysis'),
          Tab(text: 'News'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPriceHeader(),
          _buildAdvancedChart(),
          _buildActionButtons(),
          _buildKeyDataPoints(),
          _buildTechnicalAnalysisGauge(),
          _buildMarketOrderBook(),
          _buildMarketStats(),
          _buildPortfolioSection(),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTechnicalAnalysisSection(),
          SizedBox(height: 20.h),
          _buildIndicatorsSection(),
          SizedBox(height: 20.h),
          _buildSentimentSection(),
        ],
      ),
    );
  }

  Widget _buildNewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: List.generate(5, (index) => _buildNewsItem(index)),
      ),
    );
  }

  Widget _buildPriceHeader() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCryptoColor().withValues(alpha: 0.15),
            _getCryptoColor().withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    colors: [_getCryptoColor(), _getCryptoColor().withValues(alpha: 0.7)],
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.crypto.symbol.length >= 2 
                        ? widget.crypto.symbol.substring(0, 2).toUpperCase()
                        : widget.crypto.symbol.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.crypto.name,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.crypto.symbol.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '\$${widget.crypto.currentPrice.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                widget.crypto.priceChangePercentage24h >= 0 ? Icons.trending_up : Icons.trending_down,
                color: widget.crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
                size: 20.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${widget.crypto.priceChangePercentage24h >= 0 ? '+' : ''}${widget.crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  color: widget.crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(\$${widget.crypto.priceChange24h.toStringAsFixed(2)})',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedChart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 320.h,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chart header with timeframes and expand button
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Price Chart',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                // Expand button to go to full chart screen
                GestureDetector(
                  onTap: _openFullChartScreen,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: _getCryptoColor().withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.fullscreen,
                          color: _getCryptoColor(),
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Expand',
                          style: GoogleFonts.inter(
                            color: _getCryptoColor(),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Timeframe selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _timeframes.map((timeframe) {
                  final isSelected = _selectedTimeframe == timeframe;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeframe = timeframe;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: isSelected ? _getCryptoColor().withValues(alpha: 0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                      ),
                      child: Text(
                        timeframe,
                        style: GoogleFonts.inter(
                          color: isSelected ? _getCryptoColor() : Colors.grey[400],
                          fontSize: 12.sp,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // Chart area
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withValues(alpha: 0.05),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: _mockPriceData.length.toDouble() - 1,
                  minY: _mockPriceData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b) * 0.98,
                  maxY: _mockPriceData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) * 1.02,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _mockPriceData,
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          _getCryptoColor(),
                          _getCryptoColor().withValues(alpha: 0.7),
                        ],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            _getCryptoColor().withValues(alpha: 0.3),
                            _getCryptoColor().withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) => Colors.black.withValues(alpha: 0.8),
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return LineTooltipItem(
                            '\$${barSpot.y.toStringAsFixed(0)}',
                            GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _navigateToBuyScreen(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.withValues(alpha: 0.8)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'Buy',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => _navigateToSellScreen(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.red.withValues(alpha: 0.8)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'Sell',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStats() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Statistics',
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
                child: _buildStatItem('Market Cap', '\$${(widget.crypto.marketCap / 1e9).toStringAsFixed(1)}B'),
              ),
              Expanded(
                child: _buildStatItem('24h Volume', '\$${(widget.crypto.totalVolume / 1e6).toStringAsFixed(1)}M'),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Circulating Supply', '${(widget.crypto.circulatingSupply / 1e6).toStringAsFixed(1)}M'),
              ),
              Expanded(
                child: _buildStatItem('All-Time High', widget.crypto.ath != null ? '\$${widget.crypto.ath!.toStringAsFixed(2)}' : 'N/A'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Portfolio',
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
                child: _buildPortfolioItem('Holdings', '0.5 ${widget.crypto.symbol.toUpperCase()}'),
              ),
              Expanded(
                child: _buildPortfolioItem('Value', '\$${(widget.crypto.currentPrice * 0.5).toStringAsFixed(2)}'),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioItem('Avg. Cost', '\$${(widget.crypto.currentPrice * 0.95).toStringAsFixed(2)}'),
              ),
              Expanded(
                child: _buildPortfolioItem('P&L', '+\$${(widget.crypto.currentPrice * 0.025).toStringAsFixed(2)}', isPositive: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioItem(String label, String value, {bool isPositive = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: label == 'P&L' 
                ? (isPositive ? Colors.green : Colors.red)
                : Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.crypto.name}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'This is a detailed description of ${widget.crypto.name} and its key features, use cases, and market position.',
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyDataPoints() {
    // Calculate mock data based on current price
    final currentPrice = widget.crypto.currentPrice;
    final volume = widget.crypto.totalVolume;
    final previousClose = currentPrice * (1 + (math.Random().nextDouble() - 0.5) * 0.02);
    final open = currentPrice * (1 + (math.Random().nextDouble() - 0.5) * 0.015);
    final dayLow = currentPrice * 0.985;
    final dayHigh = currentPrice * 1.015;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key data points',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          _buildDataPointRow('Volume', '${(volume / 1e9).toStringAsFixed(2)}B'),
          SizedBox(height: 16.h),
          _buildDataPointRow('Previous close', '\$${previousClose.toStringAsFixed(2)} USD'),
          SizedBox(height: 16.h),
          _buildDataPointRow('Open', '\$${open.toStringAsFixed(2)} USD'),
          SizedBox(height: 16.h),
          _buildDataPointRow('Day\'s range', '\$${dayLow.toStringAsFixed(2)} — \$${dayHigh.toStringAsFixed(2)} USD'),
        ],
      ),
    );
  }

  Widget _buildDataPointRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicalAnalysisGauge() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technicals',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.h),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 200.w,
                  height: 120.h,
                  child: CustomPaint(
                    painter: TechnicalGaugePainter(),
                    size: Size(200.w, 120.h),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Buy',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          GestureDetector(
            onTap: () {
              // Navigate to more technical analysis
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'More technicals',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketOrderBook() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Book',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Bids',
                      style: GoogleFonts.inter(
                        color: Colors.green,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...List.generate(5, (index) {
                      final price = widget.crypto.currentPrice * (1 - (index + 1) * 0.001);
                      final volume = (math.Random().nextDouble() * 10).toStringAsFixed(2);
                      return _buildOrderBookRow(
                        '\$${price.toStringAsFixed(2)}',
                        volume,
                        Colors.green.withValues(alpha: 0.1),
                        Colors.green,
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Asks',
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...List.generate(5, (index) {
                      final price = widget.crypto.currentPrice * (1 + (index + 1) * 0.001);
                      final volume = (math.Random().nextDouble() * 10).toStringAsFixed(2);
                      return _buildOrderBookRow(
                        '\$${price.toStringAsFixed(2)}',
                        volume,
                        Colors.red.withValues(alpha: 0.1),
                        Colors.red,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBookRow(String price, String volume, Color bgColor, Color textColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            price,
            style: GoogleFonts.inter(
              color: textColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            volume,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalAnalysisSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Analysis',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildTechnicalIndicator('RSI (14)', '67.2', 'Neutral'),
          _buildTechnicalIndicator('MACD', '0.45', 'Bullish'),
          _buildTechnicalIndicator('Moving Average (20)', '\$${(widget.crypto.currentPrice * 0.98).toStringAsFixed(2)}', 'Above'),
        ],
      ),
    );
  }

  Widget _buildTechnicalIndicator(String name, String value, String signal) {
    Color signalColor = signal == 'Bullish' || signal == 'Above' ? Colors.green : 
                       signal == 'Bearish' || signal == 'Below' ? Colors.red : Colors.orange;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
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
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorsSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
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
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _availableIndicators.map((indicator) {
              final isSelected = _selectedIndicators.contains(indicator);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedIndicators.remove(indicator);
                    } else {
                      _selectedIndicators.add(indicator);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected ? _getCryptoColor().withValues(alpha: 0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  ),
                  child: Text(
                    indicator,
                    style: GoogleFonts.inter(
                      color: isSelected ? _getCryptoColor() : Colors.grey[400],
                      fontSize: 12.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Sentiment',
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
                child: _buildSentimentItem('Fear & Greed', '72', 'Greed', Colors.green),
              ),
              Expanded(
                child: _buildSentimentItem('Social Score', '8.4', 'Bullish', Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentItem(String label, String value, String sentiment, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          sentiment,
          style: GoogleFonts.inter(
            color: color,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsItem(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sample News Title ${index + 1}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This is a sample news description for ${widget.crypto.name} related news item.',
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '2 hours ago',
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCryptoColor() {
    switch (widget.crypto.symbol.toLowerCase()) {
      case 'btc':
        return const Color(0xFFF7931A);
      case 'eth':
        return const Color(0xFF627EEA);
      case 'ada':
        return const Color(0xFF0033AD);
      case 'sol':
        return const Color(0xFF9945FF);
      case 'dot':
        return const Color(0xFFE6007A);
      case 'matic':
        return const Color(0xFF8247E5);
      case 'avax':
        return const Color(0xFFE84142);
      case 'atom':
        return const Color(0xFF2E3148);
      default:
        return const Color(0xFF6C5CE7);
    }
  }

  void _openFullChartScreen() {
    Get.toNamed(
      AppRoutes.cryptoChartDetails,
      arguments: widget.crypto,
    );
  }

  void _navigateToBuyScreen() {
    Get.to(
      () => BlocProvider(
        create: (context) => serviceLocator<CryptoCubit>(),
        child: BuyCryptoScreen(selectedCrypto: widget.crypto),
      ),
      transition: Transition.rightToLeft,
    );
  }

  void _navigateToSellScreen() {
    Get.to(
      () => BlocProvider(
        create: (context) => serviceLocator<CryptoCubit>(),
        child: const SellCryptoScreen(),
      ),
      transition: Transition.rightToLeft,
    );
  }
}

class TechnicalGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 10;
    
    // Paint for the gauge background
    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    
    // Draw gauge segments
    const double startAngle = math.pi; // Start from left (180 degrees)
    const double sweepAngle = math.pi; // Half circle (180 degrees)
    const int segments = 5;
    const double segmentAngle = sweepAngle / segments;
    
    // Colors for each segment: Strong Sell, Sell, Neutral, Buy, Strong Buy
    final colors = [
      const Color(0xFFE53E3E), // Strong Sell - Red
      const Color(0xFFFF6B6B), // Sell - Light Red
      const Color(0xFFFFBE0B), // Neutral - Yellow
      const Color(0xFF38A169), // Buy - Green
      const Color(0xFF2D7D32), // Strong Buy - Dark Green
    ];
    
    // Draw each segment
    for (int i = 0; i < segments; i++) {
      backgroundPaint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + (i * segmentAngle),
        segmentAngle,
        false,
        backgroundPaint,
      );
    }
    
    // Draw needle pointing to "Buy" position (4th segment)
    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    
    // Calculate needle angle (pointing to Buy position - 4th segment)
    final needleAngle = startAngle + (3.2 * segmentAngle); // Slightly into the Buy segment
    final needleLength = radius - 30;
    
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(needleAngle),
      center.dy + needleLength * math.sin(needleAngle),
    );
    
    // Draw needle line
    canvas.drawLine(center, needleEnd, needlePaint);
    
    // Draw needle center circle
    canvas.drawCircle(center, 8, needlePaint);
    
    // Draw labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    final labels = ['Strong sell', 'Sell', 'Neutral', 'Buy', 'Strong buy'];
    
    for (int i = 0; i < labels.length; i++) {
      final labelAngle = startAngle + (i * segmentAngle) + (segmentAngle / 2);
      final labelRadius = radius + 25;
      final labelPosition = Offset(
        center.dx + labelRadius * math.cos(labelAngle),
        center.dy + labelRadius * math.sin(labelAngle),
      );
      
      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          labelPosition.dx - textPainter.width / 2,
          labelPosition.dy - textPainter.height / 2,
        ),
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 