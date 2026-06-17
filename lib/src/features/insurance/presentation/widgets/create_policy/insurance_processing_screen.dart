import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../../domain/repositories/insurance_repository.dart';
import '../../../../account_cards_summary/services/balance_websocket_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Screen showing insurance purchase progress with animated steps
class InsuranceProcessingScreen extends StatefulWidget {
  const InsuranceProcessingScreen({super.key});

  @override
  State<InsuranceProcessingScreen> createState() => _InsuranceProcessingScreenState();
}

class _InsuranceProcessingScreenState extends State<InsuranceProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Watchdog timer — if no terminal state (success/error) is emitted
  // within this window, MyCover is probably hung or the gRPC call
  // dropped. Surface a retry-prompt so the user isn't staring at an
  // infinite spinner.
  static const Duration _hangTimeout = Duration(seconds: 60);
  Timer? _hangTimer;
  bool _hangTimedOut = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
    _armHangTimer();
  }

  void _armHangTimer() {
    _hangTimer?.cancel();
    _hangTimedOut = false;
    _hangTimer = Timer(_hangTimeout, () {
      if (!mounted) return;
      setState(() => _hangTimedOut = true);
    });
  }

  @override
  void dispose() {
    _hangTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _currencySymbol(String currency) {
    final c = currency.toLowerCase().trim();
    if (c == 'ngn' || c.contains('naira')) return '\u20A6';
    if (c == 'usd' || c.contains('dollar')) return '\$';
    if (c == 'gbp' || c.contains('pound')) return '\u00A3';
    if (c == 'eur' || c.contains('euro')) return '\u20AC';
    if (c == 'ghs' || c.contains('cedi')) return '\u20B5';
    if (c == 'kes' || c.contains('shilling')) return 'KSh';
    if (c == 'zar' || c.contains('rand')) return 'R';
    return currency;
  }

  /// Spinner shown before the cubit emits any processing state. After
  /// the watchdog fires, swap to an "is this taking too long?" panel
  /// with a Go Back option so the user is never trapped staring at
  /// a static spinner.
  Widget _buildInitialSpinner() {
    if (!_hangTimedOut) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Center(child: LazerVaultLoader.small()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.hourglass_bottom_outlined,
                  color: const Color(0xFFFB923C), size: 48.sp),
              SizedBox(height: 16.h),
              Text('This is taking longer than usual',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Our insurance provider is slow to respond. Your '
                  'payment is safe — we will refund automatically if '
                  'the policy does not issue. You can wait or go '
                  'back and check your purchases later.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                      height: 1.4)),
              SizedBox(height: 28.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F1F1F),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Go back',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 12.h),
              LazerVaultLoader.tiny(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePolicyCubit, CreatePolicyState>(
      listener: (context, state) {
        // Any terminal state cancels the hang watchdog.
        if (state is InsurancePurchaseSuccess
            || state is CreatePolicyError) {
          _hangTimer?.cancel();
        }
        if (state is InsurancePurchaseSuccess) {
          _pulseController.stop();
          // Navigate to success/receipt screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => InsurancePurchaseReceiptScreen(
                purchaseResult: (state as InsurancePurchaseSuccess).purchaseResult,
                product: (state as InsurancePurchaseSuccess).product,
                quote: (state as InsurancePurchaseSuccess).quote,
              ),
            ),
          );
        } else if (state is CreatePolicyError) {
          _pulseController.stop();
          // Show error and go back
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((state as CreatePolicyError).message),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is! InsurancePurchaseProcessing &&
            state is! InsurancePurchaseSuccess) {
          return _buildInitialSpinner();
        }

        final processingState = state is InsurancePurchaseProcessing
            ? (state as InsurancePurchaseProcessing)
            : null;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF6366F1),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Processing Payment',
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Please wait while we secure your policy',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Product preview card
                  if (processingState?.product != null) ...[
                    _buildProductCard(processingState!.product, processingState!.quote),
                    SizedBox(height: 32.h),
                  ],

                  // Progress steps
                  Expanded(
                    child: _buildProgressSteps(processingState?.step),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(InsuranceProduct product, InsuranceQuote quote) {
    final formatter = NumberFormat('#,##0.00');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4E03D0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  product.category.icon,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      product.providerName,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white30, height: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white70,
                ),
              ),
              Text(
                '${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSteps(InsuranceProcessingStep? currentStep) {
    final steps = [
      _ProgressStep(
        id: 0,
        title: 'Verifying PIN',
        subtitle: 'Validating your transaction PIN',
        icon: Icons.lock_outline,
      ),
      _ProgressStep(
        id: 1,
        title: 'Processing Payment',
        subtitle: 'Initiating premium payment',
        icon: Icons.payment_outlined,
      ),
      _ProgressStep(
        id: 2,
        title: 'Activating Policy',
        subtitle: 'Issuing your insurance policy',
        icon: Icons.verified_user_outlined,
      ),
      _ProgressStep(
        id: 3,
        title: 'Complete',
        subtitle: 'Policy activated successfully',
        icon: Icons.check_circle,
      ),
    ];

    // Map enum step to index
    final stepIndex = switch (currentStep) {
      InsuranceProcessingStep.initiated => 0,
      InsuranceProcessingStep.validatingPin => 0,
      // Documents upload runs between PIN and fund-hold. Treat it as
      // still under the "verifying" rail so the user sees motion on
      // the first step.
      InsuranceProcessingStep.uploadingDocuments => 0,
      InsuranceProcessingStep.holdingFunds => 1,
      InsuranceProcessingStep.purchasingPolicy => 2,
      InsuranceProcessingStep.completed => 3,
      InsuranceProcessingStep.failed => -1,
      null => 0,
    };

    return Column(
      children: [
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isCompleted = index < stepIndex;
          final isCurrent = index == stepIndex;
          final isPending = index > stepIndex;

          return _buildStepItem(
            step: step,
            isCompleted: isCompleted,
            isCurrent: isCurrent,
            isPending: isPending,
            progress: currentStep == InsuranceProcessingStep.completed ? 1.0 : null,
          );
        }),
      ],
    );
  }

  Widget _buildStepItem({
    required _ProgressStep step,
    required bool isCompleted,
    required bool isCurrent,
    required bool isPending,
    double? progress,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          Row(
            children: [
              // Icon container
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isCurrent ? _pulseAnimation.value : 1.0,
                    child: _buildStepIcon(step, isCompleted, isCurrent, isPending),
                  );
                },
              ),
              SizedBox(width: 16.w),
              // Step text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                        color: isCompleted || isCurrent
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      step.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: isCompleted || isCurrent
                            ? Colors.white70
                            : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildStepIcon(_ProgressStep step, bool isCompleted, bool isCurrent, bool isPending) {
    Color bgColor;
    Color iconColor;
    Widget? icon;

    if (isCompleted) {
      bgColor = const Color(0xFF10B981);
      iconColor = Colors.white;
      icon = Icon(Icons.check, size: 20.sp, color: iconColor);
    } else if (isCurrent) {
      bgColor = const Color(0xFF6366F1);
      iconColor = Colors.white;
      icon = LazerVaultLoader.small();
    } else {
      bgColor = const Color(0xFF1F1F1F);
      iconColor = const Color(0xFF9CA3AF);
      icon = Icon(step.icon, size: 20.sp, color: iconColor);
    }

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: const Color(0xFF6366F1), width: 2)
            : null,
      ),
      child: Center(child: icon),
    );
  }
}

