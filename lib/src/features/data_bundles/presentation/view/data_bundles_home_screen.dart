import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/data_bundles_cubit.dart';
import '../widgets/data_recent_purchases_card.dart';
import '../widgets/data_quick_buy.dart';
part 'data_bundles_home_screen_widgets.dart';

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

  // Admin gates, mirroring the airtime landing so the two "split-by-scope"
  // screens behave identically. Each scope can be switched off, carry its own
  // explanation, and be opened to a whitelist of testers while shut to
  // everyone else.
  bool get _localTabEnabled => FeatureFlags.dataTabAllowed('local');
  bool get _intlTabEnabled => FeatureFlags.dataTabAllowed('international');

  bool _tabEnabled(int index) => switch (index) {
        0 => _localTabEnabled,
        1 => _intlTabEnabled,
        _ => false,
      };

  /// First enabled tab, falling back to 0 so the toggle always has a
  /// selection. When NOTHING is enabled the body renders the closed state
  /// rather than tab 0's content — see the build method.
  int get _firstEnabledTab {
    for (final i in const [0, 1]) {
      if (_tabEnabled(i)) return i;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    // Land on a tab the user can actually use: with Local switched off this
    // opens International rather than an empty Local panel.
    _selectedTab = _firstEnabledTab;
  }

  // Both tabs share the invoice purple when active — matches the airtime
  // landing so every utility's "split-by-scope" landing reads as one
  // palette. `_localColor` kept as an alias for call-site symmetry.
  static const _intlColor = Color(0xFF4E03D0);
  static const _localColor = _intlColor;

  @override
  Widget build(BuildContext context) {
    // Repaint when a fresh admin snapshot lands, so a scope switched off
    // reaches this screen within one poll instead of at next launch. The gates
    // themselves are read synchronously from the cache — nothing on the render
    // path awaits a network call.
    return ValueListenableBuilder<int>(
      valueListenable: FeatureFlags.revision,
      builder: (context, _, __) => _buildData(context),
    );
  }

  Widget _buildData(BuildContext context) {
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
                      if (!_tabEnabled(_selectedTab))
                        _buildScopeClosed()
                      else ...[
                        if (_selectedTab == 0) ..._buildLocalContent(),
                        if (_selectedTab == 1) ..._buildIntlContent(),
                      ],
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
                  // 24sp crowded the row: with the back button, the voice and
                  // chat icons beside it, the title ran to the edge and the
                  // subtitle clipped on narrower phones. 20/12 keeps the same
                  // hierarchy in noticeably less vertical space, which matters
                  // here because the plan sheet opens over this screen.
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  _selectedTab == 0
                      ? 'Buy data for Nigerian networks'
                      : 'Top up data in 100+ countries',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Per-bill voice + chat icons — pin every session to the
          // data flow on chat-products-service
          // (DIRECT_ROUTES['data'] → primary 'utility').
          ServiceVoiceButton(
            serviceName: 'data',
            iconColor: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Data Bundles',
            sourceContext: 'data',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  // -------------------- TABS --------------------

  Widget _buildTabToggle() {
    // Nothing to switch between — don't draw a one-pill toggle.
    if (!_tabBarWorthShowing) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          if (_tabEnabled(0))
            _buildTabItem(0, Icons.cell_tower, 'Local', _localColor),
          if (_tabEnabled(1))
            _buildTabItem(1, Icons.public, 'International', _intlColor),
        ],
      ),
    );
  }

  /// Whether the scope toggle is worth drawing at all.
  ///
  /// A closed scope is now HIDDEN rather than dimmed, which leaves the
  /// original objection to removing it: one lone pill reads as a broken
  /// toggle and sends people to support asking where the other one went.
  /// Answered by dropping the whole bar once fewer than two scopes remain —
  /// with a single scope there is nothing to switch between, so the screen
  /// simply shows it.
  bool get _tabBarWorthShowing {
    var open = 0;
    for (var i = 0; i < 2; i++) {
      if (_tabEnabled(i)) open++;
    }
    return open > 1;
  }

  Widget _buildTabItem(int index, IconData icon, String label, Color active) {
    final isActive = _selectedTab == index;
    // A closed scope is not rendered at all (see _buildTabBar), so anything
    // reaching here is open. The opacity is kept as a belt-and-braces for a
    // caller that bypasses the filter rather than as the way a scope is
    // closed.
    final enabled = _tabEnabled(index);
    return Expanded(
      child: Opacity(
        opacity: enabled ? 1.0 : 0.45,
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
      ),
    );
  }

  /// Shown in place of the tab body when the selected scope is closed.
  ///
  /// Reached either by selecting a dimmed tab or, when BOTH scopes are off,
  /// on open — [_firstEnabledTab] falls back to 0 so the toggle still has a
  /// selection, and without this the Local panel would render under a tab
  /// that is switched off.
  Widget _buildScopeClosed() {
    final scope = _selectedTab == 1 ? 'international' : 'local';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 44.h),
      child: Column(
        children: [
          Icon(Icons.wifi_off_rounded,
              size: 44.sp, color: const Color(0xFF4B5563)),
          SizedBox(height: 12.h),
          Text(
            _selectedTab == 1
                ? 'International data is not available right now'
                : 'Local data is not available right now',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            FeatureFlags.dataTabMessage(scope),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- LOCAL TAB --------------------

  List<Widget> _buildLocalContent() {
    // Streamlined single-page purchase: phone (prefilled) → auto-detected
    // network → plans in a styled bottom sheet → inline confirmation → TX-PIN
    // sheet (which runs the purchase) → receipt. Replaces the old
    // choose-network grid → recipient → review → processing chain. The
    // Beneficiaries / Rollover / Reminders flows stay on the quick-action row.
    return const [
      DataQuickBuy(),
    ];
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
      _buildStep(
          '1', 'Pick the destination country', 'Browse 100+ supported markets'),
      SizedBox(height: 10.h),
      _buildStep('2', 'Select operator & bundle',
          "See bundles in the recipient's currency"),
      SizedBox(height: 10.h),
      _buildStep(
          '3', 'Enter recipient phone', 'Validated against country format'),
      SizedBox(height: 10.h),
      _buildStep('4', 'Confirm & pay', 'Wallet debited in your currency'),
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
