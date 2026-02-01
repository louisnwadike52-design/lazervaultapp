import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
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
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart'
    show AuthenticationSuccess;
import 'package:lazervault/core/services/account_manager.dart';

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
  bool _isProcessingPayment = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  double get _processingFee => widget.invoice.totalAmount * 0.005;
  double get _totalAmount => widget.invoice.totalAmount + _processingFee;

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
          Get.offNamed(
            AppRoutes.invoicePaymentReceipt,
            arguments: {...state.transaction, 'fromPaymentFlow': true},
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
                  'Pay Invoice',
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
            const Color(0xFF8B5CF6).withValues(alpha: 0.1),
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
                '$_currencySymbol${widget.invoice.totalAmount.toStringAsFixed(2)}',
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
                  child: CircularProgressIndicator(
                    color: const Color(0xFF3B82F6),
                    strokeWidth: 2,
                  ),
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

            return Column(
              children: accounts.map((account) {
                final isSelected = _selectedAccountId == account.id;
                final hasSufficientBalance = account.balance >= _totalAmount;

                return GestureDetector(
                  onTap: hasSufficientBalance
                      ? () => setState(() => _selectedAccountId = account.id)
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
                                '$_currencySymbol${account.balance.toStringAsFixed(2)}',
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
                              color:
                                  const Color(0xFFEF4444).withValues(alpha: 0.2),
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
          SizedBox(height: 8.h),
          _buildBreakdownRow(
            'Processing Fee (0.5%)',
            '$_currencySymbol${_processingFee.toStringAsFixed(2)}',
            isSubtle: true,
          ),
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
              onPressed: _selectedAccountId.isNotEmpty && !_isProcessingPayment
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
              child: _isProcessingPayment
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
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

  Future<void> _processPayment() async {
    if (_selectedAccountId.isEmpty) return;

    HapticFeedback.mediumImpact();

    final idPrefix = widget.invoice.id.length >= 8
        ? widget.invoice.id.substring(0, 8)
        : widget.invoice.id;
    final transactionId = 'INV-PAY-$idPrefix';
    final idempotencyKey = const Uuid().v4();

    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'invoice_item_payment',
      amount: _totalAmount,
      currency: widget.invoice.currency,
    );

    if (pinResult == null || !pinResult.success) return;

    if (_selectedAccountId.isNotEmpty) {
      GetIt.I<AccountManager>().setActiveAccount(_selectedAccountId);
    }

    setState(() => _isProcessingPayment = true);

    await context.read<TaggedInvoiceCubit>().payInvoice(
          widget.invoice.id,
          _selectedAccountId,
          pin: '',
          verificationToken: pinResult.verificationToken ?? '',
          transactionId: transactionId,
          idempotencyKey: idempotencyKey,
        );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
