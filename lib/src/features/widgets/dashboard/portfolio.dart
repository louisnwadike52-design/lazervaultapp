import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_state.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PortfolioCubit>()..loadPortfolio(),
      child: Container(
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
              color: Color.fromARGB(255, 20, 1, 39).withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Portfolio',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.portfolioDetails);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Portfolio Value
                _buildPortfolioValue(state),

                SizedBox(height: 16.h),

                // Assets Preview (show top 4 assets)
                if (state is PortfolioLoaded) _buildAssetsList(state),
                if (state is PortfolioLoading) _buildLoadingState(),
                if (state is PortfolioError) _buildErrorState(state.message),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortfolioValue(PortfolioState state) {
    String totalValue = '£0.00';
    String gainLoss = '+£0.00';
    Color gainLossColor = Colors.green;

    if (state is PortfolioSummaryLoaded) {
      totalValue = '${state.summary.currency} ${state.summary.totalValue.toStringAsFixed(2)}';
      final isPositive = state.summary.totalGainLoss >= 0;
      gainLoss = '${isPositive ? '+' : ''}${state.summary.currency} ${state.summary.totalGainLoss.toStringAsFixed(2)}';
      gainLossColor = isPositive ? Colors.green : Colors.red;
    } else if (state is PortfolioLoaded) {
      totalValue = '${state.portfolio.summary.currency} ${state.portfolio.summary.totalValue.toStringAsFixed(2)}';
      final isPositive = state.portfolio.summary.totalGainLoss >= 0;
      gainLoss = '${isPositive ? '+' : ''}${state.portfolio.summary.currency} ${state.portfolio.summary.totalGainLoss.toStringAsFixed(2)}';
      gainLossColor = isPositive ? Colors.green : Colors.red;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Portfolio Value',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                totalValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                gainLoss,
                style: TextStyle(
                  color: gainLossColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsList(PortfolioLoaded state) {
    // Show only top 4 assets
    final assets = state.portfolio.assets.take(4).toList();

    if (assets.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            'No assets yet',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: assets.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final asset = assets[index];
        final isPositive = asset.gainLoss >= 0;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigate to asset details
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
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: asset.iconUrl != null && asset.iconUrl!.isNotEmpty
                          ? UniversalImageLoader(
                              imagePath: asset.iconUrl!,
                              height: 24.h,
                              width: 24.w,
                            )
                          : Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 24.sp,
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${asset.quantity.toStringAsFixed(4)} ${asset.symbol}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14.sp,
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${isPositive ? '+' : ''}${asset.gainLossPercent.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: isPositive ? Colors.green : Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
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
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[300],
            size: 32.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[200],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () {
              context.read<PortfolioCubit>().loadPortfolio();
            },
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
