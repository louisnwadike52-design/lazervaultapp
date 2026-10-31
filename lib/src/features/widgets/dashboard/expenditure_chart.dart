import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'expenditure_chart_type.dart';

/// One point of the daily series, decoupled from the proto so this widget can
/// be built and tested without a generated message.
class ExpenditurePoint {
  const ExpenditurePoint({required this.date, required this.amount});
  final DateTime date;
  final double amount;
}

/// One category slice, same reasoning.
class ExpenditureSlice {
  const ExpenditureSlice({required this.name, required this.amount});
  final String name;
  final double amount;
}

/// Draws the dashboard expenditure card's chart in whichever shape is selected.
///
/// Every shape is drawn on the card's purple gradient, so all ink is white or
/// from [kExpenditureCategoryColors] — nothing here may rely on the ambient
/// theme's onSurface colour, which is near-black and would vanish.
///
/// AXES ARE COMPUTED, NOT GUESSED. The chart this replaced set its gridline
/// interval to `maxAmount / 4` while setting `maxY` to `maxAmount * 1.2` — 4.8
/// steps, so the top gridline stopped short of the plot ceiling and every
/// label was a fraction of the largest single day ("₦1483", "₦2966"). It also
/// rendered labels as `'₦${value.toInt()}'` inside a fixed 46px gutter, so
/// Nigerian amounts overflowed into the plot. See [niceAxisStep],
/// [compactMoney] and [yAxisGutter].
class ExpenditureChart extends StatelessWidget {
  const ExpenditureChart({
    super.key,
    required this.type,
    required this.trend,
    required this.categories,
    required this.currencySymbol,
    required this.bottomLabel,
    required this.totalSpent,
  });

  final ExpenditureChartType type;
  final List<ExpenditurePoint> trend;
  final List<ExpenditureSlice> categories;
  final String currencySymbol;

  /// How to label an x-axis date. Injected so this widget needs no knowledge
  /// of the card's period enum.
  final String Function(DateTime) bottomLabel;

  /// Period total, shown in the donut's hole.
  final double totalSpent;

