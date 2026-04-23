import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../cubit/internet_bill_cubit.dart';
import '../cubit/internet_bill_state.dart';
import '../widgets/internet_recent_transactions_card.dart';

/// Internet Bill landing. Same shape as the other utility landings:
///   * ISP picker grid (live from `GetInternetProviders`)
///   * Quick-access row: Saved / Rollover / Reminders
///   * Recent purchases strip → full "View All" history screen
/// No hardcoded provider list; all data comes from the backend.
class InternetBillHomeScreen extends StatefulWidget {
  const InternetBillHomeScreen({super.key});

  @override
  State<InternetBillHomeScreen> createState() => _InternetBillHomeScreenState();
}

class _InternetBillHomeScreenState extends State<InternetBillHomeScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<InternetBillCubit>().getProviders();
  }

  IconData _iconFor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('smile')) return Icons.wifi;
    if (lower.contains('spectranet')) return Icons.router;
    if (lower.contains('ipnx')) return Icons.language;
    if (lower.contains('swift')) return Icons.speed;
    if (lower.contains('ntel')) return Icons.cell_tower;
    if (lower.contains('cobranet')) return Icons.hub;
    return Icons.wifi;
  }

  Color _accentFor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('smile')) return const Color(0xFF4E03D0);
    if (lower.contains('spectranet')) return const Color(0xFF10B981);
    if (lower.contains('ipnx')) return const Color(0xFFFB923C);
    if (lower.contains('swift')) return const Color(0xFFEF4444);
    if (lower.contains('ntel')) return const Color(0xFF4E03D0);
    if (lower.contains('cobranet')) return const Color(0xFF06B6D4);
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
            'Internet Bill',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<InternetBillCubit, InternetBillState>(
            builder: (context, state) {
              if (state is InternetBillLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: _accent),
                );
              }
              final providers = state is InternetBillProvidersLoaded
                  ? state.providers
                  : const <InternetProviderEntity>[];
              return RefreshIndicator(
                color: _accent,
                backgroundColor: _card,
                onRefresh: () async {
                  await context.read<InternetBillCubit>().getProviders();
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
                        'Choose an ISP',
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
                            crossAxisCount: 3,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (context, index) =>
                              _buildIspCard(providers[index]),
                        ),
                      SizedBox(height: 24.h),
                      const InternetRecentTransactionsCard(),
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

  // =============================== Quick actions ===========================

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            title: 'Saved\nAccounts',
            icon: Icons.bookmark_border,
            onTap: () => Get.toNamed(AppRoutes.internetBillSaved),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Rollover',
            icon: Icons.autorenew,
            onTap: () => Get.toNamed(AppRoutes.internetBillRollover),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            onTap: () => Get.toNamed(AppRoutes.internetBillReminders),
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
          Icon(Icons.wifi_off, color: _textSecondary, size: 40.sp),
          SizedBox(height: 12.h),
          Text(
            'No providers available',
            style: GoogleFonts.inter(color: _textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildIspCard(InternetProviderEntity provider) {
    final accent = _accentFor(provider.name);
    final icon = _iconFor(provider.name);
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.internetAccountInput,
          arguments: {'provider': provider},
        );
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: accent, size: 24.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              provider.name.toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
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
