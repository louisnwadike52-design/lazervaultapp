import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';

class DepositReviewScreen extends StatefulWidget {
  const DepositReviewScreen({super.key});

  @override
  State<DepositReviewScreen> createState() => _DepositReviewScreenState();
}

class _DepositReviewScreenState extends State<DepositReviewScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  Map<String, dynamic> _currency = {};
  Map<String, dynamic> _paymentMethod = {};
  double _amount = 0.0;
  bool _isProcessing = false;
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>;
    _currency = args['currency'] ?? {};
    _paymentMethod = args['paymentMethod'] ?? {};
    _amount = args['amount'] ?? 0.0;
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _processDeposit() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate processing time based on payment method
      final paymentType = _paymentMethod['type'] ?? '';
      int processingTime = 2; // Default 2 seconds
      
      switch (paymentType) {
        case 'local_account':
          processingTime = 1; // Instant for local transfers
          break;
        case 'crypto':
          processingTime = 3; // Longer for crypto
          break;
        case 'digital_wallet':
          processingTime = 2;
          break;
        case 'bank_transfer':
          processingTime = 4;
          break;
      }

      await Future.delayed(Duration(seconds: processingTime));

      // Process the deposit based on payment method type
      await _executeDeposit();

      setState(() {
        _isProcessing = false;
        _isConfirmed = true;
      });

      // Navigate to success screen after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        Get.offNamed(
          AppRoutes.depositSuccess,
          arguments: {
            'currency': _currency,
            'paymentMethod': _paymentMethod,
            'amount': _amount,
            'transactionId': _generateTransactionId(),
          },
        );
      });

    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      
      Get.snackbar(
        'Deposit Failed',
        'There was an error processing your deposit. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> _executeDeposit() async {
    final paymentType = _paymentMethod['type'] ?? '';
    
    switch (paymentType) {
      case 'local_account':
        await _processLocalAccountTransfer();
        break;
      case 'crypto':
        await _processCryptoDeposit();
        break;
      case 'digital_wallet':
      case 'bank_transfer':
        await _processRegularDeposit();
        break;
    }
  }

  Future<void> _processLocalAccountTransfer() async {
    // Simulate local account transfer
    // In a real app, this would update account balances in the backend
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Update local currency balance (simulated)
    final currentBalance = _currency['balance'] ?? 0.0;
    _currency['balance'] = currentBalance + _amount;
  }

  Future<void> _processCryptoDeposit() async {
    // Simulate crypto deposit processing
    // In a real app, this would generate a crypto address and wait for confirmation
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _processRegularDeposit() async {
    // Simulate regular payment processing
    await Future.delayed(const Duration(milliseconds: 800));
  }

  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final paymentType = _paymentMethod['type'] ?? 'deposit';
    return '${paymentType.toUpperCase()}_${timestamp.toString().substring(8)}';
  }

  double get _totalAmount {
    final fee = _calculateFee();
    return _amount + fee;
  }

  double _calculateFee() {
    final feeString = _paymentMethod['fee'] ?? 'Free';
    if (feeString == 'Free') return 0.0;
    
    // Parse percentage fees (e.g., "0.5%")
    if (feeString.contains('%')) {
      final percentage = double.tryParse(feeString.replaceAll('%', '')) ?? 0.0;
      return _amount * (percentage / 100);
    }
    
    // Parse fixed fees (e.g., "£0.50")
    final fixedFee = double.tryParse(feeString.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    return fixedFee;
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDepositSummary(),
                          SizedBox(height: 24.h),
                          _buildPaymentMethodDetails(),
                          SizedBox(height: 24.h),
                          _buildTransactionBreakdown(),
                          if (_paymentMethod['type'] == 'local_account') ...[
                            SizedBox(height: 24.h),
                            _buildSourceAccountDetails(),
                          ],
                          if (_paymentMethod['type'] == 'crypto') ...[
                            SizedBox(height: 24.h),
                            _buildCryptoDepositDetails(),
                          ],
                          SizedBox(height: 32.h),
                          _buildSecurityNotice(),
                          SizedBox(height: 40.h),
                          _buildConfirmButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
              onPressed: _isProcessing ? null : () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: _isProcessing ? Colors.grey[600] : Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Deposit',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Confirm your deposit details',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositSummary() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.2),
            Colors.purple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
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
          Row(
            children: [
              _buildCurrencyFlag(_currency['code'] ?? '', size: 40),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Depositing to ${_currency['code']} Wallet',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Current Balance: ${_currency['symbol']}${(_currency['balance'] ?? 0.0).toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            '${_currency['symbol']}${_amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 48.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Deposit Amount',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[500]!],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _paymentMethod['icon'] ?? Icons.payment,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _paymentMethod['name'] ?? 'Payment Method',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _paymentMethod['description'] ?? '',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionBreakdown() {
    final fee = _calculateFee();
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBreakdownRow('Deposit Amount', '${_currency['symbol']}${_amount.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildBreakdownRow('Processing Fee', fee > 0 ? '${_currency['symbol']}${fee.toStringAsFixed(2)}' : 'Free'),
          SizedBox(height: 8.h),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          SizedBox(height: 8.h),
          _buildBreakdownRow('Total Amount', '${_currency['symbol']}${_totalAmount.toStringAsFixed(2)}', isTotal: true),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.blue, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'Processing Time: ${_paymentMethod['processingTime'] ?? 'Instant'}',
                style: GoogleFonts.inter(
                  color: Colors.blue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isTotal ? Colors.white : Colors.grey[400],
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSourceAccountDetails() {
    final sourceAccount = _paymentMethod['sourceAccount'];
    if (sourceAccount == null) return const SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.withValues(alpha: 0.15),
            Colors.orange.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.orange, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Source Account',
                style: GoogleFonts.inter(
                  color: Colors.orange,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sourceAccount['accountType'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      sourceAccount['accountNumber'],
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Available Balance',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    '£${sourceAccount['balance'].toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoDepositDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withValues(alpha: 0.15),
            Colors.purple.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.currency_bitcoin, color: Colors.purple, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Crypto Deposit Details',
                style: GoogleFonts.inter(
                  color: Colors.purple,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Network', _paymentMethod['network'] ?? ''),
          SizedBox(height: 8.h),
          _buildDetailRow('Currency', _paymentMethod['name'] ?? ''),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.amber, size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'You will receive a deposit address after confirmation',
                    style: GoogleFonts.inter(
                      color: Colors.amber,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
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
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.security, color: Colors.blue, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your transaction is secured with end-to-end encryption and multi-factor authentication.',
              style: GoogleFonts.inter(
                color: Colors.blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    if (_isConfirmed) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.green[700]!, Colors.green[500]!]),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Deposit Confirmed',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: _isProcessing 
            ? null 
            : LinearGradient(colors: [Colors.green[700]!, Colors.green[500]!]),
        color: _isProcessing ? Colors.grey[800] : null,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: _isProcessing ? null : [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processDeposit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: _isProcessing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Processing...',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm Deposit',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    // Mock flag URLs for currencies
    final flagUrls = {
      'USD': 'https://flagcdn.com/w320/us.png',
      'EUR': 'https://flagcdn.com/w320/eu.png',
      'GBP': 'https://flagcdn.com/w320/gb.png',
      'JPY': 'https://flagcdn.com/w320/jp.png',
      'CAD': 'https://flagcdn.com/w320/ca.png',
      'AUD': 'https://flagcdn.com/w320/au.png',
      'CHF': 'https://flagcdn.com/w320/ch.png',
      'CNY': 'https://flagcdn.com/w320/cn.png',
      'INR': 'https://flagcdn.com/w320/in.png',
    };
    
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: CachedNetworkImage(
          imageUrl: flagUrls[currencyCode] ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
} 