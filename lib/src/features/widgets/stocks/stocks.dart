import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';

class Stocks extends StatefulWidget {
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  final List<String> timeFrames = ['1D', '1W', '1M', '3M', '1Y', 'All'];
  int selectedTimeFrame = 0;
  bool isWatchlist = true;
  int selectedTab = 0;

  // Constants for colors
  final cardBackgroundColor = const Color.fromARGB(255, 33, 11, 111);
  final primaryPurple = const Color.fromARGB(255, 129, 73, 226);
  final scaffoldBackground = const Color.fromARGB(255, 7, 1, 17);

  // Sample portfolio data
  final Map<String, dynamic> portfolioData = {
    'totalValue': 15234.67,
    'todayChange': 234.56,
    'todayPercentage': 1.57,
    'totalReturn': 1234.56,
    'totalReturnPercentage': 8.82,
  };

  // Sample market movers
  final List<Map<String, dynamic>> topMovers = [
    {
      'symbol': 'NVDA',
      'change': 5.67,
      'price': 478.23,
    },
    {
      'symbol': 'AMD',
      'change': 4.32,
      'price': 138.45,
    },
    {
      'symbol': 'META',
      'change': -3.45,
      'price': 334.12,
    },
  ];

  // Sample sectors performance
  final List<Map<String, dynamic>> sectors = [
    {
      'name': 'Technology',
      'change': 2.34,
      'color': Colors.blue,
    },
    {
      'name': 'Healthcare',
      'change': -1.23,
      'color': Colors.purple,
    },
    {
      'name': 'Finance',
      'change': 0.87,
      'color': Colors.green,
    },
  ];

  // Sample news items
  final List<Map<String, dynamic>> newsItems = [
    {
      'title': 'Tesla Announces New Factory in Mexico',
      'source': 'Bloomberg',
      'time': '2h ago',
      'imageUrl': 'assets/tesla_news.jpg',
      'relatedSymbol': 'TSLA',
    },
    {
      'title': "Apple's Latest iPhone Sales Break Records",
      'source': 'Reuters',
      'time': '4h ago',
      'imageUrl': 'assets/apple_news.jpg',
      'relatedSymbol': 'AAPL',
    },
  ];

