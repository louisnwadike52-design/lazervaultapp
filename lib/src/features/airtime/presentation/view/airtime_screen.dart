import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../cubit/airtime_cubit.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/recent_transactions_card.dart';

/// Airtime landing page.
///
/// Three scoped tabs — Buy (domestic), International (Reloadly-backed),
/// Sell (airtime-to-cash). International and Sell share the invoice purple
/// accent; Buy keeps the domestic blue. Each tab surfaces its three most
/// recent matching transactions + a scope-aware 'View All' link into
/// [AirtimeHistoryScreen]'s pill filter.
///
/// The header drops the chat/history icons since those live on the bills
/// hub and apply to every utility — no per-service duplicates.
class AirtimeScreen extends StatefulWidget {
  /// Cross-route nudge so screens that complete an airtime action (the
  /// receipt, an auto-recharge edit, a saved-contact delete) can tell
  /// the landing to refresh its quick-action data + recent transactions
  /// without sharing a cubit instance. Each route gets its own
  /// `AirtimeCubit` via `registerFactory`, so a regular `cubit.emit`
  /// can't reach the landing — this notifier bridges the gap.
  ///
  /// Bump it from anywhere (`AirtimeScreen.dataChangedTick.value++`)
  /// after a write succeeds; the landing listens and reloads.
  static final ValueNotifier<int> dataChangedTick = ValueNotifier<int>(0);

  /// Convenience helper called by post-purchase / post-edit handlers.
  static void notifyDataChanged() {
    dataChangedTick.value = dataChangedTick.value + 1;
  }

  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  int _selectedTab = 0;

