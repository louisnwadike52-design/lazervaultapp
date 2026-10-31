import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The shapes the dashboard expenditure card can draw its data in.
///
/// Two families, because the card holds two genuinely different datasets and a
/// chart can only answer questions its data supports:
///
///   * TREND (line, area, bar) reads the daily series — "when did I spend?"
///   * SHARE (pie, donut, radar) reads the category breakdown — "on what?"
///
/// Keeping both in one cycle is the point: the user taps once and the same
/// money is re-asked as a different question. What it must never do is offer a
/// shape the data cannot fill, which is why [availableChartTypes] exists rather
/// than the UI cycling blindly through the enum.
enum ExpenditureChartType { line, area, bar, pie, donut, radar }

extension ExpenditureChartTypeX on ExpenditureChartType {
  /// Short name for the cycle button.
  String get label => switch (this) {
        ExpenditureChartType.line => 'Line',
        ExpenditureChartType.area => 'Area',
        ExpenditureChartType.bar => 'Bars',
        ExpenditureChartType.pie => 'Pie',
        ExpenditureChartType.donut => 'Donut',
        ExpenditureChartType.radar => 'Radar',
      };

  IconData get icon => switch (this) {
        ExpenditureChartType.line => Icons.show_chart_rounded,
        ExpenditureChartType.area => Icons.area_chart_rounded,
        ExpenditureChartType.bar => Icons.bar_chart_rounded,
        ExpenditureChartType.pie => Icons.pie_chart_rounded,
        ExpenditureChartType.donut => Icons.donut_large_rounded,
        ExpenditureChartType.radar => Icons.radar_rounded,
      };

  /// True for the shapes that plot the CATEGORY breakdown rather than the
  /// daily series. Drives both which data the builder reads and whether the
  /// legend shows category colours.
  bool get isCategoryChart => switch (this) {
        ExpenditureChartType.pie ||
        ExpenditureChartType.donut ||
        ExpenditureChartType.radar =>
          true,
        _ => false,
      };

  /// One line for the info sheet: what this shape is good for. Phrased as the
  /// question it answers, since that is how someone picks a chart.
  String get explanation => switch (this) {
        ExpenditureChartType.line =>
          'Spending per day across the period, joined into a trend. Best for '
              'spotting when your spending rises or falls.',
        ExpenditureChartType.area =>
          'The same daily trend with the area beneath it filled, which makes '
              'the overall volume easier to judge than the line alone.',
        ExpenditureChartType.bar =>
          'One bar per day. Best for comparing individual days, since each '
              'day is a separate block rather than a point on a curve.',
        ExpenditureChartType.pie =>
          'Your spending split by category, sized by share. Best for seeing '
              'what took the largest part of your money.',
        ExpenditureChartType.donut =>
          'The same category split, with the period total in the middle so '
              'share and total read together.',
        ExpenditureChartType.radar =>
          'Categories on their own axes, so a spread across many categories '
              'looks different from everything landing in one.',
      };
}

/// Minimum categories a radar can be drawn from.
///
/// fl_chart's `RadarDataSet` asserts `dataEntries.length >= 3` and an assert
/// is a CRASH in a debug build and undefined shape in release — so this is not
/// a nicety, it is the guard that keeps radar out of the cycle until the data
/// can fill it. Two categories would also be meaningless as a polygon.
const int kRadarMinCategories = 3;

/// Chart shapes that can actually be drawn from the data on hand.
///
/// Returned in a stable order so the cycle is predictable between rebuilds —
/// a user who taps twice must land where they landed last time.
///
/// The rules, each from a real failure mode rather than taste:
///   * No trend points at all → no trend shapes. The caller shows its own
///     empty state instead of an axis with nothing on it.
///   * A SINGLE trend point cannot be a line or an area: a one-point line has
///     no segment to draw and fl_chart's x-range collapses (minX == maxX).
///     A bar is perfectly legible with one bar, so bar survives.
///   * No categories → no share shapes. This is the common case on a quiet
///     account, and cycling to an empty pie is the bug this prevents.
///   * Fewer than [kRadarMinCategories] → no radar, per the assert above.
List<ExpenditureChartType> availableChartTypes({
  required int trendPoints,
  required int categoryCount,
}) {
  final out = <ExpenditureChartType>[];
  if (trendPoints >= 2) {
    out.add(ExpenditureChartType.line);
    out.add(ExpenditureChartType.area);
  }
  if (trendPoints >= 1) {
    out.add(ExpenditureChartType.bar);
  }
  if (categoryCount >= 1) {
    out.add(ExpenditureChartType.pie);
    out.add(ExpenditureChartType.donut);
  }
  if (categoryCount >= kRadarMinCategories) {
    out.add(ExpenditureChartType.radar);
  }
  return out;
}

/// The next shape in the cycle, wrapping at the end.
///
/// If [current] is no longer available — the period changed and the categories
/// went away under a pie, which happens on every period switch — this returns
/// the FIRST available shape rather than guessing a neighbour, so the card
/// always lands somewhere it can draw.
///
/// Returns null only when nothing can be drawn at all, which the caller must
/// treat as "show the empty state", not "draw a line".
ExpenditureChartType? nextChartType(
  ExpenditureChartType current,
  List<ExpenditureChartType> available,
) {
  if (available.isEmpty) return null;
  final i = available.indexOf(current);
  if (i < 0) return available.first;
  return available[(i + 1) % available.length];
}

