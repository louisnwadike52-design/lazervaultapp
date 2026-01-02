import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../widgets/market_index_card.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/watchlist_preview_card.dart';
import '../widgets/quick_action_button.dart';

/// Modern stocks home screen - Main entry point for stocks feature
/// Follows insurance pattern with market-themed gradient and modern UI
class StocksHomeScreen extends StatefulWidget {
  const StocksHomeScreen({super.key});

  @override
  State<StocksHomeScreen> createState() => _StocksHomeScreenState();
}

class _StocksHomeScreenState extends State<StocksHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
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
    // Load all data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockCubit>().loadPortfolio();
      context.read<StockCubit>().loadWatchlists();
      context.read<StockCubit>().loadMarketIndices();
    });

    return _buildStocksHome();
  }

  Widget _buildStocksHome() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0A1628), // Deep market blue
              const Color(0xFF0F172A), // Dark navy
              const Color(0xFF0A0E1A), // Almost black
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildContent(),
                  ),
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
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Markets',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Trade stocks & manage portfolio',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF94A3B8),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF0A1628),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<StockCubit, StockState>(
      listener: (context, state) {
        if (state is StockError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: Colors.red[700],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is StockLoading) {
          return _buildLoadingState();
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<StockCubit>().loadPortfolio();
            context.read<StockCubit>().loadWatchlists();
          },
          backgroundColor: const Color(0xFF1E293B),
          color: const Color(0xFF3B82F6),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: 8.h),
              _buildQuickActions(),
              SizedBox(height: 24.h),
              _buildMarketIndices(),
              SizedBox(height: 24.h),
              _buildPortfolioSummary(state),
              SizedBox(height: 24.h),
              _buildWatchlistPreview(state),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3B82F6),
                  const Color(0xFF8B5CF6),
                ],
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
              child: SizedBox(
                width: 30.w,
                height: 30.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Loading market data...',
            style: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          QuickActionButton(
            icon: Icons.show_chart,
            label: 'Trade',
            color: const Color(0xFF3B82F6),
            onTap: () => Get.toNamed(AppRoutes.stockTrade),
          ),
          QuickActionButton(
            icon: Icons.pie_chart_outline,
            label: 'Portfolio',
            color: const Color(0xFF10B981),
            onTap: () => Get.toNamed(AppRoutes.stockPortfolio),
          ),
          QuickActionButton(
            icon: Icons.bookmark_outline,
            label: 'Watchlist',
            color: const Color(0xFFF59E0B),
            onTap: () => Get.toNamed(AppRoutes.stockWatchlist),
          ),
          QuickActionButton(
            icon: Icons.receipt_long_outlined,
            label: 'Orders',
            color: const Color(0xFF8B5CF6),
            onTap: () => Get.toNamed(AppRoutes.stockOrders),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndices() {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is MarketIndicesLoaded) {
          final indices = state.indices.entries.take(4).toList();

          if (indices.isEmpty) {
            return _buildEmptyMarketIndices();
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
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.stocks),
                    child: Text(
                      'View All',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ...List.generate((indices.length / 2).ceil(), (rowIndex) {
                final firstIndex = rowIndex * 2;
                final secondIndex = firstIndex + 1;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      if (firstIndex < indices.length)
                        Expanded(
                          child: MarketIndexCard(
                            name: indices[firstIndex].key,
                            value: indices[firstIndex].value.toStringAsFixed(2),
                            change: '0.0%', // TODO: Backend should provide change percentage
                            isPositive: true, // TODO: Backend should provide change direction
                          ),
                        ),
                      if (secondIndex < indices.length) ...[
                        SizedBox(width: 12.w),
                        Expanded(
                          child: MarketIndexCard(
                            name: indices[secondIndex].key,
                            value: indices[secondIndex].value.toStringAsFixed(2),
                            change: '0.0%', // TODO: Backend should provide change percentage
                            isPositive: true, // TODO: Backend should provide change direction
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],
          );
        }

        // Loading state
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
              ],
            ),
            SizedBox(height: 12.h),
            _buildMarketIndicesLoadingSkeleton(),
          ],
        );
      },
    );
  }

  Widget _buildMarketIndicesLoadingSkeleton() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSkeletonCard()),
            SizedBox(width: 12.w),
            Expanded(child: _buildSkeletonCard()),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildSkeletonCard()),
            SizedBox(width: 12.w),
            Expanded(child: _buildSkeletonCard()),
          ],
        ),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 20.w,
          height: 20.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF3B82F6).withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyMarketIndices() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.show_chart,
            size: 48.sp,
            color: const Color(0xFF94A3B8),
          ),
          SizedBox(height: 12.h),
          Text(
            'Market data unavailable',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Unable to fetch market indices at this time',
            style: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary(StockState state) {
    if (state is PortfolioLoaded) {
      return PortfolioSummaryCard(
        portfolio: state.portfolio,
        onTap: () => Get.toNamed(AppRoutes.stockPortfolio),
      );
    }

    return PortfolioSummaryCard(
      portfolio: null,
      onTap: () => Get.toNamed(AppRoutes.stockPortfolio),
    );
  }

  Widget _buildWatchlistPreview(StockState state) {
    // TODO: Watchlist entity only contains symbols (List<String>), not Stock objects
    // Need to fetch stock details from symbols or update backend to include stock data
    // For now, show empty watchlist preview
    return WatchlistPreviewCard(
      stocks: [],
      onTap: () => Get.toNamed(AppRoutes.stockWatchlist),
    );
  }
}
