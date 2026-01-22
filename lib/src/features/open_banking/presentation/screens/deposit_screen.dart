import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../cubit/open_banking_cubit.dart';
import '../../cubit/open_banking_state.dart';
import '../../domain/entities/linked_bank_account.dart';
import '../../domain/entities/deposit.dart';
import '../widgets/linked_account_selector.dart';
import 'linked_accounts_screen.dart';

/// Screen to initiate a deposit from a linked bank account
class DepositScreen extends StatefulWidget {
  final String userId;
  final String accessToken;
  final String destinationAccountId; // User's LazerVault virtual account
  final String destinationAccountName;

  const DepositScreen({
    super.key,
    required this.userId,
    required this.accessToken,
    required this.destinationAccountId,
    required this.destinationAccountName,
  });

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _narrationController = TextEditingController();

  LinkedBankAccount? _selectedAccount;
  double _fee = 0;
  double _netAmount = 0;
  bool _isCalculatingFee = false;
  bool _isInitiatingDeposit = false;

  @override
  void initState() {
    super.initState();
    _fetchLinkedAccounts();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _narrationController.dispose();
    super.dispose();
  }

  void _fetchLinkedAccounts() {
    context.read<OpenBankingCubit>().fetchLinkedAccounts(
          userId: widget.userId,
          accessToken: widget.accessToken,
        );
  }

  void _onAmountChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _fee = 0;
        _netAmount = 0;
      });
      return;
    }

    final amount = double.tryParse(value.replaceAll(',', ''));
    if (amount != null && amount > 0) {
      _calculateFee(amount);
    }
  }

  void _calculateFee(double amount) {
    // Local fee calculation (1.5% capped at 2000 Naira)
    setState(() {
      _isCalculatingFee = true;
    });

    final feeAmount = amount * 0.015;
    final cappedFee = feeAmount > 2000 ? 2000.0 : feeAmount;

    setState(() {
      _fee = cappedFee;
      _netAmount = amount - cappedFee;
      _isCalculatingFee = false;
    });
  }

  void _navigateToLinkBank() async {
    final result = await Get.to<bool>(
      () => LinkedAccountsScreen(
        userId: widget.userId,
        accessToken: widget.accessToken,
      ),
    );

    if (result == true) {
      _fetchLinkedAccounts();
    }
  }

  void _initiateDeposit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a linked bank account'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final amount =
        double.parse(_amountController.text.replaceAll(',', ''));

    setState(() => _isInitiatingDeposit = true);

    context.read<OpenBankingCubit>().initiateDeposit(
          userId: widget.userId,
          linkedAccountId: _selectedAccount!.id,
          destinationAccountId: widget.destinationAccountId,
          amount: amount,
          narration: _narrationController.text.isNotEmpty
              ? _narrationController.text
              : null,
          accessToken: widget.accessToken,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Deposit'),
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
          if (state is LinkedAccountsLoaded) {
            if (state.accounts.isNotEmpty) {
              setState(() {
                _selectedAccount = state.defaultAccount ?? state.accounts.first;
              });
            }
          } else if (state is DepositInitiated) {
            setState(() => _isInitiatingDeposit = false);
            _showDepositSuccessDialog(state.deposit);
          } else if (state is OpenBankingError) {
            setState(() => _isInitiatingDeposit = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final accounts = context.read<OpenBankingCubit>().linkedAccounts;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destination info card
                  _buildDestinationCard(),
                  SizedBox(height: 24.h),

                  // Source bank account selector
                  Text(
                    'From Bank Account',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (accounts.isEmpty)
                    _buildNoAccountsCard()
                  else
                    LinkedAccountSelector(
                      accounts: accounts,
                      selectedAccount: _selectedAccount,
                      onChanged: (account) {
                        setState(() => _selectedAccount = account);
                      },
                    ),
                  SizedBox(height: 24.h),

                  // Amount input
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: '0.00',
                      prefixText: '₦ ',
                      prefixStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF6C5CE7),
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: _onAmountChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      final amount = double.tryParse(value.replaceAll(',', ''));
                      if (amount == null || amount < 100) {
                        return 'Minimum deposit is ₦100';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Fee breakdown
                  if (_amountController.text.isNotEmpty) _buildFeeBreakdown(),
                  SizedBox(height: 16.h),

                  // Narration input
                  Text(
                    'Narration (Optional)',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _narrationController,
                    decoration: InputDecoration(
                      hintText: 'What\'s this for?',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF6C5CE7),
                          width: 2,
                        ),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 32.h),

                  // Deposit button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _isInitiatingDeposit ||
                              accounts.isEmpty ||
                              _selectedAccount == null
                          ? null
                          : _initiateDeposit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: _isInitiatingDeposit
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Deposit',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Security note
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 16.sp,
                          color: Colors.grey[500],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Secured with bank-grade encryption',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDestinationCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6C5CE7).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF6C5CE7).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: Color(0xFF6C5CE7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deposit to',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  widget.destinationAccountName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoAccountsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_outlined,
            size: 48.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 12.h),
          Text(
            'No linked bank accounts',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Link your bank account to make deposits',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 16.h),
          OutlinedButton(
            onPressed: _navigateToLinkBank,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6C5CE7),
              side: const BorderSide(color: Color(0xFF6C5CE7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text('Link Bank Account'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeBreakdown() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildFeeRow('Amount', '₦${_amountController.text}'),
          SizedBox(height: 8.h),
          _buildFeeRow(
            'Fee (1.5%)',
            _isCalculatingFee ? '...' : '₦${_fee.toStringAsFixed(2)}',
            isNegative: true,
          ),
          Divider(height: 16.h),
          _buildFeeRow(
            'You\'ll receive',
            '₦${_netAmount.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String value,
      {bool isNegative = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          isNegative ? '-$value' : value,
          style: TextStyle(
            fontSize: 14.sp,
            color: isNegative ? Colors.red : Colors.grey[800],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _showDepositSuccessDialog(Deposit deposit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Deposit Initiated!',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your deposit of ${deposit.formattedAmount} has been initiated.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                deposit.status.displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange[700],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Reference: ${deposit.reference}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[500],
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context, true); // Return to previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
