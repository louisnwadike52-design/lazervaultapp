import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------
const _kBg = Color(0xFF0A0A0A);
const _kCard = Color(0xFF1F1F1F);
const _kAccent = Color.fromARGB(255, 78, 3, 208);
const _kTextPrimary = Colors.white;
const _kTextSecondary = Color(0xFF9CA3AF);
const _kDivider = Color(0xFF2D2D2D);
const _kGreen = Color(0xFF10B981);
const _kRed = Color(0xFFEF4444);
const _kYellow = Color(0xFFFBBF24);

class SmartTradingScreen extends StatefulWidget {
  const SmartTradingScreen({super.key});

  @override
  State<SmartTradingScreen> createState() => _SmartTradingScreenState();
}

class _SmartTradingScreenState extends State<SmartTradingScreen> {
  final _client = serviceLocator<CryptoGrpcClient>();

  bool _loading = true;
  String? _error;

  // Fear & Greed
  FearGreedEntry? _currentFearGreed;
  List<FearGreedEntry> _fearGreedHistory = [];

  // Global market
  GetGlobalMarketDataResponse? _globalMarket;

  // News
  List<CryptoNewsItem> _newsItems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final results = await Future.wait([
        _client.getFearGreedIndex(),
        _client.getGlobalMarketData(),
        _client.getCryptoNews(currencies: ['BTC', 'ETH', 'SOL'], limit: 20),
      ]);

      final fearGreed = results[0] as GetFearGreedIndexResponse;
      final market = results[1] as GetGlobalMarketDataResponse;
      final news = results[2] as GetCryptoNewsResponse;

      if (!mounted) return;
      setState(() {
        _currentFearGreed = fearGreed.current;
        _fearGreedHistory = fearGreed.history.toList();
        _globalMarket = market;
        _newsItems = news.items.toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load market data. Pull down to retry.';
        _loading = false;
      });
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Color _fearGreedColor(int value) {
    if (value <= 25) return _kRed;
    if (value <= 45) return const Color(0xFFFF6B35);
    if (value <= 55) return _kYellow;
    if (value <= 75) return const Color(0xFF34D399);
    return _kGreen;
  }

