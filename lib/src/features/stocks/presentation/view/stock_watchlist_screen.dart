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
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Bamboo-style Watchlist Screen
/// Manage and track favorite stocks
class StockWatchlistScreen extends StatefulWidget {
  const StockWatchlistScreen({super.key});

  @override
  State<StockWatchlistScreen> createState() => _StockWatchlistScreenState();
}

class _StockWatchlistScreenState extends State<StockWatchlistScreen> {
  /// Whether the search field is showing. The magnifier used to call a
  /// `_showSearch` that only toasted "Search functionality coming soon".
  bool _searching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filters the loaded watchlist by symbol or name.
  ///
  /// Local on purpose: the watchlist is already fully in memory from
  /// `loadWatchlist`, so filtering needs no request and works offline. Matching
  /// covers both fields because people look for "AAPL" and for "Apple".
  List<Stock> _filtered(List<Stock> all) {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all
        .where((s) =>
            s.symbol.toLowerCase().contains(q) ||
            s.name.toLowerCase().contains(q))
        .toList();
  }

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;
      // Clear on close so reopening does not silently re-apply an old filter to
      // a list the user believes is complete.
      if (!_searching) _searchController.clear();
    });
  }

  void _loadWatchlist() {
    context.read<StockCubit>().loadWatchlist();
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
              if (_searching) _buildSearchField(),
              Expanded(
                child: BlocBuilder<StockCubit, StockState>(
                  builder: (context, state) {
                    if (state is WatchlistLoading) {
                      return _buildLoadingState();
                    }

                    final loaded = state is WatchlistLoaded
                        ? state.stocks
                        : <Stock>[];

                    if (loaded.isEmpty) {
                      return _buildEmptyState();
                    }

                    final watchlist = _filtered(loaded);

                    // A watchlist that HAS entries but none matching must not
                    // fall through to the "your watchlist is empty" state — that
                    // reads as data loss rather than a filter with no hits.
                    if (watchlist.isEmpty) {
                      return _buildNoSearchResults();
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        _loadWatchlist();
                      },
                      backgroundColor: const Color(0xFF1E293B),
                      color: const Color(0xFF6366F1),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: watchlist.length,
                        itemBuilder: (context, index) {
                          return _buildWatchlistCard(watchlist[index], index);
                        },
                      ),
                    );
                  },
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
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
                  'Watchlist',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Your favorite stocks',
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
                Icons.search,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: _toggleSearch,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistCard(Stock stock, int index) {
    final isPositive = stock.changePercent >= 0;

    return GestureDetector(
      onTap: () => Get.to(() => StockDetailsScreen(stock: stock)),
      child: Dismissible(
        key: Key(stock.symbol),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          _removeFromWatchlist(stock);
        },
        background: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
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
              // Position indicator
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6366F1),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Stock icon
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
              // Stock info
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
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Price and change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(stock.currentPrice, stock.currency),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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
                        '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          color: isPositive ? Colors.green : Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Star icon
              IconButton(
                icon: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.sp,
                ),
                onPressed: () => _removeFromWatchlist(stock),
              ),
            ],
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
          LazerVaultLoader.medium(),
          SizedBox(height: 16.h),
          Text(
            'Loading watchlist...',
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
              color: Colors.amber.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.star_border,
              size: 40.sp,
              color: Colors.amber,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No watchlist yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add stocks to your watchlist to track them',
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

  void _removeFromWatchlist(Stock stock) {
    context.read<StockCubit>().removeFromWatchlist(stock.symbol);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${stock.symbol} removed from watchlist',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            context.read<StockCubit>().addToWatchlist(stock.symbol);
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        // Rebuilds on every keystroke so the list filters as the user types —
        // the BlocBuilder below reads _filtered() during build.
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Search symbol or name',
          hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.4), fontSize: 14.sp),
          prefixIcon: Icon(Icons.search,
              color: Colors.white.withValues(alpha: 0.4), size: 20.sp),
          suffixIcon: IconButton(
            icon: Icon(Icons.close,
                color: Colors.white.withValues(alpha: 0.6), size: 20.sp),
            onPressed: _toggleSearch,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.06),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded,
                color: Colors.white.withValues(alpha: 0.3), size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              'No match for "${_searchController.text.trim()}"',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7), fontSize: 14.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'Your watchlist still has its other entries.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4), fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
