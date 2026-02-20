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
import '../../data/models/crypto_model.dart';
import '../widgets/crypto_search_bar.dart';
import '../widgets/voice_input_widget.dart';
import 'crypto_detail_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/voice_grpc_client.dart';
import 'buy_crypto_screen.dart';
import 'sell_crypto_screen.dart';
import 'swap_crypto_screen.dart';
import 'price_alerts_screen.dart';
import 'lazervault_card_screen.dart';
import 'crypto_transaction_history_screen.dart';
import 'crypto_confirmation_screen.dart';
import 'crypto_receipt_screen.dart';
import 'smart_trading_screen.dart';
import 'secure_wallet_screen.dart';
import 'pro_exchange_screen.dart';
import 'learn_earn_screen.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _showGainers = true;

  // Transactions are loaded from the backend via CryptosCubit state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Load initial data
    context.read<CryptoCubit>().loadCryptos();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocBuilder<CryptoCubit, CryptoState>(
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
                  _buildTopBar(),
                  if (state is CryptosLoaded) ...[
                    _buildPortfolioOverview(state),
                    _buildQuickActions(),
                    _buildWarningMessage(),
                    _buildMarketOverview(state),
                    _buildWatchlistSection(state),
                    _buildRecentTransactionsSection(state.transactions),
                    _buildLazerVaultServices(),
                    _buildPriceAlertsSection(),
                    _buildLazerVaultCard(),
                    _buildCryptoCardsRow(state),
                    _buildTopMoversSection(state),
                    _buildFooter(),
                  ] else if (state is CryptoLoading) ...[
                    SizedBox(height: 200.h),
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C5CE7)),
                      ),
                    ),
                  ] else if (state is CryptoError) ...[
                    _buildErrorState(state),
                  ],
                  SizedBox(height: 100.h),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showVoiceInputBottomSheet,
        backgroundColor: const Color(0xFF6C5CE7),
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
              onPressed: () => Get.offAllNamed(AppRoutes.investments),
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
                  icon: Icon(Icons.mic, color: const Color(0xFF6C5CE7), size: 20.sp),
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
                child: Stack(
                  children: [
          IconButton(
                      icon: Icon(Icons.notifications_outlined, 
                        color: Colors.white, size: 20.sp),
                      onPressed: () {
                        Get.snackbar(
                          'Notifications',
                          'You have 3 new notifications',
                          backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                          colorText: Colors.white,
                        );
                      },
                    ),
                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: Container(
                        height: 8.h,
                        width: 8.w,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
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

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2C3E50),
            Color(0xFF6C5CE7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
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
          SizedBox(width: 12.w),
          Expanded(
            child: _buildQuickActionButton(
              'Sell',
              Icons.remove_circle_outline,
              Colors.red,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildQuickActionButton(
              'Swap',
              Icons.swap_horiz,
              const Color(0xFF6C5CE7),
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
              child: const BuyCryptoScreen(),
            ));
            break;
          case 'Sell':
            Get.to(() => BlocProvider.value(
              value: cryptoCubit,
              child: const SellCryptoScreen(),
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

  Widget _buildPriceAlertsSection() {
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
              IconButton(
                icon: Icon(Icons.add_alert_rounded, color: const Color(0xFF6C5CE7)),
                onPressed: () => Get.to(() => const PriceAlertsScreen()),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildPriceAlert('BTC', 'Above', '${CurrencySymbols.currentSymbol}70,000', true),
          SizedBox(height: 12.h),
          _buildPriceAlert('ETH', 'Below', '${CurrencySymbols.currentSymbol}1,400', false),
        ],
            ),
          );
        }

  Widget _buildPriceAlert(String coin, String type, String price, bool isActive) {
    return Container(
      padding: EdgeInsets.all(12.w),
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
                Icon(
            type == 'Above' ? Icons.arrow_upward : Icons.arrow_downward,
            color: isActive ? const Color(0xFF6C5CE7) : Colors.grey,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$coin $type $price',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: isActive ? const Color(0xFF6C5CE7) : Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (value) {},
            activeThumbColor: const Color(0xFF6C5CE7),
                ),
              ],
            ),
          );
        }

  Widget _buildWatchlistSection(CryptosLoaded state) {
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
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: const Color(0xFF6C5CE7),
                    fontSize: 14.sp,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          if (state.cryptos.isNotEmpty) ...[
            for (int i = 0; i < (state.cryptos.length > 3 ? 3 : state.cryptos.length); i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < 2 ? 12.h : 0),
                child: _buildWatchlistItem(
                  state.cryptos[i].name,
                  state.cryptos[i].symbol,
                  '${CurrencySymbols.currentSymbol}${state.cryptos[i].currentPrice.toStringAsFixed(2)}',
                  state.cryptos[i].priceChangePercentage24h,
                  Icons.star_rounded,
                ),
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

  Widget _buildWatchlistItem(
    String name,
    String symbol,
    String price,
    double change,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        // Create a crypto object and navigate to crypto details
        final crypto = Crypto(
          id: symbol.toLowerCase(),
          name: name,
          symbol: symbol.toLowerCase(),
          image: 'default.png',
          currentPrice: double.tryParse(price.replaceAll(CurrencySymbols.currentSymbol, '').replaceAll(',', '')) ?? 0.0,
          marketCap: 0.0,
          marketCapRank: 0,
          totalVolume: 0.0,
          high24h: 0.0,
          low24h: 0.0,
          priceChange24h: 0.0,
          priceChangePercentage24h: change,
          circulatingSupply: 0.0,
          lastUpdated: DateTime.now(),
        );
        Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.amber, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    symbol,
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
                  price,
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
                onTap: () => Get.to(() => const CryptoTransactionHistoryScreen()),
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: const Color(0xFF6C5CE7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: const Color(0xFF6C5CE7),
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
            const Color(0xFF6C5CE7).withValues(alpha: 0.1),
            const Color(0xFF6C5CE7).withValues(alpha: 0.05),
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
                            backgroundColor: const Color(0xFF6C5CE7),
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
        return const Color(0xFF6C5CE7);
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
        return Colors.orange;
      case CryptoTransactionStatus.failed:
        return Colors.red;
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
                const Color(0xFF6C5CE7),
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
          backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
          colorText: Colors.white,
        );
    }
  }

  Widget _buildMarketOverview(CryptosLoaded state) {
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
                      Icons.trending_up,
                      color: Colors.green,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
          Text(
                      'Market is up',
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
              _buildMarketStat('Market Cap', '${CurrencySymbols.currentSymbol}2.89T', '+2.4%'),
              _buildMarketStat('24h Volume', '${CurrencySymbols.currentSymbol}82.1B', '+5.1%'),
              _buildMarketStat('BTC Dom.', '48.2%', '-0.8%'),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Trending Coins',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          if (state.trendingCryptos.isNotEmpty) ...[
            for (int i = 0; i < (state.trendingCryptos.length > 3 ? 3 : state.trendingCryptos.length); i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < 2 ? 12.h : 0),
                child: _buildTrendingCoin(
                  state.trendingCryptos[i].name,
                  state.trendingCryptos[i].symbol,
                  '${CurrencySymbols.currentSymbol}${state.trendingCryptos[i].currentPrice.toStringAsFixed(2)}',
                  state.trendingCryptos[i].priceChangePercentage24h,
                  Colors.orange,
                ),
              ),
          ] else ...[
            _buildTrendingCoin('Bitcoin', 'BTC', '${CurrencySymbols.currentSymbol}66,175', 1.93, Colors.orange),
            SizedBox(height: 12.h),
            _buildTrendingCoin('Ethereum', 'ETH', '${CurrencySymbols.currentSymbol}1,544', 0.67, const Color(0xFF6C5CE7)),
            SizedBox(height: 12.h),
            _buildTrendingCoin('Solana', 'SOL', '${CurrencySymbols.currentSymbol}156.78', 2.45, Colors.purple),
          ],
        ],
      ),
    );
  }

  Widget _buildLazerVaultCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7),
            const Color(0xFF1A237E),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text(
                    'LazerVault Card',
            style: GoogleFonts.inter(
                      fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
                  SizedBox(height: 4.h),
          Text(
                    'Spend your crypto anywhere',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✓ Zero transaction fees',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '✓ Instant crypto conversion',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '✓ Global acceptance',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => const LazerVaultCardScreen()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Apply Now',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6C5CE7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoCardsRow(CryptosLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            child: _buildCryptoCard(
              'BTC',
              state.cryptos.isNotEmpty ? '${CurrencySymbols.currentSymbol}${state.cryptos[0].currentPrice.toStringAsFixed(2)}' : '${CurrencySymbols.currentSymbol}66,175',
              state.cryptos.isNotEmpty ? state.cryptos[0].priceChangePercentage24h : 1.93,
              [0.2, 0.3, 0.5, 0.4, 0.6, 0.5, 0.7],
              Colors.orange,
            ),
          ),
          Expanded(
            child: _buildCryptoCard(
              'ETH',
              state.cryptos.length > 1 ? '${CurrencySymbols.currentSymbol}${state.cryptos[1].currentPrice.toStringAsFixed(2)}' : '${CurrencySymbols.currentSymbol}1,544.43',
              state.cryptos.length > 1 ? state.cryptos[1].priceChangePercentage24h : 0.67,
              [0.4, 0.5, 0.3, 0.6, 0.4, 0.5, 0.3],
              const Color(0xFF6C5CE7),
            ),
          ),
        ],
      ),
    );
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
              Icon(Icons.chevron_right, color: Colors.white, size: 20.sp),
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
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        'Service provided by LazerVault Ltd. View Crypto Disclosures.',
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 12.sp,
        ),
        textAlign: TextAlign.center,
      ),
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
              backgroundColor: const Color(0xFF6C5CE7),
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

  Widget _buildTrendingCoin(
    String name,
    String symbol,
    String price,
    double change,
    Color iconColor,
  ) {
    return GestureDetector(
      onTap: () {
        // Find the crypto from state and navigate to crypto details
        final state = context.read<CryptoCubit>().state;
        if (state is CryptosLoaded) {
          final crypto = state.cryptos.firstWhere(
            (c) => c.symbol.toUpperCase() == symbol.toUpperCase(),
            orElse: () => CryptoModel(
              id: symbol.toLowerCase(),
              name: name,
              symbol: symbol.toLowerCase(),
              image: 'default.png',
              currentPrice: double.tryParse(price.replaceAll(CurrencySymbols.currentSymbol, '').replaceAll(',', '')) ?? 0.0,
              marketCap: 0.0,
              marketCapRank: 0,
              totalVolume: 0.0,
              high24h: 0.0,
              low24h: 0.0,
              priceChange24h: 0.0,
              priceChangePercentage24h: change,
              circulatingSupply: 0.0,
              lastUpdated: DateTime.now(),
            ),
          );
          Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
        }
      },
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
                    name,
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                    symbol,
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
                  price,
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

  Widget _buildCryptoCard(
    String symbol,
    String price,
    double change,
    List<double> chartData,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        // Find the crypto from state and navigate to crypto details
        final state = context.read<CryptoCubit>().state;
        if (state is CryptosLoaded) {
          final crypto = state.cryptos.firstWhere(
            (c) => c.symbol.toUpperCase() == symbol,
            orElse: () => CryptoModel(
              id: symbol.toLowerCase(),
              name: symbol,
              symbol: symbol.toLowerCase(),
              image: 'default.png',
              currentPrice: double.tryParse(price.replaceAll(CurrencySymbols.currentSymbol, '').replaceAll(',', '')) ?? 0.0,
              marketCap: 0.0,
              marketCapRank: 0,
              totalVolume: 0.0,
              high24h: 0.0,
              low24h: 0.0,
              priceChange24h: 0.0,
              priceChangePercentage24h: change,
              circulatingSupply: 0.0,
              lastUpdated: DateTime.now(),
            ),
          );
          Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
        }
      },
      child: Container(
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
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

  List<Widget> _buildTopGainers(CryptosLoaded state) {
    final gainers = state.cryptos.where((crypto) => crypto.priceChangePercentage24h > 0).take(3).toList();
    
    if (gainers.isEmpty) {
      return [
        _buildMoverItem('XRP', 'XRP', '${CurrencySymbols.currentSymbol}1.87', 2.13, Icons.currency_exchange),
        _buildMoverItem('SOL', 'Solana', '${CurrencySymbols.currentSymbol}156.78', 1.95, Icons.solar_power),
        _buildMoverItem('MATIC', 'Polygon', '${CurrencySymbols.currentSymbol}0.98', 1.45, Icons.hexagon),
      ];
    }

    return gainers.map((crypto) => _buildMoverItem(
      crypto.symbol,
      crypto.name,
      '${CurrencySymbols.currentSymbol}${crypto.currentPrice.toStringAsFixed(2)}',
      crypto.priceChangePercentage24h,
      Icons.currency_exchange,
    )).toList();
  }

  List<Widget> _buildTopLosers(CryptosLoaded state) {
    final losers = state.cryptos.where((crypto) => crypto.priceChangePercentage24h < 0).take(3).toList();
    
    if (losers.isEmpty) {
      return [
        _buildMoverItem('BNB', 'BNB', '${CurrencySymbols.currentSymbol}481.15', -0.83, Icons.attach_money),
        _buildMoverItem('DOGE', 'Dogecoin', '${CurrencySymbols.currentSymbol}0.15', -1.2, Icons.pets),
        _buildMoverItem('DOT', 'Polkadot', '${CurrencySymbols.currentSymbol}7.25', -1.5, Icons.radio_button_unchecked),
      ];
    }

    return losers.map((crypto) => _buildMoverItem(
      crypto.symbol,
      crypto.name,
      '${CurrencySymbols.currentSymbol}${crypto.currentPrice.toStringAsFixed(2)}',
      crypto.priceChangePercentage24h,
      Icons.currency_exchange,
    )).toList();
  }

  Widget _buildMoverItem(
    String symbol,
    String name,
    String price,
    double change,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        // Create a crypto object and navigate to crypto details
        final crypto = Crypto(
          id: symbol.toLowerCase(),
          name: name,
          symbol: symbol.toLowerCase(),
          image: 'default.png',
          currentPrice: double.tryParse(price.replaceAll(CurrencySymbols.currentSymbol, '').replaceAll(',', '')) ?? 0.0,
          marketCap: 0.0,
          marketCapRank: 0,
          totalVolume: 0.0,
          high24h: 0.0,
          low24h: 0.0,
          priceChange24h: 0.0,
          priceChangePercentage24h: change,
          circulatingSupply: 0.0,
          lastUpdated: DateTime.now(),
        );
        Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
      },
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
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF6C5CE7), size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    name,
                    style: TextStyle(
                  color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    symbol,
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
                  price,
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
                        backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
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
                        backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
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
                        backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
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
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: const Color(0xFF6C5CE7), size: 20.sp),
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
} 