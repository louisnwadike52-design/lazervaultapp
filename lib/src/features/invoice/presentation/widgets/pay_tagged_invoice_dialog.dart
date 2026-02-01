import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/types/app_routes.dart';

class PayTaggedInvoiceDialog extends StatefulWidget {
  final TaggedInvoice invoice;

  const PayTaggedInvoiceDialog({
    super.key,
    required this.invoice,
  });

  @override
  State<PayTaggedInvoiceDialog> createState() => _PayTaggedInvoiceDialogState();
}

class _PayTaggedInvoiceDialogState extends State<PayTaggedInvoiceDialog>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String? _selectedAccountId;
  bool _isProcessing = false;

  double get _processingFee => widget.invoice.amount * 0.005; // 0.5% fee
  double get _totalAmount => widget.invoice.amount + _processingFee;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaggedInvoiceCubit, TaggedInvoiceState>(
      listener: (context, state) {
        if (state is TaggedInvoicePaymentSuccess) {
          // Refresh dashboard balance
          final authState = context.read<AuthenticationCubit>().state;
          if (authState is AuthenticationSuccess) {
            context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: authState.profile.userId,
            );
          }
          Get.back(); // Close dialog
          Get.toNamed(
            AppRoutes.invoicePaymentReceipt,
            arguments: {...state.transaction, 'fromPaymentFlow': true},
          );
        } else if (state is TaggedInvoiceError) {
          setState(() => _isProcessing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxHeight: 600.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildInvoiceSummary(),
                      _buildDivider(),
                      _buildAccountSelector(),
                      _buildDivider(),
                      _buildPaymentSummary(),
                    ],
                  ),
                ),
              ),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.payment,
              color: const Color(0xFF3B82F6),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay Invoice Items',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Pay invoice creator for items',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.close,
              color: const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummary() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE DETAILS',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.invoice.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'From: ${widget.invoice.displayName}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.invoice.formattedAmount,
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SELECT ACCOUNT',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12.h),
          BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
            builder: (context, state) {
              if (state is AccountCardsSummaryLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF3B82F6),
                    ),
                  ),
                );
              }

              if (state is AccountCardsSummaryLoaded) {
                if (state.accountSummaries.isEmpty) {
                  return _buildNoAccountsState();
                }

                return Column(
                  children: state.accountSummaries.map((account) {
                    final hasSufficientBalance =
                        account.balance >= _totalAmount;
                    final isSelected = _selectedAccountId == account.id;

                    return GestureDetector(
                      onTap: hasSufficientBalance
                          ? () {
                              setState(() {
                                _selectedAccountId = account.id;
                              });
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                              : const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF374151),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF374151),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.accountType,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Balance: ${account.currency} ${account.balance.toStringAsFixed(2)}',
                                    style: GoogleFonts.inter(
                                      color: hasSufficientBalance
                                          ? const Color(0xFF10B981)
                                          : const Color(0xFFEF4444),
                                      fontSize: 12.sp,
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
                                size: 24.sp,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoAccountsState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 48.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 12.h),
          Text(
            'No accounts available',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAYMENT SUMMARY',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow('Invoice Amount', widget.invoice.formattedAmount),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Processing Fee (0.5%)',
            '${widget.invoice.currency} ${_processingFee.toStringAsFixed(2)}',
            isSubtle: true,
          ),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF374151)),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            'Total',
            '${widget.invoice.currency} ${_totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
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

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color(0xFF374151),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isProcessing ? null : () => Get.back(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF374151)),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _selectedAccountId != null && !_isProcessing
                  ? _processPayment
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                disabledBackgroundColor: const Color(0xFF374151),
              ),
              child: _isProcessing
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Pay Now',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: const Color(0xFF374151),
      height: 1,
      thickness: 1,
    );
  }

  Future<void> _processPayment() async {
    if (_selectedAccountId == null) return;

    HapticFeedback.mediumImpact();

    // Generate transaction ID and idempotency key
    final idPrefix = widget.invoice.invoiceId.length >= 8
        ? widget.invoice.invoiceId.substring(0, 8)
        : widget.invoice.invoiceId;
    final transactionId = 'INV-PAY-$idPrefix';
    final idempotencyKey = const Uuid().v4();

    // Validate PIN via TransactionPinMixin
    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'invoice_item_payment',
      amount: _totalAmount,
      currency: widget.invoice.currency,
    );

    if (pinResult == null || !pinResult.success) return;

    setState(() {
      _isProcessing = true;
    });

    // Call cubit with all security params
    await context.read<TaggedInvoiceCubit>().payInvoice(
          widget.invoice.invoiceId,
          _selectedAccountId!,
          pin: '',
          verificationToken: pinResult.verificationToken ?? '',
          transactionId: transactionId,
          idempotencyKey: idempotencyKey,
        );
  }
}
