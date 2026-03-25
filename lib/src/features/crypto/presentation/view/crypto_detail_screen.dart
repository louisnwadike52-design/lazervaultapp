import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/price_point.dart';
import '../../domain/entities/crypto_entity.dart' show CryptoHolding;
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

  final List<String> _timeframes = ['1D', '7D', '30D', '90D', '1Y', 'ALL'];
  String _selectedTimeframe = '1D';
  bool _isInWatchlist = false;

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
    _tabController = TabController(length: 2, vsync: this); // Changed from 3 to 2 tabs
  }

  void _loadCryptoDetails() {
    context.read<CryptoCubit>().loadCryptoDetails(widget.crypto.id, timeframe: _timeframeToRange(_selectedTimeframe));
  }

  String _timeframeToRange(String timeframe) {
    switch (timeframe) {
      case '1D': return '1';
      case '7D': return '7';
      case '30D': return '30';
      case '90D': return '90';
      case '1Y': return '365';
      case 'ALL': return 'max';
      default: return '7';
    }
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
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0A0A),
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
                    _buildStatsTab(),
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
          Tab(text: 'Stats'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        List<PricePoint> priceHistory = [];

        if (state is CryptoDetailsLoaded) {
          priceHistory = state.priceHistory;
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildPriceHeader(),
              _buildAdvancedChart(priceHistory),
              _buildActionButtons(),
              _buildKeyDataPoints(),
              _buildMarketStats(),
              _buildPortfolioSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildMarketStatsSection(),
          SizedBox(height: 16.h),
          _buildPerformanceSection(),
        ],
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
            '${CurrencySymbols.currentSymbol}${widget.crypto.currentPrice.toStringAsFixed(2)}',
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
                '(${CurrencySymbols.currentSymbol}${widget.crypto.priceChange24h.toStringAsFixed(2)})',
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

  Widget _buildAdvancedChart(List<PricePoint> priceHistory) {
    final chartData = _generateChartData(priceHistory);

    if (chartData.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: 320.h,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.show_chart,
                size: 48.sp,
                color: Colors.grey[600],
              ),
              SizedBox(height: 12.h),
              Text(
                'Chart data unavailable',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                      borderRadius: BorderRadius.circular(8.r),
                    ),
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
                      _loadCryptoDetails();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: isSelected ? _getCryptoColor().withValues(alpha: 0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
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
                    horizontalInterval: _calculateChartInterval(chartData),
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
                  maxX: (chartData.length - 1).toDouble().clamp(1, double.infinity),
                  minY: _getMinY(chartData),
                  maxY: _getMaxY(chartData),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
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
                            '${CurrencySymbols.currentSymbol}${barSpot.y.toStringAsFixed(2)}',
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

  List<FlSpot> _generateChartData(List<PricePoint> priceHistory) {
    if (priceHistory.isEmpty) {
      // Return empty list - will show empty state
      return [];
    }

    return priceHistory.asMap().entries.map((entry) {
      final index = entry.key;
      final point = entry.value;
      return FlSpot(index.toDouble(), point.price);
    }).toList();
  }

  double _calculateChartInterval(List<FlSpot> data) {
    if (data.isEmpty) return 1000;
    final prices = data.map((e) => e.y).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final range = maxPrice - minPrice;
    if (range == 0) return 1000;
    return range / 4;
  }

  double _getMinY(List<FlSpot> data) {
    if (data.isEmpty) return 0;
    final minPrice = data.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    return minPrice * 0.98;
  }

  double _getMaxY(List<FlSpot> data) {
    if (data.isEmpty) return 100000;
    final maxPrice = data.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return maxPrice * 1.02;
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

  Widget _buildKeyDataPoints() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Data Points',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDataPoint('24h High', widget.crypto.high24h > 0
              ? '${CurrencySymbols.currentSymbol}${widget.crypto.high24h.toStringAsFixed(2)}'
              : 'N/A'),
          _buildDataPoint('24h Low', widget.crypto.low24h > 0
              ? '${CurrencySymbols.currentSymbol}${widget.crypto.low24h.toStringAsFixed(2)}'
              : 'N/A'),
          _buildDataPoint('Market Cap Rank', '#${widget.crypto.marketCapRank}'),
          if (widget.crypto.ath != null)
            _buildDataPoint('All-Time High', '${CurrencySymbols.currentSymbol}${widget.crypto.ath!.toStringAsFixed(2)}'),
          if (widget.crypto.atl != null)
            _buildDataPoint('All-Time Low', '${CurrencySymbols.currentSymbol}${widget.crypto.atl!.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildDataPoint(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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

  Widget _buildPortfolioSection() {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is! CryptosLoaded) {
          return const SizedBox.shrink();
        }

        final holdings = state.holdings;
        final userHolding = holdings.cast<CryptoHolding?>().firstWhere(
          (h) => h?.cryptoId == widget.crypto.id,
          orElse: () => null,
        );

        if (userHolding == null) {
          return Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.grey[600],
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Your Portfolio',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.grey[600],
                        size: 32.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'No ${widget.crypto.symbol.toUpperCase()} holdings',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Start trading to see your portfolio here',
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
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

        final pnlColor = userHolding.totalGainLoss >= 0 ? Colors.green : Colors.red;

        return Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: _getCryptoColor(),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Your Portfolio',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _buildPortfolioItem('Holdings', '${userHolding.quantity.toStringAsFixed(6)} ${userHolding.cryptoSymbol.toUpperCase()}'),
                  ),
                  Expanded(
                    child: _buildPortfolioItem('Value', '${CurrencySymbols.currentSymbol}${userHolding.totalValue.toStringAsFixed(2)}'),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildPortfolioItem('Avg. Cost', '${CurrencySymbols.currentSymbol}${userHolding.averagePrice.toStringAsFixed(2)}'),
                  ),
                  Expanded(
                    child: _buildPortfolioItem(
                      'P&L',
                      '${CurrencySymbols.currentSymbol}${userHolding.totalGainLoss.abs().toStringAsFixed(2)}',
                      isPositive: userHolding.totalGainLoss >= 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: pnlColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      userHolding.totalGainLoss >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: pnlColor,
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${userHolding.totalGainLossPercentage >= 0 ? '+' : ''}${userHolding.totalGainLossPercentage.toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        color: pnlColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

  Widget _buildMarketStatsSection() {
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
          _buildDataPointRow('Volume', '${_formatLargeNumber(widget.crypto.totalVolume)}'),
          SizedBox(height: 16.h),
          _buildDataPointRow('Day\'s Range', '${CurrencySymbols.currentSymbol}${widget.crypto.low24h.toStringAsFixed(2)} — ${CurrencySymbols.currentSymbol}${widget.crypto.high24h.toStringAsFixed(2)}'),
          if (widget.crypto.ath != null) ...[
            SizedBox(height: 16.h),
            _buildDataPointRow('All-Time High', '${CurrencySymbols.currentSymbol}${widget.crypto.ath!.toStringAsFixed(2)}'),
          ],
          if (widget.crypto.atl != null) ...[
            SizedBox(height: 16.h),
            _buildDataPointRow('All-Time Low', '${CurrencySymbols.currentSymbol}${widget.crypto.atl!.toStringAsFixed(2)}'),
          ],
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

  String _formatLargeNumber(double number) {
    if (number >= 1e12) {
      return '${CurrencySymbols.currentSymbol}${(number / 1e12).toStringAsFixed(2)}T';
    } else if (number >= 1e9) {
      return '${CurrencySymbols.currentSymbol}${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${CurrencySymbols.currentSymbol}${(number / 1e6).toStringAsFixed(2)}M';
    } else if (number >= 1e3) {
      return '${CurrencySymbols.currentSymbol}${(number / 1e3).toStringAsFixed(2)}K';
    } else {
      return '${CurrencySymbols.currentSymbol}${number.toStringAsFixed(2)}';
    }
  }

  Widget _buildPerformanceSection() {
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
            'Price Performance',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
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

  Widget _buildStatRowItem(String label, String value) {
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
        return const Color.fromARGB(255, 78, 3, 208);
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