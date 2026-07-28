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
import '../../cubit/crypto_config_cubit.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../../../../../core/services/injection_container.dart';
import '../widgets/asset_network_badge.dart';
import '../widgets/network_picker_sheet.dart';
import '../widgets/price_quote_card.dart';
import 'swap_flow_dispatcher.dart';

/// Streamlined SELL bottom sheet.
///
/// Opened from a crypto detail page (or anywhere the asset is already known),
/// so there is NO asset-selection step — the crypto is pre-selected and
/// locked. The user enters an amount (rate auto-computed live via
/// [PriceQuoteCard] + the inline ≈ fiat preview) and taps Sell, which runs the
/// exact same [runSwapFlow] pipeline as the full sell screen: live quote →
/// transaction PIN → outcome. Keeps the sheet decoupled from the broken
/// holdings-picker path.
Future<void> showSellCryptoSheet(
  BuildContext context, {
  required Crypto crypto,
  CryptoHolding? holding,
  CryptoCubit? cubit,
}) {
  final CryptoCubit c = cubit ?? context.read<CryptoCubit>();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: c,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SellCryptoSheet(crypto: crypto, initialHolding: holding),
      ),
    ),
  );
}

class SellCryptoSheet extends StatefulWidget {
  final Crypto crypto;
  final CryptoHolding? initialHolding;

  const SellCryptoSheet({super.key, required this.crypto, this.initialHolding});

  @override
  State<SellCryptoSheet> createState() => _SellCryptoSheetState();
}

