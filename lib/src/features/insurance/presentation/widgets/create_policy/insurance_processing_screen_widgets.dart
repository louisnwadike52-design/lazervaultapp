part of 'insurance_processing_screen.dart';

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
              SizedBox(height: 28.h),

              // Hero premium amount — mirrors the send-funds receipt.
              Text(
                'Premium paid',
                style: GoogleFonts.inter(
                    fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
              ),
              SizedBox(height: 6.h),
              Text(
                '${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                style: GoogleFonts.inter(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.0,
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

              // Action buttons — Share + View Certificate (themed in-app
              // webview sheet), then a full-width Done.
              Row(
                children: [
                  Expanded(
                    child: _outlinedCta(
                      icon: Icons.ios_share_rounded,
                      label: 'Share',
                      onTap: () => _shareReceipt(
                        policyNumber: policyNumber,
                        productName: product.name,
                        provider: product.providerName,
                        amount:
                            '${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                        reference: _referenceStr(),
                        status: status,
                      ),
                    ),
                  ),
                  if (certificateUrl.isNotEmpty) ...[
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _outlinedCta(
                        icon: Icons.workspace_premium_rounded,
                        label: 'Certificate',
                        onTap: () => _viewCertificate(certificateUrl),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 12.h),
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
                    'Done',
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

  Widget _outlinedCta({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 52.h,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF6366F1)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        icon: Icon(icon, color: const Color(0xFF6366F1), size: 18.sp),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6366F1),
          ),
        ),
      ),
    );
  }

  /// Opens the policy certificate in the app's themed in-app webview sheet
  /// (reuses [InsuranceTermsBottomSheet]) instead of kicking out to a browser.
  void _viewCertificate(String url) {
    InsuranceTermsBottomSheet.show(
      context,
      urlResolver: () async => url,
      title: 'Insurance Certificate',
      subtitle: 'Your policy document',
      icon: Icons.workspace_premium_rounded,
    );
  }

  void _shareReceipt({
    required String policyNumber,
    required String productName,
    required String provider,
    required String amount,
    required String reference,
    required String status,
  }) {
    final text = 'Insurance Policy Receipt\n\n'
        'Product: $productName\n'
        'Provider: $provider\n'
        'Policy Number: $policyNumber\n'
        'Premium: $amount\n'
        'Reference: $reference\n'
        'Status: ${status.replaceAll('_', ' ').toUpperCase()}\n\n'
        'Purchased on Lazervault.';
    SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),text: text));
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
