import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class TagPaymentConfirmationScreen extends StatefulWidget {
  final UserTagEntity tag;

  const TagPaymentConfirmationScreen({
    super.key,
    required this.tag,
  });

  @override
  State<TagPaymentConfirmationScreen> createState() =>
      _TagPaymentConfirmationScreenState();
}

class _TagPaymentConfirmationScreenState
    extends State<TagPaymentConfirmationScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String? _selectedAccountId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Ensure accounts are loaded (may not be if navigated directly)
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: 'current_user',
      );
    }
  }

  void _processPayment() async {
    if (_selectedAccountId == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select an account to pay from',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate account has sufficient balance (safety check)
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries.firstWhere(
        (a) => a.id.toString() == _selectedAccountId,
        orElse: () => throw Exception('Account not found'),
      );

      if (selectedAccount.currency.toUpperCase() != widget.tag.currency.toUpperCase()) {
        Get.snackbar(
          'Currency Mismatch',
          'Please select a ${widget.tag.currency} account',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (selectedAccount.balance < widget.tag.amount) {
        Get.snackbar(
          'Insufficient Balance',
          'Your account balance (${selectedAccount.currency} ${selectedAccount.balance.toStringAsFixed(2)}) is less than the payment amount (${widget.tag.formattedAmount})',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return;
      }
    }

    HapticFeedback.mediumImpact();

    final idPrefix = widget.tag.id.length >= 8
        ? widget.tag.id.substring(0, 8)
        : widget.tag.id;
    final transactionId = 'TAG-PAY-$idPrefix';

    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'tag_payment',
      amount: widget.tag.amount,
      currency: widget.tag.currency,
    );

    if (pinResult == null || !pinResult.success) return;

    setState(() {
      _isProcessing = true;
    });

    if (!mounted) return;
    context.read<TagPayCubit>().payTag(
          tagId: widget.tag.id,
          sourceAccountId: _selectedAccountId!,
          transactionPin: pinResult.verificationToken ?? '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is TagPaidSuccess) {
            setState(() {
              _isProcessing = false;
            });
            Get.offAllNamed(
              AppRoutes.tagPaymentReceipt,
              arguments: {
                'transaction': state.transaction,
                'tag': widget.tag,
              },
            );
          } else if (state is TagPayError) {
            setState(() {
              _isProcessing = false;
            });
            Get.snackbar(
              'Payment Failed',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 4),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 32.h),
                _buildPaymentDetails(),
                SizedBox(height: 24.h),
                _buildAccountSelector(),
                SizedBox(height: 32.h),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
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
                'Confirm Payment',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Review and confirm your payment',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'You\'re Paying',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.tag.formattedAmount,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Divider(color: const Color(0xFF2D2D2D), thickness: 1),
          SizedBox(height: 24.h),
          _buildDetailRow('To', widget.tag.taggerName.isNotEmpty ? widget.tag.taggerName : 'Unknown'),
          SizedBox(height: 16.h),
          if (widget.tag.taggerTagPay.isNotEmpty)
            _buildDetailRow('Tag', '@${widget.tag.taggerTagPay}'),
          if (widget.tag.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', widget.tag.description),
          ],
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Date',
            '${widget.tag.createdAt.day}/${widget.tag.createdAt.month}/${widget.tag.createdAt.year}',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Check if an account has sufficient balance for the tag payment
  bool _hasSufficientBalance(dynamic account) {
    // Only accounts with matching currency can pay
    if (account.currency.toUpperCase() != widget.tag.currency.toUpperCase()) {
      return false;
    }
    // Check if balance is sufficient
    return account.balance >= widget.tag.amount;
  }

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          // Filter to only show accounts with matching currency
          final matchingCurrencyAccounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == widget.tag.currency.toUpperCase())
              .toList();

          final otherCurrencyAccounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() != widget.tag.currency.toUpperCase())
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Only ${widget.tag.currency} accounts with sufficient balance can be used',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.h),

              // Show matching currency accounts first
              ...matchingCurrencyAccounts.map((account) {
                final isSelected = _selectedAccountId == account.id.toString();
                final hasSufficientBalance = _hasSufficientBalance(account);

                return GestureDetector(
                  onTap: hasSufficientBalance
                      ? () {
                          setState(() {
                            _selectedAccountId = account.id.toString();
                          });
                        }
                      : () {
                          // Show insufficient balance message
                          Get.snackbar(
                            'Insufficient Balance',
                            'This account does not have enough funds. You need ${widget.tag.currency} ${widget.tag.amount.toStringAsFixed(2)}',
                            backgroundColor: const Color(0xFFFB923C),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: !hasSufficientBalance
                          ? const Color(0xFF1F1F1F).withValues(alpha: 0.5)
                          : isSelected
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                              : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: !hasSufficientBalance
                            ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                            : isSelected
                                ? const Color(0xFF3B82F6)
                                : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                                : const Color(0xFF3B82F6).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF3B82F6),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      account.accountType,
                                      style: GoogleFonts.inter(
                                        color: !hasSufficientBalance
                                            ? Colors.white.withValues(alpha: 0.5)
                                            : Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (!hasSufficientBalance)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4.r),
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
                                ],
                              ),
                              Text(
                                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: !hasSufficientBalance
                                      ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                                      : const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected && hasSufficientBalance)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF3B82F6),
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                );
              }),

              // Show other currency accounts as disabled
              if (otherCurrencyAccounts.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  'Other Currencies (not available for this payment)',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                ...otherCurrencyAccounts.map((account) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F).withValues(alpha: 0.3),
                      border: Border.all(
                        color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
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
                                  color: Colors.white.withValues(alpha: 0.4),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Wrong Currency',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor: const Color(0xFF10B981).withValues(alpha: 0.5),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Pay ${widget.tag.formattedAmount}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
