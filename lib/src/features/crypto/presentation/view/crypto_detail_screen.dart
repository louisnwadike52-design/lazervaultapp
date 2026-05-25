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
import '../widgets/asset_wallet_sheet.dart';
import 'buy_crypto_screen.dart';
import 'sell_crypto_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';

/// Controls which action buttons appear on the detail screen.
enum CryptoDetailEntryMode { full, buyOnly, sellOnly }

class CryptoDetailScreen extends StatefulWidget {
  final Crypto crypto;
  final CryptoDetailEntryMode entryMode;

  const CryptoDetailScreen({
    super.key,
    required this.crypto,
    this.entryMode = CryptoDetailEntryMode.full,
  });

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
    // Hydrate the bookmark state from the crypto entity the caller passed
    // in — otherwise the icon always renders empty on first frame even
    // when the asset is already in the user's watchlist. The cubit
    // refreshes this when CryptosLoaded re-emits (the BlocBuilder below
    // listens), but we still need a sane initial value for this frame.
    _isInWatchlist = widget.crypto.isFavorite;
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
                // Persist to backend
                context.read<CryptoCubit>().toggleFavorite(widget.crypto.id);
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
          Tab(text: 'News'),
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
              SizedBox(height: 8.h),
              _buildKeyDataPoints(),
              _buildMarketStats(),
              _buildPortfolioSection(),
              _buildAboutSection(),
              SizedBox(height: 24.h),
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
              // "Show wallet" CTA at the right end of the asset header
              // row — opens AssetWalletSheet without leaving the details
              // page. Richer pill with gradient + chevron so it reads as
              // a primary action, not just a tag.
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => showAssetWalletSheet(
                    context,
                    cryptoSymbol: widget.crypto.symbol,
                    cryptoName: widget.crypto.name,
                    currentPrice: widget.crypto.currentPrice,
                    priceChange24hPct: widget.crypto.priceChangePercentage24h,
                    imageUrl: widget.crypto.image,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 78, 3, 208),
                          const Color.fromARGB(255, 78, 3, 208)
                              .withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 78, 3, 208)
                              .withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white.withValues(alpha: 0.95),
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Show wallet',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.95),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: 14.sp,
                        ),
                      ],
                    ),
                  ),
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
    final showBuy = widget.entryMode == CryptoDetailEntryMode.full ||
        widget.entryMode == CryptoDetailEntryMode.buyOnly;
    final showSell = widget.entryMode == CryptoDetailEntryMode.full ||
        widget.entryMode == CryptoDetailEntryMode.sellOnly;

    return Container(
      margin: EdgeInsets.all(16.w),
      child: Row(
        children: [
          if (showBuy)
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
          if (showBuy && showSell) SizedBox(width: 12.w),
          if (showSell)
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
    final sym = CurrencySymbols.currentSymbol;
    return _statsCard(
      headerIcon: Icons.account_balance_rounded,
      title: 'Market statistics',
      subtitle: 'Snapshot of supply & liquidity',
      children: [
        _statTile(
          icon: Icons.pie_chart_rounded,
          label: 'Market cap',
          value: widget.crypto.marketCap > 0
              ? '$sym${_formatLargeNumber(widget.crypto.marketCap)}'
              : '—',
        ),
        _statTile(
          icon: Icons.show_chart_rounded,
          label: '24h volume',
          value: widget.crypto.totalVolume > 0
              ? '$sym${_formatLargeNumber(widget.crypto.totalVolume)}'
              : '—',
        ),
        _statTile(
          icon: Icons.donut_small_rounded,
          label: 'Circulating supply',
          value: widget.crypto.circulatingSupply > 0
              ? _formatLargeNumber(widget.crypto.circulatingSupply)
              : '—',
        ),
        if (widget.crypto.ath != null)
          _statTile(
            icon: Icons.trending_up_rounded,
            iconTint: const Color(0xFF10B981),
            label: 'All-time high',
            value: '$sym${widget.crypto.ath!.toStringAsFixed(2)}',
          ),
      ],
    );
  }

  Widget _buildKeyDataPoints() {
    final sym = CurrencySymbols.currentSymbol;
    return _statsCard(
      headerIcon: Icons.bar_chart_rounded,
      title: 'Key data points',
      subtitle: 'The numbers that matter today',
      children: [
        _statTile(
          icon: Icons.arrow_upward_rounded,
          iconTint: const Color(0xFF10B981),
          label: '24h high',
          value: widget.crypto.high24h > 0
              ? '$sym${widget.crypto.high24h.toStringAsFixed(2)}'
              : '—',
        ),
        _statTile(
          icon: Icons.arrow_downward_rounded,
          iconTint: const Color(0xFFEF4444),
          label: '24h low',
          value: widget.crypto.low24h > 0
              ? '$sym${widget.crypto.low24h.toStringAsFixed(2)}'
              : '—',
        ),
        if (widget.crypto.marketCapRank > 0)
          _statTile(
            icon: Icons.workspace_premium_rounded,
            iconTint: _accent,
            label: 'Market cap rank',
            value: '#${widget.crypto.marketCapRank}',
          ),
        if (widget.crypto.ath != null)
          _statTile(
            icon: Icons.flag_rounded,
            iconTint: const Color(0xFF10B981),
            label: 'All-time high',
            value: '$sym${widget.crypto.ath!.toStringAsFixed(2)}',
          ),
        if (widget.crypto.atl != null)
          _statTile(
            icon: Icons.outlined_flag_rounded,
            iconTint: const Color(0xFFEF4444),
            label: 'All-time low',
            value: '$sym${widget.crypto.atl!.toStringAsFixed(2)}',
          ),
      ],
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
          return _statsCard(
            headerIcon: Icons.account_balance_wallet_rounded,
            title: 'Your portfolio',
            subtitle: 'No ${widget.crypto.symbol.toUpperCase()} holdings yet',
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: _accent.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: _accent.withValues(alpha: 0.30)),
                      ),
                      child: Icon(Icons.add_chart_rounded,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: 18.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start trading',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Buy ${widget.crypto.symbol.toUpperCase()} to see your '
                            'cost basis and P&L appear here.',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11.sp,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        final pnlColor = userHolding.totalGainLoss >= 0
            ? const Color(0xFF10B981)
            : const Color(0xFFEF4444);
        final sym = CurrencySymbols.currentSymbol;

        return _statsCard(
          headerIcon: Icons.account_balance_wallet_rounded,
          title: 'Your portfolio',
          subtitle:
              '${widget.crypto.symbol.toUpperCase()} position summary',
          children: [
            _statTile(
              icon: Icons.scale_rounded,
              label: 'Holdings',
              value:
                  '${userHolding.quantity.toStringAsFixed(6)} ${userHolding.cryptoSymbol.toUpperCase()}',
            ),
            _statTile(
              icon: Icons.attach_money_rounded,
              label: 'Value',
              value: '$sym${userHolding.totalValue.toStringAsFixed(2)}',
            ),
            _statTile(
              icon: Icons.price_change_rounded,
              label: 'Avg. cost',
              value: '$sym${userHolding.averagePrice.toStringAsFixed(2)}',
            ),
            _statTile(
              icon: userHolding.totalGainLoss >= 0
                  ? Icons.trending_up_rounded
                  : Icons.trending_down_rounded,
              iconTint: pnlColor,
              label: 'Profit & loss',
              valueWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${userHolding.totalGainLoss >= 0 ? '+' : '-'}'
                    '$sym${userHolding.totalGainLoss.abs().toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: pnlColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            // P&L pct bar — full width pill, semantic color.
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: pnlColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: pnlColor.withValues(alpha: 0.30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    userHolding.totalGainLoss >= 0
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    color: pnlColor,
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${userHolding.totalGainLossPercentage >= 0 ? '+' : ''}'
                    '${userHolding.totalGainLossPercentage.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: pnlColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'all-time',
                    style: GoogleFonts.inter(
                      color: pnlColor.withValues(alpha: 0.75),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // ─── Stats tab refactor ──────────────────────────────────────────
  // Both stats sections share a single card shell with the joint-funds
  // visual language: deep-purple gradient wash, purple accent rail at
  // the top edge, dim-purple border, soft shadow. Each row is broken
  // out into a reusable widget with an icon, label, and right-aligned
  // value — no more awkward wrapping when the value is long (notably
  // Day's Range which used to break across two lines).
  static const _accent = Color.fromARGB(255, 78, 3, 208);

  Widget _statsCard({
    required IconData headerIcon,
    required String title,
    required String? subtitle,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _accent.withValues(alpha: 0.10),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
            color: _accent.withValues(alpha: 0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header strip — icon chip, title, optional subtitle.
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 14.h),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _accent,
                        _accent.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: _accent.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(headerIcon,
                      color: Colors.white, size: 18.sp),
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
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Hairline divider against the gradient wash.
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 18.w),
            color: Colors.white.withValues(alpha: 0.06),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 16.h),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStatsSection() {
    final sym = CurrencySymbols.currentSymbol;
    final low24 = widget.crypto.low24h;
    final high24 = widget.crypto.high24h;
    return _statsCard(
      headerIcon: Icons.insights_rounded,
      title: 'Key data points',
      subtitle: '24h market snapshot',
      children: [
        _statTile(
          icon: Icons.show_chart_rounded,
          label: 'Volume',
          value: _formatLargeNumber(widget.crypto.totalVolume),
        ),
        _statTile(
          icon: Icons.swap_vert_rounded,
          label: "Day's range",
          stackValue: true,
          // Stacked under the label so the low → high pair always
          // fits, even on narrow widths and when one side jumps a
          // digit count vs the other.
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  low24 > 0 ? '$sym${low24.toStringAsFixed(2)}' : '—',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(Icons.arrow_forward_rounded,
                  color: Colors.white.withValues(alpha: 0.5), size: 12.sp),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  high24 > 0 ? '$sym${high24.toStringAsFixed(2)}' : '—',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (widget.crypto.ath != null)
          _statTile(
            icon: Icons.trending_up_rounded,
            iconTint: const Color(0xFF10B981),
            label: 'All-time high',
            value: '$sym${widget.crypto.ath!.toStringAsFixed(2)}',
          ),
        if (widget.crypto.atl != null)
          _statTile(
            icon: Icons.trending_down_rounded,
            iconTint: const Color(0xFFEF4444),
            label: 'All-time low',
            value: '$sym${widget.crypto.atl!.toStringAsFixed(2)}',
          ),
        if (widget.crypto.marketCapRank > 0)
          _statTile(
            icon: Icons.workspace_premium_rounded,
            iconTint: _accent,
            label: 'Market cap rank',
            value: '#${widget.crypto.marketCapRank}',
          ),
      ],
    );
  }

  // Single row in a stats card. Pass either `value` (string) for simple
  // text, or `valueWidget` for richer content (e.g. the Day's Range mini
  // row). Icons get a 28pt tinted chip on the left — the joint-funds
  // pattern — so the column reads as a list rather than a wall of text.
  //
  // `stackValue: true` lays the value out under the label, full width.
  // Use for compound values like Day's Range that don't fit beside the
  // label on narrow widths.
  Widget _statTile({
    required IconData icon,
    required String label,
    String? value,
    Widget? valueWidget,
    Color? iconTint,
    bool stackValue = false,
  }) {
    final tint = iconTint ?? Colors.white.withValues(alpha: 0.65);
    if (stackValue) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: tint, size: 15.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: valueWidget ??
                        Text(
                          value ?? '—',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: tint, size: 15.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child: valueWidget ??
                  Text(
                    value ?? '—',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        ],
      ),
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
    final entries = <MapEntry<String, double?>>[
      MapEntry('24 hours', widget.crypto.priceChangePercentage24h),
      MapEntry('7 days', widget.crypto.priceChangePercentage7d),
      MapEntry('30 days', widget.crypto.priceChangePercentage30d),
      MapEntry('1 year', widget.crypto.priceChangePercentage1y),
    ];
    return _statsCard(
      headerIcon: Icons.timeline_rounded,
      title: 'Price performance',
      subtitle: 'Change over time',
      children: [
        for (var i = 0; i < entries.length; i++)
          if (entries[i].value != null) ...[
            _perfRow(entries[i].key, entries[i].value!),
            if (i < entries.length - 1 && _hasMoreNonNullAfter(entries, i))
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                color: Colors.white.withValues(alpha: 0.04),
              ),
          ],
      ],
    );
  }

  bool _hasMoreNonNullAfter(
      List<MapEntry<String, double?>> entries, int after) {
    for (var i = after + 1; i < entries.length; i++) {
      if (entries[i].value != null) return true;
    }
    return false;
  }

  // Performance row: timeframe on the left, magnitude bar in the middle,
  // signed pct pill on the right. The bar gives a visual sense of move
  // size relative to a sane upper bound (50%) so the user can compare
  // 1y to 24h at a glance.
  Widget _perfRow(String timeframe, double pct) {
    final isPositive = pct >= 0;
    final color =
        isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final magnitude = (pct.abs() / 50).clamp(0.04, 1.0);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 70.w,
            child: Text(
              timeframe,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Stack(
                  children: [
                    Container(
                      height: 6.h,
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                    FractionallySizedBox(
                      widthFactor: magnitude,
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.4),
                              color,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: color,
                  size: 12.sp,
                ),
                SizedBox(width: 2.w),
                Text(
                  '${pct.abs().toStringAsFixed(2)}%',
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    final hasRank = widget.crypto.marketCapRank > 0;
    final desc = hasRank
        ? 'Trade ${widget.crypto.name} (${widget.crypto.symbol.toUpperCase()}) '
            'securely through LazerVault with our SEC-licensed partner Quidax. '
            '${widget.crypto.name} is ranked #${widget.crypto.marketCapRank} '
            'by market capitalisation.'
        : 'Trade ${widget.crypto.name} (${widget.crypto.symbol.toUpperCase()}) '
            'securely through LazerVault with our SEC-licensed partner Quidax.';

    return _statsCard(
      headerIcon: Icons.info_outline_rounded,
      title: 'About ${widget.crypto.name}',
      subtitle: 'Powered by Quidax, regulated in Nigeria',
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Text(
            desc,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 13.sp,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            _buildAboutChip(
              label: widget.crypto.symbol.toUpperCase(),
              icon: Icons.tag_rounded,
            ),
            if (hasRank)
              _buildAboutChip(
                label: 'Rank #${widget.crypto.marketCapRank}',
                icon: Icons.workspace_premium_rounded,
              ),
            _buildAboutChip(
              label: 'Quidax custodied',
              icon: Icons.verified_user_rounded,
              tint: const Color(0xFF10B981),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutChip({
    required String label,
    required IconData icon,
    Color? tint,
  }) {
    final color = tint ?? _accent;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12.sp),
          SizedBox(width: 5.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsTab() {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is CryptoDetailsLoaded && state.isLoadingNews) {
          return _buildNewsShimmer();
        }

        final news = state is CryptoDetailsLoaded ? state.news : <CryptoNews>[];

        if (news.isEmpty) {
          return _buildNewsEmpty();
        }

        // Sentiment summary chips above the feed give the user a
        // quick read on the prevailing tone before they scan items.
        final pos = news.where((n) => n.sentiment == 'positive').length;
        final neg = news.where((n) => n.sentiment == 'negative').length;
        final neu = news.length - pos - neg;

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          itemCount: news.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildNewsHeader(news.length, pos, neg, neu);
            }
            return _buildNewsItem(news[index - 1]);
          },
        );
      },
    );
  }

  Widget _buildNewsHeader(int total, int pos, int neg, int neu) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _accent.withValues(alpha: 0.18),
            _accent.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _accent.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.newspaper_rounded,
                    color: Colors.white, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest news',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '$total ${total == 1 ? 'story' : 'stories'} on ${widget.crypto.name}',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              _sentimentSummaryChip(
                  count: pos,
                  label: 'Positive',
                  color: const Color(0xFF10B981)),
              SizedBox(width: 8.w),
              _sentimentSummaryChip(
                  count: neu,
                  label: 'Neutral',
                  color: Colors.white.withValues(alpha: 0.55)),
              SizedBox(width: 8.w),
              _sentimentSummaryChip(
                  count: neg,
                  label: 'Negative',
                  color: const Color(0xFFEF4444)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sentimentSummaryChip({
    required int count,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: color.withValues(alpha: 0.30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: _accent.withValues(alpha: 0.25)),
              ),
              child: Icon(Icons.newspaper_rounded,
                  size: 28.sp, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 16.h),
            Text(
              'No news yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Stories about ${widget.crypto.name} will show up here as they break.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(CryptoNews newsItem) {
    final sentimentColor = switch (newsItem.sentiment) {
      'positive' => const Color(0xFF10B981),
      'negative' => const Color(0xFFEF4444),
      _ => Colors.white.withValues(alpha: 0.55),
    };
    final sentimentIcon = switch (newsItem.sentiment) {
      'positive' => Icons.trending_up_rounded,
      'negative' => Icons.trending_down_rounded,
      _ => Icons.remove_rounded,
    };

    final timeAgo = _formatTimeAgo(newsItem.publishedAt);
    final hasVotes =
        newsItem.votesPositive > 0 || newsItem.votesNegative > 0;

    return GestureDetector(
      onTap: () {
        // Open news URL in browser (wired by caller via url_launcher
        // when enabled; intentionally a no-op here to keep scope tight).
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sentiment spine — vertical accent bar on the left,
              // colored by the article's tone. Reads at a glance.
              Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: sentimentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    bottomLeft: Radius.circular(14.r),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: sentimentColor.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                  color: sentimentColor.withValues(alpha: 0.30)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(sentimentIcon,
                                    color: sentimentColor, size: 11.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  newsItem.sentiment.isEmpty
                                      ? 'neutral'
                                      : newsItem.sentiment,
                                  style: GoogleFonts.inter(
                                    color: sentimentColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            timeAgo,
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.45),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        newsItem.title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.public_rounded,
                              size: 12.sp,
                              color: Colors.white.withValues(alpha: 0.5)),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Text(
                              newsItem.source,
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (hasVotes) ...[
                            SizedBox(width: 8.w),
                            _newsVoteChip(
                                icon: Icons.thumb_up_alt_rounded,
                                count: newsItem.votesPositive,
                                color: const Color(0xFF10B981)),
                            SizedBox(width: 6.w),
                            _newsVoteChip(
                                icon: Icons.thumb_down_alt_rounded,
                                count: newsItem.votesNegative,
                                color: const Color(0xFFEF4444)),
                          ],
                        ],
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

  Widget _newsVoteChip({
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10.sp, color: color.withValues(alpha: 0.85)),
          SizedBox(width: 3.w),
          Text(
            '$count',
            style: GoogleFonts.inter(
              color: color.withValues(alpha: 0.85),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsShimmer() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      itemCount: 5,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        height: 110.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  bottomLeft: Radius.circular(14.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 12.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 12.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(4.r),
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

  String _formatTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${(diff.inDays / 7).floor()}w ago';
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
        child: BuyCryptoScreen(selectedCrypto: widget.crypto, lockAsset: true),
      ),
      transition: Transition.rightToLeft,
    );
  }

  void _navigateToSellScreen() {
    // Look up user's holding for this crypto
    final cubitState = context.read<CryptoCubit>().state;
    CryptoHolding? holding;
    if (cubitState is CryptosLoaded) {
      holding = cubitState.holdings.cast<CryptoHolding?>().firstWhere(
        (h) => h?.cryptoId == widget.crypto.id ||
            h?.cryptoSymbol.toLowerCase() == widget.crypto.symbol.toLowerCase(),
        orElse: () => null,
      );
    }
    Get.to(
      () => BlocProvider(
        create: (context) => serviceLocator<CryptoCubit>(),
        child: SellCryptoScreen(
          selectedHolding: holding,
          lockHolding: holding != null,
        ),
      ),
      transition: Transition.rightToLeft,
    );
  }
} 