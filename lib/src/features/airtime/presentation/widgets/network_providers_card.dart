import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../../../../../core/types/app_routes.dart';

class NetworkProvidersCard extends StatelessWidget {
  const NetworkProvidersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Network Providers',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              BlocBuilder<AirtimeCubit, AirtimeState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
                        'country': DefaultCountries.nigeria,
                      });
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          BlocConsumer<AirtimeCubit, AirtimeState>(
            listener: (context, state) {
              if (state is AirtimeNetworkProvidersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to load network providers: ${state.message}'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AirtimeNetworkProvidersLoaded && state.providers.isNotEmpty) {
                return _buildProvidersList(state.providers);
              } else if (state is AirtimeNetworkProvidersLoading) {
                return _buildLoadingState();
              } else if (state is AirtimeNetworkProvidersError) {
                return _buildErrorState(state.message);
              }
              // Default loading state for other states
              return _buildLoadingState();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProvidersList(List<NetworkProvider> providers) {
    return Row(
      children: providers.take(4).map((provider) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _buildProviderItem(provider),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProviderItem(NetworkProvider provider) {
    return GestureDetector(
      onTap: () {
        Get.find<AirtimeCubit>().selectNetworkProvider(
          DefaultCountries.nigeria,
          provider,
        );
        Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
          'country': DefaultCountries.nigeria,
          'networkProvider': provider,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
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
        child: Column(
          children: [
            // Network Logo/Icon placeholder
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: provider.type.color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  provider.name.substring(0, 1),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 6.h),
            
            Text(
              provider.name.split(' ').first,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Row(
      children: List.generate(4, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 24.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            'Failed to load providers',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  // Retry loading
                  context.read<AirtimeCubit>().loadNetworkProviders('NG');
                },
                child: Text(
                  'Tap to retry',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

} 