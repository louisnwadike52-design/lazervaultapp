import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../widgets/mycover_claim_bottom_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class InsurancePolicyDetailView extends StatefulWidget {
  final Insurance insurance;

  const InsurancePolicyDetailView({
    super.key,
    required this.insurance,
  });

  @override
  State<InsurancePolicyDetailView> createState() => _InsurancePolicyDetailViewState();
}

class _InsurancePolicyDetailViewState extends State<InsurancePolicyDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Insurance object refreshed from the backend, used in preference to
  /// the constructor-time `_currentInsurance` when we've just live-fetched
  /// (so the composed claim_url is available immediately without a
  /// rebuild from a parent route).
  Insurance? _refreshedInsurance;

  Insurance get _currentInsurance => _refreshedInsurance ?? widget.insurance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InsuranceCubit>().loadInsuranceDetailsWithData(_currentInsurance);
    });
    // The list-view path (GetUserInsurances) does not include the
    // per-policy metadata extras — claim_url, renew_url, certificate_url,
    // etc. — those are only emitted by GetInsurancePolicy. Without a
    // refresh on mount, the "Renew Policy" and "View Certificate" CTAs
    // would stay hidden until the user taps something that triggers the
    // slow-path resolver. Kick off the live fetch in the background so
    // the CTAs appear automatically once the backend composes the URLs.
    _hydrateExtrasInBackground();
  }

  Future<void> _hydrateExtrasInBackground() async {
    try {
      final refreshed = await GetIt.I<InsuranceRepository>()
          .getInsuranceById(widget.insurance.id);
      if (!mounted || refreshed == null) return;
      setState(() => _refreshedInsurance = refreshed);
      // Re-load the tabs with the fully-populated policy so payments/holder
      // info reflect the GetInsurancePolicy data (the list path omits them).
      if (mounted) {
        context.read<InsuranceCubit>().loadInsuranceDetailsWithData(refreshed);
      }
    } catch (_) {
      // Silent failure — the slow-path refresh on tap will surface
      // any error message to the user. We don't want to block the
      // detail screen on this background hydrate.
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Policy Details',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              _currentInsurance.policyNumber,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF6366F1),
          labelColor: const Color(0xFF6366F1),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'Coverage'),
            Tab(text: 'Payments'),
            Tab(text: 'Claims'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCoverageTab(),
          _buildPaymentsTab(),
          _buildClaimsTab(),
        ],
      ),
      // FABs are tab-scoped:
      //   * Coverage tab (idx 0): "Renew Policy" — shown only when the
      //     policy is past its end_date AND a renew_link is configured.
      //     A one-tap action that opens MyCover's hosted-renewal webview.
      //   * Payments tab (idx 1): nothing (read-only history).
      //   * Claims tab (idx 2): "File Claim" — opens MyCover's
      //     hosted-claim webview.
      // MyCover doesn't expose a `PUT /policies/:id` endpoint, so neither
      // FAB pretends to mutate state our backend mirrors — both delegate
      // to MyCover's hosted forms and rely on `purchase.successful` /
      // `renewal.successful` webhooks (plus our policy resync worker) to
      // reflect the result.
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (context, _) {
          switch (_tabController.index) {
            case 0:
              return _shouldShowRenewCta ? _buildRenewFab() : const SizedBox.shrink();
            case 2:
              return _buildClaimFab();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildCoverageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyOverviewCard(),
          SizedBox(height: 12.h),
          _buildPolicyNumberCard(),
          if (_certificateUrl() != null) ...[
            SizedBox(height: 12.h),
            _buildCertificateButton(),
          ],
          // The Renew CTA used to live here as an inline button, but it's
          // a one-action surface — better as a FloatingActionButton on
          // this tab so it parallels the "File Claim" FAB on the Claims
          // tab. The FAB is wired in the parent Scaffold's
          // floatingActionButton builder and only shows when
          // `_shouldShowRenewCta` is true (policy expired + base link set).
          SizedBox(height: 20.h),
          _buildSectionHeader('Policy Holder Information'),
          SizedBox(height: 12.h),
          _buildPolicyHolderInfo(),
          SizedBox(height: 20.h),
          _buildSectionHeader('Coverage Details'),
          SizedBox(height: 12.h),
          _buildCoverageDetails(),
          SizedBox(height: 20.h),
          _buildSectionHeader('Policy Dates'),
          SizedBox(height: 12.h),
          _buildPolicyDates(),
          SizedBox(height: 20.h),
          if (_currentInsurance.beneficiaries.isNotEmpty) ...[
            _buildSectionHeader('Beneficiaries'),
            SizedBox(height: 12.h),
            _buildBeneficiaries(),
            SizedBox(height: 20.h),
          ],
          _buildSectionHeader('Features'),
          SizedBox(height: 12.h),
          _buildFeatures(),
          SizedBox(height: 20.h),
          _buildOptionalFieldsSection(),
          SizedBox(height: 80.h), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return BlocBuilder<InsuranceCubit, InsuranceState>(
      builder: (context, state) {
        // Loading: explicit spinner. Covers both initial fetch and
        // refresh after pull-to-refresh.
        if (state is InsuranceLoading || state is InsuranceInitial) {
          return _buildTabLoadingState();
        }
        // Error: surface the cubit's error message + a retry path.
        // Previously this state fell through to a blank screen.
        if (state is InsuranceError) {
          return _buildTabErrorState(
            message: state.message,
            onRetry: () => context
                .read<InsuranceCubit>()
                .loadInsuranceDetailsWithData(_currentInsurance),
          );
        }
        if (state is InsuranceDetailsLoaded) {
          final payments = state.payments;
          if (payments.isEmpty) {
            return _buildTabEmptyState(
              icon: Icons.payment,
              title: 'No payments yet',
              subtitle: 'Payment receipts will appear here as your '
                  'premium is debited and any renewals land.',
            );
          }
          final dateFormat = DateFormat('MMM dd, yyyy');
          return RefreshIndicator(
            color: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () async => context
                .read<InsuranceCubit>()
                .loadInsuranceDetailsWithData(_currentInsurance),
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return _buildPaymentCard(payment, dateFormat);
              },
            ),
          );
        }
        // Any other state shape (mid-flight transitions) — fall back to
        // a generic loading view rather than an invisible screen.
        return _buildTabLoadingState();
      },
    );
  }

  Widget _buildPaymentCard(InsurancePayment payment, DateFormat dateFormat) {
    Color statusColor;
    switch (payment.status) {
      case PaymentStatus.completed:
        statusColor = const Color(0xFF10B981);
        break;
      case PaymentStatus.pending:
      case PaymentStatus.processing:
        statusColor = const Color(0xFFFBBF24);
        break;
      case PaymentStatus.failed:
        statusColor = const Color(0xFFEF4444);
        break;
      case PaymentStatus.cancelled:
      case PaymentStatus.refunded:
        statusColor = const Color(0xFF6B7280);
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              payment.paymentMethod.icon,
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${CurrencySymbols.formatAmountWithCurrency(payment.amount, payment.currency.isNotEmpty ? payment.currency : _currentInsurance.currency)}',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  // Surface the payment method alongside the date so a
                  // renewal (mycover_hosted_renewal -> "Renewal") is
                  // distinguishable from the original purchase in history.
                  '${payment.paymentMethod.displayName} · ${dateFormat.format(payment.paymentDate)}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              payment.status.displayName,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimsTab() {
    return BlocBuilder<InsuranceCubit, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceLoading || state is InsuranceInitial) {
          return _buildTabLoadingState();
        }
        if (state is InsuranceError) {
          return _buildTabErrorState(
            message: state.message,
            onRetry: () => context
                .read<InsuranceCubit>()
                .loadInsuranceDetailsWithData(_currentInsurance),
          );
        }
        if (state is InsuranceDetailsLoaded) {
          final claims = state.claims;
          if (claims.isEmpty) {
            return _buildTabEmptyState(
              icon: Icons.description_outlined,
              title: 'No claims filed',
              subtitle: 'Use the "File Claim" button below if you need '
                  'to start one. Filed claims appear here with live status.',
            );
          }
          final dateFormat = DateFormat('MMM dd, yyyy');
          return RefreshIndicator(
            color: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () async => context
                .read<InsuranceCubit>()
                .loadInsuranceDetailsWithData(_currentInsurance),
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: claims.length,
              itemBuilder: (context, index) {
                final claim = claims[index];
                return _buildClaimCard(claim, dateFormat);
              },
            ),
          );
        }
        return _buildTabLoadingState();
      },
    );
  }

  /// Shared tab-level loading state. Centered spinner with our brand
  /// indigo so loading + content states feel consistent.
  Widget _buildTabLoadingState() {
    return const Center(
      child: LazerVaultLoader.small(),
    );
  }

  /// Shared tab-level empty state. Greyed icon + headline + subtitle.
  /// No CTA in here — the action buttons live as FABs on the Scaffold
  /// (Renew on Coverage, File Claim on Claims) so we don't double up.
  Widget _buildTabEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 72.sp,
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.3),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                height: 1.4,
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shared tab-level error state. Surfaces the cubit's friendly
  /// error message + a Retry CTA so the user has an obvious way
  /// forward instead of staring at a blank screen.
  Widget _buildTabErrorState({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 56.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding:
                    EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimCard(InsuranceClaim claim, DateFormat dateFormat) {
    Color statusColor;
    switch (claim.status) {
      case ClaimStatus.submitted:
        statusColor = const Color(0xFF6366F1);
        break;
      case ClaimStatus.underReview:
      case ClaimStatus.documented:
      case ClaimStatus.inspectionSubmitted:
      case ClaimStatus.repairEstimateRequested:
      case ClaimStatus.repairEstimateProvided:
      case ClaimStatus.offerSent:
        statusColor = const Color(0xFFFB923C);
        break;
      case ClaimStatus.approved:
      case ClaimStatus.offerAccepted:
        statusColor = const Color(0xFF10B981);
        break;
      case ClaimStatus.rejected:
      case ClaimStatus.offerRejected:
        statusColor = const Color(0xFFEF4444);
        break;
      case ClaimStatus.settled:
      case ClaimStatus.paid:
        statusColor = const Color.fromARGB(255, 78, 3, 208);
        break;
      case ClaimStatus.cancelled:
        statusColor = const Color(0xFF6B7280);
        break;
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.insuranceClaimTracking, arguments: claim),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.description,
                color: statusColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    claim.title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${claim.claimNumber} • ${dateFormat.format(claim.createdAt)}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${claim.currency} ${claim.claimAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    claim.status.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyOverviewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _currentInsurance.type.icon,
                style: TextStyle(fontSize: 32.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentInsurance.type.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _currentInsurance.provider,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(_currentInsurance.status),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${CurrencySymbols.formatAmountWithCurrency(_currentInsurance.premiumAmount, _currentInsurance.currency)}',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coverage',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${CurrencySymbols.formatAmountWithCurrency(_currentInsurance.coverageAmount, _currentInsurance.currency)}',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
        color = const Color(0xFFFBBF24);
        break;
      case InsuranceStatus.expired:
      case InsuranceStatus.refundFailed:
        color = const Color(0xFFEF4444);
        break;
      case InsuranceStatus.cancelled:
      case InsuranceStatus.refunded:
        color = const Color(0xFF6B7280);
        break;
      case InsuranceStatus.refundPending:
        color = const Color(0xFFFB923C);
        break;
      case InsuranceStatus.suspended:
      case InsuranceStatus.manualReview:
        color = const Color(0xFFF97316);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // Pulls the admin-configured claim URL (with customer_id + policy_id
  // appended) out of coverageDetails. The base link itself is
  // admin-editable via the dashboard Insurance Configuration tab and
  // stored in `system_settings.insurance.mycover.claim_link` — the
  // backend composes the per-policy URL by appending
  // `customer_id`, `policy_id`, `policy_number`, `product_id` and
  // returns it in coverageDetails['claim_url']. Flutter never
  // hardcodes the URL.
  //
  // MyCover does NOT expose an API for retrieving the merchant link, so
  // there's no API fallback when the system_setting is empty (the
  // backend has a static default that matches the admin-seeded value).
  String? _claimUrlFromInsurance(Insurance insurance) {
    final composed = insurance.coverageDetails['claim_url'];
    if (composed != null) {
      final s = composed.toString().trim();
      if (s.isNotEmpty && s != 'null') return s;
    }
    // Intentionally do NOT fall back to claim_link_base. Without the
    // composed URL (which the backend only emits when customer_id is
    // present) the provider can't tie the claim to a customer, and the
    // user would file an orphan claim that never appears in their list.
    return null;
  }

  /// Tap handler for File Claim. The bottom sheet OPENS IMMEDIATELY
  /// with chrome + a loading state, then resolves the URL via the
  /// resolver below. This guarantees the user always sees a clear
  /// loading/error UI inside our chrome rather than a toast that
  /// disappears before they can read it (the old pattern, which is
  /// what produced the "Couldn't open claim" flash users were
  /// reporting).
  void _openMyCoverClaimSheet() {
    final insurance = _currentInsurance;
    final provider = insurance.coverageDetails['provider_name']?.toString() ??
        insurance.provider;
    MyCoverClaimBottomSheet.show(
      context,
      policyLabel: insurance.policyNumber.isNotEmpty
          ? insurance.policyNumber
          : insurance.type.name,
      providerName: provider.isNotEmpty ? provider : null,
      urlResolver: _resolveClaimUrl,
    );
  }

  /// Resolver that the bottom sheet calls in its initState (and again on
  /// the user's retry tap). Fast-path returns the cached claim_url from
  /// the current snapshot; slow-path live-fetches `getInsuranceById` so
  /// MyCover can backfill customer_id → claim_url. Returns null when
  /// the backend reports the URL isn't ready yet (the sheet shows a
  /// "still finalising" message in that case). Throws on hard errors
  /// (network, auth) so the sheet shows the retry overlay.
  Future<String?> _resolveClaimUrl() async {
    final cached = _claimUrlFromInsurance(_currentInsurance);
    if (cached != null) return cached;
    final refreshed = await GetIt.I<InsuranceRepository>()
        .getInsuranceById(_currentInsurance.id);
    if (mounted && refreshed != null) {
      setState(() => _refreshedInsurance = refreshed);
    }
    return _claimUrlFromInsurance(refreshed ?? _currentInsurance);
  }

  // =====================================================================
  // Renewal — hosted MyCover webview (mirror of the claim flow).
  //
  // MyCover.ai has no REST endpoint for renewal either. The renewal
  // form is a hosted merchant URL configured by the admin in
  // `system_settings.insurance.mycover.renew_link`. The backend appends
  // `policy_number` + `email` (the two fields MyCover's merchant form
  // collects) and emits the composed URL in `coverageDetails['renew_url']`.
  // Flutter never hardcodes a URL.
  //
  // We surface the CTA only when the policy is within 30 days of
  // expiry OR already expired, since renewing earlier would be confusing
  // and MyCover's hosted form rejects renewals on far-future policies.
  String? _renewUrlFromInsurance(Insurance insurance) {
    final composed = insurance.coverageDetails['renew_url'];
    if (composed == null) return null;
    final s = composed.toString().trim();
    if (s.isEmpty || s == 'null') return null;
    return s;
  }

  bool get _shouldShowRenewCta {
    final insurance = _currentInsurance;
    // Only show the Renew CTA once the policy has actually expired.
    // Showing it on active policies (even days from expiry) confuses
    // the user and risks a duplicate-charge: MyCover's hosted form
    // will accept the renewal even when the policy is still active and
    // bill the card again, leaving us with two adjacent terms.
    //
    // `Insurance.isExpired` is `status == expired || endDate < now` —
    // the date side mirrors MyCover's authoritative `expiration_date`
    // via our 5-min snapshot refresh + 15-min resync worker, so this
    // gate stays in sync with MyCover state without an extra fetch.
    if (!insurance.isExpired) return false;
    // A renew_link_base is required so the bottom sheet can compose a
    // URL when the user taps. If it's missing (admin hasn't configured
    // it), surface nothing — the slow-path snackbar would only confuse.
    final hasBase = ((insurance.coverageDetails['renew_link_base']
                ?.toString()
                .trim()
                .isNotEmpty) ??
        false);
    if (!hasBase && _renewUrlFromInsurance(insurance) == null) return false;
    return true;
  }

  /// Tap handler for Renew Policy. Same resolver-driven pattern as the
  /// claim flow — open the bottom sheet immediately, let it resolve
  /// the URL itself and surface any error in its own chrome.
  /// `.whenComplete` re-hydrates the policy after the sheet closes:
  /// if the user completed the renewal in the webview, MyCover's
  /// webhook will have already moved policy_end_date forward; the
  /// fresh GetInsurancePolicy picks that up and the Renew FAB
  /// disappears.
  void _openMyCoverRenewSheet() {
    final insurance = _currentInsurance;
    final provider = insurance.coverageDetails['provider_name']?.toString() ??
        insurance.provider;
    MyCoverClaimBottomSheet.showRenewal(
      context,
      policyLabel: insurance.policyNumber.isNotEmpty
          ? insurance.policyNumber
          : insurance.type.name,
      providerName: provider.isNotEmpty ? provider : null,
      urlResolver: _resolveRenewUrl,
    ).whenComplete(_hydrateExtrasInBackground);
  }

  /// Renewal twin of `_resolveClaimUrl` — see comments there. The two
  /// resolvers stay separate (rather than one parameterised function)
  /// because they read different fields off `coverageDetails`
  /// (`claim_url` vs `renew_url`) and the backend composes them off
  /// different `system_settings` keys.
  Future<String?> _resolveRenewUrl() async {
    final cached = _renewUrlFromInsurance(_currentInsurance);
    if (cached != null) return cached;
    final refreshed = await GetIt.I<InsuranceRepository>()
        .getInsuranceById(_currentInsurance.id);
    if (mounted && refreshed != null) {
      setState(() => _refreshedInsurance = refreshed);
    }
    return _renewUrlFromInsurance(refreshed ?? _currentInsurance);
  }

  // Pull the certificate URL from coverageDetails — the backend stuffs
  // it in the legacy `metadata` JSON field which the gateway proxy
  // parses into `coverageDetails`. Live-fetched on the backend from
  // MyCover.GetPolicyByID, so this stays fresh.
  String? _certificateUrl() {
    final raw = _currentInsurance.coverageDetails['certificate_url'];
    if (raw == null) return null;
    final s = raw.toString().trim();
    if (s.isEmpty || s == 'null') return null;
    return s;
  }

  Widget _buildCertificateButton() {
    final url = _certificateUrl();
    if (url == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () async {
        final uri = Uri.tryParse(url);
        if (uri == null) return;
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar('Certificate', 'Could not open the certificate link.');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_outlined, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'View Certificate',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Renew Policy FAB — Coverage tab only, expired policies only.
  /// Red gradient so the user immediately reads it as "your policy is
  /// down, tap to bring it back up". No on-FAB loading state: the
  /// bottom sheet opens instantly with its own loading UI, so the
  /// tap-to-open is always single-frame.
  Widget _buildRenewFab() {
    return FloatingActionButton.extended(
      onPressed: _openMyCoverRenewSheet,
      backgroundColor: const Color(0xFFEF4444),
      disabledElevation: 0,
      icon: Icon(Icons.autorenew_rounded, color: Colors.white, size: 18.sp),
      label: Text(
        'Renew Policy',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  /// File Claim FAB — Claims tab only. Same single-frame open as Renew.
  Widget _buildClaimFab() {
    return FloatingActionButton.extended(
      onPressed: _openMyCoverClaimSheet,
      backgroundColor: const Color(0xFF6366F1),
      disabledElevation: 0,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'File Claim',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  /// Prominent, copyable policy number — the identifier users quote to
  /// support or the provider. Hidden until it's known (blank on the list path,
  /// filled once the detail hydrate lands).
  Widget _buildPolicyNumberCard() {
    final pn = _currentInsurance.policyNumber.trim();
    if (pn.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.confirmation_number_outlined,
              color: const Color(0xFF6366F1), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Policy Number',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
                SizedBox(height: 2.h),
                Text(pn,
                    style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy_rounded,
                color: const Color(0xFF6366F1), size: 18.sp),
            tooltip: 'Copy',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: pn));
              Get.snackbar('Copied', 'Policy number copied to clipboard',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyHolderInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Name', _currentInsurance.policyHolderName, Icons.person),
          SizedBox(height: 12.h),
          _buildDetailRow('Email', _currentInsurance.policyHolderEmail, Icons.email),
          SizedBox(height: 12.h),
          _buildDetailRow('Phone', _currentInsurance.policyHolderPhone, Icons.phone),
        ],
      ),
    );
  }

  Widget _buildCoverageDetails() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Premium Amount',
            '${CurrencySymbols.formatAmountWithCurrency(_currentInsurance.premiumAmount, _currentInsurance.currency)}',
            Icons.attach_money,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Coverage Amount',
            '${CurrencySymbols.formatAmountWithCurrency(_currentInsurance.coverageAmount, _currentInsurance.currency)}',
            Icons.account_balance_wallet,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Currency',
            _currentInsurance.currency,
            Icons.monetization_on,
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDates() {
    final dateFormat = DateFormat('MMM dd, yyyy');
    // Read from _currentInsurance (= refreshed snapshot from
    // GetInsurancePolicy) so the dates reflect the live MyCover sync,
    // not the leaner list-view payload. Start/End come straight from
    // MyCover's policy record (live-fetched every 5 minutes on the
    // backend); the Renewal Date is end_date for MyCover policies
    // since they're one-shot annual purchases — there's no recurring
    // premium schedule.
    final insurance = _currentInsurance;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Start Date',
            dateFormat.format(insurance.startDate),
            Icons.calendar_today,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'End Date',
            dateFormat.format(insurance.endDate),
            Icons.event,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Renewal Date',
            dateFormat.format(insurance.nextPaymentDate),
            Icons.autorenew_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiaries() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: _currentInsurance.beneficiaries.map((beneficiary) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 14.sp,
                  color: const Color(0xFF6366F1),
                ),
                SizedBox(width: 6.w),
                Text(
                  beneficiary,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF6366F1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeatures() {
    final features = _currentInsurance.coverageDetails['features'] as List? ?? [];

    if (features.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          'No features listed',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: features.map((feature) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 14.sp,
                  color: const Color(0xFF10B981),
                ),
                SizedBox(width: 6.w),
                Text(
                  feature.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionalFieldsSection() {
    final coverageDetails = _currentInsurance.coverageDetails;
    bool hasOptionalFields = false;
    List<Widget> fieldWidgets = [];

    // Check and display deductible
    if (coverageDetails.containsKey('deductible')) {
      hasOptionalFields = true;
      fieldWidgets.add(_buildDetailRow(
        'Deductible',
        '${CurrencySymbols.formatAmountWithCurrency((coverageDetails['deductible'] as num).toDouble(), _currentInsurance.currency)}',
        Icons.attach_money,
      ));
      fieldWidgets.add(SizedBox(height: 12.h));
    }

    // Check and display coverage limit
    if (coverageDetails.containsKey('coverage_limit')) {
      hasOptionalFields = true;
      fieldWidgets.add(_buildDetailRow(
        'Coverage Limit',
        '${CurrencySymbols.formatAmountWithCurrency((coverageDetails['coverage_limit'] as num).toDouble(), _currentInsurance.currency)}',
        Icons.trending_up,
      ));
      fieldWidgets.add(SizedBox(height: 12.h));
    }

    // Check and display description
    if (_currentInsurance.description != null && _currentInsurance.description!.isNotEmpty) {
      hasOptionalFields = true;
      fieldWidgets.add(_buildDetailRow(
        'Description',
        _currentInsurance.description!,
        Icons.description,
      ));
    }

    if (!hasOptionalFields) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Additional Information'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: fieldWidgets,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: const Color(0xFF6366F1),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
