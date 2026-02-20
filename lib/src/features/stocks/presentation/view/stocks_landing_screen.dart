import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../widgets/market_index_card.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/quick_action_button.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/stocks/presentation/widgets/stocks_voice_agent_button.dart';

/// Professional Stocks Landing Screen
/// Figma-standard landing page with invoice theme colors
/// Hero section, portfolio summary, quick actions, market data
class StocksLandingScreen extends StatefulWidget {
  const StocksLandingScreen({super.key});

  @override
  State<StocksLandingScreen> createState() => _StocksLandingScreenState();
}

class _StocksLandingScreenState extends State<StocksLandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupScrollListener();
    _loadInitialData();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: InvoiceThemeColors.primaryBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_showAppBarTitle) {
        setState(() => _showAppBarTitle = true);
      } else if (_scrollController.offset <= 100 && _showAppBarTitle) {
        setState(() => _showAppBarTitle = false);
      }
    });
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockCubit>().loadPortfolio();
      context.read<StockCubit>().loadMarketIndices();
      context.read<StockCubit>().loadStocks(limit: 10);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String? _getAccessToken() {
    return null; // Will be passed via context
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
              InvoiceThemeColors.primaryBackground,
            ],
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildCustomAppBar(),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
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
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: InvoiceThemeColors.borderColor,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: InvoiceThemeColors.textWhite,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  opacity: _showAppBarTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'Stocks',
                    style: InvoiceTextStyles.header20,
                  ),
                ),
                if (!_showAppBarTitle) ...[
                  Text(
                    'Stock Trading',
                    style: InvoiceTextStyles.header20,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Buy, sell & manage your portfolio',
                    style: InvoiceTextStyles.small12,
                  ),
                ],
              ],
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'stocks',
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Stocks',
            sourceContext: 'investments',
            icon: Icons.chat_bubble_outline,
            iconColor: InvoiceThemeColors.primaryPurple,
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
                style: InvoiceTextStyles.body14,
              ),
              backgroundColor: InvoiceThemeColors.errorRed,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<StockCubit>().loadPortfolio();
            context.read<StockCubit>().loadMarketIndices();
            context.read<StockCubit>().loadStocks(limit: 10);
          },
          backgroundColor: InvoiceThemeColors.secondaryBackground,
          color: InvoiceThemeColors.primaryPurple,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: 8.h),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildHeroSection(),
                ),
              ),
              SizedBox(height: 24.h),
              _buildQuickActions(),
              SizedBox(height: 24.h),
              _buildMarketIndices(state),
              SizedBox(height: 24.h),
              _buildPortfolioSummary(state),
              SizedBox(height: 24.h),
              _buildTopMovers(state),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: InvoiceDecorations.elevatedCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      InvoiceThemeColors.primaryPurple,
                      InvoiceThemeColors.gradientPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.show_chart,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Stocks',
                      style: InvoiceTextStyles.header20,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Start your investing journey today',
                      style: InvoiceTextStyles.small12,
                    ),
                  ],
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
      padding: EdgeInsets.all(20.w),
      decoration: InvoiceDecorations.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: InvoiceTextStyles.header18,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickActionButton(
                icon: Icons.add_circle_outline,
                label: 'Buy',
                color: InvoiceThemeColors.successGreen,
                onTap: () => _navigateToTrade(isBuy: true),
              ),
              QuickActionButton(
                icon: Icons.remove_circle_outline,
                label: 'Sell',
                color: InvoiceThemeColors.errorRed,
                onTap: () => _navigateToTrade(isBuy: false),
              ),
              QuickActionButton(
                icon: Icons.account_balance_wallet,
                label: 'Portfolio',
                color: InvoiceThemeColors.primaryPurple,
                onTap: () => Get.toNamed(AppRoutes.stockPortfolio),
              ),
              QuickActionButton(
                icon: Icons.bookmark_outline,
                label: 'Watchlist',
                color: InvoiceThemeColors.warningOrange,
                onTap: () => Get.toNamed(AppRoutes.stockWatchlist),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndices(StockState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Market Overview',
              style: InvoiceTextStyles.header18,
            ),
            if (state is MarketIndicesLoaded)
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: InvoiceTextStyles.small12.copyWith(
                    color: InvoiceThemeColors.primaryPurple,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (state is MarketIndicesLoaded)
          _buildMarketIndicesGrid(state.indices)
        else
          _buildMarketIndicesSkeleton(),
      ],
    );
  }

  Widget _buildMarketIndicesGrid(Map<String, double> indices) {
    final entries = indices.entries.take(4).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.6,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        return MarketIndexCard(
          name: entries[index].key,
          value: entries[index].value.toStringAsFixed(2),
          change: '0.0%',
          isPositive: true,
        );
      },
    );
  }

  Widget _buildMarketIndicesSkeleton() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.6,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: InvoiceThemeColors.borderColor,
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
              InvoiceThemeColors.primaryPurple.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioSummary(StockState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Portfolio',
              style: InvoiceTextStyles.header18,
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.stockPortfolio),
              child: Text(
                'View Details',
                style: InvoiceTextStyles.small12.copyWith(
                  color: InvoiceThemeColors.primaryPurple,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (state is PortfolioLoaded)
          PortfolioSummaryCard(
            portfolio: state.portfolio,
            onTap: () => Get.toNamed(AppRoutes.stockPortfolio),
          )
        else
          _buildPortfolioSkeleton(),
      ],
    );
  }

  Widget _buildPortfolioSkeleton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: InvoiceDecorations.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Value',
            style: InvoiceTextStyles.label12,
          ),
          SizedBox(height: 12.h),
          Container(
            width: 120.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: InvoiceThemeColors.tertiaryBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 80.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.tertiaryBackground,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopMovers(StockState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Stocks',
              style: InvoiceTextStyles.header18,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: InvoiceTextStyles.small12.copyWith(
                  color: InvoiceThemeColors.primaryPurple,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (state is StockLoaded && state.stocks.isNotEmpty)
          _buildStocksList(state.stocks.take(5).toList())
        else
          _buildTopMoversSkeleton(),
      ],
    );
  }

  Widget _buildStocksList(List stocks) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stocks.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => _buildStockCard(stocks[index]),
    );
  }

  Widget _buildStockCard(dynamic stock) {
    // Handle both StockEntity and Map types
    final String symbol = (stock.symbol ?? stock['symbol'] ?? 'N/A').toString();
    final String name = (stock.name ?? stock['name'] ?? 'Unknown').toString();
    final price = stock.price ?? stock['price'] ?? 0.0;
    final change = stock.change ?? stock['change'] ?? 0.0;
    final isPositive = change >= 0;

    return GestureDetector(
      onTap: () => _navigateToStockDetails(symbol),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: InvoiceDecorations.cardDecoration,
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
                    InvoiceThemeColors.gradientPurple.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  symbol.substring(0, math.min(3, symbol.length)).toUpperCase(),
                  style: InvoiceTextStyles.header16.copyWith(
                    fontSize: 12.sp,
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
                    symbol.toUpperCase(),
                    style: InvoiceTextStyles.header16,
                  ),
                  Text(
                    name,
                    style: InvoiceTextStyles.small11,
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
                  '\$${price.toStringAsFixed(2)}',
                  style: InvoiceTextStyles.body14Medium,
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? InvoiceThemeColors.successGreen.withValues(alpha: 0.2)
                        : InvoiceThemeColors.errorRed.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
                    style: InvoiceTextStyles.tiny10.copyWith(
                      color: isPositive
                          ? InvoiceThemeColors.successGreen
                          : InvoiceThemeColors.errorRed,
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

  Widget _buildTopMoversSkeleton() {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            height: 80.h,
            decoration: InvoiceDecorations.cardDecoration,
          ),
        ),
      ),
    );
  }

  void _navigateToTrade({required bool isBuy}) {
    Get.toNamed(
      AppRoutes.stockTrade,
      arguments: {'isBuy': isBuy},
    );
  }

  void _navigateToStockDetails(String symbol) {
    Get.toNamed(
      AppRoutes.stockDetails,
      arguments: {'symbol': symbol},
    );
  }
}
