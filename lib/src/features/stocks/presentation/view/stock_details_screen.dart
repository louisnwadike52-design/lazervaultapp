import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../../domain/entities/stock_entity.dart';
import '../widgets/technical_indicators_bottom_sheet.dart';
import '../widgets/analyst_ratings_section.dart';
import '../widgets/stock_events_section.dart';
import '../widgets/advanced_chart_widget.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/navigation/invest_route_args.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

class StockDetailsScreen extends StatefulWidget {
  final Stock stock;
  final String? investCollectionId;

  const StockDetailsScreen({
    super.key,
    required this.stock,
    this.investCollectionId,
  });

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> with TickerProviderStateMixin {
  late final InvestAssetHubConfig _hub =
      InvestAssetHubConfig.forCollectionId(widget.investCollectionId);

  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<String> _timeframes = ['1D', '1W', '1M', '3M', '6M', '1Y', '5Y', 'Max'];
  String _selectedTimeframe = '1M';
  bool _isInWatchlist = false;
  // Technical Indicators
  List<String> _selectedIndicators = [];
  final List<String> _availableIndicators = [
    'SMA', 'EMA', 'MACD', 'RSI', 'Bollinger Bands', 'Volume', 'Stochastic'
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupTabController();
    _loadStockDetails();
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

  void _loadStockDetails() {
    context.read<StockCubit>().loadStockDetails(widget.stock.symbol);
    context.read<StockCubit>().loadAnalystRatings(widget.stock.symbol);
    context.read<StockCubit>().loadStockEvents(widget.stock.symbol);
  }

  void _openTradeFlow(OrderSide side) {
    var stock = widget.stock;
    final st = context.read<StockCubit>().state;
    if (st is StockDetailsLoaded && st.stock.symbol == widget.stock.symbol) {
      stock = st.stock;
    }
    Get.toNamed(
      AppRoutes.stockTradeAmount,
      arguments: {
        'stock': stock,
        'tradeType': side == OrderSide.buy ? 'buy' : 'sell',
        ...InvestRouteArgs.hub(widget.investCollectionId),
      },
    );
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
      backgroundColor: InvestTradingUi.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: InvestTradingUi.scaffoldGradient,
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
                    _buildFinancialsTab(),
                    _buildNewsTab(),
                  ],
                ),
              ),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final accent = _hub.accentColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          children: [
            Material(
              color: InvestTradingUi.surfaceElevated,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 44.h,
                  width: 44.w,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: InvestTradingUi.textPrimary,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: InvestTradingUi.border),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: widget.stock.logoUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.stock.logoUrl,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => _logoFallback(),
                      )
                    : _logoFallback(),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _hub.heroEyebrow.toUpperCase(),
                    style: InvestTradingUi.eyebrow(accent),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.stock.symbol,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: InvestTradingUi.textPrimary,
                    ),
                  ),
                  Text(
                    widget.stock.name,
                    style: InvestTradingUi.labelMuted().copyWith(fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _toggleWatchlist,
              icon: Icon(
                _isInWatchlist ? Icons.star_rounded : Icons.star_outline_rounded,
                color: _isInWatchlist ? accent : InvestTradingUi.textPrimary,
                size: 26.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoFallback() {
    return ColoredBox(
      color: InvestTradingUi.surfaceElevated,
      child: Center(
        child: Text(
          widget.stock.symbol.isNotEmpty
              ? widget.stock.symbol[0].toUpperCase()
              : '?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: InvestTradingUi.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: _hub.accentColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: InvestTradingUi.textSecondary,
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp),
        indicatorPadding: EdgeInsets.all(4.w),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Financials'),
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
          _buildAnalystRatingsSection(),
          _buildStatsSection(),
          _buildEventsSection(),
          _buildCompanyAboutSection(),
        ],
      ),
    );
  }

  Widget _buildPriceHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: InvestTradingUi.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CurrencySymbols.formatAmountWithCurrency(
                widget.stock.currentPrice, widget.stock.currency),
            style: GoogleFonts.inter(
              color: InvestTradingUi.textPrimary,
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                widget.stock.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                              color: widget.stock.isPositive ? Colors.green : Colors.red,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${widget.stock.isPositive ? '+' : ''}\$${widget.stock.change.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: widget.stock.isPositive ? Colors.green : Colors.red,
                  fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
              SizedBox(width: 8.w),
                        Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: widget.stock.isPositive 
                                ? Colors.green.withValues(alpha: 0.2)
                                : Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                  '${widget.stock.changePercent >= 0 ? '+' : ''}${widget.stock.changePercent.toStringAsFixed(2)}%',
                            style: GoogleFonts.inter(
                              color: widget.stock.isPositive ? Colors.green : Colors.red,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
              SizedBox(width: 8.w),
              Text(
                '• Past 5 years',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
          SizedBox(height: 12.h),
          Text(
            'Market closed. Opens again at Jun 2 at 2:30 PM',
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          BlocBuilder<StockCubit, StockState>(
            builder: (context, state) {
              if (state is StockDetailsLoaded) {
                return AdvancedChartWidget(
                  priceHistory: state.priceHistory,
                  stock: state.stock,
                  selectedIndicators: _selectedIndicators,
                  timeframe: _selectedTimeframe,
                );
              }
              return SizedBox(
                height: 300.h,
                child: Center(child: CircularProgressIndicator(color: Colors.blue)),
              );
            },
          ),
          SizedBox(height: 16.h),
          _buildTimeframeSelector(),
          SizedBox(height: 12.h),
          _buildIndicatorControls(),
        ],
      ),
    );
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
                _loadStockDetails();
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
            'Data displayed is indicative only. Actual execution price may vary.',
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

  Widget _buildAnalystRatingsSection() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        return AnalystRatingsSection(
          stock: widget.stock,
          onSeeAll: () => Get.toNamed('/analyst-details', arguments: widget.stock),
        );
      },
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
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
              Text(
                'Stats',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed('/stock-stats', arguments: widget.stock),
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
          _buildStatItem('Market cap', _formatMarketCap(widget.stock.marketCap)),
          _buildStatItem('PE Ratio', widget.stock.peRatio.toStringAsFixed(2)),
          _buildStatItem('EPS', CurrencySymbols.formatAmountWithCurrency(widget.stock.eps, widget.stock.currency)),
          _buildStatItem('Dividend yield', '${widget.stock.dividendYield.toStringAsFixed(2)}%'),
          _buildStatItem('Beta (5Y monthly)', widget.stock.beta.toStringAsFixed(2)),
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

  Widget _buildEventsSection() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        return StockEventsSection(
          stock: widget.stock,
          onSeeAll: () => Get.toNamed('/stock-events', arguments: widget.stock),
        );
      },
    );
  }

  Widget _buildCompanyAboutSection() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.stock.name}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
              fontWeight: FontWeight.w700,
                ),
              ),
          SizedBox(height: 16.h),
          Text(
            widget.stock.description,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          _buildCompanyDetailsGrid(),
          SizedBox(height: 20.h),
          _buildKeyExecutives(),
          SizedBox(height: 20.h),
          _buildBusinessSegments(),
        ],
      ),
    );
  }

  Widget _buildCompanyDetailsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDetailItem('Founded', '1976')),
            SizedBox(width: 16.w),
            Expanded(child: _buildDetailItem('Headquarters', 'Cupertino, CA')),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildDetailItem('Employees', '164,000+')),
            SizedBox(width: 16.w),
            Expanded(child: _buildDetailItem('CEO', 'Tim Cook')),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildDetailItem('Exchange', 'NASDAQ')),
            SizedBox(width: 16.w),
            Expanded(child: _buildDetailItem('Website', 'apple.com')),
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

  Widget _buildKeyExecutives() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Executives',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        _buildExecutiveItem('Tim Cook', 'Chief Executive Officer'),
        _buildExecutiveItem('Luca Maestri', 'Chief Financial Officer'),
        _buildExecutiveItem('Katherine Adams', 'General Counsel'),
        _buildExecutiveItem('Deirdre O\'Brien', 'Senior VP, Retail + People'),
      ],
    );
  }

  Widget _buildExecutiveItem(String name, String position) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(16.r),
                  ),
            child: Icon(Icons.person, color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  position,
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
    );
  }

  Widget _buildBusinessSegments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Segments',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        _buildSegmentItem('iPhone', '52.4%', 'Primary revenue driver'),
        _buildSegmentItem('Services', '22.3%', 'App Store, iCloud, Apple Pay'),
        _buildSegmentItem('Mac', '10.4%', 'Desktop and laptop computers'),
        _buildSegmentItem('iPad', '8.8%', 'Tablet computers'),
        _buildSegmentItem('Wearables', '6.1%', 'Apple Watch, AirPods'),
      ],
    );
  }

  Widget _buildSegmentItem(String segment, String percentage, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              percentage,
              style: GoogleFonts.inter(
                color: Colors.blue,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  segment,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
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
    );
  }

  Widget _buildFinancialsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildFinancialSummary(),
          SizedBox(height: 16.h),
          _buildIncomeStatement(),
          SizedBox(height: 16.h),
          _buildBalanceSheet(),
          SizedBox(height: 16.h),
          _buildCashFlow(),
          SizedBox(height: 16.h),
          _buildFinancialRatios(),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Summary (TTM)',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: _buildFinancialMetric('Revenue', '\$394.33B', '+2.8%', true)),
              SizedBox(width: 16.w),
              Expanded(child: _buildFinancialMetric('Net Income', '\$99.80B', '+5.4%', true)),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildFinancialMetric('Gross Margin', '44.1%', '+0.5%', true)),
              SizedBox(width: 16.w),
              Expanded(child: _buildFinancialMetric('Operating Margin', '29.9%', '+1.2%', true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetric(String label, String value, String change, bool isPositive) {
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
              fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          change,
          style: GoogleFonts.inter(
            color: isPositive ? Colors.green : Colors.red,
            fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
    );
  }

  Widget _buildIncomeStatement() {
    return Container(
      padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income Statement',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
              ),
          SizedBox(height: 20.h),
          _buildFinancialRow('Total Revenue', '\$394.33B', '\$383.29B', '\$365.82B'),
          _buildFinancialRow('Cost of Revenue', '\$220.28B', '\$212.98B', '\$201.47B'),
          _buildFinancialRow('Gross Profit', '\$174.05B', '\$170.31B', '\$164.35B'),
          _buildFinancialRow('Operating Expenses', '\$56.29B', '\$51.35B', '\$47.11B'),
          _buildFinancialRow('Operating Income', '\$117.76B', '\$118.96B', '\$117.24B'),
          _buildFinancialRow('Net Income', '\$99.80B', '\$94.68B', '\$99.80B'),
          SizedBox(height: 12.h),
          _buildFinancialHeader(),
        ],
      ),
    );
  }

  Widget _buildFinancialHeader() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp),
          ),
        ),
        Expanded(
          child: Text(
            '2023',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            '2022',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            '2021',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialRow(String label, String val2023, String val2022, String val2021) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                      color: Colors.white,
                fontSize: 14.sp,
                    ),
            ),
          ),
          Expanded(
            child: Text(
              val2023,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
              textAlign: TextAlign.center,
                ),
              ),
          Expanded(
            child: Text(
              val2022,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              val2021,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 12.sp,
                ),
              textAlign: TextAlign.center,
            ),
                  ),
                ],
              ),
    );
  }

  Widget _buildBalanceSheet() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
            'Balance Sheet',
                      style: GoogleFonts.inter(
                        color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildFinancialRow('Total Assets', '\$352.76B', '\$352.76B', '\$351.00B'),
          _buildFinancialRow('Total Liabilities', '\$290.44B', '\$302.08B', '\$287.91B'),
          _buildFinancialRow('Total Equity', '\$62.15B', '\$50.67B', '\$63.09B'),
          _buildFinancialRow('Cash & Equivalents', '\$29.97B', '\$23.65B', '\$34.94B'),
          _buildFinancialRow('Total Debt', '\$109.28B', '\$120.07B', '\$124.72B'),
                  ],
                ),
    );
  }

  Widget _buildCashFlow() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cash Flow Statement',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildFinancialRow('Operating Cash Flow', '\$110.54B', '\$122.15B', '\$104.04B'),
          _buildFinancialRow('Investing Cash Flow', '\$-10.12B', '\$-22.35B', '\$-14.55B'),
          _buildFinancialRow('Financing Cash Flow', '\$-106.11B', '\$-110.75B', '\$-93.35B'),
          _buildFinancialRow('Free Cash Flow', '\$99.58B', '\$111.44B', '\$92.95B'),
        ],
      ),
    );
  }

  Widget _buildFinancialRatios() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Ratios',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: _buildRatioItem('P/E Ratio', '28.5')),
              SizedBox(width: 16.w),
              Expanded(child: _buildRatioItem('P/B Ratio', '39.4')),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildRatioItem('ROE', '162.4%')),
              SizedBox(width: 16.w),
              Expanded(child: _buildRatioItem('ROA', '28.3%')),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildRatioItem('Debt/Equity', '1.76')),
              SizedBox(width: 16.w),
              Expanded(child: _buildRatioItem('Current Ratio', '0.98')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatioItem(String label, String value) {
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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
          _buildAnalystReports(),
          SizedBox(height: 16.h),
          _buildCompanyAnnouncements(),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
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
                child: _buildSentimentItem('Bullish', '68%', Colors.green),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSentimentItem('Neutral', '22%', Colors.grey),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSentimentItem('Bearish', '10%', Colors.red),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Based on 1,247 social media mentions and analyst reports in the last 24 hours',
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

  Widget _buildRecentNews() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
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
            'Apple Announces Q4 2023 Results',
            'Apple reports record revenue of \$89.5 billion for Q4 2023, beating analyst expectations...',
            '2 hours ago',
            'Apple Inc.',
          ),
          _buildNewsItem(
            'iPhone 15 Sales Exceed Expectations',
            'Strong demand for iPhone 15 Pro models drives higher than expected sales in launch quarter...',
            '4 hours ago',
            'Reuters',
        ),
          _buildNewsItem(
            'Apple Services Revenue Hits New High',
            'Services division reports \$22.3 billion in revenue, marking 16% year-over-year growth...',
            '6 hours ago',
            'TechCrunch',
          ),
          _buildNewsItem(
            'Vision Pro Production Ramp Up',
            'Apple increases Vision Pro production ahead of early 2024 launch, sources confirm...',
            '8 hours ago',
            'Bloomberg',
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
          if (headline != 'Vision Pro Production Ramp Up') ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.grey[700], height: 1),
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalystReports() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(
            'Latest Analyst Reports',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildAnalystReportItem(
            'Morgan Stanley',
            'Overweight',
            '\$220',
            'Maintains positive outlook on Services growth and iPhone cycle',
            '1 day ago',
            Colors.green,
                  ),
          _buildAnalystReportItem(
            'Goldman Sachs',
            'Buy',
            '\$210',
            'Raises price target citing strong Vision Pro potential',
            '3 days ago',
            Colors.green,
                  ),
          _buildAnalystReportItem(
            'JPMorgan',
            'Neutral',
            '\$185',
            'Cautious on near-term iPhone demand in China market',
            '5 days ago',
            Colors.grey,
                  ),
        ],
      ),
    );
  }

  Widget _buildAnalystReportItem(
    String firm,
    String rating,
    String target,
    String summary,
    String time,
    Color ratingColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Icons.analytics, color: Colors.white, size: 20.sp),
              ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      firm,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: ratingColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        rating,
                        style: GoogleFonts.inter(
                          color: ratingColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                  ),
                ),
              ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  summary,
                  style: GoogleFonts.inter(
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'PT: $target',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '• $time',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 11.sp,
                  ),
                ),
              ],
                ),
            ],
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyAnnouncements() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company Announcements',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              ),
            ),
          SizedBox(height: 20.h),
          _buildAnnouncementItem(
            'Quarterly Earnings Call',
            'Nov 2, 2023 • 5:00 PM EST',
            Icons.phone,
            'Join the live earnings call for Q4 2023 results',
          ),
          _buildAnnouncementItem(
            'Developer Conference 2024',
            'June 10-14, 2024 • Cupertino',
            Icons.code,
            'WWDC 2024 registration now open for developers',
          ),
          _buildAnnouncementItem(
            'Sustainability Report',
            'Oct 15, 2023',
            Icons.eco,
            'Apple releases 2023 Environmental Progress Report',
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementItem(String title, String date, IconData icon, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(icon, color: Colors.blue, size: 20.sp),
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

  Widget _buildActionButtons() {
    if (!_hub.showTradeQuickActions) {
      return const SizedBox.shrink();
    }
    return InvestTradingUi.buySellBar(
      onSell: () => _openTradeFlow(OrderSide.sell),
      onBuy: () => _openTradeFlow(OrderSide.buy),
    );
  }

  // Helper methods
  String _formatMarketCap(double marketCap) {
    if (marketCap >= 1000000000000) {
      return '${CurrencySymbols.getSymbol(widget.stock.currency)}${(marketCap / 1000000000000).toStringAsFixed(2)}T';
    } else if (marketCap >= 1000000000) {
      return '${CurrencySymbols.getSymbol(widget.stock.currency)}${(marketCap / 1000000000).toStringAsFixed(2)}B';
    }
    return '${CurrencySymbols.getSymbol(widget.stock.currency)}${(marketCap / 1000000).toStringAsFixed(2)}M';
  }

  void _toggleWatchlist() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });
  }

  void _showIndicatorSelector() {
    Get.bottomSheet(
      TechnicalIndicatorsBottomSheet(
        availableIndicators: _availableIndicators,
        selectedIndicators: _selectedIndicators,
        onIndicatorsChanged: (indicators) {
          setState(() {
            _selectedIndicators = indicators;
          });
        },
      ),
    );
  }
} 