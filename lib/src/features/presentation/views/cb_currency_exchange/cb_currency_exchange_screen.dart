import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class CBCurrencyExchangeScreen extends StatefulWidget {
  const CBCurrencyExchangeScreen({super.key});

  @override
  State<CBCurrencyExchangeScreen> createState() =>
      _CBCurrencyExchangeScreenState();
}

class _CBCurrencyExchangeScreenState extends State<CBCurrencyExchangeScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _convertedAmountController =
      TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverAccountController =
      TextEditingController();
  final TextEditingController _receiverBankController = TextEditingController();
  final TextEditingController _receiverSwiftController =
      TextEditingController();
  String _selectedFromCurrency = 'GBP';
  String _selectedToCurrency = 'USD';
  final double _exchangeRate = 1.25; // Example rate
  bool _isProcessing = false;
  List<Map<String, dynamic>> _recentTransactions = [];

  final List<String> _currencies = [
    'GBP',
    'USD',
    'EUR',
    'JPY',
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'INR'
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentTransactions();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _convertedAmountController.dispose();
    _receiverNameController.dispose();
    _receiverAccountController.dispose();
    _receiverBankController.dispose();
    _receiverSwiftController.dispose();
    super.dispose();
  }

  void _loadRecentTransactions() {
    // Simulate loading recent transactions
    setState(() {
      _recentTransactions = [
        {
          'from': 'GBP',
          'to': 'USD',
          'amount': 1000.00,
          'converted': 1250.00,
          'rate': 1.25,
          'date': '2024-03-20',
          'status': 'Completed'
        },
        {
          'from': 'USD',
          'to': 'EUR',
          'amount': 500.00,
          'converted': 460.00,
          'rate': 0.92,
          'date': '2024-03-19',
          'status': 'Completed'
        },
      ];
    });
  }

  void _convertCurrency() {
    if (_amountController.text.isEmpty) return;

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final convertedAmount = amount * _exchangeRate;

    setState(() {
      _convertedAmountController.text = convertedAmount.toStringAsFixed(2);
    });
  }

  void _showReceiverDetailsBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Receiver Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildReceiverInputField(
              'Full Name',
              _receiverNameController,
              TextInputType.name,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'Account Number',
              _receiverAccountController,
              TextInputType.number,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'Bank Name',
              _receiverBankController,
              TextInputType.text,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'SWIFT/BIC Code',
              _receiverSwiftController,
              TextInputType.text,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  Widget _buildReceiverInputField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $label',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _validateAndProceed() {
    if (_receiverNameController.text.isEmpty ||
        _receiverAccountController.text.isEmpty ||
        _receiverBankController.text.isEmpty ||
        _receiverSwiftController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all receiver details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.back(); // Close bottom sheet
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Confirm International Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfirmationRow(
                'Amount', '${_amountController.text} $_selectedFromCurrency'),
            SizedBox(height: 8.h),
            _buildConfirmationRow('Converted',
                '${_convertedAmountController.text} $_selectedToCurrency'),
            SizedBox(height: 8.h),
            _buildConfirmationRow('Exchange Rate',
                '1 $_selectedFromCurrency = $_exchangeRate $_selectedToCurrency'),
            SizedBox(height: 16.h),
            Text(
              'Receiver Details:',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            _buildConfirmationRow('Name', _receiverNameController.text),
            _buildConfirmationRow('Account', _receiverAccountController.text),
            _buildConfirmationRow('Bank', _receiverBankController.text),
            _buildConfirmationRow('SWIFT', _receiverSwiftController.text),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _handleExchange,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleExchange() async {
    if (_amountController.text.isEmpty) return;

    setState(() => _isProcessing = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'International payment completed successfully',
              style: TextStyle(fontSize: 14.sp),
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Add to recent transactions
        setState(() {
          _recentTransactions.insert(0, {
            'from': _selectedFromCurrency,
            'to': _selectedToCurrency,
            'amount': double.parse(_amountController.text),
            'converted': double.parse(_convertedAmountController.text),
            'rate': _exchangeRate,
            'date': DateTime.now().toString().split(' ')[0],
            'status': 'Completed',
            'receiver': _receiverNameController.text,
            'bank': _receiverBankController.text,
          });
        });

        // Clear all inputs
        _amountController.clear();
        _convertedAmountController.clear();
        _receiverNameController.clear();
        _receiverAccountController.clear();
        _receiverBankController.clear();
        _receiverSwiftController.clear();

        Get.toNamed(AppRoutes.transferProof,
            arguments: _receiverNameController.text);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to process payment. Please try again.',
              style: TextStyle(fontSize: 14.sp),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Widget _buildCurrencySelector(
      String selectedCurrency, Function(String) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: DropdownButton<String>(
        value: selectedCurrency,
        dropdownColor: const Color(0xFF1A1A1A),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        underline: const SizedBox(),
        items: _currencies.map((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Text(currency),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
            _convertCurrency();
          }
        },
      ),
    );
  }

  Widget _buildAmountInput(
      String label, TextEditingController controller, String currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Text(
                currency,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                  ),
                  onChanged: (_) => _convertCurrency(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${transaction['from']} → ${transaction['to']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                transaction['date'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${transaction['amount']} ${transaction['from']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '${transaction['converted']} ${transaction['to']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rate: ${transaction['rate']}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  transaction['status'],
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'International Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              // Show transaction history
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Close keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exchange Rate Display
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.2),
                      Colors.purple.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'Current Exchange Rate',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '1 $_selectedFromCurrency = $_exchangeRate $_selectedToCurrency',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Currency Selection
              Row(
                children: [
                  Expanded(
                    child: _buildCurrencySelector(
                      _selectedFromCurrency,
                      (value) => setState(() => _selectedFromCurrency = value),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 24.r,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildCurrencySelector(
                      _selectedToCurrency,
                      (value) => setState(() => _selectedToCurrency = value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Amount Inputs
              _buildAmountInput(
                  'You Send', _amountController, _selectedFromCurrency),
              SizedBox(height: 16.h),
              _buildAmountInput('You Receive', _convertedAmountController,
                  _selectedToCurrency),
              SizedBox(height: 24.h),

              // Exchange Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _isProcessing ? null : _showReceiverDetailsBottomSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Add Receiver Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Recent Transactions
              Text(
                'Recent Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              ..._recentTransactions
                  .map((transaction) => _buildTransactionCard(transaction)),
            ],
          ),
        ),
      ),
    );
  }
}
