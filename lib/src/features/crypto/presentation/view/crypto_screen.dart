import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../cubit/crypto_withdraw_cubit.dart';
import '../../domain/entities/crypto_entity.dart';
import '../models/crypto_transaction_models.dart';
import 'all_assets_screen.dart';
import '../widgets/crypto_kyc_gate.dart';
import '../widgets/my_assets_sheet.dart';
import '../widgets/crypto_search_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';
import 'swap_crypto_screen.dart';
import 'send_crypto_screen.dart';
import 'user_holdings_screen.dart';
import 'price_alerts_screen.dart';
import 'auto_orders_screen.dart';
import 'crypto_transaction_history_screen.dart';
import 'smart_trading_screen.dart';
import '../../../lifestyle/presentation/screens/partner_webview_screen.dart';
import '../../../settings/presentation/widgets/webview_bottom_sheet.dart';
import 'secure_wallet_screen.dart';
import 'pro_exchange_screen.dart';
import 'learn_earn_screen.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import '../widgets/crypto_shimmer_loading.dart';
import '../widgets/crypto_asset_avatar.dart';
import '../widgets/watchlist_manager_sheet.dart';
import '../../../../generated/crypto.pb.dart' show PriceAlert;

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showGainers = true;

  @override
  void initState() {
    super.initState();
    context.read<CryptoCubit>().loadCryptos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onPullToRefresh() async {
    // Pull-to-refresh triggers a fresh CryptoCubit.load() — re-fetches
    // markets, watchlists, holdings, and re-runs the wallet-provisioning
    // backstop (server side spawns the address reconciler too). Returns
    // the cubit's load Future so the spinner stays visible until done.
    final cubit = context.read<CryptoCubit>();
    await cubit.loadCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: ServiceEntranceAnimation(
        child: SafeArea(
        child: BlocBuilder<CryptoCubit, CryptoState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onPullToRefresh,
              color: const Color.fromARGB(255, 78, 3, 208),
              backgroundColor: const Color(0xFF1F1F1F),
              child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
        child: Column(
          children: [
                  _buildTopBar(),
                  if (state is CryptosLoaded) ...[
                    _buildPortfolioOverview(state),
                    _buildQuickActions(),
                    // Identity-verification prompt sits directly below the
                    // Buy/Sell/Send/Swap actions (per design): shows only when the
                    // user's KYC tier is too low to trade, self-hides once verified.
                    const CryptoVerifyBanner(),
                    _buildSupportedAssetsSection(state),
                    _buildMarketOverview(state),
                    _buildWatchlistSection(state),
                    _buildRecentTransactionsSection(state.transactions,
                        loading: state.transactionsLoading),
                    _buildLazerVaultServices(),
                    _buildPriceAlertsSection(state),
                    _buildCryptoCardsRow(state),
                    _buildTopMoversSection(state),
                    _buildRiskWarning(state),
                    _buildFooter(),
                  ] else if (state is CryptoLoading) ...[
                    const CryptoShimmerLoading(),
                  ] else if (state is CryptoError) ...[
                    _buildErrorState(state),
                  ],
                  SizedBox(height: 100.h),
                ],
              ),
              ),
            );
          },
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showVoiceInputBottomSheet,
        backgroundColor: const Color.fromARGB(255, 78, 3, 208),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 28.sp,
        ),
      ),
    );
  }

  void _showVoiceInputBottomSheet() {
    // Use the canonical voice path (same as ServiceVoiceButton everywhere else)
    // — VoiceCommandSheet → VoiceSessionCubit → /voice/session/start, which
    // passes the ACTIVE account (AccountManager) + ACTIVE locale/currency
    // (LocaleManager) and actually connects to LiveKit. Replaces the legacy
    // gRPC VoiceInputWidget stub that sent only serviceName+language and
    // returned canned responses.
    Get.bottomSheet(
      const VoiceCommandSheet(serviceName: 'crypto'),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          // Back Button
          Container(
            height: 34.h,
            width: 34.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 18.sp),
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
            ),
          ),
          SizedBox(width: 12.w),
          // Crypto Title
          Expanded(
            child: Text(
              'Crypto',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          // Action buttons row (compact). Search lives in the search bar below;
          // navigating back to Investments is the back button, so the old
          // 3-dots overflow menu was removed.
          Row(
            children: [
              ServiceVoiceButton(
                serviceName: 'crypto',
                iconColor: const Color.fromARGB(255, 78, 3, 208),
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                buttonSize: 34.w,
                iconSize: 17.sp,
              ),
              SizedBox(width: 8.w),
              MicroserviceChatIcon(
                serviceName: 'Crypto',
                sourceContext: 'crypto',
                size: 34,
                iconSize: 17,
              ),
              SizedBox(width: 8.w),
              // Notifications = price alerts (the real, in-app surface).
              Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.notifications_outlined,
                      color: Colors.white, size: 17.sp),
                  onPressed: _openPriceAlerts,
                ),
              ),
              SizedBox(width: 8.w),
              // Auto Orders (price-triggered buy/sell that executes a trade).
              Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.bolt, color: Colors.white, size: 17.sp),
                  onPressed: () => Get.to(() => const AutoOrdersScreen()),
                ),
              ),
              SizedBox(width: 8.w),
              // Search (kept from the removed overflow menu so crypto search
              // stays reachable on the landing).
              Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.search, color: Colors.white, size: 17.sp),
                  onPressed: () => _showSearchBottomSheet(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Live 24h portfolio performance. The backend holdings carry only balance +
  /// fiat value (no cost basis), so a "since purchase" gain/loss would be fake.
  /// Instead we derive REAL numbers from each held asset's live 24h price change
  /// (priceChangePercentage24h) in the loaded catalogue:
  ///   value_24h_ago = value_now / (1 + pct/100)
  ///   24h gain      = value_now - value_24h_ago   (summed across holdings)
  ///   24h %         = 24h gain / total value_24h_ago * 100
  /// Best asset = the held asset with the strongest real 24h move.
  ({double gainFiat, double pct, String bestSymbol, double bestPct, bool hasData})
      _portfolio24h(CryptosLoaded state) {
    double gain = 0, valueAgo = 0;
    String bestSym = '';
    double bestPct = 0;
    var haveBest = false;
    var matched = false;
    for (final h in state.holdings) {
      if (h.quantity <= 0 || h.totalValue <= 0) continue;
      final pct = _pct24hFor(state, h);
      if (pct == null) continue; // asset not in catalogue yet — skip, don't fake
      matched = true;
      final vNow = h.totalValue;
      final vAgo = pct <= -100 ? vNow : vNow / (1 + pct / 100);
      gain += vNow - vAgo;
      valueAgo += vAgo;
      if (!haveBest || pct > bestPct) {
        bestPct = pct;
        bestSym = h.cryptoSymbol;
        haveBest = true;
      }
    }
    final pct = valueAgo > 0 ? (gain / valueAgo) * 100 : 0.0;
    return (
      gainFiat: gain,
      pct: pct,
      bestSymbol: bestSym,
      bestPct: bestPct,
      hasData: matched,
    );
  }

  /// The live 24h price-change % for a holding, matched from the loaded
  /// catalogue by id then symbol. Null when the asset isn't loaded yet (so the
  /// caller can omit it rather than show a fabricated 0%).
  double? _pct24hFor(CryptosLoaded state, CryptoHolding h) {
    for (final c in state.supportedAssets) {
      if (c.id == h.cryptoId ||
          c.symbol.toLowerCase() == h.cryptoSymbol.toLowerCase()) {
        return c.priceChangePercentage24h;
      }
    }
    for (final c in state.cryptos) {
      if (c.id == h.cryptoId ||
          c.symbol.toLowerCase() == h.cryptoSymbol.toLowerCase()) {
        return c.priceChangePercentage24h;
      }
    }
    return null;
  }

  Widget _buildPortfolioOverview(CryptosLoaded state) {
    final totalValue = state.holdings.fold(0.0, (sum, holding) => sum + holding.totalValue);
    // Lazy-loading: when ANY held asset is still awaiting its fiat rate,
    // the running total is a partial sum. The UI renders a subtle
    // "loading" hint next to the value so users don't mistake a half-
    // populated total for the truth.
    final hasPriceLoading =
        state.portfolioLoading || state.holdings.any((h) => h.priceLoading);

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2C3E50),
            Color.fromARGB(255, 78, 3, 208),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Portfolio Value',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          // The amount now takes the FULL card width — the Deposit CTA moved to
          // its own prominent button below, so a large value has the whole row.
          // Never clipped: FittedBox.scaleDown shrinks it to fit; tapping opens a
          // sheet with the full comma-grouped figure so even a shrunk value is
          // readable.
          if (hasPriceLoading)
            CryptoSkeleton(
                width: 200.w, height: 34.h, radius: 8.r, onGradient: true)
          else
            GestureDetector(
              onTap: () => _showPortfolioValueSheet(state, totalValue),
              behavior: HitTestBehavior.opaque,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  _fmtPortfolioMoney(totalValue),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
          SizedBox(height: 20.h),
          // Header action row: "My assets" (left, tappable → holdings sheet) with
          // the Deposit action as a circular button on the RIGHT — horizontal,
          // beside My assets. The deposit button is themed (amber accent on the
          // purple card, not plain white) for clear contrast, and spaced so it
          // never crowds the My-assets stat.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _buildMyAssetsStat(state),
                ),
              ),
              SizedBox(width: 12.w),
              _buildDepositCircle(),
            ],
          ),
        ],
      ),
    );
  }

  /// Full portfolio value with the active currency symbol and thousands
  /// separators (e.g. "₦1,234,567.89"). Used for both the card and the sheet
  /// so the figures always match.
  String _fmtPortfolioMoney(double v) =>
      '${CurrencySymbols.currentSymbol}${NumberFormat('#,##0.00').format(v)}';

  /// Bottom sheet showing the full portfolio value — reached by tapping the
  /// amount on the overview card. The card can shrink a very large number to
  /// fit its row (never truncated), but this sheet always shows the complete,
  /// comma-grouped figure at a comfortable size, plus the 24h change and best
  /// asset already computed for the card.
  void _showPortfolioValueSheet(CryptosLoaded state, double totalValue) {
    final p24 = _portfolio24h(state);
    final isPositive = p24.gainFiat >= 0;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Total Portfolio Value',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            // Full figure — allowed to wrap across lines here; never clipped.
            Text(
              _fmtPortfolioMoney(totalValue),
              style: TextStyle(
                color: Colors.white,
                fontSize: 34.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            if (p24.hasData) ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(
                    isPositive
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${isPositive ? '+' : '-'}${_fmtPortfolioMoney(p24.gainFiat.abs())}'
                    '  (${p24.pct.abs().toStringAsFixed(2)}%)',
                    style: TextStyle(
                      color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text('24h', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                ],
              ),
              if (p24.bestSymbol.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Text(
                  'Best asset: ${p24.bestSymbol.toUpperCase()} '
                  '${p24.bestPct >= 0 ? '+' : ''}${p24.bestPct.toStringAsFixed(1)}%',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  /// "My assets" stat — replaces the old plain "Assets" count in the stats row.
  /// Tappable (opens the holdings sheet) with the held count beside the label,
  /// tinted amber so it reads as the interactive entry.
  Widget _buildMyAssetsStat(CryptosLoaded state) {
    const amber = Color(0xFFFBBF24);
    final count = state.holdings.where((h) => h.quantity > 0).length;
    final p24 = _portfolio24h(state);
    return InkWell(
      onTap: () => showMyAssetsSheet(
        context,
        holdings: state.holdings,
        assets: [...state.supportedAssets, ...state.cryptos],
        // 24h change + best asset moved OFF the header card into this sheet.
        change24hFiat: p24.gainFiat,
        change24hPct: p24.pct,
        bestSymbol: p24.bestSymbol,
        bestPct: p24.bestPct,
        has24hData: p24.hasData,
      ),
      borderRadius: BorderRadius.circular(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My assets',
                style: GoogleFonts.inter(
                  color: amber,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 3.w),
              Icon(Icons.chevron_right_rounded, color: amber, size: 15.sp),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.pie_chart_rounded, color: amber, size: 14.sp),
              SizedBox(width: 5.w),
              Text(
                '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    // 4-up row of equal-width buttons. Send routes to the existing
    // SendCryptoScreen (Quidax create-withdrawal flow): picks an asset
    // from holdings, then a network, recipient, amount, PIN, submit.
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionButton(
              'Buy',
              Icons.add_circle_outline,
              Colors.green,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildQuickActionButton(
              'Sell',
              Icons.remove_circle_outline,
              Colors.red,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildQuickActionButton(
              'Send',
              Icons.send_rounded,
              const Color(0xFFFB923C),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildQuickActionButton(
              'Swap',
              Icons.swap_horiz,
              const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        final cryptoCubit = context.read<CryptoCubit>();
        switch (label) {
          case 'Buy':
            Get.to(() => BlocProvider.value(
              value: cryptoCubit,
              child: const AllAssetsScreen(mode: AssetSelectionMode.buy),
            ));
            break;
          case 'Sell':
            final state = cryptoCubit.state;
            if (state is CryptosLoaded && state.holdings.isNotEmpty) {
              Get.to(() => BlocProvider.value(
                value: cryptoCubit,
                child: const UserHoldingsScreen(),
              ));
            } else {
              Get.snackbar(
                'No Holdings',
                "You don't have any crypto holdings to sell yet. Buy some crypto first!",
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 3),
              );
            }
            break;
          case 'Send':
            // Always open SendCryptoScreen — it handles its own empty
            // state ("You don't have any crypto to send yet. Tap Buy
            // or Receive to fund a wallet first.") with primary CTAs
            // routing the user to Buy / Receive. The previous snackbar-
            // and-stay UX was a dead-end: the user saw a fleeting
            // toast then nothing happened, with no path forward to fix
            // the situation.
            //
            // MultiBlocProvider supplies BOTH cubits the screen needs:
            //   - CryptoCubit (existing instance, .value) drives the
            //     empty-state branch + asset picker.
            //   - CryptoWithdrawCubit (factory-fetched via GetIt) drives
            //     the submit → processing → terminal pipeline. Without
            //     this, the screen's BlocConsumer<CryptoWithdrawCubit>
            //     throws ProviderNotFoundException the moment it
            //     mounts.
            Get.to(() => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: cryptoCubit),
                BlocProvider<CryptoWithdrawCubit>(
                  create: (_) => serviceLocator<CryptoWithdrawCubit>(),
                ),
              ],
              child: const SendCryptoScreen(),
            ));
            break;
          case 'Swap':
            Get.to(() => BlocProvider.value(
              value: cryptoCubit,
              child: const SwapCryptoScreen(),
            ));
            break;
        }
      },
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Deposit (receive crypto) — a CIRCULAR, themed action that sits horizontally
  /// beside "My assets" on the portfolio card. Filled amber (the crypto screen's
  /// interactive accent) with a dark-purple icon gives strong contrast BOTH ways
  /// against the purple card background (unlike the old plain-white bar), while
  /// visually distinct from the amber "My assets" TEXT so the two never merge.
  /// A small caption keeps the affordance legible. Opens the all-assets page in
  /// receive mode (pick asset → deposit-address sheet).
  Widget _buildDepositCircle() {
    const accent = Color.fromARGB(255, 78, 3, 208); // purple card background
    const amber = Color(0xFFFBBF24);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: amber,
          shape: const CircleBorder(),
          elevation: 3,
          shadowColor: Colors.black.withValues(alpha: 0.35),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              final cubit = context.read<CryptoCubit>();
              Get.to(() => BlocProvider.value(
                    value: cubit,
                    child: const AllAssetsScreen(mode: AssetSelectionMode.receive),
                  ));
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.call_received_rounded,
                color: accent,
                size: 22.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Deposit',
          style: GoogleFonts.inter(
            color: amber,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Shimmer placeholder for a lazy CARD section (price alerts, watchlist,
  /// recent transactions) — mirrors the real 0xFF1F1F1F card shell so the swap
  /// to loaded content is seamless and non-blocking.
  Widget _cardSectionShimmer(String title, {int rows = 3}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          for (int i = 0; i < rows; i++) ...[
            Row(
              children: [
                CryptoSkeleton(width: 40.w, height: 40.w, radius: 20),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CryptoSkeleton(width: 120.w, height: 12.h),
                      SizedBox(height: 8.h),
                      CryptoSkeleton(width: 80.w, height: 10.h),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                CryptoSkeleton(width: 60.w, height: 12.h),
              ],
            ),
            if (i < rows - 1) SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }

  /// Shimmer placeholder for the horizontal Top Movers strip.
  Widget _moversShimmer() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top movers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 92.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, __) =>
                  CryptoSkeleton(width: 140.w, height: 92.h, radius: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAlertsSection(CryptosLoaded state) {
    if (state.priceAlertsLoading) {
      return _cardSectionShimmer('Price Alerts', rows: 2);
    }
    // Real alerts via PriceAlertWorker → gateway → crypto-service.
    // Preview up to 3 active rows; full management lives on
    // PriceAlertsScreen (FAB + delete + sentiment views).
    final active = state.priceAlerts.where((a) => a.isActive && !a.isTriggered).toList();
    final preview = active.take(3).toList();
    final accent = const Color.fromARGB(255, 78, 3, 208);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price Alerts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(children: [
                if (active.length > 3)
                  GestureDetector(
                    onTap: () async {
                      await _openPriceAlerts();
                      // Refresh on return so deletions/creates show.
                      if (mounted) context.read<CryptoCubit>().loadCryptos();
                    },
                    child: Text(
                      'View All (${active.length})',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                IconButton(
                  icon: Icon(Icons.add_alert_rounded, color: accent),
                  onPressed: () async {
                    await _openPriceAlerts();
                    if (mounted) context.read<CryptoCubit>().loadCryptos();
                  },
                ),
              ]),
            ],
          ),
          SizedBox(height: 12.h),
          if (preview.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No price alerts set. Tap + to create one.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14.sp,
                ),
              ),
            )
          else
            for (int i = 0; i < preview.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < preview.length - 1 ? 10.h : 0),
                child: _buildPriceAlertRow(preview[i], accent),
              ),
        ],
      ),
    );
  }

  Widget _buildPriceAlertRow(PriceAlert alert, Color accent) {
    final isAbove = alert.direction.toLowerCase() == 'above';
    // Defensive defaults — legacy rows or partial responses can have
    // empty symbol / fiat, which would render as blank space. Fall
    // back to the crypto_id and the active locale currency so the row
    // always reads cleanly.
    final symbol = alert.cryptoSymbol.isNotEmpty
        ? alert.cryptoSymbol.toUpperCase()
        : alert.cryptoId.toUpperCase();
    final fiat = alert.fiatCurrency.isNotEmpty
        ? alert.fiatCurrency.toUpperCase()
        : CurrencySymbols.currentCurrency.toUpperCase();
    final priceStr = alert.targetPrice >= 1
        ? alert.targetPrice.toStringAsFixed(2)
        : alert.targetPrice.toStringAsFixed(6);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            isAbove ? Icons.arrow_upward : Icons.arrow_downward,
            color: accent,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$symbol ${isAbove ? "above" : "below"} $fiat $priceStr',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  alert.isTriggered ? 'Triggered' : 'Active',
                  style: TextStyle(
                    color: alert.isTriggered ? Colors.grey : accent,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.grey, size: 18.sp),
            tooltip: 'Delete alert',
            onPressed: () => context.read<CryptoCubit>().removePriceAlert(alert.id),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistSection(CryptosLoaded state) {
    if (state.watchlistLoading) {
      return _cardSectionShimmer('Watchlist', rows: 3);
    }
    // Resolve watchlist crypto IDs to actual Crypto objects
    final watchlistCryptos = <Crypto>[];
    for (final watchlist in state.watchlists) {
      for (final cryptoId in watchlist.cryptoIds) {
        final match = state.cryptos.cast<Crypto?>().firstWhere(
          (c) => c?.id == cryptoId,
          orElse: () => null,
        );
        if (match != null && !watchlistCryptos.any((c) => c.id == match.id)) {
          watchlistCryptos.add(match);
        }
      }
    }
    // Also include favorited cryptos
    for (final crypto in state.cryptos) {
      if (crypto.isFavorite && !watchlistCryptos.any((c) => c.id == crypto.id)) {
        watchlistCryptos.add(crypto);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                        Text(
                'Your Watchlist',
                style: TextStyle(
                            color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  final cubit = context.read<CryptoCubit>();
                  Get.bottomSheet(
                    BlocProvider.value(
                      value: cubit,
                      child: const WatchlistManagerSheet(),
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 78, 3, 208),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (watchlistCryptos.isNotEmpty) ...[
            for (int i = 0; i < (watchlistCryptos.length > 3 ? 3 : watchlistCryptos.length); i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < 2 ? 12.h : 0),
                child: _buildWatchlistItem(watchlistCryptos[i]),
              ),
          ] else
            Text(
              'No cryptocurrencies in watchlist',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
                ),
              ],
            ),
          );
        }

  Widget _buildWatchlistItem(Crypto crypto) {
    return GestureDetector(
      onTap: () => _navigateToCryptoDetails(crypto),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crypto.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    crypto.symbol.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      crypto.priceChangePercentage24h >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
                      size: 12.sp,
                    ),
                    Text(
                      '${crypto.priceChangePercentage24h.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
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

  CryptoTransactionHistory _convertToHistory(CryptoTransaction txn) {
    CryptoTransactionType historyType;
    switch (txn.type) {
      case TransactionType.buy:
        historyType = CryptoTransactionType.buy;
      case TransactionType.sell:
        historyType = CryptoTransactionType.sell;
      case TransactionType.swap:
        historyType = CryptoTransactionType.swap;
      case TransactionType.send:
        historyType = CryptoTransactionType.send;
      case TransactionType.deposit:
        historyType = CryptoTransactionType.deposit;
    }

    // Shared mapper — MUST stay identical to the view-all history screen.
    // (The old local switch collapsed swap_pending/reversed/refunded into
    // "failed", so the landing badge disagreed with view-all.)
    final historyStatus = mapBackendCryptoTxStatus(txn.status);

    return CryptoTransactionHistory(
      id: txn.id,
      type: historyType,
      cryptoName: txn.cryptoName,
      cryptoSymbol: txn.cryptoSymbol,
      amount: txn.quantity.toStringAsFixed(6),
      gbpAmount: txn.totalAmount,
      status: historyStatus,
      timestamp: txn.timestamp,
      fee: txn.fees,
    );
  }

  Widget _buildRecentTransactionsSection(List<CryptoTransaction> transactions,
      {bool loading = false}) {
    if (loading) {
      return _cardSectionShimmer('Recent Transactions', rows: 3);
    }
    final recentTransactions = transactions.map(_convertToHistory).toList();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Recent Transactions',
                style: TextStyle(
                    color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final cryptoCubit = context.read<CryptoCubit>();
                  Get.to(() => BlocProvider.value(
                    value: cryptoCubit,
                    child: const CryptoTransactionHistoryScreen(),
                  ));
                },
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            ],
                ),
                SizedBox(height: 16.h),
          if (recentTransactions.isNotEmpty) ...[
            for (int i = 0; i < (recentTransactions.length > 3 ? 3 : recentTransactions.length); i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < 2 ? 12.h : 0),
                child: _buildRecentTransactionItem(recentTransactions[i]),
              ),
          ] else ...[
            Container(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 48.sp,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No recent transactions',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Your transaction history will appear here',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 12.h),
          _buildTransactionSummaryStats(recentTransactions),
              ],
            ),
          );
        }

  Widget _buildRecentTransactionItem(CryptoTransactionHistory transaction) {
    return GestureDetector(
      // opaque so the WHOLE row opens the receipt, not just the painted text.
      // Matches the history screen's rows — both lists render the same
      // transactions and must behave identically.
      behavior: HitTestBehavior.opaque,
      onTap: () => _showTransactionDetails(transaction),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
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
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: _getTransactionTypeColorForHistory(transaction.type).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                _getTransactionTypeIconForHistory(transaction.type),
                color: _getTransactionTypeColorForHistory(transaction.type),
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTransactionTitleForHistory(transaction),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _formatTransactionDateTime(transaction.timestamp),
                    style: TextStyle(
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
                  '${transaction.amount} ${transaction.cryptoSymbol}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: _getTransactionStatusColor(transaction.status).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    cryptoTxStatusLabel(transaction.status).toUpperCase(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: _getTransactionStatusColor(transaction.status),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSummaryStats(List<CryptoTransactionHistory> recentTransactions) {
    final totalTransactions = recentTransactions.length;
    final totalValue = recentTransactions.fold(0.0, (sum, txn) => sum + txn.gbpAmount);
    final completedTransactions = recentTransactions.where((txn) => txn.status == CryptoTransactionStatus.completed).length;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStatItem('Transactions', '$totalTransactions'),
          _buildSummaryStatItem('Total Value', '${CurrencySymbols.currentSymbol}${totalValue.toStringAsFixed(0)}'),
          _buildSummaryStatItem('Completed', '$completedTransactions'),
        ],
      ),
    );
  }

  Widget _buildSummaryStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  void _showTransactionDetails(CryptoTransactionHistory transaction) {
    // Straight to the full-page receipt (shared builder, real details) —
    // the intermediate details bottomsheet was removed by request.
    openCryptoTransactionReceipt(transaction);
  }


  // Helper methods for transaction history
  Color _getTransactionTypeColorForHistory(CryptoTransactionType type) {
    switch (type) {
      case CryptoTransactionType.buy:
        return Colors.green;
      case CryptoTransactionType.sell:
        return Colors.red;
      case CryptoTransactionType.swap:
        return const Color.fromARGB(255, 78, 3, 208);
      case CryptoTransactionType.send:
        return Colors.orange;
      case CryptoTransactionType.deposit:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _getTransactionTypeIconForHistory(CryptoTransactionType type) {
    switch (type) {
      case CryptoTransactionType.buy:
        return Icons.add_circle_outline;
      case CryptoTransactionType.sell:
        return Icons.remove_circle_outline;
      case CryptoTransactionType.swap:
        return Icons.swap_horiz;
      case CryptoTransactionType.send:
        return Icons.arrow_upward;
      case CryptoTransactionType.deposit:
        return Icons.arrow_downward;
    }
  }

  String _getTransactionTitleForHistory(CryptoTransactionHistory transaction) {
    switch (transaction.type) {
      case CryptoTransactionType.buy:
        return 'Buy ${transaction.cryptoSymbol}';
      case CryptoTransactionType.sell:
        return 'Sell ${transaction.cryptoSymbol}';
      case CryptoTransactionType.swap:
        return 'Swap ${transaction.fromCrypto} → ${transaction.toCrypto}';
      case CryptoTransactionType.send:
        return 'Send ${transaction.cryptoSymbol}';
      case CryptoTransactionType.deposit:
        return 'Deposit ${transaction.cryptoSymbol}';
    }
  }

  Color _getTransactionStatusColor(CryptoTransactionStatus status) =>
      cryptoTxStatusColor(status);

  String _formatTransactionDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildLazerVaultServices() {
    return Padding(
      padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
            'Crypto Tools',
            style: TextStyle(
                    color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16.w,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.1,
            children: [
              _buildFeatureCard(
                'Smart Trading',
                'Market sentiment & signals',
                Icons.psychology,
                Colors.purple,
              ),
              _buildFeatureCard(
                'Secure Wallet',
                'Multi-layer security',
                Icons.security,
                const Color.fromARGB(255, 78, 3, 208),
              ),
              _buildFeatureCard(
                'Pro Exchange',
                'Live charts & market depth',
                Icons.candlestick_chart,
                Colors.orange,
              ),
              _buildFeatureCard(
                'Crypto Academy',
                'Crypto education',
                Icons.school,
                Colors.green,
              ),
            ],
          ),
              ],
            ),
          );
        }

  Widget _buildFeatureCard(String title, String subtitle, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _navigateToService(title),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToService(String serviceName) {
    switch (serviceName) {
      case 'Smart Trading':
        Get.to(() => const SmartTradingScreen());
        break;
      case 'Secure Wallet':
        // SecureWalletScreen reads live data via BlocBuilder<CryptoCubit>, but
        // Get.to pushes a route OUTSIDE this screen's provider scope. Re-provide
        // the SAME cubit instance so it isn't a ProviderNotFoundException.
        {
          final cryptoCubit = context.read<CryptoCubit>();
          Get.to(() => BlocProvider.value(
                value: cryptoCubit,
                child: const SecureWalletScreen(),
              ));
        }
        break;
      case 'Pro Exchange':
        Get.to(() => const ProExchangeScreen());
        break;
      case 'Crypto Academy':
        Get.to(() => const LearnEarnScreen());
        break;
      default:
        Get.snackbar(
          'Coming Soon',
          '$serviceName feature is coming soon!',
          backgroundColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
          colorText: Colors.white,
        );
    }
  }

  Widget _buildMarketOverview(CryptosLoaded state) {
    // Derive market trend from average 24h price change of loaded cryptos
    final avgChange = state.cryptos.isNotEmpty
        ? state.cryptos.fold(0.0, (sum, c) => sum + c.priceChangePercentage24h) / state.cryptos.length
        : 0.0;
    final isMarketUp = avgChange >= 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
        borderRadius: BorderRadius.circular(24.r),
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
                'Market Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
        children: [
          Icon(
                      isMarketUp ? Icons.trending_up : Icons.trending_down,
                      color: isMarketUp ? Colors.green : Colors.red,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
          Text(
                      'Market is ${isMarketUp ? 'up' : 'down'} ${avgChange.abs().toStringAsFixed(1)}%',
                      style: TextStyle(
              color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMarketStat(
                'Market Cap',
                state.globalMarketData != null
                    ? '${CurrencySymbols.currentSymbol}${_formatLargeNumber(state.globalMarketData!.totalMarketCap)}'
                    : '--',
                '',
                loading: state.statsLoading && state.globalMarketData == null,
              ),
              _buildMarketStat(
                '24h Volume',
                state.globalMarketData != null
                    ? '${CurrencySymbols.currentSymbol}${_formatLargeNumber(state.globalMarketData!.totalVolume24h)}'
                    : '--',
                '',
                loading: state.statsLoading && state.globalMarketData == null,
              ),
              _buildMarketStat(
                'BTC Dom.',
                state.globalMarketData != null
                    ? '${state.globalMarketData!.marketCapPercentageBtc.toStringAsFixed(1)}%'
                    : '--',
                '',
                loading: state.statsLoading && state.globalMarketData == null,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Coins',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (state.trendingCryptos.length > 3)
                GestureDetector(
                  onTap: () => _showTrendingCryptosSheet(state.trendingCryptos),
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 14.sp,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          if (state.trendingCryptos.isNotEmpty) ...[
            for (int i = 0; i < (state.trendingCryptos.length > 3 ? 3 : state.trendingCryptos.length); i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < 2 ? 12.h : 0),
                child: _buildCryptoListTile(state.trendingCryptos[i]),
              ),
          ] else ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'No trending data available',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ──────────────── Supported Assets Section ────────────────
  Widget _buildSupportedAssetsSection(CryptosLoaded state) {
    final assets = state.cryptos;
    final displayCount = assets.length > 5 ? 5 : assets.length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Supported Assets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final cryptoCubit = context.read<CryptoCubit>();
                  Get.to(() => BlocProvider.value(
                    value: cryptoCubit,
                    child: const AllAssetsScreen(),
                  ));
                },
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (assets.isNotEmpty) ...[
            for (int i = 0; i < displayCount; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < displayCount - 1 ? 12.h : 0),
                child: _buildCryptoListTile(assets[i]),
              ),
          ] else
            Text(
              'No assets available',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14.sp,
              ),
            ),
        ],
      ),
    );
  }

  // ──────────────── Trending Cryptos Bottom Sheet ────────────────
  void _showTrendingCryptosSheet(List<Crypto> trendingCryptos) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
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
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Coins',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: trendingCryptos.length,
                itemBuilder: (context, index) {
                  final crypto = trendingCryptos[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildCryptoListTile(crypto),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // ──────────────── Top Movers Bottom Sheet ────────────────
  void _showTopMoversSheet(CryptosLoaded state) {
    final gainers = _sortedGainers(state);
    final losers = _sortedLosers(state);

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setSheetState) {
          bool showGainers = true;
          return Container(
            height: Get.height * 0.75,
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
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
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Movers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                      ),
                    ],
                  ),
                ),
                // Toggle tabs
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: StatefulBuilder(
                    builder: (context, setTabState) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setTabState(() => showGainers = true),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: showGainers ? const Color(0xFF1F1F1F) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Top Gainers (${gainers.length})',
                                        style: TextStyle(
                                          color: showGainers ? Colors.green : Colors.grey[400],
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setTabState(() => showGainers = false),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: !showGainers ? const Color(0xFF1F1F1F) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Top Losers (${losers.length})',
                                        style: TextStyle(
                                          color: !showGainers ? Colors.red : Colors.grey[400],
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: Get.height * 0.75 - 200.h,
                            child: ListView.builder(
                              itemCount: showGainers ? gainers.length : losers.length,
                              itemBuilder: (context, index) {
                                final crypto = showGainers ? gainers[index] : losers[index];
                                return _buildMoverItem(crypto);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  // Horizontal-scrolling spotlight row that sits just above Top Movers.
  // Surfaces the user's tradable assets with sparkline + current price +
  // 24h change. Defaults to the top 10 supported assets by market cap;
  // user can tap any card to jump straight to the asset detail screen.
  Widget _buildCryptoCardsRow(CryptosLoaded state) {
    // Prefer supported assets (the ones tradable via Quidax) so taps
    // don't dead-end on unsupported coins. Fall back to overall market
    // when the supported list hasn't hydrated yet (very rare).
    final pool = state.supportedAssets.isNotEmpty
        ? state.supportedAssets
        : state.cryptos;
    if (pool.isEmpty) return SizedBox(height: 8.h);

    // Pin BTC + ETH to the front when present, then top market-cap
    // assets after. Keeps the row feeling familiar across runs.
    final priorities = ['BTC', 'ETH', 'USDT', 'USDC', 'SOL', 'XRP'];
    final byPriority = <Crypto>[];
    final remainder = <Crypto>[];
    for (final c in pool) {
      if (priorities.contains(c.symbol.toUpperCase())) {
        byPriority.add(c);
      } else {
        remainder.add(c);
      }
    }
    byPriority.sort((a, b) => priorities
        .indexOf(a.symbol.toUpperCase())
        .compareTo(priorities.indexOf(b.symbol.toUpperCase())));
    final cards = [...byPriority, ...remainder].take(30).toList();

    final sym = CurrencySymbols.currentSymbol;
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
      child: SizedBox(
        // Bug #150 follow-up: card content (header + price + change row
        // + 60h sparkline + spacers + 16w padding + 8w margin top/bottom)
        // intrinsics to ~248h on the test emulator. 220h was 28px over;
        // 260h gives ~12px breathing room which absorbs cross-device
        // font-metric variance without making the cards row sit awkwardly
        // tall (the surrounding screen layout reflows fine — the cards
        // row is between the "Top movers" header and the next section).
        height: 260.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          itemCount: cards.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (context, i) {
            final crypto = cards[i];
            final color = _accentForSymbol(crypto.symbol);
            return SizedBox(
              width: 160.w,
              child: _buildCryptoCard(
                crypto,
                crypto.symbol.toUpperCase(),
                '$sym${crypto.currentPrice.toStringAsFixed(2)}',
                crypto.priceChangePercentage24h,
                _sparklineFromCrypto(crypto),
                color,
              ),
            );
          },
        ),
      ),
    );
  }

  // Stable color per ticker so the row reads as the same asset across
  // refreshes (not deterministic from the data itself, just symbol).
  Color _accentForSymbol(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
        return const Color(0xFFF7931A);
      case 'ETH':
        return const Color(0xFF627EEA);
      case 'USDT':
        return const Color(0xFF26A17B);
      case 'USDC':
        return const Color(0xFF2775CA);
      case 'SOL':
        return const Color(0xFF9945FF);
      case 'XRP':
        return const Color(0xFF23292F);
      case 'BNB':
        return const Color(0xFFF3BA2F);
      case 'ADA':
        return const Color(0xFF0033AD);
      case 'DOGE':
        return const Color(0xFFC2A633);
      default:
        return const Color.fromARGB(255, 78, 3, 208);
    }
  }

  // Normalize the latest 7 price points to [0,1] for the chart, or fall
  // back to a directional ramp when no price history is available.
  List<double> _sparklineFromCrypto(Crypto crypto) {
    if (crypto.priceHistory.isNotEmpty) {
      final points = crypto.priceHistory.take(7).map((p) => p.price).toList();
      if (points.isEmpty) return [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
      final minP = points.reduce((a, b) => a < b ? a : b);
      final maxP = points.reduce((a, b) => a > b ? a : b);
      final range = maxP - minP;
      if (range == 0) return List.filled(points.length, 0.5);
      return points.map((p) => (p - minP) / range).toList();
    }
    final change = crypto.priceChangePercentage24h;
    if (change >= 0) return [0.3, 0.35, 0.4, 0.45, 0.5, 0.6, 0.7];
    return [0.7, 0.6, 0.5, 0.45, 0.4, 0.35, 0.3];
  }

  Widget _buildTopMoversSection(CryptosLoaded state) {
    if (state.topMoversLoading) {
      return _moversShimmer();
    }
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top movers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => _showTopMoversSheet(state),
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showGainers = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
                      color: _showGainers ? const Color(0xFF1F1F1F) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Center(
                      child: Text(
                        'Top gainers',
                        style: TextStyle(
                          color: _showGainers ? Colors.white : Colors.grey[400],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showGainers = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: !_showGainers ? const Color(0xFF1F1F1F) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Center(
                      child: Text(
                        'Top losers',
                        style: TextStyle(
                          color: !_showGainers ? Colors.white : Colors.grey[400],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...(_showGainers ? _buildTopGainers(state) : _buildTopLosers(state)),
        ],
      ),
    );
  }

  /// High-risk investment warning (UK FCA-style). Restored to the landing page.
  /// When an admin has set `crypto.risk_disclaimer_url` (surfaced on
  /// GlobalMarketData.learnMoreUrl), the whole card is tappable and "Take 2 mins
  /// to learn more" renders as a link that opens the URL in the app's in-app
  /// web-view bottom sheet; with no URL configured it stays plain, static text.
  Widget _buildRiskWarning(CryptosLoaded state) {
    final url = (state.globalMarketData?.learnMoreUrl ?? '').trim();
    final base = TextStyle(color: Colors.grey[400], fontSize: 12.sp, height: 1.5);
    const warning =
        "Don't invest unless you're prepared to lose all the money you invest. "
        "This is a high-risk investment and you should not expect to be protected "
        "if something goes wrong. ";
    final card = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: warning),
            TextSpan(
              text: 'Take 2 mins to learn more',
              // Link styling only when a URL is configured (the whole card
              // carries the tap — no per-span recognizer to leak).
              style: url.isEmpty
                  ? null
                  : base.copyWith(
                      color: const Color(0xFF3B82F6),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ],
        ),
        style: base,
        textAlign: TextAlign.center,
      ),
    );
    if (url.isEmpty) return card;
    return GestureDetector(
      onTap: () => showWebViewBottomSheet(
        context,
        url: url,
        title: 'Crypto risk warning',
      ),
      child: card,
    );
  }

  Widget _buildFooter() {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        // Disclosure URL is admin-managed via system_settings
        // (`crypto.disclosure_url`). When ops hasn't set one, fall back to the
        // published default so the Crypto Risk Disclosure is ALWAYS reachable
        // (App Store / Play compliance) instead of the CTA being hidden.
        final configured = state is CryptosLoaded
            ? (state.globalMarketData?.disclosureUrl ?? '')
            : '';
        final url = configured.trim().isNotEmpty
            ? configured.trim()
            : 'https://lazervault.app/legal/crypto';
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          child: Column(
            children: [
              Text(
                'Service provided by Lazervault Ltd.',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.45),
                  fontSize: 11.sp,
                ),
                textAlign: TextAlign.center,
              ),
              if (url.isNotEmpty) ...[
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => Get.to(
                    () => PartnerWebViewScreen(
                      url: url,
                      title: 'Crypto Disclosure',
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 78, 3, 208)
                          .withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: const Color.fromARGB(255, 78, 3, 208)
                            .withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.gavel_rounded,
                            color: Colors.white.withValues(alpha: 0.85),
                            size: 14.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'View crypto disclosure',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.open_in_new_rounded,
                            color: Colors.white.withValues(alpha: 0.65),
                            size: 12.sp),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(CryptoError state) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Error loading cryptocurrencies',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            state.message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => context.read<CryptoCubit>().loadCryptos(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Open Price Alerts, handing it the already-loaded Quidax-supported assets
  /// so its create sheet never has to re-fetch (that fetch was the source of the
  /// "failed to load assets" bug).
  Future<void> _openPriceAlerts() async {
    final s = context.read<CryptoCubit>().state;
    final assets = s is CryptosLoaded ? s.supportedAssets : <Crypto>[];
    await Get.to(() => PriceAlertsScreen(assets: assets));
  }

  void _showSearchBottomSheet() {
    // Search the Quidax-supported asset catalogue only (the tradable set), with
    // local filtering — no "popular" filler, results appear as the user types,
    // and tapping a result opens its detail page.
    final state = context.read<CryptoCubit>().state;
    final assets =
        state is CryptosLoaded ? state.supportedAssets : <Crypto>[];
    showCryptoSearchSheet(
      context,
      assets: assets,
      onSelect: _navigateToCryptoDetails,
    );
  }

  Future<void> _navigateToCryptoDetails(Crypto crypto) async {
    // Use the canonical named route (same path the main asset list uses) so the
    // detail screen is wired with its cubit + arguments consistently.
    await Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
    // The detail screen's bookmark/save toggle runs on its OWN CryptoCubit
    // instance (named route builds a fresh cubit), so pull the latest
    // watchlist membership back into THIS page's cubit on return. Without
    // this, saving an asset on the detail screen wouldn't show up in the
    // "Your Watchlist" section (or the saved indicators) until a full reload.
    if (!mounted) return;
    context.read<CryptoCubit>().refreshWatchlists();
  }

  Widget _buildMarketStat(String label, String value, String change,
      {bool loading = false}) {
    bool isPositive = change.startsWith('+');
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        // Shimmer skeleton while the stat is still loading — never a stale
        // "--" / "…" placeholder.
        if (loading)
          CryptoSkeleton(width: 64.w, height: 16.h, radius: 4.r)
        else
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(height: 2.h),
        Text(
          change,
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Reusable crypto list tile — navigates to details with the REAL Crypto object.
  Widget _buildCryptoListTile(Crypto crypto) {
    final change = crypto.priceChangePercentage24h;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _navigateToCryptoDetails(crypto),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
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
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                    crypto.symbol.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
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
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: change >= 0 ? Colors.green : Colors.red,
                      size: 12.sp,
                  ),
                  Text(
                      '${change.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: change >= 0 ? Colors.green : Colors.red,
                      fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
        ),
      ),
    ),
  );
  }

  Widget _buildCryptoCard(
    Crypto? cryptoObj,
    String symbol,
    String price,
    double change,
    List<double> chartData,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        if (cryptoObj != null) {
          _navigateToCryptoDetails(cryptoObj);
        }
      },
      child: Container(
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        ),
        // Bug #150 fix: mainAxisSize.min so the Column doesn't try to fill
        // the parent's intrinsic height. The 60h sparkline (LineChart) + the
        // header row + price row otherwise overflowed by 81px on smaller
        // emulator screens, raising "A RenderFlex overflowed" yellow-black
        // stripes. The card content is naturally small; explicit min sizing
        // also avoids future regressions when a tighter parent is used.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
        children: [
          CryptoAssetAvatar(
            symbol: symbol,
            imageUrl: cryptoObj?.image,
            size: 36,
          ),
                SizedBox(width: 8.w),
                Text(
                  symbol,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
            children: [
                Icon(
                  change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  color: change >= 0 ? Colors.green : Colors.red,
                  size: 16.sp,
                ),
              Text(
                  '${change.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: change >= 0 ? Colors.green : Colors.red,
                  fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 60.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                      isCurved: true,
                      color: color,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Crypto> _sortedGainers(CryptosLoaded state) {
    return state.cryptos
        .where((c) => c.priceChangePercentage24h > 0)
        .toList()
      ..sort((a, b) => b.priceChangePercentage24h.compareTo(a.priceChangePercentage24h));
  }

  List<Crypto> _sortedLosers(CryptosLoaded state) {
    return state.cryptos
        .where((c) => c.priceChangePercentage24h < 0)
        .toList()
      ..sort((a, b) => a.priceChangePercentage24h.compareTo(b.priceChangePercentage24h));
  }

  List<Widget> _buildTopGainers(CryptosLoaded state) {
    final gainers = _sortedGainers(state).take(3).toList();

    if (gainers.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            'No gainers in the last 24h',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14.sp),
          ),
        ),
      ];
    }

    return gainers.map((crypto) => _buildMoverItem(crypto)).toList();
  }

  List<Widget> _buildTopLosers(CryptosLoaded state) {
    final losers = _sortedLosers(state).take(3).toList();

    if (losers.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            'No losers in the last 24h',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14.sp),
          ),
        ),
      ];
    }

    return losers.map((crypto) => _buildMoverItem(crypto)).toList();
  }

  Widget _buildMoverItem(Crypto crypto) {
    final change = crypto.priceChangePercentage24h;
    return GestureDetector(
      onTap: () => _navigateToCryptoDetails(crypto),
        child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.currency_exchange, color: const Color.fromARGB(255, 78, 3, 208), size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    crypto.name,
                    style: TextStyle(
                  color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    crypto.symbol.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: change >= 0 ? Colors.green : Colors.red,
                      size: 12.sp,
                    ),
                    Text(
                      '${change.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: change >= 0 ? Colors.green : Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
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

  String _formatLargeNumber(double value) {
    if (value >= 1e12) {
      return '${(value / 1e12).toStringAsFixed(2)}T';
    } else if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B';
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M';
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(2);
  }
} 