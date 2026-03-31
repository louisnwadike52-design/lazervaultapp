import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_hub_segment.dart';
import 'package:lazervault/src/features/investments/presentation/navigation/invest_route_args.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';

/// Lean **Home** tab: discovery (movers, featured, pulse). Portfolio, watchlist,
/// orders, and news live under the top pills — use [onJumpToSegment] to switch there.
class InvestMarketLandingScroll extends StatefulWidget {
  const InvestMarketLandingScroll({
    super.key,
    required this.hub,
    required this.investCollectionId,
    required this.filterStocks,
    required this.onOpenTrade,
    required this.onJumpToSegment,
  });

  final InvestAssetHubConfig hub;
  final String? investCollectionId;
  final List<Stock> Function(List<Stock> raw) filterStocks;
  final void Function(String tradeType) onOpenTrade;
  final void Function(InvestHubPrimarySegment segment) onJumpToSegment;

  @override
  State<InvestMarketLandingScroll> createState() =>
      _InvestMarketLandingScrollState();
}

class _InvestMarketLandingScrollState extends State<InvestMarketLandingScroll> {
  bool _loading = true;
  String? _error;
  List<Stock> _stocks = [];

  Map<String, dynamic> get _hubArgs =>
      InvestRouteArgs.hub(widget.investCollectionId);

  List<Stock> get _filtered => widget.filterStocks(_stocks);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final repo = context.read<StockCubit>().repository;

