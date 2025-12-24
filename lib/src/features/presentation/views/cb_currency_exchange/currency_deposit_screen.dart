import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CurrencyDepositScreen extends StatefulWidget {
  final String currencyCode;
  
  const CurrencyDepositScreen({super.key, required this.currencyCode});

  @override
  State<CurrencyDepositScreen> createState() => _CurrencyDepositScreenState();
}

class _CurrencyDepositScreenState extends State<CurrencyDepositScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  
  bool _isProcessing = false;
  String _selectedDepositMethod = 'bank_transfer';
  
  // Mock bank account details for the selected currency
  Map<String, dynamic> get _depositDetails {
    final currency = _getCurrencyData(widget.currencyCode);
    return {
      'GBP': {
        'accountName': 'LazerVault Ltd',
        'accountNumber': '12345678',
        'sortCode': '12-34-56',
        'bankName': 'Barclays Bank',
        'iban': 'GB29 NWBK 6016 1331 9268 19',
        'swift': 'BARCGB22',
        'reference': 'LV${DateTime.now().millisecondsSinceEpoch}',
      },
      'USD': {
        'accountName': 'LazerVault Inc',
        'accountNumber': '987654321',
        'routingNumber': '021000021',
        'bankName': 'Chase Bank',
        'swift': 'CHASUS33',
        'reference': 'LV${DateTime.now().millisecondsSinceEpoch}',
      },
      'EUR': {
        'accountName': 'LazerVault SARL',
        'accountNumber': '1234567890',
        'iban': 'FR14 2004 1010 0505 0001 3M02 606',
        'bankName': 'BNP Paribas',
        'swift': 'BNPAFRPP',
        'reference': 'LV${DateTime.now().millisecondsSinceEpoch}',
      },
      'JPY': {
        'accountName': 'LazerVault KK',
        'accountNumber': '1234567',
        'bankName': 'Mitsubishi UFJ Bank',
        'swift': 'BOTKJPJT',
        'reference': 'LV${DateTime.now().millisecondsSinceEpoch}',
      },
      'CAD': {
        'accountName': 'LazerVault Corp',
        'accountNumber': '123456789',
        'transitNumber': '12345',
        'bankName': 'Royal Bank of Canada',
        'swift': 'ROYCCAT2',
        'reference': 'LV${DateTime.now().millisecondsSinceEpoch}',
      },
    }[widget.currencyCode] ?? {};
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    
    // Pre-fill reference
    _referenceController.text = _depositDetails['reference'] ?? '';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _amountController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _sortCodeController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _getCurrencyData(String code) {
    const currencies = {
      'GBP': {'name': 'British Pound', 'symbol': '£', 'flag': 'https://flagcdn.com/w320/gb.png'},
      'USD': {'name': 'US Dollar', 'symbol': '\$', 'flag': 'https://flagcdn.com/w320/us.png'},
      'EUR': {'name': 'Euro', 'symbol': '€', 'flag': 'https://flagcdn.com/w320/eu.png'},
      'JPY': {'name': 'Japanese Yen', 'symbol': '¥', 'flag': 'https://flagcdn.com/w320/jp.png'},
      'CAD': {'name': 'Canadian Dollar', 'symbol': 'C\$', 'flag': 'https://flagcdn.com/w320/ca.png'},
    };
    return currencies[code] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    final currency = _getCurrencyData(widget.currencyCode);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(currency),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCurrencyInfo(currency),
                        SizedBox(height: 24.h),
                        _buildDepositMethods(),
                        SizedBox(height: 24.h),
                        _buildAmountInput(currency),
                        SizedBox(height: 24.h),
                        _buildBankDetails(),
                        SizedBox(height: 24.h),
                        _buildDepositInstructions(),
                        SizedBox(height: 32.h),
                        _buildConfirmButton(),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> currency) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Deposit ${widget.currencyCode}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyInfo(Map<String, dynamic> currency) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.2),
            Colors.purple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: currency['flag'] ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.flag, size: 20.sp, color: Colors.grey[600]),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.flag, size: 20.sp, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currency['name'] ?? widget.currencyCode,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Add funds to your ${widget.currencyCode} wallet',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deposit Method',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        _buildMethodOption(
          'bank_transfer',
          'Bank Transfer',
          'Transfer from your bank account',
          Icons.account_balance,
        ),
        SizedBox(height: 8.h),
        _buildMethodOption(
          'debit_card',
          'Debit Card',
          'Instant deposit with your card',
          Icons.credit_card,
        ),
      ],
    );
  }

  Widget _buildMethodOption(String value, String title, String subtitle, IconData icon) {
    final isSelected = _selectedDepositMethod == value;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedDepositMethod = value),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isSelected 
                ? Colors.blue.withValues(alpha: 0.2) 
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected 
                  ? Colors.blue.withValues(alpha: 0.5) 
                  : Colors.white.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Colors.blue.withValues(alpha: 0.3) 
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.blue : Colors.white.withValues(alpha: 0.7),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 20.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput(Map<String, dynamic> currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount to Deposit',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            children: [
              Text(
                currency['symbol'] ?? widget.currencyCode,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildQuickAmount('100'),
            SizedBox(width: 8.w),
            _buildQuickAmount('500'),
            SizedBox(width: 8.w),
            _buildQuickAmount('1000'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAmount(String amount) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _amountController.text = amount,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            amount,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBankDetails() {
    if (_selectedDepositMethod != 'bank_transfer') return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Transfer Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
          ),
          child: Column(
            children: [
              _buildDetailRow('Account Name', _depositDetails['accountName'] ?? ''),
              _buildDetailRow('Account Number', _depositDetails['accountNumber'] ?? ''),
              if (_depositDetails['sortCode'] != null)
                _buildDetailRow('Sort Code', _depositDetails['sortCode']),
              if (_depositDetails['routingNumber'] != null)
                _buildDetailRow('Routing Number', _depositDetails['routingNumber']),
              if (_depositDetails['iban'] != null)
                _buildDetailRow('IBAN', _depositDetails['iban']),
              _buildDetailRow('Bank Name', _depositDetails['bankName'] ?? ''),
              _buildDetailRow('SWIFT/BIC', _depositDetails['swift'] ?? ''),
              _buildDetailRow('Reference', _depositDetails['reference'] ?? '', isReference: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isReference = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  color: isReference ? Colors.orange : Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _copyToClipboard(value),
                  borderRadius: BorderRadius.circular(4.r),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.copy,
                      color: Colors.blue,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepositInstructions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Important Instructions',
                style: GoogleFonts.inter(
                  color: Colors.orange,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '• Use the exact reference code provided\n'
            '• Transfers typically take 1-3 business days\n'
            '• Ensure the amount matches what you entered\n'
            '• Contact support if your deposit doesn\'t appear within 3 days',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _confirmDeposit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            _isProcessing ? 'Processing...' : 'Confirm Deposit Instructions',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    // In a real app, you'd use Clipboard.setData
    Get.snackbar(
      'Copied',
      'Copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  void _confirmDeposit() {
    if (_amountController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter an amount',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => _isProcessing = true);

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        
        Get.snackbar(
          'Deposit Instructions Sent',
          'Check your email for complete deposit instructions',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Navigate back and show success
        Navigator.of(context).pop();
        
        Future.delayed(const Duration(milliseconds: 500), () {
          _showDepositSuccessDialog();
        });
      }
    });
  }

  void _showDepositSuccessDialog() {
    final currency = _getCurrencyData(widget.currencyCode);
    
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Deposit Instructions Ready',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your ${currency['symbol']}${_amountController.text} ${widget.currencyCode} deposit instructions have been prepared.',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Reference: ${_depositDetails['reference']}',
                style: GoogleFonts.inter(
                  color: Colors.blue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Got it',
              style: GoogleFonts.inter(
                color: Colors.blue,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 