import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../models/crypto_transaction_models.dart';
import 'all_assets_screen.dart';
import '../widgets/crypto_search_bar.dart';
import '../widgets/voice_input_widget.dart';
import 'crypto_detail_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/voice_grpc_client.dart';
import 'swap_crypto_screen.dart';
import 'send_crypto_screen.dart';
import 'user_holdings_screen.dart';
import 'price_alerts_screen.dart';
import 'crypto_transaction_history_screen.dart';
import 'crypto_receipt_screen.dart';
import 'smart_trading_screen.dart';
import '../../../lifestyle/presentation/screens/partner_webview_screen.dart';
import 'secure_wallet_screen.dart';
import 'pro_exchange_screen.dart';
import 'learn_earn_screen.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import '../widgets/crypto_shimmer_loading.dart';
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
      body: SafeArea(
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
                    _buildWarningMessage(),
                    _buildSupportedAssetsSection(state),
                    _buildMarketOverview(state),
                    _buildWatchlistSection(state),
                    _buildRecentTransactionsSection(state.transactions),
                    _buildLazerVaultServices(),
                    _buildPriceAlertsSection(state),
                    _buildCryptoCardsRow(state),
                    _buildTopMoversSection(state),
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
    Get.bottomSheet(
      VoiceInputWidget(
        voiceClient: serviceLocator<VoiceGrpcClient>(),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Back Button
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
            ),
          ),
          SizedBox(width: 16.w),
          // Crypto Title
          Expanded(
            child: Text(
              'Crypto',
                  style: GoogleFonts.inter(
                fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          ),
          // Action buttons row
          Row(
            children: [
              // Voice Command Button
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(Icons.mic, color: const Color.fromARGB(255, 78, 3, 208), size: 20.sp),
                  onPressed: _showVoiceInputBottomSheet,
                ),
              ),
              SizedBox(width: 12.w),
              // Chat Button
              MicroserviceChatIcon(
                serviceName: 'Crypto',
                sourceContext: 'crypto',
              ),
              SizedBox(width: 12.w),
              // Notifications Button
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 20.sp),
                  onPressed: () {
                    Get.snackbar(
                      'Notifications',
                      'No new notifications',
                      backgroundColor: const Color(0xFF1F1F1F),
                      colorText: Colors.white,
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              // More Options Menu
              Container(
                height: 40.h,
                width: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white, size: 20.sp),
                  onPressed: () => _showMoreOptionsMenu(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioOverview(CryptosLoaded state) {
    final totalValue = state.holdings.fold(0.0, (sum, holding) => sum + holding.totalValue);
    final totalGainLoss = state.holdings.fold(0.0, (sum, holding) => sum + holding.totalGainLoss);
    final gainLossPercentage = totalValue > 0 ? (totalGainLoss / (totalValue - totalGainLoss)) * 100 : 0.0;
    final isPositive = totalGainLoss >= 0;
    // Lazy-loading: when ANY held asset is still awaiting its fiat rate,
    // the running total is a partial sum. The UI renders a subtle
    // "loading" hint next to the value so users don't mistake a half-
    // populated total for the truth.
    final hasPriceLoading = state.holdings.any((h) => h.priceLoading);

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
          Row(
            children: [
              Text(
                '${CurrencySymbols.currentSymbol}${totalValue.toStringAsFixed(2)}',
                style: TextStyle(
                color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
              if (hasPriceLoading) ...[
                SizedBox(width: 8.w),
                SizedBox(
                  width: 14.w,
                  height: 14.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.6,
                    valueColor: AlwaysStoppedAnimation(Colors.white.withValues(alpha: 0.55)),
                  ),
                ),
              ],
              SizedBox(width: 12.w),
              if (gainLossPercentage != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositive ? Colors.green : Colors.red).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${gainLossPercentage.abs().toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPortfolioStat('Assets', '${state.holdings.length}'),
              _buildPortfolioStat('24h Change', '${isPositive ? '+' : ''}${CurrencySymbols.currentSymbol}${totalGainLoss.abs().toStringAsFixed(2)}'),
              _buildPortfolioStat('Best Asset', state.holdings.isNotEmpty ? 
                '${state.holdings.first.cryptoSymbol} ${state.holdings.first.totalGainLossPercentage >= 0 ? '+' : ''}${state.holdings.first.totalGainLossPercentage.toStringAsFixed(1)}%' : 
                'None'),
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
            Get.to(() => BlocProvider.value(
              value: cryptoCubit,
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

  Widget _buildWarningMessage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        "Don't invest unless you're prepared to lose all the money you invest. This is a high-risk investment and you should not expect to be protected if something goes wrong. Take 2 mins to learn more",
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 12.sp,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPortfolioStat(String label, String value) {
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
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        ),
      ],
    );
  }

  Widget _buildPriceAlertsSection(CryptosLoaded state) {
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
                      await Get.to(() => const PriceAlertsScreen());
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
                    await Get.to(() => const PriceAlertsScreen());
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
      onTap: () => Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto),
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
    }

    CryptoTransactionStatus historyStatus;
    switch (txn.status.toLowerCase()) {
      case 'completed':
      case 'success':
        historyStatus = CryptoTransactionStatus.completed;
      case 'pending':
      case 'processing':
        historyStatus = CryptoTransactionStatus.pending;
      default:
        historyStatus = CryptoTransactionStatus.failed;
    }

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

  Widget _buildRecentTransactionsSection(List<CryptoTransaction> transactions) {
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
                    transaction.status.name.toUpperCase(),
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
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                          'Transaction Details',
                          style: TextStyle(
                            fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _buildDetailItem('Transaction ID', transaction.id),
                    _buildDetailItem('Type', _getTransactionTitleForHistory(transaction)),
                    _buildDetailItem('Amount', '${transaction.amount} ${transaction.cryptoSymbol}'),
                    _buildDetailItem('Value', '${CurrencySymbols.currentSymbol}${transaction.gbpAmount.toStringAsFixed(2)}'),
                    _buildDetailItem('Fee', '${CurrencySymbols.currentSymbol}${transaction.fee.toStringAsFixed(2)}'),
                    _buildDetailItem('Status', transaction.status.name.toUpperCase()),
                    _buildDetailItem('Date', _formatTransactionDateTime(transaction.timestamp)),
                    if (transaction.type == CryptoTransactionType.swap) ...[
                      _buildDetailItem('From', transaction.fromCrypto ?? 'Unknown'),
                      _buildDetailItem('To', transaction.toCrypto ?? 'Unknown'),
                    ],
                    SizedBox(height: 24.h),
                    if (transaction.status == CryptoTransactionStatus.completed)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _viewTransactionReceipt(transaction),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'View Receipt',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                          color: Colors.white,
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
              ],
            ),
          );
        }

  void _viewTransactionReceipt(CryptoTransactionHistory transaction) {
    Get.back(); // Close bottom sheet
    
    // Create transaction details
    final transactionDetails = CryptoTransactionDetails(
      type: transaction.type,
      cryptoName: transaction.cryptoName,
      cryptoSymbol: transaction.cryptoSymbol,
      cryptoAmount: transaction.amount,
      pricePerUnit: transaction.gbpAmount / double.parse(transaction.amount),
      fiatAmount: transaction.gbpAmount,
      networkFee: transaction.fee * 0.3,
      tradingFee: transaction.fee * 0.7,
      totalAmount: transaction.gbpAmount + transaction.fee,
      paymentMethod: 'Card',
      fromCrypto: transaction.fromCrypto,
      toCrypto: transaction.toCrypto,
    );
    
    // Create receipt
    final receipt = CryptoTransactionReceipt(
      transactionId: transaction.id,
      transactionDetails: transactionDetails,
      timestamp: transaction.timestamp,
      status: transaction.status,
    );
    
    Get.to(() => CryptoReceiptScreen(receipt: receipt));
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
    }
  }

  Color _getTransactionStatusColor(CryptoTransactionStatus status) {
    switch (status) {
      case CryptoTransactionStatus.completed:
        return Colors.green;
      case CryptoTransactionStatus.pending:
      case CryptoTransactionStatus.verifying:
        return Colors.orange;
      case CryptoTransactionStatus.failed:
        return Colors.red;
      case CryptoTransactionStatus.refunded:
        return const Color(0xFF9CA3AF);
      case CryptoTransactionStatus.manualReview:
        return const Color(0xFFFB923C);
    }
  }

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
            'LazerVault Services',
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
                'AI-powered insights',
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
                'Advanced trading tools',
                Icons.candlestick_chart,
                Colors.orange,
              ),
              _buildFeatureCard(
                'Learn & Earn',
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
        Get.to(() => const SecureWalletScreen());
        break;
      case 'Pro Exchange':
        Get.to(() => const ProExchangeScreen());
        break;
      case 'Learn & Earn':
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
              ),
              _buildMarketStat(
                '24h Volume',
                state.globalMarketData != null
                    ? '${CurrencySymbols.currentSymbol}${_formatLargeNumber(state.globalMarketData!.totalVolume24h)}'
                    : '--',
                '',
              ),
              _buildMarketStat(
                'BTC Dom.',
                state.globalMarketData != null
                    ? '${state.globalMarketData!.marketCapPercentageBtc.toStringAsFixed(1)}%'
                    : '--',
                '',
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
                child: _buildCryptoListTile(
                  state.trendingCryptos[i],
                  iconColor: Colors.orange,
                ),
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
                child: _buildCryptoListTile(
                  assets[i],
                  iconColor: const Color.fromARGB(255, 78, 3, 208),
                ),
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
                    child: _buildCryptoListTile(
                      crypto,
                      iconColor: Colors.orange,
                    ),
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

  Widget _buildFooter() {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        // Disclosure URL is admin-managed via system_settings
        // (`crypto.disclosure_url`). Hide the CTA entirely when ops
        // hasn't set a URL so the footer never opens a dead link.
        final url = state is CryptosLoaded
            ? (state.globalMarketData?.disclosureUrl ?? '')
            : '';
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          child: Column(
            children: [
              Text(
                'Service provided by LazerVault Ltd.',
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

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: BlocBuilder<CryptoCubit, CryptoState>(
          builder: (context, state) {
            final searchResults = state is CryptosLoaded ? state.cryptos : <Crypto>[];
            final isLoading = state is CryptoLoading;
            
            return CryptoSearchBar(
              controller: _searchController,
              onSearch: (query) => context.read<CryptoCubit>().searchCryptos(query),
              onCryptoSelected: _navigateToCryptoDetails,
              searchResults: searchResults,
              isLoading: isLoading,
            );
          },
        ),
      ),
    );
  }

  void _navigateToCryptoDetails(Crypto crypto) {
    Get.to(
      () => BlocProvider(
        create: (context) => serviceLocator<CryptoCubit>(),
        child: CryptoDetailScreen(crypto: crypto),
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildMarketStat(String label, String value, String change) {
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
  Widget _buildCryptoListTile(Crypto crypto, {Color iconColor = Colors.orange}) {
    final change = crypto.priceChangePercentage24h;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
            children: [
              Container(
              padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.currency_bitcoin,
                color: iconColor,
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
          Get.toNamed(AppRoutes.cryptoDetails, arguments: cryptoObj);
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
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
            ),
            child: Icon(
                    symbol == 'BTC' ? Icons.currency_bitcoin : Icons.currency_exchange,
                    color: color,
                    size: 20.sp,
                  ),
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
      onTap: () => Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto),
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

  void _showMoreOptionsMenu() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More Options',
                        style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                          color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildMenuOption(
                    Icons.search,
                    'Search',
                    'Find cryptocurrencies',
                    () {
                      Get.back();
                      _showSearchBottomSheet();
                    },
                  ),
                  _buildMenuOption(
                    Icons.person_outline,
                    'Profile',
                    'Manage your account',
                    () {
                      Get.back();
                      Get.snackbar(
                        'Profile',
                        'Profile management coming soon!',
                        backgroundColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                        colorText: Colors.white,
                      );
                    },
                  ),
                  _buildMenuOption(
                    Icons.settings_outlined,
                    'Settings',
                    'App preferences',
                    () {
                      Get.back();
                      Get.snackbar(
                        'Settings',
                        'Settings coming soon!',
                        backgroundColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                        colorText: Colors.white,
                      );
                    },
                  ),
                  _buildMenuOption(
                    Icons.help_outline,
                    'Help & Support',
                    'Get assistance',
                    () {
                          Get.back();
                      Get.snackbar(
                        'Help',
                        'Help center coming soon!',
                        backgroundColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                        colorText: Colors.white,
                      );
                    },
                  ),
                  _buildMenuOption(
                    Icons.logout,
                    'Back to Investments',
                    'Return to main menu',
                    () {
                      Get.back();
                      Get.offAllNamed(AppRoutes.investments);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildMenuOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: const Color.fromARGB(255, 78, 3, 208), size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                        style: GoogleFonts.inter(
                      fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                      color: Colors.white,
                        ),
                      ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withValues(alpha: 0.5),
              size: 16.sp,
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