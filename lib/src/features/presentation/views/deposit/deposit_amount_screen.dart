import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';

class DepositAmountScreen extends StatefulWidget {
  const DepositAmountScreen({super.key});

  @override
  State<DepositAmountScreen> createState() => _DepositAmountScreenState();
}

class _DepositAmountScreenState extends State<DepositAmountScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _amountController = TextEditingController();
  Map<String, dynamic> _currency = {};
  Map<String, dynamic> _paymentMethod = {};
  bool _isAmountValid = false;
  double _enteredAmount = 0.0;
  String _validationMessage = '';

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
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    setState(() {
      _enteredAmount = double.tryParse(value) ?? 0.0;
      _validateAmount();
    });
  }

  void _validateAmount() {
    _validationMessage = '';
    _isAmountValid = false;

    if (_enteredAmount <= 0) {
      _validationMessage = 'Amount must be greater than 0';
      return;
    }

    final paymentType = _paymentMethod['type'] ?? '';
    
    // Validate based on payment method type
    switch (paymentType) {
      case 'local_account':
        _validateLocalAccountTransfer();
        break;
      case 'crypto':
        _validateCryptoDeposit();
        break;
      case 'digital_wallet':
      case 'bank_transfer':
        _validateRegularDeposit();
        break;
      default:
        _validateRegularDeposit();
    }
  }

  void _validateLocalAccountTransfer() {
    final sourceAccount = _paymentMethod['sourceAccount'];
    if (sourceAccount != null) {
      final availableBalance = sourceAccount['balance'] ?? 0.0;
      
      if (_enteredAmount > availableBalance) {
        _validationMessage = 'Insufficient balance in source account';
        return;
      }
      
      // Check minimum transfer amount
      if (_enteredAmount < 1.0) {
        _validationMessage = 'Minimum transfer amount is £1.00';
        return;
      }
      
      // Check maximum transfer amount (daily limit)
      if (_enteredAmount > 50000.0) {
        _validationMessage = 'Maximum daily transfer limit is £50,000';
        return;
      }
    }
    
    _isAmountValid = true;
  }

  void _validateCryptoDeposit() {
    final minAmount = _paymentMethod['minAmount'] ?? 0.0;
    final maxAmount = _paymentMethod['maxAmount'] ?? double.infinity;
    
    if (_enteredAmount < minAmount) {
      _validationMessage = 'Minimum amount is ${minAmount.toStringAsFixed(4)} ${_paymentMethod['name']?.split(' ')[0] ?? ''}';
      return;
    }
    
    if (_enteredAmount > maxAmount) {
      _validationMessage = 'Maximum amount is ${maxAmount.toStringAsFixed(2)} ${_paymentMethod['name']?.split(' ')[0] ?? ''}';
      return;
    }
    
    _isAmountValid = true;
  }

  void _validateRegularDeposit() {
    // Standard validation for digital wallets and bank transfers
    if (_enteredAmount < 5.0) {
      _validationMessage = 'Minimum deposit amount is £5.00';
      return;
    }
    
    if (_enteredAmount > 100000.0) {
      _validationMessage = 'Maximum deposit amount is £100,000';
      return;
    }
    
    _isAmountValid = true;
  }

  void _setQuickAmount(String amount) {
    _amountController.text = amount;
    _onAmountChanged(amount);
  }

  void _proceedToReview() {
    if (!_isAmountValid) return;
    
    Get.toNamed(
      AppRoutes.depositReview,
      arguments: {
        'currency': _currency,
        'paymentMethod': _paymentMethod,
        'amount': _enteredAmount,
      },
    );
  }

  // Get appropriate quick amounts based on payment method
  List<String> get _quickAmounts {
    final paymentType = _paymentMethod['type'] ?? '';
    
    switch (paymentType) {
      case 'local_account':
        final sourceAccount = _paymentMethod['sourceAccount'];
        final balance = sourceAccount?['balance'] ?? 0.0;
        return [
          '100',
          '500', 
          '1000',
          (balance * 0.5).toStringAsFixed(0), // 50% of balance
        ];
      case 'crypto':
        final minAmount = _paymentMethod['minAmount'] ?? 0.0;
        return [
          minAmount.toString(),
          (minAmount * 10).toString(),
          (minAmount * 50).toString(),
          (minAmount * 100).toString(),
        ];
      default:
        return ['50', '100', '500', '1000'];
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
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCurrencyInfo(),
                          SizedBox(height: 32.h),
                          _buildAmountInput(),
                          if (_validationMessage.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            _buildValidationMessage(),
                          ],
                          SizedBox(height: 24.h),
                          _buildQuickAmounts(),
                          SizedBox(height: 32.h),
                          _buildPaymentMethodInfo(),
                          if (_paymentMethod['type'] == 'local_account') ...[
                            SizedBox(height: 24.h),
                            _buildSourceAccountInfo(),
                          ],
                          if (_paymentMethod['type'] == 'crypto') ...[
                            SizedBox(height: 24.h),
                            _buildCryptoInfo(),
                          ],
                          SizedBox(height: 40.h),
                          _buildContinueButton(),
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
                  'Deposit Amount',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Enter the amount to deposit',
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

  Widget _buildCurrencyInfo() {
    return Container(
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
      child: Row(
        children: [
          _buildCurrencyFlag(_currency['code'] ?? '', size: 40),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_currency['code']} Wallet',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
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
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deposit Amount',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
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
              Text(
                _currency['symbol'] ?? '',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 32.sp,
                    ),
                  ),
                  onChanged: _onAmountChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amounts',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                  ),
                  child: Text(
                    '${_currency['symbol']}$amount',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.blue[500]!],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _paymentMethod['icon'] ?? Icons.payment,
              color: Colors.white,
              size: 20.sp,
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Fee: ${_paymentMethod['fee'] ?? 'Free'} • ${_paymentMethod['processingTime'] ?? 'Instant'}',
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
    );
  }

  Widget _buildContinueButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: _isAmountValid
            ? LinearGradient(colors: [Colors.green[700]!, Colors.green[500]!])
            : null,
        color: _isAmountValid ? null : Colors.grey[800],
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: _isAmountValid ? [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ] : null,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isAmountValid ? _proceedToReview : null,
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
                'Continue to Review',
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

  Widget _buildValidationMessage() {
    return Text(
      _validationMessage,
      style: GoogleFonts.inter(
        color: Colors.red,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSourceAccountInfo() {
    final sourceAccount = _paymentMethod['sourceAccount'];
    if (sourceAccount == null) return const SizedBox.shrink();
    
    final isUp = sourceAccount['isUp'] ?? true;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.withValues(alpha: 0.15),
            Colors.orange.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.orange,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Source Account',
                style: GoogleFonts.inter(
                  color: Colors.orange,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
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
                    SizedBox(height: 4.h),
                    Text(
                      'Available: £${sourceAccount['balance'].toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isUp
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  sourceAccount['trend'],
                  style: GoogleFonts.inter(
                    color: isUp ? Colors.green[300] : Colors.red[300],
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Funds will be transferred instantly from your ${sourceAccount['accountType']}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 11.sp,
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

  Widget _buildCryptoInfo() {
    final cryptoName = _paymentMethod['name'] ?? '';
    final network = _paymentMethod['network'] ?? '';
    final minAmount = _paymentMethod['minAmount'] ?? 0.0;
    final maxAmount = _paymentMethod['maxAmount'] ?? 0.0;
    final fee = _paymentMethod['fee'] ?? '0%';
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withValues(alpha: 0.15),
            Colors.purple.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.currency_bitcoin,
                color: Colors.purple,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Crypto Deposit Info',
                style: GoogleFonts.inter(
                  color: Colors.purple,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildCryptoInfoRow('Currency', cryptoName),
          SizedBox(height: 8.h),
          _buildCryptoInfoRow('Network', network),
          SizedBox(height: 8.h),
          _buildCryptoInfoRow('Min Amount', '${minAmount.toStringAsFixed(4)} ${cryptoName.split(' ')[0]}'),
          SizedBox(height: 8.h),
          _buildCryptoInfoRow('Max Amount', '${maxAmount.toStringAsFixed(2)} ${cryptoName.split(' ')[0]}'),
          SizedBox(height: 8.h),
          _buildCryptoInfoRow('Network Fee', fee),
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
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.amber,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Crypto deposits are irreversible. Please double-check the amount and network.',
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

  Widget _buildCryptoInfoRow(String label, String value) {
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
} 