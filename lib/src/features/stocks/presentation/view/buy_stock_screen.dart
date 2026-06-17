import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/stock_entity.dart';
import '../widgets/stock_selector_bottom_sheet.dart';
import '../../../../../core/utils/currency_formatter.dart';

/// Bamboo-style Buy Stock Screen
/// Clean, step-by-step buying flow with amount input, payment method, and review
class BuyStockScreen extends StatefulWidget {
  final Stock? stock;

  const BuyStockScreen({super.key, this.stock});

  @override
  State<BuyStockScreen> createState() => _BuyStockScreenState();
}

class _BuyStockScreenState extends State<BuyStockScreen>
    with SingleTickerProviderStateMixin {
  static const double _kDisplayFeeRate = 0.0025; // ~25 bps; server applies tiers

  late TabController _tabController;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _sharesController = TextEditingController();
  String _selectedPaymentMethod = 'wallet';
  int _currentStep = 0;
  Stock? _selectedStock;

  String _tradeCurrency(Stock? s) {
    final c = s?.currency.trim() ?? '';
    if (c.isEmpty) return 'USD';
    return c.toUpperCase();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedStock = widget.stock;
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _sharesController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    // Calculate shares based on amount
    if (_selectedStock != null && _amountController.text.isNotEmpty) {
      final amount = double.tryParse(_amountController.text) ?? 0;
      final shares = amount / _selectedStock!.currentPrice;
      _sharesController.text = shares.toStringAsFixed(2);
    }
  }

  void _proceedToReview() {
    setState(() => _currentStep = 1);
  }

  void _placeOrder() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final shares = double.tryParse(_sharesController.text) ?? 0;
    if (_selectedStock == null || shares <= 0 || amount <= 0) {
      Get.snackbar('Invalid order', 'Enter amount and select a stock');
      return;
    }
    final fees = amount * _kDisplayFeeRate;
    Get.toNamed(
      AppRoutes.stockTradeReview,
      arguments: {
        'stock': _selectedStock,
        'tradeType': 'buy',
        'amount': amount,
        'shares': shares.ceil(),
        'sharesExact': shares,
        'fees': fees,
        'estimatedTotal': amount + fees,
        'paymentMethod': _selectedPaymentMethod,
        'paymentDetails': <String, dynamic>{},
        'orderType': OrderType.market,
      },
    );
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
              const Color(0xFF1A0A2E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              if (_currentStep == 0)
                _buildAmountStep()
              else
                _buildReviewStep(),
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
          GestureDetector(
            onTap: () {
              if (_currentStep == 1) {
                setState(() => _currentStep = 0);
              } else {
                Get.back();
              }
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _currentStep == 1 ? Icons.arrow_back : Icons.close,
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
                  _currentStep == 0 ? 'Buy Stock' : 'Review Order',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _currentStep == 0
                      ? 'Enter amount to invest'
                      : 'Confirm your purchase',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          if (_currentStep == 1)
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAmountStep() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            _buildFxFundBanner(),
            _buildInputTypeToggle(),
            SizedBox(height: 24.h),
            _buildStockSelector(),
            SizedBox(height: 24.h),
            _buildAmountInput(),
            SizedBox(height: 24.h),
            _buildQuickAmountButtons(),
            SizedBox(height: 24.h),
            _buildPaymentMethodSelector(),
            SizedBox(height: 24.h),
            _buildOrderSummary(),
            SizedBox(height: 32.h),
            _buildProceedButton(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFxFundBanner() {
    final ccy = _tradeCurrency(_selectedStock);
    if (ccy != 'USD') return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'US trades use your USD wallet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Convert NGN→USD in Exchange (platform rates) before buying if needed.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.sp,
              height: 1.35,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => Get.toNamed(
                AppRoutes.exchangeHome,
                arguments: {
                  'fromCurrency': 'NGN',
                  'toCurrency': 'USD',
                },
              ),
              child: Text(
                'Open Exchange',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputTypeToggle() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        labelColor: Colors.white.withValues(alpha: 0.7),
        unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp),
        indicatorPadding: EdgeInsets.all(4.w),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'By Amount'),
          Tab(text: 'By Shares'),
        ],
      ),
    );
  }

  Widget _buildStockSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Stock',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _showStockSelector,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                if (_selectedStock != null) ...[
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withValues(alpha: 0.3),
                          const Color(0xFF4F46E5).withValues(alpha: 0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        _selectedStock!.symbol.substring(0, 2).toUpperCase(),
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6366F1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedStock!.symbol,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _selectedStock!.name,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ] else
                  Expanded(
                    child: Text(
                      'Search for a stock',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _tabController.index == 0 ? 'Amount to Invest' : 'Number of Shares',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Text(
                '₦',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6366F1),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _tabController.index == 0 ? _amountController : _sharesController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_selectedStock != null && _amountController.text.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF6366F1),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'At current price: ₦${_selectedStock!.currentPrice.toStringAsFixed(2)}/share',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6366F1),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuickAmountButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amount',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildQuickAmountButton('₦5,000', 5000),
            SizedBox(width: 8.w),
            _buildQuickAmountButton('₦10,000', 10000),
            SizedBox(width: 8.w),
            _buildQuickAmountButton('₦25,000', 25000),
            SizedBox(width: 8.w),
            _buildQuickAmountButton('₦50,000', 50000),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAmountButton(String label, double amount) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _amountController.text = amount.toString();
          _onAmountChanged();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildPaymentMethod('Wallet', 'wallet', Icons.account_balance_wallet),
            SizedBox(width: 12.w),
            _buildPaymentMethod('Card', 'card', Icons.credit_card),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(String label, String value, IconData icon) {
    final isSelected = _selectedPaymentMethod == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedPaymentMethod = value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6366F1)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF6366F1) : Colors.white.withValues(alpha: 0.5),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected ? const Color(0xFF6366F1) : Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final shares = double.tryParse(_sharesController.text) ?? 0;
    final ccy = _tradeCurrency(_selectedStock);
    final fee = amount * _kDisplayFeeRate;
    final total = amount + fee;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryItem('Stock', _selectedStock?.symbol ?? '-'),
          _buildSummaryItem('Shares', shares.toStringAsFixed(2)),
          _buildSummaryItem('Price', _selectedStock != null
              ? CurrencySymbols.formatAmountWithCurrency(_selectedStock!.currentPrice, ccy)
              : '-'),
          _buildSummaryItem('Subtotal', CurrencySymbols.formatAmountWithCurrency(amount, ccy)),
          _buildSummaryItem('Est. platform fee (~0.25%)',
              CurrencySymbols.formatAmountWithCurrency(fee, ccy)),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          _buildSummaryItem('Total', CurrencySymbols.formatAmountWithCurrency(total, ccy),
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.7),
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: isTotal
                  ? const Color(0xFF6366F1)
                  : Colors.white,
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    final isEnabled = _selectedStock != null &&
        _amountController.text.isNotEmpty &&
        (double.tryParse(_amountController.text) ?? 0) > 0;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? _proceedToReview : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.green : Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Review Order',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewStep() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final shares = double.tryParse(_sharesController.text) ?? 0;
    final fee = amount * _kDisplayFeeRate;
    final total = amount + fee;

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildReviewCard(amount, shares, fee, total),
            SizedBox(height: 16.h),
            _buildFeeDisclosure(),
            SizedBox(height: 32.h),
            _buildConfirmButton(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(double amount, double shares, double fee, double total) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.1),
            Colors.green.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6366F1).withValues(alpha: 0.3),
                      const Color(0xFF4F46E5).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    _selectedStock?.symbol.substring(0, 2).toUpperCase() ?? '??',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6366F1),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
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
                      _selectedStock?.symbol ?? '',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Buy Order',
                      style: GoogleFonts.inter(
                        color: Colors.green,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 16.h),
          _buildReviewItem('Shares to Buy', shares.toStringAsFixed(2)),
          _buildReviewItem(
              'Price per Share',
              CurrencySymbols.formatAmountWithCurrency(
                _selectedStock?.currentPrice ?? 0,
                _tradeCurrency(_selectedStock),
              )),
          _buildReviewItem(
              'Subtotal',
              CurrencySymbols.formatAmountWithCurrency(
                amount,
                _tradeCurrency(_selectedStock),
              )),
          _buildReviewItem(
              'Est. platform fee',
              CurrencySymbols.formatAmountWithCurrency(
                fee,
                _tradeCurrency(_selectedStock),
              )),
          SizedBox(height: 16.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 16.h),
          _buildReviewItem(
              'Total Amount',
              CurrencySymbols.formatAmountWithCurrency(
                total,
                _tradeCurrency(_selectedStock),
              ),
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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
          Text(
            value,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.green : Colors.white,
              fontSize: isTotal ? 18.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeDisclosure() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.orange,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Orders are executed during market hours. You\'ll receive a confirmation when your order is processed.',
              style: GoogleFonts.inter(
                color: Colors.orange.withValues(alpha: 0.9),
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _placeOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Confirm Purchase',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockSelector() async {
    final selectedStock = await showStockSelector(
      context,
      title: 'Select Stock to Buy',
    );

    if (selectedStock != null) {
      setState(() {
        _selectedStock = selectedStock;
      });
      // Clear amount when stock changes
      _amountController.clear();
      _sharesController.clear();
    }
  }
}
