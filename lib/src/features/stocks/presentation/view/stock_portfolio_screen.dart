import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../../domain/entities/stock_entity.dart';
import 'stock_details_screen.dart';
import '../../../../../core/utils/currency_formatter.dart';

/// Bamboo-style Portfolio Screen
/// Clean, minimal design with portfolio summary, holdings list, and performance metrics
class StockPortfolioScreen extends StatefulWidget {
  const StockPortfolioScreen({super.key});

  @override
  State<StockPortfolioScreen> createState() => _StockPortfolioScreenState();
}

class _StockPortfolioScreenState extends State<StockPortfolioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedSort = 'value';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPortfolio();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadPortfolio() {
    context.read<StockCubit>().loadPortfolio();
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
              const Color(0xFF1A0A2E),
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
                    _buildHoldingsTab(),
                    _buildAnalyticsTab(),
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
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        final portfolioValue = state is PortfolioLoaded
            ? state.portfolio.totalValue
            : 0.0;
        final dayChange = state is PortfolioLoaded
            ? state.portfolio.dayChange
            : 0.0;
        final dayChangePercent = state is PortfolioLoaded
            ? state.portfolio.dayChangePercent
            : 0.0;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Portfolio',
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Your stock holdings',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      onPressed: _loadPortfolio,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildPortfolioSummary(portfolioValue, dayChange, dayChangePercent),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPortfolioSummary(double value, double dayChange, double dayChangePercent) {
    final isPositive = dayChange >= 0;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF4F46E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Value',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            CurrencySymbols.formatAmountWithCurrency(value, 'NGN'),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: (isPositive
                      ? Colors.green
                      : Colors.red).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${isPositive ? '+' : ''}${CurrencySymbols.formatAmountWithCurrency(dayChange.abs(), 'NGN')}',
                      style: GoogleFonts.inter(
                        color: isPositive ? Colors.green : Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Today: ${isPositive ? '+' : ''}${dayChangePercent.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        labelColor: Colors.white.withValues(alpha: 0.7),
        unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp),
        indicatorPadding: EdgeInsets.all(4.w),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Holdings'),
          Tab(text: 'Analytics'),
        ],
      ),
    );
  }

  Widget _buildHoldingsTab() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return _buildLoadingState();
        }

        if (state is PortfolioError) {
          return _buildErrorState(state.message);
        }

        final holdings = state is PortfolioLoaded
            ? state.portfolio.holdings
            : <StockHolding>[];

        if (holdings.isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            _buildSortBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: holdings.length,
                itemBuilder: (context, index) {
                  return _buildHoldingCard(holdings[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnalyticsTab() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        final portfolio = state is PortfolioLoaded
            ? state.portfolio
            : null;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              _buildAnalyticsCard('Performance', [
                _buildAnalyticsItem('Today\'s Return',
                    portfolio?.dayChangePercent ?? 0.0, '%'),
                _buildAnalyticsItem('Total Return',
                    portfolio?.totalReturnPercent ?? 0.0, '%'),
                _buildAnalyticsItem('Dividend Income',
                    portfolio?.dividendIncome ?? 0.0, 'NGN'),
              ]),
              SizedBox(height: 16.h),
              _buildAnalyticsCard('Allocation', [
                _buildAnalyticsItem('Stocks',
                    portfolio?.stockCount ?? 0, 'stocks'),
                _buildAnalyticsItem('Total Invested',
                    portfolio?.totalInvested ?? 0.0, 'NGN'),
              ]),
              SizedBox(height: 16.h),
              _buildSectorBreakdown(portfolio),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnalyticsCard(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAnalyticsItem(String label, double value, String suffix) {
    final isPositive = suffix == '%' ? value >= 0 : true;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            suffix == '%' || suffix == 'NGN'
                ? '${isPositive && suffix == '%' ? '+' : ''}${value.toStringAsFixed(2)}$suffix'
                : '${value.toInt()} $suffix',
            style: GoogleFonts.inter(
              color: suffix == '%'
                  ? (isPositive ? Colors.green : Colors.red)
                  : Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectorBreakdown(Portfolio? portfolio) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sector Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSectorItem('Technology', 45, Colors.blue),
          _buildSectorItem('Finance', 25, Colors.green),
          _buildSectorItem('Healthcare', 15, Colors.red),
          _buildSectorItem('Consumer', 10, Colors.orange),
          _buildSectorItem('Others', 5, Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSectorItem(String name, int percentage, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '$percentage%',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          Text(
            'Sort by:',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 8.w),
          _buildSortChip('Value', 'value'),
          SizedBox(width: 8.w),
          _buildSortChip('Name', 'name'),
          SizedBox(width: 8.w),
          _buildSortChip('Change', 'change'),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = _selectedSort == value;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedSort = value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected
                ? const Color(0xFF6366F1)
                : Colors.white.withValues(alpha: 0.7),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHoldingCard(StockHolding holding) {
    final stock = holding.stock;
    final isPositive = holding.dayChangePercent >= 0;
    final totalValue = holding.quantity * stock.currentPrice;
    final totalCost = holding.quantity * holding.averagePrice;
    final totalGain = totalValue - totalCost;
    final totalGainPercent = totalCost > 0 ? (totalGain / totalCost) * 100 : 0.0;

    return GestureDetector(
      onTap: () => Get.to(() => StockDetailsScreen(stock: stock)),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6366F1).withValues(alpha: 0.3),
                    const Color(0xFF4F46E5).withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  stock.symbol.substring(0, 2).toUpperCase(),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6366F1),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
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
                    stock.symbol,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${holding.quantity} shares',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencySymbols.formatAmountWithCurrency(totalValue, stock.currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: (totalGainPercent >= 0
                        ? Colors.green
                        : Colors.red).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '${totalGainPercent >= 0 ? '+' : ''}${totalGainPercent.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: totalGainPercent >= 0 ? Colors.green : Colors.red,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFF6366F1),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading portfolio...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.show_chart,
              size: 40.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No holdings yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start investing to build your portfolio',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Explore Stocks',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: Colors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            'Error loading portfolio',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _loadPortfolio,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper classes for Portfolio
class StockHolding {
  final Stock stock;
  final int quantity;
  final double averagePrice;
  final double dayChangePercent;

  StockHolding({
    required this.stock,
    required this.quantity,
    required this.averagePrice,
    required this.dayChangePercent,
  });
}

class Portfolio {
  final double totalValue;
  final double dayChange;
  final double dayChangePercent;
  final double totalReturnPercent;
  final double totalInvested;
  final double dividendIncome;
  final int stockCount;
  final List<StockHolding> holdings;

  Portfolio({
    required this.totalValue,
    required this.dayChange,
    required this.dayChangePercent,
    required this.totalReturnPercent,
    required this.totalInvested,
    required this.dividendIncome,
    required this.stockCount,
    required this.holdings,
  });
}
