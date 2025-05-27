import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../../domain/entities/stock_entity.dart';
import '../../../../../core/types/app_routes.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({super.key});

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  final List<String> _sectors = ['All', 'Technology', 'Healthcare', 'Finance', 'Energy', 'Consumer'];
  String _selectedSector = 'All';
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupTabController();
    _loadInitialData();
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0F0F23),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  void _setupTabController() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
        _loadTabData(_selectedTab);
      }
    });
  }

  void _loadInitialData() {
    context.read<StockCubit>().loadStocks();
    context.read<StockCubit>().loadPortfolio();
    context.read<StockCubit>().loadMarketIndices();
  }

  void _loadTabData(int tabIndex) {
    final cubit = context.read<StockCubit>();
    switch (tabIndex) {
      case 0: // Stocks
        cubit.loadStocks(sector: _selectedSector == 'All' ? null : _selectedSector);
        break;
      case 1: // Portfolio
        cubit.loadPortfolio();
        cubit.loadHoldings();
        break;
      case 2: // Watchlist
        cubit.loadWatchlists();
        break;
      case 3: // Orders
        cubit.loadOrders();
        break;
      case 4: // News
        cubit.loadMarketNews();
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _searchController.dispose();
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
              _buildMarketOverview(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildStocksTab(),
                    _buildPortfolioTab(),
                    _buildWatchlistTab(),
                    _buildOrdersTab(),
                    _buildNewsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                icon: Icon(
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
                    'Stock Exchange',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Trade with confidence',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => _showSearchDialog(),
                icon: Icon(
                  Icons.search,
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

  Widget _buildMarketOverview() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.2), Colors.purple.withValues(alpha: 0.2)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: BlocBuilder<StockCubit, StockState>(
        builder: (context, state) {
          if (state is MarketIndicesLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Market Overview',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'LIVE',
                        style: GoogleFonts.inter(
                          color: Colors.green,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: state.indices.entries.take(2).map((entry) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: entry.key != state.indices.keys.last ? 8.w : 0),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              entry.value.toStringAsFixed(2),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }
          return Container(
            height: 80.h,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[500]!],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 12.sp),
        isScrollable: true,
        tabs: const [
          Tab(text: 'Stocks'),
          Tab(text: 'Portfolio'),
          Tab(text: 'Watchlist'),
          Tab(text: 'Orders'),
          Tab(text: 'News'),
        ],
      ),
    );
  }

  Widget _buildStocksTab() {
    return Column(
      children: [
        _buildSectorFilter(),
        Expanded(
          child: BlocBuilder<StockCubit, StockState>(
            builder: (context, state) {
              if (state is StockLoading) {
                return _buildLoadingState();
              } else if (state is StockLoaded) {
                return _buildStocksList(state.stocks);
              } else if (state is StockError) {
                return _buildErrorState(state.message);
              }
              return _buildEmptyState('No stocks available');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectorFilter() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: _sectors.length,
        itemBuilder: (context, index) {
          final sector = _sectors[index];
          final isSelected = _selectedSector == sector;
          
          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(sector),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedSector = sector;
                });
                context.read<StockCubit>().loadStocks(
                  sector: sector == 'All' ? null : sector,
                );
              },
              backgroundColor: Colors.grey[900],
              selectedColor: Colors.blue.withValues(alpha: 0.3),
              labelStyle: GoogleFonts.inter(
                color: isSelected ? Colors.blue : Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              side: BorderSide(
                color: isSelected ? Colors.blue : Colors.grey[700]!,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStocksList(List<Stock> stocks) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return _buildStockItem(stock);
      },
    );
  }

  Widget _buildStockItem(Stock stock) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => Get.toNamed(AppRoutes.stockDetails, arguments: stock),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: stock.logoUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.business, color: Colors.grey[600]),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            stock.symbol[0],
                            style: GoogleFonts.inter(
                              color: Colors.grey[600],
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        stock.name,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${stock.currentPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: stock.isPositive 
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${stock.isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          color: stock.isPositive ? Colors.green : Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioTab() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return _buildLoadingState();
        } else if (state is PortfolioLoaded) {
          return _buildPortfolioView(state.portfolio);
        } else if (state is PortfolioError) {
          return _buildErrorState(state.message);
        }
        return _buildEmptyState('No portfolio data available');
      },
    );
  }

  Widget _buildPortfolioView(Portfolio portfolio) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPortfolioSummary(portfolio),
          SizedBox(height: 24.h),
          _buildPortfolioChart(portfolio),
          SizedBox(height: 24.h),
          _buildHoldingsList(portfolio.holdings),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary(Portfolio portfolio) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.withValues(alpha: 0.2), Colors.blue.withValues(alpha: 0.2)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Value',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '\$${portfolio.totalValue.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioMetric(
                  'Total Return',
                  '\$${portfolio.totalReturn.toStringAsFixed(2)}',
                  '${portfolio.totalReturnPercent >= 0 ? '+' : ''}${portfolio.totalReturnPercent.toStringAsFixed(2)}%',
                  portfolio.totalReturnPercent >= 0,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildPortfolioMetric(
                  'Today',
                  '\$${portfolio.dayChange.toStringAsFixed(2)}',
                  '${portfolio.dayChangePercent >= 0 ? '+' : ''}${portfolio.dayChangePercent.toStringAsFixed(2)}%',
                  portfolio.dayChangePercent >= 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioMetric(String title, String value, String percentage, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            percentage,
            style: GoogleFonts.inter(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioChart(Portfolio portfolio) {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Allocation',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: portfolio.holdings.map((holding) {
                  final percentage = (holding.totalValue / portfolio.totalValue) * 100;
                  return PieChartSectionData(
                    value: percentage,
                    title: '${percentage.toStringAsFixed(1)}%',
                    color: _getColorForSymbol(holding.symbol),
                    radius: 50.r,
                    titleStyle: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList(),
                centerSpaceRadius: 40.r,
                sectionsSpace: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForSymbol(String symbol) {
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.red];
    return colors[symbol.hashCode % colors.length];
  }

  Widget _buildHoldingsList(List<StockHolding> holdings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Holdings',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        ...holdings.map((holding) => _buildHoldingItem(holding)).toList(),
      ],
    );
  }

  Widget _buildHoldingItem(StockHolding holding) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: _getColorForSymbol(holding.symbol).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                holding.symbol[0],
                style: GoogleFonts.inter(
                  color: _getColorForSymbol(holding.symbol),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
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
                  holding.symbol,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${holding.shares} shares',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
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
                '\$${holding.totalValue.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${holding.totalReturnPercent >= 0 ? '+' : ''}${holding.totalReturnPercent.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  color: holding.totalReturnPercent >= 0 ? Colors.green : Colors.red,
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

  Widget _buildWatchlistTab() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is WatchlistsLoading) {
          return _buildLoadingState();
        } else if (state is WatchlistsLoaded) {
          return _buildWatchlistView(state.watchlists);
        } else if (state is WatchlistsError) {
          return _buildErrorState(state.message);
        }
        return _buildEmptyState('No watchlists available');
      },
    );
  }

  Widget _buildWatchlistView(List<Watchlist> watchlists) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Watchlists',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateWatchlistDialog(),
                icon: Icon(Icons.add, size: 16.sp),
                label: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: watchlists.length,
            itemBuilder: (context, index) {
              final watchlist = watchlists[index];
              return _buildWatchlistItem(watchlist);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWatchlistItem(Watchlist watchlist) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  watchlist.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey[400]),
                color: const Color(0xFF2D2D2D),
                onSelected: (value) {
                  if (value == 'delete') {
                    context.read<StockCubit>().deleteWatchlist(watchlist.id);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: GoogleFonts.inter(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${watchlist.symbols.length} stocks',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
          if (watchlist.symbols.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: watchlist.symbols.map((symbol) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    symbol,
                    style: GoogleFonts.inter(
                      color: Colors.blue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return _buildLoadingState();
        } else if (state is OrdersLoaded) {
          return _buildOrdersView(state.orders);
        } else if (state is StockError) {
          return _buildErrorState(state.message);
        }
        return _buildEmptyState('No orders available');
      },
    );
  }

  Widget _buildOrdersView(List<StockOrder> orders) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderItem(order);
      },
    );
  }

  Widget _buildOrderItem(StockOrder order) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: order.side == OrderSide.buy 
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  order.side.toString().toUpperCase(),
                  style: GoogleFonts.inter(
                    color: order.side == OrderSide.buy ? Colors.green : Colors.red,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  order.symbol,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  order.status.toString().toUpperCase(),
                  style: GoogleFonts.inter(
                    color: _getStatusColor(order.status),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity: ${order.quantity}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                    if (order.price != null)
                      Text(
                        'Price: \$${order.price!.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ),
              if (order.status == OrderStatus.pending)
                TextButton(
                  onPressed: () => context.read<StockCubit>().cancelOrder(order.id),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.executed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.rejected:
        return Colors.red;
    }
  }

  Widget _buildNewsTab() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is MarketNewsLoading) {
          return _buildLoadingState();
        } else if (state is MarketNewsLoaded) {
          return _buildNewsView(state.news);
        } else if (state is MarketNewsError) {
          return _buildErrorState(state.message);
        }
        return _buildEmptyState('No news available');
      },
    );
  }

  Widget _buildNewsView(List<MarketNews> news) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: news.length,
      itemBuilder: (context, index) {
        final article = news[index];
        return _buildNewsItem(article);
      },
    );
  }

  Widget _buildNewsItem(MarketNews article) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: CachedNetworkImage(
              imageUrl: article.imageUrl,
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 150.h,
                color: Colors.grey[800],
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 150.h,
                color: Colors.grey[800],
                child: Icon(Icons.image, color: Colors.grey[600]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Text(
                  article.summary,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Text(
                      article.source,
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      _formatTime(article.publishedAt),
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 12.sp,
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

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
        strokeWidth: 2,
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
            color: Colors.red,
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Error',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => _loadTabData(_selectedTab),
            child: Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            color: Colors.grey[600],
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.stockTrade),
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Trade',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D2D2D),
        title: Text(
          'Search Stocks',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: TextField(
          controller: _searchController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter symbol or company name',
            hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: (query) {
            context.read<StockCubit>().searchStocks(query);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateWatchlistDialog() {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D2D2D),
        title: Text(
          'Create Watchlist',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: TextField(
          controller: nameController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Watchlist name',
            hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<StockCubit>().createWatchlist(nameController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
} 