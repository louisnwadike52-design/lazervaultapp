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
import '../widgets/stock_action_bottom_sheet.dart';

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
  late ScrollController _tabScrollController;
  
  final TextEditingController _searchController = TextEditingController();
  final List<String> _sectors = ['All', 'Technology', 'Healthcare', 'Finance', 'Energy', 'Consumer'];
  final List<Map<String, String>> _countries = [
    {'code': 'ALL', 'name': 'All Markets', 'flag': '🌍'},
    {'code': 'US', 'name': 'United States', 'flag': '🇺🇸'},
    {'code': 'UK', 'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'code': 'CA', 'name': 'Canada', 'flag': '🇨🇦'},
    {'code': 'DE', 'name': 'Germany', 'flag': '🇩🇪'},
    {'code': 'JP', 'name': 'Japan', 'flag': '🇯🇵'},
    {'code': 'CN', 'name': 'China', 'flag': '🇨🇳'},
    {'code': 'IN', 'name': 'India', 'flag': '🇮🇳'},
    {'code': 'AU', 'name': 'Australia', 'flag': '🇦🇺'},
    {'code': 'BR', 'name': 'Brazil', 'flag': '🇧🇷'},
  ];
  String _selectedSector = 'All';
  String _selectedCountry = 'ALL';
  int _selectedTab = 0;
  bool _showGainers = true;

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
    _tabScrollController = ScrollController();
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
    // Load stocks with pagination for better performance
    context.read<StockCubit>().loadStocks(
      sector: _selectedSector == 'All' ? null : _selectedSector,
      limit: 10, // Load only 10 stocks initially for faster loading
    );
    
    // Load market indices first as they're lightweight
    context.read<StockCubit>().loadMarketIndices();
    
    // Load portfolio data asynchronously
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<StockCubit>().loadPortfolio();
      }
    });
  }

  void _loadMoreStocks() {
    // Load more stocks when needed
    context.read<StockCubit>().loadStocks(
      sector: _selectedSector == 'All' ? null : _selectedSector,
      limit: 20,
      page: 2, // Load next page
    );
  }

  void _loadTabData(int tabIndex) {
    final cubit = context.read<StockCubit>();
    switch (tabIndex) {
      case 0: // Stocks
        cubit.loadStocks(
          sector: _selectedSector == 'All' ? null : _selectedSector,
          limit: 15, // Optimized loading with smaller batch
        );
        break;
      case 1: // Portfolio
        // Load portfolio data asynchronously for better performance
        Future.microtask(() => cubit.loadPortfolio());
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) cubit.loadHoldings();
        });
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

  void _scrollTabsLeft() {
    final currentIndex = _tabController.index;
    if (currentIndex > 0) {
      _tabController.animateTo(
        currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollTabsRight() {
    final currentIndex = _tabController.index;
    if (currentIndex < _tabController.length - 1) {
      _tabController.animateTo(
        currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    _tabScrollController.dispose();
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
                onPressed: () => Get.offAllNamed(AppRoutes.investments),
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
                    'Stocks',
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
                onPressed: () => _showVoiceSheet(),
                icon: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => _showAIChatBottomSheet(),
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
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
          // Always show market data, fallback to mock data if not loaded
          final marketData = state is MarketIndicesLoaded 
              ? state.indices 
              : {
                  'S&P 500': 4567.89,
                  'NASDAQ': 14234.56,
                  'DOW': 34567.12,
                  'FTSE': 7234.56,
                  'NIKKEI': 28456.78,
                  'DAX': 15234.67,
                  'CAC 40': 6789.12,
                  'HANG SENG': 23456.89,
                };

          // Generate random percentage changes for demo
          final percentageChanges = {
            'S&P 500': 0.85,
            'NASDAQ': 1.23,
            'DOW': -0.45,
            'FTSE': 0.67,
            'NIKKEI': 1.12,
            'DAX': -0.23,
            'CAC 40': 0.89,
            'HANG SENG': -0.78,
          };

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
              SizedBox(
                height: 80.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: marketData.length,
                  itemBuilder: (context, index) {
                    final entry = marketData.entries.elementAt(index);
                    final change = percentageChanges[entry.key] ?? 0.0;
                    final isPositive = change >= 0;
                    
                    return Container(
                      width: 140.w,
                      margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isPositive 
                              ? Colors.green.withValues(alpha: 0.2)
                              : Colors.red.withValues(alpha: 0.2),
                        ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              entry.value.toStringAsFixed(2),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                  fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Icon(
                                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                    color: isPositive ? Colors.green : Colors.red,
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
                                    style: GoogleFonts.inter(
                                      color: isPositive ? Colors.green : Colors.red,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF4A90E2),
                    const Color(0xFF357ABD),
                    const Color(0xFF2E6BA8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              labelStyle: GoogleFonts.inter(
                fontSize: 13.sp, 
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              indicatorPadding: EdgeInsets.all(4.w),
              dividerColor: Colors.transparent,
        isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: [
                _buildStyledTab('Stocks', Icons.trending_up),
                _buildStyledTab('Portfolio', Icons.pie_chart),
                _buildStyledTab('Watchlist', Icons.bookmark),
                _buildStyledTab('Orders', Icons.receipt_long),
                _buildStyledTab('News', Icons.article),
              ],
            ),
          ),
          // Left scroll indicator
          if (_selectedTab > 0)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => _scrollTabsLeft(),
                child: Container(
                  width: 24.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFF2A2A3E).withValues(alpha: 0.9),
                        const Color(0xFF2A2A3E).withValues(alpha: 0.0),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // Right scroll indicator
          if (_selectedTab < 4)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => _scrollTabsRight(),
                child: Container(
                  width: 24.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        const Color(0xFF2A2A3E).withValues(alpha: 0.9),
                        const Color(0xFF2A2A3E).withValues(alpha: 0.0),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // Bottom scroll hint dots
          Positioned(
            bottom: 4.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  width: 4.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledTab(String text, IconData icon) {
    return Tab(
      height: 50.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp),
            SizedBox(width: 6.w),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget _buildStocksTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
      children: [
          _buildFiltersSection(),
          _buildTrendingSection(),
          _buildTopMoversSection(),
          _buildStocksSectionHeader(),
          BlocBuilder<StockCubit, StockState>(
            builder: (context, state) {
              if (state is StockLoading) {
                return Container(
                  height: 200.h,
                  child: _buildLoadingState(),
                );
              } else if (state is StockLoaded) {
                if (state.stocks.isEmpty) {
                  return Container(
                    height: 200.h,
                    child: _buildEmptyState('No stocks available'),
                  );
                }
                return _buildStocksListScrollable(state.stocks);
              } else if (state is StockError) {
                return Container(
                  height: 200.h,
                  child: _buildErrorState(state.message),
                );
              }
              // Show loading initially to trigger data load
              return Container(
                height: 200.h,
                child: _buildLoadingState(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          _buildCountryFilter(),
          SizedBox(height: 12.h),
          _buildSectorFilter(),
        ],
      ),
    );
  }

  Widget _buildCountryFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.public,
            color: const Color(0xFF4A90E2),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            'Market:',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountry,
                dropdownColor: const Color(0xFF2A2A3E),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF4A90E2),
                  size: 20.sp,
                ),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Row(
                      children: [
                        Text(
                          country['flag']!,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          country['name']!,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                    context.read<StockCubit>().loadStocks(
                      sector: _selectedSector == 'All' ? null : _selectedSector,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectorFilter() {
    return Container(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _sectors.length,
        itemBuilder: (context, index) {
          final sector = _sectors[index];
          final isSelected = _selectedSector == sector;
          
          return Container(
            margin: EdgeInsets.only(right: 12.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25.r),
                onTap: () {
                setState(() {
                  _selectedSector = sector;
                });
                context.read<StockCubit>().loadStocks(
                  sector: sector == 'All' ? null : sector,
                );
              },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4A90E2),
                              const Color(0xFF357ABD),
                            ],
                          )
                        : LinearGradient(
                            colors: [
                              const Color(0xFF2A2A3E).withValues(alpha: 0.6),
                              const Color(0xFF1F1F35).withValues(alpha: 0.8),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: isSelected 
                          ? const Color(0xFF4A90E2).withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFF4A90E2).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    sector,
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.white : Colors.grey[300],
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
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

  Widget _buildStocksListScrollable(List<Stock> stocks) {
    return Column(
      children: [
        ...stocks.map((stock) => 
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _buildStockItem(stock),
          )
        ).toList(),
        
        // Load More Button
        if (stocks.length >= 10)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _loadMoreStocks(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color(0xFF4A90E2),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(
                      color: const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 20.sp,
                      color: const Color(0xFF4A90E2),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Load More Stocks',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4A90E2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStockItem(Stock stock) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => Get.toNamed(AppRoutes.stockDetails, arguments: stock),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.grey[100]!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: stock.logoUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.grey[200]!, Colors.grey[300]!],
                          ),
                        ),
                        child: Icon(Icons.business, color: Colors.grey[600], size: 24.sp),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.grey[200]!, Colors.grey[300]!],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            stock.symbol[0],
                            style: GoogleFonts.inter(
                              color: Colors.grey[700],
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                    children: [
                      Text(
                        stock.symbol,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A90E2).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              stock.exchange,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF4A90E2),
                                fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        stock.name,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.grey[500],
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Vol: ${_formatVolume(stock.volume)}',
                            style: GoogleFonts.inter(
                              color: Colors.grey[500],
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: stock.isPositive 
                              ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                              : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: (stock.isPositive ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E))
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            stock.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${stock.changePercent.toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                              color: Colors.white,
                          fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${stock.isPositive ? '+' : ''}\$${stock.change.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: stock.isPositive ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
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

  String _formatVolume(double volume) {
    if (volume >= 1000000000) {
      return '${(volume / 1000000000).toStringAsFixed(1)}B';
    } else if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }
    return volume.toStringAsFixed(0);
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
          _buildPortfolioPerformanceCards(portfolio),
          SizedBox(height: 24.h),
          _buildPortfolioChart(portfolio),
          SizedBox(height: 24.h),
          _buildPortfolioInsights(portfolio),
          SizedBox(height: 24.h),
          _buildTopPerformers(portfolio.holdings),
          SizedBox(height: 24.h),
          _buildHoldingsList(portfolio.holdings),
          SizedBox(height: 24.h),
          _buildPortfolioActions(),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary(Portfolio portfolio) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4CAF50).withValues(alpha: 0.15),
            const Color(0xFF4A90E2).withValues(alpha: 0.15),
            const Color(0xFF9C27B0).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      const Color(0xFF357ABD).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF4A90E2),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Value',
            style: GoogleFonts.inter(
                        color: Colors.grey[300],
              fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
            ),
          ),
                    SizedBox(height: 4.h),
          Text(
            '\$${portfolio.totalValue.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioMetric(
                  'Total Return',
                  '\$${portfolio.totalReturn.toStringAsFixed(2)}',
                  '${portfolio.totalReturnPercent >= 0 ? '+' : ''}${portfolio.totalReturnPercent.toStringAsFixed(2)}%',
                  portfolio.totalReturnPercent >= 0,
                  Icons.trending_up,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildPortfolioMetric(
                  'Today\'s Change',
                  '\$${portfolio.dayChange.toStringAsFixed(2)}',
                  '${portfolio.dayChangePercent >= 0 ? '+' : ''}${portfolio.dayChangePercent.toStringAsFixed(2)}%',
                  portfolio.dayChangePercent >= 0,
                  Icons.today,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioMetric(
                  'Available Cash',
                  '\$${portfolio.availableCash.toStringAsFixed(2)}',
                  'Ready to invest',
                  true,
                  Icons.account_balance,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildPortfolioMetric(
                  'Total Invested',
                  '\$${portfolio.totalInvested.toStringAsFixed(2)}',
                  'In positions',
                  true,
                  Icons.pie_chart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioMetric(String title, String value, String percentage, bool isPositive, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.08),
            Colors.white.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF4A90E2),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
            title,
            style: GoogleFonts.inter(
                    color: Colors.grey[300],
              fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
            ),
          ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isPositive 
                    ? [const Color(0xFF4CAF50).withValues(alpha: 0.2), const Color(0xFF45A049).withValues(alpha: 0.2)]
                    : [const Color(0xFFE53E3E).withValues(alpha: 0.2), const Color(0xFFD53F3F).withValues(alpha: 0.2)],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
            percentage,
            style: GoogleFonts.inter(
                color: isPositive ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E),
                fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioChart(Portfolio portfolio) {
    return Container(
      height: 280.h,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      const Color(0xFF357ABD).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.pie_chart,
                  color: const Color(0xFF4A90E2),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
          Text(
            'Portfolio Allocation',
            style: GoogleFonts.inter(
              color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
            ),
          ),
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
            child: PieChart(
              PieChartData(
                sections: portfolio.holdings.map((holding) {
                  final percentage = (holding.totalValue / portfolio.totalValue) * 100;
                  return PieChartSectionData(
                    value: percentage,
                    title: '${percentage.toStringAsFixed(1)}%',
                    color: _getColorForSymbol(holding.symbol),
                            radius: 60.r,
                    titleStyle: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                        centerSpaceRadius: 45.r,
                        sectionsSpace: 3,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: portfolio.holdings.take(4).map((holding) {
                      final percentage = (holding.totalValue / portfolio.totalValue) * 100;
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: _getColorForSymbol(holding.symbol),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    holding.symbol,
                                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${percentage.toStringAsFixed(1)}%',
                                    style: GoogleFonts.inter(
                                      color: Colors.grey[400],
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  );
                }).toList(),
              ),
                ),
              ],
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
        ...holdings.map((holding) => _buildHoldingItem(holding)),
      ],
    );
  }

  Widget _buildHoldingItem(StockHolding holding) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            // Navigate to stock details for this holding
            final stock = Stock(
              symbol: holding.symbol,
              name: '${holding.symbol} Inc.',
              currentPrice: holding.totalValue / holding.shares,
              previousClose: (holding.totalValue / holding.shares) - 1.0,
              change: 1.0,
              changePercent: holding.totalReturnPercent,
              dayHigh: (holding.totalValue / holding.shares) + 5.0,
              dayLow: (holding.totalValue / holding.shares) - 5.0,
              volume: 1000000,
              marketCap: 1000000000,
              peRatio: 25.0,
              dividendYield: 2.5,
              sector: 'Technology',
              industry: 'Software',
              logoUrl: 'https://via.placeholder.com/64x64/4A90E2/FFFFFF?text=${holding.symbol[0]}',
              priceHistory: [],
              lastUpdated: DateTime.now(),
              weekHigh52: (holding.totalValue / holding.shares) + 50.0,
              weekLow52: (holding.totalValue / holding.shares) - 50.0,
              avgVolume: 1500000,
              beta: 1.2,
              eps: 5.0,
              description: 'A leading technology company',
              exchange: 'NASDAQ',
              currency: 'USD',
            );
            Get.toNamed(AppRoutes.stockDetails, arguments: stock);
          },
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getColorForSymbol(holding.symbol).withValues(alpha: 0.3),
                        _getColorForSymbol(holding.symbol).withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: _getColorForSymbol(holding.symbol).withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      holding.symbol[0],
                      style: GoogleFonts.inter(
                        color: _getColorForSymbol(holding.symbol),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            holding.symbol,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: _getColorForSymbol(holding.symbol).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'HOLDING',
                              style: GoogleFonts.inter(
                                color: _getColorForSymbol(holding.symbol),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${holding.shares} shares • \$${(holding.totalValue / holding.shares).toStringAsFixed(2)} avg',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.grey[500],
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Portfolio weight: ${((holding.totalValue / 10000) * 100).toStringAsFixed(1)}%',
                            style: GoogleFonts.inter(
                              color: Colors.grey[500],
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: holding.totalReturnPercent >= 0 
                              ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                              : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: (holding.totalReturnPercent >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E))
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            holding.totalReturnPercent >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${holding.totalReturnPercent >= 0 ? '+' : ''}${holding.totalReturnPercent.toStringAsFixed(2)}%',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${holding.totalReturnPercent >= 0 ? '+' : ''}\$${(holding.totalValue * (holding.totalReturnPercent / 100)).toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: holding.totalReturnPercent >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[300],
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioPerformanceCards(Portfolio portfolio) {
    return Row(
      children: [
        Expanded(
          child: _buildPerformanceCard(
            'Best Performer',
            'AAPL',
            '+12.5%',
            '\$2,450',
            Colors.green,
            Icons.trending_up,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildPerformanceCard(
            'Worst Performer',
            'NFLX',
            '-3.2%',
            '\$890',
            Colors.red,
            Icons.trending_down,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard(String title, String symbol, String change, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16.sp,
                ),
              ),
              Spacer(),
              Text(
                change,
                style: GoogleFonts.inter(
                  color: color,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            symbol,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
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

  Widget _buildPortfolioInsights(Portfolio portfolio) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      const Color(0xFF357ABD).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.insights,
                  color: const Color(0xFF4A90E2),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Portfolio Insights',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'AI POWERED',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildInsightItem(
            Icons.psychology,
            'Diversification Score',
            '8.5/10',
            'Your portfolio is well diversified across sectors',
            Colors.green,
          ),
          SizedBox(height: 16.h),
          _buildInsightItem(
            Icons.trending_up,
            'Risk Level',
            'Moderate',
            'Balanced risk profile with growth potential',
            Colors.orange,
          ),
          SizedBox(height: 16.h),
          _buildInsightItem(
            Icons.schedule,
            'Rebalancing',
            'Recommended',
            'Consider rebalancing in 2 weeks',
            const Color(0xFF4A90E2),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(IconData icon, String title, String value, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16.sp,
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
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        color: color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
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

  Widget _buildTopPerformers(List<StockHolding> holdings) {
    final sortedHoldings = List<StockHolding>.from(holdings)
      ..sort((a, b) => b.totalReturnPercent.compareTo(a.totalReturnPercent));
    
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withValues(alpha: 0.3),
                      Colors.green.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: Colors.green,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Top Performers',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'TOP 3',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ...sortedHoldings.take(3).map((holding) => _buildTopPerformerItem(holding, sortedHoldings.indexOf(holding) + 1)),
        ],
      ),
    );
  }

  Widget _buildTopPerformerItem(StockHolding holding, int rank) {
    final rankColors = [Colors.amber, Colors.grey[400]!, Colors.orange[300]!];
    final rankColor = rankColors[rank - 1];
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: rankColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rankColor, rankColor.withValues(alpha: 0.7)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: _getColorForSymbol(holding.symbol).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                holding.symbol[0],
                style: GoogleFonts.inter(
                  color: _getColorForSymbol(holding.symbol),
                  fontSize: 16.sp,
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
                  holding.symbol,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '\$${holding.totalValue.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF4CAF50), const Color(0xFF45A049)],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '+${holding.totalReturnPercent.toStringAsFixed(1)}%',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioActions() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
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
                child: _buildActionButton(
                  'Add Funds',
                  Icons.add_circle,
                  Colors.green,
                  () => _showAddFundsDialog(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  'Rebalance',
                  Icons.balance,
                  const Color(0xFF4A90E2),
                  () => _showRebalanceDialog(),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Withdraw',
                  Icons.remove_circle,
                  Colors.orange,
                  () => _showWithdrawDialog(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  'Analytics',
                  Icons.analytics,
                  Colors.purple,
                  () => _showAnalyticsDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddFundsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Add Funds',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Add funds to your portfolio to increase your buying power.',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Add Funds',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRebalanceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Rebalance Portfolio',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Rebalance your portfolio to maintain your target allocation.',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Rebalance',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Withdraw Funds',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Withdraw funds from your portfolio to your bank account.',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Withdraw',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAnalyticsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Portfolio Analytics',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'View detailed analytics and performance metrics for your portfolio.',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'View Analytics',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
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
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _showWatchlistDetailsDialog(watchlist),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF4A90E2).withValues(alpha: 0.3),
                            const Color(0xFF357ABD).withValues(alpha: 0.3),
                          ],
                        ),
        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        watchlist.isDefault ? Icons.star : Icons.bookmark,
                        color: watchlist.isDefault ? const Color(0xFFFFD700) : const Color(0xFF4A90E2),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
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
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              if (watchlist.isDefault)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [const Color(0xFFFFD700), const Color(0xFFFFA500)],
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    'DEFAULT',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: Colors.grey[400],
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${watchlist.symbols.length} stocks',
                                style: GoogleFonts.inter(
                                  color: Colors.grey[400],
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Icon(
                                Icons.access_time,
                                color: Colors.grey[500],
                                size: 12.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _formatDate(watchlist.lastUpdated),
                                style: GoogleFonts.inter(
                                  color: Colors.grey[500],
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                ),
              ),
              PopupMenuButton<String>(
                      icon: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.grey[300],
                          size: 16.sp,
                        ),
                      ),
                      color: const Color(0xFF2A2A3E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onSelected: (value) => _handleWatchlistAction(value, watchlist),
                itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: const Color(0xFF4A90E2), size: 16.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Edit',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'add_stock',
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.green, size: 16.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Add Stock',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'duplicate',
                          child: Row(
                            children: [
                              Icon(Icons.copy, color: Colors.orange, size: 16.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Duplicate',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        if (!watchlist.isDefault)
                          PopupMenuItem(
                            value: 'set_default',
                            child: Row(
                              children: [
                                Icon(Icons.star, color: const Color(0xFFFFD700), size: 16.sp),
                                SizedBox(width: 8.w),
                                Text(
                                  'Set as Default',
                                  style: GoogleFonts.inter(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                  PopupMenuItem(
                    value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 16.sp),
                              SizedBox(width: 8.w),
                              Text(
                      'Delete',
                      style: GoogleFonts.inter(color: Colors.red),
                              ),
                            ],
                    ),
                  ),
                ],
              ),
            ],
          ),
                if (watchlist.symbols.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          Text(
                          'Stocks in this watchlist:',
            style: GoogleFonts.inter(
                            color: Colors.grey[300],
              fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
            ),
          ),
                        SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
                          children: watchlist.symbols.take(6).map((symbol) {
                return Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF4A90E2).withValues(alpha: 0.3),
                                    const Color(0xFF357ABD).withValues(alpha: 0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFF4A90E2).withValues(alpha: 0.5),
                                ),
                  ),
                  child: Text(
                    symbol,
                    style: GoogleFonts.inter(
                                  color: const Color(0xFF4A90E2),
                      fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
                        ),
                        if (watchlist.symbols.length > 6) ...[
                          SizedBox(height: 8.h),
                          Text(
                            '+${watchlist.symbols.length - 6} more stocks',
                            style: GoogleFonts.inter(
                              color: Colors.grey[400],
                              fontSize: 11.sp,
                              fontStyle: FontStyle.italic,
                            ),
            ),
          ],
        ],
                    ),
                  ),
                ] else ...[
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[800]!.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey[600]!.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey[400],
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'No stocks added yet. Tap to add stocks.',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  void _handleWatchlistAction(String action, Watchlist watchlist) {
    switch (action) {
      case 'edit':
        _showEditWatchlistDialog(watchlist);
        break;
      case 'add_stock':
        _showAddStockToWatchlistDialog(watchlist);
        break;
      case 'duplicate':
        _duplicateWatchlist(watchlist);
        break;
      case 'set_default':
        _setDefaultWatchlist(watchlist);
        break;
      case 'delete':
        _showDeleteWatchlistConfirmation(watchlist);
        break;
    }
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
      case OrderStatus.partiallyFilled:
        return Colors.yellow;
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
          colors: [
            const Color(0xFF4CAF50),
            const Color(0xFF45A049),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => _showQuickTradeDialog(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Quick Trade',
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
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF4A90E2), const Color(0xFF357ABD)],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.bookmark_add,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
          'Create Watchlist',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
          controller: nameController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
                hintText: 'Enter watchlist name',
            hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
            border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
            ),
            focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: const Color(0xFF4A90E2),
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.edit,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<StockCubit>().createWatchlist(nameController.text, []);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Create',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showWatchlistDetailsDialog(Watchlist watchlist) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 600.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF2A2A3E),
                const Color(0xFF1F1F35),
              ],
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.2),
                      const Color(0xFF357ABD).withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: Row(
                  children: [
                    Icon(
                      watchlist.isDefault ? Icons.star : Icons.bookmark,
                      color: watchlist.isDefault ? const Color(0xFFFFD700) : const Color(0xFF4A90E2),
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            watchlist.name,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${watchlist.symbols.length} stocks • Updated ${_formatDate(watchlist.lastUpdated)}',
                            style: GoogleFonts.inter(
                              color: Colors.grey[400],
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: watchlist.symbols.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(32.w),
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
                              'No stocks in this watchlist',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Add stocks to start tracking them',
                              style: GoogleFonts.inter(
                                color: Colors.grey[500],
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        shrinkWrap: true,
                        itemCount: watchlist.symbols.length,
                        itemBuilder: (context, index) {
                          final symbol = watchlist.symbols[index];
                          return _buildWatchlistStockItem(symbol, watchlist);
                        },
                      ),
              ),
              // Actions
              Container(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showAddStockToWatchlistDialog(watchlist);
                        },
                        icon: Icon(Icons.add, size: 16.sp),
                        label: Text('Add Stock'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showEditWatchlistDialog(watchlist);
                      },
                      icon: Icon(Icons.edit, size: 16.sp),
                      label: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWatchlistStockItem(String symbol, Watchlist watchlist) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4A90E2).withValues(alpha: 0.3),
                  const Color(0xFF357ABD).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                symbol[0],
                style: GoogleFonts.inter(
                  color: const Color(0xFF4A90E2),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              symbol,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _removeStockFromWatchlist(watchlist, symbol),
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditWatchlistDialog(Watchlist watchlist) {
    final nameController = TextEditingController(text: watchlist.name);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF4A90E2), const Color(0xFF357ABD)],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Edit Watchlist',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter watchlist name',
                hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: const Color(0xFF4A90E2),
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.edit,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<StockCubit>().updateWatchlist(
                  watchlist.id,
                  nameController.text,
                  watchlist.symbols,
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Update',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddStockToWatchlistDialog(Watchlist watchlist) {
    final searchController = TextEditingController();
    final stockCubit = context.read<StockCubit>(); // Get the cubit instance
    
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: stockCubit, // Provide the cubit to the dialog context
        child: StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 500.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2A2A3E),
                  const Color(0xFF1F1F35),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withValues(alpha: 0.2),
                        const Color(0xFF357ABD).withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: const Color(0xFF4A90E2),
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Add Stock to ${watchlist.name}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                // Search
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: TextField(
                    controller: searchController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search stocks by symbol or name',
                      hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      ),
                    ),
                    onChanged: (query) {
                      if (query.isNotEmpty) {
                        context.read<StockCubit>().searchStocks(query);
                      }
                    },
                  ),
                ),
                  // Search Results - Now the BlocBuilder has access to StockCubit
                Flexible(
                  child: BlocBuilder<StockCubit, StockState>(
                    builder: (context, state) {
                      if (state is StockSearchLoaded) {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          shrinkWrap: true,
                          itemCount: state.searchResults.length,
                          itemBuilder: (context, index) {
                            final stock = state.searchResults[index];
                            final isAlreadyAdded = watchlist.symbols.contains(stock.symbol);
                            
                            return Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFF4A90E2).withValues(alpha: 0.3),
                                          const Color(0xFF357ABD).withValues(alpha: 0.3),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        stock.symbol[0],
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF4A90E2),
                                          fontSize: 16.sp,
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
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                                  ElevatedButton(
                                    onPressed: isAlreadyAdded
                                        ? null
                                        : () {
                                            context.read<StockCubit>().addToWatchlist(
                                              watchlist.id,
                                              stock.symbol,
                                            );
                                            Navigator.pop(context);
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isAlreadyAdded
                                          ? Colors.grey[600]
                                          : const Color(0xFF4A90E2),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 8.h,
                                      ),
                                    ),
                                    child: Text(
                                      isAlreadyAdded ? 'Added' : 'Add',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Container(
                        padding: EdgeInsets.all(32.w),
                        child: Text(
                          'Search for stocks to add to your watchlist',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _duplicateWatchlist(Watchlist watchlist) {
    final newName = '${watchlist.name} Copy';
    context.read<StockCubit>().createWatchlist(newName, watchlist.symbols);
  }

  void _setDefaultWatchlist(Watchlist watchlist) {
    // This would typically update the watchlist to be the default
    // For now, we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${watchlist.name} set as default watchlist'),
        backgroundColor: const Color(0xFF4A90E2),
      ),
    );
  }

  void _removeStockFromWatchlist(Watchlist watchlist, String symbol) {
    context.read<StockCubit>().removeFromWatchlist(watchlist.id, symbol);
  }



  void _showDeleteWatchlistConfirmation(Watchlist watchlist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Delete Watchlist',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${watchlist.name}"? This action cannot be undone.',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<StockCubit>().deleteWatchlist(watchlist.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showVoiceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A2A3E),
              const Color(0xFF1F1F35),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.pink],
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Voice Commands',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.withValues(alpha: 0.3), Colors.pink.withValues(alpha: 0.3)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mic,
                      color: Colors.red,
                      size: 48.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Tap to speak',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Say commands like "Buy Apple stock" or "Show my portfolio"',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAIChatBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A2A3E),
              const Color(0xFF1F1F35),
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.smart_toy,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'AI Stock Assistant',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          _buildChatMessage(
                            'Hello! I\'m your AI stock assistant. I can help you with market analysis, stock recommendations, and trading insights. What would you like to know?',
                            isBot: true,
                          ),
                          _buildChatMessage(
                            'What are the top performing stocks today?',
                            isBot: false,
                          ),
                          _buildChatMessage(
                            'Based on current market data, here are today\'s top performers:\n\n• AAPL: +2.5%\n• MSFT: +1.8%\n• GOOGL: +1.2%\n\nWould you like detailed analysis on any of these?',
                            isBot: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Text(
                              'Type your message...',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage(String message, {required bool isBot}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBot) ...[
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isBot 
                    ? Colors.blue.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          if (!isBot) ...[
            SizedBox(width: 12.w),
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Stocks',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'HOT',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildTrendingStock('Apple Inc.', 'AAPL', '\$175.43', 2.34, Colors.blue),
          SizedBox(height: 12.h),
          _buildTrendingStock('Microsoft Corp.', 'MSFT', '\$378.85', 1.87, Colors.green),
          SizedBox(height: 12.h),
          _buildTrendingStock('Tesla Inc.', 'TSLA', '\$248.50', 3.21, Colors.red),
        ],
      ),
    );
  }

  Widget _buildTrendingStock(String name, String symbol, String price, double change, Color iconColor) {
    // Get logo URL based on symbol
    final logoUrl = _getCompanyLogoUrl(symbol);
    
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            iconColor.withValues(alpha: 0.1),
            iconColor.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _showTrendingStockDetails(symbol, name, price, change, logoUrl),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Company Logo
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.grey[50]!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: logoUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              iconColor.withValues(alpha: 0.2),
                              iconColor.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            symbol[0],
                            style: GoogleFonts.inter(
                              color: iconColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              iconColor.withValues(alpha: 0.2),
                              iconColor.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            symbol[0],
                            style: GoogleFonts.inter(
                              color: iconColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              name,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange],
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withValues(alpha: 0.3),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.white,
                                    size: 8.sp,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    'HOT',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: iconColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: iconColor.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              symbol,
                              style: GoogleFonts.inter(
                                color: iconColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.trending_up,
                            color: Colors.green,
                            size: 12.sp,
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            child: Text(
                              'Trending',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        price,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: change >= 0 
                              ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                              : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: (change >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E))
                                .withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            '${change.abs().toStringAsFixed(2)}%',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
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

  Widget _buildTopMoversSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4A90E2).withValues(alpha: 0.3),
                          const Color(0xFF357ABD).withValues(alpha: 0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: const Color(0xFF4A90E2),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Top Movers',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'LIVE',
                  style: GoogleFonts.inter(
                    color: Colors.orange,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showGainers = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: _showGainers 
                          ? LinearGradient(
                              colors: [
                                const Color(0xFF4CAF50),
                                const Color(0xFF45A049),
                              ],
                            )
                          : null,
                      color: _showGainers ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: _showGainers 
                            ? const Color(0xFF4CAF50).withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: _showGainers ? Colors.white : Colors.grey[400],
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Top Gainers',
                            style: GoogleFonts.inter(
                              color: _showGainers ? Colors.white : Colors.grey[400],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showGainers = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: !_showGainers 
                          ? LinearGradient(
                              colors: [
                                const Color(0xFFE53E3E),
                                const Color(0xFFD53F3F),
                              ],
                            )
                          : null,
                      color: !_showGainers ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: !_showGainers 
                            ? const Color(0xFFE53E3E).withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: !_showGainers ? Colors.white : Colors.grey[400],
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Top Losers',
                            style: GoogleFonts.inter(
                              color: !_showGainers ? Colors.white : Colors.grey[400],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 150.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              children: _showGainers ? _buildTopGainers() : _buildTopLosers(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTopGainers() {
    return [
      _buildMoverCard('NVDA', 'NVIDIA Corp.', '\$875.28', 4.23, Icons.memory),
      _buildMoverCard('AMD', 'Advanced Micro Devices', '\$142.33', 3.87, Icons.developer_board),
      _buildMoverCard('GOOGL', 'Alphabet Inc.', '\$2,847.63', 2.95, Icons.search),
      _buildMoverCard('META', 'Meta Platforms', '\$485.75', 2.14, Icons.facebook),
    ];
  }

  List<Widget> _buildTopLosers() {
    return [
      _buildMoverCard('NFLX', 'Netflix Inc.', '\$398.42', -2.83, Icons.play_circle),
      _buildMoverCard('UBER', 'Uber Technologies', '\$58.73', -1.95, Icons.local_taxi),
      _buildMoverCard('SNAP', 'Snap Inc.', '\$12.45', -3.21, Icons.camera_alt),
      _buildMoverCard('TWTR', 'Twitter Inc.', '\$45.67', -1.67, Icons.alternate_email),
    ];
  }

  Widget _buildMoverCard(String symbol, String name, String price, double change, IconData icon) {
    final isGainer = change >= 0;
    
    return Container(
      width: 150.w,
      height: 140.h,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _showMoverStockActions(symbol, name, price),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'LIVE',
                        style: GoogleFonts.inter(
                          color: Colors.orange,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symbol,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isGainer 
                              ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                              : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isGainer ? Icons.trending_up : Icons.trending_down,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${change.abs().toStringAsFixed(2)}%',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
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

  Widget _buildStocksSectionHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Divider line
          Container(
            height: 1.h,
            margin: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      const Color(0xFF357ABD).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.list,
                  color: const Color(0xFF4A90E2),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'All Stocks',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showBrowseBottomSheet(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'BROWSE',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF4A90E2),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBrowseBottomSheet() {
    final stockCubit = context.read<StockCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => BlocProvider.value(
        value: stockCubit,
        child: StockActionBottomSheet(
          type: StockActionType.allStocks,
          title: 'Browse Stocks',
        ),
      ),
    );
  }

  Widget _buildBrowseStocksList(List<Stock> stocks) {
    if (stocks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              color: Colors.grey[400],
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'No stocks found',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(
                AppRoutes.stockDetails,
                arguments: stock,
              );
            },
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withValues(alpha: 0.3),
                        const Color(0xFF357ABD).withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      stock.symbol[0],
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4A90E2),
                        fontSize: 18.sp,
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
                          fontWeight: FontWeight.w700,
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
                      if (stock.sector.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A90E2).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            stock.sector,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF4A90E2),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          stock.changePercent >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                          color: stock.changePercent >= 0 ? Colors.green : Colors.red,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${stock.changePercent >= 0 ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                          style: GoogleFonts.inter(
                            color: stock.changePercent >= 0 ? Colors.green : Colors.red,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
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
      },
    );
  }



  Widget _buildBrowseSection(String title, Widget content) {
    return Column(
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
        SizedBox(height: 12.h),
        content,
      ],
    );
  }

  Widget _buildFeaturedStocks() {
    return SizedBox(
      height: 140.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        children: [
          _buildFeaturedStockCard('AAPL', 'Apple Inc.', '\$175.43', 2.34, Colors.blue),
          _buildFeaturedStockCard('MSFT', 'Microsoft', '\$378.85', 1.87, Colors.green),
          _buildFeaturedStockCard('GOOGL', 'Alphabet', '\$2,847.63', 2.95, Colors.red),
          _buildFeaturedStockCard('TSLA', 'Tesla', '\$248.50', -1.21, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildFeaturedStockCard(String symbol, String name, String price, double change, Color accentColor) {
    return Container(
      width: 160.w,
      height: 130.h,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.1),
            accentColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  symbol[0],
                  style: GoogleFonts.inter(
                    color: accentColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Spacer(),
              Icon(
                change >= 0 ? Icons.trending_up : Icons.trending_down,
                color: change >= 0 ? Colors.green : Colors.red,
                size: 16.sp,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                name,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 10.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  price,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  color: change >= 0 ? Colors.green : Colors.red,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketMovers() {
    return Column(
      children: [
        _buildMoverRow('NVDA', 'NVIDIA Corp.', '\$875.28', 4.23, true),
        SizedBox(height: 8.h),
        _buildMoverRow('AMD', 'Advanced Micro Devices', '\$142.33', 3.87, true),
        SizedBox(height: 8.h),
        _buildMoverRow('NFLX', 'Netflix Inc.', '\$398.42', -2.83, false),
      ],
    );
  }

  Widget _buildMoverRow(String symbol, String name, String price, double change, bool isGainer) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: (isGainer ? Colors.green : Colors.red).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                symbol[0],
                style: GoogleFonts.inter(
                  color: isGainer ? Colors.green : Colors.red,
                  fontSize: 16.sp,
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
                  symbol,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  name,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 11.sp,
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
                price,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(
                    isGainer ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isGainer ? Colors.green : Colors.red,
                    size: 12.sp,
                  ),
                  Text(
                    '${change.abs().toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: isGainer ? Colors.green : Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }



  String _getCompanyLogoUrl(String symbol) {
    // Return company logo URLs based on symbol
    final logoUrls = {
      'AAPL': 'https://logo.clearbit.com/apple.com',
      'MSFT': 'https://logo.clearbit.com/microsoft.com',
      'GOOGL': 'https://logo.clearbit.com/google.com',
      'TSLA': 'https://logo.clearbit.com/tesla.com',
      'AMZN': 'https://logo.clearbit.com/amazon.com',
      'META': 'https://logo.clearbit.com/meta.com',
      'NVDA': 'https://logo.clearbit.com/nvidia.com',
      'AMD': 'https://logo.clearbit.com/amd.com',
      'NFLX': 'https://logo.clearbit.com/netflix.com',
      'UBER': 'https://logo.clearbit.com/uber.com',
      'SNAP': 'https://logo.clearbit.com/snap.com',
      'TWTR': 'https://logo.clearbit.com/twitter.com',
    };
    
    return logoUrls[symbol] ?? 'https://via.placeholder.com/64x64/4A90E2/FFFFFF?text=${symbol[0]}';
  }

  void _showTrendingStockDetails(String symbol, String name, String price, double change, String logoUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A2A3E),
              const Color(0xFF1F1F35),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            
            // Stock Info Header
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[100]!],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: logoUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.withValues(alpha: 0.2), Colors.blue.withValues(alpha: 0.1)],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            symbol[0],
                            style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.withValues(alpha: 0.2), Colors.blue.withValues(alpha: 0.1)],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            symbol[0],
                            style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange, Colors.deepOrange],
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'TRENDING',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              symbol,
                              style: GoogleFonts.inter(
                                color: Colors.blue,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            price,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: change >= 0 
                                    ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                                    : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: Colors.white,
                                  size: 10.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  '${change.abs().toStringAsFixed(2)}%',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 32.h),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF4CAF50),
                          const Color(0xFF45A049),
                          const Color(0xFF388E3C),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Create a proper Stock object for navigation
                        final currentPrice = double.tryParse(price.replaceAll('\$', '').replaceAll(',', '')) ?? 0.0;
                        final stock = Stock(
                          symbol: symbol,
                          name: name,
                          currentPrice: currentPrice,
                          previousClose: currentPrice - change,
                          change: change,
                          changePercent: change,
                          dayHigh: currentPrice + 5.0,
                          dayLow: currentPrice - 5.0,
                          volume: 1000000,
                          marketCap: 1000000000,
                          peRatio: 25.0,
                          dividendYield: 2.5,
                          sector: 'Technology',
                          industry: 'Software',
                          logoUrl: logoUrl,
                          priceHistory: [],
                          lastUpdated: DateTime.now(),
                          weekHigh52: currentPrice + 50.0,
                          weekLow52: currentPrice - 50.0,
                          avgVolume: 1500000,
                          beta: 1.2,
                          eps: 5.0,
                          description: 'A leading technology company',
                          exchange: 'NASDAQ',
                          currency: 'USD',
                        );
                        Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                          'stock': stock,
                          'tradeType': 'buy',
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Buy Stock',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFE53E3E),
                          const Color(0xFFD53F3F),
                          const Color(0xFFC62828),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE53E3E).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Create a proper Stock object for navigation
                        final currentPrice = double.tryParse(price.replaceAll('\$', '').replaceAll(',', '')) ?? 0.0;
                        final stock = Stock(
                          symbol: symbol,
                          name: name,
                          currentPrice: currentPrice,
                          previousClose: currentPrice - change,
                          change: change,
                          changePercent: change,
                          dayHigh: currentPrice + 5.0,
                          dayLow: currentPrice - 5.0,
                          volume: 1000000,
                          marketCap: 1000000000,
                          peRatio: 25.0,
                          dividendYield: 2.5,
                          sector: 'Technology',
                          industry: 'Software',
                          logoUrl: logoUrl,
                          priceHistory: [],
                          lastUpdated: DateTime.now(),
                          weekHigh52: currentPrice + 50.0,
                          weekLow52: currentPrice - 50.0,
                          avgVolume: 1500000,
                          beta: 1.2,
                          eps: 5.0,
                          description: 'A leading technology company',
                          exchange: 'NASDAQ',
                          currency: 'USD',
                        );
                        Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                          'stock': stock,
                          'tradeType': 'sell',
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Sell Stock',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // View Details button
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF4A90E2),
                    const Color(0xFF357ABD),
                    const Color(0xFF2E6BA8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Create a mock Stock object for navigation
                  final currentPrice = double.tryParse(price.replaceAll('\$', '').replaceAll(',', '')) ?? 0.0;
                  final stock = Stock(
                    symbol: symbol,
                    name: name,
                    currentPrice: currentPrice,
                    previousClose: currentPrice - change,
                    change: change,
                    changePercent: change,
                    dayHigh: currentPrice + 5.0,
                    dayLow: currentPrice - 5.0,
                    volume: 1000000,
                    marketCap: 1000000000,
                    peRatio: 25.0,
                    dividendYield: 2.5,
                    sector: 'Technology',
                    industry: 'Software',
                    logoUrl: logoUrl,
                    priceHistory: [],
                    lastUpdated: DateTime.now(),
                    weekHigh52: currentPrice + 50.0,
                    weekLow52: currentPrice - 50.0,
                    avgVolume: 1500000,
                    beta: 1.2,
                    eps: 5.0,
                    description: 'A leading technology company',
                    exchange: 'NASDAQ',
                    currency: 'USD',
                  );
                  Get.toNamed(AppRoutes.stockDetails, arguments: stock);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.analytics_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'View Details & Charts',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
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

  void _showTrendingStockActions(String symbol, String name, String price) {
    final stockCubit = context.read<StockCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => BlocProvider.value(
        value: stockCubit,
        child: StockActionBottomSheet(
          type: StockActionType.trending,
          title: 'Trending Stocks',
        ),
      ),
    );
  }

  void _showMoverStockActions(String symbol, String name, String price) {
    final stockCubit = context.read<StockCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => BlocProvider.value(
        value: stockCubit,
        child: StockActionBottomSheet(
          type: StockActionType.movers,
          title: 'Market Movers',
        ),
      ),
    );
  }

  void _showQuickTradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF4CAF50), const Color(0xFF45A049)],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Quick Trade',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose a trading action',
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to buy flow
                      Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                        'tradeType': 'buy',
                      });
                    },
                    icon: Icon(Icons.add, size: 16.sp),
                    label: Text('Buy'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to sell flow
                      Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                        'tradeType': 'sell',
                      });
                    },
                    icon: Icon(Icons.remove, size: 16.sp),
                    label: Text('Sell'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53E3E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 