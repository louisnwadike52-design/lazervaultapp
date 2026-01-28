import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../cubit/crypto_cubit.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../../../../core/types/app_routes.dart';

class CryptoDetailsScreen extends StatefulWidget {
  final Crypto crypto;

  const CryptoDetailsScreen({
    super.key,
    required this.crypto,
  });

  @override
  State<CryptoDetailsScreen> createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<String> _timeframes = ['1H', '4H', '1D', '1W', '1M', '3M', '6M', '1Y', 'ALL'];
  String _selectedTimeframe = '1D';
  bool _isInWatchlist = false;
  final bool _showIndicators = false;
  
  // Technical Indicators
  final List<String> _selectedIndicators = [];
  final List<String> _availableIndicators = [
    'SMA', 'EMA', 'MACD', 'RSI', 'Bollinger Bands', 'Volume', 'Stochastic'
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
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  void _setupTabController() {
    _tabController = TabController(length: 3, vsync: this);
  }

  void _loadCryptoDetails() {
    context.read<CryptoCubit>().loadCryptoDetails(widget.crypto.id);
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
      padding: EdgeInsets.all(16.w),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
      decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
              Container(
              width: 40.w,
              height: 40.h,
                decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.currency_bitcoin,
                color: Colors.white,
                size: 24.sp,
                ),
              ),
            SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                  children: [
                    Text(
                        widget.crypto.symbol.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                      ),
                    ),
                      SizedBox(width: 8.w),
                    Text(
                        '• ${widget.crypto.name}',
                      style: GoogleFonts.inter(
                          color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                  ),
                  Text(
                    'Rank #${widget.crypto.marketCapRank}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 12.sp,
                ),
              ),
            ],
          ),
            ),
            IconButton(
              onPressed: _toggleWatchlist,
              icon: Icon(
                _isInWatchlist ? Icons.notifications : Icons.notifications_outlined,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            IconButton(
              onPressed: _toggleWatchlist,
              icon: Icon(
                _isInWatchlist ? Icons.star : Icons.star_outline,
                color: Colors.white,
                size: 24.sp,
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
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp),
        indicatorPadding: EdgeInsets.all(4.w),
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
          _buildMarketStatsSection(),
          _buildPerformanceSection(),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildPriceHeader() {
    final isPositive = widget.crypto.priceChangePercentage24h >= 0;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$${widget.crypto.currentPrice.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${isPositive ? '+' : ''}\$${widget.crypto.priceChange24h.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPositive 
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${widget.crypto.priceChangePercentage24h >= 0 ? '+' : ''}${widget.crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: GoogleFonts.inter(
                  color: isPositive ? Colors.green : Colors.red,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                ),
              ),
              ),
              SizedBox(width: 8.w),
              Text(
                '• Past 24 hours',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Market is open 24/7 • Real-time data',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedChart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 300.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white.withValues(alpha: 0.1),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.white.withValues(alpha: 0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          '${value.toInt()}h',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 10.sp,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1000,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          '\$${(value / 1000).toStringAsFixed(0)}k',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 10.sp,
                          ),
                        );
                      },
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 23,
                minY: widget.crypto.currentPrice * 0.95,
                maxY: widget.crypto.currentPrice * 1.05,
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateChartData(),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C5CE7),
                        const Color(0xFF8B7CF6),
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
                          const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          const Color(0xFF6C5CE7).withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildTimeframeSelector(),
          SizedBox(height: 12.h),
          _buildIndicatorControls(),
        ],
      ),
    );
  }

  List<FlSpot> _generateChartData() {
    final basePrice = widget.crypto.currentPrice;
    final List<FlSpot> spots = [];
    
    for (int i = 0; i <= 23; i++) {
      final variation = (i % 3 == 0 ? 0.02 : -0.01) * (i % 2 == 0 ? 1 : -1);
      final price = basePrice * (1 + variation);
      spots.add(FlSpot(i.toDouble(), price));
    }
    
    return spots;
  }

  Widget _buildTimeframeSelector() {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: _timeframes.map((timeframe) {
          final isSelected = _selectedTimeframe == timeframe;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTimeframe = timeframe;
                });
                _loadCryptoDetails();
              },
              child: Container(
                margin: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Center(
                  child: Text(
                    timeframe,
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.black : Colors.grey[400],
                      fontSize: 12.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIndicatorControls() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Data displayed is real-time. Past performance is not indicative of future results.',
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 11.sp,
            ),
          ),
        ),
        IconButton(
          onPressed: () => _showIndicatorSelector(),
          icon: Icon(
            Icons.analytics_outlined,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(25.r),
              ),
          child: ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.cryptoTrade, arguments: {
                  'crypto': widget.crypto,
                  'tradeType': 'sell',
                }),
            style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  'Sell',
                  style: GoogleFonts.inter(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.buyCrypto, arguments: widget.crypto),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                    'Buy',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
          ),
          SizedBox(width: 12.w),
        Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF6C5CE7), width: 2),
                borderRadius: BorderRadius.circular(25.r),
              ),
          child: ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.cryptoTrade, arguments: {
                  'crypto': widget.crypto,
                  'tradeType': 'swap',
                }),
            style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  'Swap',
                    style: GoogleFonts.inter(
                    color: const Color(0xFF6C5CE7),
                      fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                    ),
                  ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildMarketStatsSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
        children: [
          Text(
            'Market Stats',
            style: GoogleFonts.inter(
              color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showMoreStats(),
                child: Text(
                  'See all',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildStatItem('Market cap', _formatMarketCap(widget.crypto.marketCap)),
          _buildStatItem('24h Volume', '\$${_formatLargeNumber(widget.crypto.totalVolume)}'),
          _buildStatItem('Circulating Supply', '${_formatLargeNumber(widget.crypto.circulatingSupply)} ${widget.crypto.symbol}'),
          if (widget.crypto.maxSupply != null)
            _buildStatItem('Max Supply', '${_formatLargeNumber(widget.crypto.maxSupply!)} ${widget.crypto.symbol}'),
          _buildStatItem('24h High', '\$${widget.crypto.high24h.toStringAsFixed(2)}'),
          _buildStatItem('24h Low', '\$${widget.crypto.low24h.toStringAsFixed(2)}'),
          if (widget.crypto.ath != null)
            _buildStatItem('All-Time High', '\$${widget.crypto.ath!.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildPerformanceItem('1 Hour', widget.crypto.priceChangePercentage24h * 0.04),
          _buildPerformanceItem('24 Hours', widget.crypto.priceChangePercentage24h),
          if (widget.crypto.priceChangePercentage7d != null)
            _buildPerformanceItem('7 Days', widget.crypto.priceChangePercentage7d!),
          if (widget.crypto.priceChangePercentage30d != null)
            _buildPerformanceItem('30 Days', widget.crypto.priceChangePercentage30d!),
          if (widget.crypto.priceChangePercentage1y != null)
            _buildPerformanceItem('1 Year', widget.crypto.priceChangePercentage1y!),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String timeframe, double changePercent) {
    final isPositive = changePercent >= 0;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            timeframe,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.crypto.name}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            _getAboutText(widget.crypto.id),
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          _buildTechDetailsGrid(),
          SizedBox(height: 20.h),
          _buildKeyMetrics(),
        ],
      ),
    );
  }

  Widget _buildTechDetailsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDetailItem('Algorithm', _getAlgorithm(widget.crypto.id))),
            SizedBox(width: 16.w),
            Expanded(child: _buildDetailItem('Block Time', _getBlockTime(widget.crypto.id))),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildDetailItem('Consensus', _getConsensus(widget.crypto.id))),
            SizedBox(width: 16.w),
            Expanded(child: _buildDetailItem('Total Supply', _formatLargeNumber(widget.crypto.totalSupply ?? 0))),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
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

  Widget _buildKeyMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildMetricItem('Volatility (30d)', '${(widget.crypto.priceChangePercentage30d?.abs() ?? 15.0).toStringAsFixed(1)}%')),
            SizedBox(width: 16.w),
            Expanded(child: _buildMetricItem('Market Dominance', '${((widget.crypto.marketCap / 2500000000000) * 100).toStringAsFixed(2)}%')),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildMetricItem('ROI (1Y)', '${(widget.crypto.priceChangePercentage1y ?? 0.0).toStringAsFixed(1)}%')),
            SizedBox(width: 16.w),
            Expanded(child: _buildMetricItem('Sharpe Ratio', (1.2 + (widget.crypto.priceChangePercentage24h / 100)).toStringAsFixed(2))),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricItem(String label, String value) {
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

  String _formatLargeNumber(double number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(2)}T';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}M';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String _formatMarketCap(double marketCap) {
    if (marketCap >= 1e12) {
      return '${(marketCap / 1e12).toStringAsFixed(2)}T';
    } else if (marketCap >= 1e9) {
      return '${(marketCap / 1e9).toStringAsFixed(2)}B';
    } else if (marketCap >= 1e6) {
      return '${(marketCap / 1e6).toStringAsFixed(2)}M';
    } else if (marketCap >= 1e3) {
      return '${(marketCap / 1e3).toStringAsFixed(2)}K';
    } else {
      return marketCap.toStringAsFixed(2);
    }
  }

  String _getAboutText(String cryptoId) {
    switch (cryptoId) {
      case 'bitcoin':
        return 'Bitcoin is the world\'s first and largest cryptocurrency by market capitalization. It was created by an unknown person or group using the pseudonym Satoshi Nakamoto in 2009.';
      case 'ethereum':
        return 'Ethereum is a decentralized platform that runs smart contracts and enables developers to build and deploy decentralized applications (DApps).';
      case 'binancecoin':
        return 'BNB is the native cryptocurrency of the Binance ecosystem, originally created to pay fees on the Binance exchange with discounts.';
      default:
        return 'This cryptocurrency is a digital asset designed to work as a medium of exchange using cryptography to secure transactions.';
    }
  }

  String _getAlgorithm(String cryptoId) {
    switch (cryptoId) {
      case 'bitcoin':
        return 'SHA-256';
      case 'ethereum':
        return 'Ethash';
      case 'binancecoin':
        return 'SHA-256';
      default:
        return 'Unknown';
    }
  }

  String _getBlockTime(String cryptoId) {
    switch (cryptoId) {
      case 'bitcoin':
        return '10 minutes';
      case 'ethereum':
        return '12 seconds';
      case 'binancecoin':
        return '3 seconds';
      default:
        return 'Unknown';
    }
  }

  String _getConsensus(String cryptoId) {
    switch (cryptoId) {
      case 'bitcoin':
        return 'Proof of Work';
      case 'ethereum':
        return 'Proof of Work';
      case 'binancecoin':
        return 'Proof of Stake';
      default:
        return 'Unknown';
    }
  }

  void _toggleWatchlist() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });
  }

  void _showIndicatorSelector() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Text(
                'Technical Indicators',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: _availableIndicators.length,
                itemBuilder: (context, index) {
                  final indicator = _availableIndicators[index];
                  final isSelected = _selectedIndicators.contains(indicator);
                  return CheckboxListTile(
                    title: Text(
                      indicator,
                style: GoogleFonts.inter(color: Colors.white),
                    ),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedIndicators.add(indicator);
                        } else {
                          _selectedIndicators.remove(indicator);
                        }
                      });
                    },
                    activeColor: const Color(0xFF6C5CE7),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreStats() {
    Get.toNamed(AppRoutes.cryptoDetails, arguments: widget.crypto);
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildMarketSentiment(),
          SizedBox(height: 16.h),
          _buildTechnicalAnalysis(),
          SizedBox(height: 16.h),
          _buildRiskMetrics(),
          SizedBox(height: 16.h),
          _buildSocialSentiment(),
        ],
      ),
    );
  }

  Widget _buildMarketSentiment() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Sentiment',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                child: _buildSentimentItem('Bullish', '72%', Colors.green),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSentimentItem('Neutral', '18%', Colors.grey),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSentimentItem('Bearish', '10%', Colors.red),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Based on 2,847 social media mentions and market indicators in the last 24 hours',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentItem(String label, String percentage, Color color) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
                      child: Text(
              percentage,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
                        style: GoogleFonts.inter(
                          color: Colors.white,
            fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
      ],
    );
  }

  Widget _buildTechnicalAnalysis() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Analysis',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildTechnicalIndicator('RSI (14)', '68.5', 'Neutral', Colors.orange),
          _buildTechnicalIndicator('MACD', 'Bullish', 'Buy Signal', Colors.green),
          _buildTechnicalIndicator('SMA (50)', '\$${(widget.crypto.currentPrice * 0.95).toStringAsFixed(2)}', 'Above', Colors.green),
          _buildTechnicalIndicator('Support Level', '\$${(widget.crypto.currentPrice * 0.92).toStringAsFixed(2)}', 'Strong', Colors.blue),
          _buildTechnicalIndicator('Resistance Level', '\$${(widget.crypto.currentPrice * 1.08).toStringAsFixed(2)}', 'Moderate', Colors.red),
        ],
      ),
    );
  }

  Widget _buildTechnicalIndicator(String indicator, String value, String signal, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                indicator,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                  fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              signal,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskMetrics() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Risk Analysis',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildRiskItem('Volatility Risk', 'High', Colors.red),
          _buildRiskItem('Liquidity Risk', 'Low', Colors.green),
          _buildRiskItem('Market Risk', 'Medium', Colors.orange),
          _buildRiskItem('Correlation (BTC)', (0.85 + (widget.crypto.priceChangePercentage24h / 1000)).toStringAsFixed(2), Colors.blue),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSentiment() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Sentiment',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildSocialMetric('Twitter Mentions', '1,247', '+18%'),
          _buildSocialMetric('Reddit Discussions', '892', '+12%'),
          _buildSocialMetric('News Articles', '156', '+24%'),
          _buildSocialMetric('Google Trends', '78/100', '+5%'),
        ],
      ),
    );
  }

  Widget _buildSocialMetric(String platform, String count, String change) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            platform,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              Text(
                count,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                change,
                style: GoogleFonts.inter(
                  color: Colors.green,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildMarketSentiment(),
          SizedBox(height: 16.h),
          _buildRecentNews(),
          SizedBox(height: 16.h),
          _buildCryptoUpdates(),
        ],
      ),
    );
  }

  Widget _buildRecentNews() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Recent News',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Text(
                'See all',
                style: GoogleFonts.inter(
                  color: Colors.green,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildNewsItem(
            '${widget.crypto.name} Shows Strong Momentum',
            'Latest market analysis indicates positive trends for ${widget.crypto.symbol.toUpperCase()} with increased institutional interest...',
            '2 hours ago',
            'CryptoNews',
          ),
          _buildNewsItem(
            'Major Exchange Lists ${widget.crypto.symbol.toUpperCase()}',
            'Leading cryptocurrency exchange announces support for ${widget.crypto.name} trading pairs...',
            '5 hours ago',
            'CoinDesk',
          ),
          _buildNewsItem(
            'Technical Upgrade Announced',
            '${widget.crypto.name} development team announces major protocol upgrade scheduled for next quarter...',
            '8 hours ago',
            'CryptoDaily',
          ),
          _buildNewsItem(
            'Market Analysis: ${widget.crypto.symbol.toUpperCase()} Outlook',
            'Professional traders share insights on ${widget.crypto.name} price movements and future prospects...',
            '12 hours ago',
            'TradingView',
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(String headline, String summary, String time, String source) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            summary,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                source,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '•',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                time,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          if (headline != 'Market Analysis: ${widget.crypto.symbol.toUpperCase()} Outlook') ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.grey[700], height: 1),
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }

  Widget _buildCryptoUpdates() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Protocol Updates',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildUpdateItem(
            'Network Upgrade v2.1',
            'Dec 15, 2023',
            Icons.upgrade,
            'Major performance improvements and security enhancements',
          ),
          _buildUpdateItem(
            'Partnership Announcement',
            'Nov 28, 2023',
            Icons.handshake,
            'Strategic partnership with leading DeFi protocol',
          ),
          _buildUpdateItem(
            'Staking Rewards Update',
            'Nov 20, 2023',
            Icons.account_balance_wallet,
            'Increased staking rewards and reduced lock-up periods',
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String title, String date, IconData icon, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(icon, color: const Color(0xFF6C5CE7), size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 