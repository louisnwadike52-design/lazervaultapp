import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../../domain/entities/stock_entity.dart';
import '../widgets/stock_search_bar.dart';
import 'stock_details_screen.dart';
import 'buy_stock_screen.dart';
import 'sell_stock_screen.dart';
import 'stock_portfolio_screen.dart';
import 'stock_orders_screen.dart';
import 'stock_watchlist_screen.dart';

/// Modern stocks main screen - Bamboo-style UX with purple theme
/// Main entry point following Bamboo app design patterns
class StocksMainScreen extends StatefulWidget {
  const StocksMainScreen({super.key});

  @override
  State<StocksMainScreen> createState() => _StocksMainScreenState();
}

class _StocksMainScreenState extends State<StocksMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() {
    context.read<StockCubit>().loadDashboard();
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
              const Color(0xFF1A0A2E), // Purple dark
              const Color(0xFF0F0F23), // Dark background
              const Color(0xFF0A0A1A), // Almost black
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
                    _buildDiscoverTab(),
                    _buildPortfolioTab(),
                    _buildOrdersTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildVoiceButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          // Back Button
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 16.w),
          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stocks',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Invest in global markets',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // Search Button
          GestureDetector(
            onTap: () {
              setState(() => _isSearching = !_isSearching);
              if (!_isSearching) {
                _searchController.clear();
              }
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Notifications
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
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
          Tab(text: 'Discover'),
          Tab(text: 'Portfolio'),
          Tab(text: 'Orders'),
        ],
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return BlocConsumer<StockCubit, StockState>(
      listener: (context, state) {
        if (state is StockError && !_isSearching) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: Colors.red[700],
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is StockLoading) {
          return _buildLoadingState();
        }

        final stocks = state is StockLoaded ? state.stocks : <Stock>[];
        final portfolio = state is PortfolioLoaded ? state.portfolio : null;
        final indices = state is MarketIndicesLoaded ? state.indices : {};

        return RefreshIndicator(
          onRefresh: () async {
            _loadData();
          },
          backgroundColor: const Color(0xFF1E293B),
          color: const Color(0xFF6366F1),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              if (_isSearching) ...[
                SizedBox(height: 16.h),
                _buildSearchResults(stocks),
              ] else ...[
                SizedBox(height: 8.h),
                if (portfolio != null) _buildPortfolioCard(portfolio),
                SizedBox(height: 16.h),
                _buildQuickActions(),
                SizedBox(height: 24.h),
                _buildMarketIndices(indices),
                SizedBox(height: 24.h),
                _buildTopMovers(stocks),
                SizedBox(height: 24.h),
                _buildTrendingStocks(stocks),
                SizedBox(height: 24.h),
                _buildWatchlistPreview(),
                SizedBox(height: 40.h),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildPortfolioTab() {
    return StockPortfolioScreen();
  }

  Widget _buildOrdersTab() {
    return StockOrdersScreen();
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
            'Loading market data...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioCard(Portfolio portfolio) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6366F1), // Purple primary
            Color(0xFF4F46E5), // Purple dark
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
            'Portfolio Value',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${CurrencySymbols.formatAmountWithCurrency(portfolio.totalValue, 'NGN')}',
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
                  color: (portfolio.totalReturnPercent >= 0
                      ? Colors.green
                      : Colors.red).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      portfolio.totalReturnPercent >= 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: portfolio.totalReturnPercent >= 0
                          ? Colors.green
                          : Colors.red,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${portfolio.totalReturnPercent >= 0 ? '+' : ''}${portfolio.totalReturnPercent.toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        color: portfolio.totalReturnPercent >= 0
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Today: ${portfolio.dayChangePercent >= 0 ? '+' : ''}${portfolio.dayChangePercent.toStringAsFixed(2)}%',
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

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickAction(
            icon: Icons.add_circle_outline,
            label: 'Buy',
            color: Colors.green,
            onTap: () => Get.to(() => const BuyStockScreen()),
          ),
          _buildQuickAction(
            icon: Icons.remove_circle_outline,
            label: 'Sell',
            color: Colors.red,
            onTap: () => Get.to(() => const SellStockScreen()),
          ),
          _buildQuickAction(
            icon: Icons.account_balance_wallet,
            label: 'Portfolio',
            color: const Color(0xFF6366F1),
            onTap: () => _tabController.animateTo(1),
          ),
          _buildQuickAction(
            icon: Icons.receipt_long,
            label: 'Orders',
            color: const Color(0xFFF59E0B),
            onTap: () => _tabController.animateTo(2),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketIndices(Map<String, double> indices) {
    if (indices.isEmpty) {
      return _buildEmptyCard('Market Overview', Icons.show_chart, 'Market data unavailable');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Market Overview',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'See all',
              style: GoogleFonts.inter(
                color: const Color(0xFF6366F1),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: indices.entries.map((entry) => _buildIndexCard(entry.key, entry.value)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildIndexCard(String name, double value) {
    final isPositive = value >= 0;
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value.toStringAsFixed(2),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 12.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                '0.0%',
                style: GoogleFonts.inter(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopMovers(List<Stock> stocks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Movers',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'See all',
              style: GoogleFonts.inter(
                color: const Color(0xFF6366F1),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildMoverTab('Gainers', true),
              ),
              Expanded(
                child: _buildMoverTab('Losers', false),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stocks.take(5).length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return _buildMoverCard(stock);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMoverTab(String label, bool isGainers) {
    return GestureDetector(
      onTap: () {
        // Filter by gainers/losers
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMoverCard(Stock stock) {
    return GestureDetector(
      onTap: () => Get.to(() => StockDetailsScreen(stock: stock)),
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Text(
                      stock.symbol.substring(0, 2).toUpperCase(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: (stock.changePercent >= 0
                        ? Colors.green
                        : Colors.red).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '${stock.changePercent >= 0 ? '+' : ''}${stock.changePercent.toStringAsFixed(1)}%',
                    style: GoogleFonts.inter(
                      color: stock.changePercent >= 0 ? Colors.green : Colors.red,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              stock.symbol,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              CurrencySymbols.formatAmountWithCurrency(stock.currentPrice, stock.currency),
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingStocks(List<Stock> stocks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Stocks',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        ...stocks.take(5).map((stock) => _buildStockListItem(stock)),
      ],
    );
  }

  Widget _buildStockListItem(Stock stock) {
    return GestureDetector(
      onTap: () => Get.to(() => StockDetailsScreen(stock: stock)),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10.r),
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    stock.name,
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
                  CurrencySymbols.formatAmountWithCurrency(stock.currentPrice, stock.currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      stock.changePercent >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: stock.changePercent >= 0 ? Colors.green : Colors.red,
                      size: 12.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${stock.changePercent >= 0 ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        color: stock.changePercent >= 0 ? Colors.green : Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistPreview() {
    return GestureDetector(
      onTap: () => Get.to(() => const StockWatchlistScreen()),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watchlist',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.bookmark_outline,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Add stocks to your watchlist to track their performance',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Stock> stocks) {
    if (stocks.isEmpty) {
      return _buildEmptyCard('No results', Icons.search_off, 'No stocks found');
    }
    return Column(
      children: stocks.map((stock) => _buildStockListItem(stock)).toList(),
    );
  }

  Widget _buildEmptyCard(String title, IconData icon, String message) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48.sp,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceButton() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF6366F1),
      onPressed: () {
        // Show voice input
      },
      child: Icon(Icons.mic, color: Colors.white, size: 24.sp),
    );
  }
}
