import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';

class InternationalTransferAmountScreen extends StatefulWidget {
  const InternationalTransferAmountScreen({super.key});

  @override
  State<InternationalTransferAmountScreen> createState() =>
      _InternationalTransferAmountScreenState();
}

class _InternationalTransferAmountScreenState extends State<InternationalTransferAmountScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _convertedAmountController = TextEditingController();
  
  String _fromCurrency = '';
  String _toCurrency = '';
  Map<String, dynamic> _fromCurrencyData = {};
  Map<String, dynamic> _toCurrencyData = {};
  
  bool _isAmountValid = false;
  double _exchangeRate = 0.0;
  double _fees = 0.0;
  
  final List<String> _quickAmounts = ['100', '500', '1000', '2000', '5000'];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>;
    _fromCurrency = args['fromCurrency'] ?? 'GBP';
    _toCurrency = args['toCurrency'] ?? 'USD';
    _fromCurrencyData = args['fromCurrencyData'] ?? {};
    _toCurrencyData = args['toCurrencyData'] ?? {};
    
    _exchangeRate = (_toCurrencyData['rate'] ?? 1.0) / (_fromCurrencyData['rate'] ?? 1.0);
    
    // Pre-fill amount if suggested
    final suggestedAmount = args['suggestedAmount'];
    if (suggestedAmount != null) {
      _amountController.text = suggestedAmount.toString();
      _convertCurrency();
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _amountController.dispose();
    _convertedAmountController.dispose();
    super.dispose();
  }

  void _convertCurrency() {
    if (_amountController.text.isEmpty) {
      setState(() {
        _convertedAmountController.clear();
        _isAmountValid = false;
        _fees = 0.0;
      });
      return;
    }

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0) {
      setState(() {
        _convertedAmountController.clear();
        _isAmountValid = false;
        _fees = 0.0;
      });
      return;
    }

    // Check if amount exceeds available balance
    final availableBalance = _fromCurrencyData['balance'] ?? 0.0;
    if (amount > availableBalance) {
      setState(() {
        _isAmountValid = false;
      });
      return;
    }

    final convertedAmount = amount * _exchangeRate;
    _fees = _calculateFees(amount);
    
    setState(() {
      _convertedAmountController.text = convertedAmount.toStringAsFixed(2);
      _isAmountValid = true;
    });
  }

  double _calculateFees(double amount) {
    // Mock fee calculation - typically 0.5% with minimum fee
    const feePercentage = 0.005;
    const minimumFee = 2.0;
    final calculatedFee = amount * feePercentage;
    return calculatedFee < minimumFee ? minimumFee : calculatedFee;
  }

  void _setQuickAmount(String amount) {
    _amountController.text = amount;
    _convertCurrency();
  }

  void _proceedToRecipient() {
    if (!_isAmountValid) return;
    
    final args = Get.arguments as Map<String, dynamic>;
    final skipRecipientSelection = args['skipRecipientSelection'] ?? false;
    final preSelectedRecipient = args['preSelectedRecipient'];
    final totalSteps = args['totalSteps'] ?? 4;
    
    if (skipRecipientSelection && preSelectedRecipient != null) {
      // Skip to review screen with pre-selected recipient
      // This is step 3/3 when coming from previous recipient
      Get.toNamed(
        AppRoutes.internationalTransferReview,
        arguments: {
          'fromCurrency': _fromCurrency,
          'toCurrency': _toCurrency,
          'fromCurrencyData': _fromCurrencyData,
          'toCurrencyData': _toCurrencyData,
          'amount': double.parse(_amountController.text),
          'convertedAmount': double.parse(_convertedAmountController.text),
          'exchangeRate': _exchangeRate,
          'fees': _fees,
          'recipient': preSelectedRecipient,
          'currentStep': 3,
          'totalSteps': 3,
          'stepTitle': 'Review & Confirm',
        },
      );
    } else {
      // Go to recipient selection screen (page 3 of 4)
      Get.toNamed(
        AppRoutes.internationalTransferRecipient,
        arguments: {
          'fromCurrency': _fromCurrency,
          'toCurrency': _toCurrency,
          'fromCurrencyData': _fromCurrencyData,
          'toCurrencyData': _toCurrencyData,
          'amount': double.parse(_amountController.text),
          'convertedAmount': double.parse(_convertedAmountController.text),
          'exchangeRate': _exchangeRate,
          'fees': _fees,
          'currentStep': 3,
          'totalSteps': totalSteps,
          'stepTitle': 'Select Recipient',
        },
      );
    }
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
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              SizedBox(height: 24.h),
                              _buildCurrencyPairDisplay(),
                              SizedBox(height: 32.h),
                              _buildAmountInput(),
                              SizedBox(height: 24.h),
                              _buildQuickAmountButtons(),
                              SizedBox(height: 32.h),
                              _buildConversionDisplay(),
                              SizedBox(height: 24.h),
                              _buildFeesBreakdown(),
                              SizedBox(height: 40.h),
                              _buildContinueButton(),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      );
                    },
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
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final currentStep = args['currentStep'] ?? 2;
    final totalSteps = args['totalSteps'] ?? 4;
    final stepTitle = args['stepTitle'] ?? 'Enter Amount';
    
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stepTitle,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Step $currentStep of $totalSteps - How much to send?',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Progress indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '$currentStep/$totalSteps',
              style: GoogleFonts.inter(
                color: Colors.blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyPairDisplay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.15),
            Colors.purple.withValues(alpha: 0.15),
          ],
        ),
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
        children: [
          Text(
            'Exchange Rate',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCurrencyFlag(_fromCurrency, size: 32),
              SizedBox(width: 12.w),
              Text(
                _fromCurrency,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.7), size: 24.sp),
              SizedBox(width: 16.w),
              _buildCurrencyFlag(_toCurrency, size: 32),
              SizedBox(width: 12.w),
              Text(
                _toCurrency,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '1 $_fromCurrency = ${_exchangeRate.toStringAsFixed(4)} $_toCurrency',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.green, size: 8.sp),
              SizedBox(width: 4.w),
              Text(
                'Live rate • Updates every 30 seconds',
                style: GoogleFonts.inter(
                  color: Colors.green,
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

  Widget _buildAmountInput() {
    final availableBalance = _fromCurrencyData['balance'] ?? 0.0;
    final symbol = _fromCurrencyData['symbol'] ?? _fromCurrency;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You Send',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Available: $symbol${availableBalance.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
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
                _buildCurrencyFlag(_fromCurrency, size: 24),
                SizedBox(width: 12.w),
                Text(
                  symbol,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0.00',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 24.sp,
                      ),
                    ),
                    onChanged: (_) => _convertCurrency(),
                  ),
                ),
              ],
            ),
          ),
          if (_amountController.text.isNotEmpty && !_isAmountValid)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Insufficient balance or invalid amount',
                style: GoogleFonts.inter(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Amounts',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: _quickAmounts.map((amount) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _setQuickAmount(amount),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                    ),
                    child: Text(
                      '${_fromCurrencyData['symbol']}$amount',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionDisplay() {
    if (_convertedAmountController.text.isEmpty) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withValues(alpha: 0.15),
            Colors.blue.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recipient Receives',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14.sp,
                ),
              ),
              Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildCurrencyFlag(_toCurrency, size: 28),
              SizedBox(width: 12.w),
              Text(
                _toCurrencyData['symbol'] ?? _toCurrency,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  _convertedAmountController.text,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Estimated arrival: Within 1-3 business days',
            style: GoogleFonts.inter(
              color: Colors.green,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeesBreakdown() {
    if (!_isAmountValid) return const SizedBox.shrink();
    
    final amount = double.parse(_amountController.text);
    final totalDeducted = amount + _fees;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
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
            'Transaction Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildFeeRow('Amount to send', '${_fromCurrencyData['symbol']}${amount.toStringAsFixed(2)}'),
          _buildFeeRow('Transfer fee', '${_fromCurrencyData['symbol']}${_fees.toStringAsFixed(2)}'),
          Divider(color: Colors.white.withValues(alpha: 0.2), height: 24.h),
          _buildFeeRow(
            'Total deducted', 
            '${_fromCurrencyData['symbol']}${totalDeducted.toStringAsFixed(2)}',
            isTotal: true,
          ),
          SizedBox(height: 8.h),
          Text(
            'Exchange rate: 1 $_fromCurrency = ${_exchangeRate >= 0.01 ? _exchangeRate.toStringAsFixed(4) : _exchangeRate.toStringAsFixed(6)} $_toCurrency',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : Colors.white.withValues(alpha: 0.7),
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: _isAmountValid
              ? LinearGradient(colors: [Colors.blue[700]!, Colors.blue[500]!])
              : null,
          color: _isAmountValid ? null : Colors.grey[800],
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: _isAmountValid ? [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ] : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isAmountValid ? _proceedToRecipient : null,
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
                Text(
                  'Continue to Recipient',
                  style: GoogleFonts.inter(
                    color: _isAmountValid ? Colors.white : Colors.grey[500],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward,
                  color: _isAmountValid ? Colors.white : Colors.grey[500],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    final flagUrl = _fromCurrency == currencyCode 
        ? _fromCurrencyData['flag'] 
        : _toCurrencyData['flag'];
    
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: CachedNetworkImage(
          imageUrl: flagUrl ?? '',
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