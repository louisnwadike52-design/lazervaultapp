import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../cubit/internet_bill_cubit.dart';
import '../widgets/internet_recent_transactions_card.dart';
import '../widgets/internet_quick_buy.dart';

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
  static const _accent = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    context.read<InternetBillCubit>().getProviders();
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
          // Per-bill voice + chat icons removed — unified utility bills
          // landing page hosts the single chat/mic entry point now.
        ),
        body: SafeArea(
          child: RefreshIndicator(
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
                  // Streamlined single-page purchase (see InternetQuickBuy).
                  _buildQuickActions(),
                  SizedBox(height: 24.h),
                  const InternetQuickBuy(),
                  SizedBox(height: 24.h),
                  const InternetRecentTransactionsCard(),
                ],
              ),
            ),
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
