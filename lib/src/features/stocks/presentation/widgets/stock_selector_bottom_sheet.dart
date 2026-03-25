import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_state.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/stocks/utils/debouncer.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Stock Selector Bottom Sheet
/// Bamboo-style stock discovery interface with search and filtering
/// Returns the selected stock via callback
class StockSelectorBottomSheet extends StatefulWidget {
  final Function(Stock) onStockSelected;
  final String? title;
  final bool showOnlyHoldings;
  final List<Stock>? initialStocks;

  const StockSelectorBottomSheet({
    super.key,
    required this.onStockSelected,
    this.title,
    this.showOnlyHoldings = false,
    this.initialStocks,
  });

  @override
  State<StockSelectorBottomSheet> createState() => _StockSelectorBottomSheetState();
}

class _StockSelectorBottomSheetState extends State<StockSelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  List<Stock> _filteredStocks = [];
  bool _isSearching = false;
  final Debouncer _searchDebouncer = Debouncers.search;

  @override
  void initState() {
    super.initState();
    if (widget.initialStocks != null) {
      _filteredStocks = widget.initialStocks!;
    } else if (widget.showOnlyHoldings) {
      _filteredStocks = [];
      _loadHoldings();
    } else {
      _filteredStocks = [];
      _loadStocks();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }

  void _loadStocks() {
    context.read<StockCubit>().loadStocks(limit: 50);
  }

  void _loadHoldings() {
    context.read<StockCubit>().loadHoldings();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
    });

    if (query.isEmpty) {
      _searchDebouncer.cancel();
      _filterStocks(widget.initialStocks ?? []);
      return;
    }

    // Debounce the search to avoid excessive API calls
    _searchDebouncer.call(() {
      context.read<StockCubit>().searchStocks(query);
    });
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
          if (!widget.showOnlyHoldings) _buildFilterChips(),
          Expanded(
            child: BlocConsumer<StockCubit, StockState>(
              listener: (context, state) {
                if (state is StockLoaded && !_isSearching) {
                  _filterStocks(state.stocks);
                } else if (state is StockSearchLoaded && _isSearching) {
                  _filterStocks(state.searchResults);
                } else if (state is HoldingsLoaded) {
                  // Convert holdings to stocks for display
                  final stocks = state.holdings.map((h) => Stock(
                    symbol: h.symbol,
                    name: h.name,
                    currentPrice: h.currentPrice,
                    previousClose: h.averageCost,
                    change: h.dayChange,
                    changePercent: h.dayChangePercent,
                    dayHigh: h.currentPrice * 1.05,
                    dayLow: h.currentPrice * 0.95,
                    volume: 1000000,
                    marketCap: h.totalValue * 1000,
                    peRatio: 25.0,
                    dividendYield: 2.5,
                    sector: 'Unknown',
                    industry: 'Unknown',
                    logoUrl: h.logoUrl,
                    priceHistory: [],
                    lastUpdated: DateTime.now(),
                    weekHigh52: h.currentPrice * 1.2,
                    weekLow52: h.currentPrice * 0.8,
                    avgVolume: 1000000,
                    beta: 1.0,
                    eps: h.currentPrice * 0.1,
                    description: '${h.name} stock holding',
                    exchange: 'NASDAQ',
                    currency: 'USD',
                  )).toList();
                  _filterStocks(stocks);
                }
              },
              builder: (context, state) {
                if (state is StockLoading || state is HoldingsLoading) {
                  return _buildLoadingState();
                } else if (state is StockError || state is HoldingsError) {
                  return _buildErrorState(state is StockError ? state.message : (state as HoldingsError).message);
                } else if (_isSearching && state is StockSearchLoading) {
                  return _buildLoadingState();
                }
                return _buildStocksList();
              },
            ),
          ),
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
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4A90E2).withValues(alpha: 0.3),
                  const Color(0xFF4A90E2).withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.search,
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
                  widget.title ?? (widget.showOnlyHoldings ? 'Your Holdings' : 'Search Stocks'),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.showOnlyHoldings
                      ? 'Select from your portfolio'
                      : 'Search and select a stock',
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
            offset: const Offset(0, 2),
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
                hintText: widget.showOnlyHoldings
                    ? 'Search your holdings...'
                    : 'Search stocks by symbol or name...',
                hintStyle: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
              ),
              onChanged: _onSearchChanged,
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
                } else if (currentState is StockSearchLoaded) {
                  _filterStocks(currentState.searchResults);
                } else if (widget.initialStocks != null) {
                  _filterStocks(widget.initialStocks!);
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
                      offset: const Offset(0, 2),
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
              _searchController.text.isEmpty
                  ? 'No stocks available'
                  : 'No stocks found',
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            widget.onStockSelected(stock);
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withValues(alpha: 0.3),
                        const Color(0xFF4A90E2).withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      stock.symbol.length > 2
                          ? stock.symbol.substring(0, 2).toUpperCase()
                          : stock.symbol.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4A90E2),
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
                      CurrencySymbols.formatAmountWithCurrency(stock.currentPrice, stock.currency),
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

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: const Color(0xFF4A90E2),
          ),
          SizedBox(height: 16.h),
          Text(
            _isSearching ? 'Searching stocks...' : 'Loading stocks...',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
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
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _loadStocks,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
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

/// Helper function to show the stock selector bottom sheet
Future<Stock?> showStockSelector(
  BuildContext context, {
  String? title,
  bool showOnlyHoldings = false,
  List<Stock>? initialStocks,
}) {
  return showModalBottomSheet<Stock>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => StockSelectorBottomSheet(
      title: title,
      showOnlyHoldings: showOnlyHoldings,
      initialStocks: initialStocks,
      onStockSelected: (stock) {
        Navigator.of(context).pop(stock);
      },
    ),
  );
}
