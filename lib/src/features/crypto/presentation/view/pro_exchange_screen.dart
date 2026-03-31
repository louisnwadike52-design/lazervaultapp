import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Transition;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';

const _bg = Color(0xFF0A0A0A);
const _card = Color(0xFF1F1F1F);
const _accent = Color.fromARGB(255, 78, 3, 208);
const _green = Color(0xFF10B981);
const _red = Color(0xFFEF4444);
const _txt = Colors.white;
const _txt2 = Color(0xFF9CA3AF);
const _div = Color(0xFF2D2D2D);

const _markets = {'btcngn': 'BTC/NGN', 'ethngn': 'ETH/NGN', 'usdtngn': 'USDT/NGN', 'solngn': 'SOL/NGN', 'xrpngn': 'XRP/NGN'};
const _mktId = {'btcngn': 'bitcoin', 'ethngn': 'ethereum', 'usdtngn': 'tether', 'solngn': 'solana', 'xrpngn': 'ripple'};
const _tfDays = {'1H': 1, '4H': 1, '1D': 1, '1W': 7, '1M': 30};

TextStyle _inter(double sz, {FontWeight w = FontWeight.w400, Color c = _txt}) =>
    GoogleFonts.inter(fontSize: sz, fontWeight: w, color: c);

class ProExchangeScreen extends StatefulWidget {
  const ProExchangeScreen({super.key});
  @override
  State<ProExchangeScreen> createState() => _ProExchangeScreenState();
}

class _ProExchangeScreenState extends State<ProExchangeScreen> with TickerProviderStateMixin {
  late final TabController _tab;
  late final CryptoGrpcClient _client;
  String _market = 'btcngn';
  String _tf = '1D';
  List<OHLCVPoint> _ohlcv = [];
  GetOrderBookResponse? _book;
  List<TradeEntry> _trades = [];
  bool _cLoad = true, _bLoad = true, _tLoad = true;
  String? _cErr, _bErr, _tErr;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
    _client = serviceLocator<CryptoGrpcClient>();
    _loadAll();
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  Future<void> _loadAll() => Future.wait([_loadChart(), _loadBook(), _loadTrades()]);

  Future<void> _loadChart() async {
    setState(() { _cLoad = true; _cErr = null; });
    try {
      final r = await _client.getOHLCV(cryptoId: _mktId[_market] ?? 'bitcoin', vsCurrency: 'ngn', days: _tfDays[_tf] ?? 1);
      if (!mounted) return;
      setState(() { _ohlcv = r.points.toList(); _cLoad = false; });
    } catch (_) { if (mounted) setState(() { _cErr = 'Failed to load chart'; _cLoad = false; }); }
  }

  Future<void> _loadBook() async {
    setState(() { _bLoad = true; _bErr = null; });
    try {
      final r = await _client.getOrderBook(_market);
      if (!mounted) return;
      setState(() { _book = r; _bLoad = false; });
    } catch (_) { if (mounted) setState(() { _bErr = 'Failed to load order book'; _bLoad = false; }); }
  }

  Future<void> _loadTrades() async {
    setState(() { _tLoad = true; _tErr = null; });
    try {
      final r = await _client.getRecentTrades(_market);
      if (!mounted) return;
      setState(() { _trades = r.trades.toList(); _tLoad = false; });
    } catch (_) { if (mounted) setState(() { _tErr = 'Failed to load trades'; _tLoad = false; }); }
  }

  void _setMarket(String? m) { if (m != null && m != _market) { setState(() => _market = m); _loadAll(); } }
  void _setTf(String t) { if (t != _tf) { setState(() => _tf = t); _loadChart(); } }