  // Add these to the state class
  final bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_error != null) {
      return _buildErrorState(_error!);
    }

    return Container(
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
      child: Column(
        children: [
          // Main content
          Expanded(
            child: DefaultTabController(
      length: 4,
      child: Column(
        children: [
                  _buildModernHeader(),
                  _buildPortfolioSummaryCard(),
                  _buildQuickActions(),
                  SizedBox(height: 16.h),
                  _buildTabBar(),
          Expanded(
            child: TabBarView(
              children: [
                _buildStocksTab(),
                _buildComingSoonTab('Crypto'),
                _buildComingSoonTab('ETFs'),
                _buildNewsTab(),
              ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, MediaQuery.of(context).padding.top + 16.h, 16.w, 16.h),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
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
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Search stocks...',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(Icons.mic_rounded, 
                    color: Colors.blue, size: 20.sp),
                  onPressed: () => _showVoiceAgentSheet(),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined, 
                    color: Colors.white, size: 20.sp),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVoiceAgentSheet() {
    final stocksSuggestions = [
      'Check my portfolio balance',
      'Show recent stock performance',
      'Buy Apple stock',
      'Sell Tesla shares',
      'Show market trends',
      'Check NVIDIA price',
      'Set price alert',
      'View my watchlist',
    ];
    
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(suggestions: stocksSuggestions),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildPortfolioSummaryCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            const Color(0xFF2C3E50),
            const Color(0xFF3498DB),
              ],
            ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(
            'Portfolio Value',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
                children: [
                  Text(
                '\$${NumberFormat('#,##0.00').format(portfolioData['totalValue'])}',
                    style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                    ),
                  ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: portfolioData['todayPercentage'] >= 0 
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      portfolioData['todayPercentage'] >= 0 
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      color: portfolioData['todayPercentage'] >= 0 
                          ? Colors.green
                          : Colors.red,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${portfolioData['todayPercentage'].toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: portfolioData['todayPercentage'] >= 0 
                            ? Colors.green
                            : Colors.red,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                ],
              ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPortfolioStat('Today\'s Change', 
                '\$${NumberFormat('#,##0.00').format(portfolioData['todayChange'])}'),
              _buildPortfolioStat('Total Return', 
                '\$${NumberFormat('#,##0.00').format(portfolioData['totalReturn'])}'),
              _buildPortfolioStat('Holdings', '12'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
                style: TextStyle(
                  color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
                ),
              ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
                children: [
          _buildQuickActionButton(
            'Buy Stock',
            Icons.add_circle_outline,
            Colors.green,
            () => _showBuyStockDialog(),
          ),
          SizedBox(width: 12.w),
          _buildQuickActionButton(
            'Sell Stock',
            Icons.remove_circle_outline,
            Colors.red,
            () => _showSellStockDialog(),
          ),
          SizedBox(width: 12.w),
          _buildQuickActionButton(
            'Watchlist',
            Icons.visibility_outlined,
            Colors.blue,
            () => _toggleWatchlist(),
                  ),
          SizedBox(width: 12.w),
          _buildQuickActionButton(
            'Analysis',
            Icons.analytics_outlined,
            Colors.purple,
            () => _showAnalysis(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      width: 120.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 18.sp),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                  ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        onTap: (index) => setState(() => selectedTab = index),
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[700]!,
              Colors.blue[500]!,
            ],
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          Tab(text: 'Stocks'),
          Tab(text: 'Crypto'),
          Tab(text: 'ETFs'),
          Tab(text: 'News'),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildStocksTab() {
    return RefreshIndicator(
      color: Colors.blue,
      backgroundColor: Colors.grey[900],
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildSection('Top Movers', _buildTopMovers()),
            _buildSection('Sectors Performance', _buildSectorsPerformance()),
            _buildWatchlistToggle(),
            _buildStocksList(),
            SizedBox(height: 100.h), // Space for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                  size: 16.r,
                ),
                label: Text(
                  'See All',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
        child,
      ],
    );
  }

  Widget _buildTopMovers() {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: topMovers.length,
        itemBuilder: (context, index) {
          final mover = topMovers[index];
          final isPositive = mover['change'] > 0;

          return Container(
            width: 140.w,
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16.r),              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mover['symbol'],
                      style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: isPositive 
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$${mover['price']}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${isPositive ? '+' : ''}${mover['change']}%',
                  style: GoogleFonts.inter(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectorsPerformance() {
    return Column(
      children: sectors.map((sector) {
        final isPositive = sector['change'] > 0;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: sector['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    sector['name'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPositive 
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                '${isPositive ? '+' : ''}${sector['change']}%',
                  style: GoogleFonts.inter(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWatchlistToggle() {
        return Container(
      margin: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
        color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                        ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isWatchlist = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: isWatchlist
                      ? LinearGradient(
                          colors: [
                            Colors.blue[700]!,
                            Colors.blue[500]!,
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Watchlist',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: isWatchlist ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isWatchlist = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: !isWatchlist
                      ? LinearGradient(
                          colors: [
                            Colors.blue[700]!,
                            Colors.blue[500]!,
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Portfolio',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: !isWatchlist ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStocksList() {
    final List<Map<String, dynamic>> stocks = [
      {
        'symbol': 'AAPL',
        'name': 'Apple Inc.',
        'price': 178.72,
        'change': 2.34,
        'changePercentage': 1.32,
        'chart': [120.0, 125.0, 123.0, 130.0, 128.0, 135.0],
        'isUp': true,
      },
      {
        'symbol': 'TSLA',
        'name': 'Tesla, Inc.',
        'price': 242.15,
        'change': -5.23,
        'changePercentage': -2.11,
        'chart': [240.0, 238.0, 235.0, 233.0, 236.0, 242.0],
        'isUp': false,
      },
      {
        'symbol': 'MSFT',
        'name': 'Microsoft Corporation',
        'price': 338.11,
        'change': 4.56,
        'changePercentage': 1.37,
        'chart': [330.0, 332.0, 335.0, 337.0, 336.0, 338.0],
        'isUp': true,
      },
      {
        'symbol': 'GOOGL',
        'name': 'Alphabet Inc.',
        'price': 132.67,
        'change': -1.23,
        'changePercentage': -0.92,
        'chart': [133.0, 132.5, 132.0, 131.8, 132.3, 132.67],
        'isUp': false,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: stocks.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return _buildModernStockCard(stock, index);
      },
    );
  }

  Widget _buildModernStockCard(Map<String, dynamic> stock, int index) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeOut,
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16.r),            boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () => _showStockDetails(stock),
            child: Padding(
              padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
                  // Stock Logo/Symbol
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[700]!,
                          Colors.blue[500]!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        stock['symbol'].substring(0, 2),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  
              // Stock Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock['symbol'],
                          style: GoogleFonts.inter(
                        color: Colors.white,
                            fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      stock['name'],
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

                  // Mini Chart
                  SizedBox(
                    width: 60.w,
                    height: 30.h,
                  child: CustomPaint(
                    painter: MiniChartPainter(
                      points: stock['chart'],
                      isUp: stock['isUp'],
                  ),
                ),
              ),
                  
                  SizedBox(width: 12.w),

              // Price Info
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${stock['price'].toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: stock['isUp'] 
                              ? Colors.green.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                      '${stock['isUp'] ? '+' : ''}${stock['changePercentage'].toStringAsFixed(2)}%',
                          style: GoogleFonts.inter(
                        color: stock['isUp'] ? Colors.green : Colors.red,
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
      ),
    );
  }

  Widget _buildNewsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final news = newsItems[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
      children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[700]!,
                      Colors.blue[500]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    news['relatedSymbol'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
            fontSize: 14.sp,
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
                      news['title'],
                      style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
        ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
        Text(
                          news['source'],
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '•',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          news['time'],
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
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
      },
    );
  }

  Widget _buildComingSoonTab(String feature) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
            ),
            child: Icon(
              Icons.upcoming,
              size: 48.r,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 16.h),
              Text(
            '$feature Coming Soon',
            style: GoogleFonts.inter(
                  color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
                ),
              ),
          SizedBox(height: 8.h),
          Text(
            "We're working on bringing you the best $feature trading experience",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
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
      child: Column(
        children: [
          // Main content
          _buildModernHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.1),
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: Container(
                    height: 80.h,
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
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
      child: Column(
        children: [
          // Main content
          _buildModernHeader(),
          Expanded(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: 48.sp,
                      color: Colors.red.shade400,
                    ),
          ),
          SizedBox(height: 16.h),
          Text(
                    'Something went wrong',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
              color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      message,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[700]!,
                          Colors.blue[500]!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
            onPressed: () {
              setState(() {
                _error = null;
              });
            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
            child: Text(
                        'Try Again',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  // Action methods
  void _showBuyStockDialog() {
    Get.snackbar(
      'Buy Stock',
      'Buy stock feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 12.r,
      margin: EdgeInsets.all(16.w),
    );
  }

  void _showSellStockDialog() {
    Get.snackbar(
      'Sell Stock',
      'Sell stock feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 12.r,
      margin: EdgeInsets.all(16.w),
    );
  }

  void _toggleWatchlist() {
    setState(() {
      isWatchlist = !isWatchlist;
    });
  }

  void _showAnalysis() {
    Get.snackbar(
      'Analysis',
      'Stock analysis feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 12.r,
      margin: EdgeInsets.all(16.w),
    );
  }

  void _showStockDetails(Map<String, dynamic> stock) {
    Get.snackbar(
      stock['symbol'],
      'Stock details for ${stock['name']} coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 12.r,
      margin: EdgeInsets.all(16.w),
    );
  }


}

// Custom painter for mini chart
class MiniChartPainter extends CustomPainter {
  final List<double> points;
  final bool isUp;

  MiniChartPainter({required this.points, required this.isUp});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isUp ? Colors.green : Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width / (points.length - 1);
    final max = points.reduce((a, b) => a > b ? a : b);
    final min = points.reduce((a, b) => a < b ? a : b);
    final range = max - min;

    if (range == 0) return;

    path.moveTo(0, size.height * (1 - (points[0] - min) / range));

    for (var i = 1; i < points.length; i++) {
      path.lineTo(
        width * i,
        size.height * (1 - (points[i] - min) / range),
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
