import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// The chart primitives behind [ChatAnalyticsCard].
///
/// Split out because the card itself is the layout and these are the drawing —
/// and because three chart kinds in one file with the header and totals row put
/// it well past the repo's 500-line ceiling.
///
/// The palette lives HERE rather than on the wire. The backend sends values and
/// labels only; a service that shipped hex codes would be picking colours for a
/// theme it cannot see, and would fight dark mode from the wrong side.

/// Brand-derived series colours, in assignment order.
///
/// Ordered so the first two — the ones that carry the eye on a two-series chart
/// and the biggest slice on a donut — are the dashboard purple and a green that
/// reads as "money in" without further explanation.
const List<Color> kAnalyticsPalette = <Color>[
  Color(0xFF7C5CFF), // brand purple, lifted for contrast on the dark card
  Color(0xFF34D399), // money-in green
  Color(0xFFF59E0B), // amber
  Color(0xFF38BDF8), // sky
  Color(0xFFFB7185), // rose
  Color(0xFFA78BFA), // light violet
  Color(0xFF94A3B8), // slate — reserved feel, suits the folded "Other" slice
];

Color analyticsColorAt(int index) =>
    kAnalyticsPalette[index % kAnalyticsPalette.length];

final NumberFormat _whole = NumberFormat('#,##0');
final NumberFormat _twoDp = NumberFormat('#,##0.00');

/// Full precision, for figures the user might check against a statement.
String analyticsMoney(double value, String currency) =>
    '${CurrencySymbols.getSymbol(currency)}${_twoDp.format(value)}';

/// Short form, for axis ticks and cramped labels.
///
/// This is the "₦1,100, not ₦1.1" rule: dividing to make a number short is what
/// produced amounts a hundred times too small elsewhere in the chat. Here the
/// magnitude is always spelled out by its SUFFIX, so ₦1.1k can never be misread
/// as ₦1.10.
String analyticsMoneyCompact(double value, String currency) {
  final symbol = CurrencySymbols.getSymbol(currency);
  final abs = value.abs();
  final sign = value < 0 ? '-' : '';
  if (abs >= 1000000000) {
    return '$sign$symbol${(abs / 1000000000).toStringAsFixed(1)}B';
  }
  if (abs >= 1000000) {
    return '$sign$symbol${(abs / 1000000).toStringAsFixed(1)}M';
  }
  if (abs >= 1000) {
    return '$sign$symbol${(abs / 1000).toStringAsFixed(1)}k';
  }
  return '$sign$symbol${_whole.format(abs)}';
}

/// One point as the card understands it. Mirrors AnalyticsPoint on the wire.
class AnalyticsPointView {
  const AnalyticsPointView({
    required this.label,
    required this.value,
    this.secondary,
    this.percentage,
    this.count,
  });

  final String label;
  final double value;
  final double? secondary;
  final double? percentage;
  final int? count;

  static double _num(dynamic v) {
    if (v is num) return v.toDouble();
    return double.tryParse(v?.toString() ?? '') ?? 0.0;
  }

  static AnalyticsPointView? fromJson(dynamic raw) {
    if (raw is! Map) return null;
    final label = raw['label']?.toString().trim() ?? '';
    // A slice with no name cannot be read, so it is not drawn. Dropping it is
    // safer than labelling it "Unknown", which invents a category.
    if (label.isEmpty) return null;
    return AnalyticsPointView(
      label: label,
      value: _num(raw['value']),
      secondary: raw['secondary'] == null ? null : _num(raw['secondary']),
      percentage: raw['percentage'] == null ? null : _num(raw['percentage']),
      count: raw['count'] == null ? null : _num(raw['count']).round(),
    );
  }
}

/// A donut plus a legend, because a donut alone is unreadable.
///
/// fl_chart can draw labels inside the slices, but at chat-bubble width the
/// small slices overlap into illegibility. The legend carries the name, the
/// amount and the share instead, and the ring carries only proportion.
class AnalyticsDonut extends StatelessWidget {
  const AnalyticsDonut({
    super.key,
    required this.points,
    required this.currency,
  });

