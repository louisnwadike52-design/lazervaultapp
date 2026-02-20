import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
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
      subtitle: 'Individual company shares',
      description: 'Buy and sell shares of your favorite companies',
      icon: Icons.trending_up,
      color: const Color(0xFF4CAF50),
      route: AppRoutes.stocks,
      isPopular: true,
      expectedReturn: '8-12%',
      riskLevel: 'Medium',
    ),
    InvestmentOption(
      title: 'ETFs',
      subtitle: 'Exchange Traded Funds',
      description: 'Diversified portfolios with lower risk',
      icon: Icons.pie_chart,
      color: const Color(0xFF2196F3),
      route: null, // Coming soon
      isPopular: false,
      expectedReturn: '6-10%',
      riskLevel: 'Low-Medium',
    ),
    InvestmentOption(
      title: 'Mutual Funds',
      subtitle: 'Professionally managed',
      description: 'Let experts manage your investments',
      icon: Icons.account_balance,
      color: const Color(0xFF9C27B0),
      route: null, // Coming soon
      isPopular: false,
      expectedReturn: '5-9%',
      riskLevel: 'Low',
    ),
    InvestmentOption(
      title: 'Bonds',
      subtitle: 'Fixed income securities',
      description: 'Stable returns with lower volatility',
      icon: Icons.security,
      color: const Color(0xFF607D8B),
      route: null, // Coming soon
      isPopular: false,
      expectedReturn: '3-6%',
      riskLevel: 'Low',
    ),
    InvestmentOption(
      title: 'Real Estate',
      subtitle: 'Property investments',
      description: 'Invest in real estate through REITs',
      icon: Icons.home,
      color: const Color(0xFF795548),
      route: null, // Coming soon
      isPopular: false,
      expectedReturn: '7-11%',
      riskLevel: 'Medium',
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
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CustomScrollView(
                slivers: [
                  _buildSliverAppBar(),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 16.h),
                        _buildHeaderSection(),
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
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back,
            color: InvoiceThemeColors.textWhite,
            size: 20.sp,
          ),
        ),
        onPressed: () => Get.toNamed(AppRoutes.dashboard),
      ),
      title: Text(
        'Investments',
        style: InvoiceTextStyles.header20,
      ),
      centerTitle: true,
      floating: true,
      snap: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: MicroserviceChatIcon(
            serviceName: 'Investments',
            sourceContext: 'investments',
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            InvoiceThemeColors.alternativePurple,
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
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
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.trending_up,
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
                      'Start Your Investment Journey',
                      style: InvoiceTextStyles.header16,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Choose from various investment options',
                      style: InvoiceTextStyles.small12,
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

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: InvoiceThemeColors.textWhite.withValues(alpha: 0.8),
              size: 16.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: InvoiceTextStyles.body14Medium,
            ),
            Text(
              title,
              style: InvoiceTextStyles.tiny10,
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
              Icons.star,
              color: Colors.amber,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Popular Investments',
              style: InvoiceTextStyles.header18,
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
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: option.color.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
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
                    color: option.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    option.icon,
                    color: option.color,
                    size: 20.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Popular',
                    style: InvoiceTextStyles.tiny10,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              option.title,
              style: InvoiceTextStyles.header16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              option.subtitle,
              style: InvoiceTextStyles.small11,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: Wrap(
                spacing: 4.w,
                runSpacing: 4.h,
                children: [
                  _buildMetricChip(option.expectedReturn, InvoiceThemeColors.successGreen),
                  _buildMetricChip(option.riskLevel, _getRiskColor(option.riskLevel)),
                ],
              ),
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
          'All Investment Options',
          style: InvoiceTextStyles.header18,
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
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: option.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                option.icon,
                color: option.color,
                size: 24.sp,
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
                          option.title,
                          style: InvoiceTextStyles.header16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (option.isPopular) ...[
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.sp,
                        ),
                      ],
                      if (option.route == null) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            'Coming Soon',
                            style: InvoiceTextStyles.tiny10.copyWith(
                              color: InvoiceThemeColors.primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    option.subtitle,
                    style: InvoiceTextStyles.small12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    option.description,
                    style: InvoiceTextStyles.small11,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: [
                      _buildMetricChip('${option.expectedReturn} return', InvoiceThemeColors.successGreen),
                      _buildMetricChip(option.riskLevel, _getRiskColor(option.riskLevel)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: InvoiceThemeColors.textGray600,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: InvoiceTextStyles.tiny10.copyWith(
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return InvoiceThemeColors.successGreen;
      case 'low-medium':
        return Colors.lime;
      case 'medium':
        return InvoiceThemeColors.warningOrange;
      case 'high':
        return InvoiceThemeColors.errorRed;
      default:
        return InvoiceThemeColors.textGray500;
    }
  }

  void _handleInvestmentTap(InvestmentOption option) {
    if (option.route != null) {
      Get.toNamed(option.route!);
    } else {
      // Show coming soon dialog
      Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.upcoming_outlined,
                  color: InvoiceThemeColors.primaryPurple,
                  size: 48.sp,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Coming Soon',
                  style: InvoiceTextStyles.header20,
                ),
                SizedBox(height: 8.h),
                Text(
                  '${option.title} investments will be available soon!',
                  textAlign: TextAlign.center,
                  style: InvoiceTextStyles.body14,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InvoiceThemeColors.primaryPurple,
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Got it',
                      style: InvoiceTextStyles.button14,
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
  final bool isPopular;
  final String expectedReturn;
  final String riskLevel;

  InvestmentOption({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    this.route,
    this.isPopular = false,
    required this.expectedReturn,
    required this.riskLevel,
  });
} 