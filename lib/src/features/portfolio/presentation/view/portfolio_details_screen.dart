import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_state.dart';
import 'package:lazervault/src/features/portfolio/domain/entities/portfolio_entity.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class PortfolioDetailsScreen extends StatefulWidget {
  const PortfolioDetailsScreen({super.key});

  @override
  State<PortfolioDetailsScreen> createState() => _PortfolioDetailsScreenState();
}

class _PortfolioDetailsScreenState extends State<PortfolioDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String _selectedAssetType = 'all';
  String _selectedTimeframe = '1M';
  final List<String> _timeframes = ['1W', '1M', '3M', '6M', '1Y', 'ALL'];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PortfolioCubit>()..loadPortfolio(),
      child: Scaffold(
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
                Expanded(
                  child: BlocBuilder<PortfolioCubit, PortfolioState>(
                    builder: (context, state) {
                      if (state is PortfolioLoading) {
                        return _buildLoadingState();
                      } else if (state is PortfolioLoaded) {
                        return _buildContent(state.portfolio);
                      } else if (state is PortfolioError) {
                        return _buildErrorState(state.message);
                      }
                      return _buildLoadingState();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
            Color.fromARGB(255, 20, 1, 39).withValues(alpha: 0.2),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: 12.w),
          Text(
            'Portfolio',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<PortfolioCubit>().refreshPortfolio();
            },
          ),
                ServiceVoiceButton(
          serviceName: 'portfolio',
        ),
],
      ),
    );
  }

  Widget _buildContent(Portfolio portfolio) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<PortfolioCubit>().refreshPortfolio();
      },
      color: Color.fromARGB(255, 78, 3, 208),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPortfolioSummary(portfolio.summary),
              SizedBox(height: 24.h),
              _buildTimeframeSelector(),
              SizedBox(height: 24.h),
              _buildPerformanceChart(portfolio),
              SizedBox(height: 32.h),
              _buildMetricsGrid(portfolio.summary),
              SizedBox(height: 32.h),
              _buildAssetTypeFilter(portfolio),
              SizedBox(height: 16.h),
              _buildAssetsList(portfolio),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioSummary(PortfolioSummary summary) {
    final isPositive = summary.totalGainLoss >= 0;
    final gainLossColor = isPositive ? Colors.green : Colors.red;
    final gainLossIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 20, 1, 39),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
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
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Total Portfolio Value',
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            '${summary.currency} ${summary.totalValue.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                gainLossIcon,
                color: gainLossColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                '${isPositive ? '+' : ''}${summary.currency} ${summary.totalGainLoss.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: gainLossColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(${isPositive ? '+' : ''}${summary.totalGainLossPercent.toStringAsFixed(2)}%)',
                style: GoogleFonts.poppins(
                  color: gainLossColor.withValues(alpha: 0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Invested',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${summary.currency} ${summary.totalInvested.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Assets',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${summary.assetCount}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
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

  Widget _buildTimeframeSelector() {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _timeframes.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final timeframe = _timeframes[index];
          final isSelected = _selectedTimeframe == timeframe;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeframe = timeframe;
              });
              // TODO: Load portfolio history for selected timeframe
              // context.read<PortfolioCubit>().loadHistory(_selectedTimeframe);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? Color.fromARGB(255, 78, 3, 208)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected
                      ? Color.fromARGB(255, 78, 3, 208)
                      : Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  timeframe,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPerformanceChart(Portfolio portfolio) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white.withValues(alpha: 0.05),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40.w,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${(value / 1000).toStringAsFixed(0)}K',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 10.sp,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30.h,
                      getTitlesWidget: (value, meta) {
                        final labels = ['W1', 'W2', 'W3', 'W4'];
                        if (value.toInt() >= 0 &&
                            value.toInt() < labels.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              labels[value.toInt()],
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 10.sp,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 3,
                minY: 0,
                maxY: portfolio.summary.totalValue * 1.2,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, portfolio.summary.totalInvested * 0.9),
                      FlSpot(1, portfolio.summary.totalInvested * 0.95),
                      FlSpot(2, portfolio.summary.totalInvested),
                      FlSpot(3, portfolio.summary.totalValue),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 78, 3, 208),
                        Color.fromARGB(255, 107, 33, 224),
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                          Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.0),
                        ],
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

  Widget _buildMetricsGrid(PortfolioSummary summary) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      childAspectRatio: 1.5,
      children: [
        _buildMetricCard(
          'Total Value',
          '${summary.currency} ${summary.totalValue.toStringAsFixed(2)}',
          Icons.account_balance_wallet,
          Color.fromARGB(255, 78, 3, 208),
        ),
        _buildMetricCard(
          'Total Invested',
          '${summary.currency} ${summary.totalInvested.toStringAsFixed(2)}',
          Icons.trending_up,
          Color.fromARGB(255, 107, 33, 224),
        ),
        _buildMetricCard(
          'Gain/Loss',
          '${summary.totalGainLoss >= 0 ? '+' : ''}${summary.currency} ${summary.totalGainLoss.toStringAsFixed(2)}',
          summary.totalGainLoss >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
          summary.totalGainLoss >= 0 ? Colors.green : Colors.red,
        ),
        _buildMetricCard(
          'Return %',
          '${summary.totalGainLoss >= 0 ? '+' : ''}${summary.totalGainLossPercent.toStringAsFixed(2)}%',
          Icons.percent,
          summary.totalGainLoss >= 0 ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16.sp,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetTypeFilter(Portfolio portfolio) {
    // Calculate asset type distribution
    final assetTypes = <String, int>{};
    for (final asset in portfolio.assets) {
      assetTypes[asset.assetType] = (assetTypes[asset.assetType] ?? 0) + 1;
    }

    final filters = [
      {'label': 'All', 'value': 'all', 'count': portfolio.assets.length},
      if (assetTypes.containsKey('crypto'))
        {'label': 'Crypto', 'value': 'crypto', 'count': assetTypes['crypto']},
      if (assetTypes.containsKey('stock'))
        {'label': 'Stocks', 'value': 'stock', 'count': assetTypes['stock']},
      if (assetTypes.containsKey('investment'))
        {'label': 'Investments', 'value': 'investment', 'count': assetTypes['investment']},
      if (assetTypes.containsKey('account'))
        {'label': 'Accounts', 'value': 'account', 'count': assetTypes['account']},
      if (assetTypes.containsKey('savings'))
        {'label': 'Savings', 'value': 'savings', 'count': assetTypes['savings']},
      if (assetTypes.containsKey('financial_goal'))
        {'label': 'Goals', 'value': 'financial_goal', 'count': assetTypes['financial_goal']},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assets',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 40.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final isSelected = _selectedAssetType == filter['value'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAssetType = filter['value'] as String;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color.fromARGB(255, 78, 3, 208)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? Color.fromARGB(255, 78, 3, 208)
                          : Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        filter['label'] as String,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${filter['count']}',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAssetsList(Portfolio portfolio) {
    // Filter assets based on selected type
    final filteredAssets = _selectedAssetType == 'all'
        ? portfolio.assets
        : portfolio.assets
            .where((asset) => asset.assetType == _selectedAssetType)
            .toList();

    if (filteredAssets.isEmpty) {
      return Container(
        padding: EdgeInsets.all(40.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white.withValues(alpha: 0.3),
                size: 48.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'No assets in this category',
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredAssets.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final asset = filteredAssets[index];
        return _buildAssetItem(asset);
      },
    );
  }

  Widget _buildAssetItem(PortfolioAsset asset) {
    final isPositive = asset.gainLoss >= 0;
    final gainLossColor = isPositive ? Colors.green : Colors.red;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to asset details
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Asset Icon
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: asset.iconUrl != null && asset.iconUrl!.isNotEmpty
                      ? UniversalImageLoader(
                          imagePath: asset.iconUrl!,
                          height: 28.h,
                          width: 28.w,
                        )
                      : Icon(
                          _getAssetIcon(asset.assetType),
                          color: Colors.white,
                          size: 28.sp,
                        ),
                ),
                SizedBox(width: 16.w),

                // Asset Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${asset.quantity.toStringAsFixed(4)} ${asset.symbol}',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _getAssetTypeColor(asset.assetType).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          _getAssetTypeLabel(asset.assetType),
                          style: GoogleFonts.poppins(
                            color: _getAssetTypeColor(asset.assetType),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Asset Value
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${asset.currency} ${asset.currentValue.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
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
                          color: gainLossColor,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${isPositive ? '+' : ''}${asset.gainLossPercent.toStringAsFixed(2)}%',
                          style: GoogleFonts.poppins(
                            color: gainLossColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${isPositive ? '+' : ''}${asset.currency} ${asset.gainLoss.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: gainLossColor.withValues(alpha: 0.8),
                        fontSize: 12.sp,
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

  IconData _getAssetIcon(String assetType) {
    switch (assetType) {
      case 'crypto':
        return Icons.currency_bitcoin;
      case 'stock':
        return Icons.show_chart;
      case 'investment':
        return Icons.trending_up;
      case 'account':
        return Icons.account_balance;
      case 'savings':
        return Icons.savings;
      case 'financial_goal':
        return Icons.flag;
      default:
        return Icons.account_balance_wallet;
    }
  }

  Color _getAssetTypeColor(String assetType) {
    switch (assetType) {
      case 'crypto':
        return const Color(0xFFF7931A); // Bitcoin orange
      case 'stock':
        return const Color(0xFF4285F4); // Blue
      case 'investment':
        return const Color(0xFF34A853); // Green
      case 'account':
        return const Color(0xFFEA4335); // Red
      case 'savings':
        return const Color(0xFFFBBC05); // Yellow
      case 'financial_goal':
        return const Color(0xFF9C27B0); // Purple
      default:
        return Colors.grey;
    }
  }

  String _getAssetTypeLabel(String assetType) {
    switch (assetType) {
      case 'crypto':
        return 'CRYPTO';
      case 'stock':
        return 'STOCK';
      case 'investment':
        return 'INVESTMENT';
      case 'account':
        return 'ACCOUNT';
      case 'savings':
        return 'SAVINGS';
      case 'financial_goal':
        return 'GOAL';
      default:
        return 'ASSET';
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading portfolio...',
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[300],
              size: 64.sp,
            ),
            SizedBox(height: 24.h),
            Text(
              'Error Loading Portfolio',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                context.read<PortfolioCubit>().loadPortfolio();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 78, 3, 208),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
