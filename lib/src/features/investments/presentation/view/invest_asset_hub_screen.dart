import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_hub_segment.dart';
import 'package:lazervault/src/features/investments/presentation/navigation/invest_route_args.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import 'package:lazervault/src/features/investments/presentation/widgets/invest_hub_panels.dart';
import 'package:lazervault/src/features/investments/presentation/widgets/invest_market_landing_scroll.dart';
import 'package:lazervault/src/features/investments/presentation/widgets/invest_revolut_segment_pills.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_state.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

/// Per–asset-class hub: Revolut-style pill segments (All · Portfolio · Watchlist · Orders · News).
class InvestAssetHubScreen extends StatefulWidget {
  const InvestAssetHubScreen({super.key});

  @override
  State<InvestAssetHubScreen> createState() => _InvestAssetHubScreenState();
}

class _InvestAssetHubScreenState extends State<InvestAssetHubScreen> {
  late final InvestAssetHubConfig _hub;
  late final List<InvestHubPrimarySegment> _segments;
  int _segmentIndex = 0;
  final TextEditingController _search = TextEditingController();

  String? get _investCollectionId =>
      _hub.collectionId != 'stocks' ? _hub.collectionId : null;

  @override
  void initState() {
    super.initState();
    _hub = InvestAssetHubConfig.resolve(Get.arguments);
    _segments = _hub.hubPrimarySegments;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _syncDataForSegment(_segments[_segmentIndex]);
    });
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: InvestTradingUi.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _openTrade({required String tradeType}) {
    Get.toNamed(
      AppRoutes.stockTradeAmount,
      arguments: {
        'tradeType': tradeType,
        ...InvestRouteArgs.hub(_investCollectionId),
      },
    );
  }

  void _openDetails(Stock stock) {
    Get.toNamed(
      AppRoutes.stockDetails,
      arguments: {
        'stock': stock,
        ...InvestRouteArgs.hub(_investCollectionId),
      },
    );
  }

  void _syncDataForSegment(InvestHubPrimarySegment s) {
    if (!mounted) return;
    final c = context.read<StockCubit>();
    switch (s) {
      case InvestHubPrimarySegment.home:
        break;
      case InvestHubPrimarySegment.assets:
        c.loadStocks(limit: 100);
        break;
      case InvestHubPrimarySegment.portfolio:
        c.loadPortfolio();
        break;
      case InvestHubPrimarySegment.watchlist:
        c.loadWatchlists();
        break;
      case InvestHubPrimarySegment.orders:
        c.loadOrders();
        break;
      case InvestHubPrimarySegment.news:
        c.loadMarketNews();
        break;
      case InvestHubPrimarySegment.programme:
      case InvestHubPrimarySegment.exchange:
        break;
    }
  }

  void _onSegmentChanged(int i) {
    if (i == _segmentIndex) return;
    setState(() => _segmentIndex = i);
    _syncDataForSegment(_segments[i]);
  }

  List<Stock> _filterAndCurate(List<Stock> raw) {
    var list = List<Stock>.from(raw);
    if (_hub.hasCuratedList) {
      final want = _hub.curatedSymbols.map((s) => s.toUpperCase()).toSet();
      list = list.where((s) => want.contains(s.symbol.toUpperCase())).toList();
      if (list.isEmpty) {
        return _hub.curatedSymbols.map((sym) => Stock.navigationStub(sym)).toList();
      }
    }
    final q = _search.text.trim().toLowerCase();
    if (q.isEmpty) return list;
    return list
        .where(
          (s) =>
              s.symbol.toLowerCase().contains(q) ||
              s.name.toLowerCase().contains(q),
        )
        .toList();
  }

  InvestHubPrimarySegment get _current => _segments[_segmentIndex];

  bool get _showBuySellBar =>
      _hub.showTradeQuickActions &&
      _hub.showsInstrumentBrowse &&
      (_current == InvestHubPrimarySegment.assets ||
          _current == InvestHubPrimarySegment.home);

  @override
  Widget build(BuildContext context) {
    final accent = _hub.accentColor;
    final labels = _segments.map(_hub.label).toList();

    return Scaffold(
      backgroundColor: InvestTradingUi.background,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(InvestTradingUi.background, accent, 0.1)!,
              InvestTradingUi.background,
            ],
            stops: const [0.0, 0.42],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(accent),
              SizedBox(height: 6.h),
              InvestRevolutSegmentPills(
                labels: labels,
                selectedIndex: _segmentIndex,
                onChanged: _onSegmentChanged,
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: IndexedStack(
                  index: _segmentIndex,
                  alignment: Alignment.topCenter,
                  children: _segments.map(_panelForSegment).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _showBuySellBar ? _buildBuySellBar() : null,
    );
  }

  Widget _panelForSegment(InvestHubPrimarySegment s) {
    final accent = _hub.accentColor;
    return switch (s) {
      InvestHubPrimarySegment.home => InvestMarketLandingScroll(
          hub: _hub,
          investCollectionId: _investCollectionId,
          filterStocks: _filterAndCurate,
          onOpenTrade: (t) => _openTrade(tradeType: t),
          onJumpToSegment: (seg) {
            final i = _segments.indexOf(seg);
            if (i != -1) _onSegmentChanged(i);
          },
        ),
      InvestHubPrimarySegment.assets => _buildBrowse(accent),
      InvestHubPrimarySegment.programme => _buildProgrammeScroll(accent),
      InvestHubPrimarySegment.exchange => _buildExchangeScroll(accent),
      InvestHubPrimarySegment.portfolio => InvestHubPanels.portfolio(
          investCollectionId: _investCollectionId,
          accent: accent,
        ),
      InvestHubPrimarySegment.watchlist => InvestHubPanels.watchlist(
          investCollectionId: _investCollectionId,
          accent: accent,
        ),
      InvestHubPrimarySegment.orders => InvestHubPanels.orders(
          investCollectionId: _investCollectionId,
          accent: accent,
        ),
      InvestHubPrimarySegment.news => InvestHubPanels.news(accent: accent),
    };
  }

  Widget _buildAppBar(Color accent) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: InvestTradingUi.textPrimary,
              size: 20.sp,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _hub.appBarScrolledTitle,
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: InvestTradingUi.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  _hub.heroSubtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: InvestTradingUi.labelMuted(),
                ),
              ],
            ),
          ),
          ServiceVoiceButton(serviceName: _hub.voiceServiceName),
          SizedBox(width: 4.w),
          MicroserviceChatIcon(
            serviceName: _hub.microserviceChatServiceName,
            sourceContext: 'investments',
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: accent,
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeScroll(Color accent) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      child: _buildFxCard(accent),
    );
  }

  Widget _buildProgrammeScroll(Color accent) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      child: _buildProgrammeCard(accent),
    );
  }

  Widget _buildFxCard(Color accent) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: InvestTradingUi.statementCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _hub.heroTitle,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _hub.heroSubtitle,
            style: InvestTradingUi.labelMuted().copyWith(height: 1.4),
          ),
          SizedBox(height: 20.h),
          FilledButton(
            onPressed: () => Get.toNamed(
              AppRoutes.exchangeHome,
              arguments: const {
                'fromCurrency': 'NGN',
                'toCurrency': 'USD',
              },
            ),
            style: FilledButton.styleFrom(
              backgroundColor: accent,
              foregroundColor: Colors.black87,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              'Open exchange',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgrammeCard(Color accent) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: InvestTradingUi.statementCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _hub.heroEyebrow.toUpperCase(),
            style: InvestTradingUi.eyebrow(accent),
          ),
          SizedBox(height: 8.h),
          Text(
            _hub.heroTitle,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _hub.heroSubtitle,
            style: InvestTradingUi.labelMuted().copyWith(height: 1.45),
          ),
          SizedBox(height: 12.h),
          Text(
            'This programme is not the same as US stock search. Availability and rates come from the connected provider when live in-app.',
            style: InvestTradingUi.labelMuted().copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowse(Color accent) {
    return BlocConsumer<StockCubit, StockState>(
      listener: (context, state) {
        if (state is StockError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: InvestTradingUi.sell,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final loading = state is StockLoading;
        List<Stock> stocks = [];
        if (state is StockLoaded) {
          stocks = _filterAndCurate(state.stocks);
        }

        return RefreshIndicator(
          color: accent,
          backgroundColor: InvestTradingUi.surfaceElevated,
          onRefresh: () => context.read<StockCubit>().loadStocks(limit: 100),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _search,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.inter(
                          color: InvestTradingUi.textPrimary,
                          fontSize: 15.sp,
                        ),
                        decoration: InvestTradingUi.tradingInputDecoration(
                          hintText: 'Search ${_hub.appBarScrolledTitle.toLowerCase()}',
                          accentColor: accent,
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: InvestTradingUi.textSecondary,
                            size: 22.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _hub.hasCuratedList
                            ? (_hub.curatedSectionTitle ?? 'Suggested')
                            : 'All instruments',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: InvestTradingUi.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
              if (loading && stocks.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: accent,
                      strokeWidth: 2,
                    ),
                  ),
                )
              else if (!loading && stocks.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No matches',
                      style: InvestTradingUi.labelMuted(),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final stock = stocks[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: _InstrumentTile(
                            stock: stock,
                            accent: accent,
                            onTap: () => _openDetails(stock),
                          ),
                        );
                      },
                      childCount: stocks.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBuySellBar() {
    return Container(
      decoration: InvestTradingUi.bottomBarDecoration,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _openTrade(tradeType: 'sell'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: InvestTradingUi.sell,
                    side: const BorderSide(color: InvestTradingUi.sell, width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Sell',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: FilledButton(
                  onPressed: () => _openTrade(tradeType: 'buy'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Buy',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstrumentTile extends StatelessWidget {
  const _InstrumentTile({
    required this.stock,
    required this.accent,
    required this.onTap,
  });

  final Stock stock;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final symbol = stock.symbol;
    final name = stock.name;
    final price = stock.currentPrice;
    final change = stock.changePercent;
    final currency = stock.currency.isNotEmpty ? stock.currency : 'USD';
    final isPositive = change >= 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: InvestTradingUi.cardDecoration(
            color: const Color(0xFF1C1C1E),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Center(
                  child: Text(
                    symbol
                        .substring(0, math.min(3, symbol.length))
                        .toUpperCase(),
                    style: GoogleFonts.inter(
                      color: accent,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
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
                      symbol.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: InvestTradingUi.textPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: InvestTradingUi.labelMuted(),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(
                      price.toDouble(),
                      currency,
                    ),
                    style: GoogleFonts.inter(
                      color: InvestTradingUi.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: isPositive ? InvestTradingUi.buy : InvestTradingUi.sell,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
