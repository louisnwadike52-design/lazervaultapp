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
  bool _isAmountInCrypto = true;

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
    return _cryptoAmount > 0 && _cryptoAmount <= h.quantity;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Amount to sell',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                // Unit toggle — enter the amount in crypto or fiat.
                GestureDetector(
                  onTap: _toggleUnit,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(children: [
                      Icon(Icons.swap_vert,
                          size: 14.sp, color: const Color(0xFF9F7AEA)),
                      SizedBox(width: 4.w),
                      Text(
                        altLabel,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9F7AEA),
                        ),
                      ),
                    ]),
                  ),
                ),
                if (h != null) ...[
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _fillMax(h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Max',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              Text(
                unitLabel,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          approx,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        if (h != null && _cryptoAmount > h.quantity)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              'You only hold ${h.quantity.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()}',
              style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    final fee = _fiatAmount * _feeDisplayRate();
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

    final fee = _fiatAmount * _feeDisplayRate();
    final netProceeds = _fiatAmount - fee;
    final quantity = _cryptoAmount;
    final intentId = 'CRYPTO-SELL-${DateTime.now().millisecondsSinceEpoch}';

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

    if (!mounted) return;
    setState(() => _isTransacting = false);
    if (!result.initiated && (result.message ?? '').isNotEmpty) {
      Get.snackbar('Trade failed', result.message!,
          snackPosition: SnackPosition.BOTTOM);
    } else if (result.initiated) {
      // Refresh holdings so the reduced balance reflects, then close the sheet.
      context.read<CryptoCubit>().refreshHoldingsLive();
      Get.back();
    }
  }
}
