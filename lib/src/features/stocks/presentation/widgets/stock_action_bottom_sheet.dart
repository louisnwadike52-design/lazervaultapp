import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_state.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';

enum StockActionType { trending, movers, allStocks }

class StockActionBottomSheet extends StatefulWidget {
  final StockActionType type;
  final String? title;
  final List<Stock>? stocks;
  final String? selectedFilter;

  const StockActionBottomSheet({
    super.key,
    required this.type,
    this.title,
    this.stocks,
    this.selectedFilter,
  });

  @override
  State<StockActionBottomSheet> createState() => _StockActionBottomSheetState();
}

class _StockActionBottomSheetState extends State<StockActionBottomSheet> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  List<Stock> _filteredStocks = [];

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.selectedFilter ?? 'All';
    _filteredStocks = widget.stocks ?? [];
    // Defer loading stocks until after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStocks();
    });
  }

  void _loadStocks() {
    if (widget.stocks == null && mounted) {
      try {
        // Load stocks based on the type
        switch (widget.type) {
          case StockActionType.trending:
            context.read<StockCubit>().loadStocks(limit: 20);
            break;
          case StockActionType.movers:
            context.read<StockCubit>().loadTopMovers();
            break;
          case StockActionType.allStocks:
            context.read<StockCubit>().loadStocks(limit: 50);
            break;
        }
      } catch (e) {
        print('Error loading stocks in bottom sheet: $e');
      }
    }
  }

  void _filterStocks(List<Stock> stocks) {
    setState(() {
      _filteredStocks = stocks.where((stock) {
        final matchesSearch = _searchController.text.isEmpty ||
            stock.symbol.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            stock.name.toLowerCase().contains(_searchController.text.toLowerCase());
        
        final matchesFilter = _selectedFilter == 'All' ||
            (_selectedFilter == 'Gainers' && stock.changePercent > 0) ||
            (_selectedFilter == 'Losers' && stock.changePercent < 0) ||
            (_selectedFilter == 'Most Active' && stock.volume > 1000000) ||
            (_selectedFilter == 'Tech' && stock.sector.toLowerCase().contains('tech')) ||
            (_selectedFilter == 'Healthcare' && stock.sector.toLowerCase().contains('health')) ||
            (_selectedFilter == 'Finance' && stock.sector.toLowerCase().contains('financ'));
        
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
          _buildHandle(),
          _buildHeader(),
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: BlocConsumer<StockCubit, StockState>(
              listener: (context, state) {
                if (state is StockLoaded) {
                  _filterStocks(state.stocks);
                }
              },
              builder: (context, state) {
                if (state is StockLoading) {
                  return _buildLoadingState();
                } else if (state is StockLoaded) {
                  return _buildStocksList();
                } else if (state is StockError) {
                  return _buildErrorState(state.message);
                }
                // Show stocks list with current filtered stocks
                return _buildStocksList();
              },
            ),
          ),
          _buildPreviousOrders(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    IconData icon;
    String title;
    String subtitle;
    Color accentColor;

    switch (widget.type) {
      case StockActionType.trending:
        icon = Icons.trending_up;
        title = 'Trending Stocks';
        subtitle = 'Hot stocks right now';
        accentColor = Colors.orange;
        break;
      case StockActionType.movers:
        icon = Icons.show_chart;
        title = 'Market Movers';
        subtitle = 'Top gainers and losers';
        accentColor = Colors.green;
        break;
      case StockActionType.allStocks:
        icon = Icons.explore;
        title = 'Browse Stocks';
        subtitle = 'Discover investment opportunities';
        accentColor = const Color(0xFF4A90E2);
        break;
    }

    return Container(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.3),
                  accentColor.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
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
          Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search stocks...',
                hintStyle: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Get current stocks from the cubit state
                final currentState = context.read<StockCubit>().state;
                if (currentState is StockLoaded) {
                  _filterStocks(currentState.stocks);
                } else if (widget.stocks != null) {
                  _filterStocks(widget.stocks!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Gainers', 'Losers', 'Most Active', 'Tech', 'Healthcare', 'Finance'];
    
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;
          
          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
                // Get current stocks from the cubit state
                final currentState = context.read<StockCubit>().state;
                if (currentState is StockLoaded) {
                  _filterStocks(currentState.stocks);
                } else if (widget.stocks != null) {
                  _filterStocks(widget.stocks!);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            const Color(0xFF4A90E2),
                            const Color(0xFF357ABD),
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Text(
                  filter,
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.white : Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStocksList() {
    if (_filteredStocks.isEmpty) {
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
      itemCount: _filteredStocks.length,
      itemBuilder: (context, index) {
        final stock = _filteredStocks[index];
        return _buildStockItem(stock);
      },
    );
  }

  Widget _buildStockItem(Stock stock) {
    final isPositive = stock.changePercent >= 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
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
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => _showStockActions(stock),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[100]!],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      stock.symbol[0],
                      style: GoogleFonts.inter(
                        color: Colors.grey[700],
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
                          fontSize: 14.sp,
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isPositive 
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          color: isPositive ? Colors.green : Colors.red,
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
        ),
      ),
    );
  }

  Widget _buildPreviousOrders() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: const Color(0xFF4A90E2),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Previous Orders',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to orders tab
                  // This would need to be implemented based on your tab controller
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4A90E2),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...List.generate(3, (index) => _buildOrderItem(index)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(int index) {
    final orders = [
      {'symbol': 'AAPL', 'type': 'BUY', 'shares': '10', 'price': '\$175.43', 'date': '2 days ago'},
      {'symbol': 'MSFT', 'type': 'SELL', 'shares': '5', 'price': '\$378.85', 'date': '1 week ago'},
      {'symbol': 'GOOGL', 'type': 'BUY', 'shares': '2', 'price': '\$2,847.63', 'date': '2 weeks ago'},
    ];
    
    final order = orders[index];
    final isBuy = order['type'] == 'BUY';
    
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: InkWell(
        onTap: () => _showOrderDetails(order),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isBuy 
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                order['type']!,
                style: GoogleFonts.inter(
                  color: isBuy ? Colors.green : Colors.red,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order['shares']} shares of ${order['symbol']}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'at ${order['price']} • ${order['date']}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: const Color(0xFF4A90E2),
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
            message,
            style: GoogleFonts.inter(
              color: Colors.red,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showStockActions(Stock stock) {
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
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[100]!],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      stock.symbol[0],
                      style: GoogleFonts.inter(
                        color: Colors.grey[700],
                        fontSize: 20.sp,
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
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        stock.name,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '\$${stock.currentPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                        'stock': stock,
                        'tradeType': 'buy',
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
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
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                        'stock': stock,
                        'tradeType': 'sell',
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Sell',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.stockDetails, arguments: stock);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'View Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(Map<String, String> order) {
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
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Order Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildOrderDetailRow('Symbol', order['symbol']!),
                  _buildOrderDetailRow('Type', order['type']!),
                  _buildOrderDetailRow('Shares', order['shares']!),
                  _buildOrderDetailRow('Price', order['price']!),
                  _buildOrderDetailRow('Date', order['date']!),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Create a mock Stock object for repeat order
                  final symbol = order['symbol']!;
                  final price = double.tryParse(order['price']!.replaceAll('\$', '')) ?? 100.0;
                  final stock = Stock(
                    symbol: symbol,
                    name: '$symbol Inc.',
                    currentPrice: price,
                    previousClose: price - 1.0,
                    change: 1.0,
                    changePercent: 1.0,
                    dayHigh: price + 5.0,
                    dayLow: price - 5.0,
                    volume: 1000000,
                    marketCap: 1000000000,
                    peRatio: 25.0,
                    dividendYield: 2.5,
                    sector: 'Technology',
                    industry: 'Software',
                    logoUrl: 'https://via.placeholder.com/64x64/4A90E2/FFFFFF?text=${symbol[0]}',
                    priceHistory: [],
                    lastUpdated: DateTime.now(),
                    weekHigh52: price + 50.0,
                    weekLow52: price - 50.0,
                    avgVolume: 1500000,
                    beta: 1.2,
                    eps: 5.0,
                    description: 'A leading technology company',
                    exchange: 'NASDAQ',
                    currency: 'USD',
                  );
                  // Navigate to trade amount screen with proper stock object
                  Get.toNamed(AppRoutes.stockTradeAmount, arguments: {
                    'stock': stock,
                    'tradeType': order['type']!.toLowerCase(),
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Repeat Order',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 