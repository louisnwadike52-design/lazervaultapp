import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import 'package:lazervault/src/features/investments/presentation/widgets/invest_revolut_segment_pills.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_state.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late PortfolioCubit _portfolioCubit;

  final List<InvestmentOption> investmentOptions = [
    InvestmentOption(
      title: 'Stocks',
      subtitle: 'US & Global stocks via DriveWealth',
      description: 'Trade US stocks. Fractional shares from \$1. Apple, Tesla, NVIDIA & more.',
      icon: Icons.trending_up,
      color: const Color(0xFF10B981),
      route: AppRoutes.stocks,
      isPopular: true,
      riskBadge: 'Medium risk',
      complianceBadge: 'Returns vary',
    ),
    InvestmentOption(
      title: 'Treasury ETFs',
      subtitle: 'US Government bond ETFs',
      description: 'Ultra-low risk. Backed by US Treasury bonds. Stable yield ~4-5% annually.',
      icon: Icons.shield,
      color: const Color(0xFF0EA5E9),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'treasury_etf'},
      isPopular: true,
      riskBadge: 'Very low risk',
      complianceBadge: 'Stable yield',
    ),
    InvestmentOption(
      title: 'ETFs',
      subtitle: 'Exchange-traded funds',
      description: 'Broad market and theme exposure. Often used for diversified, long-term investing.',
      icon: Icons.pie_chart,
      color: const Color(0xFF3B82F6),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'etf'},
      isPopular: false,
      riskBadge: 'Low–medium',
      complianceBadge: 'Past performance ≠ future',
    ),
    InvestmentOption(
      title: 'REITs',
      subtitle: 'Real estate investment trusts',
      description: 'Income from property. REITs pay ~90% of income as dividends. ~3-4% yield.',
      icon: Icons.home_work,
      color: const Color(0xFF795548),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'reit_etf'},
      isPopular: true,
      riskBadge: 'Medium risk',
      complianceBadge: 'Dividend income',
    ),
    InvestmentOption(
      title: 'Bond ETFs',
      subtitle: 'Fixed income funds',
      description: 'Many “bond” exposures in-app are bond ETFs or funds, not primary T-bill auctions.',
      icon: Icons.security,
      color: const Color(0xFF607D8B),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'bond_etf'},
      isPopular: false,
      riskBadge: 'Income focus',
      complianceBadge: 'Yields change',
    ),
    InvestmentOption(
      title: 'Nigerian T-Bills',
      subtitle: 'CBN Treasury Bills',
      description: 'Government-backed. 91-364 day maturities. Historically ~10-18% yield.',
      icon: Icons.account_balance,
      color: const Color(0xFF059669),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'tbill'},
      isPopular: true,
      riskBadge: 'Very low risk',
      complianceBadge: 'Fixed income',
    ),
    InvestmentOption(
      title: 'Mutual Funds',
      subtitle: 'Nigerian managed funds',
      description: 'Money market, equity, and balanced funds via Cowrywise. Professional management.',
      icon: Icons.analytics,
      color: const Color(0xFF9C27B0),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'mutual_fund'},
      isPopular: false,
      riskBadge: 'Varies',
      complianceBadge: 'Managed funds',
    ),
    InvestmentOption(
      title: 'FX Exchange',
      subtitle: 'Currency conversion',
      description: 'Convert between NGN, USD, and GBP with competitive rates.',
      icon: Icons.currency_exchange,
      color: const Color(0xFFF59E0B),
      route: AppRoutes.stocks,
      routeArgs: {'investCollection': 'fx'},
      isPopular: false,
      riskBadge: 'FX rates',
      complianceBadge: 'Live rates',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
    _portfolioCubit = serviceLocator<PortfolioCubit>()..loadSummary();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _portfolioCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestTradingUi.background,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: InvestTradingUi.scaffoldGradient),
                child: CustomScrollView(
                  slivers: [
                  _buildSliverAppBar(),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 16.h),
                        _buildHeaderSection(),
                        SizedBox(height: 20.h),
                        _buildActivityShortcutStrip(),
                        SizedBox(height: 24.h),
                        _buildPopularSection(),
                        SizedBox(height: 24.h),
                        _buildAllInvestmentsSection(),
                        SizedBox(height: 20.h), // Bottom padding
                      ]),
                    ),
                  ),
                ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.w),
          decoration: InvestTradingUi.cardDecoration(
            color: InvestTradingUi.surfaceElevated,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: InvestTradingUi.textPrimary,
            size: 18.sp,
          ),
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Invest',
        style: GoogleFonts.inter(
          color: InvestTradingUi.textPrimary,
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
      centerTitle: true,
      floating: true,
      snap: true,
      actions: [
        ServiceVoiceButton(
          serviceName: 'stocks',
          iconColor: InvestTradingUi.accent,
          backgroundColor: InvestTradingUi.accent,
        ),
        SizedBox(width: 8.w),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: MicroserviceChatIcon(
            serviceName: 'Investments',
            sourceContext: 'investments',
            iconColor: InvestTradingUi.accent,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    const accent = InvestTradingUi.accent;
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: InvestTradingUi.statementCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4.w,
                height: 52.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      accent,
                      accent.withValues(alpha: 0.45),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INVEST',
                      style: InvestTradingUi.eyebrow(accent),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Build your portfolio',
                      style: GoogleFonts.inter(
                        color: InvestTradingUi.textPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Pick an asset class — each hub has its own tools and risk profile.',
                      style: InvestTradingUi.labelMuted().copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              ServiceVoiceButton(
                serviceName: 'stocks',
              ),
            ],
          ),
          SizedBox(height: 20.h),
          BlocBuilder<PortfolioCubit, PortfolioState>(
            bloc: _portfolioCubit,
            builder: (context, state) {
              String portfolioValue = '--';
              String totalReturn = '--';
              if (state is PortfolioSummaryLoaded) {
                portfolioValue = state.summary.formattedTotalValue;
                totalReturn = state.summary.formattedGainLoss;
              } else if (state is PortfolioLoaded) {
                portfolioValue = state.portfolio.summary.formattedTotalValue;
                totalReturn = state.portfolio.summary.formattedGainLoss;
              }
              return Row(
                children: [
                  _buildStatCard('Portfolio Value', portfolioValue, Icons.account_balance_wallet),
                  SizedBox(width: 12.w),
                  _buildStatCard('Total Return', totalReturn, Icons.trending_up),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityShortcutStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your activity',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Jump to portfolio, watchlists, orders, news, or the full asset list.',
          style: InvestTradingUi.labelMuted(),
        ),
        SizedBox(height: 12.h),
        InvestRevolutSegmentPills(
          labels: const [
            'Portfolio',
            'Watchlist',
            'Orders',
            'News',
            'All assets',
          ],
          selectedIndex: null,
          onChanged: (i) {
            const empty = <String, dynamic>{};
            switch (i) {
              case 0:
                Get.toNamed(AppRoutes.stockPortfolio, arguments: empty);
                break;
              case 1:
                Get.toNamed(AppRoutes.stockWatchlist, arguments: empty);
                break;
              case 2:
                Get.toNamed(AppRoutes.stockOrders, arguments: empty);
                break;
              case 3:
                Get.toNamed(AppRoutes.stockNews, arguments: empty);
                break;
              case 4:
                Get.toNamed(AppRoutes.stocks, arguments: empty);
                break;
            }
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvestTradingUi.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: InvestTradingUi.accent,
              size: 18.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: GoogleFonts.inter(
                color: InvestTradingUi.textPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              title,
              style: InvestTradingUi.labelMuted(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularSection() {
    final popularOptions = investmentOptions.where((option) => option.isPopular).toList();

    if (popularOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              color: InvestTradingUi.accent,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Popular',
              style: GoogleFonts.inter(
                color: InvestTradingUi.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 20.w),
            itemCount: popularOptions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: _buildPopularInvestmentCard(popularOptions[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularInvestmentCard(InvestmentOption option) {
    return GestureDetector(
      onTap: () => _handleInvestmentTap(option),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        constraints: BoxConstraints(
          minWidth: 180.w,
          maxWidth: 220.w,
        ),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: InvestTradingUi.surfaceElevated,
          borderRadius: BorderRadius.circular(16.r),
          border: Border(
            left: BorderSide(color: option.color, width: 3.w),
            top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            right: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: option.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: option.color.withValues(alpha: 0.35)),
                  ),
                  child: Icon(
                    option.icon,
                    color: option.color,
                    size: 20.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: option.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'POPULAR',
                    style: InvestTradingUi.eyebrow(option.color).copyWith(fontSize: 9.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              option.title,
              style: GoogleFonts.inter(
                color: InvestTradingUi.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              option.subtitle,
              style: InvestTradingUi.labelMuted(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                _buildMetricChip(option.complianceBadge, InvestTradingUi.buy),
                _buildMetricChip(option.riskBadge, _getRiskColor(option.riskBadge)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllInvestmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All options',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: investmentOptions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildInvestmentCard(investmentOptions[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInvestmentCard(InvestmentOption option) {
    return GestureDetector(
      onTap: () => _handleInvestmentTap(option),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: InvestTradingUi.cardDecoration(
          color: InvestTradingUi.surfaceElevated,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: option.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: option.color.withValues(alpha: 0.35)),
              ),
              child: Icon(
                option.icon,
                color: option.color,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.title,
                          style: GoogleFonts.inter(
                            color: InvestTradingUi.textPrimary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (option.isPopular) ...[
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: option.color,
                          size: 16.sp,
                        ),
                      ],
                      if (option.route == null) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: InvestTradingUi.accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: InvestTradingUi.accent.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            'Soon',
                            style: GoogleFonts.inter(
                              color: InvestTradingUi.accent,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    option.subtitle,
                    style: InvestTradingUi.labelMuted().copyWith(fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    option.description,
                    style: InvestTradingUi.labelMuted().copyWith(height: 1.35),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: [
                      _buildMetricChip(option.complianceBadge, InvestTradingUi.buy),
                      _buildMetricChip(option.riskBadge, _getRiskColor(option.riskBadge)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: InvestTradingUi.textSecondary,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Color _getRiskColor(String riskBadge) {
    final r = riskBadge.toLowerCase();
    if (r.contains('high')) return InvestTradingUi.sell;
    if (r.contains('medium')) return const Color(0xFFFB923C);
    if (r.contains('low') && r.contains('medium')) return InvestTradingUi.accent;
    if (r.contains('low')) return InvestTradingUi.buy;
    return InvestTradingUi.textSecondary;
  }

  void _handleInvestmentTap(InvestmentOption option) {
    if (option.route != null) {
      if (option.routeArgs != null && option.routeArgs!.isNotEmpty) {
        Get.toNamed(option.route!, arguments: option.routeArgs);
      } else {
        // Clear prior route args so generic Stocks is not stuck on e.g. T-Bills hub.
        Get.toNamed(option.route!, arguments: const <String, dynamic>{});
      }
      return;
    } else {
      // Show coming soon dialog
      Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: InvestTradingUi.surfaceElevated,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.schedule_rounded,
                  color: InvestTradingUi.accent,
                  size: 44.sp,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Coming soon',
                  style: GoogleFonts.inter(
                    color: InvestTradingUi.textPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${option.title} will be available in a future release.',
                  textAlign: TextAlign.center,
                  style: InvestTradingUi.labelMuted().copyWith(height: 1.4),
                ),
                SizedBox(height: 22.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Get.back(),
                    style: FilledButton.styleFrom(
                      backgroundColor: InvestTradingUi.accent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      'Got it',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class InvestmentOption {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final String? route;
  final Map<String, dynamic>? routeArgs;
  final bool isPopular;
  final String riskBadge;
  final String complianceBadge;

  InvestmentOption({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    this.route,
    this.routeArgs,
    this.isPopular = false,
    required this.riskBadge,
    required this.complianceBadge,
  });
} 