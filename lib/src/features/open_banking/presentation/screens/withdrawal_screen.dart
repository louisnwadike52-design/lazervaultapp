import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/open_banking_cubit.dart';
import '../../cubit/open_banking_state.dart';
import '../../domain/entities/withdrawal.dart';

/// Screen for withdrawing funds to external bank account
class WithdrawalScreen extends StatefulWidget {
  final String userId;
  final String sourceAccountId;
  final double availableBalance;
  final String accountName;
  final String accessToken;

  const WithdrawalScreen({
    super.key,
    required this.userId,
    required this.sourceAccountId,
    required this.availableBalance,
    required this.accountName,
    required this.accessToken,
  });

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _narrationController = TextEditingController();

  Bank? _selectedBank;
  AccountNameInquiry? _resolvedAccount;
  WithdrawalFeeCalculation? _feeCalculation;
  bool _isResolvingAccount = false;
  bool _showConfirmation = false;

  @override
  void initState() {
    super.initState();
    _fetchBanks();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _accountNumberController.dispose();
    _narrationController.dispose();
    super.dispose();
  }

  void _fetchBanks() {
    context.read<OpenBankingCubit>().fetchBanks(
          accessToken: widget.accessToken,
        );
  }

  void _onAmountChanged() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null && amount >= 100) {
      _calculateFee(amount);
    } else {
      setState(() {
        _feeCalculation = null;
      });
    }
  }

  void _calculateFee(double amount) {
    context.read<OpenBankingCubit>().calculateWithdrawalFee(
          amount: amount,
          accessToken: widget.accessToken,
        );
  }

  void _resolveAccountName() {
    if (_selectedBank == null || _accountNumberController.text.length != 10) {
      return;
    }

    setState(() {
      _isResolvingAccount = true;
      _resolvedAccount = null;
    });

    context.read<OpenBankingCubit>().resolveAccountName(
          accountNumber: _accountNumberController.text,
          bankCode: _selectedBank!.code,
          accessToken: widget.accessToken,
        );
  }

  void _initiateWithdrawal() {
    if (!_formKey.currentState!.validate()) return;
    if (_resolvedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please verify the account name first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final amount = double.parse(_amountController.text);

    context.read<OpenBankingCubit>().initiateWithdrawal(
          userId: widget.userId,
          sourceAccountId: widget.sourceAccountId,
          bankCode: _selectedBank!.code,
          accountNumber: _accountNumberController.text,
          accountName: _resolvedAccount!.accountName,
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
        title: const Text('Withdraw Funds'),
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
          if (state is BanksLoaded) {
            // Banks loaded - handled in builder
          } else if (state is AccountNameResolved) {
            setState(() {
              _resolvedAccount = state.inquiry;
              _isResolvingAccount = false;
            });
          } else if (state is WithdrawalFeeCalculated) {
            setState(() {
              _feeCalculation = state.calculation;
            });
          } else if (state is WithdrawalInitiated) {
            Navigator.pop(context, state.withdrawal);
          } else if (state is OpenBankingError) {
            setState(() {
              _isResolvingAccount = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final banks = context.read<OpenBankingCubit>().banks;

          if (banks.isEmpty && state is OpenBankingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_showConfirmation) {
            return _buildConfirmationView(state);
          }

          return _buildForm(banks, state);
        },
      ),
    );
  }

  Widget _buildForm(List<Bank> banks, OpenBankingState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Available balance header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: Color(0xFF6C5CE7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '₦${widget.availableBalance.toStringAsFixed(2).replaceAllMapped(
                        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                        (match) => '${match[1]},',
                      )}',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.accountName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount input
                  Text(
                    'Amount to Withdraw',
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
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    decoration: InputDecoration(
                      prefixText: '₦ ',
                      prefixStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      hintText: '0.00',
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
                        borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null) {
                        return 'Invalid amount';
                      }
                      if (amount < 100) {
                        return 'Minimum withdrawal is ₦100';
                      }
                      final total = amount + (_feeCalculation?.fee ?? 0);
                      if (total > widget.availableBalance) {
                        return 'Insufficient balance';
                      }
                      return null;
                    },
                  ),

                  // Fee display
                  if (_feeCalculation != null) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transfer fee:',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.blue[700],
                            ),
                          ),
                          Text(
                            _feeCalculation!.formattedFee,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // Bank selection
                  Text(
                    'Select Bank',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildBankDropdown(banks),

                  SizedBox(height: 20.h),

                  // Account number
                  Text(
                    'Account Number',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _accountNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'Enter 10-digit account number',
                      filled: true,
                      fillColor: Colors.white,
                      counterText: '',
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
                        borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                      suffixIcon: _isResolvingAccount
                          ? Padding(
                              padding: EdgeInsets.all(12.w),
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF6C5CE7),
                                ),
                              ),
                            )
                          : _accountNumberController.text.length == 10 &&
                                  _selectedBank != null
                              ? IconButton(
                                  onPressed: _resolveAccountName,
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey[600],
                                  ),
                                )
                              : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _resolvedAccount = null;
                      });
                      if (value.length == 10 && _selectedBank != null) {
                        _resolveAccountName();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter account number';
                      }
                      if (value.length != 10) {
                        return 'Account number must be 10 digits';
                      }
                      return null;
                    },
                  ),

                  // Resolved account name
                  if (_resolvedAccount != null) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[600],
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              _resolvedAccount!.accountName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 20.h),

                  // Narration (optional)
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
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'e.g., Personal savings',
                      filled: true,
                      fillColor: Colors.white,
                      counterText: '',
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
                        borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _resolvedAccount != null &&
                              _formKey.currentState?.validate() == true
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _showConfirmation = true;
                                });
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _buildBankDropdown(List<Bank> banks) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<Bank>(
          value: _selectedBank,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            border: InputBorder.none,
          ),
          hint: Text(
            'Select a bank',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
          items: banks.map((bank) {
            return DropdownMenuItem(
              value: bank,
              child: Text(
                bank.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[800],
                ),
              ),
            );
          }).toList(),
          onChanged: (bank) {
            setState(() {
              _selectedBank = bank;
              _resolvedAccount = null;
            });
            if (_accountNumberController.text.length == 10 && bank != null) {
              _resolveAccountName();
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a bank';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildConfirmationView(OpenBankingState state) {
    final amount = double.parse(_amountController.text);
    final fee = _feeCalculation?.fee ?? 0;
    final total = amount + fee;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: () => setState(() => _showConfirmation = false),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 18.sp, color: Colors.grey[600]),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Title
          Text(
            'Confirm Withdrawal',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please review the details below',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 32.h),

          // Summary card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Recipient info
                _buildDetailRow(
                  'Recipient',
                  _resolvedAccount?.accountName ?? '',
                  isHighlighted: true,
                ),
                Divider(height: 24.h),
                _buildDetailRow(
                  'Bank',
                  _selectedBank?.name ?? '',
                ),
                SizedBox(height: 12.h),
                _buildDetailRow(
                  'Account Number',
                  _accountNumberController.text,
                ),
                Divider(height: 24.h),
                _buildDetailRow(
                  'Amount',
                  '₦${amount.toStringAsFixed(2).replaceAllMapped(
                        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                        (match) => '${match[1]},',
                      )}',
                ),
                SizedBox(height: 12.h),
                _buildDetailRow(
                  'Transfer Fee',
                  '₦${fee.toStringAsFixed(2)}',
                  valueColor: Colors.orange[700],
                ),
                Divider(height: 24.h),
                _buildDetailRow(
                  'Total Debit',
                  '₦${total.toStringAsFixed(2).replaceAllMapped(
                        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                        (match) => '${match[1]},',
                      )}',
                  isHighlighted: true,
                  valueColor: const Color(0xFF6C5CE7),
                ),
                if (_narrationController.text.isNotEmpty) ...[
                  Divider(height: 24.h),
                  _buildDetailRow(
                    'Narration',
                    _narrationController.text,
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Warning
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.amber[200]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.amber[700],
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Please confirm that all details are correct. Withdrawals cannot be reversed once processed.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.amber[900],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Withdraw button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed:
                  state is OpenBankingLoading ? null : _initiateWithdrawal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF6C5CE7).withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: state is OpenBankingLoading
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Withdraw ₦${amount.toStringAsFixed(2).replaceAllMapped(
                            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                            (match) => '${match[1]},',
                          )}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlighted = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isHighlighted ? 15.sp : 14.sp,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
              color: valueColor ?? Colors.grey[800],
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