  String _formatLargeNumber(double value) {
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(2)}T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(2)}B';
    if (value >= 1e6) return '\$${(value / 1e6).toStringAsFixed(2)}M';
    return '\$${value.toStringAsFixed(0)}';
  }

  Color _sentimentColor(String sentiment) {
    final s = sentiment.toLowerCase();
    if (s == 'positive' || s == 'bullish') return _kGreen;
    if (s == 'negative' || s == 'bearish') return _kRed;
    return _kTextSecondary;
  }

  String _sentimentLabel(String sentiment) {
    final s = sentiment.toLowerCase();
    if (s == 'positive' || s == 'bullish') return 'Bullish';
    if (s == 'negative' || s == 'bearish') return 'Bearish';
    return 'Neutral';
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
            _buildAppBar(),
            Expanded(
              child: _loading
                  ? _buildShimmer()
                  : _error != null
                      ? _buildError()
                      : RefreshIndicator(
                          color: _kAccent,
                          backgroundColor: _kCard,
                          onRefresh: _loadData,
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 8.h),
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              _buildFearGreedGauge(),
                              SizedBox(height: 20.h),
                              _buildMarketOverview(),
                              SizedBox(height: 20.h),
                              _buildNewsSentiment(),
                              SizedBox(height: 20.h),
                              _buildFearGreedHistory(),
                              SizedBox(height: 32.h),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // App bar
  // ---------------------------------------------------------------------------

  Widget _buildAppBar() {
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
              child: Icon(Icons.arrow_back, color: _kTextPrimary, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Smart Trading',
              style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: _kTextPrimary),
            ),
          ),
          GestureDetector(
            onTap: _loadData,
            child: Icon(Icons.refresh_rounded,
                color: _kTextSecondary, size: 22.sp),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Fear & Greed Gauge
  // ---------------------------------------------------------------------------

  Widget _buildFearGreedGauge() {
    final value = _currentFearGreed?.value ?? 50;
    final classification = _currentFearGreed?.classification ?? 'Neutral';
    final color = _fearGreedColor(value);

    // Determine trend from history
    int? yesterdayValue;
    if (_fearGreedHistory.length >= 2) {
      yesterdayValue = _fearGreedHistory[1].value;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _kDivider, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.speed_rounded, color: _kAccent, size: 18.sp),
              SizedBox(width: 8.w),
              Text('Fear & Greed Index',
                  style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: _kTextPrimary)),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 180.w,
            width: 180.w,
            child: CustomPaint(
              painter: _FearGreedGaugePainter(value: value, color: color),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$value',
                        style: GoogleFonts.inter(
                            fontSize: 42.sp,
                            fontWeight: FontWeight.bold,
                            color: color)),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(classification,
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: _kTextSecondary)),
                        if (yesterdayValue != null) ...[
                          SizedBox(width: 6.w),
                          Icon(
                            value > yesterdayValue
                                ? Icons.arrow_upward_rounded
                                : value < yesterdayValue
                                    ? Icons.arrow_downward_rounded
                                    : Icons.remove,
                            color: value > yesterdayValue
                                ? _kGreen
                                : value < yesterdayValue
                                    ? _kRed
                                    : _kTextSecondary,
                            size: 16.sp,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Extreme Fear',
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: _kRed.withValues(alpha: 0.8))),
              Text('Extreme Greed',
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: _kGreen.withValues(alpha: 0.8))),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Market Overview Cards
  // ---------------------------------------------------------------------------

  Widget _buildMarketOverview() {
    final market = _globalMarket;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Market Overview',
            style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: _kTextPrimary)),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildMetricCard(
              label: 'Market Cap',
              value: _formatLargeNumber(market?.totalMarketCap ?? 0),
              icon: Icons.pie_chart_rounded,
            ),
            SizedBox(width: 10.w),
            _buildMetricCard(
              label: '24h Volume',
              value: _formatLargeNumber(market?.totalVolume24h ?? 0),
              icon: Icons.bar_chart_rounded,
            ),
            SizedBox(width: 10.w),
            _buildMetricCard(
              label: 'BTC Dom.',
              value:
                  '${(market?.marketCapPercentageBtc ?? 0).toStringAsFixed(1)}%',
              icon: Icons.currency_bitcoin_rounded,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _kDivider, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: _kAccent, size: 18.sp),
            SizedBox(height: 10.h),
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _kTextPrimary)),
            SizedBox(height: 2.h),
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 11.sp, color: _kTextSecondary)),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // News Sentiment
  // ---------------------------------------------------------------------------

  Widget _buildNewsSentiment() {
    int bullish = 0, bearish = 0, neutral = 0;
    for (final item in _newsItems) {
      final s = item.sentiment.toLowerCase();
      if (s == 'positive' || s == 'bullish') {
        bullish++;
      } else if (s == 'negative' || s == 'bearish') {
        bearish++;
      } else {
        neutral++;
      }
    }
    final total = bullish + bearish + neutral;
    final topNews = _newsItems.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('News Sentiment',
            style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: _kTextPrimary)),
        SizedBox(height: 12.h),
        // Stacked bar
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _kDivider, width: 1),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: SizedBox(
                  height: 12.h,
                  child: total > 0
                      ? Row(
                          children: [
                            if (bullish > 0)
                              Expanded(
                                  flex: bullish,
                                  child: Container(color: _kGreen)),
                            if (neutral > 0)
                              Expanded(
                                  flex: neutral,
                                  child: Container(color: _kTextSecondary)),
                            if (bearish > 0)
                              Expanded(
                                  flex: bearish,
                                  child: Container(color: _kRed)),
                          ],
                        )
                      : Container(color: _kDivider),
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _sentimentLegend('Bullish', bullish, _kGreen),
                  _sentimentLegend('Neutral', neutral, _kTextSecondary),
                  _sentimentLegend('Bearish', bearish, _kRed),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Top news list
        ...topNews.map((item) => _buildNewsItem(item)),
      ],
    );
  }

  Widget _sentimentLegend(String label, int count, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text('$label ($count)',
            style: GoogleFonts.inter(fontSize: 12.sp, color: _kTextSecondary)),
      ],
    );
  }

  Widget _buildNewsItem(CryptoNewsItem item) {
    final sentimentColor = _sentimentColor(item.sentiment);
    final sentimentLabel = _sentimentLabel(item.sentiment);

    return GestureDetector(
      onTap: () {
        if (item.url.isNotEmpty) {
          launchUrl(Uri.parse(item.url), mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _kDivider, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: _kTextPrimary)),
                  SizedBox(height: 6.h),
                  Text(item.source,
                      style: GoogleFonts.inter(
                          fontSize: 11.sp, color: _kTextSecondary)),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: sentimentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(sentimentLabel,
                  style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: sentimentColor)),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Fear & Greed History Chart
  // ---------------------------------------------------------------------------

  Widget _buildFearGreedHistory() {
    final history = _fearGreedHistory.take(30).toList().reversed.toList();
    if (history.isEmpty) return const SizedBox.shrink();

    final spots = <FlSpot>[];
    for (int i = 0; i < history.length; i++) {
      spots.add(FlSpot(i.toDouble(), history[i].value.toDouble()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('30-Day Fear & Greed Trend',
            style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: _kTextPrimary)),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.fromLTRB(12.w, 20.h, 16.w, 12.h),
          height: 200.h,
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _kDivider, width: 1),
          ),
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: 100,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 25,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: _kDivider,
                  strokeWidth: 0.5,
                ),
              ),
              titlesData: FlTitlesData(
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 25,
                    reservedSize: 32,
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style: GoogleFonts.inter(
                          fontSize: 10.sp, color: _kTextSecondary),
                    ),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: _kAccent,
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _kAccent.withValues(alpha: 0.25),
                        _kAccent.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => _kCard,
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (touchedSpots) => touchedSpots
                      .map((spot) => LineTooltipItem(
                            spot.y.toInt().toString(),
                            GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: _kTextPrimary),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Shimmer loading
  // ---------------------------------------------------------------------------

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: _kCard,
      highlightColor: const Color(0xFF2A2A2A),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _shimmerBox(height: 280.h),
          SizedBox(height: 20.h),
          Row(children: [
            Expanded(child: _shimmerBox(height: 90.h)),
            SizedBox(width: 10.w),
            Expanded(child: _shimmerBox(height: 90.h)),
            SizedBox(width: 10.w),
            Expanded(child: _shimmerBox(height: 90.h)),
          ]),
          SizedBox(height: 20.h),
          _shimmerBox(height: 80.h),
          SizedBox(height: 8.h),
          _shimmerBox(height: 70.h),
          SizedBox(height: 8.h),
          _shimmerBox(height: 70.h),
          SizedBox(height: 20.h),
          _shimmerBox(height: 200.h),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14.r),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Error state
  // ---------------------------------------------------------------------------

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, color: _kTextSecondary, size: 48.sp),
            SizedBox(height: 16.h),
            Text(_error ?? 'Something went wrong',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.inter(fontSize: 14.sp, color: _kTextSecondary)),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: _loadData,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text('Retry',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: _kTextPrimary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Fear & Greed Gauge Painter
// =============================================================================

class _FearGreedGaugePainter extends CustomPainter {
  final int value;
  final Color color;

  _FearGreedGaugePainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const startAngle = 2.35619; // 135 degrees in radians
    const sweepAngle = 4.71239; // 270 degrees in radians

    // Background arc
    final bgPaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Gradient arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: const [
        Color(0xFFEF4444), // Red (Extreme Fear)
        Color(0xFFFF6B35), // Orange
        Color(0xFFFBBF24), // Yellow (Neutral)
        Color(0xFF34D399), // Light green
        Color(0xFF10B981), // Green (Extreme Greed)
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final valueFraction = value / 100.0;
    final valueSweep = sweepAngle * valueFraction;

    final fgPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, valueSweep, false, fgPaint);

    // Needle dot at the end of the value arc
    final needleAngle = startAngle + valueSweep;
    final dotCenter = Offset(
      center.dx + radius * math.cos(needleAngle),
      center.dy + radius * math.sin(needleAngle),
    );
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(dotCenter, 6, dotPaint);
    final dotBorderPaint = Paint()
      ..color = _kBg
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(dotCenter, 6, dotBorderPaint);
  }

  @override
  bool shouldRepaint(covariant _FearGreedGaugePainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.color != color;
}