  // All three tabs share the invoice purple when active — keeps the
  // airtime landing on one palette. `_buyColor` kept as an alias so the
  // call sites below don't have to change.
  static const _invoicePurple = Color(0xFF4E03D0);
  static const _buyColor = _invoicePurple;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    // Reload whenever an unrelated screen (receipt, auto-recharge edit,
    // saved-contact write) bumps the cross-route nudge. Without this
    // the user would see stale recent-transactions until they
    // pull-to-refresh manually.
    AirtimeScreen.dataChangedTick.addListener(_onDataChangedTick);
  }

  @override
  void dispose() {
    AirtimeScreen.dataChangedTick.removeListener(_onDataChangedTick);
    super.dispose();
  }

  void _onDataChangedTick() {
    if (!mounted) return;
    _loadInitialData();
  }

  void _loadInitialData() {
    final cubit = context.read<AirtimeCubit>();
    cubit.loadNetworkProviders('NG');

    final userId = context.read<AuthenticationCubit>().userId ?? '';
    if (userId.isNotEmpty) {
      cubit.loadTransactionHistory(userId);
    }
  }

  Future<void> _onRefresh() async {
    _loadInitialData();
    // Give the cubit a moment to roundtrip so the indicator stays visible
    // long enough to feel responsive without holding the user.
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        color: const Color(0xFF0A0A0A),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: _invoicePurple,
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        _buildQuickActionsRow(),
                        SizedBox(height: 16.h),
                        _buildTabToggle(),
                        SizedBox(height: 20.h),
                        if (_selectedTab == 0) ..._buildBuyContent(),
                        if (_selectedTab == 1) ..._buildIntlContent(),
                        if (_selectedTab == 2) ..._buildSellContent(),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 3-tile quick-actions row (Saved Contacts / Auto-Recharge / Reminders)
  /// above the tabs — mirrors the electricity landing. Each tile routes
  /// into an existing airtime backend flow via routes declared in
  /// `AppRoutes.airtime{Beneficiaries,AutoRecharge,Reminders}`, which are
  /// already wired through `AirtimeCubit` / `AirtimeRepository` to the
  /// utility-payments service RPCs.
  Widget _buildQuickActionsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionTile(
            title: 'Saved Contacts',
            icon: Icons.bookmark_border,
            color: _invoicePurple,
            onTap: () => Get.toNamed(AppRoutes.airtimeBeneficiaries),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildQuickActionTile(
            title: 'Auto-Recharge',
            icon: Icons.autorenew,
            color: const Color(0xFF10B981),
            onTap: () => Get.toNamed(AppRoutes.airtimeAutoRecharge),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildQuickActionTile(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            color: const Color(0xFFF59E0B),
            onTap: () => Get.toNamed(AppRoutes.airtimeReminders),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabToggle() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildTabItem(0, Icons.phone_android, 'Buy', _buyColor),
          _buildTabItem(1, Icons.public, 'International', _invoicePurple),
          _buildTabItem(
              2, Icons.currency_exchange, 'Sell', _invoicePurple),
        ],
      ),
    );
  }

  Widget _buildTabItem(
      int index, IconData icon, String label, Color activeColor) {
    final isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0xFF9CA3AF),
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------- BUY TAB -----------------------

  List<Widget> _buildBuyContent() {
    // Network picker was removed from the landing; users pick their
    // network on the recipient-input screen after tapping Buy/Send.
    // The quick-actions card + recent list is enough to get them into
    // the purchase flow without the redundant grid.
    return [
      const QuickActionsCard(),
      SizedBox(height: 24.h),
      const RecentTransactionsCard(
        scope: AirtimeScope.buy,
        accent: _buyColor,
      ),
    ];
  }

  // ----------------------- INTERNATIONAL TAB -----------------------

  List<Widget> _buildIntlContent() {
    return [
      // Hero banner ("International Airtime — top up phones in 100+
      // countries…") + the FX hint card were removed: the box-shaped
      // Browse Countries CTA below conveys the same message and the
      // "Paid in your wallet currency / FX rate locked" detail belongs
      // on the country-selection screen rather than the landing.
      _buildBrowseCountriesCta(),
      SizedBox(height: 18.h),
      const RecentTransactionsCard(
        scope: AirtimeScope.intl,
        accent: _invoicePurple,
      ),
    ];
  }

  /// Bigger, box-shaped Browse Countries CTA with a leading globe icon
  /// and a trailing chevron — reads unambiguously as "tap to navigate"
  /// rather than a flat banner. Replaces the previous slim ElevatedButton
  /// which users were sometimes missing.
  Widget _buildBrowseCountriesCta() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.intlAirtimeCountrySelection),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _invoicePurple,
              _invoicePurple.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: _invoicePurple.withValues(alpha: 0.25),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.public, color: Colors.white, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse Countries',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Top up phones in 100+ countries',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------- SELL TAB -----------------------

  List<Widget> _buildSellContent() {
    return [
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_invoicePurple, Color(0xFF6D28D9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.currency_exchange,
                  color: Colors.white, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Convert Airtime to Cash',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Turn unused airtime into wallet balance.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20.h),
      Text(
        'How it works',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 12.h),
      _buildStep('1', 'Select your network',
          'Choose MTN, Airtel, Glo, or 9mobile'),
      SizedBox(height: 10.h),
      _buildStep('2', 'Enter your phone & amount',
          'Specify how much airtime to convert'),
      SizedBox(height: 10.h),
      _buildStep('3', 'Transfer airtime',
          "Send airtime to the provider's number"),
      SizedBox(height: 10.h),
      _buildStep('4', 'Get cash in wallet',
          'Cash is credited instantly to your wallet'),
      SizedBox(height: 24.h),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.toNamed(AppRoutes.airtimeToCash),
          style: ElevatedButton.styleFrom(
            backgroundColor: _invoicePurple,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Convert Airtime Now',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      SizedBox(height: 24.h),
      const RecentTransactionsCard(
        scope: AirtimeScope.sell,
        accent: _invoicePurple,
      ),
    ];
  }

  // ----------------------- SHARED -----------------------

  Widget _buildStep(String number, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: _invoicePurple.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: _invoicePurple,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.billsHub),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Airtime',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  switch (_selectedTab) {
                    1 => 'Top up airtime in 100+ countries',
                    2 => 'Convert your airtime to cash',
                    _ => 'Buy airtime for yourself or others',
                  },
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
