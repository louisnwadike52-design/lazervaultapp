import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../cubit/crypto_config_cubit.dart';
import '../../cubit/crypto_cubit.dart';
import '../../domain/entities/crypto_entity.dart';
import '../widgets/price_quote_card.dart';
import 'swap_flow_dispatcher.dart';

/// Streamlined BUY bottom sheet — the mirror of [SellCryptoSheet].
///
/// Opened from a crypto detail page, so the asset is pre-selected and locked.
/// The user enters an amount in fiat OR crypto (toggle), the live rate drives
/// the conversion, and Buy runs the same [runSwapFlow] pipeline (quote → PIN →
/// async live receipt) as the sell. Pays from the user's local-currency wallet.
Future<void> showBuyCryptoSheet(
  BuildContext context, {
  required Crypto crypto,
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BuyCryptoSheet(crypto: crypto),
      ),
    ),
  );
}

class BuyCryptoSheet extends StatefulWidget {
  final Crypto crypto;
  const BuyCryptoSheet({super.key, required this.crypto});

  @override
  State<BuyCryptoSheet> createState() => _BuyCryptoSheetState();
}

class _BuyCryptoSheetState extends State<BuyCryptoSheet> with TransactionPinMixin {
  final TextEditingController _amountController = TextEditingController();
  bool _isTransacting = false;
  // Fiat-input by default for a buy (you spend NGN to get crypto).
  bool _isAmountInCrypto = false;
  // Live rate from PriceQuoteCard; falls back to the entity's currentPrice.
  double? _liveRate;

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() => setState(() {}));
    // The AccountCardsSummaryCubit is loaded app-wide (dashboard); the
    // BlocBuilder below reads its current spendable balance for the pay-from
    // card + validation. Warm the per-token Quidax min-order limits too.
    try {
      context.read<CryptoConfigCubit>().load();
    } catch (_) {}
  }

  /// Quidax minimum order value for this token, in fiat major units (per-token
  /// from GET /markets minimum_order_size, currency floor fallback). 0=unknown.
  double _minFiat() {
    int? minor;
    try {
      final cfg = context.read<CryptoConfigCubit>().config;
      minor = cfg.minOrderFor(widget.crypto.symbol) ??
          cfg.minOrderFor(CurrencySymbols.currentCurrency);
    } catch (_) {}
    return (minor ?? 0) / 100.0;
  }

  String? _amountError(double available) {
    if (_amountController.text.isEmpty || _fiatAmount <= 0) return null;
    final min = _minFiat();
    if (min > 0 && _fiatAmount < min) {
      return 'Minimum is ${CurrencySymbols.currentSymbol}${min.toStringAsFixed(2)}';
    }
    if (_fiatAmount > available) {
      return 'Exceeds your wallet balance';
    }
    return null;
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

  double _rate() {
    final r = _liveRate ?? 0.0;
    return r > 0 ? r : widget.crypto.currentPrice;
  }

  double get _typed => double.tryParse(_amountController.text) ?? 0.0;

  /// Fiat the user pays — the field value in fiat mode, or crypto×rate in
  /// crypto mode.
  double get _fiatAmount {
    if (_isAmountInCrypto) {
      final r = _rate();
      return r > 0 ? _typed * r : 0.0;
    }
    return _typed;
  }

  /// Crypto received — the field value in crypto mode, or fiat÷rate in fiat mode.
  double get _cryptoAmount {
    if (_isAmountInCrypto) return _typed;
    final r = _rate();
    return r > 0 ? _typed / r : 0.0;
  }

  AccountSummaryEntity? _personal(AccountCardsSummaryState state) {
    final accounts = switch (state) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => const <AccountSummaryEntity>[],
    };
    final ccy = CurrencySymbols.currentCurrency.toUpperCase();
    for (final a in accounts) {
      if (a.isPersonalAccount && a.currency.toUpperCase() == ccy) return a;
    }
    return null;
  }

  String _trimNum(double v) {
    var s = v.toStringAsFixed(6);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }

  void _toggleUnit() {
    final fiat = _fiatAmount;
    setState(() {
      _isAmountInCrypto = !_isAmountInCrypto;
      if (fiat > 0) {
        final r = _rate();
        _amountController.text = _isAmountInCrypto
            ? (r > 0 ? _trimNum(fiat / r) : '')
            : fiat.toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, acctState) {
        final personal = _personal(acctState);
        final available = personal?.availableBalance ?? 0.0;
        final sym = CurrencySymbols.currentSymbol;
        final canCover = personal != null && available >= _fiatAmount && _fiatAmount > 0;
        final min = _minFiat();
        final meetsMin = min <= 0 || _fiatAmount >= min;
        final enabled = canCover && meetsMin && !_isTransacting;

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
                _buildHeader(),
                SizedBox(height: 16.h),
                PriceQuoteCard(
                  cryptoId: widget.crypto.id,
                  cryptoSymbol: widget.crypto.symbol,
                  onRateUpdated: (r) {
                    if (mounted && r != _liveRate) setState(() => _liveRate = r);
                  },
                ),
                SizedBox(height: 20.h),
                _buildAmountField(available),
                SizedBox(height: 16.h),
                if (_fiatAmount > 0) _buildOrderSummary(),
                SizedBox(height: 12.h),
                _buildPayFrom(available, canCover, sym),
                SizedBox(height: 18.h),
                _buildBuyButton(enabled),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(Icons.add_circle_outline, color: const Color(0xFF10B981), size: 22.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Buy ${widget.crypto.name}',
                  style: GoogleFonts.inter(
                      fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 2.h),
              Text('Instant · settled by licensed partner',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.6))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField(double available) {
    final unitLabel = _isAmountInCrypto
        ? widget.crypto.symbol.toUpperCase()
        : CurrencySymbols.currentCurrency.toUpperCase();
    final altLabel = _isAmountInCrypto
        ? CurrencySymbols.currentCurrency.toUpperCase()
        : widget.crypto.symbol.toUpperCase();
    final approx = _isAmountInCrypto
        ? '≈ ${CurrencySymbols.currentSymbol}${_fiatAmount.toStringAsFixed(2)}'
        : '≈ ${_trimNum(_cryptoAmount)} ${widget.crypto.symbol.toUpperCase()}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Amount to buy',
                style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
            Row(children: [
              GestureDetector(
                onTap: _toggleUnit,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(children: [
                    Icon(Icons.swap_vert, size: 14.sp, color: const Color(0xFF9F7AEA)),
                    SizedBox(width: 4.w),
                    Text(altLabel,
                        style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF9F7AEA))),
                  ]),
                ),
              ),
              // Max: spend the full spendable fiat balance.
              if (available > 0 && !_isAmountInCrypto) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => setState(() =>
                      _amountController.text = available.toStringAsFixed(2)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text('Max',
                        style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3B82F6))),
                  ),
                ),
              ],
            ]),
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
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                style: GoogleFonts.inter(
                    fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00',
                  hintStyle: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withValues(alpha: 0.3)),
                ),
              ),
            ),
            Text(unitLabel,
                style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.7))),
          ]),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(approx,
                style: GoogleFonts.inter(
                    fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.6))),
            _buildLimitsHint(available),
          ],
        ),
        if (_amountError(available) != null)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(_amountError(available)!,
                style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFEF4444))),
          ),
      ],
    );
  }

  /// Min (Quidax per-token) / Max (your spendable wallet) hint, with a loading
  /// state while the config carrying the per-token minimum is still fetching.
  Widget _buildLimitsHint(double available) {
    return BlocBuilder<CryptoConfigCubit, CryptoConfigState>(
      builder: (context, cfgState) {
        final loading = cfgState is CryptoConfigInitial || cfgState is CryptoConfigLoading;
        final sym = CurrencySymbols.currentSymbol;
        if (loading) {
          return Text('Loading limits…',
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.4)));
        }
        final min = _minFiat();
        final parts = <String>[];
        if (min > 0) parts.add('Min $sym${min.toStringAsFixed(0)}');
        if (available > 0) parts.add('Max $sym${available.toStringAsFixed(0)}');
        return Text(parts.join(' · '),
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.45)));
      },
    );
  }

  Widget _buildOrderSummary() {
    final fee = _fiatAmount * _feeDisplayRate();
    final total = _fiatAmount + fee;
    final sym = CurrencySymbols.currentSymbol;
    Widget row(String l, String r, {bool bold = false}) => Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.7))),
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
          color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(14.r)),
      child: Column(children: [
        row('You receive',
            '${_trimNum(_cryptoAmount)} ${widget.crypto.symbol.toUpperCase()}'),
        row('Subtotal', '$sym${_fiatAmount.toStringAsFixed(2)}'),
        row('Fee (approx)', '$sym${fee.toStringAsFixed(2)}'),
        Divider(color: Colors.white.withValues(alpha: 0.08), height: 16.h),
        row('Total', '$sym${total.toStringAsFixed(2)}', bold: true),
      ]),
    );
  }

  Widget _buildPayFrom(double available, bool canCover, String sym) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
            color: canCover
                ? const Color(0xFF7C3AED).withValues(alpha: 0.6)
                : const Color(0xFF2D2D2D)),
      ),
      child: Row(children: [
        Icon(Icons.account_balance_wallet, color: const Color(0xFF9F7AEA), size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lazervault Wallet',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
              SizedBox(height: 2.h),
              Text('$sym${_formatMoney(available)}',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.7))),
            ],
          ),
        ),
        if (_fiatAmount > 0)
          Text(
            canCover ? 'Enough' : 'Short by $sym${_formatMoney(_fiatAmount - available)}',
            style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: canCover ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
          ),
      ]),
    );
  }

  Widget _buildBuyButton(bool enabled) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? _processBuyOrder : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor: const Color(0xFF2D2D2D),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        child: _isTransacting
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text('Buy ${widget.crypto.symbol.toUpperCase()}',
                style: GoogleFonts.inter(
                    fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  String _formatMoney(double v) => v.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');

  Future<void> _processBuyOrder() async {
    if (_fiatAmount <= 0 || _isTransacting) return;
    final fiat = _fiatAmount;
    final quantity = _cryptoAmount;
    final intentId = 'CRYPTO-BUY-${DateTime.now().millisecondsSinceEpoch}';
    final cubit = context.read<CryptoCubit>();

    setState(() => _isTransacting = true);

    // Same quote-first pipeline as the buy screen; runSwapFlow handles the
    // async→live-receipt routing. Dismiss this sheet before it navigates so the
    // receipt lands on a clean stack (Get.off can't replace a route under a
    // modal).
    final result = await runSwapFlow(
      context: context,
      side: 'buy',
      cryptoSymbol: widget.crypto.symbol,
      fiatAmount: fiat,
      cryptoAmount: quantity,
      description:
          'Buy ${quantity.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()}',
      clientIntentId: intentId,
      onBeforeProcessing: () {
        if (mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
      },
      requestPin: () async {
        String? token;
        await validateTransactionPin(
          context: context,
          transactionId: intentId,
          transactionType: 'buy',
          amount: fiat,
          currency: CurrencySymbols.currentCurrency,
          title: 'Confirm Buy Order',
          message:
              'Confirm purchase of ${quantity.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()}',
          totalAmount: fiat,
          showProcessingPhase: false,
          onPinValidated: (verificationToken) async {
            token = verificationToken;
          },
        );
        return token;
      },
    );

    // On success the sheet was dismissed by onBeforeProcessing; only the
    // pre-confirm error path leaves it open.
    try {
      cubit.refreshHoldingsLive();
    } catch (_) {}
    if (!result.initiated && (result.message ?? '').isNotEmpty) {
      Get.snackbar('Trade failed', result.message!, snackPosition: SnackPosition.BOTTOM);
      if (mounted) setState(() => _isTransacting = false);
    }
  }
}
