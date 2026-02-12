import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';

class CableTVHomeScreen extends StatefulWidget {
  const CableTVHomeScreen({super.key});

  @override
  State<CableTVHomeScreen> createState() => _CableTVHomeScreenState();
}

class _CableTVHomeScreenState extends State<CableTVHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CableTVCubit>().getProviders();
  }

  IconData _getProviderIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('dstv')) return Icons.live_tv;
    if (lower.contains('gotv')) return Icons.connected_tv;
    if (lower.contains('startimes')) return Icons.tv;
    if (lower.contains('showmax')) return Icons.play_circle_outline;
    return Icons.tv;
  }

  Color _getProviderAccent(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('dstv')) return const Color(0xFF3B82F6);
    if (lower.contains('gotv')) return const Color(0xFF10B981);
    if (lower.contains('startimes')) return const Color(0xFFFB923C);
    if (lower.contains('showmax')) return const Color(0xFFEF4444);
    return const Color(0xFF3B82F6);
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Cable TV',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Header illustration
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.live_tv,
                    color: const Color(0xFF3B82F6),
                    size: 48.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Center(
                child: Text(
                  'Choose Your Provider',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Select your cable TV provider to get started',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Provider grid
              Expanded(
                child: BlocBuilder<CableTVCubit, CableTVState>(
                  builder: (context, state) {
                    if (state is CableTVLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF3B82F6),
                          ),
                        ),
                      );
                    }

                    if (state is CableTVError) {
                      return _buildErrorState(state.message);
                    }

                    if (state is CableTVProvidersLoaded) {
                      if (state.providers.isEmpty) {
                        return _buildEmptyState();
                      }
                      return GridView.builder(
                        itemCount: state.providers.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          return _buildProviderCard(state.providers[index]);
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProviderCard(CableTVProviderEntity provider) {
    final accent = _getProviderAccent(provider.name);
    final icon = _getProviderIcon(provider.name);

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.cableTVSmartCardInput,
          arguments: {'provider': provider},
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                icon,
                color: accent,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              provider.name.toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<CableTVCubit>().getProviders(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
            ),
            child: Text(
              'Retry',
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tv_off,
            color: const Color(0xFF9CA3AF),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No providers available',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
