import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/src/features/crypto/presentation/utils/crypto_error_messages.dart';
import 'package:lazervault/src/generated/crypto.pb.dart' as cpb;

// AssetWalletSheet — bottom-sheet view of a single asset's wallet.
// Renders:
//   - asset symbol/name header
//   - current balance (quantity + fiat value)
//   - network selector (when more than one available)
//   - QR code of the deposit address (qr_flutter)
//   - selectable address text + copy button
//   - destination tag warning when required
//
// Opened from:
//   - All Assets screen onTap of a row (`showAssetWalletSheet(ctx, ...)`).
//   - Buy / Sell / Swap screens via a "View wallet" CTA on the active asset.
//
// Idempotent on the server side: EnsureWalletAddress just returns the
// existing address if one's already minted.

Future<void> showAssetWalletSheet(
  BuildContext context, {
  required String cryptoSymbol,
  required String cryptoName,
  double? balance,
  double? fiatValue,
  String? fiatCurrency,
  double? currentPrice,
  double? priceChange24hPct,
  String? imageUrl,
  // Optional. When provided, a "View details" CTA appears at the base
  // of the sheet; tapping pops the sheet then runs the callback so
  // the caller can navigate to the asset-details screen with the
  // appropriate context (browse vs sell-only entry mode, BLoC scope,
  // etc.). The sheet stays decoupled from routing.
  VoidCallback? onViewDetails,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: AssetWalletSheet(
        cryptoSymbol: cryptoSymbol,
        cryptoName: cryptoName,
        balance: balance,
        fiatValue: fiatValue,
        fiatCurrency: fiatCurrency,
        currentPrice: currentPrice,
        priceChange24hPct: priceChange24hPct,
        imageUrl: imageUrl,
        onViewDetails: onViewDetails,
      ),
    ),
  );
}

class AssetWalletSheet extends StatefulWidget {
  final String cryptoSymbol;
  final String cryptoName;
  final double? balance;
  final double? fiatValue;
  final String? fiatCurrency;
  final double? currentPrice;
  final double? priceChange24hPct;
  final String? imageUrl;
  final VoidCallback? onViewDetails;

  const AssetWalletSheet({
    super.key,
    required this.cryptoSymbol,
    required this.cryptoName,
    this.balance,
    this.fiatValue,
    this.fiatCurrency,
    this.currentPrice,
    this.priceChange24hPct,
    this.imageUrl,
    this.onViewDetails,
  });

  @override
  State<AssetWalletSheet> createState() => _AssetWalletSheetState();
}

class _AssetWalletSheetState extends State<AssetWalletSheet> {
  bool _loading = true;
  bool _generating = false;
  List<cpb.QuidaxAssetNetwork> _networks = const [];
  String? _selectedNetwork;
  String _address = '';
  String _destinationTag = '';
  String _minDeposit = '';
  // _error is a fatal, sheet-level failure (couldn't even load the network
  // list) — it replaces the whole body. _addressError is a per-network
  // address-generation failure (e.g. Quidax declines deposits for this
  // asset/network) — the network selector stays visible so the user can pick
  // a different network that DOES support deposits (e.g. BTC via BEP20).
  String _error = '';
  String _addressError = '';
  double? _liveBalance;
  double? _liveFiatValue;
  double? _livePrice;
  double? _livePriceChange24hPct;
  bool _refreshingMetrics = false;
  // Monotonic counters used to ignore the result of stale async calls
  // when the user rapidly changes network (or rapidly hits Refresh).
  // Each call increments the counter; on completion we drop the result
  // unless our local copy still matches the current counter.
  int _addressGen = 0;
  int _refreshGen = 0;
  // 'ready' once the on-chain address has been minted by Quidax, 'pending'
  // when we successfully kicked off creation but Quidax is still
  // generating it (async via wallet.address.generated webhook). Used to
  // distinguish the "we triggered creation, just wait" UI from the
  // "couldn't reach the server" / "first call" states.
  String _creationStatus = '';

  CryptoGrpcClient get _client => GetIt.I<CryptoGrpcClient>();
  String get _currency => widget.cryptoSymbol.toLowerCase();
  String get _fiatCurrency => widget.fiatCurrency ?? _resolveFiat();

