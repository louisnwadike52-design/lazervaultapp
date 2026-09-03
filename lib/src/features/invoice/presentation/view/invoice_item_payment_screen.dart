import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/pending_actions/presentation/cubit/pending_actions_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/tagged_invoice_cubit.dart';
import '../cubit/tagged_invoice_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart'
    show AuthenticationSuccess;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/currency_holdings_service.dart';
import '../widgets/invoice_cross_currency_notice.dart';
import '../widgets/invoice_fx_confirm_sheet.dart';

class InvoiceItemPaymentScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceItemPaymentScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<InvoiceItemPaymentScreen> createState() =>
      _InvoiceItemPaymentScreenState();
}

class _InvoiceItemPaymentScreenState extends State<InvoiceItemPaymentScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String _selectedAccountId = '';
  String _selectedAccountCurrency = '';
  bool _isProcessingPayment = false;

  /// True while the cross-currency pre-checks run (the foreign-holding lookup
  /// and the live rate fetch) before the explainer sheet opens.
  ///
  /// Without it the CTA sits inert through a network round-trip and the sheet
  /// appears from nowhere, so the tap reads as ignored.
  bool _isPreparingFx = false;

  /// The confirmed conversion when the payer's account currency differs from the
  /// invoice currency. Null for a same-currency payment. Set in [_processPayment]
  /// and consumed by the success listener to render both currencies on the receipt.
  InvoiceFxQuote? _fxQuote;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  /// The amount THIS payer owes: for a split (tagged to >1 users) invoice it's
  /// the current user's equal share; otherwise the full invoice total. The
  /// backend charges the same share, so the confirmation/receipt match the debit.
  double get _baseAmount {
    final tagged = widget.invoice.taggedUsers;
    if (tagged == null || tagged.length <= 1) return widget.invoice.totalAmount;
    String? uid;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) uid = authState.profile.userId;
    if (uid == null) return widget.invoice.totalAmount;
    for (final t in tagged) {
      if (t.userId == uid) {
        return t.shareAmount > 0 ? t.shareAmount : widget.invoice.totalAmount;
      }
    }
    return widget.invoice.totalAmount;
  }

  bool get _isSplit => (widget.invoice.taggedUsers?.length ?? 0) > 1;

  // No payer-side processing fee exists on the backend — the old 0.5% row
  // was display-only fiction that inflated the affordability check too.
  double get _totalAmount => _baseAmount;

  String get _currencySymbol => _getCurrencySymbol(widget.invoice.currency);

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20a6';
      case 'GBP':
        return '\u00a3';
      case 'EUR':
        return '\u20ac';
      case 'ZAR':
        return 'R';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'INR':
        return '\u20b9';
      case 'JPY':
        return '\u00a5';
      case 'USD':
        return '\$';
      default:
        return '₦';
    }
  }

  IconData _getAccountIcon(String accountType) {
    final type = accountType.toLowerCase();
    if (type.contains('savings')) return Icons.savings;
    if (type.contains('investment')) return Icons.trending_up;
    if (type.contains('family')) return Icons.family_restroom;
    return Icons.account_balance_wallet;
  }

  Color _getAccountColor(String accountType) {
    final type = accountType.toLowerCase();
    if (type.contains('savings')) return Colors.green;
    if (type.contains('investment')) return Colors.purple;
    if (type.contains('family')) return Colors.orange;
    return Colors.blue;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _fetchAccounts();
  }

  void _fetchAccounts() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: authState.profile.userId,
          );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaggedInvoiceCubit, TaggedInvoiceState>(
      listener: (context, state) {
        if (state is TaggedInvoicePaymentSuccess) {
          setState(() => _isProcessingPayment = false);
          // Refresh dashboard balance
          _fetchAccounts();
          // The invoice (or this user's share of it) is settled — drop it from
          // the dashboard badge and launch prompt straight away.
          refreshPendingActions();
          final fx = _fxQuote;
          Get.offNamed(
            AppRoutes.invoicePaymentReceipt,
            arguments: {
              ...state.transaction,
              // The receipt shows the SHARE actually paid (and total for split
              // invoices), not the backend's full-total amount field. For a
              // cross-currency payment the debit happened in the payer's account
              // currency, so the headline amount/currency reflect the converted
              // value and the invoice's own currency/amount + rate ride along.
              'amount': fx != null ? fx.convertedAmount : _baseAmount,
              'currency': fx != null ? fx.toCurrency : widget.invoice.currency,
              'invoice_type': widget.invoice.type.name,
              if (fx != null) 'invoice_currency': fx.fromCurrency,
              if (fx != null) 'invoice_amount': fx.fromAmount,
              if (fx != null) 'fx_rate': fx.rate,
              if (_isSplit) 'is_split': true,
              if (_isSplit) 'total_amount': widget.invoice.totalAmount,
              // Whether THIS payment settled the invoice in full — drives the
              // receipt's status line (last payer sees "fully paid", not "partial").
              'settled_full':
                  (state.transaction['status']?.toString() ?? '') == 'paid',
              'fromPaymentFlow': true,
            },
          );
        } else if (state is TaggedInvoiceError) {
          setState(() => _isProcessingPayment = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: InvoiceThemeColors.primaryBackground,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInvoiceSummary(),
                        SizedBox(height: 20.h),
                        _buildItemsList(),
                        SizedBox(height: 20.h),
                        _buildAccountSelector(),
                        SizedBox(height: 20.h),
                        _buildPaymentBreakdown(),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay ${widget.invoice.typeDisplayName}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Payment for invoice items',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Secure',
              style: GoogleFonts.inter(
                color: const Color(0xFF10B981),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF3B82F6).withValues(alpha: 0.1),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.invoice.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.invoice.toName != null)
                      Text(
                        'From: ${widget.invoice.toName}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                '$_currencySymbol${_baseAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (widget.invoice.dueDate != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    color: const Color(0xFF9CA3AF), size: 14.sp),
                SizedBox(width: 6.w),
                Text(
                  'Due: ${_formatDate(widget.invoice.dueDate!)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    final items = widget.invoice.items;
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice Items',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: idx < items.length - 1
                      ? Border(
                          bottom: BorderSide(
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${item.quantity.toStringAsFixed(0)} x $_currencySymbol${item.unitPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$_currencySymbol${item.totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pay From',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
          builder: (context, state) {
            List<AccountSummaryEntity> accounts = [];
            if (state is AccountCardsSummaryLoaded) {
              accounts = state.accountSummaries;
            } else if (state is AccountBalanceUpdated) {
              accounts = state.accountSummaries;
            }

            if (state is AccountCardsSummaryLoading) {
              return Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: LazerVaultLoader.tiny(),
                ),
              );
            }

            if (accounts.isEmpty) {
              return Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'No accounts available',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              );
            }

            // ONE wallet — the ACTIVE one. This used to render every account as
            // a chooser, which invited paying an invoice from a wallet the user
            // wasn't otherwise operating in and made the pay screen a second
            // place to switch accounts. The dashboard is where the active
            // account is chosen; this screen states which one will be used.
            //
            // Cross-currency is deliberately NOT removed: if the active wallet
            // is denominated differently from the invoice, the existing FX
            // quote path still runs for THAT wallet. Restricting the list must
            // not become "you can no longer pay this invoice at all".
            final activeId = GetIt.I<AccountManager>().activeAccountId;
            final activeMatch = accounts.where((a) => a.id == activeId);
            final shown = activeMatch.isNotEmpty
                ? [activeMatch.first]
                : <AccountSummaryEntity>[];
            if (shown.isEmpty) {
              return Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'Select an active account on your dashboard to pay from.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              );
            }
            // Preselect it — there is nothing else to choose.
            //
            // The assignment alone was not enough: it happens DURING build, and
            // the Pay button is built earlier in the tree, so on the first frame
            // the button still read an empty _selectedAccountId and rendered
            // disabled. The user had to tap the (already highlighted) account to
            // force a rebuild before they could pay. Schedule a rebuild for the
            // frame after, so the button is live as soon as the account loads.
            if (_selectedAccountId != shown.first.id) {
              _selectedAccountId = shown.first.id;
              _selectedAccountCurrency = shown.first.currency;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() {});
              });
            }

            return Column(
              children: shown.map((account) {
                final isSelected = _selectedAccountId == account.id;
                final sameCurrency = account.currency.toUpperCase() ==
                    widget.invoice.currency.toUpperCase();
                // Same-currency accounts can be affordability-checked up front.
                // For a different-currency account the payable amount is only
                // known after the FX quote, so we keep it selectable and defer
                // the real sufficiency check to the conversion sheet + backend.
                final hasSufficientBalance =
                    !sameCurrency || account.availableBalance >= _totalAmount;

                return GestureDetector(
                  onTap: hasSufficientBalance
                      ? () => setState(() {
                            _selectedAccountId = account.id;
                            _selectedAccountCurrency = account.currency;
                          })
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                          : InvoiceThemeColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.4))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: _getAccountColor(account.accountType)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            _getAccountIcon(account.accountType),
                            color: _getAccountColor(account.accountType),
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${account.accountType} Account',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${_getCurrencySymbol(account.currency)}${account.availableBalance.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: hasSufficientBalance
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFFEF4444),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!hasSufficientBalance)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Insufficient',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFEF4444),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF3B82F6),
                            size: 22.sp,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPaymentBreakdown() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBreakdownRow(
            'Subtotal',
            '$_currencySymbol${widget.invoice.totalAmount.toStringAsFixed(2)}',
          ),
          if (widget.invoice.taxAmount != null &&
              widget.invoice.taxAmount! > 0) ...[
            SizedBox(height: 8.h),
            _buildBreakdownRow(
              'Tax',
              '$_currencySymbol${widget.invoice.taxAmount!.toStringAsFixed(2)}',
              isSubtle: true,
            ),
          ],
          if (widget.invoice.discountAmount != null &&
              widget.invoice.discountAmount! > 0) ...[
            SizedBox(height: 8.h),
            _buildBreakdownRow(
              'Discount',
              '-$_currencySymbol${widget.invoice.discountAmount!.toStringAsFixed(2)}',
              isSubtle: true,
            ),
          ],
          SizedBox(height: 12.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),
          _buildBreakdownRow(
            'Total',
            '$_currencySymbol${_totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value,
      {bool isSubtle = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isSubtle ? const Color(0xFF6B7280) : Colors.white,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: isTotal ? const Color(0xFF3B82F6) : Colors.white,
            fontSize: isTotal ? 20.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: const Color(0xFF3B82F6),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Your payment is secured with end-to-end encryption',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _selectedAccountId.isNotEmpty &&
                      !_isProcessingPayment &&
                      !_isPreparingFx
                  ? _processPayment
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: (_isProcessingPayment || _isPreparingFx)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LazerVaultLoader.small(),
                        SizedBox(width: 12.w),
                        Text(
                          'Processing Payment...',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Pay $_currencySymbol${_totalAmount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// The currently selected account entity (for its currency + balance).
  AccountSummaryEntity? _selectedAccount() {
    final state = context.read<AccountCardsSummaryCubit>().state;
    List<AccountSummaryEntity> accounts = const [];
    if (state is AccountCardsSummaryLoaded) {
      accounts = state.accountSummaries;
    } else if (state is AccountBalanceUpdated) {
      accounts = state.accountSummaries;
    }
    for (final a in accounts) {
      if (a.id == _selectedAccountId) return a;
    }
    return null;
  }

  Future<void> _processPayment() async {
    if (_selectedAccountId.isEmpty) return;

    // Quotes are documents, not payables — bail before FX/PIN instead of
    // failing at the backend guard after the user has done all the work.
    if (widget.invoice.isQuote) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'This is a quote — it becomes payable once the sender converts it to an invoice.'),
        backgroundColor: Colors.orange,
      ));
      return;
    }

    // Re-check affordability AT TAP, not just at render. The card is disabled
    // when the balance is short, but that was decided when the list was last
    // built — a debit elsewhere (another tab, a scheduled transfer, a hold)
    // between then and now would otherwise walk the user through the PIN only
    // to fail at the backend. Same-currency only: for a cross-currency payment
    // the payable amount isn't known until the FX quote below, and the
    // conversion sheet does its own check against the balance.
    final source = _selectedAccount();
    final sameCurrency = source != null &&
        source.currency.toUpperCase() == widget.invoice.currency.toUpperCase();
    if (sameCurrency && source.availableBalance < _totalAmount) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Insufficient balance. You have '
          '${_getCurrencySymbol(source.currency)}'
          '${source.availableBalance.toStringAsFixed(2)} available and this '
          'payment is $_currencySymbol${_totalAmount.toStringAsFixed(2)}.',
        ),
        backgroundColor: Colors.red[700],
      ));
      return;
    }

    HapticFeedback.mediumImpact();

    // Re-quote on every attempt — a stale FX quote must never be reused.
    _fxQuote = null;

    // When the invoice currency differs from the payer's account currency,
    // confirm the live conversion BEFORE the PIN. The payer's account is then
    // debited (and the biller credited) the converted amount in the account's
    // own currency; the backend independently re-resolves the rate at
    // settlement, so this quote is for informed consent + receipt display.
    final invoiceCurrency = widget.invoice.currency;
    final payCurrency = _selectedAccountCurrency;
    double pinAmount = _baseAmount;
    String pinCurrency = invoiceCurrency;
    if (payCurrency.isNotEmpty &&
        payCurrency.toUpperCase() != invoiceCurrency.toUpperCase()) {
      final account = _selectedAccount();

      // Explain the conversion BEFORE quoting a rate. Meeting an FX sheet with
      // no lead-in reads like the app picked the wrong wallet. The holding
      // lookup needs includeAllCurrencies: the account list this screen shows
      // is locale-currency only, so it cannot see a foreign wallet at all.
      //
      // The lookup is a network call, so the CTA shows a spinner for its
      // duration. `finally` clears it on EVERY exit — an early return or a
      // throw that left the button spinning would strand the user on a screen
      // they cannot act on.
      double? holding;
      setState(() => _isPreparingFx = true);
      try {
        holding =
            await CurrencyHoldingsService.largestActiveBalance(invoiceCurrency);
      } finally {
        if (mounted) setState(() => _isPreparingFx = false);
      }
      if (!mounted) return;

      final proceed = await InvoiceCrossCurrencyNotice.show(
        context,
        invoiceCurrency: invoiceCurrency,
        payCurrency: payCurrency,
        invoiceAmount: _baseAmount,
        holdingInInvoiceCurrency: holding,
      );
      // Covers the swipe-to-dismiss case too: show() resolves false when the
      // sheet is dragged away rather than confirmed.
      if (!mounted) return;
      if (!proceed) return;

      final quote = await InvoiceFxConfirmSheet.show(
        context,
        fromCurrency: invoiceCurrency,
        toCurrency: payCurrency,
        fromAmount: _baseAmount,
        availableBalance: account?.availableBalance ?? 0,
      );
      if (!mounted) return;
      // Null covers all three no-go paths: cancelled, swiped away, or the rate
      // could not be fetched. None of them may fall through to the PIN.
      if (quote == null) return;
      _fxQuote = quote;
      pinAmount = quote.convertedAmount;
      pinCurrency = quote.toCurrency;
    }
    if (!mounted) return;

    final idPrefix = widget.invoice.id.length >= 8
        ? widget.invoice.id.substring(0, 8)
        : widget.invoice.id;
    final transactionId = 'INV-PAY-$idPrefix';
    final idempotencyKey = const Uuid().v4();

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'invoice_item_payment',
      amount: pinAmount,
      currency: pinCurrency,
      title: 'Confirm Payment',
      message:
          'Confirm invoice payment of $pinCurrency ${pinAmount.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;

    if (_selectedAccountId.isNotEmpty) {
      GetIt.I<AccountManager>().setActiveAccount(_selectedAccountId);
    }

    // PIN consumed — the payment must fire even if this screen is gone, so
    // the cubit must not be read from a possibly-deactivated context.
    if (!mounted) return;
    setState(() => _isProcessingPayment = true);

    await context.read<TaggedInvoiceCubit>().payInvoice(
          widget.invoice.id,
          _selectedAccountId,
          pin: '',
          verificationToken: verificationToken!,
          transactionId: transactionId,
          idempotencyKey: idempotencyKey,
        );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
