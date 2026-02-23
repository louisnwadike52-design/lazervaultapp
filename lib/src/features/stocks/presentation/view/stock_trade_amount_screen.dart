import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/stock_entity.dart';
import '../../../../../core/types/app_routes.dart';

class StockTradeAmountScreen extends StatefulWidget {
  const StockTradeAmountScreen({super.key});

  @override
  State<StockTradeAmountScreen> createState() => _StockTradeAmountScreenState();
}

class _StockTradeAmountScreenState extends State<StockTradeAmountScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  Stock? _selectedStock;
  String _tradeType = 'buy';
  OrderType _orderType = OrderType.market;
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _sharesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  
  bool _isAmountMode = true; // true for amount, false for shares
  double _currentAmount = 0.0;
  int _currentShares = 0;
  double _estimatedFees = 0.0;
  double _estimatedTotal = 0.0;
  
  final double _feePercentage = 0.0025; // 0.25% fee

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
    _setupControllers();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _selectedStock = args['stock'] as Stock?;
    _tradeType = args['tradeType'] ?? 'buy';
    
    if (_selectedStock != null) {
      _priceController.text = _selectedStock!.currentPrice.toStringAsFixed(2);
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  void _setupControllers() {
    _amountController.addListener(_onAmountChanged);
    _sharesController.addListener(_onSharesChanged);
    _priceController.addListener(_onPriceChanged);
  }

  void _onAmountChanged() {
    if (_isAmountMode && _selectedStock != null) {
      final amount = double.tryParse(_amountController.text) ?? 0.0;
      final price = _orderType == OrderType.market 
          ? _selectedStock!.currentPrice 
          : (double.tryParse(_priceController.text) ?? _selectedStock!.currentPrice);
      
      setState(() {
        _currentAmount = amount;
        _currentShares = price > 0 ? (amount / price).floor() : 0;
        _sharesController.text = _currentShares.toString();
        _calculateTotals();
      });
    }
  }

  void _onSharesChanged() {
    if (!_isAmountMode && _selectedStock != null) {
      final shares = int.tryParse(_sharesController.text) ?? 0;
      final price = _orderType == OrderType.market 
          ? _selectedStock!.currentPrice 
          : (double.tryParse(_priceController.text) ?? _selectedStock!.currentPrice);
      
      setState(() {
        _currentShares = shares;
        _currentAmount = shares * price;
        _amountController.text = _currentAmount.toStringAsFixed(2);
        _calculateTotals();
      });
    }
  }

  void _onPriceChanged() {
    if (_orderType == OrderType.limit) {
      _calculateTotals();
    }
  }

  void _calculateTotals() {
    final price = _orderType == OrderType.market 
        ? _selectedStock?.currentPrice ?? 0.0
        : (double.tryParse(_priceController.text) ?? 0.0);
    
    final tradeAmount = _currentShares * price;
    _estimatedFees = tradeAmount * _feePercentage;
    _estimatedTotal = _tradeType == 'buy' 
        ? tradeAmount + _estimatedFees 
        : tradeAmount - _estimatedFees;
  }

  void _proceedToPayment() {
    if (_selectedStock == null || _currentShares <= 0) {
      _showErrorSnackBar('Please enter a valid amount or number of shares');
      return;
    }

    if (_orderType == OrderType.limit) {
      final price = double.tryParse(_priceController.text);
      if (price == null || price <= 0) {
        _showErrorSnackBar('Please enter a valid limit price');
        return;
      }
    }

    Get.toNamed(AppRoutes.stockTradePayment, arguments: {
      'stock': _selectedStock,
      'tradeType': _tradeType,
      'orderType': _orderType,
      'amount': _currentAmount,
      'shares': _currentShares,
      'price': _orderType == OrderType.limit ? double.tryParse(_priceController.text) : null,
      'fees': _estimatedFees,
      'estimatedTotal': _estimatedTotal,
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _amountController.dispose();
    _sharesController.dispose();
    _priceController.dispose();
    super.dispose();
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
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            children: [
                              _buildStockCard(),
                              SizedBox(height: 24.h),
                              _buildOrderTypeSelector(),
                              SizedBox(height: 24.h),
                              _buildAmountSharesToggle(),
                              SizedBox(height: 16.h),
                              _buildInputSection(),
                              if (_orderType == OrderType.limit) ...[
                                SizedBox(height: 16.h),
                                _buildLimitPriceInput(),
                              ],
                              SizedBox(height: 24.h),
                              _buildQuickAmountButtons(),
                              SizedBox(height: 24.h),
                              _buildSummaryCard(),
                              SizedBox(height: 32.h),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildBottomButton(),
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
                  '${_tradeType == 'buy' ? 'Buy' : 'Sell'} Stock',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Enter amount or shares',
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

  Widget _buildStockCard() {
    if (_selectedStock == null) return const SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey[100]!,
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: _selectedStock!.logoUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: _selectedStock!.logoUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey[200]!, Colors.grey[300]!],
                        ),
                      ),
                      child: Icon(Icons.business, color: Colors.grey[600], size: 24.sp),
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey[200]!, Colors.grey[300]!],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _selectedStock!.symbol[0],
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[200]!, Colors.grey[300]!],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _selectedStock!.symbol[0],
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _selectedStock!.symbol,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        _selectedStock!.exchange,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4A90E2),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  _selectedStock!.name,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencySymbols.formatAmountWithCurrency(_selectedStock!.currentPrice, _selectedStock!.currency),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _selectedStock!.isPositive 
                        ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                        : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${_selectedStock!.changePercent.toStringAsFixed(2)}%',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(16.r),
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
          Expanded(
            child: _buildOrderTypeButton('Market', OrderType.market),
          ),
          Expanded(
            child: _buildOrderTypeButton('Limit', OrderType.limit),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeButton(String label, OrderType type) {
    final isSelected = _orderType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _orderType = type;
          _calculateTotals();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    const Color(0xFF4A90E2),
                    const Color(0xFF357ABD),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAmountSharesToggle() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(16.r),
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
          Expanded(
            child: _buildToggleButton('Amount (${_selectedStock != null ? CurrencySymbols.getSymbol(_selectedStock!.currency) : '\$'})', true),
          ),
          Expanded(
            child: _buildToggleButton('Shares', false),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isAmountMode) {
    final isSelected = _isAmountMode == isAmountMode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAmountMode = isAmountMode;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    const Color(0xFF4A90E2),
                    const Color(0xFF357ABD),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(20.r),
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
          Text(
            _isAmountMode ? 'Enter Amount' : 'Enter Shares',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _isAmountMode ? _amountController : _sharesController,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: _isAmountMode),
            inputFormatters: [
              if (_isAmountMode)
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
              else
                FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: _isAmountMode ? '0.00' : '0',
              hintStyle: GoogleFonts.inter(
                color: Colors.grey[600],
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixText: _isAmountMode ? '${_selectedStock != null ? CurrencySymbols.getSymbol(_selectedStock!.currency) : '\$'} ' : '',
              prefixStyle: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _isAmountMode 
                ? 'Approximately $_currentShares shares'
                : 'Approximately ${CurrencySymbols.formatAmountWithCurrency(_currentAmount, _selectedStock?.currency ?? 'USD')}',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitPriceInput() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(20.r),
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
          Text(
            'Limit Price',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _priceController,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: GoogleFonts.inter(
                color: Colors.grey[600],
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixText: '${_selectedStock != null ? CurrencySymbols.getSymbol(_selectedStock!.currency) : '\$'} ',
              prefixStyle: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Current market price: ${_selectedStock != null ? CurrencySymbols.formatAmountWithCurrency(_selectedStock!.currentPrice, _selectedStock!.currency) : '0.00'}',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButtons() {
    final quickAmounts = [100.0, 500.0, 1000.0, 2500.0];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amounts',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: quickAmounts.map((amount) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _isAmountMode = true;
                  _amountController.text = amount.toStringAsFixed(0);
                  _onAmountChanged();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A3E),
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
                  '${CurrencySymbols.getSymbol(_selectedStock?.currency ?? 'USD')}${amount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Order Type', '${_orderType.toString().split('.').last.toUpperCase()} ${_tradeType.toUpperCase()}'),
          _buildSummaryRow('Shares', _currentShares.toString()),
          _buildSummaryRow('Price per Share', CurrencySymbols.formatAmountWithCurrency(_orderType == OrderType.market ? _selectedStock?.currentPrice ?? 0.0 : double.tryParse(_priceController.text) ?? 0.0, _selectedStock?.currency ?? 'USD')),
          _buildSummaryRow('Subtotal', CurrencySymbols.formatAmountWithCurrency(_currentAmount, _selectedStock?.currency ?? 'USD')),
          _buildSummaryRow('Estimated Fees', CurrencySymbols.formatAmountWithCurrency(_estimatedFees, _selectedStock?.currency ?? 'USD')),
          Divider(color: Colors.grey[600], height: 24.h),
          _buildSummaryRow('Estimated Total', CurrencySymbols.formatAmountWithCurrency(_estimatedTotal, _selectedStock?.currency ?? 'USD'), isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : Colors.grey[400],
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
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

  Widget _buildBottomButton() {
    final isEnabled = _currentShares > 0 && 
        (_orderType == OrderType.market || 
         (double.tryParse(_priceController.text) ?? 0.0) > 0);
    
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(
                  colors: _tradeType == 'buy' 
                      ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                      : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                )
              : LinearGradient(
                  colors: [Colors.grey[700]!, Colors.grey[600]!],
                ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: (_tradeType == 'buy' ? const Color(0xFF4CAF50) : const Color(0xFFE53E3E))
                        .withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? _proceedToPayment : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            'Continue to Payment',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
} 