  static const _ink = Colors.white;
  static Color get _inkDim => Colors.white.withValues(alpha: 0.7);
  static Color get _grid => Colors.white.withValues(alpha: 0.1);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ExpenditureChartType.line:
        return _trendChart(filled: false);
      case ExpenditureChartType.area:
        return _trendChart(filled: true);
      case ExpenditureChartType.bar:
        return _barChart();
      case ExpenditureChartType.pie:
        return _pieChart(donut: false);
      case ExpenditureChartType.donut:
        return _pieChart(donut: true);
      case ExpenditureChartType.radar:
        return _radarChart();
    }
  }

  double get _maxTrend => trend.isEmpty
      ? 0
      : trend.map((e) => e.amount).reduce((a, b) => a > b ? a : b);

  /// How many x labels to draw. Every day on a week, every few on a month —
  /// drawing all 31 overlaps them into a grey smear.
  double _bottomInterval(int n) {
    if (n <= 7) return 1;
    if (n <= 14) return 2;
    if (n <= 31) return 5;
    return (n / 6).ceilToDouble();
  }

  // ── Trend shapes ──────────────────────────────────────────────────

  Widget _trendChart({required bool filled}) {
    final step = niceAxisStep(_maxTrend);
    final axisMax = niceAxisMax(_maxTrend);
    final gutter = yAxisGutter(axisMax, step, currencySymbol);
    final spots = <FlSpot>[
      for (var i = 0; i < trend.length; i++)
        FlSpot(i.toDouble(), trend[i].amount),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: step,
          getDrawingHorizontalLine: (_) => FlLine(color: _grid, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: _bottomInterval(trend.length),
              getTitlesWidget: _bottomTitle,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: step,
              reservedSize: gutter,
              getTitlesWidget: (v, _) => _leftTitle(v, axisMax),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        // Half a step of padding at each end so the first and last dot are
        // not sliced in half by the plot edge, which they were at minX: 0.
        minX: -0.5,
        maxX: (trend.length - 1) + 0.5,
        minY: 0,
        maxY: axisMax,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => const Color(0xFF2A0B5E),
            tooltipBorderRadius: BorderRadius.circular(8.r),
            getTooltipItems: (spots) => spots.map((s) {
              final i = s.x.round();
              final label = (i >= 0 && i < trend.length)
                  ? bottomLabel(trend[i].date)
                  : '';
              return LineTooltipItem(
                '$label\n${compactMoney(s.y, currencySymbol)}',
                TextStyle(
                  color: _ink,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            // Keeps a curve through a spiky series from dipping below zero,
            // which looks like negative spending.
            preventCurveOverShooting: true,
            color: _ink,
            barWidth: filled ? 2.5 : 3,
            isStrokeCapRound: true,
            // Dots on a month of points become a dotted smear, so they appear
            // only when there are few enough to read individually.
            dotData: FlDotData(
              show: trend.length <= 14 && !filled,
              getDotPainter: (s, p, b, i) => FlDotCirclePainter(
                radius: 4,
                color: _ink,
                strokeWidth: 2,
                strokeColor: const Color.fromARGB(255, 78, 3, 208),
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: filled
                    ? [
                        Colors.white.withValues(alpha: 0.45),
                        Colors.white.withValues(alpha: 0.04),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.03),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _barChart() {
    final step = niceAxisStep(_maxTrend);
    final axisMax = niceAxisMax(_maxTrend);
    final gutter = yAxisGutter(axisMax, step, currencySymbol);
    // Thin the bars as the period grows so 31 of them still have gaps.
    final width = trend.length <= 7
        ? 18.0
        : trend.length <= 14
            ? 11.0
            : trend.length <= 31
                ? 6.0
                : 3.0;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: axisMax,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: step,
          getDrawingHorizontalLine: (_) => FlLine(color: _grid, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: _bottomInterval(trend.length),
              getTitlesWidget: _bottomTitle,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: step,
              reservedSize: gutter,
              getTitlesWidget: (v, _) => _leftTitle(v, axisMax),
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => const Color(0xFF2A0B5E),
            tooltipBorderRadius: BorderRadius.circular(8.r),
            getTooltipItem: (group, gi, rod, ri) {
              final i = group.x;
              final label =
                  (i >= 0 && i < trend.length) ? bottomLabel(trend[i].date) : '';
              return BarTooltipItem(
                '$label\n${compactMoney(rod.toY, currencySymbol)}',
                TextStyle(
                  color: _ink,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
        barGroups: [
          for (var i = 0; i < trend.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: trend[i].amount,
                  width: width,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(width / 3),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.45),
                      Colors.white,
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ── Share shapes ──────────────────────────────────────────────────

  Widget _pieChart({required bool donut}) {
    final total = categories.fold<double>(0, (a, c) => a + c.amount);
    // Every category at zero would make fl_chart draw zero-sweep sections and
    // divide by the total while computing them. The caller's empty state is
    // the right answer, but guard here too since this widget is public.
    if (total <= 0) return const SizedBox.shrink();

    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: donut ? 46.r : 0,
            startDegreeOffset: -90,
            sections: [
              for (var i = 0; i < categories.length; i++)
                PieChartSectionData(
                  value: categories[i].amount,
                  color: expenditureCategoryColor(i),
                  radius: donut ? 26.r : 62.r,
                  // A percentage printed inside a 3% slice overlaps its
                  // neighbours into illegibility, so small slices are left to
                  // the legend, which names every category regardless.
                  showTitle: categories[i].amount / total >= 0.08,
                  title:
                      '${(categories[i].amount / total * 100).round()}%',
                  titleStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: donut ? Colors.white : const Color(0xFF1F1147),
                  ),
                ),
            ],
          ),
        ),
        if (donut)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 10.sp, color: _inkDim),
              ),
              SizedBox(height: 2.h),
              Text(
                compactMoney(totalSpent, currencySymbol),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _radarChart() {
    // Availability gating keeps this at >= kRadarMinCategories, but the assert
    // inside RadarDataSet is a crash, so never trust the caller here.
    if (categories.length < kRadarMinCategories) return const SizedBox.shrink();
    final maxAmount =
        categories.map((c) => c.amount).reduce((a, b) => a > b ? a : b);

    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        radarBackgroundColor: Colors.transparent,
        radarBorderData: BorderSide(color: _grid, width: 1),
        gridBorderData: BorderSide(color: _grid, width: 1),
        tickBorderData: const BorderSide(color: Colors.transparent),
        // Ticks hidden: their labels are drawn un-abbreviated by the package
        // and collided with the axis titles on Nigerian amounts. The legend
        // and tooltip carry the figures instead.
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 1),
        tickCount: 4,
        titlePositionPercentageOffset: 0.18,
        titleTextStyle: TextStyle(fontSize: 9.sp, color: _inkDim),
        getTitle: (index, angle) {
          if (index < 0 || index >= categories.length) {
            return const RadarChartTitle(text: '');
          }
          final name = categories[index].name;
          return RadarChartTitle(
            // Long category names rotate into each other on a small polygon.
            text: name.length <= 10 ? name : '${name.substring(0, 9)}…',
          );
        },
        dataSets: [
          RadarDataSet(
            fillColor: Colors.white.withValues(alpha: 0.18),
            borderColor: Colors.white,
            borderWidth: 2,
            entryRadius: 2.5,
            dataEntries: [
              for (final c in categories)
                // Normalised to the largest category: the polygon is about
                // relative spread, and absolute minor units would push every
                // vertex to the rim.
                RadarEntry(value: maxAmount <= 0 ? 0 : c.amount / maxAmount),
            ],
          ),
        ],
      ),
    );
  }

  // ── Axis label widgets ────────────────────────────────────────────

  Widget _bottomTitle(double value, TitleMeta meta) {
    final i = value.round();
    // The half-step padding on minX/maxX means fl_chart asks for titles just
    // outside the data range; those must render empty, not throw.
    if (i < 0 || i >= trend.length) return const SizedBox.shrink();
    // Only label integral positions — the padding makes fractional ones
    // reachable, and labelling them double-prints a day.
    if ((value - i).abs() > 0.01) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Text(
        bottomLabel(trend[i].date),
        style: TextStyle(
          color: _inkDim,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _leftTitle(double value, double axisMax) {
    // fl_chart emits a title at the very top of the plot as well as at each
    // interval; with headroom that top value is above the data and labelling
    // it crowds the corner.
    if (value > axisMax - 0.01) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Text(
        compactMoney(value, currencySymbol),
        textAlign: TextAlign.right,
        style: TextStyle(
          color: _inkDim,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