  final List<AnalyticsPointView> points;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final total = points.fold<double>(0, (sum, p) => sum + p.value);
    if (total <= 0) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 44.r,
                  startDegreeOffset: -90,
                  sections: [
                    for (int i = 0; i < points.length; i++)
                      PieChartSectionData(
                        value: points[i].value,
                        color: analyticsColorAt(i),
                        radius: 22.r,
                        showTitle: false,
                      ),
                  ],
                ),
              ),
              // The total belongs in the hole: it is the number every slice is
              // a fraction of, and putting it anywhere else makes the reader
              // hunt for the denominator.
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8A8AA3),
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    analyticsMoneyCompact(total, currency),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        for (int i = 0; i < points.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              children: [
                Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: analyticsColorAt(i),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    points[i].label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFD6D6E2),
                      fontSize: 11.5.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  analyticsMoney(points[i].value, currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (points[i].percentage != null) ...[
                  SizedBox(width: 6.w),
                  Text(
                    '${points[i].percentage!.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8A8AA3),
                      fontSize: 10.5.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

/// Vertical bars, for a handful of named amounts.
class AnalyticsBars extends StatelessWidget {
  const AnalyticsBars({
    super.key,
    required this.points,
    required this.currency,
  });

  final List<AnalyticsPointView> points;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final maxValue = points.fold<double>(
      0,
      (m, p) => math.max(m, p.value),
    );
    if (maxValue <= 0) return const SizedBox.shrink();

    return SizedBox(
      height: 168.h,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          // Headroom so the tallest bar does not touch the top border, which
          // reads as a clipped chart.
          maxY: maxValue * 1.18,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue / 2 <= 0 ? null : maxValue / 2,
            getDrawingHorizontalLine: (_) => FlLine(
              color: const Color(0xFF2D2D3D),
              strokeWidth: 1,
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                '${points[group.x].label}\n'
                '${analyticsMoney(rod.toY, currency)}',
                GoogleFonts.inter(color: Colors.white, fontSize: 11.sp),
              ),
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42.w,
                interval: maxValue / 2 <= 0 ? null : maxValue / 2,
                getTitlesWidget: (value, _) => Text(
                  analyticsMoneyCompact(value, currency),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8A8AA3),
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30.h,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= points.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      // Truncated hard rather than wrapped: a wrapped axis
                      // label pushes the plot area up and squashes the bars.
                      points[i].label.length > 8
                          ? '${points[i].label.substring(0, 7)}…'
                          : points[i].label,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8A8AA3),
                        fontSize: 9.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (int i = 0; i < points.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: points[i].value,
                    color: analyticsColorAt(i),
                    width: 16.w,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4.r),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Two series over time, with a legend naming both.
class AnalyticsTrendLine extends StatelessWidget {
  const AnalyticsTrendLine({
    super.key,
    required this.points,
    required this.currency,
    required this.seriesLabels,
  });

  final List<AnalyticsPointView> points;
  final String currency;
  final List<String> seriesLabels;

  @override
  Widget build(BuildContext context) {
    double maxValue = 0;
    for (final p in points) {
      maxValue = math.max(maxValue, p.value);
      maxValue = math.max(maxValue, p.secondary ?? 0);
    }
    if (points.length < 2) {
      // One point is not a trend. A single dot on an axis invites the reader to
      // infer a direction that the data does not contain.
      return const SizedBox.shrink();
    }

    LineChartBarData series(bool primary, Color color) => LineChartBarData(
          isCurved: true,
          curveSmoothness: 0.25,
          color: color,
          barWidth: 2.4,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: color.withValues(alpha: 0.12),
          ),
          spots: [
            for (int i = 0; i < points.length; i++)
              FlSpot(
                i.toDouble(),
                primary ? points[i].value : (points[i].secondary ?? 0),
              ),
          ],
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160.h,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxValue <= 0 ? 1 : maxValue * 1.18,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxValue / 2 <= 0 ? null : maxValue / 2,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: const Color(0xFF2D2D3D),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 42.w,
                    interval: maxValue / 2 <= 0 ? null : maxValue / 2,
                    getTitlesWidget: (value, _) => Text(
                      analyticsMoneyCompact(value, currency),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8A8AA3),
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24.h,
                    getTitlesWidget: (value, _) {
                      final i = value.round();
                      if (i < 0 || i >= points.length) {
                        return const SizedBox.shrink();
                      }
                      // Every label at chat width collides; show the ends and
                      // the middle, which is enough to orient the series.
                      final keep = i == 0 ||
                          i == points.length - 1 ||
                          i == points.length ~/ 2;
                      if (!keep) return const SizedBox.shrink();
                      return Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          points[i].label,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8A8AA3),
                            fontSize: 9.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (spots) => spots.map((s) {
                    final i = s.x.round();
                    final label =
                        i >= 0 && i < points.length ? points[i].label : '';
                    return LineTooltipItem(
                      '$label\n${analyticsMoney(s.y, currency)}',
                      GoogleFonts.inter(color: Colors.white, fontSize: 11.sp),
                    );
                  }).toList(),
                ),
              ),
              lineBarsData: [
                series(true, analyticsColorAt(1)),
                series(false, analyticsColorAt(0)),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            for (int i = 0; i < seriesLabels.length && i < 2; i++) ...[
              Container(
                width: 9.w,
                height: 9.w,
                decoration: BoxDecoration(
                  // Index 0 is the primary series, drawn in the green at
                  // palette slot 1 — so the legend swatch has to follow the
                  // line, not the loop counter.
                  color: analyticsColorAt(i == 0 ? 1 : 0),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                seriesLabels[i],
                style: GoogleFonts.inter(
                  color: const Color(0xFFD6D6E2),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(width: 14.w),
            ],
          ],
        ),
      ],
    );
  }
}
