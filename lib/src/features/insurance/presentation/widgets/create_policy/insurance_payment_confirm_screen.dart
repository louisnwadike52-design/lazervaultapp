import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_state.dart';

/// Screen 4: Confirm payment - active account selector with bottom sheet to change, amount display, confirm button
class InsurancePaymentConfirmScreen extends StatefulWidget {
  const InsurancePaymentConfirmScreen({super.key});

  @override
  State<InsurancePaymentConfirmScreen> createState() => _InsurancePaymentConfirmScreenState();
}

class _InsurancePaymentConfirmScreenState extends State<InsurancePaymentConfirmScreen> {
  String? _selectedAccountId;
  AccountManager? _accountManager;

  @override
  void initState() {
    super.initState();
    _accountManager = GetIt.I<AccountManager>();
    // Pre-select active account if available
    _selectedAccountId = _accountManager?.activeAccountId;
  }

  /// Convert currency name/code to symbol
  String _currencySymbol(String currency) {
    final c = currency.toLowerCase().trim();
    if (c == 'ngn' || c.contains('naira')) return '\u20A6';
    if (c == 'usd' || c.contains('dollar')) return '\$';
    if (c == 'gbp' || c.contains('pound')) return '\u00A3';
    if (c == 'eur' || c.contains('euro')) return '\u20AC';
    if (c == 'ghs' || c.contains('cedi')) return '\u20B5';
    if (c == 'kes' || c.contains('shilling')) return 'KSh';
    if (c == 'zar' || c.contains('rand')) return 'R';
    return currency; // fallback to raw value
  }

