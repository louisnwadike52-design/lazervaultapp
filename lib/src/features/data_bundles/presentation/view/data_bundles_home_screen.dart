import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/data_bundles_cubit.dart';
import '../widgets/data_recent_purchases_card.dart';

/// Two-tab landing for data bundles mirroring the airtime landing page:
///   - Local: NGN network grid → BuyData / GetDataPlans (eBills Africa).
///   - International: country picker CTA → BuyIntlData / GetIntlData*
///     (Reloadly-backed).
///
/// Header keeps only the back button — the chat & history icons are
/// intentionally absent because they live on the bills hub and apply to
/// every utility, so duplicating them on each child screen adds noise.
///
/// "Non-Expiring Data" also lives in the purchase flow (auto-renew toggle
/// on the confirmation screen), so the landing page no longer advertises
/// it as a separate card.
class DataBundlesHomeScreen extends StatefulWidget {
  const DataBundlesHomeScreen({super.key});

  @override
  State<DataBundlesHomeScreen> createState() => _DataBundlesHomeScreenState();
}

class _DataBundlesHomeScreenState extends State<DataBundlesHomeScreen> {
  /// 0 = Local (eBills Africa), 1 = International (Reloadly).
  int _selectedTab = 0;

  // Both tabs share the invoice purple when active — matches the airtime
  // landing so every utility's "split-by-scope" landing reads as one
  // palette. `_localColor` kept as an alias for call-site symmetry.
  static const _intlColor = Color(0xFF4E03D0);
  static const _localColor = _intlColor;

  static const _networks = [
    _NetworkInfo(
      name: 'MTN',
      code: 'mtn-data',
      color: Color(0xFFFBBF24),
      icon: Icons.cell_tower,
    ),
    _NetworkInfo(
      name: 'Airtel',
      code: 'airtel-data',
      color: Color(0xFFEF4444),
      icon: Icons.cell_tower,
    ),
    _NetworkInfo(
      name: 'Glo',
      code: 'glo-data',
      color: Color(0xFF10B981),
      icon: Icons.cell_tower,
    ),
    _NetworkInfo(
      name: '9mobile',
      code: 'etisalat-data',
      color: Color(0xFF10B981),
      icon: Icons.cell_tower,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              // Pull-to-refresh rehydrates the "Recent Purchases" card
              // via DataBundlesCubit — the only async surface on this
              // landing. Uses AlwaysScrollableScrollPhysics so the
              // gesture fires even when the page is shorter than the
              // viewport. ClampingScrollPhysics preserves the native
              // Android overscroll glow behavior.
              child: RefreshIndicator(
                color: _intlColor,
                backgroundColor: const Color(0xFF1F1F1F),
                onRefresh: () async {
                  if (!mounted) return;
                  await context
                      .read<DataBundlesCubit>()
                      .loadDataPurchaseHistory(limit: 50);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: 16.h),
                    // Quick actions sit above the tabs so Beneficiaries /
                    // Rollover / Reminders apply to whichever scope is
                    // active — mirrors the airtime landing where the
                    // generic Quick Actions card sits above the tabbed
                    // content. Routes resolve to local vs intl variants
                    // based on the active tab.
                    _buildQuickActionsRow(),
                    SizedBox(height: 20.h),
                    _buildTabToggle(),
                    SizedBox(height: 20.h),
                    if (_selectedTab == 0) ..._buildLocalContent(),
                    if (_selectedTab == 1) ..._buildIntlContent(),
                    SizedBox(height: 24.h),
                    DataRecentPurchasesCard(
                      accent: _selectedTab == 0 ? _localColor : _intlColor,
                      scope: _selectedTab == 0
                          ? DataPurchaseScope.buy
                          : DataPurchaseScope.intl,
                    ),
                    SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- HEADER --------------------

  Widget _buildHeader() {
    return Padding(
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
                  'Data Bundles',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _selectedTab == 0
                      ? 'Buy data for Nigerian networks'
                      : 'Top up data in 100+ countries',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- TABS --------------------

  Widget _buildTabToggle() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildTabItem(0, Icons.cell_tower, 'Local', _localColor),
          _buildTabItem(1, Icons.public, 'International', _intlColor),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, IconData icon, String label, Color active) {
    final isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isActive ? active : Colors.transparent,
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
              SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
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

  // -------------------- LOCAL TAB --------------------

  List<Widget> _buildLocalContent() {
    return [
      Text(
        'Choose Your Network',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 12.h),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _networks.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) => _buildNetworkCard(_networks[index]),
      ),
    ];
  }

  Widget _buildNetworkCard(_NetworkInfo network) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.dataBundlesPlanSelection,
          arguments: {
            'network': network.code,
            'networkName': network.name,
            'networkColor': network.color.toARGB32(),
          },
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
                color: network.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                network.icon,
                color: network.color,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              network.name.toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- INTERNATIONAL TAB --------------------

  List<Widget> _buildIntlContent() {
    return [
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_intlColor, Color(0xFF6D28D9)],
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
              child: Icon(Icons.public, color: Colors.white, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'International Data',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Send data bundles to phones in 100+ countries.',
                    style: GoogleFonts.inter(
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
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 12.h),
      _buildStep('1', 'Pick the destination country',
          'Browse 100+ supported markets'),
      SizedBox(height: 10.h),
      _buildStep('2', 'Select operator & bundle',
          "See bundles in the recipient's currency"),
      SizedBox(height: 10.h),
      _buildStep('3', 'Enter recipient phone',
          'Validated against country format'),
      SizedBox(height: 10.h),
      _buildStep('4', 'Confirm & pay',
          'Wallet debited in your currency'),
      SizedBox(height: 24.h),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.toNamed(AppRoutes.intlDataPurchase),
          style: ElevatedButton.styleFrom(
            backgroundColor: _intlColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Browse Countries',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ];
  }

  // -------------------- SHARED --------------------

  /// Quick actions rendered above the tab toggle and visible for both
  /// Local and International tabs. Route resolves to the scope that's
  /// currently active (the three tiles look & feel identical across tabs
  /// — only the destination screen changes).
  ///
  /// Visual style mirrors [_QuickActionCard] on the internet bill
  /// landing: flat dark card + small purple-tinted icon square +
  /// two-line title. No gradients, no shadows — keeps the quick-access
  /// strip quiet so the tab toggle below remains the obvious primary
  /// control.
  Widget _buildQuickActionsRow() {
    final isLocal = _selectedTab == 0;
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            title: 'Saved\nContacts',
            icon: Icons.bookmark_border,
            onTap: () => Get.toNamed(
              isLocal
                  ? AppRoutes.dataBundlesBeneficiaries
                  : AppRoutes.intlDataBeneficiaries,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Auto\nRecharge',
            icon: Icons.autorenew,
            onTap: () => Get.toNamed(
              isLocal
                  ? AppRoutes.dataBundlesRollover
                  : AppRoutes.intlDataAutoRecharge,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            onTap: () => Get.toNamed(
              isLocal
                  ? AppRoutes.dataBundlesReminders
                  : AppRoutes.intlDataReminders,
            ),
          ),
        ),
      ],
    );
  }

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
              color: _intlColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: _intlColor,
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
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
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
}

class _NetworkInfo {
  final String name;
  final String code;
  final Color color;
  final IconData icon;

  const _NetworkInfo({
    required this.name,
    required this.code,
    required this.color,
    required this.icon,
  });
}

/// Flat quick-action tile used above the tab toggle. Mirrors
/// [_QuickActionCard] on the internet bill landing so every utility's
/// "Saved / Rollover / Reminders" strip renders the same shell.
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
