import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import '../cubit/ai_scan_state.dart';

/// Unified confirm screen for every AI Scan-to-Pay target. Shows the
/// beneficiary header, an amount field (read-only for fixed-amount targets),
/// a source-account selector with currency + balance validation, an optional
/// note, and a Pay button. PIN is validated via [TransactionPinMixin] and the
/// resulting verification token is handed to [AiScanCubit.pay].
class AiScanConfirmScreen extends StatefulWidget {
  final ScanPaymentIntent intent;

  const AiScanConfirmScreen({super.key, required this.intent});

  @override
  State<AiScanConfirmScreen> createState() => _AiScanConfirmScreenState();
}

class _AiScanConfirmScreenState extends State<AiScanConfirmScreen>
    with TransactionPinMixin<AiScanConfirmScreen> {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  // Editable bank-detail fields (low-confidence review sub-case).
  late final TextEditingController _accountNumberController;
  late final TextEditingController _bankNameController;

  String? _selectedAccountId;
  bool _isProcessing = false;

  late ScanPaymentIntent _intent;

  bool get _amountEditable => _intent.amountEditable;
  bool get _requiresBankReview =>
      _intent.type == ScanIntentType.bankDetails &&
      (_intent.bankDetails?.requiresReview ?? false);

  @override
  void initState() {
    super.initState();
    _intent = widget.intent;
    if (_intent.amount != null && _intent.amount! > 0) {
      _amountController.text = _intent.amount!.toStringAsFixed(2);
    }
    if (_intent.description != null) {
      _noteController.text = _intent.description!;
    }
    _accountNumberController =
        TextEditingController(text: _intent.bankDetails?.accountNumber ?? '');
    _bankNameController =
        TextEditingController(text: _intent.bankDetails?.bankName ?? '');

    // Load accounts if not already loaded.
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context
          .read<AccountCardsSummaryCubit>()
          .fetchAccountSummaries(userId: userId);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  String _transactionType() {
    switch (_intent.type) {
      case ScanIntentType.bankDetails:
        return 'BANK_DETAILS_PAYMENT';
      case ScanIntentType.qrPay:
        return 'qr_payment';
      case ScanIntentType.invoice:
        return 'invoice';
      case ScanIntentType.recipient:
        return 'c2c';
      case ScanIntentType.unknown:
        return 'c2c';
    }
  }

  Future<void> _onPay() async {
    if (_selectedAccountId == null) {
      _snack('Please select an account to pay from');
      return;
    }

    final amount = _amountEditable
        ? (double.tryParse(_amountController.text.trim()) ?? 0)
        : (_intent.amount ?? 0);

    if (amount <= 0) {
      _snack('Please enter a valid amount');
      return;
    }

    final currency = _intent.currency.toUpperCase();

    // Currency + balance validation against the selected account.
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selected = accountState.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .toList();
      if (selected.isNotEmpty) {
        final acct = selected.first;
        if (acct.currency.toUpperCase() != currency) {
          _snack('Please select a $currency account');
          return;
        }
        if (acct.availableBalance < amount) {
          _snack(
              'Insufficient balance (${acct.currency} ${acct.availableBalance.toStringAsFixed(2)})');
          return;
        }
      }
    }

    // Apply edited bank-detail fields (low-confidence review).
    if (_requiresBankReview && _intent.bankDetails != null) {
      final edited = _intent.bankDetails!.copyWith(
        accountNumber: _accountNumberController.text.trim(),
        bankName: _bankNameController.text.trim(),
      );
      _intent = ScanPaymentIntent(
        type: _intent.type,
        title: _intent.title,
        subtitle: _intent.subtitle,
        amount: _intent.amount,
        currency: _intent.currency,
        amountEditable: _intent.amountEditable,
        description: _intent.description,
        bankDetails: edited,
        username: _intent.username,
        userId: _intent.userId,
        accountNumber: edited.accountNumber,
        bankName: edited.bankName,
        bankCode: edited.bankCode,
        qrCode: _intent.qrCode,
        invoiceId: _intent.invoiceId,
        raw: _intent.raw,
      );
    }

    HapticFeedback.mediumImpact();

    final note = _noteController.text.trim();
    final transactionId =
        '${_transactionType()}-${DateTime.now().millisecondsSinceEpoch}';

    String? verificationToken;
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: _transactionType(),
      amount: amount,
      currency: currency,
      title: 'Confirm Payment',
      message: 'Confirm payment of $currency ${amount.toStringAsFixed(2)}',
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;
    if (!mounted) return;

    setState(() => _isProcessing = true);
    context.read<AiScanCubit>().pay(
          intent: _intent,
          verificationToken: verificationToken!,
          sourceAccountId: _selectedAccountId!,
          amount: amount,
          description: note.isEmpty ? null : note,
        );
  }

  void _snack(String message) {
    Get.snackbar(
      'Heads up',
      message,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Confirm Payment',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AiScanCubit, AiScanState>(
        // Reset the in-screen processing flag if the payment fails so the
        // user can correct + retry (the host handles forward navigation on
        // AiScanPaying / AiScanPaymentCompleted).
        listener: (context, state) {
          if (state is AiScanPaymentFailedResult && mounted) {
            setState(() => _isProcessing = false);
          }
        },
        child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBeneficiaryCard(),
              SizedBox(height: 20.h),
              if (_requiresBankReview) ...[
                _buildBankReviewFields(),
                SizedBox(height: 20.h),
              ],
              if (_amountEditable)
                _buildAmountInput()
              else
                _buildAmountDisplay(),
              SizedBox(height: 20.h),
              _buildNoteField(),
              SizedBox(height: 20.h),
              _buildAccountSelector(),
              SizedBox(height: 28.h),
              _buildPayButton(),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildBeneficiaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(_iconForType(), color: const Color(0xFF3B82F6), size: 40.sp),
          SizedBox(height: 8.h),
          Text(
            _intent.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (_intent.subtitle.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              _intent.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _iconForType() {
    switch (_intent.type) {
      case ScanIntentType.bankDetails:
        return Icons.account_balance;
      case ScanIntentType.qrPay:
        return Icons.qr_code_2;
      case ScanIntentType.invoice:
        return Icons.receipt_long;
      case ScanIntentType.recipient:
        return Icons.person;
      case ScanIntentType.unknown:
        return Icons.help_outline;
    }
  }

  Widget _buildBankReviewFields() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber,
                  color: Color(0xFFFB923C), size: 18),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Low confidence — please double-check these details',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFFFB923C),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _darkTextField(
            controller: _accountNumberController,
            label: 'Account Number',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12.h),
          _darkTextField(
            controller: _bankNameController,
            label: 'Bank Name',
          ),
        ],
      ),
    );
  }

  Widget _darkTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Amount',
          style: GoogleFonts.inter(
              fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixText: '${_intent.currency} ',
              prefixStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 18.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
              hintText: '0.00',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountDisplay() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            'Amount',
            style: GoogleFonts.inter(
                fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
          ),
          SizedBox(height: 8.h),
          Text(
            '${_intent.currency} ${(_intent.amount ?? 0).toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note (optional)',
          style: GoogleFonts.inter(
              fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: _noteController,
            maxLength: 100,
            style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white),
            decoration: InputDecoration(
              hintText: 'What is this payment for?',
              hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp, color: const Color(0xFF6B7280)),
              counterText: '',
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
        ),
      ],
    );
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
            child: const Center(child: LazerVaultLoader.small()),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final currency = _intent.currency.toUpperCase();
          final matching = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == currency)
              .toList();

          final amount = _amountEditable
              ? (double.tryParse(_amountController.text.trim()) ?? 0)
              : (_intent.amount ?? 0);

          // Auto-select the first account with sufficient balance.
          if (_selectedAccountId == null && matching.isNotEmpty) {
            final best = matching.firstWhere(
              (a) => a.availableBalance >= amount,
              orElse: () => matching.first,
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && _selectedAccountId == null) {
                setState(() => _selectedAccountId = best.id.toString());
              }
            });
          }

          if (matching.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber,
                      color: Color(0xFFEF4444), size: 22),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'No $currency account found. Please create one first.',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Account',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              ...matching.map((account) {
                final isSelected =
                    _selectedAccountId == account.id.toString();
                final sufficient = account.availableBalance >= amount;
                return GestureDetector(
                  onTap: sufficient
                      ? () => setState(
                          () => _selectedAccountId = account.id.toString())
                      : () => _snack('This account does not have enough funds'),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: !sufficient
                          ? const Color(0xFF1F1F1F).withValues(alpha: 0.5)
                          : isSelected
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                              : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: !sufficient
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
                            color: const Color(0xFF3B82F6)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: const Icon(Icons.account_balance_wallet,
                              color: Color(0xFF3B82F6), size: 20),
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
                              Text(
                                '${account.currency} ${account.availableBalance.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected && sufficient)
                          const Icon(Icons.check_circle,
                              color: Color(0xFF3B82F6), size: 24),
                      ],
                    ),
                  ),
                );
              }),
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
      height: 54.h,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _onPay,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor:
              const Color(0xFF10B981).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: _isProcessing
            ? LazerVaultLoader.small()
            : Text(
                'Pay Now',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