  String _resolveFiat() {
    try {
      return GetIt.I<LocaleManager>().currentCurrency;
    } catch (_) {
      return 'NGN';
    }
  }

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    // Bumping the generation counters means any in-flight Quidax /
    // gRPC response that completes after dispose() will fail its
    // generation check and not call setState on a disposed widget.
    _addressGen++;
    _refreshGen++;
    super.dispose();
  }

  Future<void> _bootstrap() async {
    if (_currency.isEmpty) {
      // Caller passed an empty symbol — extremely defensive but cheap.
      // Show the no-networks banner immediately so the user understands.
      setState(() => _loading = false);
      return;
    }
    setState(() => _loading = true);
    try {
      final netResp =
          await _client.getSupportedAssetNetworks(currency: _currency);
      if (!mounted) return;
      _networks = netResp.networks;
      // Default to is_default row OR first deposit-enabled OR first row.
      cpb.QuidaxAssetNetwork? defaultNet;
      for (final n in _networks) {
        if (n.isDefault && n.depositEnabled) {
          defaultNet = n;
          break;
        }
      }
      defaultNet ??= _networks.firstWhereOrNull((n) => n.depositEnabled);
      defaultNet ??= _networks.isNotEmpty ? _networks.first : null;
      _selectedNetwork = defaultNet?.network;
      _minDeposit = defaultNet?.minDepositDecimal ?? '';
    } catch (e) {
      if (!mounted) return;
      _error = friendlyCryptoError(e, context: 'loading wallet networks');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
    // Bail out on error / no-network paths so we don't fire the address
    // call against an unknown network.
    if (!mounted || _selectedNetwork == null || _error.isNotEmpty) return;
    await _ensureAddress();
    if (!mounted) return;
    // Refresh balance + price from Quidax on first open so the user
    // sees up-to-date numbers, not stale list-screen snapshots. Runs
    // unawaited so the address can render first.
    unawaited(_refreshLiveMetrics());
  }

  Future<void> _ensureAddress() async {
    if (_selectedNetwork == null) return;
    if (_currency.isEmpty) return; // defensive: caller passed empty symbol
    final myGen = ++_addressGen;
    setState(() {
      _generating = true;
      _address = '';
      _destinationTag = '';
      _creationStatus = '';
      _addressError = '';
    });
    try {
      final resp = await _client.ensureWalletAddress(
        currency: _currency,
        network: _selectedNetwork!,
      );
      // Drop the response if the user changed network (or dismissed the
      // sheet) while we were waiting on Quidax — otherwise a stale
      // address for the previous network could overwrite the fresh one.
      if (!mounted || myGen != _addressGen) return;
      _address = resp.address;
      _destinationTag = resp.destinationTag;
      // 'ready' | 'pending'. When pending, Quidax accepted the request
      // but the on-chain address mints asynchronously and lands via the
      // wallet.address.generated webhook. The UI surfaces a clear
      // "we've started creating it" state so the user knows to check
      // back rather than thinking the screen is just slow.
      _creationStatus = resp.creationStatus;
    } catch (e) {
      if (!mounted || myGen != _addressGen) return;
      _addressError = friendlyCryptoError(e, context: 'generating your wallet address');
    } finally {
      if (mounted && myGen == _addressGen) {
        setState(() => _generating = false);
      }
    }
  }

  Future<void> _copy() async {
    if (_address.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: _address));
    if (!mounted) return;
    Get.snackbar(
      'Copied',
      'Address copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xCC10B981),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _onNetworkChange(String? net) {
    if (net == null || net == _selectedNetwork) return;
    final match =
        _networks.firstWhereOrNull((n) => n.network == net);
    setState(() {
      _selectedNetwork = net;
      _minDeposit = match?.minDepositDecimal ?? '';
      _address = '';
      _destinationTag = '';
    });
    _ensureAddress();
    // Per the design ask: when the user switches network, also pull
    // fresh balance / price / 24h change from Quidax via the holdings
    // RPC. Networks can have separately-funded balances on Quidax for
    // assets like USDT (TRC20 vs ERC20 vs BEP20), so this matters.
    _refreshLiveMetrics();
  }

  // Pulls fresh holdings + price for the current asset from Quidax via
  // the gRPC layer and overwrites the locally-cached metrics. Safe to
  // call any time; runs as a fire-and-forget setState update so a slow
  // network call doesn't block the rest of the sheet.
  Future<void> _refreshLiveMetrics() async {
    if (!mounted) return;
    if (_currency.isEmpty) return; // defensive: nothing to refresh against
    final myGen = ++_refreshGen;
    setState(() => _refreshingMetrics = true);
    try {
      // Holdings include balance + fiat value for the requesting user.
      // Single round-trip; the server aggregates per crypto_id.
      final resp = await _client.getHoldings();
      if (!mounted || myGen != _refreshGen) return;
      final symLower = _currency;
      for (final h in resp.holdings) {
        if (h.symbol.toLowerCase() == symLower) {
          _liveBalance = h.balance;
          _liveFiatValue = h.fiatValue;
          break;
        }
      }
    } catch (e) {
      // Non-fatal: keep showing the last known values. The error
      // helper still logs the raw cause for engineers.
      friendlyCryptoError(e, context: 'refreshing wallet metrics');
    }
    if (!mounted || myGen != _refreshGen) return;
    try {
      // Price + 24h change for the asset header card. We pass the
      // CoinGecko id when we have it (caller passes via imageUrl
      // typically isn't enough; rely on getExchangeRate which the
      // server resolves through the same Quidax-symbol map).
      final priceResp = await _client.getExchangeRate(
        cryptoId: _currency,
        fiatCurrency: _fiatCurrency.toUpperCase(),
      );
      if (!mounted || myGen != _refreshGen) return;
      _livePrice = priceResp.rate;
      // GetCryptoFiatRate doesn't include 24h change today; once it
      // does, plumb _livePriceChange24hPct here.
    } catch (e) {
      friendlyCryptoError(e, context: 'refreshing market price');
    } finally {
      if (mounted && myGen == _refreshGen) {
        setState(() => _refreshingMetrics = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final symbol = widget.cryptoSymbol.toUpperCase();
    // Prefer the live value (refreshed on network change) over the
    // value the caller passed when constructing the sheet. Falls back
    // to 0 when neither is available.
    final balance = _liveBalance ?? widget.balance ?? 0.0;
    final fiatValue = _liveFiatValue ?? widget.fiatValue ?? 0.0;
    final fiatSym = CurrencySymbols.getSymbol(_fiatCurrency);

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _grabHandle(),
            SizedBox(height: 12.h),
            _header(symbol),
            SizedBox(height: 16.h),
            if ((_livePrice ?? widget.currentPrice) != null) ...[
              _assetPriceCard(symbol, fiatSym),
              SizedBox(height: 12.h),
            ],
            _balanceCard(symbol, balance, fiatValue, fiatSym),
            SizedBox(height: 16.h),
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_error.isNotEmpty)
              // Surface the transport / RPC failure clearly with a retry
              // — DON'T also show the "no networks configured" banner,
              // since that orange message reads as a permanent state and
              // misleads when the real cause was a temporary connection
              // drop (e.g. crypto-service restarting in dev).
              _errorBanner()
            else if (_networks.isEmpty)
              _noNetworksBanner(symbol)
            else ...[
              _networkSelector(),
              SizedBox(height: 16.h),
              // Address generation can fail for the selected network alone
              // (e.g. Quidax declines on-chain deposits for BTC's native
              // chain while BEP20 works). Keep the selector above visible so
              // the user can switch networks instead of hitting a dead end.
              if (_addressError.isNotEmpty)
                _addressUnavailableBanner()
              else ...[
                _qrAndAddress(symbol),
                if (_destinationTag.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  _destinationTagBanner(),
                ],
                if (_minDeposit.isNotEmpty && _minDeposit != '0') ...[
                  SizedBox(height: 12.h),
                  _minDepositNotice(symbol),
                ],
              ],
            ],
            SizedBox(height: 8.h),
          ],
        ),
            ),
          ),
          if (widget.onViewDetails != null) _viewDetailsBar(),
        ],
      ),
    );
  }

  // Sticky bottom CTA — sits below the scrolling sheet body so the user
  // always has a one-tap path from the wallet view to the full asset
  // details (price chart, history, etc.). Pop first so the sheet is
  // gone by the time the caller pushes the details route — avoids a
  // double-stacked back behaviour where dismissing details returns to
  // the sheet.
  Widget _viewDetailsBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            final cb = widget.onViewDetails;
            Navigator.of(context).pop();
            if (cb != null) cb();
          },
          icon: Icon(Icons.bar_chart_rounded,
              color: Colors.white.withValues(alpha: 0.92), size: 18.sp),
          label: Text(
            'View details',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _grabHandle() => Center(
        child: Container(
          width: 44.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      );

  Widget _header(String symbol) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3E),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              symbol.length >= 2 ? symbol.substring(0, 2) : symbol,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
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
                'Your $symbol wallet',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.cryptoName,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  // Asset price card — shown above the wallet balance when the caller
  // passed `currentPrice`. Makes the sheet feel richer than "just a
  // wallet": user sees the market price + 24h move without having to
  // navigate to the asset detail screen (which is intentionally NOT
  // reachable from this sheet — per the design ask, the sheet is the
  // destination).
  Widget _assetPriceCard(String symbol, String fiatSym) {
    final price = _livePrice ?? widget.currentPrice ?? 0.0;
    final change = _livePriceChange24hPct ?? widget.priceChange24hPct;
    final isPositive = (change ?? 0) >= 0;
    final pnlColor = isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.18),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Market price',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '$fiatSym${price.toStringAsFixed(price >= 1 ? 2 : 6)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          if (change != null)
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: pnlColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPositive
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: pnlColor,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${change.abs().toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: pnlColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _balanceCard(
      String symbol, double balance, double fiatValue, String fiatSym) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    'Wallet balance',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                  if (_refreshingMetrics) ...[
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 10.sp,
                      height: 10.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                  ],
                ]),
                SizedBox(height: 6.h),
                Text(
                  '${balance.toStringAsFixed(6)} $symbol',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Fiat value',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                '$fiatSym${fiatValue.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _errorBanner() {
    // `_error` already came through friendlyCryptoError, so it's a clean
    // user-facing string. We just present it with a retry affordance —
    // no string-sniffing here, no raw server message ever surfaces.
    const headline = "We couldn't load your wallet";
    final subline = _error;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.12),
        border: Border.all(color: const Color(0xFFEF4444), width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              headline,
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]),
        SizedBox(height: 6.h),
        Text(
          subline,
          style: GoogleFonts.inter(
            color: const Color(0xFFEF4444).withValues(alpha: 0.85),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Row(children: [
          TextButton.icon(
            onPressed: () {
              setState(() => _error = '');
              _bootstrap();
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Retry'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _noNetworksBanner(String symbol) => Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFFB923C), width: 1),
        ),
        child: Text(
          '$symbol does not currently support deposits or withdrawals on any network. '
          'You can still buy and sell it from your LazerVault balance.',
          style: GoogleFonts.inter(
            color: const Color(0xFFFB923C),
            fontSize: 12.sp,
          ),
        ),
      );

  // Shown when address generation failed for the SELECTED network only (the
  // network list loaded fine). Calm amber, not a red error — the selector
  // above is still live, so the user can pick a network that supports
  // deposits (a multi-network asset like BTC may work on BEP20 even when its
  // native chain is unavailable). Also offers a direct retry.
  Widget _addressUnavailableBanner() {
    final hasOtherNetworks =
        _networks.where((n) => n.depositEnabled).length > 1;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFFB923C), width: 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.info_outline, color: const Color(0xFFFB923C), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              _addressError,
              style: GoogleFonts.inter(
                color: const Color(0xFFFB923C),
                fontSize: 12.sp,
                height: 1.35,
              ),
            ),
          ),
        ]),
        if (hasOtherNetworks) ...[
          SizedBox(height: 6.h),
          Text(
            'Pick a different network above to receive this asset.',
            style: GoogleFonts.inter(
              color: const Color(0xFFFB923C).withValues(alpha: 0.85),
              fontSize: 11.sp,
            ),
          ),
        ],
        SizedBox(height: 8.h),
        TextButton.icon(
          onPressed: _generating ? null : _ensureAddress,
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Try again'),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFFB923C),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          ),
        ),
      ]),
    );
  }

  Widget _networkSelector() {
    final enabledNets =
        _networks.where((n) => n.depositEnabled).toList(growable: false);
    if (enabledNets.isEmpty) {
      return Text(
        'No deposit-enabled network for this asset. Try again later.',
        style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF), fontSize: 12.sp),
      );
    }
    if (enabledNets.length == 1) {
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(Icons.lan_outlined,
                color: Colors.white.withValues(alpha: 0.6), size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              'Network: ${enabledNets.first.networkName.isNotEmpty ? enabledNets.first.networkName : enabledNets.first.network.toUpperCase()}',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButton<String>(
        value: _selectedNetwork,
        isExpanded: true,
        dropdownColor: const Color(0xFF1F1F1F),
        underline: const SizedBox.shrink(),
        style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
        items: enabledNets
            .map((n) => DropdownMenuItem(
                  value: n.network,
                  child: Text(
                    n.networkName.isNotEmpty
                        ? '${n.networkName} (${n.network.toUpperCase()})'
                        : n.network.toUpperCase(),
                  ),
                ))
            .toList(),
        onChanged: _onNetworkChange,
      ),
    );
  }

  Widget _qrAndAddress(String symbol) {
    if (_generating) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_address.isEmpty) {
      // Two cases collapse into one piece of UI:
      //   1. We just kicked off creation and Quidax replied "pending"
      //      (CreationStatus == 'pending'). The on-chain address will
      //      arrive via the wallet.address.generated webhook within
      //      seconds-to-minutes and the next sheet open / pull-to-refresh
      //      will display it. No auto-poll here — that would hammer
      //      Quidax's rate limit for impatient users.
      //   2. The call returned without a status (rare; transport blip
      //      or older response). We still treat it as "in progress" and
      //      offer a manual refresh.
      final pending = _creationStatus == 'pending';
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(children: [
          Icon(pending ? Icons.hourglass_top_rounded : Icons.refresh_rounded,
              color: const Color(0xFFFB923C), size: 44.sp),
          SizedBox(height: 12.h),
          Text(
            pending
                ? 'Creating your $symbol address'
                : 'Address not ready yet',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            pending
                ? "We've started creating your $symbol wallet address. "
                    "This usually takes a few seconds. "
                    "Close this sheet and check back shortly — your address "
                    "will appear here once it's ready."
                : 'Tap refresh to check again. If this keeps happening, our '
                    'team is on it.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 14.h),
          TextButton.icon(
            onPressed: _ensureAddress,
            icon: Icon(Icons.refresh_rounded,
                color: Colors.white.withValues(alpha: 0.92), size: 16.sp),
            label: Text(
              pending ? 'Check again' : 'Refresh',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.92),
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208)
                  .withValues(alpha: 0.22),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ]),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // QR code — qr_flutter renders inline; white background gives best
        // scanner contrast on a dark sheet.
        Center(
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: QrImageView(
              data: _address,
              version: QrVersions.auto,
              size: 200.w,
              backgroundColor: Colors.white,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Address row — the copy icon lives BESIDE the address, not as a
        // separate full-width CTA below. Tap target on the icon button is
        // generous; tapping the address also copies it. No "view detail"
        // CTA — the sheet is the destination, never a stepping stone to
        // the asset detail screen.
        Container(
          padding: EdgeInsets.fromLTRB(14.w, 12.h, 6.w, 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color:
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _copy,
                  child: SelectableText(
                    _address,
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              IconButton(
                onPressed: _copy,
                tooltip: 'Copy address',
                splashRadius: 22.r,
                padding: EdgeInsets.all(6.w),
                constraints: BoxConstraints(
                  minWidth: 36.w,
                  minHeight: 36.w,
                ),
                icon: Icon(
                  Icons.copy_rounded,
                  // Lighter purple-tinted white so it pops against the
                  // near-black background; previously the dark purple icon
                  // disappeared against the dark sheet.
                  color: Colors.white.withValues(alpha: 0.92),
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _destinationTagBanner() => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.15),
          border: Border.all(color: const Color(0xFFFB923C), width: 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Destination tag (required)',
            style: GoogleFonts.inter(
              color: const Color(0xFFFB923C),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          SelectableText(
            _destinationTag,
            style: GoogleFonts.robotoMono(
                color: Colors.white, fontSize: 13.sp),
          ),
        ]),
      );

  Widget _minDepositNotice(String symbol) => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: const Color(0xFFFB923C).withValues(alpha: 0.5)),
        ),
        child: Row(children: [
          Icon(Icons.info_outline,
              color: const Color(0xFFFB923C), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Minimum deposit: $_minDeposit $symbol. '
              'Smaller amounts may be held for review.',
              style: GoogleFonts.inter(
                color: const Color(0xFFFB923C),
                fontSize: 12.sp,
              ),
            ),
          ),
        ]),
      );
}

