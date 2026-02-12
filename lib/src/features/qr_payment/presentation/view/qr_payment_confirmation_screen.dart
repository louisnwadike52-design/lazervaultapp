import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class QRPaymentConfirmationScreen extends StatefulWidget {
  const QRPaymentConfirmationScreen({super.key});

  @override
  State<QRPaymentConfirmationScreen> createState() =>
      _QRPaymentConfirmationScreenState();
}

class _QRPaymentConfirmationScreenState
    extends State<QRPaymentConfirmationScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _amountController = TextEditingController();
  Map<String, dynamic> _qrData = {};
  String? _selectedAccountId;
  bool _isStaticQR = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _qrData = Get.arguments as Map<String, dynamic>? ?? {};
    _isStaticQR = (_qrData['qr_type'] ?? '') == 'static';
    if (!_isStaticQR && _qrData['amount'] != null) {
      _amountController.text = _qrData['amount'].toString();
    }

    // Load accounts if not already loaded
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
          );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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

    final amount = _isStaticQR
        ? (double.tryParse(_amountController.text) ?? 0)
        : (double.tryParse(_qrData['amount'].toString()) ?? 0);

    if (_isStaticQR && amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final currency = (_qrData['currency'] ?? 'NGN').toString().toUpperCase();

    // Validate account has sufficient balance
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries.firstWhere(
        (a) => a.id.toString() == _selectedAccountId,
        orElse: () => throw Exception('Account not found'),
      );

      if (selectedAccount.currency.toUpperCase() != currency) {
        Get.snackbar(
          'Currency Mismatch',
          'Please select a $currency account',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (selectedAccount.balance < amount) {
        Get.snackbar(
          'Insufficient Balance',
          'Your account balance (${selectedAccount.currency} ${selectedAccount.balance.toStringAsFixed(2)}) is less than the payment amount ($currency ${amount.toStringAsFixed(2)})',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return;
      }
    }

    HapticFeedback.mediumImpact();

    final qrCode = _qrData['qr_code']?.toString() ?? '';
    final idPrefix = qrCode.length >= 8 ? qrCode.substring(0, 8) : qrCode;
    final transactionId = 'QR-PAY-$idPrefix';

    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'qr_payment',
      amount: amount,
      currency: currency,
    );

    if (pinResult == null || !pinResult.success) return;

    setState(() {
      _isProcessing = true;
    });

    if (!mounted) return;
    context.read<QRPaymentCubit>().processQRPayment(
          qrCode: qrCode,
          sourceAccountId: _selectedAccountId!,
          amount: amount,
          transactionPin: pinResult.verificationToken ?? '',
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
        title: const Text(
          'Confirm Payment',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: BlocListener<QRPaymentCubit, QRPaymentState>(
        listener: (context, state) {
          if (state is QRPaymentSuccess) {
            setState(() {
              _isProcessing = false;
            });
            Get.offNamed(
              AppRoutes.qrPaymentReceipt,
              arguments: {
                'transaction': state.transaction,
                'newBalance': state.newBalance,
              },
            );
          } else if (state is QRPaymentError) {
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRecipientCard(),
                const SizedBox(height: 24),
                if (_isStaticQR) ...[
                  _buildAmountInput(),
                  const SizedBox(height: 24),
                ] else
                  _buildAmountDisplay(),
                _buildAccountSelector(),
                const SizedBox(height: 32),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.person, color: Color(0xFF3B82F6), size: 40),
          const SizedBox(height: 8),
          Text(
            _qrData['recipient_name'] ?? _qrData['recipient'] ?? 'Recipient',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (_qrData['recipient'] != null) ...[
            const SizedBox(height: 4),
            Text(
              '@${_qrData['recipient']}',
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
          ],
          if (_qrData['description'] != null &&
              _qrData['description'].toString().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _qrData['description'].toString(),
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountDisplay() {
    final amount = _qrData['amount'] ?? 0;
    final currency = _qrData['currency'] ?? 'NGN';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Amount',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '$currency ${double.tryParse(amount.toString())?.toStringAsFixed(2) ?? '0.00'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter Amount',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _amountController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixText: '${_qrData['currency'] ?? 'NGN'} ',
              prefixStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: '0.00',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 24,
              ),
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final currency =
              (_qrData['currency'] ?? 'NGN').toString().toUpperCase();
          final matchingAccounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == currency)
              .toList();

          // Auto-select first matching account with sufficient balance
          if (_selectedAccountId == null && matchingAccounts.isNotEmpty) {
            final amount = _isStaticQR
                ? (double.tryParse(_amountController.text) ?? 0)
                : (double.tryParse(_qrData['amount'].toString()) ?? 0);
            final bestAccount = matchingAccounts.firstWhere(
              (a) => a.balance >= amount,
              orElse: () => matchingAccounts.first,
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _selectedAccountId = bestAccount.id.toString();
                });
              }
            });
          }

          if (matchingAccounts.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber,
                      color: Color(0xFFEF4444), size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No $currency account found. Please create one first.',
                      style: const TextStyle(
                          color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Only $currency accounts are available for this payment',
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              ...matchingAccounts.map((account) {
                final isSelected =
                    _selectedAccountId == account.id.toString();
                final amount = _isStaticQR
                    ? (double.tryParse(_amountController.text) ?? 0)
                    : (double.tryParse(_qrData['amount'].toString()) ?? 0);
                final hasSufficientBalance = account.balance >= amount;

                return GestureDetector(
                  onTap: hasSufficientBalance
                      ? () {
                          setState(() {
                            _selectedAccountId = account.id.toString();
                          });
                        }
                      : () {
                          Get.snackbar(
                            'Insufficient Balance',
                            'This account does not have enough funds',
                            backgroundColor: const Color(0xFFFB923C),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: !hasSufficientBalance
                          ? const Color(0xFF1F1F1F).withValues(alpha: 0.5)
                          : isSelected
                              ? const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.1)
                              : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: !hasSufficientBalance
                            ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                            : isSelected
                                ? const Color(0xFF3B82F6)
                                : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444)
                                    .withValues(alpha: 0.2)
                                : const Color(0xFF3B82F6)
                                    .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: !hasSufficientBalance
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF3B82F6),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      account.accountType,
                                      style: TextStyle(
                                        color: !hasSufficientBalance
                                            ? Colors.white
                                                .withValues(alpha: 0.5)
                                            : Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (!hasSufficientBalance)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEF4444)
                                            .withValues(alpha: 0.2),
                                        borderRadius:
                                            BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Insufficient',
                                        style: TextStyle(
                                          color: Color(0xFFEF4444),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: !hasSufficientBalance
                                      ? const Color(0xFF9CA3AF)
                                          .withValues(alpha: 0.5)
                                      : const Color(0xFF9CA3AF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected && hasSufficientBalance)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF3B82F6),
                            size: 24,
                          ),
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
      height: 54,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor:
              const Color(0xFF10B981).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isProcessing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Pay Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
