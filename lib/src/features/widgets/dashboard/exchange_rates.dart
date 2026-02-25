import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/cubit/dashboard_rates_cubit.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/cubit/dashboard_rates_state.dart';
import 'package:lazervault/src/features/widgets/dashboard/country_rate_card.dart';

class ExchangeRates extends StatelessWidget {
  const ExchangeRates({super.key});

  String _formatLastUpdated(DateTime lastUpdated) {
    final diff = DateTime.now().difference(lastUpdated);
    if (diff.inMinutes < 1) return 'Live rates';
    if (diff.inMinutes < 60) return 'Updated ${diff.inMinutes}m ago';
    return 'Updated ${diff.inHours}h ago';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardRatesCubit, DashboardRatesState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(state),
              SizedBox(height: 16.h),
              _buildBody(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(DashboardRatesState state) {
    String subtitle = 'Live rates';
    if (state is DashboardRatesLoaded) {
      subtitle = _formatLastUpdated(state.lastUpdated);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.currency_exchange_rounded,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exchange Rates',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.exchangeHome),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 3, 208)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, DashboardRatesState state) {
    if (state is DashboardRatesLoading) {
      return _buildShimmer();
    }

    if (state is DashboardRatesLoaded) {
      return Column(
        children: [
          if (state.isStale)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: const LinearProgressIndicator(
                minHeight: 2,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 78, 3, 208)),
                backgroundColor: Color(0xFFE5E7EB),
              ),
            ),
          SizedBox(
            height: 160.h,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.rates.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: CountryRateCard(rate: state.rates[index]),
                );
              },
            ),
          ),
        ],
      );
    }

    if (state is DashboardRatesError) {
      return SizedBox(
        height: 120.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 32.sp,
                color: Colors.black26,
              ),
              SizedBox(height: 8.h),
              Text(
                'Unable to load rates',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () =>
                    context.read<DashboardRatesCubit>().loadRates('NGN'),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 78, 3, 208)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _buildShimmer();
  }

  Widget _buildShimmer() {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 3,
        itemBuilder: (_, __) => _buildShimmerCard(),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 78, 3, 208)
                  .withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 50.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 60.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
