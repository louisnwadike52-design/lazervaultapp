import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';

// ---------------------------------------------------------------------------
// Colors
// ---------------------------------------------------------------------------
const _kBg = Color(0xFF0A0A0A);
const _kCard = Color(0xFF1F1F1F);
const _kAccent = Color.fromARGB(255, 78, 3, 208);
const _kTextSecondary = Color(0xFF9CA3AF);
const _kDivider = Color(0xFF2D2D2D);

// ---------------------------------------------------------------------------
// Educational content data
// ---------------------------------------------------------------------------
class _Lesson {
  final IconData icon;
  final String title;
  final String summary;
  final String detail;
  const _Lesson(this.icon, this.title, this.summary, this.detail);
}

const _cryptoBasics = <_Lesson>[
  _Lesson(
    Icons.currency_bitcoin,
    'What is Bitcoin?',
    'The first decentralised digital currency, created in 2009 by Satoshi Nakamoto.',
    'Bitcoin (BTC) is a peer-to-peer electronic cash system that operates without '
        'a central authority. Transactions are verified by network nodes through '
        'cryptography and recorded on a public ledger called a blockchain. Its '
        'supply is capped at 21 million coins, making it a deflationary asset. '
        'Bitcoin pioneered the concept of trustless digital value transfer and '
        'remains the largest cryptocurrency by market capitalisation.',
  ),
  _Lesson(
    Icons.auto_awesome,
    'What is Ethereum?',
    'A programmable blockchain that enables smart contracts and decentralised apps.',
    'Ethereum (ETH) extends blockchain technology beyond simple transactions by '
        'allowing developers to deploy self-executing smart contracts. These power '
        'decentralised finance (DeFi), NFTs, DAOs and thousands of other applications. '
        'Ethereum transitioned from Proof of Work to Proof of Stake in 2022, '
        'reducing energy consumption by over 99%. Its native token, Ether, is '
        'used to pay gas fees for computation on the network.',
  ),
  _Lesson(
    Icons.account_balance,
    'What is DeFi?',
    'Decentralised Finance recreates traditional banking services on the blockchain.',
    'DeFi protocols let users lend, borrow, trade, and earn interest without '
        'intermediaries like banks. Popular protocols include Aave (lending), '
        'Uniswap (decentralised exchange) and MakerDAO (stablecoin issuance). '
        'DeFi uses smart contracts to automate financial logic, enabling '
        'permissionless access to financial services globally. Risks include '
        'smart-contract vulnerabilities, impermanent loss, and regulatory uncertainty.',
  ),
  _Lesson(
    Icons.link,
    'How does blockchain work?',
    'A distributed, immutable ledger that records transactions across many computers.',
    'A blockchain is a chain of blocks, each containing a batch of validated '
        'transactions. Every block includes a cryptographic hash of the previous '
        'block, creating a tamper-proof chain. Consensus mechanisms (Proof of Work '
        'or Proof of Stake) ensure all participants agree on the state of the '
        'ledger without a central coordinator. This architecture makes double-'
        'spending virtually impossible and provides full transaction transparency.',
  ),
  _Lesson(
    Icons.bar_chart,
    'Understanding market cap',
    'Market capitalisation measures a cryptocurrency\'s total value in circulation.',
    'Market cap is calculated by multiplying the current price by the circulating '
        'supply. It is the primary metric for comparing the relative size of '
        'cryptocurrencies. Large-cap assets (>\$10B) like Bitcoin and Ethereum are '
        'generally considered lower risk, while small-cap assets can offer higher '
        'growth potential but with greater volatility. Fully diluted valuation '
        '(FDV) uses max supply instead, giving a ceiling estimate.',
  ),
  _Lesson(
    Icons.attach_money,
    'What are stablecoins?',
    'Cryptocurrencies pegged to fiat currencies, maintaining a stable value.',
    'Stablecoins like USDT, USDC and DAI are designed to hold a 1:1 value with '
        'the US dollar. They achieve this through fiat reserves (USDT/USDC), '
        'crypto over-collateralisation (DAI) or algorithmic mechanisms. Stablecoins '
        'serve as a bridge between traditional finance and crypto, enabling fast '
        'settlement, DeFi participation and a safe-haven during market volatility '
        'without needing to exit to a bank account.',
  ),
];

