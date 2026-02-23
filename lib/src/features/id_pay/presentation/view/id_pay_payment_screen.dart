import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';

class IDPayPaymentScreen extends StatefulWidget {
  const IDPayPaymentScreen({super.key});

  @override
  State<IDPayPaymentScreen> createState() => _IDPayPaymentScreenState();
}

class _IDPayPaymentScreenState extends State<IDPayPaymentScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  late final IDPayEntity _idPay;
  final TextEditingController _amountController = TextEditingController();
  String? _selectedAccountId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    _idPay = args['idPay'] as IDPayEntity;

    if (_idPay.isFixed) {
      _amountController.text = _idPay.amount.toStringAsFixed(2);
    }

    // Ensure accounts are loaded, then auto-select best account
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      _autoSelectAccount(accountState.accountSummaries);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
          );
    }
  }

  void _autoSelectAccount(List<dynamic> accounts) {
    if (_selectedAccountId != null) return;
    // Pick first matching-currency account with sufficient balance
    for (final account in accounts) {
      if (account.currency.toUpperCase() == _idPay.currency.toUpperCase() &&
          account.balance >= _paymentAmount) {
        setState(() {
          _selectedAccountId = account.id.toString();
        });
        return;
      }
    }
    // Fallback: pick first matching-currency account even if insufficient
    for (final account in accounts) {
      if (account.currency.toUpperCase() == _idPay.currency.toUpperCase()) {
        setState(() {
          _selectedAccountId = account.id.toString();
        });
        return;
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double get _paymentAmount {
    if (_idPay.isFixed) return _idPay.amount;
    return double.tryParse(_amountController.text.trim()) ?? 0.0;
  }

  bool get _isValidAmount {
    final amount = _paymentAmount;
    if (amount <= 0) return false;
    if (_idPay.isFlexible) {
      if (_idPay.minAmount > 0 && amount < _idPay.minAmount) return false;
      if (_idPay.maxAmount > 0 && amount > _idPay.maxAmount) return false;
    }
    return true;
  }

  void _processPayment() async {
    if (!_isValidAmount) {
      Get.snackbar(
        'Invalid Amount',
        _getAmountErrorMessage(),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    if (_selectedAccountId == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select a source account',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    // Validate account balance
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries.firstWhere(
        (a) => a.id.toString() == _selectedAccountId,
        orElse: () => throw Exception('Account not found'),
      );

      if (selectedAccount.currency.toUpperCase() !=
          _idPay.currency.toUpperCase()) {
        Get.snackbar(
          'Currency Mismatch',
          'Please select a ${_idPay.currency} account',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16.w),
        );
        return;
      }

      if (selectedAccount.balance < _paymentAmount) {
        Get.snackbar(
          'Insufficient Balance',
          'Your account balance (${selectedAccount.currency} ${selectedAccount.balance.toStringAsFixed(2)}) is less than the payment amount',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16.w),
          duration: const Duration(seconds: 4),
        );
        return;
      }
    }

    HapticFeedback.mediumImpact();

    final idPrefix =
        _idPay.id.length >= 8 ? _idPay.id.substring(0, 8) : _idPay.id;
    final transactionId = 'IDPAY-$idPrefix';

    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'id_pay_payment',
      amount: _paymentAmount,
      currency: _idPay.currency,
    );

    if (pinResult == null || !pinResult.success) return;

    setState(() {
      _isProcessing = true;
    });

    if (!mounted) return;
    context.read<IDPayCubit>().payIDPay(
          payId: _idPay.payId,
          amount: _paymentAmount,
          transactionPin: pinResult.verificationToken ?? '',
          sourceAccountId: _selectedAccountId!,
        );
  }

  String _getAmountErrorMessage() {
    final amount = _paymentAmount;
    if (amount <= 0) return 'Please enter a valid amount';
    if (_idPay.minAmount > 0 && amount < _idPay.minAmount) {
      return 'Minimum amount is ${_currencySymbol(_idPay.currency)}${_idPay.minAmount.toStringAsFixed(2)}';
    }
    if (_idPay.maxAmount > 0 && amount > _idPay.maxAmount) {
      return 'Maximum amount is ${_currencySymbol(_idPay.currency)}${_idPay.maxAmount.toStringAsFixed(2)}';
    }
    return 'Invalid amount';
  }

  bool _hasSufficientBalance(dynamic account) {
    if (account.currency.toUpperCase() != _idPay.currency.toUpperCase()) {
      return false;
    }
    return account.balance >= _paymentAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<IDPayCubit, IDPayState>(
        listener: (context, state) {
          if (state is IDPayPaid) {
            setState(() {
              _isProcessing = false;
            });
            Get.offAllNamed('/id-pay/receipt', arguments: {
              'transaction': state.transaction,
              'idPay': _idPay,
              'newBalance': state.newBalance,
            });
          } else if (state is IDPayError) {
            setState(() {
              _isProcessing = false;
            });
            Get.snackbar(
              'Payment Failed',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(16.w),
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
                _buildRecipientCard(),
                SizedBox(height: 24.h),
                if (_idPay.isFlexible) ...[
                  _buildAmountInput(),
                  SizedBox(height: 24.h),
                ] else ...[
                  _buildFixedAmountDisplay(),
                  SizedBox(height: 24.h),
                ],
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
                'Review and confirm your IDPay payment',
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

  Widget _buildRecipientCard() {
    return Container(
      width: double.infinity,
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
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(26.r),
            ),
            child: Center(
              child: Text(
                _idPay.creatorName.isNotEmpty
                    ? _idPay.creatorName[0].toUpperCase()
                    : '?',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _idPay.creatorName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _idPay.displayPayId,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_idPay.creatorUsername.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '@${_idPay.creatorUsername}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedAmountDisplay() {
    return Container(
      width: double.infinity,
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
      child: Center(
        child: Column(
          children: [
            Text(
              "You're Paying",
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${_currencySymbol(_idPay.currency)}${_idPay.amount.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Amount',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 24.sp,
            ),
            prefixText: '${_currencySymbol(_idPay.currency)} ',
            prefixStyle: GoogleFonts.inter(
              color: const Color(0xFF3B82F6),
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          ),
          onChanged: (_) => setState(() {}),
        ),
        if (_idPay.minAmount > 0 || _idPay.maxAmount > 0) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              if (_idPay.minAmount > 0)
                Text(
                  'Min: ${_currencySymbol(_idPay.currency)}${_idPay.minAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (_idPay.minAmount > 0 && _idPay.maxAmount > 0)
                Text(
                  '  |  ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4B5563),
                    fontSize: 12.sp,
                  ),
                ),
              if (_idPay.maxAmount > 0)
                Text(
                  'Max: ${_currencySymbol(_idPay.currency)}${_idPay.maxAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ],
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
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          // Auto-select if not yet selected
          if (_selectedAccountId == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _autoSelectAccount(state.accountSummaries);
            });
          }

          final selectedAccount = _selectedAccountId != null
              ? state.accountSummaries
                  .where((a) => a.id.toString() == _selectedAccountId)
                  .firstOrNull
              : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Source Account',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAccountPickerSheet(
                        state.accountSummaries),
                    child: Text(
                      'Change',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              if (selectedAccount != null)
                _buildSelectedAccountCard(selectedAccount)
              else
                GestureDetector(
                  onTap: () => _showAccountPickerSheet(
                      state.accountSummaries),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: const Color(0xFF9CA3AF),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Tap to select an account',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSelectedAccountCard(dynamic account) {
    final hasSufficientBalance = _hasSufficientBalance(account);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        border: Border.all(
          color: const Color(0xFF3B82F6),
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
              color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: const Color(0xFF3B82F6),
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
                          color: Colors.white,
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
                          color: const Color(0xFFEF4444)
                              .withValues(alpha: 0.2),
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
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF3B82F6),
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  void _showAccountPickerSheet(List<dynamic> allAccounts) {
    final matchingAccounts = allAccounts
        .where((a) =>
            a.currency.toUpperCase() == _idPay.currency.toUpperCase())
        .toList();

    final otherAccounts = allAccounts
        .where((a) =>
            a.currency.toUpperCase() != _idPay.currency.toUpperCase())
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4B5563),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    'Select Account',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close,
                        color: const Color(0xFF9CA3AF), size: 22.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Only ${_idPay.currency} accounts with sufficient balance can be used',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  ...matchingAccounts.map((account) {
                    final isSelected =
                        _selectedAccountId == account.id.toString();
                    final hasSufficientBalance =
                        _hasSufficientBalance(account);
                    return GestureDetector(
                      onTap: hasSufficientBalance
                          ? () {
                              setState(() {
                                _selectedAccountId =
                                    account.id.toString();
                              });
                              Navigator.pop(context);
                            }
                          : () {
                              Get.snackbar(
                                'Insufficient Balance',
                                'This account does not have enough funds. You need ${_idPay.currency} ${_paymentAmount.toStringAsFixed(2)}',
                                backgroundColor:
                                    const Color(0xFFFB923C),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                            },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: !hasSufficientBalance
                              ? const Color(0xFF1F1F1F)
                                  .withValues(alpha: 0.5)
                              : isSelected
                                  ? const Color(0xFF3B82F6)
                                      .withValues(alpha: 0.1)
                                  : const Color(0xFF0A0A0A),
                          border: Border.all(
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444)
                                    .withValues(alpha: 0.3)
                                : isSelected
                                    ? const Color(0xFF3B82F6)
                                    : const Color(0xFF2D2D2D),
                            width: isSelected ? 2 : 1,
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
                                    ? const Color(0xFFEF4444)
                                        .withValues(alpha: 0.2)
                                    : const Color(0xFF3B82F6)
                                        .withValues(alpha: 0.2),
                                borderRadius:
                                    BorderRadius.circular(20.r),
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.accountType,
                                    style: GoogleFonts.inter(
                                      color: !hasSufficientBalance
                                          ? Colors.white
                                              .withValues(alpha: 0.5)
                                          : Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                    style: GoogleFonts.inter(
                                      color: !hasSufficientBalance
                                          ? const Color(0xFF9CA3AF)
                                              .withValues(alpha: 0.5)
                                          : const Color(0xFF9CA3AF),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!hasSufficientBalance)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444)
                                      .withValues(alpha: 0.2),
                                  borderRadius:
                                      BorderRadius.circular(4.r),
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
                  if (otherAccounts.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      'Other Currencies (not available)',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF)
                            .withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...otherAccounts.map((account) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F)
                              .withValues(alpha: 0.3),
                          border: Border.all(
                            color: const Color(0xFF2D2D2D)
                                .withValues(alpha: 0.5),
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
                                color: const Color(0xFF2D2D2D)
                                    .withValues(alpha: 0.5),
                                borderRadius:
                                    BorderRadius.circular(20.r),
                              ),
                              child: Icon(
                                Icons.account_balance_wallet,
                                color: const Color(0xFF9CA3AF)
                                    .withValues(alpha: 0.5),
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.accountType,
                                    style: GoogleFonts.inter(
                                      color: Colors.white
                                          .withValues(alpha: 0.4),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF)
                                          .withValues(alpha: 0.4),
                                      fontSize: 12.sp,
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
                                borderRadius:
                                    BorderRadius.circular(4.r),
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
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          disabledBackgroundColor:
              const Color(0xFF3B82F6).withValues(alpha: 0.5),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? SizedBox(
                height: 22.h,
                width: 22.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Pay ${_idPay.isFixed ? "${_currencySymbol(_idPay.currency)}${_idPay.amount.toStringAsFixed(2)}" : ""}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$currency ';
    }
  }
}
