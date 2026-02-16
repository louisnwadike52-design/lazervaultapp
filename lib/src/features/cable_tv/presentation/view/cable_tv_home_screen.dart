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
  final TextEditingController _searchController = TextEditingController();
  List<CableTVProviderEntity> _providers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<CableTVCubit>().getProviders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  List<CableTVProviderEntity> get _filteredProviders {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return _providers;
    return _providers
        .where((p) =>
            p.name.toLowerCase().contains(query) ||
            p.serviceId.toLowerCase().contains(query))
        .toList();
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
        child: BlocListener<CableTVCubit, CableTVState>(
          listener: (context, state) {
            if (state is CableTVProvidersLoaded) {
              setState(() {
                _providers = state.providers;
                _isLoading = false;
              });
            }
            if (state is CableTVLoading) {
              setState(() => _isLoading = true);
            }
            if (state is CableTVError) {
              setState(() => _isLoading = false);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Header illustration
                Center(
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    ),
                    child: Icon(
                      Icons.live_tv,
                      color: const Color(0xFF3B82F6),
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

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
                SizedBox(height: 6.h),
                Center(
                  child: Text(
                    'Select your cable TV provider to get started',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFF2D2D2D),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search provider...',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: const Color(0xFF6B7280),
                        size: 20.sp,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.close,
                                color: const Color(0xFF6B7280),
                                size: 18.sp,
                              ),
                            )
                          : null,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                SizedBox(height: 16.h),

                // Provider list
                Expanded(
                  child: _buildProviderList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderList() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32.w,
              height: 32.w,
              child: const CircularProgressIndicator(
                color: Color(0xFF3B82F6),
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Loading providers...',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    if (_providers.isEmpty) {
      return _buildEmptyState();
    }

    final filtered = _filteredProviders;
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              color: const Color(0xFF6B7280),
              size: 40.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'No providers found',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return _buildProviderItem(filtered[index]);
      },
    );
  }

  Widget _buildProviderItem(CableTVProviderEntity provider) {
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
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: accent,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    provider.serviceId,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF6B7280),
              size: 22.sp,
            ),
          ],
        ),
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
}
