import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import 'crypto_confirmation_screen.dart';

class BuyCryptoScreen extends StatefulWidget {
  final Crypto? selectedCrypto;

  const BuyCryptoScreen({super.key, this.selectedCrypto});

  @override
  State<BuyCryptoScreen> createState() => _BuyCryptoScreenState();
}

class _BuyCryptoScreenState extends State<BuyCryptoScreen>
    with TickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  Crypto? _selectedCrypto;
  String _selectedPaymentMethod = 'Card';
  bool _isAmountInCrypto = false;
  bool _isLoading = false;
  
  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Card', 'icon': Icons.credit_card, 'subtitle': 'Instant purchase'},
    {'name': 'Bank Transfer', 'icon': Icons.account_balance, 'subtitle': '1-2 business days'},
    {'name': 'Apple Pay', 'icon': Icons.apple, 'subtitle': 'Quick & secure'},
    {'name': 'Google Pay', 'icon': Icons.account_balance_wallet, 'subtitle': 'One-tap payment'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCrypto = widget.selectedCrypto;
    _amountController.addListener(_onAmountChanged);
    _setupAnimations();
    
    // Load cryptocurrencies if not already loaded
    context.read<CryptoCubit>().loadCryptos();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    setState(() {});
  }

  double get _gbpAmount {
    if (_amountController.text.isEmpty) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto && _selectedCrypto != null) {
      return amount * _selectedCrypto!.currentPrice;
    }
    return amount;
  }

  double get _cryptoAmount {
    if (_amountController.text.isEmpty || _selectedCrypto == null) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto) {
      return amount;
    }
    return amount / _selectedCrypto!.currentPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCryptoSelector(),
                          SizedBox(height: 24.h),
                          _buildAmountInput(),
                          SizedBox(height: 24.h),
                          if (_selectedCrypto != null && _amountController.text.isNotEmpty)
                            _buildOrderSummary(),
                          if (_selectedCrypto != null && _amountController.text.isNotEmpty)
                            SizedBox(height: 24.h),
                          _buildPaymentMethods(),
                          SizedBox(height: 24.h),
                          _buildLegalDisclaimer(),
                          SizedBox(height: 32.h),
                          _buildBuyButton(),
                          SizedBox(height: 20.h),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
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
                  'Buy Crypto',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Purchase cryptocurrency instantly',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.green,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoSelector() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E2746),
            const Color(0xFF2A3A5C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.currency_bitcoin,
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Select Cryptocurrency',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: _showCryptoSearchBottomSheet,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0E27),
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
                  if (_selectedCrypto != null) ...[
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.orange.withValues(alpha: 0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Icons.currency_bitcoin,
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
                            _selectedCrypto!.name,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _selectedCrypto!.symbol.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '£${_selectedCrypto!.currentPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              _selectedCrypto!.priceChangePercentage24h >= 0 
                                ? Icons.arrow_upward 
                                : Icons.arrow_downward,
                              color: _selectedCrypto!.priceChangePercentage24h >= 0 
                                ? Colors.green 
                                : Colors.red,
                              size: 12.sp,
                            ),
                            Text(
                              '${_selectedCrypto!.priceChangePercentage24h.abs().toStringAsFixed(2)}%',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: _selectedCrypto!.priceChangePercentage24h >= 0 
                                  ? Colors.green 
                                  : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    Icon(
                      Icons.search,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Choose cryptocurrency to buy',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xFF6C5CE7),
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E2746),
            const Color(0xFF2A3A5C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: const Color(0xFF6C5CE7),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Amount',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (_selectedCrypto != null)
                GestureDetector(
                  onTap: () => setState(() => _isAmountInCrypto = !_isAmountInCrypto),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                        ],
                      ),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.swap_horiz,
                          color: const Color(0xFF6C5CE7),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _isAmountInCrypto ? 'GBP' : 'Crypto',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFF6C5CE7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0E27),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _isAmountInCrypto ? (_selectedCrypto?.symbol.toUpperCase() ?? '') : '£',
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6C5CE7),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_selectedCrypto != null && _amountController.text.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    _isAmountInCrypto 
                      ? '≈ £${_gbpAmount.toStringAsFixed(2)}'
                      : '≈ ${_cryptoAmount.toStringAsFixed(6)} ${_selectedCrypto!.symbol.toUpperCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildQuickAmountButton('£25', 25),
              SizedBox(width: 8.w),
              _buildQuickAmountButton('£50', 50),
              SizedBox(width: 8.w),
              _buildQuickAmountButton('£100', 100),
              SizedBox(width: 8.w),
              _buildQuickAmountButton('£500', 500),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButton(String label, double amount) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isAmountInCrypto = false;
            _amountController.text = amount.toString();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                const Color(0xFF6C5CE7).withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6C5CE7),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final fee = _gbpAmount * 0.015; // 1.5% fee
    final networkFee = fee * 0.3;
    final tradingFee = fee * 0.7;
    final total = _gbpAmount + fee;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.1),
            const Color(0xFF1E2746),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: Colors.green,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Order Summary',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('You pay', '£${_gbpAmount.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Network fee', '£${networkFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Trading fee', '£${tradingFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('You receive', '${_cryptoAmount.toStringAsFixed(6)} ${_selectedCrypto!.symbol.toUpperCase()}'),
          SizedBox(height: 12.h),
          Container(
            height: 1.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow('Total', '£${total.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.white.withValues(alpha: isTotal ? 1.0 : 0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: isTotal ? Colors.green : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E2746),
            const Color(0xFF2A3A5C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.payment,
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Payment Method',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ..._paymentMethods.map((method) => _buildPaymentMethodOption(method)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == method['name'];
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () => setState(() => _selectedPaymentMethod = method['name']),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: isSelected 
              ? LinearGradient(
                  colors: [
                    const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                    const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  ],
                )
              : null,
            color: isSelected ? null : const Color(0xFF0A0E27),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF6C5CE7) : Colors.white.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: isSelected 
                    ? const Color(0xFF6C5CE7).withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  method['icon'],
                  color: isSelected ? const Color(0xFF6C5CE7) : Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method['name'],
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      method['subtitle'],
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegalDisclaimer() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withValues(alpha: 0.1),
            Colors.orange.withValues(alpha: 0.05),
          ],
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Cryptocurrency investments are subject to high market risk. Please invest responsibly and only what you can afford to lose.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.8),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyButton() {
    final isEnabled = _selectedCrypto != null && 
                     _amountController.text.isNotEmpty && 
                     (double.tryParse(_amountController.text) ?? 0.0) > 0;

    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: isEnabled ? _processBuyOrder : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: isEnabled 
                ? LinearGradient(
                    colors: [
                      const Color(0xFF6C5CE7),
                      const Color(0xFF8B7CF6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Colors.grey.withValues(alpha: 0.3),
                      Colors.grey.withValues(alpha: 0.1),
                    ],
                  ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: isEnabled ? [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ] : null,
            ),
            child: _isLoading
              ? Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Buy ${_selectedCrypto?.symbol.toUpperCase() ?? 'Crypto'}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  void _showCryptoSearchBottomSheet() {
    final cryptoCubit = context.read<CryptoCubit>(); // Capture cubit before showing bottom sheet
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: cryptoCubit, // Use the captured cubit instance
        child: Container(
          height: Get.height * 0.85,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A3E),
                const Color(0xFF0A0E27),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Select Cryptocurrency',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search cryptocurrencies...',
                    hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.5)),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)),
                    filled: true,
                    fillColor: const Color(0xFF1E2746),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    cryptoCubit.searchCryptos(value); // Use captured cubit directly
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<CryptoCubit, CryptoState>(
                  builder: (context, state) {
                    if (state is CryptoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CryptosLoaded) {
                      final cryptos = _searchController.text.isEmpty 
                        ? state.cryptos.take(20).toList()
                        : state.cryptos.where((crypto) => 
                            crypto.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                            crypto.symbol.toLowerCase().contains(_searchController.text.toLowerCase())
                          ).toList();
                          
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: cryptos.length,
                        itemBuilder: (context, index) {
                          final crypto = cryptos[index];
                          return _buildCryptoSearchItem(crypto);
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Failed to load cryptocurrencies',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCryptoSearchItem(Crypto crypto) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCrypto = crypto;
        });
        _searchController.clear();
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2746),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.currency_bitcoin,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crypto.name,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    crypto.symbol.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '£${crypto.currentPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      crypto.priceChangePercentage24h >= 0 
                        ? Icons.arrow_upward 
                        : Icons.arrow_downward,
                      color: crypto.priceChangePercentage24h >= 0 
                        ? Colors.green 
                        : Colors.red,
                      size: 12.sp,
                    ),
                    Text(
                      '${crypto.priceChangePercentage24h.abs().toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: crypto.priceChangePercentage24h >= 0 
                          ? Colors.green 
                          : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _processBuyOrder() {
    if (_selectedCrypto == null || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate processing delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      // Create transaction details
      final fee = _gbpAmount * 0.015; // 1.5% fee
      final total = _gbpAmount + fee;
      
      final transactionDetails = CryptoTransactionDetails(
        type: CryptoTransactionType.buy,
        cryptoName: _selectedCrypto!.name,
        cryptoSymbol: _selectedCrypto!.symbol,
        cryptoAmount: _cryptoAmount.toStringAsFixed(6),
        pricePerUnit: _selectedCrypto!.currentPrice,
        gbpAmount: _gbpAmount,
        networkFee: fee * 0.3, // 30% of total fee for network
        tradingFee: fee * 0.7, // 70% of total fee for LazerVault
        totalAmount: total,
        paymentMethod: _selectedPaymentMethod,
      );

      // Navigate to confirmation screen
      Get.to(() => CryptoConfirmationScreen(transactionDetails: transactionDetails));
    });
  }
} 