    try {
      final sr = await repo.getStocks(limit: 100);
      if (!mounted) return;
      final s = sr.fold((_) => <Stock>[], (v) => v);
      setState(() {
        _stocks = s;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _toDetails(Stock stock) {
    Get.toNamed(
      AppRoutes.stockDetails,
      arguments: {'stock': stock, ..._hubArgs},
    );
  }

  void _toChart(Stock stock) {
    Get.toNamed(AppRoutes.stockChartDetails, arguments: stock);
  }

  List<FlSpot> _normalizedSpots(List<double> vals) {
    if (vals.isEmpty) {
      return const [FlSpot(0, 0.5), FlSpot(1, 0.5)];
    }
    var minV = vals.first;
    var maxV = vals.first;
    for (final v in vals) {
      if (v < minV) minV = v;
      if (v > maxV) maxV = v;
    }
    if (maxV == minV) {
      return [
        for (var i = 0; i < vals.length; i++) FlSpot(i.toDouble(), 0.5),
      ];
    }
    return [
      for (var i = 0; i < vals.length; i++)
        FlSpot(
          i.toDouble(),
          (vals[i] - minV) / (maxV - minV),
        ),
    ];
  }

  List<double> _sparkline(Stock s) {
    if (s.priceHistory.isNotEmpty) {
      final pts = s.priceHistory.length > 14
          ? s.priceHistory.sublist(s.priceHistory.length - 14)
          : s.priceHistory;
      return pts.map((e) => e.price).toList();
    }
    final base = s.currentPrice > 0 ? s.currentPrice : 100.0;
    final n = 7;
    final step = base * (s.changePercent / 100).clamp(-0.15, 0.15) / n;
    return List.generate(n, (i) => base + step * (i - n / 2));
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.hub.accentColor;

    if (_loading) {
      return Center(child: CircularProgressIndicator(color: accent));
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Could not load market data',
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: InvestTradingUi.labelMuted(),
              ),
              SizedBox(height: 16.h),
              FilledButton(
                onPressed: _load,
                style: FilledButton.styleFrom(backgroundColor: accent),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: accent,
      onRefresh: _load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.only(bottom: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _homeHero(accent),
            _shortcutsStrip(accent),
            SizedBox(height: 8.h),
            _quickActionsBuySell(accent),
            _riskBanner(),
            _marketPulse(accent),
            _featuredRow(accent),
            _moversSection(accent),
            _footer(),
          ],
        ),
      ),
    );
  }

  /// Headline copy for Home only (lists live under pills).
  Widget _homeHero(Color accent) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hub.heroEyebrow.toUpperCase(),
            style: InvestTradingUi.eyebrow(accent),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.hub.heroTitle,
            style: GoogleFonts.inter(
              color: InvestTradingUi.textPrimary,
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            widget.hub.heroSubtitle,
            style: InvestTradingUi.labelMuted(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Same destinations as top pills — jump without duplicating full UIs here.
  Widget _shortcutsStrip(Color accent) {
    final shortcuts = <({InvestHubPrimarySegment seg, IconData icon, String label})>[
      (
        seg: InvestHubPrimarySegment.portfolio,
        icon: Icons.pie_chart_outline_rounded,
        label: 'Portfolio',
      ),
      (
        seg: InvestHubPrimarySegment.watchlist,
        icon: Icons.star_outline_rounded,
        label: 'Watchlist',
      ),
      (
        seg: InvestHubPrimarySegment.orders,
        icon: Icons.receipt_long_outlined,
        label: 'Orders',
      ),
      (
        seg: InvestHubPrimarySegment.news,
        icon: Icons.newspaper_rounded,
        label: 'News',
      ),
      (
        seg: InvestHubPrimarySegment.assets,
        icon: Icons.grid_view_rounded,
        label: 'All',
      ),
    ];

    return SizedBox(
      height: 92.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: shortcuts.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, i) {
          final it = shortcuts[i];
          return _shortcutPill(
            accent: accent,
            icon: it.icon,
            label: it.label,
            onTap: () => widget.onJumpToSegment(it.seg),
          );
        },
      ),
    );
  }

  Widget _shortcutPill({
    required Color accent,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Container(
          width: 76.w,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: InvestTradingUi.surfaceElevated,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent, size: 22.sp),
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textPrimary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActionsBuySell(Color accent) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _qaBtn(
              'Buy',
              Icons.add_circle_outline,
              InvestTradingUi.buy,
              () => widget.onOpenTrade('buy'),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _qaBtn(
              'Sell',
              Icons.remove_circle_outline,
              InvestTradingUi.sell,
              () => widget.onOpenTrade('sell'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qaBtn(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: SizedBox(
          height: 52.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22.sp),
              SizedBox(width: 10.w),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _riskBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: InvestTradingUi.surfaceElevated.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Text(
        "Don't invest unless you're prepared to lose capital. "
        'Past performance does not guarantee future results.',
        style: GoogleFonts.inter(
          color: InvestTradingUi.textSecondary,
          fontSize: 11.sp,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _marketPulse(Color accent) {
    final list = _filtered;
    final adv = list.where((s) => s.changePercent > 0).length;
    final dec = list.where((s) => s.changePercent < 0).length;
    final mcap = list.fold<double>(0, (a, s) => a + s.marketCap);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            InvestTradingUi.surfaceElevated,
            Color.lerp(InvestTradingUi.surfaceElevated, accent, 0.12)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pulse',
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textPrimary,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                onPressed: () =>
                    widget.onJumpToSegment(InvestHubPrimarySegment.assets),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _pulseCell('Universe', '${list.length}', accent),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _pulseCell('Up', '$adv', InvestTradingUi.buy),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _pulseCell('Down', '$dec', InvestTradingUi.sell),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _pulseCell(
                  'Cap',
                  mcap > 0 ? _shortNum(mcap) : '—',
                  accent,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Ideas in this hub',
            style: GoogleFonts.inter(
              color: InvestTradingUi.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 10.h),
          if (list.isEmpty)
            Text(
              'No instruments yet — open All.',
              style: InvestTradingUi.labelMuted(),
            )
          else
            for (int i = 0; i < (list.length > 3 ? 3 : list.length); i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < 2 ? 8.h : 0),
                child: _trendRow(list[i], accent),
              ),
        ],
      ),
    );
  }

  Widget _pulseCell(String label, String value, Color tone) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: InvestTradingUi.textPrimary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: InvestTradingUi.textSecondary,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _shortNum(double v) {
    if (v >= 1e12) return '${(v / 1e12).toStringAsFixed(2)}T';
    if (v >= 1e9) return '${(v / 1e9).toStringAsFixed(1)}B';
    if (v >= 1e6) return '${(v / 1e6).toStringAsFixed(1)}M';
    if (v >= 1e3) return '${(v / 1e3).toStringAsFixed(1)}K';
    return v.toStringAsFixed(0);
  }

  Widget _trendRow(Stock s, Color accent) {
    final sym = s.symbol.toUpperCase();
    return Material(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: () => _toDetails(s),
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              Icon(Icons.bolt_rounded, color: accent, size: 22.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: InvestTradingUi.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(sym, style: InvestTradingUi.labelMuted()),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => _toChart(s),
                child: Text(
                  'Chart',
                  style: TextStyle(color: accent, fontSize: 12.sp),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(
                      s.currentPrice,
                      s.currency,
                    ),
                    style: GoogleFonts.inter(
                      color: InvestTradingUi.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '${s.changePercent >= 0 ? '+' : ''}${s.changePercent.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: s.changePercent >= 0
                          ? InvestTradingUi.buy
                          : InvestTradingUi.sell,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
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

  Widget _featuredRow(Color accent) {
    final a = _filtered.isNotEmpty ? _filtered[0] : null;
    final b = _filtered.length > 1 ? _filtered[1] : null;
    if (a == null && b == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (a != null) Expanded(child: _bigCard(a, accent)),
          if (a != null && b != null) SizedBox(width: 8.w),
          if (b != null) Expanded(child: _bigCard(b, accent)),
        ],
      ),
    );
  }

  Widget _bigCard(Stock s, Color color) {
    final vals = _sparkline(s);
    return Material(
      color: InvestTradingUi.surfaceElevated,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        onTap: () => _toDetails(s),
        borderRadius: BorderRadius.circular(18.r),
        child: Padding(
          padding: EdgeInsets.all(14.w),
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
                    child: Icon(Icons.show_chart_rounded,
                        color: color, size: 18.sp),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    s.symbol,
                    style: GoogleFonts.inter(
                      color: InvestTradingUi.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                CurrencySymbols.formatAmountWithCurrency(
                  s.currentPrice,
                  s.currency,
                ),
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                ),
              ),
              Row(
                children: [
                  Icon(
                    s.changePercent >= 0
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: s.changePercent >= 0
                        ? InvestTradingUi.buy
                        : InvestTradingUi.sell,
                    size: 14.sp,
                  ),
                  Text(
                    '${s.changePercent.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: s.changePercent >= 0
                          ? InvestTradingUi.buy
                          : InvestTradingUi.sell,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _toChart(s),
                    child: Text('Full chart', style: TextStyle(color: color)),
                  ),
                ],
              ),
              SizedBox(
                height: 52.h,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _normalizedSpots(vals),
                        isCurved: true,
                        color: color,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moversSection(Color accent) {
    final gainers = [..._filtered]
        .where((s) => s.changePercent > 0)
        .toList()
      ..sort((a, b) => b.changePercent.compareTo(a.changePercent));
    final losers = [..._filtered]
        .where((s) => s.changePercent < 0)
        .toList()
      ..sort((a, b) => a.changePercent.compareTo(b.changePercent));

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Movers',
            style: GoogleFonts.inter(
              color: InvestTradingUi.textPrimary,
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10.h),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: InvestTradingUi.textPrimary,
                  unselectedLabelColor: InvestTradingUi.textSecondary,
                  indicatorColor: accent,
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                  tabs: const [
                    Tab(text: 'Gainers'),
                    Tab(text: 'Losers'),
                  ],
                ),
                SizedBox(
                  height: 200.h,
                  child: TabBarView(
                    children: [
                      _moverList(gainers.take(5).toList(), accent),
                      _moverList(losers.take(5).toList(), accent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moverList(List<Stock> list, Color accent) {
    if (list.isEmpty) {
      return Center(
        child: Text('No data', style: InvestTradingUi.labelMuted()),
      );
    }
    return ListView(
      padding: EdgeInsets.only(top: 10.h),
      children: [
        for (final s in list)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Material(
              color: InvestTradingUi.surfaceElevated,
              borderRadius: BorderRadius.circular(14.r),
              child: ListTile(
                onTap: () => _toDetails(s),
                title: Text(
                  s.symbol,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    color: InvestTradingUi.textPrimary,
                  ),
                ),
                subtitle: Text(
                  s.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: InvestTradingUi.labelMuted(),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${s.changePercent >= 0 ? '+' : ''}${s.changePercent.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: s.changePercent >= 0
                            ? InvestTradingUi.buy
                            : InvestTradingUi.sell,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _toChart(s),
                      child: Text('Chart', style: TextStyle(color: accent)),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _footer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
      child: Text(
        'Details, indicators, and news: open a symbol or use the tabs above.',
        style: GoogleFonts.inter(
          color: InvestTradingUi.textSecondary,
          fontSize: 11.sp,
          height: 1.35,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
