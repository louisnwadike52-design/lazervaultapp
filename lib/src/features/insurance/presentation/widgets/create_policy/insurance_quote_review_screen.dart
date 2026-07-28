import 'dart:async';

import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../insurance_terms_bottom_sheet.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:get_it/get_it.dart';
import '../../../data/services/coverage_summary_service.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Screen 3: Review quote details - premium, coverage breakdown, provider info
class InsuranceQuoteReviewScreen extends StatefulWidget {
  const InsuranceQuoteReviewScreen({super.key});

  /// Bumped by the carousel when the user taps Confirm & Pay without
  /// accepting the agreement. The screen state listens, scrolls the
  /// terms row into view, and flashes a red highlight on it.
  /// Using a ValueNotifier (rather than a GlobalKey on the State) keeps
  /// the screen const-constructible inside the PageView.
  static final ValueNotifier<int> requestTermsFocus = ValueNotifier<int>(0);

  @override
  State<InsuranceQuoteReviewScreen> createState() =>
      _InsuranceQuoteReviewScreenState();
}

class _InsuranceQuoteReviewScreenState extends State<InsuranceQuoteReviewScreen>
    with TransactionPinMixin {
  Timer? _countdownTimer;
  Duration _remaining = Duration.zero;

  // Scroll target for the terms checkbox so the carousel can request
  // the user scroll to it on Confirm & Pay when terms aren't accepted.
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _termsKey = GlobalKey();
  bool _termsValidationError = false;

  /// AI-generated coverage summary. Keyed by quote_id so navigating
  /// back+forward doesn't refetch unnecessarily.
  String? _summarisedQuoteId;
  CoverageSummary? _coverageSummary;
  bool _coverageSummaryLoading = false;
  String? _coverageSummaryError;

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
  void initState() {
    super.initState();
    InsuranceQuoteReviewScreen.requestTermsFocus.addListener(_handleTermsFocusRequest);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    InsuranceQuoteReviewScreen.requestTermsFocus.removeListener(_handleTermsFocusRequest);
    _scrollController.dispose();
    super.dispose();
  }

  /// Triggered by the carousel when the user taps Confirm & Pay without
  /// ticking the terms checkbox. Scrolls the terms row into view and
  /// flips the inline error flag so the row renders with a red border
  /// + helper text.
  void _handleTermsFocusRequest() {
    if (!mounted) return;
    setState(() => _termsValidationError = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _termsKey.currentContext;
      if (ctx == null || !mounted) return;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    });
  }

  void _startCountdown(DateTime validUntil) {
    _countdownTimer?.cancel();
    _updateRemaining(validUntil);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _updateRemaining(validUntil);
    });
  }

  void _updateRemaining(DateTime validUntil) {
    final now = DateTime.now();
    final diff = validUntil.difference(now);
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
  }

  Color _countdownColor() {
    if (_remaining.inSeconds <= 0) return const Color(0xFFEF4444);
    if (_remaining.inSeconds <= 30) return const Color(0xFFEF4444);
    if (_remaining.inSeconds <= 120) return const Color(0xFFFB923C);
    return const Color(0xFF10B981);
  }

  String _formatCountdown() {
    if (_remaining.inSeconds <= 0) return 'Expired';
    final minutes = _remaining.inMinutes;
    final seconds = _remaining.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePolicyCubit, CreatePolicyState>(
      builder: (context, state) {
        if (state is InsuranceQuoteLoading) {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              LazerVaultLoader.small(),
              SizedBox(height: 16.h),
              Text('Getting your quote...', style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            ]),
          );
        }

        if (state is InsuranceQuoteLoaded) {
          // Start or restart countdown when quote has validUntil
          if (state.quote.validUntil != null) {
            // Only start if not already counting down for this quote
            if (_countdownTimer == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _startCountdown(state.quote.validUntil!);
              });
            }
          }
          return _buildQuoteDetails(context, state);
        }

        if (state is CreatePolicyError) {
          return _buildError(context, state.message);
        }

        return Center(child: Text('Loading quote...',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))));
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 48.sp),
          SizedBox(height: 16.h),
          Text(message, textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
          SizedBox(height: 24.h),
          GestureDetector(
            onTap: () {
              _countdownTimer?.cancel();
              _countdownTimer = null;
              context.read<CreatePolicyCubit>().getQuote();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(8.r)),
              child: Text('Get New Quote', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildQuoteDetails(BuildContext context, InsuranceQuoteLoaded state) {
    final quote = state.quote;
    final product = state.product;
    final formatter = NumberFormat('#,##0.00');
    final isExpired = quote.isExpired;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 8.h),
            Text('Your Quote', style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            SizedBox(height: 4.h),
            Text('Review your insurance quote details', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
            SizedBox(height: 20.h),

            // Premium amount card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(children: [
                Text('Premium', style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.white70)),
                SizedBox(height: 4.h),
                Text('${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                  style: GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.white)),
                if (quote.validUntil != null) ...[
                  SizedBox(height: 8.h),
                  // Live countdown
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _countdownColor().withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isExpired ? Icons.timer_off : Icons.timer,
                          color: _countdownColor(),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          isExpired ? 'Quote Expired' : 'Expires in ${_formatCountdown()}',
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: _countdownColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ]),
            ),
            SizedBox(height: 20.h),

            // Provider info with info button
            _buildInfoCardWithAction('Provider', [
              _buildInfoRow('Name', product.providerName),
              _buildInfoRow('Product', product.name),
              _buildInfoRow('Category', product.category.displayName),
            ], onInfo: () => _showProductInfoSheet(context, product)),
            SizedBox(height: 12.h),

            // AI-generated coverage summary. Replaces the raw HTML
            // coverage rendering — the chat-agent-gateway endpoint
            // distills MyCover's mixed-quality descriptions into a
            // concise 2-3 sentence summary + 3-5 bullets. Fires on
            // every new quote and is keyed by quote_id so navigating
            // back+forward doesn't refetch.
            if (quote.coverageSummary.isNotEmpty || quote.coverageItems.isNotEmpty)
              _buildAiCoverageCard(context, state),

            // View Terms link
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => _openTermsBottomSheet(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gavel, color: const Color(0xFF6366F1), size: 16.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'View Terms & Conditions',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF6366F1),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
            ),

            // Quote details
            if (quote.quoteDetails.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _buildInfoCard('Details',
                quote.quoteDetails.entries.map((e) => _buildInfoRow(e.key, e.value)).toList()),
            ],

            // Account selector + terms — these used to live on the
            // dropped "Confirm & Pay" slide. The carousel's bottom
            // navigation button handles the actual purchase.
            if (!isExpired) ...[
              SizedBox(height: 20.h),
              Text('Pay with', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              SizedBox(height: 8.h),
              _buildAccountSelector(context, quote.currency, quote.premium),
              SizedBox(height: 16.h),
              _buildTermsCheckbox(context, product, quote),
            ],

            // Expired quote action
            if (isExpired) ...[
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  _countdownTimer?.cancel();
                  _countdownTimer = null;
                  context.read<CreatePolicyCubit>().getQuote();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C), borderRadius: BorderRadius.circular(10.r)),
                  child: Center(child: Text('Get New Quote',
                    style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white))),
                ),
              ),
            ],
            SizedBox(height: 20.h),
          ]),
        ),

        // Expired overlay
        if (isExpired)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0A0A0A).withValues(alpha: 0.7),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(40.w),
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer_off, color: const Color(0xFFEF4444), size: 48.sp),
                      SizedBox(height: 16.h),
                      Text(
                        'Quote Expired',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'This quote is no longer valid. Please get a new quote to continue.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          _countdownTimer?.cancel();
                          _countdownTimer = null;
                          context.read<CreatePolicyCubit>().getQuote();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              'Get New Quote',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Fetch the AI-generated coverage summary on first render of this
  /// quote. Idempotent — keyed by quote id so back/forward navigation
  /// reuses the cached result.
  void _maybeFetchCoverageSummary(InsuranceQuoteLoaded state) {
    final qid = state.quote.quoteId;
    if (_summarisedQuoteId == qid && (_coverageSummary != null || _coverageSummaryError != null)) {
      return;
    }
    if (_coverageSummaryLoading && _summarisedQuoteId == qid) return;
    _summarisedQuoteId = qid;
    _coverageSummary = null;
    _coverageSummaryError = null;
    _coverageSummaryLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final svc = CoverageSummaryService();
        final res = await svc.summarize(
          productId: state.product.id,
          productName: state.product.name,
          providerName: state.product.providerName,
          category: state.product.category.displayName,
          coverageSummary: state.quote.coverageSummary,
          coverageItems: state.quote.coverageItems,
          currency: state.quote.currency,
        );
        if (!mounted || _summarisedQuoteId != qid) return;
        setState(() {
          _coverageSummary = res;
          _coverageSummaryLoading = false;
        });
      } catch (e) {
        if (!mounted || _summarisedQuoteId != qid) return;
        setState(() {
          _coverageSummaryError = e.toString();
          _coverageSummaryLoading = false;
        });
      }
    });
  }

  Widget _buildAiCoverageCard(BuildContext context, InsuranceQuoteLoaded state) {
    _maybeFetchCoverageSummary(state);
    if (_coverageSummaryLoading) {
      return _buildInfoCard('Coverage', [
        Row(children: [
          LazerVaultLoader(size: 14),
          SizedBox(width: 10.w),
          Text('Summarising coverage…', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
        ]),
      ]);
    }
    final summary = _coverageSummary;
    if (summary == null) {
      // AI failed entirely — fall back to a plain text rendering of
      // whatever raw description we have so the user is never staring
      // at nothing.
      return _buildInfoCard('Coverage', [
        if (state.quote.coverageSummary.isNotEmpty)
          Padding(padding: EdgeInsets.only(bottom: 8.h),
            child: _buildRichContent(state.quote.coverageSummary, const Color(0xFF9CA3AF))),
        ...state.quote.coverageItems.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(child: _buildRichContent(item, Colors.white)),
          ]),
        )),
      ]);
    }
    return _buildInfoCard('Coverage', [
      if (summary.summary.isNotEmpty)
        Padding(padding: EdgeInsets.only(bottom: summary.bullets.isEmpty ? 0 : 10.h),
          child: Text(
            summary.summary,
            style: GoogleFonts.inter(fontSize: 13.sp, height: 1.4, color: Colors.white),
          ),
        ),
      ...summary.bullets.map((b) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(child: Text(b, style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white))),
        ]),
      )),
    ]);
  }

  /// Active-account-only display on the Review slide.
  ///
  /// Per product decision: the last slide should *only* show the active
  /// account selected on the dashboard — no account-change bottom sheet,
  /// no expand chevron, no list. Users wanting to pay from a different
  /// account switch their active account before starting the purchase.
  /// The currency-mismatch and missing-account error states are kept
  /// so the user always knows why payment is blocked.
  Widget _buildAccountSelector(BuildContext context, String currency, double premium) {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        final cubit = context.read<CreatePolicyCubit>();
        final activeId = GetIt.I<AccountManager>().activeAccountId;

        if (state is! AccountCardsSummaryLoaded) {
          return Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(children: [
              LazerVaultLoader(size: 14),
              SizedBox(width: 10.w),
              Text('Loading account…', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
            ]),
          );
        }

        // Find the active account directly. If it exists and matches
        // the quote currency we use it; otherwise we surface a clear
        // error rather than silently switching accounts.
        final active = state.accountSummaries
            .cast<dynamic>()
            .firstWhere(
              (a) => a.id == activeId,
              orElse: () => null,
            );

        if (active == null) {
          return Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              Icon(Icons.warning_amber, color: const Color(0xFFEF4444), size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(child: Text(
                'No active account selected. Choose one on the dashboard before purchasing.',
                style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFEF4444)),
              )),
            ]),
          );
        }

        // Compare by canonical ISO code so a provider's full currency name
        // (e.g. "NIGERIAN NAIRA") matches an account's ISO code ("NGN").
        final currencyMismatch =
            !CurrencyUtils.sameCurrency(active.currency, currency);

        if (currencyMismatch) {
          return Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              Icon(Icons.warning_amber, color: const Color(0xFFEF4444), size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(child: Text(
                'Your active account is in ${CurrencyUtils.normalizeCode(active.currency)}, but this premium is in '
                '${CurrencyUtils.normalizeCode(currency)}. Switch your active account on the dashboard before purchasing.',
                style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFEF4444)),
              )),
            ]),
          );
        }

        // Push the active account into the cubit so the carousel's
        // case-2 validation (selectedAccountId != null) passes.
        if (cubit.selectedAccountId != active.id) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) cubit.selectAccount(active.id);
          });
        }

        final hasFunds = active.availableBalance >= premium;

        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: hasFunds
                  ? const Color(0xFF2D2D2D)
                  : const Color(0xFFEF4444).withValues(alpha: 0.4),
              width: hasFunds ? 1 : 1.5,
            ),
          ),
          child: Row(children: [
            Container(
              width: 38.w, height: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.account_balance_wallet, color: const Color(0xFF6366F1), size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Flexible(child: Text(
                  (active.accountName?.isNotEmpty ?? false)
                      ? active.accountName!
                      : 'Account ${active.accountNumber ?? active.id.substring(0, 6)}',
                  style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                )),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text('ACTIVE',
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981),
                      letterSpacing: 0.3,
                    )),
                ),
              ]),
              SizedBox(height: 2.h),
              Text(
                'Balance: ${_currencySymbol(currency)}${active.availableBalance.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: hasFunds ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444),
                ),
              ),
              if (!hasFunds) ...[
                SizedBox(height: 2.h),
                Text(
                  'Insufficient balance for this premium.',
                  style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)),
                ),
              ],
            ])),
          ]),
        );
      },
    );
  }

  // Account-change bottom sheet removed: per product decision the
  // Review slide displays the dashboard-active account only. Users
  // change it from the dashboard rather than here.

  /// Terms acceptance — must be checked before the carousel's bottom
  /// "Confirm & Pay" button lets the purchase proceed.
  Widget _buildTermsCheckbox(BuildContext context, InsuranceProduct product, dynamic quote) {
    final cubit = context.read<CreatePolicyCubit>();
    final agreed = cubit.agreedToTerms;
    final showError = _termsValidationError && !agreed;
    final borderColor = showError
        ? const Color(0xFFEF4444)
        : const Color(0xFFFB923C).withValues(alpha: 0.3);
    final tintColor = showError
        ? const Color(0xFFEF4444).withValues(alpha: 0.08)
        : const Color(0xFFFB923C).withValues(alpha: 0.08);
    return Column(
      key: _termsKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: tintColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor, width: showError ? 1.5 : 1),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: 24.w, height: 24.w,
              child: Checkbox(
                value: agreed,
                onChanged: (v) {
                  cubit.setTermsAgreed(v ?? false);
                  setState(() {
                    if (v == true) _termsValidationError = false;
                  });
                },
                activeColor: const Color(0xFF6366F1),
                side: BorderSide(color: const Color(0xFFFB923C).withValues(alpha: 0.5)),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(child: GestureDetector(
              onTap: () => _openTermsBottomSheet(context),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'I agree to the ',
                    style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFFB923C).withValues(alpha: 0.8)),
                  ),
                  TextSpan(
                    text: 'insurance terms and conditions',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp, color: const Color(0xFFFB923C),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFFB923C),
                    ),
                  ),
                  TextSpan(
                    text: '. I will be charged ${_currencySymbol(quote.currency)}${quote.premium.toStringAsFixed(2)} from my selected account.',
                    style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFFB923C).withValues(alpha: 0.8)),
                  ),
                ]),
              ),
            )),
          ]),
        ),
        if (showError)
          Padding(
            padding: EdgeInsets.only(top: 6.h, left: 4.w),
            child: Row(children: [
              Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 14.sp),
              SizedBox(width: 6.w),
              Text(
                'Please accept the terms to continue.',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFFEF4444),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          ),
      ],
    );
  }

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  /// Open the in-app webview bottom sheet that loads the admin-set
  /// terms link. The link is fetched lazily through the cubit so we
  /// always reflect the current admin config.
  void _openTermsBottomSheet(BuildContext context) {
    final cubit = context.read<CreatePolicyCubit>();
    InsuranceTermsBottomSheet.show(
      context,
      urlResolver: cubit.resolveTermsLink,
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
        SizedBox(height: 12.h),
        ...children,
      ]),
    );
  }

  Widget _buildInfoCardWithAction(String title, List<Widget> children, {VoidCallback? onInfo}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(title, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white))),
          if (onInfo != null)
            GestureDetector(
              onTap: onInfo,
              child: Container(
                width: 28.w, height: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                ),
                child: Icon(Icons.info_outline, color: const Color(0xFF6366F1), size: 16.sp),
              ),
            ),
        ]),
        SizedBox(height: 12.h),
        ...children,
      ]),
    );
  }

  void _showProductInfoSheet(BuildContext context, InsuranceProduct product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.35,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r)),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  children: [
                    Row(children: [
                      Container(
                        width: 48.w, height: 48.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r)),
                        child: Icon(product.category.icon, size: 26.sp, color: const Color(0xFF6366F1)),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(product.name, style: GoogleFonts.inter(
                          fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                        SizedBox(height: 2.h),
                        Text(product.providerName, style: GoogleFonts.inter(
                          fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                      ])),
                    ]),
                    SizedBox(height: 16.h),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.premiumRange, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.category.displayName, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF6366F1))),
                      ),
                    ]),
                    SizedBox(height: 20.h),
                    Text('About', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                    SizedBox(height: 8.h),
                    _buildRichContent(product.description, const Color(0xFF9CA3AF)),
                    if (product.howItWorks.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Text('How It Works', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      SizedBox(height: 8.h),
                      _buildRichContent(product.howItWorks, const Color(0xFF9CA3AF)),
                    ],
                    if (product.benefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Text('Benefits', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      SizedBox(height: 8.h),
                      ...product.benefits.map((b) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Icon(Icons.check_circle, size: 16.sp, color: const Color(0xFF10B981)),
                          SizedBox(width: 8.w),
                          Expanded(child: Text(b, style: GoogleFonts.inter(
                            fontSize: 13.sp, color: Colors.white, height: 1.4))),
                        ]),
                      )),
                    ],
                    if (product.fullBenefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Text('Full Coverage Details', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      SizedBox(height: 8.h),
                      _buildRichContent(product.fullBenefits, const Color(0xFF9CA3AF)),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
        Flexible(child: _buildRichContent(value, Colors.white, fontWeight: FontWeight.w500, textAlign: TextAlign.end)),
      ]),
    );
  }

  /// Renders HTML content if it contains tags, otherwise renders plain text
  Widget _buildRichContent(String content, Color color, {FontWeight? fontWeight, TextAlign? textAlign}) {
    if (content.contains('<') && content.contains('>')) {
      return HtmlWidget(
        content,
        textStyle: GoogleFonts.inter(fontSize: 13.sp, color: color, fontWeight: fontWeight),
        customStylesBuilder: (element) {
          // Override all inline colors to match dark theme
          return {'color': _colorToCss(color), 'background-color': 'transparent'};
        },
      );
    }
    return Text(content, textAlign: textAlign,
      style: GoogleFonts.inter(fontSize: 13.sp, color: color, fontWeight: fontWeight));
  }

  String _colorToCss(Color c) =>
      'rgba(${c.red}, ${c.green}, ${c.blue}, ${c.opacity.toStringAsFixed(2)})';
}
