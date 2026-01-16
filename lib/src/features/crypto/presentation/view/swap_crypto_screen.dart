import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crypto_entity.dart';
import 'crypto_confirmation_screen.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class SwapCryptoScreen extends StatefulWidget {
  final CryptoHolding? fromHolding;
  final Crypto? toCrypto;

  const SwapCryptoScreen({super.key, this.fromHolding, this.toCrypto});

  @override
  State<SwapCryptoScreen> createState() => _SwapCryptoScreenState();
}

class _SwapCryptoScreenState extends State<SwapCryptoScreen>
    with TickerProviderStateMixin {
  final TextEditingController _fromAmountController = TextEditingController();
  final TextEditingController _toAmountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  late AnimationController _animationController;
  late AnimationController _swapAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotationAnimation;
  
  CryptoHolding? _fromHolding;
  Crypto? _toCrypto;
  bool _isFromAmountActive = true;
  bool _isLoading = false;
  
  // Mock holdings data
  final List<CryptoHolding> _mockHoldings = [
    CryptoHolding(
      id: 'holding_1',
      cryptoId: 'bitcoin',
      cryptoName: 'Bitcoin',
      cryptoSymbol: 'BTC',
      quantity: 0.125,
      averagePrice: 45000.0,
      currentPrice: 67000.0,
      totalValue: 8375.0,
      totalGainLoss: 2750.0,
      totalGainLossPercentage: 48.89,
      purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
      lastUpdated: DateTime.now(),
    ),
    CryptoHolding(
      id: 'holding_2',
      cryptoId: 'ethereum',
      cryptoName: 'Ethereum',
      cryptoSymbol: 'ETH',
      quantity: 2.5,
      averagePrice: 2800.0,
      currentPrice: 3100.0,
      totalValue: 7750.0,
      totalGainLoss: 750.0,
      totalGainLossPercentage: 10.71,
      purchaseDate: DateTime.now().subtract(const Duration(days: 45)),
      lastUpdated: DateTime.now(),
    ),
    CryptoHolding(
      id: 'holding_3',
      cryptoId: 'solana',
      cryptoName: 'Solana',
      cryptoSymbol: 'SOL',
      quantity: 45.0,
      averagePrice: 120.0,
      currentPrice: 157.0,
      totalValue: 7065.0,
      totalGainLoss: 1665.0,
      totalGainLossPercentage: 30.83,
      purchaseDate: DateTime.now().subtract(const Duration(days: 60)),
      lastUpdated: DateTime.now(),
    ),
  ];

  // Mock available cryptos for swapping
  final List<Crypto> _availableCryptos = [
    Crypto(
      id: 'bitcoin',
      name: 'Bitcoin',
      symbol: 'BTC',
      image: 'default.png',
      currentPrice: 67000.0,
      priceChange24h: 1250.0,
      priceChangePercentage24h: 1.9,
      marketCap: 1320000000000.0,
      marketCapRank: 1,
      totalVolume: 28000000000.0,
      high24h: 68500.0,
      low24h: 65200.0,
      circulatingSupply: 19700000.0,
      lastUpdated: DateTime.now(),
    ),
    Crypto(
      id: 'ethereum',
      name: 'Ethereum',
      symbol: 'ETH',
      image: 'default.png',
      currentPrice: 3100.0,
      priceChange24h: -45.0,
      priceChangePercentage24h: -1.4,
      marketCap: 373000000000.0,
      marketCapRank: 2,
      totalVolume: 14000000000.0,
      high24h: 3200.0,
      low24h: 3050.0,
      circulatingSupply: 120280000.0,
      lastUpdated: DateTime.now(),
    ),
    Crypto(
      id: 'solana',
      name: 'Solana',
      symbol: 'SOL',
      image: 'default.png',
      currentPrice: 157.0,
      priceChange24h: 8.5,
      priceChangePercentage24h: 5.7,
      marketCap: 73000000000.0,
      marketCapRank: 5,
      totalVolume: 2500000000.0,
      high24h: 165.0,
      low24h: 152.0,
      circulatingSupply: 465000000.0,
      lastUpdated: DateTime.now(),
    ),
    Crypto(
      id: 'cardano',
      name: 'Cardano',
      symbol: 'ADA',
      image: 'default.png',
      currentPrice: 0.89,
      priceChange24h: 0.03,
      priceChangePercentage24h: 3.5,
      marketCap: 31000000000.0,
      marketCapRank: 8,
      totalVolume: 850000000.0,
      high24h: 0.92,
      low24h: 0.86,
      circulatingSupply: 35000000000.0,
      lastUpdated: DateTime.now(),
    ),
    Crypto(
      id: 'polkadot',
      name: 'Polkadot',
      symbol: 'DOT',
      image: 'default.png',
      currentPrice: 12.45,
      priceChange24h: -0.25,
      priceChangePercentage24h: -2.0,
      marketCap: 15000000000.0,
      marketCapRank: 12,
      totalVolume: 420000000.0,
      high24h: 12.85,
      low24h: 12.20,
      circulatingSupply: 1200000000.0,
      lastUpdated: DateTime.now(),
    ),
    Crypto(
      id: 'chainlink',
      name: 'Chainlink',
      symbol: 'LINK',
      image: 'default.png',
      currentPrice: 18.75,
      priceChange24h: 0.85,
      priceChangePercentage24h: 4.7,
      marketCap: 11000000000.0,
      marketCapRank: 15,
      totalVolume: 650000000.0,
      high24h: 19.20,
      low24h: 18.40,
      circulatingSupply: 586000000.0,
      lastUpdated: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fromHolding = widget.fromHolding;
    _toCrypto = widget.toCrypto;
    _fromAmountController.addListener(_onFromAmountChanged);
    _toAmountController.addListener(_onToAmountChanged);
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _swapAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _swapAnimationController, curve: Curves.elasticOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _fromAmountController.dispose();
    _toAmountController.dispose();
    _searchController.dispose();
    _animationController.dispose();
    _swapAnimationController.dispose();
    super.dispose();
  }

  void _onFromAmountChanged() {
    if (_isFromAmountActive && _fromHolding != null && _toCrypto != null) {
      final fromAmount = double.tryParse(_fromAmountController.text) ?? 0.0;
      final gbpValue = fromAmount * _fromHolding!.currentPrice;
      final toAmount = gbpValue / _toCrypto!.currentPrice;
      _toAmountController.text = toAmount > 0 ? toAmount.toStringAsFixed(6) : '';
    }
    setState(() {});
  }

  void _onToAmountChanged() {
    if (!_isFromAmountActive && _fromHolding != null && _toCrypto != null) {
      final toAmount = double.tryParse(_toAmountController.text) ?? 0.0;
      final gbpValue = toAmount * _toCrypto!.currentPrice;
      final fromAmount = gbpValue / _fromHolding!.currentPrice;
      _fromAmountController.text = fromAmount > 0 ? fromAmount.toStringAsFixed(6) : '';
    }
    setState(() {});
  }

  double get _fromAmount => double.tryParse(_fromAmountController.text) ?? 0.0;
  double get _toAmount => double.tryParse(_toAmountController.text) ?? 0.0;
  
  bool get _hasValidAmount {
    if (_fromHolding == null) return false;
    return _fromAmount > 0 && _fromAmount <= _fromHolding!.quantity;
  }

  double get _exchangeRate {
    if (_fromHolding == null || _toCrypto == null) return 0.0;
    return _toCrypto!.currentPrice / _fromHolding!.currentPrice;
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
                          _buildSwapInterface(),
                          SizedBox(height: 24.h),
                          if (_fromHolding != null && _toCrypto != null) ...[
                            _buildExchangeRate(),
                            SizedBox(height: 24.h),
                            if (_hasValidAmount) _buildSwapSummary(),
                            if (_hasValidAmount) SizedBox(height: 24.h),
                          ],
                          _buildSwapSettings(),
                          SizedBox(height: 24.h),
                          _buildLegalDisclaimer(),
                          SizedBox(height: 32.h),
                          _buildSwapButton(),
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
                  'Swap Crypto',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Exchange one crypto for another',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                            ServiceVoiceButton(
                serviceName: 'crypto',
              ),
],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.swap_horiz,
              color: const Color(0xFF6C5CE7),
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapInterface() {
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCryptoInputCard(
            title: 'From',
            crypto: _fromHolding?.cryptoName ?? 'Select crypto',
            symbol: _fromHolding?.cryptoSymbol ?? '',
            price: _fromHolding?.currentPrice ?? 0.0,
            balance: _fromHolding?.quantity ?? 0.0,
            controller: _fromAmountController,
            isFrom: true,
            onTap: () => _showCryptoSelector(true),
            isEmpty: _fromHolding == null,
          ),
          SizedBox(height: 16.h),
          Center(
            child: GestureDetector(
              onTap: _swapCryptos,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 3.14159,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF6C5CE7),
                            const Color(0xFF8B7CF6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C5CE7).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.swap_vert,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildCryptoInputCard(
            title: 'To',
            crypto: _toCrypto?.name ?? 'Select crypto',
            symbol: _toCrypto?.symbol ?? '',
            price: _toCrypto?.currentPrice ?? 0.0,
            balance: null,
            controller: _toAmountController,
            isFrom: false,
            onTap: () => _showCryptoSelector(false),
            isEmpty: _toCrypto == null,
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoInputCard({
    required String title,
    required String crypto,
    required String symbol,
    required double price,
    required double? balance,
    required TextEditingController controller,
    required bool isFrom,
    required VoidCallback onTap,
    required bool isEmpty,
  }) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (balance != null)
                GestureDetector(
                  onTap: () {
                    if (balance > 0) {
                      setState(() {
                        _isFromAmountActive = true;
                        controller.text = balance.toStringAsFixed(6);
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6C5CE7).withOpacity(0.2),
                          const Color(0xFF6C5CE7).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Max: ${balance.toStringAsFixed(6)}',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: const Color(0xFF6C5CE7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isEmpty 
                            ? [Colors.grey.withOpacity(0.3), Colors.grey.withOpacity(0.1)]
                            : [Colors.orange, Colors.orange.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        isEmpty ? Icons.add : Icons.currency_bitcoin,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isEmpty 
                              ? Colors.white.withOpacity(0.6)
                              : Colors.white,
                          ),
                        ),
                        if (symbol.isNotEmpty)
                          Text(
                            symbol.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: const Color(0xFF6C5CE7),
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!isEmpty)
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.right,
                    onTap: () => setState(() => _isFromAmountActive = isFrom),
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.0',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
            ],
          ),
          if (price > 0 && !isEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£${price.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                if (controller.text.isNotEmpty)
                  Text(
                    '≈ £${(price * (double.tryParse(controller.text) ?? 0.0)).toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
              ],
            ),
          ],
          if (!_hasValidAmount && _fromAmount > 0 && isFrom) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Insufficient balance. Available: ${balance?.toStringAsFixed(6) ?? 0} ${symbol.toUpperCase()}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExchangeRate() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.1),
            const Color(0xFF1E2746),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.1),
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
                Icons.trending_up,
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Exchange Rate',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Simulate rate refresh
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: const Color(0xFF6C5CE7),
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1 ${_fromHolding!.cryptoSymbol.toUpperCase()}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: const Color(0xFF6C5CE7),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${_exchangeRate.toStringAsFixed(6)} ${_toCrypto!.symbol.toUpperCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF6C5CE7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Rate updates every 30 seconds',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapSummary() {
    final fee = (_fromAmount * _fromHolding!.currentPrice) * 0.005; // 0.5% fee
    final networkFee = fee * 0.3;
    final tradingFee = fee * 0.7;
    final effectiveRate = _toAmount / _fromAmount;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.1),
            const Color(0xFF1E2746),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.1),
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
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Swap Summary',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('You swap', '${_fromAmount.toStringAsFixed(6)} ${_fromHolding!.cryptoSymbol.toUpperCase()}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Network fee', '£${networkFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Trading fee', '£${tradingFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Effective rate', '1 ${_fromHolding!.cryptoSymbol.toUpperCase()} = ${effectiveRate.toStringAsFixed(6)} ${_toCrypto!.symbol.toUpperCase()}'),
          SizedBox(height: 12.h),
          Container(
            height: 1.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow('You receive', '${_toAmount.toStringAsFixed(6)} ${_toCrypto!.symbol.toUpperCase()}', isTotal: true),
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
            color: Colors.white.withOpacity(isTotal ? 1.0 : 0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: isTotal ? const Color(0xFF6C5CE7) : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSwapSettings() {
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
            color: Colors.black.withOpacity(0.1),
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
                Icons.tune,
                color: Colors.blue,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Swap Settings',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSettingRow('Slippage tolerance', '0.5%', Icons.tune),
          SizedBox(height: 12.h),
          _buildSettingRow('Transaction deadline', '20 minutes', Icons.access_time),
          SizedBox(height: 12.h),
          _buildSettingRow('Exchange type', 'Market swap', Icons.swap_horiz),
        ],
      ),
    );
  }

  Widget _buildSettingRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.6), size: 16.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
            ),
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
        SizedBox(width: 8.w),
        Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.4), size: 16.sp),
      ],
    );
  }

  Widget _buildLegalDisclaimer() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.1),
            Colors.orange.withOpacity(0.05),
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
              'Cryptocurrency swaps are subject to market volatility and slippage. The final amount may differ from the estimate due to rapid price changes.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.8),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapButton() {
    final isEnabled = _fromHolding != null && _toCrypto != null && _hasValidAmount;

    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: isEnabled ? _processSwapOrder : null,
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
                      Colors.grey.withOpacity(0.3),
                      Colors.grey.withOpacity(0.1),
                    ],
                  ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: isEnabled ? [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.3),
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
                      Icons.swap_horiz,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _fromHolding != null && _toCrypto != null
                        ? 'Swap ${_fromHolding!.cryptoSymbol.toUpperCase()} for ${_toCrypto!.symbol.toUpperCase()}'
                        : 'Select cryptos to swap',
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

  void _swapCryptos() {
    if (_fromHolding != null && _toCrypto != null) {
      _swapAnimationController.forward().then((_) {
        _swapAnimationController.reset();
      });
      
      setState(() {
        // Convert the current _toCrypto to a CryptoHolding for the from side
        // In real implementation, you'd check if user actually has this crypto
        final tempFromHolding = _fromHolding;
        final tempToCrypto = _toCrypto;
        
        // Find if user has holdings of the target crypto
        final existingHolding = _mockHoldings.firstWhere(
          (holding) => holding.cryptoSymbol.toLowerCase() == tempToCrypto!.symbol.toLowerCase(),
          orElse: () => CryptoHolding(
            id: 'temp_${tempToCrypto!.id}',
            cryptoId: tempToCrypto.id,
            cryptoName: tempToCrypto.name,
            cryptoSymbol: tempToCrypto.symbol,
            quantity: 0.0, // No holdings of this crypto
            averagePrice: tempToCrypto.currentPrice,
            currentPrice: tempToCrypto.currentPrice,
            totalValue: 0.0,
            totalGainLoss: 0.0,
            totalGainLossPercentage: 0.0,
            purchaseDate: DateTime.now(),
            lastUpdated: DateTime.now(),
          ),
        );
        
        _fromHolding = existingHolding;
        _toCrypto = _availableCryptos.firstWhere(
          (crypto) => crypto.symbol.toLowerCase() == tempFromHolding!.cryptoSymbol.toLowerCase(),
        );
        
        // Clear amounts
        _fromAmountController.clear();
        _toAmountController.clear();
      });
    }
  }

  void _showCryptoSelector(bool isFrom) {
    final currentContext = context;
    showModalBottomSheet(
      context: currentContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
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
                      isFrom ? 'Select crypto to swap from' : 'Select crypto to swap to',
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
                  hintStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: const Color(0xFF1E2746),
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
                itemCount: isFrom ? _mockHoldings.length : _availableCryptos.length,
                itemBuilder: (context, index) {
                  if (isFrom) {
                    final holding = _mockHoldings[index];
                    return _buildHoldingOption(holding);
                  } else {
                    final crypto = _availableCryptos[index];
                    return _buildCryptoOption(crypto);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldingOption(CryptoHolding holding) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _fromHolding = holding;
          _fromAmountController.clear();
          _toAmountController.clear();
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
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange.withOpacity(0.7)],
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
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '£${holding.totalValue.toStringAsFixed(2)}',
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

  Widget _buildCryptoOption(Crypto crypto) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _toCrypto = crypto;
          _fromAmountController.clear();
          _toAmountController.clear();
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
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange.withOpacity(0.7)],
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
                      color: Colors.white.withOpacity(0.6),
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

  void _processSwapOrder() {
    if (_fromHolding == null || _toCrypto == null || !_hasValidAmount) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate processing delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      // Create transaction details
      final fee = (_fromAmount * _fromHolding!.currentPrice) * 0.005; // 0.5% fee for swaps
      final totalGbpValue = _fromAmount * _fromHolding!.currentPrice;
      
      final transactionDetails = CryptoTransactionDetails(
        type: CryptoTransactionType.swap,
        cryptoName: _toCrypto!.name,
        cryptoSymbol: _toCrypto!.symbol,
        cryptoAmount: _toAmount.toStringAsFixed(6),
        pricePerUnit: _toCrypto!.currentPrice,
        gbpAmount: totalGbpValue,
        networkFee: fee * 0.3, // 30% of total fee for network
        tradingFee: fee * 0.7, // 70% of total fee for LazerVault
        totalAmount: totalGbpValue,
        paymentMethod: 'Crypto Wallet', // Internal swap
        fromCrypto: _fromHolding!.cryptoSymbol,
        toCrypto: _toCrypto!.symbol,
      );

      // Navigate to confirmation screen
      Get.to(() => CryptoConfirmationScreen(transactionDetails: transactionDetails));
    });
  }
} 