  String _fmtPrice(double v) => v >= 1e6 ? '${(v / 1e6).toStringAsFixed(2)}M' : v >= 1e3 ? '${(v / 1e3).toStringAsFixed(1)}K' : v.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(child: Column(children: [
        _header(),
        Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _div))),
          child: TabBar(
            controller: _tab, indicatorColor: _accent, indicatorWeight: 2,
            labelColor: _txt, unselectedLabelColor: _txt2,
            labelStyle: _inter(14.sp, w: FontWeight.w600), unselectedLabelStyle: _inter(14.sp),
            tabs: const [Tab(text: 'Chart'), Tab(text: 'Order Book'), Tab(text: 'Trades')],
          ),
        ),
        Expanded(child: TabBarView(controller: _tab, children: [_chartTab(), _bookTab(), _tradesTab()])),
      ])),
    );
  }

  Widget _header() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    child: Row(children: [
      GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(10.r)),
          child: Icon(Icons.arrow_back, color: _txt, size: 20.sp),
        ),
      ),
      SizedBox(width: 12.w),
      Text('Pro Exchange', style: _inter(20.sp, w: FontWeight.bold)),
      const Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(8.r), border: Border.all(color: _div)),
        child: DropdownButtonHideUnderline(child: DropdownButton<String>(
          value: _market, dropdownColor: _card,
          icon: Icon(Icons.keyboard_arrow_down, color: _accent, size: 18.sp),
          style: _inter(13.sp, w: FontWeight.w600),
          items: _markets.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
          onChanged: _setMarket,
        )),
      ),
    ]),
  );

  // -- Chart Tab --
  Widget _chartTab() => SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _priceHeader(),
      SizedBox(height: 12.h),
      _tfPills(),
      SizedBox(height: 16.h),
      _cLoad ? _Shimmer(h: 260.h) : _cErr != null ? _Err(_cErr!, _loadChart) : _candleChart(),
      SizedBox(height: 8.h),
      _cLoad ? _Shimmer(h: 60.h) : _cErr == null ? _volChart() : const SizedBox.shrink(),
    ]),
  );

  Widget _priceHeader() {
    if (_ohlcv.isEmpty) return _Shimmer(h: 56.h);
    final last = _ohlcv.last, first = _ohlcv.first;
    final chg = first.open > 0 ? ((last.close - first.open) / first.open) * 100 : 0.0;
    final up = chg >= 0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('NGN ${NumberFormat('#,##0.00').format(last.close)}', style: _inter(26.sp, w: FontWeight.bold)),
      SizedBox(height: 4.h),
      Row(children: [
        Icon(up ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: up ? _green : _red, size: 20.sp),
        Text('${up ? '+' : ''}${chg.toStringAsFixed(2)}%', style: _inter(14.sp, w: FontWeight.w600, c: up ? _green : _red)),
        SizedBox(width: 8.w),
        Text('24h', style: _inter(12.sp, c: _txt2)),
      ]),
    ]);
  }

  Widget _tfPills() => Row(
    children: _tfDays.keys.map((t) {
      final sel = t == _tf;
      return Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: GestureDetector(
          onTap: () => _setTf(t),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: sel ? _accent : _card,
              borderRadius: BorderRadius.circular(20.r),
              border: sel ? null : Border.all(color: _div),
            ),
            child: Text(t, style: _inter(12.sp, w: FontWeight.w600, c: sel ? Colors.white : _txt2)),
          ),
        ),
      );
    }).toList(),
  );

  Widget _candleChart() {
    if (_ohlcv.isEmpty) return Center(child: Text('No chart data', style: _inter(14.sp, c: _txt2)));
    double minY = double.infinity, maxY = double.negativeInfinity;
    final bars = <BarChartGroupData>[];
    for (var i = 0; i < _ohlcv.length; i++) {
      final p = _ohlcv[i]; final bull = p.close >= p.open;
      minY = math.min(minY, p.low); maxY = math.max(maxY, p.high);
      bars.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(fromY: p.low, toY: p.high, width: 1.5.w,
          color: (bull ? _green : _red).withValues(alpha: 0.4),
          rodStackItems: [BarChartRodStackItem(math.min(p.open, p.close), math.max(p.open, p.close), bull ? _green : _red)]),
      ]));
    }
    final pad = (maxY - minY) * 0.05;
    return Container(
      height: 260.h, padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12.r)),
      child: BarChart(BarChartData(
        alignment: BarChartAlignment.spaceEvenly, minY: minY - pad, maxY: maxY + pad,
        barGroups: bars,
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: (maxY - minY) / 4,
          getDrawingHorizontalLine: (_) => FlLine(color: _div.withValues(alpha: 0.4), strokeWidth: 0.5)),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 55.w,
            getTitlesWidget: (v, m) => v == m.max || v == m.min ? const SizedBox.shrink()
              : Padding(padding: EdgeInsets.only(left: 4.w), child: Text(_fmtPrice(v), style: _inter(9.sp, c: _txt2))))),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => _card, tooltipPadding: EdgeInsets.all(6.w),
          getTooltipItem: (g, _, __, ___) {
            if (g.x >= _ohlcv.length) return null;
            final p = _ohlcv[g.x];
            return BarTooltipItem('O ${_fmtPrice(p.open)}\nH ${_fmtPrice(p.high)}\nL ${_fmtPrice(p.low)}\nC ${_fmtPrice(p.close)}',
              _inter(10.sp));
          },
        )),
      )),
    );
  }

  Widget _volChart() {
    if (_ohlcv.isEmpty) return const SizedBox.shrink();
    double mx = 0; for (final p in _ohlcv) { if (p.volume > mx) mx = p.volume; }
    if (mx == 0) mx = 1;
    return Container(
      height: 60.h, padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12.r)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: _ohlcv.map((p) {
        final bull = p.close >= p.open;
        return Expanded(child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.5.w),
          height: ((p.volume / mx) * 44.h).clamp(2.h, 44.h),
          decoration: BoxDecoration(color: (bull ? _green : _red).withValues(alpha: 0.5), borderRadius: BorderRadius.circular(1.r)),
        ));
      }).toList()),
    );
  }

  // -- Order Book Tab --
  Widget _bookTab() {
    if (_bLoad) return _shimmerList(12);
    if (_bErr != null) return _Err(_bErr!, _loadBook);
    final asks = _book?.asks.toList() ?? [], bids = _book?.bids.toList() ?? [];
    if (asks.isEmpty && bids.isEmpty) return Center(child: Text('Order book is empty', style: _inter(14.sp, c: _txt2)));
    double aCum = 0, bCum = 0;
    for (final e in asks) aCum += double.tryParse(e.volume) ?? 0;
    for (final e in bids) bCum += double.tryParse(e.volume) ?? 0;
    final bestA = asks.isNotEmpty ? double.tryParse(asks.first.price) ?? 0 : 0.0;
    final bestB = bids.isNotEmpty ? double.tryParse(bids.first.price) ?? 0 : 0.0;
    return Column(children: [
      _bookHeader(),
      Expanded(child: ListView.builder(
        reverse: true, padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: math.min(asks.length, 15),
        itemBuilder: (_, i) { double c = 0; for (var j = 0; j <= i; j++) c += double.tryParse(asks[j].volume) ?? 0;
          return _BookRow(e: asks[i], color: _red, fill: aCum > 0 ? c / aCum : 0); },
      )),
      Container(width: double.infinity, padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w), color: _card,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Spread: ', style: _inter(12.sp, c: _txt2)),
          Text(NumberFormat('#,##0.00').format(bestA - bestB), style: _inter(12.sp, w: FontWeight.w600, c: _accent)),
        ])),
      Expanded(child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: math.min(bids.length, 15),
        itemBuilder: (_, i) { double c = 0; for (var j = 0; j <= i; j++) c += double.tryParse(bids[j].volume) ?? 0;
          return _BookRow(e: bids[i], color: _green, fill: bCum > 0 ? c / bCum : 0); },
      )),
    ]);
  }

  Widget _bookHeader() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(children: [
      Expanded(child: Text('Price (NGN)', style: _inter(11.sp, c: _txt2))),
      Expanded(child: Text('Volume', textAlign: TextAlign.center, style: _inter(11.sp, c: _txt2))),
      Expanded(child: Text('Total', textAlign: TextAlign.right, style: _inter(11.sp, c: _txt2))),
    ]),
  );

  // -- Trades Tab --
  Widget _tradesTab() {
    if (_tLoad) return _shimmerList(15);
    if (_tErr != null) return _Err(_tErr!, _loadTrades);
    if (_trades.isEmpty) return Center(child: Text('No recent trades', style: _inter(14.sp, c: _txt2)));
    return Column(children: [
      Padding(padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), child: Row(children: [
        Expanded(flex: 2, child: Text('Time', style: _inter(11.sp, c: _txt2))),
        Expanded(flex: 3, child: Text('Price (NGN)', textAlign: TextAlign.center, style: _inter(11.sp, c: _txt2))),
        Expanded(flex: 2, child: Text('Amount', textAlign: TextAlign.right, style: _inter(11.sp, c: _txt2))),
        Expanded(flex: 1, child: Text('Side', textAlign: TextAlign.right, style: _inter(11.sp, c: _txt2))),
      ])),
      const Divider(color: _div, height: 1),
      Expanded(child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: _trades.length,
        itemBuilder: (_, i) => _tradeRow(_trades[i]),
      )),
    ]);
  }

  Widget _tradeRow(TradeEntry t) {
    final buy = t.side.toLowerCase() == 'buy'; final c = buy ? _green : _red;
    final p = double.tryParse(t.price) ?? 0; final v = double.tryParse(t.volume) ?? 0;
    String time = '--:--';
    if (t.hasCreatedAt()) time = DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(t.createdAt.seconds.toInt() * 1000));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _div, width: 0.5))),
      child: Row(children: [
        Expanded(flex: 2, child: Text(time, style: _inter(11.sp, c: _txt2))),
        Expanded(flex: 3, child: Text(NumberFormat('#,##0.00').format(p), textAlign: TextAlign.center, style: _inter(12.sp, w: FontWeight.w500, c: c))),
        Expanded(flex: 2, child: Text(v.toStringAsFixed(6), textAlign: TextAlign.right, style: _inter(11.sp))),
        Expanded(flex: 1, child: Text(buy ? 'BUY' : 'SELL', textAlign: TextAlign.right, style: _inter(10.sp, w: FontWeight.w700, c: c))),
      ]),
    );
  }

  Widget _shimmerList(int n) => ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h), itemCount: n,
    itemBuilder: (_, i) => _ShimmerBar(delay: i * 60),
  );
}

