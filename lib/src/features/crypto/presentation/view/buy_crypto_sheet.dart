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
import '../widgets/network_picker_sheet.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pbgrpc.dart' show QuidaxAssetNetwork;
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

  // Receive-network selection. Quidax keeps one unified balance per currency,
  // so picking a network doesn't change the buy (an internal, network-agnostic
  // master->sub delivery); it provisions the chosen chain's deposit address and
  // marks it active for the asset. Deposit-enabled networks only.
  CryptoGrpcClient get _networkClient => GetIt.I<CryptoGrpcClient>();
  List<QuidaxAssetNetwork> _networks = const [];
  String? _selectedNetwork;
  bool _loadingNetworks = false;
  bool _switchingNetwork = false;
  // True only after a successful fetch (see buy_crypto_screen for rationale).
  bool _networksLoaded = false;

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() => setState(() {}));
    _loadNetworks();
    // The AccountCardsSummaryCubit is loaded app-wide (dashboard); the
    // BlocBuilder below reads its current spendable balance for the pay-from
    // card + validation. Warm the per-token Quidax min-order limits too.
    try {
      GetIt.I<CryptoConfigCubit>().load();
    } catch (_) {}
  }

  /// Quidax minimum order value for this token, in fiat major units (per-token
  /// from GET /markets minimum_order_size, currency floor fallback). 0=unknown.
  double _minFiat() {
    int? minor;
    try {
      final cfg = GetIt.I<CryptoConfigCubit>().config;
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
    // The backend charges the platform fee ON TOP of the subtotal (holds
    // subtotal + fee), so the wallet must cover the TOTAL, not just the subtotal.
    if (_fiatAmount + _resolveFee() > available) {
      return 'Exceeds your wallet balance';
    }
    return null;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  /// Loads the deposit-enabled networks for the asset and picks the
  /// active/default one. Cheap (DB-backed GetAssetNetworkStatus), non-blocking.
  Future<void> _loadNetworks() async {
    final sym = widget.crypto.symbol.toLowerCase();
    if (sym.isEmpty) return;
    setState(() {
      _loadingNetworks = true;
      _networksLoaded = false;
      _networks = const [];
      _selectedNetwork = null;
    });
    try {
      final res = await _networkClient.getAssetNetworkStatus(currency: sym);
      if (!mounted) return;
      final deposit = res.networks
          .where((e) => e.network.depositEnabled)
          .map((e) => e.network)
          .toList(growable: false);
      String? active = res.activeNetwork.isNotEmpty ? res.activeNetwork : null;
      if (active == null) {
        for (final n in deposit) {
          if (n.isDefault) {
            active = n.network;
            break;
          }
        }
      }
      active ??= deposit.isNotEmpty ? deposit.first.network : null;
      setState(() {
        _networks = deposit;
        _selectedNetwork = active;
        _loadingNetworks = false;
        _networksLoaded = true;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingNetworks = false);
    }
  }

  String _networkLabel(String slug) {
    for (final n in _networks) {
      if (n.network == slug) {
        return n.networkName.isNotEmpty
            ? n.networkName
            : n.network.toUpperCase();
      }
    }
    return slug.toUpperCase();
  }

  Future<void> _pickNetwork() async {
    if (_networks.isEmpty || _switchingNetwork) return;
    final sym = widget.crypto.symbol.toUpperCase();
    final chosen = await showNetworkPickerSheet(
      context,
      currency: widget.crypto.symbol.toLowerCase(),
      networks: _networks,
      selectedNetwork: _selectedNetwork,
      title: 'Receive $sym on',
      subtitle:
          'Your balance is the same on every network. This sets the chain your $sym address uses for receiving and sending.',
    );
    if (chosen == null || chosen == _selectedNetwork || !mounted) return;
    setState(() {
      _selectedNetwork = chosen;
      _switchingNetwork = true;
    });
    try {
      // Provision the chosen chain's address and mark it active for the asset.
      // Does NOT touch the buy money path.
      await _networkClient.ensureWalletAddress(
        currency: widget.crypto.symbol.toLowerCase(),
        network: chosen,
      );
    } catch (_) {
      // Non-fatal: the selection still stands for display; provisioning retries
      // when the user opens the wallet sheet.
    } finally {
      if (mounted) setState(() => _switchingNetwork = false);
    }
  }

  /// Emphasized card telling the user which network their purchased asset will
  /// live on, with a prominent affordance to change it. Balance is the same on
  /// every network (Quidax unified balance); the network only sets the
  /// receiving/sending chain.
  /// Notice for trade-only assets with no deposit-enabled network — buyable /
  /// sellable / swappable, but not receivable to an external address.
  Widget _buildReceiveUnsupportedNotice(String sym) {
    const warn = Color(0xFFFB923C);
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: warn.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: warn.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: warn, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$sym is trade-only',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  "This asset can't be received to an on-chain address. You can still buy, sell and swap it in the app.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkAlert() {
    const accent = Color(0xFF3B82F6);
    final sym = widget.crypto.symbol.toUpperCase();
    final label = _selectedNetwork != null
        ? _networkLabel(_selectedNetwork!)
        : 'Choose network';
    // Trade-only asset (fetch succeeded, no deposit-enabled network): show a
    // clear notice rather than a "Choose network" button that does nothing. A
    // failed fetch leaves _networksLoaded=false so a transient error never
    // shows this.
    if (!_loadingNetworks && _networksLoaded && _networks.isEmpty) {
      return _buildReceiveUnsupportedNotice(sym);
    }
    final canChange = _networks.length > 1 && !_switchingNetwork;
    final canRetry = _networks.isEmpty && !_switchingNetwork && !_loadingNetworks;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.16),
            accent.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.lan_rounded,
                color: const Color(0xFF93C5FD), size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Receiving network',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                if (_loadingNetworks)
                  Text(
                    'Loading networks...',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13.sp,
                    ),
                  )
                else
                  Text(
                    _networks.isEmpty
                        ? "Couldn't load networks"
                        : 'Your $sym will use $label',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Material(
            color: (canChange || canRetry) ? accent : accent.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.r),
            child: InkWell(
              onTap: canChange
                  ? _pickNetwork
                  : (canRetry ? _loadNetworks : null),
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_switchingNetwork)
                      SizedBox(
                        width: 14.w,
                        height: 14.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    else ...[
                      Text(
                        _networks.length > 1
                            ? 'Change'
                            : (_networks.isEmpty ? 'Retry' : label),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (_networks.length > 1) ...[
                        SizedBox(width: 4.w),
                        Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.white, size: 16.sp),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  /// Estimated Lazervault buy fee for the current amount, honoring the admin's
  /// percentage/fixed config (crypto.fee.buy.*). Falls back to the flat display
  /// rate before the config RPC lands.
  double _resolveFee() {
    try {
      return GetIt.I<CryptoConfigCubit>()
          .config
          .feeForOp('buy', _fiatAmount, CurrencySymbols.currentCurrency);
    } catch (_) {
      return _fiatAmount * _feeDisplayRate();
    }
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
        // Wallet must cover the TOTAL (subtotal + our fee) — the backend holds
        // subtotal + fee, so a subtotal-only check would let the hold fail.
        final totalCost = _fiatAmount + _resolveFee();
        final canCover = personal != null && available >= totalCost && _fiatAmount > 0;
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
                _buildNetworkAlert(),
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
    final hasError = _amountError(available) != null;

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
                  Text('Amount to buy',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.7))),
                  Row(children: [
                    _unitToggleChip(altLabel),
                    // Max: spend the full spendable fiat balance.
                    if (available > 0 && !_isAmountInCrypto) ...[
                      SizedBox(width: 8.w),
                      _maxChip(() => setState(() =>
                          _amountController.text = available.toStringAsFixed(2))),
                    ],
                  ]),
                ],
              ),
              SizedBox(height: 16.h),
              Row(children: [
                _assetChip(),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                    style: GoogleFonts.inter(
                        fontSize: 26.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: '0.00',
                      hintStyle: GoogleFonts.inter(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.25)),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(unitLabel,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF9F7AEA))),
              ]),
              SizedBox(height: 14.h),
              Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(approx,
                      style: GoogleFonts.inter(
                          fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.55))),
                  _buildLimitsHint(available),
                ],
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Row(children: [
              Icon(Icons.error_outline, size: 13.sp, color: const Color(0xFFEF4444)),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(_amountError(available)!,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: const Color(0xFFEF4444))),
              ),
            ]),
          ),
      ],
    );
  }

  /// Gradient asset avatar — mirrors the swap page's crypto chip. Ticker's
  /// leading letter over a purple gradient (no network icon fetch).
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
      child: Text(sym.isNotEmpty ? sym[0] : '?',
          style: GoogleFonts.inter(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  /// Unit toggle chip (fiat ⇄ crypto) styled to the swap-page purple accent.
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

  /// "Max" chip — fills the field with the full spendable wallet balance.
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

  /// Min (Quidax per-token) / Max (your spendable wallet) hint, with a loading
  /// state while the config carrying the per-token minimum is still fetching.
  Widget _buildLimitsHint(double available) {
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
    final fee = _resolveFee();
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
            canCover
                ? 'Enough'
                : 'Short by $sym${_formatMoney((_fiatAmount + _resolveFee()) - available)}',
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

    // Same quote-first pipeline as the buy screen. runSwapFlow pushes the
    // receipt/processing screen with Get.to. It must NOT push over an open modal
    // (the receipt never mounts → BLANK screen — the Buy-CTA-after-PIN bug). So we
    // dismiss THIS bottom sheet via onBeforeProcessing the instant the trade
    // confirms, exactly like sell_crypto_sheet does, so the receipt lands on a
    // clean stack. (The earlier "let the receipt land ON TOP of the sheet"
    // approach is what left the blank screen; the sell sheet proves popping in
    // onBeforeProcessing is the correct, race-free pattern.)
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
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      requestPin: (onValidated) async {
        // The PIN sheet's processing phase runs the trade confirmation, then the
        // flow goes straight to the receipt — no intermediate buy-sheet spinner.
        return await validateTransactionPin(
          context: context,
          transactionId: intentId,
          transactionType: 'buy',
          amount: fiat,
          currency: CurrencySymbols.currentCurrency,
          title: 'Confirm Buy Order',
          message:
              'Confirm purchase of ${quantity.toStringAsFixed(6)} ${widget.crypto.symbol.toUpperCase()}',
          totalAmount: fiat,
          showProcessingPhase: true,
          successMessage: 'Order Placed',
          onPinValidated: (verificationToken) => onValidated(verificationToken),
        );
      },
    );

    // On success the sheet was already dismissed by onBeforeProcessing (so the
    // receipt could render on a clean stack); only the pre-confirm error path
    // leaves it open. Refresh holdings on the captured cubit regardless.
    try {
      cubit.refreshHoldingsLive();
    } catch (_) {}
    if (!result.initiated && (result.message ?? '').isNotEmpty) {
      Get.snackbar('Trade failed', result.message!, snackPosition: SnackPosition.BOTTOM);
      if (mounted) setState(() => _isTransacting = false);
    }
  }
}
