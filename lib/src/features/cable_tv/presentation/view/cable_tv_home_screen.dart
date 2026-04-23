import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';
import '../widgets/cable_tv_recent_transactions_card.dart';

/// Cable TV landing. Same shape as the other utility landings:
///   * Quick-access row: Saved / Auto-Renew / Reminders
///   * Provider picker grid (live from `GetCableTVProviders`)
///   * Recent purchases strip → full "View All" history screen
///
/// No hardcoded provider list; all data comes from the backend.
class CableTVHomeScreen extends StatefulWidget {
  const CableTVHomeScreen({super.key});

  @override
  State<CableTVHomeScreen> createState() => _CableTVHomeScreenState();
}

class _CableTVHomeScreenState extends State<CableTVHomeScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<CableTVCubit>().getProviders();
  }

  IconData _iconFor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('dstv')) return Icons.live_tv;
    if (lower.contains('gotv')) return Icons.connected_tv;
    if (lower.contains('startimes')) return Icons.tv;
    if (lower.contains('showmax')) return Icons.play_circle_outline;
    return Icons.tv;
  }

  Color _accentFor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('dstv')) return const Color(0xFF4E03D0);
    if (lower.contains('gotv')) return const Color(0xFF10B981);
    if (lower.contains('startimes')) return const Color(0xFFFB923C);
    if (lower.contains('showmax')) return const Color(0xFFEF4444);
    return _accent;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.billsHub);
      },
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
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
          child: BlocBuilder<CableTVCubit, CableTVState>(
            buildWhen: (_, next) =>
                next is CableTVLoading ||
                next is CableTVProvidersLoaded ||
                next is CableTVError,
            builder: (context, state) {
              if (state is CableTVLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: _accent),
                );
              }
              final providers = state is CableTVProvidersLoaded
                  ? state.providers
                  : const <CableTVProviderEntity>[];
              return RefreshIndicator(
                color: _accent,
                backgroundColor: _card,
                onRefresh: () async {
                  await context.read<CableTVCubit>().getProviders();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuickActions(),
                      SizedBox(height: 24.h),
                      Text(
                        'Choose Your Provider',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      if (providers.isEmpty)
                        _buildEmptyProviders()
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: providers.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.85,
                          ),
                          itemBuilder: (context, index) =>
                              _buildProviderCard(providers[index]),
                        ),
                      SizedBox(height: 24.h),
                      const CableTVRecentTransactionsCard(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            title: 'Saved\nSmart Cards',
            icon: Icons.bookmark_border,
            onTap: () => Get.toNamed(AppRoutes.cableTVBeneficiaries),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Auto-Renew',
            icon: Icons.autorenew,
            onTap: () => Get.toNamed(AppRoutes.cableTVAutoRecharge),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            onTap: () => Get.toNamed(AppRoutes.cableTVReminders),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyProviders() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Icon(Icons.tv_off, color: _textSecondary, size: 40.sp),
          SizedBox(height: 12.h),
          Text(
            'No providers available',
            style: GoogleFonts.inter(color: _textSecondary, fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () => context.read<CableTVCubit>().getProviders(),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(color: _accent, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderCard(CableTVProviderEntity provider) {
    final accent = _accentFor(provider.name);
    final icon = _iconFor(provider.name);
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.cableTVSmartCardInput,
          arguments: {'provider': provider},
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: accent, size: 16.sp),
            ),
            SizedBox(height: 6.h),
            Text(
              provider.name.toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
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
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _accent = Color(0xFF4E03D0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: _accent, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
