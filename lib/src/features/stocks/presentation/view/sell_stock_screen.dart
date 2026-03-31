import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../../domain/entities/stock_entity.dart';
import '../widgets/stock_selector_bottom_sheet.dart';
import '../../../../../core/utils/currency_formatter.dart';

/// Bamboo-style Sell Stock Screen
/// Clean selling flow with holdings selection and amount input
class SellStockScreen extends StatefulWidget {
  final Stock? stock;

  const SellStockScreen({super.key, this.stock});

  @override
  State<SellStockScreen> createState() => _SellStockScreenState();
}

class _SellStockScreenState extends State<SellStockScreen>
    with SingleTickerProviderStateMixin {
  static const double _kDisplayFeeRate = 0.0025;

  late TabController _tabController;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _sharesController = TextEditingController();
  String _selectedWithdrawMethod = 'wallet';
  int _currentStep = 0;
  Stock? _selectedStock;
  int _availableShares = 0;

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
    _sharesController.addListener(_onSharesChanged);
    _loadAvailableShares();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _sharesController.dispose();
    super.dispose();
  }

  void _loadAvailableShares() {
    if (_selectedStock == null) {
      _availableShares = 0;
      return;
    }

    // Get available shares from the cubit state
    final currentState = context.read<StockCubit>().state;
    if (currentState is HoldingsLoaded) {
      try {
        final holding = currentState.holdings.firstWhere(
          (h) => h.symbol == _selectedStock!.symbol,
        );
        _availableShares = holding.shares;
      } catch (e) {
        // Stock not found in holdings
        _availableShares = 0;
      }
    } else {
      // If holdings aren't loaded, load them
      context.read<StockCubit>().loadHoldings();
      _availableShares = 0;
    }
  }

  void _onSharesChanged() {
    // Calculate amount based on shares
    if (_selectedStock != null && _sharesController.text.isNotEmpty) {
      final shares = double.tryParse(_sharesController.text) ?? 0;
      final amount = shares * _selectedStock!.currentPrice;
      _amountController.text = amount.toStringAsFixed(2);
    }
  }

  void _proceedToReview() {
    final shares = double.tryParse(_sharesController.text) ?? 0;
    if (shares > _availableShares) {
      Get.snackbar(
        'Insufficient Shares',
        'You only have $_availableShares shares available',
        backgroundColor: Colors.red.withValues(alpha: 0.2),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    setState(() => _currentStep = 1);
  }

  void _placeOrder() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final shares = double.tryParse(_sharesController.text) ?? 0;
    if (_selectedStock == null || shares <= 0) {
      Get.snackbar('Invalid order', 'Enter shares to sell');
      return;
    }
    final fees = amount * _kDisplayFeeRate;
    Get.toNamed(
      AppRoutes.stockTradeReview,
      arguments: {
        'stock': _selectedStock,
        'tradeType': 'sell',
        'amount': amount,
        'shares': shares.ceil(),
        'sharesExact': shares,
        'fees': fees,
        'estimatedTotal': amount - fees,
        'paymentMethod': _selectedWithdrawMethod,
        'paymentDetails': <String, dynamic>{},
        'orderType': OrderType.market,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockCubit, StockState>(
      listener: (context, state) {
        if (state is HoldingsLoaded && _selectedStock != null) {
          try {
            final holding = state.holdings.firstWhere(
              (h) => h.symbol == _selectedStock!.symbol,
            );
            setState(() {
              _availableShares = holding.shares;
            });
          } catch (e) {
            // Stock not found in holdings
            setState(() {
              _availableShares = 0;
            });
          }
        }
      },
      child: Scaffold(
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
                  _currentStep == 0 ? 'Sell Stock' : 'Review Order',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _currentStep == 0
                      ? 'Enter shares to sell'
                      : 'Confirm your sale',
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
                Icons.sell,
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
            _buildAvailableSharesCard(),
            SizedBox(height: 24.h),
            _buildStockSelector(),
            SizedBox(height: 24.h),
            _buildSharesInput(),
            SizedBox(height: 24.h),
            _buildQuickShareButtons(),
            SizedBox(height: 24.h),
            _buildWithdrawMethodSelector(),
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
            'Proceeds settle in USD',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'To move funds to NGN, use Exchange after the sale clears.',
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
                  'fromCurrency': 'USD',
                  'toCurrency': 'NGN',
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

  Widget _buildAvailableSharesCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha: 0.1),
            Colors.red.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: Colors.red,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Shares',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$_availableShares shares',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white.withValues(alpha: 0.3),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildStockSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Stock to Sell',
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
                      'Select a stock to sell',
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

  Widget _buildSharesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Shares',
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
              color: Colors.red.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _sharesController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 24.sp,
                    ),
                    suffixText: 'shares',
                    suffixStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_selectedStock != null && _sharesController.text.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: _selectedStock!.isPositive ? Colors.green : Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Current price: ₦${_selectedStock!.currentPrice.toStringAsFixed(2)}/share',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuickShareButtons() {
    final quarter = (_availableShares / 4).floor();
    final half = (_availableShares / 2).floor();
    final threeQuarter = (_availableShares * 3 / 4).floor();
    final all = _availableShares;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Select',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildQuickShareButton('25%', quarter),
            SizedBox(width: 8.w),
            _buildQuickShareButton('50%', half),
            SizedBox(width: 8.w),
            _buildQuickShareButton('75%', threeQuarter),
            SizedBox(width: 8.w),
            _buildQuickShareButton('100%', all),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickShareButton(String label, int shares) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _sharesController.text = shares.toString();
          _onSharesChanged();
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

  Widget _buildWithdrawMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Withdraw To',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildWithdrawMethod('Wallet', 'wallet', Icons.account_balance_wallet),
            SizedBox(width: 12.w),
            _buildWithdrawMethod('Bank', 'bank', Icons.account_balance),
          ],
        ),
      ],
    );
  }

  Widget _buildWithdrawMethod(String label, String value, IconData icon) {
    final isSelected = _selectedWithdrawMethod == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedWithdrawMethod = value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.red.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? Colors.red
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.red : Colors.white.withValues(alpha: 0.5),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.red : Colors.white,
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
    final shares = double.tryParse(_sharesController.text) ?? 0;
    final amount = double.tryParse(_amountController.text) ?? 0;
    final ccy = _tradeCurrency(_selectedStock);
    final fee = amount * _kDisplayFeeRate;
    final netAmount = amount - fee;

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
          _buildSummaryItem('Shares to Sell', shares.toStringAsFixed(2)),
          _buildSummaryItem('Current Price', _selectedStock != null
              ? CurrencySymbols.formatAmountWithCurrency(_selectedStock!.currentPrice, ccy)
              : '-'),
          _buildSummaryItem('Gross Amount', CurrencySymbols.formatAmountWithCurrency(amount, ccy)),
          _buildSummaryItem('Est. platform fee (~0.25%)',
              CurrencySymbols.formatAmountWithCurrency(fee, ccy)),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          _buildSummaryItem('You\'ll Receive', CurrencySymbols.formatAmountWithCurrency(netAmount, ccy),
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
                  ? Colors.green
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
        _sharesController.text.isNotEmpty &&
        (double.tryParse(_sharesController.text) ?? 0) > 0 &&
        (double.tryParse(_sharesController.text) ?? 0) <= _availableShares;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? _proceedToReview : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.red : Colors.grey,
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
    final shares = double.tryParse(_sharesController.text) ?? 0;
    final amount = double.tryParse(_amountController.text) ?? 0;
    final fee = amount * _kDisplayFeeRate;
    final netAmount = amount - fee;

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildReviewCard(shares, amount, fee, netAmount),
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

  Widget _buildReviewCard(double shares, double amount, double fee, double netAmount) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha: 0.1),
            Colors.red.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.3),
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
                      'Sell Order',
                      style: GoogleFonts.inter(
                        color: Colors.red,
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
          _buildReviewItem('Shares to Sell', shares.toStringAsFixed(2)),
          _buildReviewItem(
              'Price per Share',
              CurrencySymbols.formatAmountWithCurrency(
                _selectedStock?.currentPrice ?? 0,
                _tradeCurrency(_selectedStock),
              )),
          _buildReviewItem(
              'Gross Amount',
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
              'You\'ll Receive',
              CurrencySymbols.formatAmountWithCurrency(
                netAmount,
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
              'Sell orders are executed during market hours. Funds will be available in your selected account after settlement.',
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
          backgroundColor: Colors.red,
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
              'Confirm Sale',
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
      title: 'Select Stock to Sell',
      showOnlyHoldings: true,
    );

    if (selectedStock != null) {
      setState(() {
        _selectedStock = selectedStock;
      });
      // Load available shares for the selected stock
      _loadAvailableShares();
      // Clear inputs when stock changes
      _sharesController.clear();
      _amountController.clear();
    }
  }
}
