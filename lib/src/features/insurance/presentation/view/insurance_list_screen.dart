import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../cubit/create_policy_cubit.dart';
import 'create_insurance_policy_carousel.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import '../widgets/mycover_claim_bottom_sheet.dart';
import '../widgets/mycover_hosted_url.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class InsuranceListScreen extends StatefulWidget {
  const InsuranceListScreen({super.key});

  @override
  State<InsuranceListScreen> createState() => _InsuranceListScreenState();
}

class _InsuranceListScreenState extends State<InsuranceListScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Admin can disable the quick-service entrance animation platform-wide.
    // When off, jump both controllers to their end so the content renders in
    // place (fully faded in, no slide) instead of animating.
    if (FeatureFlags.serviceEntranceAnimation) {
      _fadeController.forward();
      _slideController.forward();
    } else {
      _fadeController.value = 1.0;
      _slideController.value = 1.0;
    }

    // Initialize userId once on mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthenticationCubit>().state;
      final userId = authState is AuthenticationSuccess
          ? authState.profile.user.id
          : 'guest_user';
      context.read<InsuranceCubit>().setUserId(userId);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        // Handle auth state changes (e.g., re-login)
        final userId = authState is AuthenticationSuccess
            ? authState.profile.user.id
            : 'guest_user';
        context.read<InsuranceCubit>().setUserId(userId);
      },
      builder: (context, authState) {
        return _buildInsuranceScreen();
      },
    );
  }

  Widget _buildInsuranceScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Container(
          color: const Color(0xFF0A0A0A),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: BlocConsumer<InsuranceCubit, InsuranceState>(
                      listener: (context, state) {
                        // Show snackbar only for transient errors (when there's already data showing)
                        // Don't show snackbar for errors that have their own full-screen error state
                        if (state is InsuranceError) {
                          // The builder below will show the error state inline
                          // No need for a duplicate snackbar
                        }
                        if (state is InsuranceCreated || state is InsuranceUpdated || state is InsuranceDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Operation successful',
                                style: GoogleFonts.inter(color: Colors.white)),
                              backgroundColor: const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is InsuranceLoading) {
                          return _buildLoadingState();
                        }

                        if (state is InsurancesLoaded) {
                          return _buildInsurancesView(state);
                        }

                        if (state is InsuranceError) {
                          return _buildErrorState(state.message);
                        }

                        return _buildEmptyState();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),  // SafeArea
      // FAB voice button removed — the appbar already exposes a mic
      // (ServiceVoiceButton) at top-right, so the floating mic was a
      // duplicate. Keeping only the primary "New Insurance" CTA.
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Insurance',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Cover what matters',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Inline mic + chat + overflow — sized to match each other so
          // they read as a row of equal-weight controls.
          ServiceVoiceButton(
            serviceName: 'insurance',
            buttonSize: 38.w,
            iconSize: 18.sp,
          ),
          SizedBox(width: 6.w),
          MicroserviceChatIcon(
            serviceName: 'Insurance',
            sourceContext: 'insurance',
            size: 38.w,
            iconSize: 18.sp,
          ),
          SizedBox(width: 6.w),
          _buildHeaderOverflowMenu(),
        ],
      ),
    );
  }

  // 3-dot overflow menu for low-frequency insurance utilities.
  // Sized to match the mic + chat row to keep visual weight even.
  Widget _buildHeaderOverflowMenu() {
    return PopupMenuButton<String>(
      icon: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(19.r),
        ),
        child: Icon(Icons.more_vert, color: Colors.white70, size: 18.sp),
      ),
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      onSelected: (value) {
        switch (value) {
          case 'faq':
            Get.toNamed(AppRoutes.insuranceFaq);
            break;
          case 'guide':
            Get.toNamed(AppRoutes.insuranceGuide);
            break;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: 'faq',
          child: Row(
            children: [
              Icon(Icons.help_outline,
                  color: Colors.white70, size: 16.sp),
              SizedBox(width: 10.w),
              Text(
                'FAQ',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'guide',
          child: Row(
            children: [
              Icon(Icons.menu_book_outlined,
                  color: Colors.white70, size: 16.sp),
              SizedBox(width: 10.w),
              Text(
                'Guide',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsurancesView(InsurancesLoaded state) {
    final activePolicies = state.insurances.where((i) => i.status == InsuranceStatus.active).toList();
    final pendingPolicies = state.insurances.where((i) => i.status == InsuranceStatus.pending).toList();
    final expiredPolicies = state.insurances.where((i) => i.status == InsuranceStatus.expired).toList();

    return RefreshIndicator(
      // Wrap so an underlying RPC failure doesn't leave the
      // RefreshIndicator spinner stuck. Errors are already surfaced
      // through cubit state — this just makes sure the spinner clears.
      onRefresh: () async {
        try {
          await context.read<InsuranceCubit>().loadInsurances();
        } catch (_) {/* state listener surfaces the error */}
      },
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compact stat row
            _buildCompactStats(state.statistics, state.insurances.length),
            SizedBox(height: 16.h),

            // Quick status filters
            _buildStatusChips(activePolicies.length, pendingPolicies.length, expiredPolicies.length),
            SizedBox(height: 20.h),

            // Policies preview (max 3) with View All — surfaced for any
            // non-empty count so newly-purchased policies are always one
            // tap away from the full paginated screen.
            _buildSectionHeader('Your Policies', state.insurances.length),
            SizedBox(height: 10.h),
            if (state.insurances.isEmpty)
              _buildEmptyPoliciesCard()
            else
              _buildInsurancesList(state.insurances.take(3).toList()),
            SizedBox(height: 20.h),

            // Visual segmentation — the "Manage" header makes it
            // clear these CTAs are distinct from the "Your Policies"
            // preview above. Without a header they read as if they
            // were policy cards.
            _buildSimpleSectionHeader('Manage'),
            SizedBox(height: 10.h),
            // Manage Plan — only when the admin enables hosted entry points.
            // Opens MyCover's universal hosted webview so the user can manage
            // their existing policies; changes sync back automatically. When
            // the toggle is off, the native policy list + detail screens above
            // are the management surface, so this tile is hidden.
            if (FeatureFlags.insuranceHostedEntrypoints) ...[
              _buildShortcutTile(
                icon: Icons.tune_rounded,
                label: 'Manage Plan',
                subtitle: 'Control your insurance policies',
                color: const Color(0xFF3B82F6),
                onTap: () {
                  final insuranceCubit = context.read<InsuranceCubit>();
                  MyCoverClaimBottomSheet.showManage(
                    context,
                    urlResolver: _resolveHostedUrl,
                  ).then((_) => insuranceCubit.loadInsurances());
                },
              ),
              SizedBox(height: 10.h),
            ],
            _buildShortcutTile(
              icon: Icons.assignment_outlined,
              label: 'My Claims',
              subtitle: 'Track and file insurance claims',
              color: const Color(0xFFFB923C),
              onTap: () => Get.toNamed(AppRoutes.insuranceMyClaims),
            ),
            SizedBox(height: 10.h),
            _buildShortcutTile(
              icon: Icons.receipt_long_outlined,
              label: 'Purchase History',
              subtitle: 'Receipts, certificates & past purchases',
              color: const Color(0xFF10B981),
              onTap: () => Get.toNamed(AppRoutes.insurancePurchaseHistory),
            ),
            // "Activity & Alerts" was removed: the signals it surfaced
            // (recently-added / expiring-soon / payment-due) are already
            // visible on each policy card's daysUntilExpiry chip and via
            // the Renew FAB on the policy detail screen. The two CTAs
            // above are the supported entry points for claims + receipts.
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  // Hero stats card — matches Group Funds (#4E03D0 purple gradient with
  // soft shadow). Three columns split by faint white dividers, icons
  // tinted white-on-purple so it reads as a single coloured block.
  Widget _buildCompactStats(Map<String, dynamic> statistics, int totalPolicies) {
    final activePolicies = statistics['activePolicies'] ?? 0;
    final totalCoverage = (statistics['totalCoverageAmount'] ?? 0.0) as double;
    // Render the coverage total in the user's current locale currency
    // — pulled from LocaleManager via CurrencySymbols.currentSymbol —
    // not a hardcoded `$`. A user on NGN now sees `₦`, USD users see
    // `$`, etc. The amount itself is whatever the cubit/statistics
    // path passed in; we don't convert it here (the backend returns
    // amounts in the user's account currency already).
    final currencySymbol = CurrencySymbols.currentSymbol;
    final coverageStr = totalCoverage >= 1000
        ? '$currencySymbol${(totalCoverage / 1000).toStringAsFixed(0)}K'
        : '$currencySymbol${totalCoverage.toStringAsFixed(0)}';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _buildCompactStatItem(Icons.shield_outlined, '$activePolicies', 'Active')),
          _buildStatDivider(),
          Expanded(child: _buildCompactStatItem(Icons.policy_outlined, '$totalPolicies', 'Total')),
          _buildStatDivider(),
          Expanded(child: _buildCompactStatItem(Icons.account_balance_outlined, coverageStr, 'Coverage')),
        ],
      ),
    );
  }

  Widget _buildCompactStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18.sp),
        SizedBox(height: 4.h),
        Text(value, style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
        Text(label, style: GoogleFonts.inter(fontSize: 10.sp, color: Colors.white.withValues(alpha: 0.85))),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 36.h, color: Colors.white.withValues(alpha: 0.2));
  }

  Widget _buildStatusChips(int active, int pending, int expired) {
    return SizedBox(
      height: 32.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (active > 0) _buildChip('Active ($active)', const Color(0xFF10B981), 'active'),
          if (pending > 0) _buildChip('Pending ($pending)', const Color(0xFFF59E0B), 'pending'),
          if (expired > 0) _buildChip('Expired ($expired)', const Color(0xFFEF4444), 'expired'),
          // "View All" was removed here. The "Your Policies" section
          // header below already exposes a View All affordance for the
          // full paginated list — duplicating it inside the status
          // chip row was redundant and visually noisy.
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color, String? filterStatus) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.insuranceAllPolicies, arguments: filterStatus),
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(label, style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600, color: color)),
      ),
    );
  }

  // Phase D — compact action tile used for "My Claims" and "Purchase History".
  Widget _buildShortcutTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w, height: 40.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: const Color(0xFF6B7280), size: 20.sp),
          ],
        ),
      ),
    );
  }

  // Empty-state card rendered in place of the policies preview when the
  // user has zero policies. Mirrors the look of the shortcut tiles
  // already on the page so the empty state feels intentional.
  Widget _buildEmptyPoliciesCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Icon(Icons.shield_outlined,
              color: const Color.fromARGB(255, 78, 3, 208), size: 28.sp),
          SizedBox(height: 8.h),
          Text(
            'No policies yet',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap below to browse insurance products and create your first policy.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  // Title on the left, "<count> policies · View All" pinned to the right.
  // The View All inline sits next to the count so it doesn't waste a row
  // and reads as a quiet utility link rather than a heavy button.
  /// Lightweight section header — just the title, no count or
  /// View-All. Used to group the operational CTAs (My Claims,
  /// Purchase History) so they read as a distinct section, not as
  /// additional policies under "Your Policies".
  Widget _buildSimpleSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF9CA3AF),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    final hasItems = count > 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '$count ${count == 1 ? 'policy' : 'policies'}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (hasItems) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.insuranceAllPolicies),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
                  child: Text(
                    'View all',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildInsurancesList(List<Insurance> insurances) {
    if (insurances.isEmpty) {
      return _buildEmptyInsurances();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: insurances.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => _buildInsuranceCard(insurances[index]),
    );
  }

  Widget _buildInsuranceCard(Insurance insurance) {
    return GestureDetector(
      onTap: () => _navigateToInsuranceDetails(insurance),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 78, 3, 208),
                    Color.fromARGB(255, 48, 0, 140),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: Text(insurance.type.icon, style: TextStyle(fontSize: 18.sp))),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(insurance.type.displayName,
                          style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      _buildStatusBadge(insurance.status),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text('${insurance.provider} \u2022 ${insurance.policyNumber}',
                    style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      // Each policy carries its OWN currency on the
                      // Insurance entity (from the backend purchase
                      // row), so format with that — not the user's
                      // current locale — so a USD policy displays in
                      // USD even after the user switches their default
                      // locale to NGN. The two are independent: the
                      // stats card up top uses LocaleManager (current
                      // wallet currency), tiles use the policy's own.
                      Text(
                        CurrencySymbols.formatAmountWithCurrency(
                          insurance.premiumAmount,
                          insurance.currency,
                        ),
                        style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)),
                      ),
                      const Spacer(),
                      Text('Exp: ${insurance.endDate.day}/${insurance.endDate.month}/${insurance.endDate.year}',
                        style: GoogleFonts.inter(fontSize: 10.sp, color: const Color(0xFF9CA3AF))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(InsuranceStatus status) {
    Color color;
    switch (status) {
      case InsuranceStatus.active:
        color = const Color(0xFF10B981);
        break;
      case InsuranceStatus.pending:
      case InsuranceStatus.processing:
      case InsuranceStatus.awaitingWebhook:
        color = const Color(0xFFF59E0B);
        break;
      case InsuranceStatus.refundPending:
        color = const Color(0xFFFB923C);
        break;
      case InsuranceStatus.expired:
      case InsuranceStatus.refundFailed:
        color = const Color(0xFFEF4444);
        break;
      case InsuranceStatus.cancelled:
      case InsuranceStatus.refunded:
        color = const Color(0xFF6B7280);
        break;
      case InsuranceStatus.suspended:
      case InsuranceStatus.manualReview:
        color = const Color.fromARGB(255, 78, 3, 208);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyInsurances() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 40.sp,
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Insurance Policies',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Get started by adding your first insurance policy',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
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
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 40.sp,
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Welcome to Insurance',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Manage all your insurance policies in one place',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          _buildGetStartedButton(),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.insuranceHowItWorks),
            child: Text(
              'How does insurance work?',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color.fromARGB(255, 78, 3, 208),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: const Color.fromARGB(255, 78, 3, 208),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: LazerVaultLoader.tiny(),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading insurance policies...',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(36.r),
              ),
              child: Icon(Icons.cloud_off_outlined, size: 36.sp, color: const Color(0xFFEF4444)),
            ),
            SizedBox(height: 20.h),
            Text(
              'Something went wrong',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () => context.read<InsuranceCubit>().loadInsurances(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 78, 3, 208),
                      Color.fromARGB(255, 48, 0, 140),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text('Try Again', style: GoogleFonts.inter(
                      fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _showCreateInsuranceDialog(),
              child: Text(
                'Or browse insurance plans',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.read<InsuranceCubit>().loadInsurances(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Get Started',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208),
          ],
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => _showCreateInsuranceDialog(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          'New Policy',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  /// Resolves the per-user MyCover hosted URL for Buy/Manage from the
  /// admin-configured base link + the logged-in user's identity. Returns
  /// null when the link isn't configured (sheet shows an unavailable state).
  Future<String?> _resolveHostedUrl() async {
    final authState = context.read<AuthenticationCubit>().state;
    final user = authState is AuthenticationSuccess ? authState.profile.user : null;
    return MyCoverHostedUrl.compose(
      base: FeatureFlags.insuranceHostedBaseLink,
      email: user?.email ?? '',
      userId: user?.id ?? '',
    );
  }

  void _showCreateInsuranceDialog() {
    // Admin toggle: when hosted entry points are on, Buy opens MyCover's
    // universal hosted webview in a themed bottom sheet instead of the
    // native carousel. Purchases sync back via the webhook + import worker,
    // so we still refresh the list when the sheet closes.
    if (FeatureFlags.insuranceHostedEntrypoints) {
      final insuranceCubit = context.read<InsuranceCubit>();
      MyCoverClaimBottomSheet.showBuy(
        context,
        urlResolver: _resolveHostedUrl,
      ).then((_) => insuranceCubit.loadInsurances());
      return;
    }

    // Capture cubits from current context before navigation
    final insuranceCubit = context.read<InsuranceCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: insuranceCubit),
            BlocProvider.value(value: authCubit),
            BlocProvider(create: (context) => CreatePolicyCubit(
              repository: serviceLocator<InsuranceRepository>(),
              cacheManager: serviceLocator<SWRCacheManager>(),
              localeManager: serviceLocator<LocaleManager>(),
            )),
          ],
          child: const CreateInsurancePolicyCarousel(),
        ),
      ),
    ).then((_) {
      // Refresh insurance list after carousel closes
      insuranceCubit.loadInsurances();
    });
  }

  void _navigateToInsuranceDetails(Insurance insurance) async {
    // Navigate with the insurance object directly (simulates API approach)
    Get.toNamed(AppRoutes.insuranceDetails, arguments: insurance);
  }
}