  /// Strip HTML tags for plain text fallback
  bool _containsHtml(String text) {
    return text.contains('<') && text.contains('>');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePolicyCubit, CreatePolicyState>(
      builder: (context, state) {
        if (state is! InsuranceQuoteLoaded) {
          return Center(child: Text('Quote not loaded',
            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))));
        }

        final quote = state.quote;
        final product = state.product;
        final formatter = NumberFormat('#,##0.00');

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 8.h),
            Text('Confirm Payment', style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            SizedBox(height: 4.h),
            Text('Review and confirm your insurance purchase',
              style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
            SizedBox(height: 24.h),

            // Account selector — use active locale currency (from dashboard),
            // falling back to quote currency if locale not available
            _buildAccountSelector(
              context.read<CreatePolicyCubit>().activeCurrency.isNotEmpty
                  ? context.read<CreatePolicyCubit>().activeCurrency
                  : quote.currency,
              quote.premium,
            ),
            SizedBox(height: 16.h),

            // Payment summary card with info button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text('Payment Summary', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white))),
                  GestureDetector(
                    onTap: () => _showProductInfoSheet(context, product),
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
                SizedBox(height: 16.h),
                _buildSummaryRow('Product', product.name),
                _buildSummaryRow('Provider', product.providerName),
                _buildSummaryRow('Category', product.category.displayName),
                Divider(color: const Color(0xFF2D2D2D), height: 24.h),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Total Premium', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  Text('${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                    style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF10B981))),
                ]),
              ]),
            ),
            SizedBox(height: 16.h),

            // Coverage highlights
            if (quote.coverageItems.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Coverage Highlights', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                  SizedBox(height: 12.h),
                  ...quote.coverageItems.take(5).map((item) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(Icons.shield, color: const Color(0xFF6366F1), size: 16.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: _containsHtml(item)
                          ? HtmlWidget(item,
                              textStyle: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white),
                              customStylesBuilder: (_) => {'color': 'rgba(255,255,255,0.9)', 'background-color': 'transparent'})
                          : Text(item, style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white)),
                      ),
                    ]),
                  )),
                ]),
              ),
              SizedBox(height: 16.h),
            ],

            // Terms acceptance checkbox
            Builder(
              builder: (context) {
                final cubit = context.read<CreatePolicyCubit>();
                final agreed = cubit.agreedToTerms;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
                  ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: Checkbox(
                        value: agreed,
                        onChanged: (v) {
                          cubit.setTermsAgreed(v ?? false);
                          setState(() {}); // Refresh local UI
                        },
                        activeColor: const Color(0xFF6366F1),
                        side: BorderSide(color: const Color(0xFFFB923C).withValues(alpha: 0.5)),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.insuranceTerms, arguments: product),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree to the ',
                              style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFFB923C).withValues(alpha: 0.8)),
                            ),
                            TextSpan(
                              text: 'insurance terms and conditions',
                              style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFFB923C), fontWeight: FontWeight.w600, decoration: TextDecoration.underline, decorationColor: const Color(0xFFFB923C)),
                            ),
                            TextSpan(
                              text: '. I will be charged ${_currencySymbol(quote.currency)}${formatter.format(quote.premium)} from my selected account.',
                              style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFFB923C).withValues(alpha: 0.8)),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ]),
                );
              },
            ),
            SizedBox(height: 12.h),

            // Account selection / terms validation hint
            Builder(
              builder: (context) {
                final cubit = context.read<CreatePolicyCubit>();
                final canProceed = _selectedAccountId != null && cubit.agreedToTerms;
                if (canProceed) return const SizedBox.shrink();
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(children: [
                    Icon(Icons.info_outline, color: const Color(0xFF9CA3AF), size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(child: Text(
                      _selectedAccountId == null
                          ? 'Select an account to continue'
                          : 'Accept the terms to continue',
                      style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
                    )),
                  ]),
                );
              },
            ),
            SizedBox(height: 20.h),
          ]),
        );
      },
    );
  }

  Widget _buildAccountSelector(String currency, double premium) {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1))),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final accounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
              .toList();

          if (accounts.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                Icon(Icons.warning_amber, color: const Color(0xFFEF4444), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(child: Text(
                  'No $currency accounts available',
                  style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444)),
                )),
              ]),
            );
          }

          // Use active account as default if none selected
          if (_selectedAccountId == null) {
            final activeAccount = accounts.firstWhere(
              (a) => a.id.toString() == _accountManager?.activeAccountId,
              orElse: () => accounts.first,
            );
            _selectedAccountId = activeAccount.id.toString();
            context.read<CreatePolicyCubit>().selectAccount(_selectedAccountId!);
          }

          final selectedAccount = accounts.firstWhereOrNull(
            (a) => a.id.toString() == _selectedAccountId,
          );

          if (selectedAccount == null) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                Icon(Icons.info_outline, color: const Color(0xFFFB923C), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(child: Text(
                  'Please select an account',
                  style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFFB923C)),
                )),
              ]),
            );
          }

          final formatter = NumberFormat('#,##0.00');
          final hasSufficientBalance = selectedAccount.balance >= premium;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment Account', style: GoogleFonts.inter(
                fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
              SizedBox(height: 4.h),
              Text('Account to be charged', style: GoogleFonts.inter(
                fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 12.h),
              // Compact selected account card - tap to change
              GestureDetector(
                onTap: () => _showAccountSelectorBottomSheet(
                  context,
                  accounts: accounts,
                  currency: currency,
                  premium: premium,
                ),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: hasSufficientBalance
                          ? const Color(0xFF2D2D2D)
                          : const Color(0xFFEF4444).withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Row(children: [
                    Container(
                      width: 44.w, height: 44.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hasSufficientBalance
                            ? const Color(0xFF6366F1).withValues(alpha: 0.15)
                            : const Color(0xFFEF4444).withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: hasSufficientBalance ? const Color(0xFF6366F1) : const Color(0xFFEF4444),
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedAccount.accountName ?? selectedAccount.accountType,
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(children: [
                          Text(
                            '${selectedAccount.currency} ${formatter.format(selectedAccount.balance)}',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: hasSufficientBalance
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (!hasSufficientBalance) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text('Insufficient',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  color: const Color(0xFFEF4444),
                                  fontWeight: FontWeight.w600,
                                )),
                            ),
                          ],
                        ]),
                      ],
                    )),
                    Icon(Icons.keyboard_arrow_up, color: const Color(0xFF9CA3AF), size: 24.sp),
                  ]),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Bottom sheet to select from available accounts
  void _showAccountSelectorBottomSheet(
    BuildContext context, {
    required List<dynamic> accounts,
    required String currency,
    required double premium,
  }) {
    final formatter = NumberFormat('#,##0.00');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.account_balance_wallet,
                      color: const Color(0xFF6366F1), size: 24.sp),
                    SizedBox(width: 12.w),
                    Text('Select Account', style: GoogleFonts.inter(
                      fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp),
                    ),
                  ]),
                  SizedBox(height: 8.h),
                  Text('Choose an account to pay the premium',
                    style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                  SizedBox(height: 16.h),
                  Divider(color: const Color(0xFF2D2D2D)),
                  SizedBox(height: 8.h),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 350.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: accounts.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, index) {
                        final account = accounts[index];
                        final isSelected = _selectedAccountId == account.id.toString();
                        final balance = account.balance;
                        final hasSufficientBalance = balance >= premium;

                        return GestureDetector(
                          onTap: hasSufficientBalance ? () {
                            setState(() => _selectedAccountId = account.id.toString());
                            context.read<CreatePolicyCubit>().selectAccount(account.id.toString());
                            Navigator.pop(context);
                          } : null,
                          child: Container(
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: !hasSufficientBalance
                                  ? const Color(0xFF1F1F1F).withValues(alpha: 0.5)
                                  : isSelected
                                      ? const Color(0xFF6366F1).withValues(alpha: 0.12)
                                      : Colors.white.withValues(alpha: 0.03),
                              border: Border.all(
                                color: !hasSufficientBalance
                                    ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                                    : isSelected
                                        ? const Color(0xFF6366F1)
                                        : const Color(0xFF2D2D2D),
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(children: [
                              Container(
                                width: 40.w, height: 40.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                                      : Colors.white.withValues(alpha: 0.06),
                                ),
                                child: Icon(Icons.account_balance_wallet,
                                  color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF9CA3AF),
                                  size: 20.sp),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(account.accountName ?? account.accountType,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: hasSufficientBalance ? Colors.white : const Color(0xFF9CA3AF)),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text('${account.currency} ${formatter.format(balance)}',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      color: hasSufficientBalance
                                          ? const Color(0xFF10B981)
                                          : const Color(0xFFEF4444))),
                                ],
                              )),
                              if (isSelected)
                                Icon(Icons.check_circle, color: const Color(0xFF6366F1), size: 22.sp)
                              else if (!hasSufficientBalance)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text('Insufficient',
                                    style: GoogleFonts.inter(
                                      fontSize: 10.sp,
                                      color: const Color(0xFFEF4444),
                                      fontWeight: FontWeight.w600,
                                    )),
                                )
                              else
                                Icon(Icons.radio_button_unchecked,
                                  color: const Color(0xFF4B5563), size: 20.sp),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
        Flexible(child: Text(value, textAlign: TextAlign.end,
          style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.white))),
      ]),
    );
  }

  void _showAccountInfoSheet(
    BuildContext context, {
    required String accountName,
    required String currency,
    required double balance,
    required double premium,
  }) {
    final formatter = NumberFormat('#,##0.00');
    final remaining = balance - premium;
    final hasSufficient = remaining >= 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r)),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 48.w, height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                      ),
                      child: Icon(Icons.account_balance_wallet, size: 24.sp, color: const Color(0xFF6366F1)),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(accountName, style: GoogleFonts.inter(
                        fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      SizedBox(height: 2.h),
                      Text('$currency Account', style: GoogleFonts.inter(
                        fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                    ])),
                  ]),
                  SizedBox(height: 20.h),
                  _buildInfoRow('Available Balance', '$currency ${formatter.format(balance)}',
                    valueColor: const Color(0xFF10B981)),
                  _buildInfoRow('Insurance Premium', '$currency ${formatter.format(premium)}',
                    valueColor: const Color(0xFFFB923C)),
                  Divider(color: const Color(0xFF2D2D2D), height: 20.h),
                  _buildInfoRow('Balance After Payment',
                    hasSufficient ? '$currency ${formatter.format(remaining)}' : 'Insufficient funds',
                    valueColor: hasSufficient ? Colors.white : const Color(0xFFEF4444),
                    isBold: true),
                  if (!hasSufficient) ...[
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8.r)),
                      child: Row(children: [
                        Icon(Icons.warning_amber, size: 16.sp, color: const Color(0xFFEF4444)),
                        SizedBox(width: 8.w),
                        Expanded(child: Text(
                          'You need $currency ${formatter.format(premium - balance)} more to complete this purchase.',
                          style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFEF4444)),
                        )),
                      ]),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
        Text(value, style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          color: valueColor ?? Colors.white)),
      ]),
    );
  }

  void _showProductInfoSheet(BuildContext context, InsuranceProduct product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.55,
        maxChildSize: 0.85,
        minChildSize: 0.3,
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
                    if (product.description.isNotEmpty) ...[
                      Text('About', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      SizedBox(height: 8.h),
                      Text(product.description, style: GoogleFonts.inter(
                        fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5)),
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
}
