import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../cubit/education_cubit.dart';
import '../cubit/education_state.dart';

class EducationHomeScreen extends StatefulWidget {
  const EducationHomeScreen({super.key});

  @override
  State<EducationHomeScreen> createState() => _EducationHomeScreenState();
}

class _EducationHomeScreenState extends State<EducationHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EducationCubit>().getProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Education PINs',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<EducationCubit, EducationState>(
          builder: (context, state) {
            if (state is EducationLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              );
            }

            if (state is EducationError) {
              return _buildErrorState(state.message);
            }

            if (state is EducationProvidersLoaded) {
              if (state.providers.isEmpty) {
                return _buildEmptyState();
              }
              return _buildProviderList(state.providers);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load providers',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.read<EducationCubit>().getProviders(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64.sp,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Education PIN Providers Available',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Check back later for available providers',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.read<EducationCubit>().getProviders(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderList(List<EducationProviderEntity> providers) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.school,
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
                        'Buy Education PINs',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Purchase WAEC, JAMB, and other exam PINs instantly',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            'Select Provider',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Provider cards
          ...providers.map((provider) => _buildProviderCard(provider)),
        ],
      ),
    );
  }

  Widget _buildProviderCard(EducationProviderEntity provider) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.educationPurchase, arguments: {
          'provider': provider,
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Provider icon
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: _getProviderColor(provider.name).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: _getProviderIcon(provider.name),
              ),
            ),

            SizedBox(width: 16.w),

            // Provider details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    provider.description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Price and arrow
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\u20A6${_formatAmount(provider.amount)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'per PIN',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),

            SizedBox(width: 8.w),

            Icon(
              Icons.chevron_right,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Color _getProviderColor(String name) {
    final nameLower = name.toLowerCase();
    if (nameLower.contains('waec')) {
      return const Color(0xFF10B981);
    } else if (nameLower.contains('jamb')) {
      return const Color(0xFF3B82F6);
    }
    return const Color(0xFFFB923C);
  }

  Widget _getProviderIcon(String name) {
    final nameLower = name.toLowerCase();
    if (nameLower.contains('waec')) {
      return Icon(
        Icons.assignment,
        color: const Color(0xFF10B981),
        size: 28.sp,
      );
    } else if (nameLower.contains('jamb')) {
      return Icon(
        Icons.menu_book,
        color: const Color(0xFF3B82F6),
        size: 28.sp,
      );
    }
    return Icon(
      Icons.school,
      color: const Color(0xFFFB923C),
      size: 28.sp,
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }
}
