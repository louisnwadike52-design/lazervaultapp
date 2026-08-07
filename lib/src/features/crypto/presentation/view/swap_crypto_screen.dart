import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/crypto_config_cubit.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../widgets/crypto_asset_avatar.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../widgets/asset_wallet_sheet.dart';
import '../widgets/asset_network_badge.dart';
import '../widgets/network_picker_sheet.dart';
import '../widgets/price_quote_card.dart';
import 'swap_flow_dispatcher.dart';
import 'all_assets_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
// Removed ServiceVoiceButton import per #212 — voice icons live on
// the parent crypto landing only; sub-screens like the swap detail
// inherit the session pinned by the landing's canonical button.
import 'package:lazervault/core/utils/currency_formatter.dart';

class SwapCryptoScreen extends StatefulWidget {
  final CryptoHolding? fromHolding;
  final Crypto? toCrypto;

  const SwapCryptoScreen({super.key, this.fromHolding, this.toCrypto});

  @override
  State<SwapCryptoScreen> createState() => _SwapCryptoScreenState();
}

class _SwapCryptoScreenState extends State<SwapCryptoScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
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
  bool _isTransacting = false;
  // The FROM amount can be typed in fiat or crypto. `_fromAmount` always returns
  // the from-crypto QUANTITY (converting when in fiat) so all downstream logic
  // (validation, rate, submit, summary) stays crypto-denominated and unchanged.
  bool _fromInFiat = false;
  double get _fromPrice => _fromHolding?.currentPrice ?? 0.0;

  void _toggleFromUnit() {
    if (_fromPrice <= 0) return;
    final typed = double.tryParse(_fromAmountController.text) ?? 0.0;
    _isUpdatingAmounts = true;
    setState(() {
      if (_fromInFiat) {
        _fromAmountController.text = typed > 0 ? (typed / _fromPrice).toStringAsFixed(6) : '';
      } else {
        _fromAmountController.text = typed > 0 ? (typed * _fromPrice).toStringAsFixed(2) : '';
      }
      _fromInFiat = !_fromInFiat;
    });
    _isUpdatingAmounts = false;
    _onFromAmountChanged();
  }

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  List<CryptoHolding> get _holdings {
    final state = context.read<CryptoCubit>().state;
    return state is CryptosLoaded ? state.holdings : [];
  }

  /// The ONLY assets valid on the "from" side: the ones the user actually
  /// holds a positive balance of. A zero-balance holding row is not something
  /// you can swap from, so it must never appear in the from selector or be
  /// reachable via the direction-flip.
  List<CryptoHolding> get _swappableHoldings =>
      _holdings.where((h) => h.quantity > 0).toList();

  List<Crypto> get _availableCryptos {
    final state = context.read<CryptoCubit>().state;
    if (state is CryptosLoaded) {
      // Use Quidax-supported assets for swap selection
      return state.supportedAssets.isNotEmpty ? state.supportedAssets : state.cryptos;
    }
    return [];
  }

  /// The user's positive-balance holding for [symbol], or null if not held.
  /// (Explicit loop instead of firstWhereOrNull to avoid a package:collection
  /// dependency.)
  CryptoHolding? _heldBySymbol(String symbol) {
    final s = symbol.toLowerCase();
    for (final h in _swappableHoldings) {
      if (h.cryptoSymbol.toLowerCase() == s) return h;
    }
    return null;
  }

  /// The Quidax-supported catalogue asset for [symbol], or null if absent.
  Crypto? _supportedBySymbol(String symbol) {
    final s = symbol.toLowerCase();
    for (final c in _availableCryptos) {
      if (c.symbol.toLowerCase() == s) return c;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _fromHolding = widget.fromHolding;
    _toCrypto = widget.toCrypto;
    // Never start with the same asset on both sides (you can't swap X into X).
    if (_fromHolding != null &&
        _toCrypto != null &&
        _fromHolding!.cryptoSymbol.toLowerCase() ==
            _toCrypto!.symbol.toLowerCase()) {
      _toCrypto = null;
    }
    _fromAmountController.addListener(_onFromAmountChanged);
    _toAmountController.addListener(_onToAmountChanged);
    _setupAnimations();

    // Load crypto data if not already loaded
    final cubit = context.read<CryptoCubit>();
    if (cubit.state is! CryptosLoaded) {
      cubit.loadCryptos();
    } else {
      // Already loaded — still ask the backend for the latest holdings
      // (it overlays Quidax-live balances on the mirror) so an external
      // deposit that landed on Quidax since the last landing-page load
      // shows up here without a manual refresh. Quidax is the source
      // of truth.
      cubit.refreshHoldingsLive();
    }
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

  /// Prevent listener re-entrancy when one field programmatically sets the other.
  bool _isUpdatingAmounts = false;

  void _onFromAmountChanged() {
    if (_isUpdatingAmounts) return;
    if (_isFromAmountActive && _fromHolding != null && _toCrypto != null) {
      final fromAmount = _fromAmount; // crypto qty (converts if typed in fiat)
      if (_toCrypto!.currentPrice <= 0) return; // Guard division by zero
      final gbpValue = fromAmount * _fromHolding!.currentPrice;
      final toAmount = gbpValue / _toCrypto!.currentPrice;
      _isUpdatingAmounts = true;
      _toAmountController.text = toAmount > 0 ? toAmount.toStringAsFixed(6) : '';
      _isUpdatingAmounts = false;
    }
    setState(() {});
  }

  void _onToAmountChanged() {
    if (_isUpdatingAmounts) return;
    if (!_isFromAmountActive && _fromHolding != null && _toCrypto != null) {
      final toAmount = double.tryParse(_toAmountController.text) ?? 0.0;
      if (_fromHolding!.currentPrice <= 0) return; // Guard division by zero
      final gbpValue = toAmount * _toCrypto!.currentPrice;
      final fromCryptoQty = gbpValue / _fromHolding!.currentPrice;
      _isUpdatingAmounts = true;
      // Mirror the FROM field in whichever unit it's currently showing.
      _fromAmountController.text = fromCryptoQty > 0
          ? (_fromInFiat
              ? gbpValue.toStringAsFixed(2)
              : fromCryptoQty.toStringAsFixed(6))
          : '';
      _isUpdatingAmounts = false;
    }
    setState(() {});
  }

  // The from-crypto QUANTITY, whether the user typed fiat or crypto.
  double get _fromAmount {
    final typed = double.tryParse(_fromAmountController.text) ?? 0.0;
    if (_fromInFiat) return _fromPrice > 0 ? typed / _fromPrice : 0.0;
    return typed;
  }

  double get _toAmount => double.tryParse(_toAmountController.text) ?? 0.0;
  
  bool get _hasValidAmount {
    if (_fromHolding == null) return false;
    return _fromAmount > 0 && _fromAmount <= _fromHolding!.quantity;
  }

  double get _exchangeRate {
    if (_fromHolding == null || _toCrypto == null) return 0.0;
    // Displayed as "1 <from> → X <to>", so X = value-of-one-from expressed in to
    // = fromPrice / toPrice. (Previously toPrice/fromPrice, which is the INVERSE
    // and rendered e.g. "1 TRX → 3.068 USDT" instead of 0.325.)
    if (_toCrypto!.currentPrice <= 0) return 0.0; // Guard division by zero
    return _fromHolding!.currentPrice / _toCrypto!.currentPrice;
  }

  /// Resolves an asset's real logo URL by ticker from the CryptoCubit catalogue
  /// (holdings + supported + full list all carry the `image`). Null when not
  /// found → [CryptoAssetAvatar] renders its per-symbol initials chip. Ensures
  /// USDT/TRX/etc. never borrow the Bitcoin icon.
  String? _imageForSymbol(String symbol) {
    final s = symbol.trim().toLowerCase();
    if (s.isEmpty) return null;
    try {
      final st = context.read<CryptoCubit>().state;
      if (st is! CryptosLoaded) return null;
      for (final c in [...st.cryptos, ...st.supportedAssets]) {
        if (c.symbol.toLowerCase() == s && c.image.trim().isNotEmpty) {
          return c.image;
        }
      }
    } catch (_) {
      // No CryptoCubit in scope → avatar shows its initials chip.
    }
    return null;
  }

  /// Keeps the active "from" holding in sync with the freshest balances. When
  /// refreshHoldingsLive() (or any cubit update) lands new holdings, the
  /// captured _fromHolding can go stale: its balance may have changed, or the
  /// user may no longer hold it at all (e.g. it was fully swapped/sent from
  /// another surface). We re-point it at the fresh holding, and DROP it when
  /// the balance hits zero — preserving the "from is always an asset you own"
  /// invariant even while the screen is open.
  void _reconcileFromHolding(BuildContext context, CryptoState state) {
    if (state is! CryptosLoaded) return;
    final fh = _fromHolding;
    if (fh == null) return;
    CryptoHolding? fresh;
    for (final h in state.holdings) {
      if (h.cryptoSymbol.toLowerCase() == fh.cryptoSymbol.toLowerCase()) {
        fresh = h;
        break;
      }
    }
    if (fresh == null || fresh.quantity <= 0) {
      // No longer held → force a re-selection.
      setState(() {
        _fromHolding = null;
        _fromAmountController.clear();
        _toAmountController.clear();
      });
    } else if (fresh.quantity != fh.quantity ||
        fresh.currentPrice != fh.currentPrice) {
      setState(() => _fromHolding = fresh);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CryptoCubit, CryptoState>(
      listener: _reconcileFromHolding,
      child: Scaffold(
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
                          _buildSwapInterface(),
                          if (_fromHolding != null || _toCrypto != null) ...[
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                if (_fromHolding != null)
                                  Expanded(
                                    child: PriceQuoteCard(
                                      cryptoId: _fromHolding!.cryptoId,
                                      cryptoSymbol: _fromHolding!.cryptoSymbol,
                                    ),
                                  ),
                                if (_fromHolding != null && _toCrypto != null)
                                  SizedBox(width: 8.w),
                                if (_toCrypto != null)
                                  Expanded(
                                    child: PriceQuoteCard(
                                      cryptoId: _toCrypto!.id,
                                      cryptoSymbol: _toCrypto!.symbol,
                                    ),
                                  ),
                              ],
                            ),
                          ],
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
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // View wallet CTA — opens AssetWalletSheet for the from-side
          // holding (address + QR + balance + market price). Lighter
          // text/icon for high contrast against the dark header.
          if (_fromHolding != null) ...[
            GestureDetector(
              onTap: () => showAssetWalletSheet(
                context,
                cryptoSymbol: _fromHolding!.cryptoSymbol,
                cryptoName: _fromHolding!.cryptoName,
                balance: _fromHolding!.quantity,
                fiatValue: _fromHolding!.totalValue,
                currentPrice: _fromHolding!.currentPrice,
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
                      color: Colors.white.withValues(alpha: 0.92),
                      size: 16.sp),
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
              color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.swap_horiz,
              color: const Color.fromARGB(255, 78, 3, 208),
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
          // Informational: which network the from-asset lives on. Swap is
          // balance-only and network-agnostic (Quidax unified balance), so
          // this is display only. heldHint forces it to show since it renders
          // from a holding.
          if (_fromHolding != null) ...[
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerLeft,
              child: AssetNetworkBadge(
                symbol: _fromHolding!.cryptoSymbol,
                heldHint: true,
                compact: true,
                onTap: () => showNetworkPickerForAsset(
                  context,
                  symbol: _fromHolding!.cryptoSymbol,
                ),
              ),
            ),
          ],
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
                            const Color.fromARGB(255, 78, 3, 208),
                            const Color(0xFF8B7CF6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // FROM amount unit toggle (fiat <-> crypto).
                if (isFrom && price > 0) ...[
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _toggleFromUnit,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9F7AEA).withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: const Color(0xFF9F7AEA).withValues(alpha: 0.35)),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          _fromInFiat
                              ? CurrencySymbols.currentCurrency.toUpperCase()
                              : symbol.toUpperCase(),
                          style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF9F7AEA)),
                        ),
                        SizedBox(width: 3.w),
                        Icon(Icons.swap_vert_rounded,
                            size: 13.sp, color: const Color(0xFF9F7AEA)),
                      ]),
                    ),
                  ),
                ],
              ]),
              if (balance != null)
                GestureDetector(
                  onTap: () {
                    if (balance > 0) {
                      setState(() {
                        _isFromAmountActive = true;
                        controller.text = (isFrom && _fromInFiat && price > 0)
                            ? (balance * price).toStringAsFixed(2)
                            : balance.toStringAsFixed(6);
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                          const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      (isFrom && _fromInFiat && price > 0)
                          ? 'Max: ${CurrencySymbols.currentSymbol}${(balance * price).toStringAsFixed(2)}'
                          : 'Max: ${balance.toStringAsFixed(6)}',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 78, 3, 208),
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
                    isEmpty
                        ? Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.withValues(alpha: 0.3),
                                  Colors.grey.withValues(alpha: 0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(Icons.add, color: Colors.white, size: 20.sp),
                          )
                        : CryptoAssetAvatar(
                            symbol: symbol,
                            imageUrl: _imageForSymbol(symbol),
                            size: 40,
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
                              ? Colors.white.withValues(alpha: 0.6)
                              : Colors.white,
                          ),
                        ),
                        if (symbol.isNotEmpty)
                          Text(
                            symbol.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: const Color.fromARGB(255, 78, 3, 208),
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
                        color: Colors.white.withValues(alpha: 0.3),
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
                  '${CurrencySymbols.currentSymbol}${price.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                if (controller.text.isNotEmpty)
                  Text(
                    (isFrom && _fromInFiat && price > 0)
                        ? '≈ ${((double.tryParse(controller.text) ?? 0.0) / price).toStringAsFixed(6)} ${symbol.toUpperCase()}'
                        : '≈ ${CurrencySymbols.currentSymbol}${(price * (double.tryParse(controller.text) ?? 0.0)).toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
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
                color: Colors.red.withValues(alpha: 0.1),
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
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
                color: const Color.fromARGB(255, 78, 3, 208),
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
                    color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: const Color.fromARGB(255, 78, 3, 208),
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
                    color: const Color.fromARGB(255, 78, 3, 208),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${_exchangeRate.toStringAsFixed(6)} ${_toCrypto!.symbol.toUpperCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color.fromARGB(255, 78, 3, 208),
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
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapSummary() {
    // Lazervault swap fee honoring the admin config (crypto.fee.swap.*).
    // A crypto→crypto swap has no fiat leg, so it is percentage-only; the basis
    // is the from-asset's fiat value. Falls back to 0.5% before config loads.
    final fiatValue = _fromAmount * _fromHolding!.currentPrice;
    double fee;
    try {
      fee = GetIt.I<CryptoConfigCubit>()
          .config
          .feeForOp('swap', fiatValue, CurrencySymbols.currentCurrency);
    } catch (_) {
      fee = fiatValue * 0.005;
    }
    final networkFee = fee * 0.3;
    final tradingFee = fee * 0.7;
    final effectiveRate = _fromAmount > 0 ? _toAmount / _fromAmount : 0.0;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
                color: const Color.fromARGB(255, 78, 3, 208),
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
          _buildSummaryRow('Network fee', '${CurrencySymbols.currentSymbol}${networkFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Trading fee', '${CurrencySymbols.currentSymbol}${tradingFee.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Effective rate', '1 ${_fromHolding!.cryptoSymbol.toUpperCase()} = ${effectiveRate.toStringAsFixed(6)} ${_toCrypto!.symbol.toUpperCase()}'),
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
            color: Colors.white.withValues(alpha: isTotal ? 1.0 : 0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: isTotal ? const Color.fromARGB(255, 78, 3, 208) : Colors.white,
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
        Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 16.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
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
        Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.4), size: 16.sp),
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
              'Cryptocurrency swaps are subject to market volatility and slippage. The final amount may differ from the estimate due to rapid price changes.',
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
            child: _isLoading
              ? Center(
                  child: LazerVaultLoader.small(),
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
    if (_fromHolding == null || _toCrypto == null) return;

    // The "from" side may only ever be an asset the user holds. A flip would
    // move the current TO asset onto the FROM side, so it's only valid when the
    // user actually holds that TO asset with a positive balance.
    final targetHolding = _heldBySymbol(_toCrypto!.symbol);
    if (targetHolding == null) {
      Get.snackbar(
        "You don't hold ${_toCrypto!.symbol.toUpperCase()}",
        'You can only swap from assets you own. Buy ${_toCrypto!.symbol.toUpperCase()} first to swap out of it.',
        backgroundColor: const Color(0xFF1F1F1F),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Resolve the new TO asset (the previous FROM). It came from a holding, so
    // it should be in the supported catalogue; if not, abort cleanly rather
    // than crash (the old firstWhere had no orElse).
    final newTo = _supportedBySymbol(_fromHolding!.cryptoSymbol);
    if (newTo == null) {
      Get.snackbar(
        "Can't reverse this pair",
        '${_fromHolding!.cryptoSymbol.toUpperCase()} isn\'t available to swap into right now.',
        backgroundColor: const Color(0xFF1F1F1F),
        colorText: Colors.white,
      );
      return;
    }

    _swapAnimationController.forward().then((_) {
      _swapAnimationController.reset();
    });
    setState(() {
      _fromHolding = targetHolding;
      _toCrypto = newTo;
      _fromAmountController.clear();
      _toAmountController.clear();
    });
  }

  void _showCryptoSelector(bool isFrom) {
    _searchController.clear();
    var query = '';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final q = query.trim().toLowerCase();
          // Exclude the counterpart asset so a user can't pick X on both
          // sides (you can't swap an asset into itself).
          final excludeSymbol = (isFrom
                  ? _toCrypto?.symbol
                  : _fromHolding?.cryptoSymbol)
              ?.toLowerCase();

          // FROM lists ONLY the user's positive-balance holdings; TO lists the
          // Quidax-supported catalogue. Both honour the live search query.
          final fromList = isFrom
              ? _swappableHoldings.where((h) {
                  if (excludeSymbol != null &&
                      h.cryptoSymbol.toLowerCase() == excludeSymbol) {
                    return false;
                  }
                  if (q.isEmpty) return true;
                  return h.cryptoName.toLowerCase().contains(q) ||
                      h.cryptoSymbol.toLowerCase().contains(q);
                }).toList()
              : const <CryptoHolding>[];
          final toList = !isFrom
              ? _availableCryptos.where((c) {
                  if (excludeSymbol != null &&
                      c.symbol.toLowerCase() == excludeSymbol) {
                    return false;
                  }
                  if (q.isEmpty) return true;
                  return c.name.toLowerCase().contains(q) ||
                      c.symbol.toLowerCase().contains(q);
                }).toList()
              : const <Crypto>[];

          final isListEmpty = isFrom ? fromList.isEmpty : toList.isEmpty;
          final noHoldingsAtAll = isFrom && _swappableHoldings.isEmpty;

          return Container(
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
                          isFrom
                              ? 'Select crypto to swap from'
                              : 'Select crypto to swap to',
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
                // No search bar when the from side has nothing to search.
                if (!noHoldingsAtAll)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setSheetState(() => query = v),
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: isFrom
                            ? 'Search your holdings...'
                            : 'Search cryptocurrencies...',
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
                    ),
                  ),
                SizedBox(height: 16.h),
                Expanded(
                  child: isListEmpty
                      ? _buildSelectorEmptyState(
                          isFrom: isFrom,
                          noHoldingsAtAll: noHoldingsAtAll,
                          hasQuery: q.isNotEmpty,
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          itemCount: isFrom ? fromList.length : toList.length,
                          itemBuilder: (context, index) {
                            if (isFrom) {
                              return _buildHoldingOption(fromList[index]);
                            }
                            return _buildCryptoOption(toList[index]);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Empty state for the crypto selector. Three cases:
  ///  - FROM with no positive-balance holdings at all: nudge to buy first.
  ///  - active search with no matches: "no results".
  ///  - otherwise: nothing available.
  Widget _buildSelectorEmptyState({
    required bool isFrom,
    required bool noHoldingsAtAll,
    required bool hasQuery,
  }) {
    final IconData icon;
    final String title;
    final String subtitle;
    if (noHoldingsAtAll) {
      icon = Icons.account_balance_wallet_outlined;
      title = 'No crypto to swap from';
      subtitle =
          'You can only swap assets you already own. Buy some crypto first, then come back to swap it.';
    } else if (hasQuery) {
      icon = Icons.search_off_rounded;
      title = 'No matches';
      subtitle = isFrom
          ? "None of your holdings match that search."
          : "No supported asset matches that search.";
    } else {
      icon = Icons.inbox_outlined;
      title = isFrom ? 'No holdings available' : 'Nothing available';
      subtitle = isFrom
          ? 'You have no other asset to swap from right now.'
          : 'No other asset is available to swap into right now.';
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 56.sp, color: Colors.white.withValues(alpha: 0.35)),
          SizedBox(height: 16.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.4,
            ),
          ),
          if (noHoldingsAtAll) ...[
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () async {
                // `context` here is the State's context (this method is an
                // instance method), which carries the CryptoCubit provider.
                final cubit = context.read<CryptoCubit>();
                Get.back(); // close the selector sheet
                // Route into the integrated buy path (asset picker → buy bottom
                // sheet) with the shared cubit.
                await Get.to(() => BlocProvider.value(
                      value: cubit,
                      child: const AllAssetsScreen(mode: AssetSelectionMode.buy),
                    ));
                // Pull fresh holdings so a just-bought asset is immediately
                // swappable without a manual refresh.
                if (mounted) cubit.refreshHoldingsLive();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 78, 3, 208),
                      Color(0xFF8B7CF6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Buy crypto',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            CryptoAssetAvatar(
              symbol: holding.cryptoSymbol,
              imageUrl: _imageForSymbol(holding.cryptoSymbol),
              size: 40,
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
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            CryptoAssetAvatar(
              symbol: crypto.symbol,
              imageUrl: crypto.image,
              size: 40,
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
    );
  }

  Future<void> _processSwapOrder() async {
    if (_fromHolding == null || _toCrypto == null || !_hasValidAmount || _isLoading || _isTransacting) return;
    // Prevent swapping same crypto to same crypto
    if (_fromHolding!.cryptoId == _toCrypto!.id ||
        _fromHolding!.cryptoSymbol.toLowerCase() == _toCrypto!.symbol.toLowerCase()) {
      Get.snackbar(
        'Invalid Swap',
        'Cannot swap a cryptocurrency for itself. Please select a different target.',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final fromSymbol = _fromHolding!.cryptoSymbol;
    final toSymbol = _toCrypto!.symbol;
    final fromAmount = _fromAmount;

    // One id minted up-front for both the PIN token binding and the swap's
    // clientIntentId, so ConfirmSwap can validate the token against the row.
    final intentId = 'CRYPTO-CONVERT-${DateTime.now().millisecondsSinceEpoch}';

    setState(() => _isTransacting = true);

    // Quote-FIRST flow: show the live convert quote, then collect the PIN on
    // Confirm (which finalizes the convert). side="convert" with `fiatAmount`
    // reinterpreted as the from-side major units (e.g. 0.001 BTC); the server
    // saga handles min-order / pair support / hold lifecycle.
    final result = await runSwapFlow(
      context: context,
      side: 'convert',
      fromCryptoSymbol: fromSymbol,
      cryptoSymbol: toSymbol,
      fiatAmount: fromAmount,
      description: 'Convert ${fromAmount.toStringAsFixed(6)} '
          '${fromSymbol.toUpperCase()} → ${toSymbol.toUpperCase()}',
      clientIntentId: intentId,
      requestPin: (onValidated) async {
        return await validateTransactionPin(
          context: context,
          transactionId: intentId,
          transactionType: 'swap',
          amount: fromAmount,
          currency: fromSymbol.toUpperCase(),
          title: 'Confirm Convert',
          message: 'Convert ${fromAmount.toStringAsFixed(6)} '
              '${fromSymbol.toUpperCase()} → ${toSymbol.toUpperCase()}',
          showProcessingPhase: true,
          successMessage: 'Convert Submitted',
          onPinValidated: (verificationToken) => onValidated(verificationToken),
        );
      },
    );

    if (!mounted) return;
    if (!result.initiated && (result.message ?? '').isNotEmpty) {
      Get.snackbar('Convert failed', result.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    setState(() => _isTransacting = false);
  }
}