const _tradingConcepts = <_Lesson>[
  _Lesson(
    Icons.swap_vert,
    'Market vs Limit Orders',
    'Two fundamental order types for buying and selling assets.',
    'A market order executes immediately at the best available price, prioritising '
        'speed over price certainty. A limit order lets you set a specific price '
        'and only fills when the market reaches it, giving you price control but '
        'no guarantee of execution. Market orders are best for liquid assets when '
        'you need quick fills; limit orders suit precise entry/exit strategies.',
  ),
  _Lesson(
    Icons.candlestick_chart,
    'Reading candlestick charts',
    'Visual representation of price action showing open, high, low and close.',
    'Each candlestick represents a time period. The body shows the open-to-close '
        'range (green if close > open, red otherwise). Wicks extend to the high '
        'and low. Common patterns include doji (indecision), hammer (reversal) '
        'and engulfing (trend change). Combining candlesticks with volume data '
        'helps confirm price movements and identify potential entry/exit points.',
  ),
  _Lesson(
    Icons.receipt_long,
    'Understanding fees',
    'Trading fees, network fees and spreads can significantly impact returns.',
    'Exchanges charge maker/taker fees (typically 0.1%-0.5% per trade). Network '
        'fees (gas on Ethereum, transaction fees on Bitcoin) are paid to validators '
        'for processing on-chain transactions. Spread is the difference between '
        'bid and ask prices. For frequent traders, fee optimisation through limit '
        'orders, fee-tier upgrades and choosing low-fee networks can meaningfully '
        'improve profitability over time.',
  ),
  _Lesson(
    Icons.shield,
    'Risk management basics',
    'Protecting your capital with position sizing, stop-losses and diversification.',
    'Never invest more than you can afford to lose. The 1-2% rule suggests risking '
        'no more than 1-2% of your portfolio on a single trade. Stop-loss orders '
        'automatically sell when price drops to a specified level, limiting '
        'downside. Diversification across asset classes and market caps reduces '
        'concentration risk. Dollar-cost averaging (DCA) smooths out volatility '
        'by investing fixed amounts at regular intervals.',
  ),
];

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------
class LearnEarnScreen extends StatefulWidget {
  const LearnEarnScreen({super.key});

  @override
  State<LearnEarnScreen> createState() => _LearnEarnScreenState();
}