class _SellCryptoSheetState extends State<SellCryptoSheet>
    with TransactionPinMixin {
  final TextEditingController _amountController = TextEditingController();
  CryptoHolding? _holding;
  bool _isTransacting = false;
  bool _holdingLoaded = false;
  // Which unit the amount field currently accepts. Toggle flips it and
  // converts the current value so the trade size is preserved across units.
  // Defaults to FIAT (NGN) so a seller thinks in "how much money do I want",
  // matching the buy sheet and the user's expectation.
  bool _isAmountInCrypto = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _holding = widget.initialHolding;
    _holdingLoaded = widget.initialHolding != null;
    _amountController.addListener(() => setState(() {}));
    // Resolve the live balance directly from the repository — independent of
    // the cubit's state. The cubit's refreshHoldingsLive() no-ops unless the
    // cubit is already CryptosLoaded, which a detail-screen's fresh cubit is
    // NOT, so relying on it strands the sheet on "Loading your balance…".
    _loadHolding();
    // Warm the per-token Quidax min-order limits for validation + display.
    try {
      GetIt.I<CryptoConfigCubit>().load();
    } catch (_) {}
  }

  /// Quidax minimum order value for this token, in fiat major units. Sourced
  /// from GetCryptoConfig's min_order map — per-token (from Quidax GET /markets
  /// minimum_order_size) with the flat currency floor as fallback. 0 = unknown
  /// (the backend still enforces Quidax's real floor on the quote).
  double _minFiat() {
    int? minor;
    try {
      final cfg = GetIt.I<CryptoConfigCubit>().config;
      minor = cfg.minOrderFor(widget.crypto.symbol) ??
          cfg.minOrderFor(CurrencySymbols.currentCurrency);
    } catch (_) {}
    return (minor ?? 0) / 100.0;
  }

  Future<void> _loadHolding() async {
    try {
      final holdings =
          await serviceLocator<CryptoRepository>().getHoldings(unitsOnly: true);
      if (!mounted) return;
      CryptoHolding? found;
      for (final h in holdings) {
        if (h.cryptoId == widget.crypto.id ||
            h.cryptoSymbol.toLowerCase() ==
                widget.crypto.symbol.toLowerCase()) {
          found = h;
          break;
        }
      }
      setState(() {
        if (found != null) _holding = found;
        _holdingLoaded = true;
      });
    } catch (_) {
      if (mounted) setState(() => _holdingLoaded = true);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

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

  /// Estimated Lazervault sell fee for the current amount, honoring the admin's
  /// percentage/fixed config (crypto.fee.sell.*). Falls back to the flat display
  /// rate before the config RPC lands.
  double _resolveFee() {
    try {
      return GetIt.I<CryptoConfigCubit>()
          .config
          .feeForOp('sell', _fiatAmount, CurrencySymbols.currentCurrency);
    } catch (_) {
      return _fiatAmount * _feeDisplayRate();
    }
  }

  /// Resolve the user's holding for this crypto from the latest cubit state,
  /// falling back to whatever was passed in. Matches by id first, then symbol.
  CryptoHolding? _resolveHolding(CryptoState state) {
    if (state is CryptosLoaded) {
      for (final h in state.holdings) {
        if (h.cryptoId == widget.crypto.id ||
            h.cryptoSymbol.toLowerCase() == widget.crypto.symbol.toLowerCase()) {
          return h;
        }
      }
    }
    return _holding;
  }

  double _price() {
    final p = _holding?.currentPrice ?? 0.0;
    return p > 0 ? p : widget.crypto.currentPrice;
  }

  /// The raw number typed in the field, interpreted per the active unit.
  double get _typedAmount => double.tryParse(_amountController.text) ?? 0.0;

  /// Crypto quantity being sold — the field value directly in crypto mode, or
  /// the fiat value divided by the live price in fiat mode.
  double get _cryptoAmount {
    if (_isAmountInCrypto) return _typedAmount;
    final p = _price();
    return p > 0 ? _typedAmount / p : 0.0;
  }

  /// Fiat proceeds — the field value directly in fiat mode, or the crypto
  /// quantity times the live price in crypto mode.
  double get _fiatAmount {
    if (_isAmountInCrypto) return _typedAmount * _price();
    return _typedAmount;
  }

  bool get _hasValidAmount {
    final h = _holding;
    if (h == null) return false;
    final min = _minFiat();
    return _cryptoAmount > 0 &&
        _cryptoAmount <= h.quantity &&
        (min <= 0 || _fiatAmount >= min);
  }

  /// Inline validation message (null when the amount is acceptable).
  String? _amountError() {
    final h = _holding;
    if (h == null || _amountController.text.isEmpty) return null;
    if (_cryptoAmount <= 0) return null;
    if (_cryptoAmount > h.quantity) {
      return 'You only hold ${h.quantity.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()}';
    }
    final min = _minFiat();
    if (min > 0 && _fiatAmount < min) {
      return 'Minimum is ${CurrencySymbols.currentSymbol}${min.toStringAsFixed(2)}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        // Keep the resolved holding fresh as live balances land.
        final resolved = _resolveHolding(state);
        if (resolved != null) _holding = resolved;
        final h = _holding;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                _buildAssetHeader(h),
                SizedBox(height: 16.h),
                PriceQuoteCard(
                  cryptoId: widget.crypto.id,
                  cryptoSymbol: widget.crypto.symbol,
                ),
                SizedBox(height: 20.h),
                _buildAmountField(h),
                SizedBox(height: 16.h),
                if (h != null && _amountController.text.isNotEmpty && _hasValidAmount)
                  _buildOrderSummary(),
                SizedBox(height: 20.h),
                _buildSellButton(h),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAssetHeader(CryptoHolding? h) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(Icons.remove_circle_outline, color: Colors.red, size: 22.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sell ${widget.crypto.name}',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                h != null
                    ? 'You hold ${h.quantity.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()} ≈ ${CurrencySymbols.currentSymbol}${(h.quantity * _price()).toStringAsFixed(2)}'
                    : (_holdingLoaded
                        ? 'You don’t hold any ${widget.crypto.symbol.toUpperCase()}'
                        : 'Loading your balance…'),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              // Active network for the held asset (display only; the Quidax
              // balance is the same on every chain). heldHint forces it to
              // show since this sheet renders from a holding.
              if (h != null) ...[
                SizedBox(height: 6.h),
                AssetNetworkBadge(
                  symbol: h.cryptoSymbol,
                  heldHint: true,
                  compact: true,
                  onTap: () => showNetworkPickerForAsset(
                    context,
                    symbol: h.cryptoSymbol,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Trim a crypto quantity to a clean string (≤6 dp, no trailing zeros).
  String _trimNum(double v) {
    var s = v.toStringAsFixed(6);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }

  /// Flip the input unit, converting the current value so the trade size the
  /// user already entered is preserved across the switch.
  void _toggleUnit() {
    final crypto = _cryptoAmount; // unit-agnostic current quantity
    setState(() {
      _isAmountInCrypto = !_isAmountInCrypto;
      if (crypto > 0) {
        _amountController.text = _isAmountInCrypto
            ? _trimNum(crypto)
            : (crypto * _price()).toStringAsFixed(2);
      }
    });
  }

  void _fillMax(CryptoHolding h) {
    setState(() {
      _amountController.text = _isAmountInCrypto
          ? _trimNum(h.quantity)
          : (h.quantity * _price()).toStringAsFixed(2);
    });
  }

  Widget _buildAmountField(CryptoHolding? h) {
    final unitLabel = _isAmountInCrypto
        ? widget.crypto.symbol.toUpperCase()
        : CurrencySymbols.currentCurrency.toUpperCase();
    // The "switch to" unit shown on the toggle chip.
    final altLabel = _isAmountInCrypto
        ? CurrencySymbols.currentCurrency.toUpperCase()
        : widget.crypto.symbol.toUpperCase();
    // The ≈ conversion line shows the opposite unit.
    final approx = _isAmountInCrypto
        ? '≈ ${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'
        : '≈ ${_trimNum(_cryptoAmount)} ${widget.crypto.symbol.toUpperCase()}';
    final hasError = _amountError() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF161616), Color(0xFF0C0C0C)],
            ),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: hasError
                  ? const Color(0xFFEF4444).withValues(alpha: 0.55)
                  : const Color(0xFF7C3AED).withValues(alpha: 0.28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.28),
                blurRadius: 14,
                offset: const Offset(0, 5),
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
                    'Amount to sell',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  Row(
                    children: [
                      _unitToggleChip(altLabel),
                      if (h != null) ...[
                        SizedBox(width: 8.w),
                        _maxChip(() => _fillMax(h)),
                      ],
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _assetChip(),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      ],
                      style: GoogleFonts.inter(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: '0.00',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    unitLabel,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF9F7AEA),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(approx,
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.white.withValues(alpha: 0.55))),
                  _buildLimitsHint(h),
                ],
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Row(children: [
              Icon(Icons.error_outline,
                  size: 13.sp, color: const Color(0xFFEF4444)),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(_amountError()!,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: const Color(0xFFEF4444))),
              ),
            ]),
          ),
      ],
    );
  }

  /// Gradient asset avatar — mirrors the swap page's crypto chip. Shows the
  /// ticker's leading letter over a purple gradient so the card reads as "this
  /// asset" at a glance without a network icon fetch.
  Widget _assetChip() {
    final sym = widget.crypto.symbol.toUpperCase();
    return Container(
      width: 44.w,
      height: 44.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B5CF6), Color(0xFF4E03D0)],
        ),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        sym.isNotEmpty ? sym[0] : '?',
        style: GoogleFonts.inter(
            fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  /// Unit toggle chip (crypto ⇄ fiat) styled to the swap-page purple accent.
  Widget _unitToggleChip(String altLabel) {
    return GestureDetector(
      onTap: _toggleUnit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(0xFF7C3AED).withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(9.r),
          border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.3)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.swap_vert, size: 14.sp, color: const Color(0xFF9F7AEA)),
          SizedBox(width: 4.w),
          Text(altLabel,
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9F7AEA))),
        ]),
      ),
    );
  }

  /// "Max" chip — fills the field with the seller's full holding.
  Widget _maxChip(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(9.r),
          border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
        ),
        child: Text('Max',
            style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B82F6))),
      ),
    );
  }

  /// Min (Quidax) / Max (your holding value) hint with a loading state while
  /// the config that carries the per-token Quidax minimum is still fetching.
  Widget _buildLimitsHint(CryptoHolding? h) {
    return BlocBuilder<CryptoConfigCubit, CryptoConfigState>(
      bloc: GetIt.I<CryptoConfigCubit>(),
      builder: (context, cfgState) {
        final loading = cfgState is CryptoConfigInitial || cfgState is CryptoConfigLoading;
        final sym = CurrencySymbols.currentSymbol;
        if (loading) {
          return Text('Loading limits…',
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.4)));
        }
        final min = _minFiat();
        final maxFiat = (h?.quantity ?? 0) * _price();
        final parts = <String>[];
        if (min > 0) parts.add('Min $sym${min.toStringAsFixed(0)}');
        if (maxFiat > 0) parts.add('Max $sym${maxFiat.toStringAsFixed(0)}');
        return Text(parts.join(' · '),
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.45)));
      },
    );
  }

  Widget _buildOrderSummary() {
    final fee = _resolveFee();
    final net = _fiatAmount - fee;
    final sym = CurrencySymbols.currentSymbol;
    Widget row(String l, String r, {bool bold = false}) => Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.7))),
              Text(r,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                      color: bold ? const Color(0xFF10B981) : Colors.white)),
            ],
          ),
        );
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          row('You sell',
              '${_cryptoAmount.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()}'),
          row('Gross', '$sym${_fiatAmount.toStringAsFixed(2)}'),
          row('Fee (approx)', '$sym${fee.toStringAsFixed(2)}'),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 16.h),
          row('You receive', '$sym${net.toStringAsFixed(2)}', bold: true),
        ],
      ),
    );
  }

  Widget _buildSellButton(CryptoHolding? h) {
    final enabled = h != null && _hasValidAmount && !_isTransacting;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? _processSellOrder : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),
          disabledBackgroundColor: const Color(0xFF2D2D2D),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: _isTransacting
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Text(
                'Sell ${widget.crypto.symbol.toUpperCase()}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _processSellOrder() async {
    final h = _holding;
    if (h == null || !_hasValidAmount || _isTransacting) return;

    final fee = _resolveFee();
    final netProceeds = _fiatAmount - fee;
    final quantity = _cryptoAmount;
    final intentId = 'CRYPTO-SELL-${DateTime.now().millisecondsSinceEpoch}';
    // Capture the running cubit before the sheet closes — after
    // onBeforeProcessing dismisses this sheet, `context` is defunct.
    final cubit = context.read<CryptoCubit>();

    setState(() => _isTransacting = true);

    // Same quote-first pipeline as the full sell screen: send the CRYPTO
    // quantity as the swap from-amount (Quidax quotes crypto->fiat in the
    // crypto); netProceeds is the display/min-order fiat. PIN is collected on
    // Confirm inside the quote sheet.
    final result = await runSwapFlow(
      context: context,
      side: 'sell',
      cryptoSymbol: h.cryptoSymbol,
      fiatAmount: netProceeds,
      cryptoAmount: quantity,
      description:
          'Sell ${quantity.toStringAsFixed(6)} ${h.cryptoSymbol.toUpperCase()}',
      clientIntentId: intentId,
      // Dismiss this bottom sheet the instant the trade confirms, so the
      // processing→receipt screens render on a clean stack (Get.off can't
      // replace a route sitting under an open modal → receipt never shows).
      onBeforeProcessing: () {
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      requestPin: () async {
        String? token;
        await validateTransactionPin(
          context: context,
          transactionId: intentId,
          transactionType: 'sell',
          amount: netProceeds,
          currency: CurrencySymbols.currentCurrency,
          title: 'Confirm Sell Order',
          message:
              'Confirm sale of ${quantity.toStringAsFixed(6)} ${h.cryptoSymbol.toUpperCase()}',
          fee: fee,
          totalAmount: netProceeds,
          showProcessingPhase: false,
          onPinValidated: (verificationToken) async {
            token = verificationToken;
          },
        );
        return token;
      },
    );

    // On success the sheet was already dismissed by onBeforeProcessing (so the
    // receipt could show); only the pre-confirm error path leaves it open.
    cubit.refreshHoldingsLive();
    if (!result.initiated && (result.message ?? '').isNotEmpty) {
      Get.snackbar('Trade failed', result.message!,
          snackPosition: SnackPosition.BOTTOM);
      if (mounted) setState(() => _isTransacting = false);
    }
  }
}
