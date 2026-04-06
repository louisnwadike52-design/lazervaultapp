import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';

/// Screen 3: Review quote details - premium, coverage breakdown, provider info
class InsuranceQuoteReviewScreen extends StatefulWidget {
  const InsuranceQuoteReviewScreen({super.key});

  @override
  State<InsuranceQuoteReviewScreen> createState() =>
      _InsuranceQuoteReviewScreenState();
}

class _InsuranceQuoteReviewScreenState extends State<InsuranceQuoteReviewScreen>
    with TransactionPinMixin {
  Timer? _countdownTimer;
  Duration _remaining = Duration.zero;

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
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
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
              const CircularProgressIndicator(color: Color(0xFF6366F1)),
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

            // Coverage summary
            if (quote.coverageSummary.isNotEmpty || quote.coverageItems.isNotEmpty)
              _buildInfoCard('Coverage', [
                if (quote.coverageSummary.isNotEmpty)
                  Padding(padding: EdgeInsets.only(bottom: 8.h),
                    child: _buildRichContent(quote.coverageSummary, const Color(0xFF9CA3AF))),
                ...quote.coverageItems.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(child: _buildRichContent(item, Colors.white)),
                  ]),
                )),
              ]),

            // View Terms link
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.insuranceTerms, arguments: product),
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

        // Continue to Payment button (only show when quote is valid)
        if (!isExpired)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0A0A0A).withValues(alpha: 0.9),
                    const Color(0xFF0A0A0A),
                  ],
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _proceedToPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    disabledBackgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.5),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Continue to Payment',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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

  Future<void> _proceedToPayment() async {
    final cubit = context.read<CreatePolicyCubit>();
    final state = cubit.state;

    if (state is! InsuranceQuoteLoaded) return;

    final quote = state.quote;
    final product = state.product;

    // Then show PIN modal and validate
    final success = await validateTransactionPin(
      context: context,
      transactionId: quote.quoteId,
      transactionType: 'insurance_purchase',
      amount: quote.premium,
      currency: quote.currency,
      onPinValidated: (verificationToken) async {
        // Call purchase with the verification token
        await cubit.purchaseInsurance(
          accountId: cubit.selectedAccountId ?? '',
          transactionPin: verificationToken, // This is now the token, not raw PIN
          transactionId: quote.quoteId,
        );
      },
      title: 'Confirm Insurance Purchase',
      message: 'Purchase ${product.name} from ${product.providerName}?',
      currencySymbol: _currencySymbol(quote.currency),
    );

    if (!success && mounted) {
      // PIN validation failed or was cancelled
      // Stay on the quote review screen
    }
  }

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

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
