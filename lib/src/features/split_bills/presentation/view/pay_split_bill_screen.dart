import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';

class PaySplitBillScreen extends StatelessWidget {
  const PaySplitBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SplitBillCubit>(),
      child: const _PaySplitBillView(),
    );
  }
}

class _PaySplitBillView extends StatefulWidget {
  const _PaySplitBillView();

  @override
  State<_PaySplitBillView> createState() => _PaySplitBillViewState();
}

class _PaySplitBillViewState extends State<_PaySplitBillView> {
  final _pinController = TextEditingController();
  bool _isProcessing = false;

  late final String splitBillId;
  late final double amount;
  late final String currency;
  late final String creatorName;
  late final String description;
  bool _invalidArgs = false;

  final _accountManager = GetIt.I<AccountManager>();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    splitBillId = args['splitBillId'] as String? ?? '';
    amount = (args['amount'] as num?)?.toDouble() ?? 0.0;
    currency = args['currency'] as String? ?? 'NGN';
    creatorName = args['creatorName'] as String? ?? 'Unknown';
    description = args['description'] as String? ?? '';
    if (splitBillId.isEmpty || amount <= 0) {
      _invalidArgs = true;
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  String get _formattedAmount {
    return '${_currencySymbol(currency)}${amount.toStringAsFixed(2)}';
  }

  String _currencySymbol(String code) {
    switch (code) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'GHS':
        return 'GH\u20B5';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '$code ';
    }
  }

  double? get _accountBalance =>
      _accountManager.activeAccountDetails?.balance;

  bool get _hasInsufficientFunds {
    final balance = _accountBalance;
    return balance != null && balance < amount;
  }

  void _submitPayment() {
    final pin = _pinController.text.trim();
    if (pin.length != 6) {
      Get.snackbar(
        'Invalid PIN',
        'Please enter your 6-digit transaction PIN',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final sourceAccountId = _accountManager.activeAccountId ?? '';
    if (sourceAccountId.isEmpty) {
      Get.snackbar(
        'No Account',
        'Please select an active account first',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_hasInsufficientFunds) {
      Get.snackbar(
        'Insufficient Funds',
        'Your account balance is not enough for this payment',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    HapticFeedback.mediumImpact();
    setState(() => _isProcessing = true);

    context.read<SplitBillCubit>().payShare(
          splitBillId: splitBillId,
          sourceAccountId: sourceAccountId,
          transactionPin: pin,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_invalidArgs) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Invalid payment details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

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
          'Pay Split Bill',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SplitBillCubit, SplitBillState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is SplitBillSharePaid) {
            setState(() => _isProcessing = false);
            Get.offAllNamed(
              AppRoutes.splitBillReceipt,
              arguments: {
                'transactionReference': state.transactionReference,
                'amount': amount,
                'currency': currency,
                'creatorName': creatorName,
                'description': description,
                'paidCount': state.updatedBill.paidCount,
                'totalParticipants': state.updatedBill.totalParticipants,
              },
            );
          } else if (state is SplitBillError) {
            setState(() => _isProcessing = false);
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
                const SizedBox(height: 12),
                _buildSummaryCard(),
                const SizedBox(height: 16),
                _buildAccountInfo(),
                const SizedBox(height: 32),
                _buildPinField(),
                const SizedBox(height: 40),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          const Text(
            'You\'re Paying',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formattedAmount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFF2D2D2D), thickness: 1),
          const SizedBox(height: 20),
          _buildDetailRow('To', creatorName),
          const SizedBox(height: 12),
          if (description.isNotEmpty) ...[
            _buildDetailRow('Description', description),
            const SizedBox(height: 12),
          ],
          _buildDetailRow('Currency', currency),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    final accountDetails = _accountManager.activeAccountDetails;
    final hasAccount = _accountManager.hasActiveAccount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hasInsufficientFunds
              ? const Color(0xFFEF4444).withValues(alpha: 0.5)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Color(0xFF3B82F6),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paying from',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hasAccount
                          ? _accountManager.getAccountDisplayText()
                          : 'No account selected',
                      style: TextStyle(
                        color: hasAccount
                            ? Colors.white
                            : const Color(0xFFEF4444),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (accountDetails != null)
                Text(
                  '${_currencySymbol(accountDetails.currency)}${accountDetails.balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: _hasInsufficientFunds
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          if (_hasInsufficientFunds) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFEF4444),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Insufficient balance. You need ${_currencySymbol(currency)}${(amount - (_accountBalance ?? 0)).toStringAsFixed(2)} more.',
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction PIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Enter your 6-digit transaction PIN to confirm',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _pinController,
          obscureText: true,
          maxLength: 6,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 12,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            hintText: '------',
            hintStyle: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 24,
              letterSpacing: 12,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          ),
          onSubmitted: (_) => _submitPayment(),
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing || _hasInsufficientFunds
            ? null
            : _submitPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor:
              const Color(0xFF10B981).withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Pay $_formattedAmount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