// ---------------------------------------------------------------------------
// Small reusable widgets
// ---------------------------------------------------------------------------

class _BookRow extends StatelessWidget {
  final OrderBookEntry e; final Color color; final double fill;
  const _BookRow({required this.e, required this.color, required this.fill});
  @override
  Widget build(BuildContext context) {
    final p = double.tryParse(e.price) ?? 0; final v = double.tryParse(e.volume) ?? 0;
    return SizedBox(height: 28.h, child: Stack(children: [
      Align(alignment: Alignment.centerRight, child: FractionallySizedBox(widthFactor: fill.clamp(0, 1),
        child: Container(decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(2.r))))),
      Padding(padding: EdgeInsets.symmetric(horizontal: 4.w), child: Row(children: [
        Expanded(child: Text(NumberFormat('#,##0.00').format(p), style: _inter(12.sp, w: FontWeight.w500, c: color))),
        Expanded(child: Text(v.toStringAsFixed(6), textAlign: TextAlign.center, style: _inter(11.sp))),
        Expanded(child: Text(NumberFormat('#,##0.00').format(p * v), textAlign: TextAlign.right, style: _inter(11.sp, c: _txt2))),
      ])),
    ]));
  }
}

class _Err extends StatelessWidget {
  final String msg; final VoidCallback retry;
  const _Err(this.msg, this.retry);
  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: EdgeInsets.all(32.w), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.error_outline, color: _red, size: 40.sp), SizedBox(height: 12.h),
      Text(msg, style: _inter(14.sp, c: _txt2)), SizedBox(height: 16.h),
      GestureDetector(onTap: retry, child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(8.r)),
        child: Text('Retry', style: _inter(14.sp, w: FontWeight.w600)),
      )),
    ]),
  ));
}

// Shimmer placeholder block
class _Shimmer extends StatefulWidget {
  final double h;
  const _Shimmer({required this.h});
  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)..repeat(reverse: true);
    _a = Tween<double>(begin: 0.3, end: 0.7).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }
  @override
  void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: _a,
    builder: (_, __) => Container(height: widget.h, decoration: BoxDecoration(
      color: _card.withValues(alpha: _a.value), borderRadius: BorderRadius.circular(12.r))));
}

// Shimmer row for lists
class _ShimmerBar extends StatefulWidget {
  final int delay;
  const _ShimmerBar({this.delay = 0});
  @override
  State<_ShimmerBar> createState() => _ShimmerBarState();
}

class _ShimmerBarState extends State<_ShimmerBar> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _a = Tween<double>(begin: 0.3, end: 0.7).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () { if (mounted) _c.repeat(reverse: true); });
  }
  @override
  void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: _a,
    builder: (_, __) => Container(height: 28.h, margin: EdgeInsets.only(bottom: 4.h),
      decoration: BoxDecoration(color: _card.withValues(alpha: _a.value), borderRadius: BorderRadius.circular(4.r))));
}