class _LearnEarnScreenState extends State<LearnEarnScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final CryptoGrpcClient _grpcClient = serviceLocator<CryptoGrpcClient>();

  List<CryptoMessage> _topCryptos = [];
  List<CryptoNewsItem> _newsItems = [];
  bool _isLoadingDiscover = true;
  String? _discoverError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1 && _isLoadingDiscover && _discoverError == null) {
        _loadDiscoverData();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDiscoverData() async {
    setState(() {
      _isLoadingDiscover = true;
      _discoverError = null;
    });
    try {
      final results = await Future.wait([
        _grpcClient.getTopCryptos(limit: 10, vsCurrency: 'usd'),
        _grpcClient.getCryptoNews(currencies: ['btc', 'eth', 'sol', 'bnb'], limit: 10),
      ]);
      if (!mounted) return;
      setState(() {
        _topCryptos = (results[0] as GetTopCryptosResponse).cryptos.toList();
        _newsItems = (results[1] as GetCryptoNewsResponse).items.toList();
        _isLoadingDiscover = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _discoverError = 'Unable to load market data. Pull down to retry.';
        _isLoadingDiscover = false;
      });
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildLearnTab(), _buildDiscoverTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Learn & Earn',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: _kAccent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0,
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp),
        labelColor: Colors.white,
        unselectedLabelColor: _kTextSecondary,
        tabs: const [Tab(text: 'Learn'), Tab(text: 'Discover')],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LEARN TAB
  // ---------------------------------------------------------------------------
  Widget _buildLearnTab() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      children: [
        _sectionTitle('Crypto Basics', Icons.school),
        SizedBox(height: 12.h),
        ..._cryptoBasics.map(_buildLessonCard),
        SizedBox(height: 28.h),
        _sectionTitle('Trading Concepts', Icons.trending_up),
        SizedBox(height: 12.h),
        ..._tradingConcepts.map(_buildLessonCard),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: _kAccent, size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonCard(_Lesson lesson) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: _ExpandableLessonCard(lesson: lesson),
    );
  }

  // ---------------------------------------------------------------------------
  // DISCOVER TAB
  // ---------------------------------------------------------------------------
  Widget _buildDiscoverTab() {
    if (_isLoadingDiscover) {
      return const Center(child: CircularProgressIndicator(color: _kAccent));
    }
    if (_discoverError != null) {
      return RefreshIndicator(
        color: _kAccent,
        onRefresh: _loadDiscoverData,
        child: ListView(
          children: [
            SizedBox(height: 120.h),
            Center(
              child: Column(
                children: [
                  Icon(Icons.cloud_off, color: _kTextSecondary, size: 48.sp),
                  SizedBox(height: 12.h),
                  Text(
                    _discoverError!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 14.sp, color: _kTextSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      color: _kAccent,
      onRefresh: _loadDiscoverData,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        children: [
          _sectionTitle('Top Cryptocurrencies', Icons.emoji_events),
          SizedBox(height: 12.h),
          ..._topCryptos.asMap().entries.map((e) => _buildCryptoRow(e.key + 1, e.value)),
          SizedBox(height: 28.h),
          _sectionTitle('Trending News', Icons.newspaper),
          SizedBox(height: 12.h),
          if (_newsItems.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  'No news articles available right now.',
                  style: GoogleFonts.inter(fontSize: 13.sp, color: _kTextSecondary),
                ),
              ),
            )
          else
            ..._newsItems.map(_buildNewsCard),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildCryptoRow(int rank, CryptoMessage crypto) {
    final priceFmt = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final mcapFmt = NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 1);
    final pctChange = crypto.priceChangePercentage24h;
    final isPositive = pctChange >= 0;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _kDivider, width: 0.5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            child: Text(
              '#$rank',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _kTextSecondary,
              ),
            ),
          ),
          if (crypto.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                crypto.image,
                width: 32.w,
                height: 32.w,
                errorBuilder: (_, __, ___) => _placeholderIcon(crypto.symbol),
              ),
            )
          else
            _placeholderIcon(crypto.symbol),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crypto.name,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  '${crypto.symbol.toUpperCase()}  |  MCap ${mcapFmt.format(crypto.marketCap)}',
                  style: GoogleFonts.inter(fontSize: 11.sp, color: _kTextSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                priceFmt.format(crypto.currentPrice),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${isPositive ? '+' : ''}${pctChange.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _placeholderIcon(String symbol) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: _kAccent.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        symbol.substring(0, symbol.length.clamp(0, 2)).toUpperCase(),
        style: GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.w700, color: _kAccent),
      ),
    );
  }

  Widget _buildNewsCard(CryptoNewsItem news) {
    final timeAgo = news.hasPublishedAt() ? _formatTimeAgo(news.publishedAt.toDateTime()) : '';
    final sentiment = news.sentiment.isNotEmpty ? news.sentiment : null;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _kDivider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              if (news.source.isNotEmpty) ...[
                Icon(Icons.language, size: 13.sp, color: _kTextSecondary),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    news.source,
                    style: GoogleFonts.inter(fontSize: 11.sp, color: _kTextSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10.w),
              ],
              if (timeAgo.isNotEmpty) ...[
                Icon(Icons.access_time, size: 13.sp, color: _kTextSecondary),
                SizedBox(width: 4.w),
                Text(timeAgo, style: GoogleFonts.inter(fontSize: 11.sp, color: _kTextSecondary)),
              ],
              const Spacer(),
              if (sentiment != null) _sentimentBadge(sentiment),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sentimentBadge(String sentiment) {
    final lc = sentiment.toLowerCase();
    final Color bg;
    final Color fg;
    if (lc == 'positive' || lc == 'bullish') {
      bg = const Color(0xFF10B981).withValues(alpha: 0.15);
      fg = const Color(0xFF10B981);
    } else if (lc == 'negative' || lc == 'bearish') {
      bg = const Color(0xFFEF4444).withValues(alpha: 0.15);
      fg = const Color(0xFFEF4444);
    } else {
      bg = _kTextSecondary.withValues(alpha: 0.15);
      fg = _kTextSecondary;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6.r)),
      child: Text(
        sentiment[0].toUpperCase() + sentiment.substring(1),
        style: GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(dt);
  }
}

// ---------------------------------------------------------------------------
// Expandable lesson card (stateful for animation)
// ---------------------------------------------------------------------------
class _ExpandableLessonCard extends StatefulWidget {
  final _Lesson lesson;
  const _ExpandableLessonCard({required this.lesson});

  @override
  State<_ExpandableLessonCard> createState() => _ExpandableLessonCardState();
}

class _ExpandableLessonCardState extends State<_ExpandableLessonCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _expanded ? _kAccent.withValues(alpha: 0.5) : _kDivider,
            width: _expanded ? 1 : 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _kAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(lesson.icon, color: _kAccent, size: 18.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        lesson.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(fontSize: 12.sp, color: _kTextSecondary),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(Icons.keyboard_arrow_down, color: _kTextSecondary, size: 20.sp),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  lesson.detail,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.55,
                  ),
                ),
              ),
              crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
