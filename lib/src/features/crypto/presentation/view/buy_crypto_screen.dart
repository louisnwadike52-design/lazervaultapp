import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/crypto_config_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../widgets/asset_wallet_sheet.dart';
import '../widgets/price_quote_card.dart';
import 'swap_flow_dispatcher.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class BuyCryptoScreen extends StatefulWidget {
  final Crypto? selectedCrypto;
  final bool lockAsset;

  const BuyCryptoScreen({super.key, this.selectedCrypto, this.lockAsset = false});

  @override
  State<BuyCryptoScreen> createState() => _BuyCryptoScreenState();
}

class _BuyCryptoScreenState extends State<BuyCryptoScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  Crypto? _selectedCrypto;
  String _selectedPaymentMethod = 'LazerVault Wallet';
  bool _isAmountInCrypto = false;
  bool _isLoading = false;
  bool _isTransacting = false;

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  /// Display-only fee rate driven by `crypto.fee_display.fallback_bps`. The
  /// authoritative fee comes from the server's swap-quote response; this is
  /// the placeholder shown before the quote arrives.
  double _feeDisplayRate() {
    int? bps;
    try {
      bps = context.read<CryptoConfigCubit>().config.feeDisplayFallbackBps;
    } catch (_) {
      try {
        bps = GetIt.I<CryptoConfigCubit>().config.feeDisplayFallbackBps;
      } catch (_) {}
    }
    return (bps ?? 150) / 10000.0;
  }

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

  /// Live exchange rate from PriceQuoteCard's onRateUpdated callback.
  /// Null = the card is loading or in error with no fallback. The
  /// OrderSummary section binds to this; when null we render a
  /// loading/error skeleton instead of the misleading old behaviour
  /// of computing against `_selectedCrypto.currentPrice` (a stale
  /// entity field hydrated at landing-page load time, often hours
  /// or days old when the user finally opens Buy).
  double? _liveRate;

  /// Effective rate used to drive computed amounts. Picks the live
  /// rate when available; otherwise null (so callers can render a
  /// loading-state skeleton instead of fake numbers).
  double? get _effectiveRate => _liveRate;

  /// True iff we have enough data to compute a meaningful summary.
  /// The user has picked an asset, typed an amount, and we have a
  /// live rate to multiply / divide by.
  bool get _isSummaryReady =>
      _selectedCrypto != null &&
      _amountController.text.isNotEmpty &&
      (_effectiveRate ?? 0) > 0;

  /// True while the rate fetch is in flight with no fallback to show.
  /// Drives the OrderSummary's loading-skeleton render.
  bool get _isRateLoading =>
      _selectedCrypto != null &&
      _amountController.text.isNotEmpty &&
      _liveRate == null;

  double get _fiatAmount {
    if (_amountController.text.isEmpty) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto) {
      // Crypto-input mode: multiply by the live rate to get the fiat
      // equivalent. Without a live rate we honestly return 0 so the
      // caller knows there's nothing trustworthy to display.
      final r = _effectiveRate;
      if (r == null || r <= 0) return 0.0;
      return amount * r;
    }
    // Fiat-input mode: the user typed the fiat number directly.
    return amount;
  }

  double get _cryptoAmount {
    if (_amountController.text.isEmpty || _selectedCrypto == null) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto) {
      return amount;
    }
    // Fiat-input mode: divide by the live rate to get the crypto
    // amount. Same honesty: return 0 when rate is unknown.
    final r = _effectiveRate;
    if (r == null || r <= 0) return 0.0;
    return amount / r;
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
                          _buildCryptoSelector(),
                          if (_selectedCrypto != null) ...[
                            SizedBox(height: 12.h),
                            PriceQuoteCard(
                              cryptoId: _selectedCrypto!.id,
                              cryptoSymbol: _selectedCrypto!.symbol,
                              onRateUpdated: (rate) {
                                if (!mounted) return;
                                if (rate == _liveRate) return;
                                setState(() => _liveRate = rate);
                              },
                            ),
                          ],
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
          // View wallet CTA — visible once a coin is selected, opens the
          // shared AssetWalletSheet (deposit address + QR + balance +
          // market price). Bright orange so it reads as a primary
          // affordance even on the dark header.
          if (_selectedCrypto != null) ...[
            GestureDetector(
              onTap: () => showAssetWalletSheet(
                context,
                cryptoSymbol: _selectedCrypto!.symbol,
                cryptoName: _selectedCrypto!.name,
                currentPrice: _selectedCrypto!.currentPrice,
                priceChange24hPct: _selectedCrypto!.priceChangePercentage24h,
                imageUrl: _selectedCrypto!.image,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFB923C), Color(0xFFEA580C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.45),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(children: [
                  Icon(Icons.account_balance_wallet_rounded,
                      color: Colors.white, size: 16.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Wallet',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(width: 8.w),
          ],
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
                Icons.currency_bitcoin,
                color: const Color.fromARGB(255, 78, 3, 208),
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
            onTap: widget.lockAsset ? null : _showCryptoSearchBottomSheet,
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
                          '${CurrencySymbols.currentSymbol}${_selectedCrypto!.currentPrice.toStringAsFixed(2)}',
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
                  if (!widget.lockAsset)
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: const Color.fromARGB(255, 78, 3, 208),
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
                    Icons.account_balance_wallet,
                    color: const Color.fromARGB(255, 78, 3, 208),
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
                          const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                          const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
                          color: const Color.fromARGB(255, 78, 3, 208),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _isAmountInCrypto ? CurrencySymbols.currentCurrency : 'Crypto',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color.fromARGB(255, 78, 3, 208),
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
                      _isAmountInCrypto ? (_selectedCrypto?.symbol.toUpperCase() ?? '') : CurrencySymbols.currentSymbol,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                        ],
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
                      ? '≈ ${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'
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
          Builder(builder: (context) {
            final sym = CurrencySymbols.currentSymbol;
            final amounts = switch (CurrencySymbols.currentCurrency) {
              'NGN' => [5000, 10000, 25000, 50000],
              'GHS' => [50, 100, 250, 500],
              'KES' => [500, 1000, 2500, 5000],
              'ZAR' => [100, 250, 500, 1000],
              'JPY' => [3000, 5000, 10000, 50000],
              'INR' => [2000, 5000, 10000, 25000],
              _ => [25, 50, 100, 500],
            };
            return Row(
              children: [
                for (var i = 0; i < amounts.length; i++) ...[
                  if (i > 0) SizedBox(width: 8.w),
                  _buildQuickAmountButton('$sym${amounts[i]}', amounts[i].toDouble()),
                ],
              ],
            );
          }),
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
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    // The card chrome is the same across all three states (header +
    // gradient + container). Body content branches on whether we have:
    //   • Empty:   no asset picked or no amount typed — nothing to show
    //   • Loading: rate fetch in flight, no fallback to compute against
    //   • Error:   rate fetch failed AND no stale price to fall back on
    //   • Loaded:  computed amounts derived from the live rate
    //
    // The previous version always ran the computation and rendered
    // numbers, using `_selectedCrypto.currentPrice` which is a stale
    // entity field hydrated at landing-page load time — so even when
    // PriceQuoteCard showed "Rate unavailable" the summary still
    // showed confident numbers, which is the misleading UX the user
    // flagged. Now the summary only renders trustable numbers when
    // _isSummaryReady, and otherwise tells the user what's happening.
    final symbol = _selectedCrypto?.symbol.toUpperCase() ?? '';

    Widget body;
    if (!_isSummaryReady && _isRateLoading) {
      body = _buildOrderSummaryLoading();
    } else if (!_isSummaryReady) {
      // _liveRate is null AND we aren't loading — means PriceQuoteCard
      // gave up. Surface a compact error so the user knows the summary
      // is intentionally blank; PriceQuoteCard above has the Retry
      // button so we don't duplicate it.
      body = _buildOrderSummaryError();
    } else {
      // Loaded — compute against the live rate. Fee is a display
      // estimate; the real one comes back from CreateSwapQuote.
      final feeRate = _feeDisplayRate();
      final fee = _fiatAmount * feeRate;
      final networkFee = fee * 0.3;
      final tradingFee = fee * 0.7;
      final total = _fiatAmount + fee;
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('You pay',
              '${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Network fee',
              '${CurrencySymbols.currentSymbol}${networkFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Trading fee',
              '${CurrencySymbols.currentSymbol}${tradingFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('You receive',
              '${_cryptoAmount.toStringAsFixed(6)} $symbol'),
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
          _buildSummaryRow('Total',
              '${CurrencySymbols.currentSymbol}${total.toStringAsFixed(2)}',
              isTotal: true),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.1),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
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
              Icon(Icons.receipt_long, color: Colors.green, size: 20.sp),
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
          body,
        ],
      ),
    );
  }

  /// Loading-state body: skeleton rows so the user sees the summary
  /// is coming, not just an empty card. Three rows roughly mirroring
  /// the loaded layout so the card doesn't jank when the rate lands.
  Widget _buildOrderSummaryLoading() {
    Widget skeleton(double w) => Container(
          width: w,
          height: 12.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
    Widget skeletonRow(double leftW, double rightW) => Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [skeleton(leftW), skeleton(rightW)],
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        skeletonRow(60.w, 90.w),
        skeletonRow(70.w, 80.w),
        skeletonRow(60.w, 70.w),
        skeletonRow(80.w, 100.w),
        SizedBox(height: 4.h),
        Row(
          children: [
            LazerVaultLoader(size: 14),
            SizedBox(width: 8.w),
            Text('Fetching live rate…',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          ],
        ),
      ],
    );
  }

  /// Error-state body. The display rate is offline but Buy itself is
  /// still allowed — CreateSwapQuote will fetch a fresh Quidax-live
  /// rate and lock it on the confirm screen. Tell the user that
  /// honestly instead of pretending we know what they'll pay.
  Widget _buildOrderSummaryError() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lock_clock,
            color: const Color(0xFFFB923C), size: 14.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            "Live display rate is paused. Your binding rate will be locked from Quidax when you tap Buy — you'll see it on the confirm screen before paying.",
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 12.sp, height: 1.4),
          ),
        ),
      ],
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
            const Color(0xFF1F1F1F),
            const Color(0xFF2D2D2D),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
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
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Pay From',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // LazerVault personal wallet — single payment source. Listens
          // to AccountCardsSummaryCubit so the spendable balance for
          // the active fiat is shown live (no manual refresh needed).
          BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
            builder: (context, accountState) {
              final personal = _personalAccountForActiveCurrency(accountState);
              final hasFunds =
                  personal != null && personal.availableBalance > 0;
              final available = personal?.availableBalance ?? 0.0;
              final canCover =
                  personal != null && available >= _fiatAmount && _fiatAmount > 0;
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                      const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color.fromARGB(255, 78, 3, 208),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208)
                            .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: const Color.fromARGB(255, 78, 3, 208),
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'LazerVault Wallet',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (accountState is AccountCardsSummaryLoading)
                                LazerVaultLoader(size: 12),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Personal ${CurrencySymbols.currentCurrency} Balance',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          // Live balance — the number the user needs to
                          // see before tapping "Buy". Falls back to
                          // "Balance unavailable" when the cubit hasn't
                          // hydrated yet (rare; layout still stable).
                          Text(
                            personal == null
                                ? 'Balance unavailable'
                                : '${CurrencySymbols.currentSymbol}${_formatMoney(available)}',
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: hasFunds
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.6),
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (_fiatAmount > 0 && personal != null) ...[
                            SizedBox(height: 4.h),
                            Text(
                              canCover
                                  ? 'Enough to cover this purchase'
                                  : 'Short by ${CurrencySymbols.currentSymbol}${_formatMoney(_fiatAmount - available)}',
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: canCover
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFEF4444),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, color: Colors.white, size: 14.sp),
                    ),
                  ],
                ),
              );
            },
          ),
          // Insufficient funds warning
          if (_fiatAmount > 0) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Funds will be deducted from your LazerVault wallet balance',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.blue.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
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
    // Quidax-as-source-of-truth: the binding rate is the one
    // CreateSwapQuote locks on the server side via Quidax merchant
    // API; the display rate from PriceQuoteCard is informational. So
    // we DON'T block the CTA on display-rate health — a transient
    // CoinGecko 429 or gateway channel reset shouldn't stop the user
    // from initiating Buy. The saga will fetch its own Quidax-live
    // rate, return the locked quote, and the user gets a confirm
    // screen with the real binding numbers. If Quidax is genuinely
    // down the saga itself will surface that on the confirm step.
    //
    // We still surface a note when the display rate is unavailable
    // so the user understands the OrderSummary is sparse — but the
    // tap path is unblocked.
    final isEnabled = _selectedCrypto != null &&
                     _amountController.text.isNotEmpty &&
                     (double.tryParse(_amountController.text) ?? 0.0) > 0 &&
                     !_isTransacting;

    // Build validation error message
    String? validationError;
    if (_selectedCrypto == null) {
      validationError = 'Please select a cryptocurrency';
    } else if (_amountController.text.isEmpty) {
      validationError = 'Please enter an amount';
    } else if ((double.tryParse(_amountController.text) ?? 0.0) <= 0) {
      validationError = 'Please enter a valid amount';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show validation error if any
        if (validationError != null && !isEnabled)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.orange,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    validationError,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Buy button
        GestureDetector(
          onTap: isEnabled ? _processBuyOrder : _showDisabledButtonFeedback,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: isEnabled
                ? LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 78, 3, 208),
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
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ] : null,
            ),
            child: _isTransacting
              ? Center(
                  child: LazerVaultLoader.small(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: isEnabled ? Colors.white : Colors.grey,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Buy ${_selectedCrypto?.symbol.toUpperCase() ?? 'Crypto'}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isEnabled ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ],
    );
  }

  void _showDisabledButtonFeedback() {
    // Haptic feedback
    // Show brief message indicating what's needed
    if (_selectedCrypto == null) {
      Get.snackbar(
        'Select Crypto',
        'Please select a cryptocurrency to buy',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else if (_amountController.text.isEmpty || (double.tryParse(_amountController.text) ?? 0.0) <= 0) {
      Get.snackbar(
        'Enter Amount',
        'Please enter a valid amount to purchase',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else if (_isTransacting) {
      Get.snackbar(
        'Processing',
        'Transaction in progress, please wait...',
        backgroundColor: Colors.blue.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
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
                    fillColor: const Color(0xFF1F1F1F),
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
                      return const Center(child: LazerVaultLoader.small());
                    } else if (state is CryptosLoaded) {
                      // Only show Quidax-supported assets for buy
                      final supported = state.supportedAssets;
                      if (supported.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.info_outline, color: Colors.grey[600], size: 48.sp),
                                SizedBox(height: 12.h),
                                Text(
                                  'No supported assets available',
                                  style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16.sp),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Quidax-supported trading pairs could not be loaded. Please try again.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final query = _searchController.text.toLowerCase();
                      final cryptos = query.isEmpty
                        ? supported
                        : supported.where((c) =>
                            c.name.toLowerCase().contains(query) ||
                            c.symbol.toLowerCase().contains(query)
                          ).toList();

                      if (cryptos.isEmpty) {
                        return Center(
                          child: Text(
                            'No matching assets found',
                            style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14.sp),
                          ),
                        );
                      }

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
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedCrypto = crypto;
                // Reset the live rate so the OrderSummary shows its
                // loading state until PriceQuoteCard reports a new
                // rate for the freshly-picked asset. Otherwise the
                // user briefly sees BTC's rate applied to ETH input.
                _liveRate = null;
              });
              _searchController.clear();
              Get.back();
            },
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
                      '${CurrencySymbols.currentSymbol}${crypto.currentPrice.toStringAsFixed(2)}',
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
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              Get.back(); // close bottom sheet
              Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'View Details',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _processBuyOrder() async {
    if (_selectedCrypto == null || _isLoading || _isTransacting) return;
    final fiat = _fiatAmount;
    if (fiat <= 0) return; // Guard against zero/negative amount

    // Fee display still shown to user via the PIN sheet; the actual platform
    // spread is computed server-side from system_settings.crypto.spread.*
    // basis points and applied during the swap-quotation flow. The display
    // rate here comes from CryptoConfigCubit (PR5d.4).
    final fee = fiat * _feeDisplayRate();
    final total = fiat + fee;
    final quantity = _cryptoAmount;

    // Show PIN bottom sheet first
    final success = await validateTransactionPin(
      context: context,
      transactionId: 'CRYPTO-BUY-${DateTime.now().millisecondsSinceEpoch}',
      transactionType: 'buy',
      amount: fiat,
      currency: CurrencySymbols.currentCurrency,
      title: 'Confirm Buy Order',
      message: 'Confirm purchase of ${quantity.toStringAsFixed(6)} ${_selectedCrypto!.symbol.toUpperCase()}',
      fee: fee,
      totalAmount: total,
      showProcessingPhase: false, // We'll use our own processing screen
      onPinValidated: (verificationToken) async {
        if (!mounted) return;
        setState(() => _isTransacting = true);

        // PR4.7: PIN validated → route into the Quidax swap-quotation flow.
        // The dispatcher resolves the fiat account id from
        // AccountCardsSummaryCubit, calls cubit.createSwapQuote, shows the
        // QuoteTimerCard, and surfaces a snackbar on terminal state.
        // verificationToken is captured by the PIN service; the saga handles
        // hold + push + quote without needing it explicitly.
        final result = await runSwapFlow(
          context: context,
          side: 'buy',
          cryptoSymbol: _selectedCrypto!.symbol,
          fiatAmount: fiat,
          description: 'Buy ${quantity.toStringAsFixed(6)} ${_selectedCrypto!.symbol.toUpperCase()}',
          transactionPin: verificationToken,
        );

        if (!mounted) return;
        if (!result.initiated && (result.message ?? '').isNotEmpty) {
          Get.snackbar(
            'Trade failed',
            result.message!,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          _amountController.clear();
        }
        setState(() => _isTransacting = false);
      },
    );

    if (!success && mounted) {
      setState(() => _isTransacting = false);
    }
  }

  // Pick the user's personal account whose currency matches the active
  // locale fiat — that's the wallet this screen actually debits. Returns
  // null while the cubit is still hydrating or if the user genuinely has
  // no personal account for this fiat (rare; shows "Balance unavailable").
  AccountSummaryEntity? _personalAccountForActiveCurrency(
      AccountCardsSummaryState state) {
    final accounts = switch (state) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => const <AccountSummaryEntity>[],
    };
    if (accounts.isEmpty) return null;
    final wantedCcy = CurrencySymbols.currentCurrency.toUpperCase();
    for (final a in accounts) {
      if (a.isPersonalAccount && a.currency.toUpperCase() == wantedCcy) {
        return a;
      }
    }
    return null;
  }

  // Format a fiat amount with grouped thousands separators. We avoid
  // the locale-aware NumberFormat here so the output stays consistent
  // across the screen with the other fiat figures (which also use
  // toStringAsFixed(2) + a manual symbol).
  String _formatMoney(double amount) {
    final neg = amount < 0;
    final abs = amount.abs();
    final fixed = abs.toStringAsFixed(2);
    final parts = fixed.split('.');
    final whole = parts[0];
    final frac = parts.length > 1 ? parts[1] : '00';
    final buf = StringBuffer();
    for (int i = 0; i < whole.length; i++) {
      if (i > 0 && (whole.length - i) % 3 == 0) buf.write(',');
      buf.write(whole[i]);
    }
    return '${neg ? '-' : ''}${buf.toString()}.$frac';
  }
} 