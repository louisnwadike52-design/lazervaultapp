import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import 'crypto_confirmation_screen.dart';

class SellCryptoScreen extends StatefulWidget {
  final CryptoHolding? selectedHolding;

  const SellCryptoScreen({super.key, this.selectedHolding});

  @override
  State<SellCryptoScreen> createState() => _SellCryptoScreenState();
}

class _SellCryptoScreenState extends State<SellCryptoScreen>
    with TickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  CryptoHolding? _selectedHolding;
  bool _isAmountInCrypto = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedHolding = widget.selectedHolding;
    _amountController.addListener(_onAmountChanged);
    _setupAnimations();
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

  double get _cryptoAmount {
    if (_amountController.text.isEmpty) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto) {
      return amount;
    }
    return _selectedHolding != null ? amount / _selectedHolding!.currentPrice : 0.0;
  }

  double get _fiatAmount {
    if (_amountController.text.isEmpty || _selectedHolding == null) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto) {
      return amount * _selectedHolding!.currentPrice;
    }
    return amount;
  }

  bool get _hasValidAmount {
    if (_selectedHolding == null) return false;
    return _cryptoAmount > 0 && _cryptoAmount <= _selectedHolding!.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0A0A),
              const Color(0xFF0A0A0A),
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
                          _buildHoldingSelector(),
                          SizedBox(height: 24.h),
                          _buildAmountInput(),
                          SizedBox(height: 24.h),
                          if (_selectedHolding != null && _amountController.text.isNotEmpty && _hasValidAmount)
                            _buildOrderSummary(),
                          if (_selectedHolding != null && _amountController.text.isNotEmpty && _hasValidAmount)
                            SizedBox(height: 24.h),
                          _buildTransactionDetails(),
                          SizedBox(height: 24.h),
                          _buildLegalDisclaimer(),
                          SizedBox(height: 32.h),
                          _buildSellButton(),
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
              color: const Color(0xFF1F1F1F),
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
                  'Sell Crypto',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Convert your crypto to cash',
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
              color: Colors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingSelector() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1F1F1F),
            const Color(0xFF2D2D2D),
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
                Icons.account_balance_wallet,
                color: Colors.red,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Select Holdings to Sell',
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
            onTap: _showHoldingsBottomSheet,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
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
                  if (_selectedHolding != null) ...[
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
                            _selectedHolding!.cryptoName,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Available: ${_selectedHolding!.quantity.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol}',
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
                          '${CurrencySymbols.currentSymbol}${_selectedHolding!.currentPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              _selectedHolding!.totalGainLossPercentage >= 0 
                                ? Icons.arrow_upward 
                                : Icons.arrow_downward,
                              color: _selectedHolding!.totalGainLossPercentage >= 0 
                                ? Colors.green 
                                : Colors.red,
                              size: 12.sp,
                            ),
                            Text(
                              '${_selectedHolding!.totalGainLossPercentage.abs().toStringAsFixed(2)}%',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: _selectedHolding!.totalGainLossPercentage >= 0 
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
                        'Choose holdings to sell',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.red,
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
            const Color(0xFF1F1F1F),
            const Color(0xFF2D2D2D),
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
                    Icons.trending_down,
                    color: Colors.red,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Amount to Sell',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (_selectedHolding != null)
                GestureDetector(
                  onTap: () => setState(() => _isAmountInCrypto = !_isAmountInCrypto),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.withValues(alpha: 0.3),
                          Colors.red.withValues(alpha: 0.1),
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
                          color: Colors.red,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _isAmountInCrypto ? CurrencySymbols.currentCurrency : 'Crypto',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.red,
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
              color: const Color(0xFF0A0A0A),
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
                      _isAmountInCrypto ? (_selectedHolding?.cryptoSymbol.toUpperCase() ?? '') : CurrencySymbols.currentSymbol,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
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
                if (_selectedHolding != null && _amountController.text.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    _isAmountInCrypto 
                      ? '≈ ${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'
                      : '≈ ${_cryptoAmount.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol.toUpperCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
                if (!_hasValidAmount && _cryptoAmount > 0) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Insufficient balance. Available: ${_selectedHolding!.quantity.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol.toUpperCase()}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_selectedHolding != null) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildQuickPercentageButton('25%', 0.25),
                SizedBox(width: 8.w),
                _buildQuickPercentageButton('50%', 0.50),
                SizedBox(width: 8.w),
                _buildQuickPercentageButton('75%', 0.75),
                SizedBox(width: 8.w),
                _buildQuickPercentageButton('All', 1.0),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickPercentageButton(String label, double percentage) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_selectedHolding != null) {
            setState(() {
              _isAmountInCrypto = true;
              _amountController.text = (_selectedHolding!.quantity * percentage).toStringAsFixed(6);
            });
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.withValues(alpha: 0.1),
                Colors.red.withValues(alpha: 0.05),
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
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final fee = _fiatAmount * 0.015; // 1.5% fee
    final networkFee = fee * 0.3;
    final tradingFee = fee * 0.7;
    final netProceeds = _fiatAmount - fee;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha: 0.1),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.1),
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
                color: Colors.red,
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
          _buildSummaryRow('You sell', '${_cryptoAmount.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol.toUpperCase()}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Market value', '${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Network fee', '${CurrencySymbols.currentSymbol}${networkFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Trading fee', '${CurrencySymbols.currentSymbol}${tradingFee.toStringAsFixed(2)}'),
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
          _buildSummaryRow('You receive', '${CurrencySymbols.currentSymbol}${netProceeds.toStringAsFixed(2)}', isTotal: true),
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
            color: isTotal ? Colors.red : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1F1F1F),
            const Color(0xFF2D2D2D),
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
                Icons.info_outline,
                color: Colors.blue,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Transaction Details',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Settlement', 'Instant'),
          SizedBox(height: 8.h),
          _buildDetailRow('Funds available', 'Immediately'),
          SizedBox(height: 8.h),
          _buildDetailRow('Transaction type', 'Market sell'),
          SizedBox(height: 8.h),
          _buildDetailRow('Destination', 'LazerVault Balance'),
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
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
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
              'Selling cryptocurrency will convert your holdings to ${CurrencySymbols.currentCurrency}. This action cannot be undone. Market prices are volatile and may change rapidly.',
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

  Widget _buildSellButton() {
    final isEnabled = _selectedHolding != null && _hasValidAmount;

    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: isEnabled ? _processSellOrder : null,
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
                      Colors.red,
                      Colors.red.withValues(alpha: 0.8),
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
                  color: Colors.red.withValues(alpha: 0.3),
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
                      Icons.remove_circle_outline,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Sell ${_selectedHolding?.cryptoSymbol.toUpperCase() ?? 'Crypto'}',
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

  void _showHoldingsBottomSheet() {
    final cubitState = context.read<CryptoCubit>().state;
    final holdings = cubitState is CryptosLoaded ? cubitState.holdings : <CryptoHolding>[];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0A0A),
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
                      'Your Holdings',
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
                  hintText: 'Search your holdings...',
                  hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.5)),
                  prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: holdings.length,
                itemBuilder: (context, index) {
                  final holding = holdings[index];
                  return _buildHoldingItem(holding);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldingItem(CryptoHolding holding) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHolding = holding;
        });
        _searchController.clear();
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
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
                    holding.cryptoName,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${holding.quantity.toStringAsFixed(6)} ${holding.cryptoSymbol.toUpperCase()}',
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
                  '${CurrencySymbols.currentSymbol}${holding.totalValue.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      holding.totalGainLossPercentage >= 0 
                        ? Icons.arrow_upward 
                        : Icons.arrow_downward,
                      color: holding.totalGainLossPercentage >= 0 
                        ? Colors.green 
                        : Colors.red,
                      size: 12.sp,
                    ),
                    Text(
                      '${holding.totalGainLossPercentage.abs().toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: holding.totalGainLossPercentage >= 0 
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

  void _processSellOrder() {
    if (_selectedHolding == null || !_hasValidAmount) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate processing delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      // Create transaction details
      final fee = _fiatAmount * 0.015; // 1.5% fee
      final netProceeds = _fiatAmount - fee;
      
      final transactionDetails = CryptoTransactionDetails(
        type: CryptoTransactionType.sell,
        cryptoName: _selectedHolding!.cryptoName,
        cryptoSymbol: _selectedHolding!.cryptoSymbol,
        cryptoAmount: _cryptoAmount.toStringAsFixed(6),
        pricePerUnit: _selectedHolding!.currentPrice,
        fiatAmount: netProceeds,
        networkFee: fee * 0.3, // 30% of total fee for network
        tradingFee: fee * 0.7, // 70% of total fee for LazerVault
        totalAmount: netProceeds,
        paymentMethod: 'Bank Transfer', // Default for sells
      );

      // Navigate to confirmation screen
      Get.to(() => CryptoConfirmationScreen(transactionDetails: transactionDetails));
    });
  }
} 