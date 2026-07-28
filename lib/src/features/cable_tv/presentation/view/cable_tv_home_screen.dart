import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../cubit/cable_tv_cubit.dart';
import '../widgets/cable_tv_recent_transactions_card.dart';
import '../widgets/cable_tv_quick_buy.dart';

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
  static const _accent = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<CableTVCubit>().getProviders();
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
          // Per-bill voice + chat icons removed — the unified utility
          // bills landing page now hosts the single chat/mic entry point
          // for every utility flow.
        ),
        body: SafeArea(
          // Streamlined single-page purchase: pick provider → smart card →
          // auto-validated customer + bouquets (styled bottom sheet) → inline
          // confirmation → TX-PIN sheet runs the payment → receipt. Replaces the
          // choose-provider grid → smart-card-input → package → confirm →
          // processing chain. CableTVQuickBuy loads providers itself, so this no
          // longer needs the BlocBuilder (whose CableTVLoading branch blanked
          // the screen when the new widget loaded packages).
          child: RefreshIndicator(
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
                  const CableTVQuickBuy(),
                  SizedBox(height: 24.h),
                  const CableTVRecentTransactionsCard(),
                ],
              ),
            ),
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