/// Clamp a remembered choice onto what the data can draw.
///
/// The chosen shape is persisted and restored, and the data behind it is not:
/// a user who left the card on Radar and comes back to a period with two
/// categories must not be shown a crash. Falls back to the first available.
ExpenditureChartType? resolveChartType(
  ExpenditureChartType? wanted,
  List<ExpenditureChartType> available,
) {
  if (available.isEmpty) return null;
  if (wanted != null && available.contains(wanted)) return wanted;
  return available.first;
}

// ─────────────────────────────────────────────────────────────────────
// Axis arithmetic
//
// The old chart derived its gridlines and labels from `maxAmount / 4` while
// setting `maxY` to `maxAmount * 1.2`. That is 4.8 steps, so the top gridline
// fell short of the top of the plot and every label was an arbitrary fraction
// of the largest transaction — "₦1483", "₦2966". Both are the "proper spacing
// and alignment" complaint, and both are arithmetic, not styling.
// ─────────────────────────────────────────────────────────────────────

/// A human axis step: 1, 2 or 5 times a power of ten.
///
/// These are the only step sizes people read fluently, which is why every
/// charting library converges on them. Covering [maxValue] in roughly
/// [targetTicks] steps and then rounding UP to the next nice number means the
/// axis always reaches past the data instead of clipping it.
double niceAxisStep(double maxValue, {int targetTicks = 4}) {
  if (!maxValue.isFinite || maxValue <= 0) return 1;
  final ticks = targetTicks < 1 ? 1 : targetTicks;
  final rough = maxValue / ticks;
  final magnitude = math.pow(10, (math.log(rough) / math.ln10).floor());
  final normalized = rough / magnitude;
  final double nice;
  if (normalized <= 1) {
    nice = 1;
  } else if (normalized <= 2) {
    nice = 2;
  } else if (normalized <= 5) {
    nice = 5;
  } else {
    nice = 10;
  }
  final step = nice * magnitude;
  // Guard the degenerate tiny-value case: a step of 0 would make fl_chart
  // divide by zero while laying out gridlines.
  return step <= 0 ? 1 : step.toDouble();
}

/// The axis top: the first nice step at or above [maxValue], with one extra
/// step of headroom so the peak never touches the ceiling.
///
/// Never returns 0. A zero maxY is the degenerate case the old code could
/// reach when every amount in the period was 0 (a real period — a month with
/// only refunds), and fl_chart lays out a 0-height plot by dividing by it.
double niceAxisMax(double maxValue, {int targetTicks = 4}) {
  final step = niceAxisStep(maxValue, targetTicks: targetTicks);
  if (!maxValue.isFinite || maxValue <= 0) return step;
  final steps = (maxValue / step).ceil();
  return step * (steps + 1);
}

/// Money for an axis label: short enough to fit, exact enough to trust.
///
/// `'$symbol${value.toInt()}'` was the old label. At Nigerian amounts that is
/// "₦1250000" in a 46-logical-pixel gutter, so the labels overflowed into the
/// plot and collided with each other. Thousands and millions are abbreviated;
/// anything under 1000 is shown exactly, because that is the range where a
/// rounded figure would be misleading rather than merely short.
String compactMoney(double value, String symbol) {
  final v = value.abs();
  final sign = value < 0 ? '-' : '';
  if (v >= 1000000000) {
    return '$sign$symbol${_trim(v / 1000000000)}B';
  }
  if (v >= 1000000) {
    return '$sign$symbol${_trim(v / 1000000)}M';
  }
  if (v >= 1000) {
    return '$sign$symbol${_trim(v / 1000)}k';
  }
  // Sub-1000 axis values can be fractional when the step is small (a quiet
  // period), so show one decimal only when there is one to show.
  if (v != v.roundToDouble() && v < 100) {
    return '$sign$symbol${_trim(v)}';
  }
  return '$sign$symbol${v.round()}';
}

/// One decimal place, and only when it carries information: 1.5k keeps its
/// decimal, 2.0k becomes 2k. A column of labels reading "2.0k 4.0k 6.0k"
/// wastes width on zeroes.
String _trim(double v) {
  final s = v.toStringAsFixed(1);
  return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
}

/// Width to reserve for the Y gutter, derived from the widest label the axis
/// will actually render rather than a fixed guess.
///
/// A hardcoded `reservedSize: 46` is right for "₦2k" and wrong for "₦1.2M",
/// and when it is wrong the label is clipped — silently, since there is no
/// overflow warning for a painted axis label.
double yAxisGutter(double axisMax, double step, String symbol,
    {double perChar = 6.5, double padding = 10}) {
  var widest = 0;
  for (var v = 0.0; v <= axisMax + step / 2; v += step) {
    final len = compactMoney(v, symbol).length;
    if (len > widest) widest = len;
    if (step <= 0) break;
  }
  return widest * perChar + padding;
}

/// The palette category slices and legend swatches are drawn from.
///
/// Fixed and ordered, so a category keeps its colour between the pie, the
/// donut, the radar and the legend — a category that changes colour when the
/// chart shape changes makes the legend useless. Chosen to stay legible on the
/// card's purple gradient, which rules out deep blues and violets.
const List<Color> kExpenditureCategoryColors = <Color>[
  Color(0xFF4ADE80), // green
  Color(0xFFFBBF24), // amber
  Color(0xFF38BDF8), // sky
  Color(0xFFF472B6), // pink
  Color(0xFFFB923C), // orange
  Color(0xFF2DD4BF), // teal
  Color(0xFFA3E635), // lime
  Color(0xFFE879F9), // fuchsia
];

/// Colour for the category at [index], cycling if there are more categories
/// than colours.
Color expenditureCategoryColor(int index) =>
    kExpenditureCategoryColors[index % kExpenditureCategoryColors.length];
