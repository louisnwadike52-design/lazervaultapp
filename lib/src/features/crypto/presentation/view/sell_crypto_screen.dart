import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../domain/trade_amounts.dart';
import '../widgets/asset_wallet_sheet.dart';
import '../widgets/asset_network_badge.dart';
import '../widgets/network_picker_sheet.dart';
import '../widgets/price_quote_card.dart';
import 'swap_flow_dispatcher.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/crypto/domain/trade_pricing.dart';

class SellCryptoScreen extends StatefulWidget {
  final CryptoHolding? selectedHolding;
  final bool lockHolding;

  const SellCryptoScreen(
      {super.key, this.selectedHolding, this.lockHolding = false});

  @override
  State<SellCryptoScreen> createState() => _SellCryptoScreenState();
}

class _SellCryptoScreenState extends State<SellCryptoScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  CryptoHolding? _selectedHolding;
  bool _isAmountInCrypto = true;
  bool _isLoading = false;
  bool _isTransacting = false;

  /// Live exchange rate from PriceQuoteCard's onRateUpdated callback.
  ///
  /// Null until the first successful fetch, and deliberately WITHOUT a
  /// fallback to `_selectedHolding.currentPrice`: that is a stale entity field
  /// hydrated when the holdings list loaded, often hours old by the time the
  /// user opens Sell. See sell_crypto_sheet._price and buy_crypto_sheet._rate.
  double? _liveRate;

  /// Quidax's swap margin, from PriceQuoteCard. The rate it reports is the MID
  /// of the executable buy and sell rates; a sell fills BELOW it.
  double _swapMargin = 0;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  /// Effective rate used to drive every computed amount: the rate a SELL
  /// actually fills at. Null while no live rate has arrived, so callers render
  /// a loading / unavailable state rather than fake numbers.
  ///
  /// This screen used to price everything off `_selectedHolding.currentPrice`,
  /// which is both stale AND un-margined — and on a sell an un-margined rate
  /// OVERSTATES the proceeds by the whole margin, because a sell hits the
  /// swap's bid and fills BELOW the mid. The sell SHEET already applied
  /// `rate * (1 - margin)`; this screen, reachable from the same Sell action,
  /// did not. (The buy side is the mirror image: `rate * (1 + margin)`, which
  /// understated the cost — fixed in buy_crypto_screen._effectiveRate.)
  CryptoTradePricing get _pricing => CryptoTradePricing(
        isBuy: false,
        fiatCurrency: CurrencySymbols.currentCurrency,
        liveRate: _liveRate,
        swapMargin: _swapMargin,
      );

  double? get _effectiveRate => _pricing.executableRate;

  /// True once a live rate is available. Gates the CTA so a sale can never be
  /// composed against a price we don't currently have.
  bool get _hasLiveRate => (_liveRate ?? 0) > 0;

  /// True while the rate fetch is in flight with no fallback to show. Drives
  /// the order summary's loading render.
  bool get _isRateLoading =>
      _selectedHolding != null &&
      _amountController.text.isNotEmpty &&
      _liveRate == null;

  /// The platform fee for an arbitrary fiat gross, honouring the admin's
  /// percentage / cap / floor / fixed configuration (crypto.fee.sell.*).
  /// Falls back to the flat display rate before the config RPC lands.
  ///
  /// Taken as a function rather than read inline so CryptoTradeAmounts.estimate
  /// can price a hypothetical amount with the SAME rules the real fee uses — a
  /// cap or a floor applies at the amount being priced, not at whatever is
  /// currently typed.
  double _feeForFiat(double fiatGross) => _pricing.feeForFiat(fiatGross);

  /// THE trade, priced once — the same definition the sell SHEET uses, so the
  /// two routes to selling cannot quote different numbers for one trade.
  CryptoTradeAmounts get _amounts => CryptoTradeAmounts.estimate(
        isBuy: false,
        fiatCurrency: CurrencySymbols.currentCurrency,
        executableRate: _effectiveRate ?? 0,
        assetQuantity: _cryptoAmount,
        feeForFiatAmount: _feeForFiat,
      );

  /// What actually lands in the wallet: gross less our fee.
  double get _netProceeds => _amounts.receive;

  /// What one unit yields INCLUSIVE of our fee — the only rate the user can
  /// reconcile against the proceeds beneath it. Null while no live rate.
  double? _displayRate() {
    final qty = _cryptoAmount;
    if (qty <= 0) return _effectiveRate;
    final allIn = _amounts.allInRateFor(qty);
    return allIn > 0 ? allIn : _effectiveRate;
  }

  @override
  void initState() {
    super.initState();
    _selectedHolding = widget.selectedHolding;
    _amountController.addListener(_onAmountChanged);
    _setupAnimations();
    // Quidax-as-source-of-truth: refresh holdings from the backend
    // (which itself overlays Quidax-live balances on the mirror), so
    // an external-deposit crypto that arrived since the user opened
    // the app shows up in the Sell picker without a manual refresh.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // ignore: use_build_context_synchronously
      context.read<CryptoCubit>().refreshHoldingsLive();
    });
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
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

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

  /// Crypto quantity being sold — the field value directly in crypto mode, or
  /// the fiat value divided by the EXECUTABLE rate in fiat mode.
  double get _cryptoAmount {
    if (_amountController.text.isEmpty) return 0.0;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (_isAmountInCrypto) {
      return amount;
    }
    // Fiat-input mode: divide by the live executable rate. Without one we
    // honestly return 0 so callers know there is nothing trustworthy to show,
    // rather than dividing by a stale cached price.
    final r = _effectiveRate;
    if (r == null || r <= 0) return 0.0;
    return amount / r;
  }

  /// GROSS fiat value of the sale, before our fee. Always derived from the
  /// quantity times the executable rate (in fiat mode that is an exact round
  /// trip of what was typed), so the amount shown, the fee and the proceeds
  /// all describe one trade. The NET figure is [_netProceeds].
  double get _fiatAmount {
    if (_amountController.text.isEmpty || _selectedHolding == null) return 0.0;
    final r = _effectiveRate;
    if (r == null || r <= 0) return 0.0;
    return _cryptoAmount * r;
  }

  String _trimNum(double v) {
    if (!v.isFinite) return '';
    var s = v.toStringAsFixed(6);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }

  /// Flip the amount unit AND convert the entered value so the underlying
  /// value doesn't silently change meaning on toggle.
  void _toggleAmountUnit() {
    final fiat = _fiatAmount; // gross fiat value in the CURRENT mode
    // Convert at the EXECUTABLE rate, the same one every other figure uses —
    // converting at the stale cached price made the value jump on toggle.
    final rate = _effectiveRate ?? 0.0;
    setState(() {
      _isAmountInCrypto = !_isAmountInCrypto;
      if (fiat > 0 && rate > 0) {
        _amountController.text =
            _isAmountInCrypto ? _trimNum(fiat / rate) : fiat.toStringAsFixed(2);
      }
    });
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
                          if (_selectedHolding != null) ...[
                            SizedBox(height: 12.h),
                            PriceQuoteCard(
                              // Show the rate this trade actually FILLS at, not the raw
                              // order-book ticker. The screen's own maths already applies
                              // the swap margin, so displaying the unadjusted ticker put
                              // two different rates on one screen.
                              side: 'sell',
                              cryptoId: _selectedHolding!.cryptoId,
                              cryptoSymbol: _selectedHolding!.cryptoSymbol,
                              // The card already refetches every 30s; listen to it so
                              // proceeds are computed from the LIVE rate instead of the
                              // holding's cached currentPrice snapshot.
                              onRateUpdated: (r) {
                                if (mounted && r != _liveRate) {
                                  setState(() => _liveRate = r);
                                }
                              },
                              onSwapMarginUpdated: (m) {
                                if (mounted && m != _swapMargin) {
                                  setState(() => _swapMargin = m);
                                }
                              },
                              // The headline must be the rate the PROCEEDS below
                              // imply, fee included — otherwise the two numbers on
                              // one screen cannot be reconciled.
                              allInRate:
                                  _cryptoAmount > 0 ? _displayRate() : null,
                            ),
                          ],
                          SizedBox(height: 24.h),
                          _buildAmountInput(),
                          SizedBox(height: 24.h),
                          if (_selectedHolding != null &&
                              _amountController.text.isNotEmpty &&
                              _hasValidAmount)
                            _buildOrderSummary(),
                          if (_selectedHolding != null &&
                              _amountController.text.isNotEmpty &&
                              _hasValidAmount)
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
          // View wallet CTA — opens AssetWalletSheet for the active
          // holding (deposit address + QR + balance + market price).
          // Lighter text/icon for high contrast against the dark header.
          if (_selectedHolding != null) ...[
            GestureDetector(
              onTap: () => showAssetWalletSheet(
                context,
                cryptoSymbol: _selectedHolding!.cryptoSymbol,
                cryptoName: _selectedHolding!.cryptoName,
                balance: _selectedHolding!.quantity,
                fiatValue: _selectedHolding!.totalValue,
                currentPrice: _selectedHolding!.currentPrice,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                      color: const Color.fromARGB(255, 78, 3, 208)
                          .withValues(alpha: 0.5)),
                ),
                child: Row(children: [
                  Icon(Icons.account_balance_wallet_outlined,
                      color: Colors.white.withValues(alpha: 0.92), size: 16.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Wallet',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
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
            onTap: widget.lockHolding ? null : _showHoldingsBottomSheet,
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
                          colors: [
                            Colors.orange,
                            Colors.orange.withValues(alpha: 0.7)
                          ],
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
                        // The rate a SELL fills at, from the live quote — NOT
                        // the holding's cached currentPrice. Printing the
                        // stale, un-margined price here put a second,
                        // better-looking rate directly above the PriceQuoteCard
                        // and the proceeds, which is unreconcilable. '—' while
                        // no live rate has arrived; PriceQuoteCard below owns
                        // the loading/error affordance and the Retry button.
                        Text(
                          _effectiveRate == null
                              ? '—'
                              : '${CurrencySymbols.currentSymbol}${_effectiveRate!.toStringAsFixed(2)}',
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
                              color:
                                  _selectedHolding!.totalGainLossPercentage >= 0
                                      ? Colors.green
                                      : Colors.red,
                              size: 12.sp,
                            ),
                            Text(
                              '${_selectedHolding!.totalGainLossPercentage.abs().toStringAsFixed(2)}%',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color:
                                    _selectedHolding!.totalGainLossPercentage >=
                                            0
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
                  onTap: _toggleAmountUnit,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
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
                          _isAmountInCrypto
                              ? CurrencySymbols.currentCurrency
                              : 'Crypto',
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
          // Active network for the held asset (display only; the Quidax
          // balance is the same on every chain). heldHint forces it to
          // show since this screen renders from a holding.
          if (_selectedHolding != null) ...[
            SizedBox(height: 12.h),
            AssetNetworkBadge(
              symbol: _selectedHolding!.cryptoSymbol,
              heldHint: true,
              compact: true,
              onTap: () => showNetworkPickerForAsset(
                context,
                symbol: _selectedHolding!.cryptoSymbol,
              ),
            ),
          ],
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
                      _isAmountInCrypto
                          ? (_selectedHolding?.cryptoSymbol.toUpperCase() ?? '')
                          : CurrencySymbols.currentSymbol,
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$')),
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
                if (_selectedHolding != null &&
                    _amountController.text.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  // No live rate → say so. Converting at the stale cached
                  // price put a confident number here that the proceeds below
                  // then contradicted.
                  Text(
                    !_hasLiveRate
                        ? (_isRateLoading
                            ? 'Fetching live rate…'
                            : 'Rate unavailable')
                        : _isAmountInCrypto
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
              // FLOOR to 6dp — toStringAsFixed rounds, so "All" (100%) could
              // round the qty UP above the holding → instant "Insufficient
              // balance" and a disabled Sell button. (sell_crypto_sheet floors
              // for exactly this reason.)
              final raw = _selectedHolding!.quantity * percentage;
              _amountController.text =
                  ((raw * 1e6).floorToDouble() / 1e6).toStringAsFixed(6);
            });
          }
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
    // Display estimate; authoritative fee comes from server swap-quote
    // response.
    // ONE platform fee (spread). There is NO network fee on a sell — the crypto
    // moves sub→master as a zero-fee internal Quidax transfer. The old 30/70
    // "network/trading" split invented a fee category and misstated both.
    //
    // The card chrome is the same in all three states; only the body branches.
    // This used to ALWAYS compute, from `_selectedHolding.currentPrice` — a
    // stale entity field with no swap margin — so even while PriceQuoteCard
    // above said "Rate unavailable" these rows showed confident numbers, and
    // the un-margined rate OVERSTATED the proceeds on every sale.
    final Widget body;
    if (!_hasLiveRate) {
      body = _buildOrderSummaryUnavailable();
    } else {
      // ONE derivation, shared with the sell sheet. Deriving it here as
      // `_fiatAmount - _resolveFee()` off an un-margined rate was a second
      // definition that disagreed with the sheet for the same trade.
      final amounts = _amounts;
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('You sell',
              '${_cryptoAmount.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol.toUpperCase()}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Market value',
              '${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Fee',
              '${CurrencySymbols.currentSymbol}${amounts.feeInFiat.toStringAsFixed(2)}'),
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
          _buildSummaryRow('You receive',
              '${CurrencySymbols.currentSymbol}${amounts.receive.toStringAsFixed(2)}',
              isTotal: true),
        ],
      );
    }

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
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
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
          body,
        ],
      ),
    );
  }

  /// Body shown when no live rate has arrived: loading while the fetch is in
  /// flight, otherwise an honest "unavailable". Deliberately no numbers —
  /// PriceQuoteCard above owns the Retry affordance, so we don't duplicate it.
  Widget _buildOrderSummaryUnavailable() {
    final loading = _isRateLoading;
    return Row(
      children: [
        if (loading)
          SizedBox(
            width: 14.sp,
            height: 14.sp,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            ),
          )
        else
          Icon(Icons.cloud_off_outlined, color: Colors.orange, size: 16.sp),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            loading
                ? 'Fetching the live sell rate…'
                : 'Live rate unavailable — we can’t estimate your proceeds right now. Retry above.',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
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
          _buildDetailRow('Destination', 'Lazervault Balance'),
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
    // _hasLiveRate: refuse to transact without a current price, the same gate
    // the sell sheet and the buy screen apply.
    final isEnabled = _selectedHolding != null &&
        _hasValidAmount &&
        !_isTransacting &&
        _hasLiveRate;

    // Build validation error message
    String? validationError;
    if (_selectedHolding == null) {
      validationError = 'Please select a cryptocurrency holding';
    } else if (_amountController.text.isEmpty) {
      validationError = 'Please enter an amount to sell';
    } else if (!_hasValidAmount) {
      validationError = 'Amount exceeds your holding balance';
    } else if (!_hasLiveRate) {
      validationError = _isRateLoading
          ? 'Fetching the live sell rate…'
          : 'Live rate unavailable — retry the price above before selling';
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
        // Sell button
        GestureDetector(
          onTap: isEnabled ? _processSellOrder : _showDisabledButtonFeedback,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
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
              boxShadow: isEnabled
                  ? [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: _isTransacting
                ? Center(
                    child: LazerVaultLoader.small(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_circle_outline,
                        color: isEnabled ? Colors.white : Colors.grey,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Sell ${_selectedHolding?.cryptoSymbol.toUpperCase() ?? 'Crypto'}',
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
    // Show helpful message when disabled button is tapped
    if (_selectedHolding == null) {
      Get.snackbar(
        'Select Holding',
        'Please select a cryptocurrency holding to sell',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else if (_amountController.text.isEmpty || !_hasValidAmount) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount within your holding balance',
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
    } else if (!_hasLiveRate) {
      // Never let a sale be composed against a price we don't currently hold.
      Get.snackbar(
        _isRateLoading ? 'Fetching Rate' : 'Rate Unavailable',
        _isRateLoading
            ? 'Getting the live sell rate, one moment...'
            : 'We could not fetch a live sell rate. Retry the price above, then try again.',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _showHoldingsBottomSheet() {
    final cubitState = context.read<CryptoCubit>().state;
    if (cubitState is! CryptosLoaded) return;

    // Only show holdings for Quidax-supported assets
    final supportedSymbols =
        cubitState.supportedAssets.map((a) => a.symbol.toLowerCase()).toSet();
    final allHoldings = cubitState.holdings;
    final holdings = supportedSymbols.isNotEmpty
        ? allHoldings
            .where(
                (h) => supportedSymbols.contains(h.cryptoSymbol.toLowerCase()))
            .toList()
        : allHoldings;

    // Resolve holdings to Crypto objects for detail navigation
    final cryptoLookup = <String, Crypto>{};
    for (final c in cubitState.cryptos) {
      cryptoLookup[c.symbol.toLowerCase()] = c;
    }
    for (final c in cubitState.supportedAssets) {
      cryptoLookup[c.symbol.toLowerCase()] = c;
    }

    final searchNotifier = ValueNotifier<String>('');

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
                  hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5)),
                  prefixIcon: Icon(Icons.search,
                      color: Colors.white.withValues(alpha: 0.5)),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (v) => searchNotifier.value = v.toLowerCase(),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: holdings.isEmpty
                  ? Center(
                      child: Text(
                        'No holdings to sell',
                        style: GoogleFonts.inter(
                            color: Colors.grey[400], fontSize: 14.sp),
                      ),
                    )
                  : ValueListenableBuilder<String>(
                      valueListenable: searchNotifier,
                      builder: (context, query, _) {
                        final filtered = query.isEmpty
                            ? holdings
                            : holdings
                                .where((h) =>
                                    h.cryptoName
                                        .toLowerCase()
                                        .contains(query) ||
                                    h.cryptoSymbol
                                        .toLowerCase()
                                        .contains(query))
                                .toList();

                        if (filtered.isEmpty) {
                          return Center(
                            child: Text(
                              'No matching holdings',
                              style: GoogleFonts.inter(
                                  color: Colors.grey[400], fontSize: 14.sp),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return _buildHoldingItem(
                              filtered[index],
                              cryptoForDetail: cryptoLookup[
                                  filtered[index].cryptoSymbol.toLowerCase()],
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldingItem(CryptoHolding holding, {Crypto? cryptoForDetail}) {
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
                _selectedHolding = holding;
                // Drop the previous asset's rate so the screen shows the
                // loading state until PriceQuoteCard reports a new one — the
                // old rate belongs to a different coin entirely. (Same reset
                // buy_crypto_screen does on asset change.)
                _liveRate = null;
                _swapMargin = 0;
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
                      colors: [
                        Colors.orange,
                        Colors.orange.withValues(alpha: 0.7)
                      ],
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
          if (cryptoForDetail != null) ...[
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Get.back(); // close bottom sheet
                Get.toNamed(AppRoutes.cryptoDetails,
                    arguments: cryptoForDetail);
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
        ],
      ),
    );
  }

  void _processSellOrder() async {
    if (_selectedHolding == null ||
        !_hasValidAmount ||
        _isLoading ||
        _isTransacting ||
        // Mirrors the CTA gate: never open the quote flow against a price we
        // don't currently hold.
        !_hasLiveRate) return;

    // Fee display still shown to user via the PIN sheet; the actual platform
    // spread is computed server-side from system_settings.crypto.spread.*
    // basis points and applied during the swap-quotation flow. The local
    // estimate is the SHARED derivation (CryptoTradeAmounts.estimate off the
    // live, margin-adjusted sell rate), so the number the PIN sheet falls back
    // to can no longer be the un-margined one this screen used to show.
    final netProceeds = _netProceeds;
    final quantity = _cryptoAmount;

    // One id minted up-front for both the PIN token binding and the swap's
    // clientIntentId, so ConfirmSwap can validate the token against the row.
    final intentId = 'CRYPTO-SELL-${DateTime.now().millisecondsSinceEpoch}';

    setState(() => _isTransacting = true);

    // Quote-FIRST flow: show the live quote, then collect the PIN on Confirm.
    // We send the CRYPTO quantity as the swap from-amount (Quidax quotes
    // crypto->fiat denominated in the crypto); `fiatAmount` carries the expected
    // proceeds for the min-order check + receipt display. The PIN is collected
    // via requestPin from the quote sheet's Confirm and finalizes the sale.
    final result = await runSwapFlow(
      context: context,
      side: 'sell',
      cryptoSymbol: _selectedHolding!.cryptoSymbol,
      fiatAmount: netProceeds,
      cryptoAmount: quantity,
      description:
          'Sell ${quantity.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol.toUpperCase()}',
      clientIntentId: intentId,
      requestPin: (onValidated, quoted) async {
        // Authorise the SERVER's locked quote, which runSwapFlow hands in.
        //
        // Reading it from a cubit here does not work: the quote lives on an
        // isolated CryptoCubit inside runSwapFlow, so a local read silently
        // fell back to the on-screen estimate and asked the user to approve a
        // number that differed from the debit. `quoted` has no such gap —
        // it is re-read at confirm time, after the 15s timer's last refresh.
        //
        // The local estimate stays as the fallback for the (shouldn't happen)
        // case where the quote state was lost between confirm and PIN.
        return await validateTransactionPin(
          context: context,
          transactionId: intentId,
          transactionType: 'sell',
          amount: quoted.receive > 0 ? quoted.receive : netProceeds,
          currency: CurrencySymbols.currentCurrency,
          title: 'Confirm Sell Order',
          message:
              'Confirm sale of ${quantity.toStringAsFixed(6)} ${_selectedHolding!.cryptoSymbol.toUpperCase()}',
          totalAmount: quoted.receive > 0 ? quoted.receive : netProceeds,
          showProcessingPhase: true,
          successMessage: 'Order Placed',
          onPinValidated: (verificationToken) => onValidated(verificationToken),
        );
      },
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
  }
}
