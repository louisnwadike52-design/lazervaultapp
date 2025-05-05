import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';

class Stocks extends StatefulWidget {
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 129, 73, 226),
        ),
      );
    }

    if (_error != null) {
      return _buildErrorState(_error!);
    }

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          // Portfolio Summary Card
          _buildPortfolioCard(),

          // Tab Bar
          TabBar(
            onTap: (index) => setState(() => selectedTab = index),
            indicatorColor: primaryPurple,
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(text: 'Stocks'),
              Tab(text: 'Crypto'),
              Tab(text: 'ETFs'),
              Tab(text: 'News'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
          ),

          // Main Content
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
    );
  }

  Widget _buildPortfolioCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackNavigator(),
        Container(
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 129, 73, 226),
                Color.fromARGB(255, 33, 11, 111),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Portfolio',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 16.sp,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                '\$${NumberFormat('#,##0.00').format(portfolioData['totalValue'])}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _buildPortfolioMetric(
                    'Today',
                    portfolioData['todayChange'],
                    portfolioData['todayPercentage'],
                  ),
                  SizedBox(width: 24.w),
                  _buildPortfolioMetric(
                    'Total Return',
                    portfolioData['totalReturn'],
                    portfolioData['totalReturnPercentage'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStocksTab() {
    return RefreshIndicator(
      color: primaryPurple,
      backgroundColor: cardBackgroundColor,
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          // Refresh data
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Market Movers Section
            _buildSection(
              'Top Movers',
              _buildTopMovers(),
            ),

            // Sectors Performance
            _buildSection(
              'Sectors Performance',
              _buildSectorsPerformance(),
            ),

            // Watchlist/Portfolio Toggle
            _buildWatchlistToggle(),

            // Stocks List
            _buildStocksList(),

            // Add bottom padding
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTopMovers() {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topMovers.length,
        itemBuilder: (context, index) {
          final mover = topMovers[index];
          final isPositive = mover['change'] > 0;

          return Container(
            width: 120.w,
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 33, 11, 111),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mover['symbol'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${mover['price']}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${isPositive ? '+' : ''}${mover['change']}%',
                  style: TextStyle(
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
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 33, 11, 111),
            borderRadius: BorderRadius.circular(8.r),
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
                  SizedBox(width: 8.w),
                  Text(
                    sector['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '${isPositive ? '+' : ''}${sector['change']}%',
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNewsTab() {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final news = newsItems[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 33, 11, 111),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                // You would normally use Image.network or Image.asset here
                child: Center(
                  child: Text(
                    news['relatedSymbol'],
                    style: TextStyle(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          news['source'],
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '•',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          news['time'],
                          style: TextStyle(
                            color: Colors.white60,
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
          Icon(
            Icons.upcoming,
            size: 48.r,
            color: Colors.white60,
          ),
          SizedBox(height: 16.h),
          Text(
            '$feature Coming Soon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "We're working on bringing you the best $feature trading experience",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistToggle() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isWatchlist = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isWatchlist
                      ? const Color.fromARGB(255, 129, 73, 226)
                      : const Color.fromARGB(255, 33, 11, 111),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Watchlist',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        isWatchlist ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isWatchlist = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !isWatchlist
                      ? const Color.fromARGB(255, 129, 73, 226)
                      : const Color.fromARGB(255, 33, 11, 111),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Portfolio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        !isWatchlist ? FontWeight.bold : FontWeight.normal,
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
    // Sample stock data
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
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Stock Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock['symbol'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      stock['name'],
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),

              // Mini Chart (placeholder)
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 40.h,
                  child: CustomPaint(
                    painter: MiniChartPainter(
                      points: stock['chart'],
                      isUp: stock['isUp'],
                    ),
                  ),
                ),
              ),

              // Price Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${stock['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${stock['isUp'] ? '+' : ''}${stock['changePercentage'].toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: stock['isUp'] ? Colors.green : Colors.red,
                        fontSize: 14.sp,
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

  Widget _buildPortfolioMetric(String label, double value, double percentage) {
    final isPositive = percentage >= 0;
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white60,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '\$${NumberFormat('#,##0.00').format(value)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${isPositive ? '+' : ''}$percentage%',
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  // Add this helper widget for section headers
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 129, 73, 226),
                  size: 16.r,
                ),
                label: Text(
                  'See All',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 129, 73, 226),
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

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48.r,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: () {
              setState(() {
                _error = null;
                // Retry loading data
              });
            },
            child: Text(
              'Retry',
              style: TextStyle(
                color: primaryPurple,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(2);
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