class _ProgressStep {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;

  const _ProgressStep({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// Receipt/Success screen shown after successful insurance purchase
class InsurancePurchaseReceiptScreen extends StatefulWidget {
  final dynamic purchaseResult;
  final InsuranceProduct product;
  final InsuranceQuote quote;

  const InsurancePurchaseReceiptScreen({
    super.key,
    required this.purchaseResult,
    required this.product,
    required this.quote,
  });

  @override
  State<InsurancePurchaseReceiptScreen> createState() =>
      _InsurancePurchaseReceiptScreenState();
}

class _InsurancePurchaseReceiptScreenState
    extends State<InsurancePurchaseReceiptScreen> {
  // Mutable result so a deferred (processing) purchase can resolve to
  // completed live, on this very screen, via the balance-WS — never a poll.
  late dynamic _pr;
  StreamSubscription? _purchaseSub;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _pr = widget.purchaseResult;
    if (!_confirmed) {
      // 1) Live: balance-WS pushes insurance_purchase_completed; refetch on it.
      try {
        final ws = GetIt.I<BalanceWebSocketService>();
        _purchaseSub = ws.insurancePurchaseEvents.listen((e) {
          if (!mounted) return;
          if (e.isPurchaseTerminal || e.status == 'completed' || e.status == 'active') {
            _refreshStatus();
          }
        });
      } catch (_) {
        // WS service not registered (shouldn't happen) — fetch-on-load +
        // pull-to-refresh still resolve it.
      }
      // 2) Fetch-on-load: catch an already-completed status (webhook landed
      //    between purchase and this screen opening).
      WidgetsBinding.instance.addPostFrameCallback((_) => _refreshStatus());
    }
  }

  @override
  void dispose() {
    _purchaseSub?.cancel();
    super.dispose();
  }

  String _statusStr() {
    final pr = _pr;
    if (pr is InsurancePurchaseResult) return pr.status;
    if (pr is Map) return (pr['status'] ?? '').toString();
    return '';
  }

  String _referenceStr() {
    final pr = _pr;
    if (pr is InsurancePurchaseResult) return pr.reference;
    if (pr is Map) return (pr['reference'] ?? '').toString();
    return '';
  }

  // Confirmed = policy actually active. Anything else (processing / pending /
  // awaiting_webhook) shows the "confirming" state, not a false success.
  bool get _confirmed {
    final pr = _pr;
    if (pr is InsurancePurchaseResult) return pr.isCompleted;
    final s = _statusStr();
    return s == 'completed' || s == 'active';
  }

  // Re-fetch the authoritative status by reference (no Timer.periodic — this
  // fires only on WS events, on load, and on pull-to-refresh).
  Future<void> _refreshStatus() async {
    final ref = _referenceStr();
    if (ref.isEmpty || _refreshing) return;
    _refreshing = true;
    try {
      final updated =
          await GetIt.I<InsuranceRepository>().getInsurancePurchaseStatus(reference: ref);
      if (mounted) setState(() => _pr = updated);
    } catch (_) {
      // Leave the "confirming" state; pull-to-refresh / next WS event retries.
    } finally {
      _refreshing = false;
    }
  }

  String _currencySymbol(String currency) {
    final c = currency.toLowerCase().trim();
    if (c == 'ngn' || c.contains('naira')) return '\u20A6';
    if (c == 'usd' || c.contains('dollar')) return '\$';
    if (c == 'gbp' || c.contains('pound')) return '\u00A3';
    if (c == 'eur' || c.contains('euro')) return '\u20AC';
    if (c == 'ghs' || c.contains('cedi')) return '\u20B5';
    if (c == 'kes' || c.contains('shilling')) return 'KSh';
    if (c == 'zar' || c.contains('rand')) return 'R';
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00');
    final now = DateTime.now();

    // Aliases so the body below reads from the LIVE mutable result/widget
    // fields (StatefulWidget refactor) without touching every reference.
    final purchaseResult = _pr;
    final product = widget.product;
    final quote = widget.quote;
    final confirmed = _confirmed;

    // Typed view of the result when available (promotes cleanly; the Map
    // path is a legacy/defensive fallback).
    final InsurancePurchaseResult? prTyped =
        purchaseResult is InsurancePurchaseResult ? purchaseResult : null;
    final Map? prMap = purchaseResult is Map ? purchaseResult : null;

    // Extract data - handle both typed entity and legacy map.
    final rawPolicyNumber = prMap != null
        ? (prMap['policy_number'] ?? '')
        : (prTyped?.policyNumber ?? '');
    final policyNumber = rawPolicyNumber.toString().isNotEmpty
        ? rawPolicyNumber.toString()
        : (confirmed ? '—' : 'Pending confirmation');
    final status = prMap != null
        ? (prMap['status'] ?? 'active').toString()
        : (prTyped?.status ?? 'active');

    // Provider-confirmed policy detail (only present on the typed entity).
    final String certificateUrl = prTyped?.certificateUrl ?? '';
    final DateTime? policyStart = prTyped?.startDate;
    final DateTime? policyEnd = prTyped?.endDate;
    final double? coverageAmount = prTyped?.coverageAmount;

    // Status-aware header: only claim "active" when the policy is actually
    // confirmed. A deferred (processing) purchase shows a "confirming"
    // state that resolves live via the balance-WS (see initState).
    final Color headerColor =
        confirmed ? const Color(0xFF10B981) : const Color(0xFFFB923C);
    final IconData headerIcon =
        confirmed ? Icons.check_circle : Icons.schedule_rounded;
    final String headerTitle =
        confirmed ? 'Purchase Successful!' : 'Payment Received';
    final String headerSubtitle = confirmed
        ? 'Your insurance policy is now active'
        : 'We’re confirming your policy with the provider. This page '
            'updates automatically — pull down to refresh.';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFF1F1F1F),
          onRefresh: _refreshStatus,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
              SizedBox(height: 40.h),

              // Status header (confirmed = green check, processing = amber clock)
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: headerColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: confirmed
                    ? Icon(headerIcon, color: headerColor, size: 48.sp)
                    : LazerVaultLoader.medium(),
              ),
              SizedBox(height: 24.h),

              Text(
                headerTitle,
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                headerSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 32.h),

              // Policy details card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Policy Details',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    _buildReceiptRow('Policy Number', policyNumber),
                    _buildReceiptRow('Status', status.replaceAll('_', ' ').toUpperCase()),
                    Divider(color: const Color(0xFF2D2D2D), height: 24.h),
                    _buildReceiptRow('Product', product.name),
                    _buildReceiptRow('Provider', product.providerName),
                    _buildReceiptRow('Category', product.category.displayName),
                    Divider(color: const Color(0xFF2D2D2D), height: 24.h),
                    _buildReceiptRow('Premium Amount',
                        '${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                        isAmount: true),
                    if (coverageAmount != null && coverageAmount > 0)
                      _buildReceiptRow('Sum Insured',
                          '${_currencySymbol(quote.currency)}${formatter.format(coverageAmount)}'),
                    if (quote.coverageItems.isNotEmpty)
                      _buildReceiptRow('Coverage', quote.coverageItems.first),
                    SizedBox(height: 16.h),
                    if (policyStart != null)
                      _buildReceiptRow('Start Date',
                          DateFormat('MMM dd, yyyy').format(policyStart)),
                    if (policyEnd != null)
                      _buildReceiptRow('End Date',
                          DateFormat('MMM dd, yyyy').format(policyEnd)),
                    _buildReceiptRow('Purchase Date',
                        DateFormat('MMM dd, yyyy • HH:mm').format(now)),
                    _buildReceiptRow('Reference',
                        purchaseResult is Map
                            ? (purchaseResult as Map)['reference'] ?? 'N/A'
                            : (purchaseResult.reference?.toString() ?? 'N/A')),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Coverage highlights
              if (quote.coverageItems.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coverage Highlights',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ...quote.coverageItems.take(4).map((item) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF10B981),
                              size: 16.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],

              // Action buttons
              if (certificateUrl.isNotEmpty) ...[
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final uri = Uri.tryParse(certificateUrl);
                      if (uri != null) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF6366F1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    icon: Icon(Icons.description_outlined,
                        color: const Color(0xFF6366F1), size: 18.sp),
                    label: Text(
                      'View Certificate',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Back to Dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'You can view your policy details in the Insurance section',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isAmount ? FontWeight.w700 : FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
