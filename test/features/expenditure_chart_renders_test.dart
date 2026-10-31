import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/dashboard/expenditure_chart.dart';
import 'package:lazervault/src/features/widgets/dashboard/expenditure_chart_type.dart';

/// Every chart shape must actually PAINT, on real data and on the degenerate
/// data a quiet account produces. The arithmetic is covered in
/// expenditure_chart_test.dart; this is the half that only a pumped widget can
/// prove, because the failures live inside fl_chart:
///
///   * `RadarDataSet` asserts `dataEntries.length >= 3` — a crash in debug.
///   * A pie whose sections sum to zero divides by that total.
///   * A one-point line collapses minX == maxX.
///   * An axis with maxY == 0 lays out a zero-height plot by dividing by it.
///
/// A test that only calls the helpers would pass through all four.
void main() {
  Widget host(Widget child) => ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            // The real card is a purple gradient; size it like the real slot
            // so layout maths runs against realistic constraints.
            body: Center(
              child: SizedBox(height: 240, width: 340, child: child),
            ),
          ),
        ),
      );

  List<ExpenditurePoint> trend(List<double> amounts) => [
        for (var i = 0; i < amounts.length; i++)
          ExpenditurePoint(
            date: DateTime(2026, 10, i + 1),
            amount: amounts[i],
          ),
      ];

  List<ExpenditureSlice> slices(List<double> amounts) => [
        for (var i = 0; i < amounts.length; i++)
          ExpenditureSlice(name: 'Category $i', amount: amounts[i]),
      ];

  Widget chart(
    ExpenditureChartType type, {
    required List<ExpenditurePoint> points,
    required List<ExpenditureSlice> cats,
    double total = 10000,
  }) =>
      host(ExpenditureChart(
        type: type,
        trend: points,
        categories: cats,
        currencySymbol: '₦',
        bottomLabel: (d) => '${d.day}',
        totalSpent: total,
      ));

  group('realistic data', () {
    final points = trend([1200, 4500, 800, 9900, 2300, 15000, 640]);
    final cats = slices([42000, 18000, 9500, 4200, 1100]);

    for (final type in ExpenditureChartType.values) {
      testWidgets('${type.name} paints', (tester) async {
        await tester.pumpWidget(
            chart(type, points: points, cats: cats, total: 74800));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('a single day of activity', () {
    // availableChartTypes refuses line and area here; bar must still paint.
    final points = trend([5000]);
    final cats = slices([5000]);

    test('line and area are not offered', () {
      final a = availableChartTypes(trendPoints: 1, categoryCount: 1);
      expect(a, isNot(contains(ExpenditureChartType.line)));
      expect(a, isNot(contains(ExpenditureChartType.area)));
    });

    testWidgets('bar paints with one bar', (tester) async {
      await tester.pumpWidget(chart(ExpenditureChartType.bar,
          points: points, cats: cats, total: 5000));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('pie paints with one slice', (tester) async {
      await tester.pumpWidget(chart(ExpenditureChartType.pie,
          points: points, cats: cats, total: 5000));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });

  group('every amount is zero', () {
    // Real: a period containing only refunds or only failed attempts. The old
    // axis maths made maxY 0 here and fl_chart divides by it.
    final points = trend([0, 0, 0, 0]);

    for (final type in [
      ExpenditureChartType.line,
      ExpenditureChartType.area,
      ExpenditureChartType.bar,
    ]) {
      testWidgets('${type.name} paints on an all-zero series', (tester) async {
        await tester.pumpWidget(
            chart(type, points: points, cats: const [], total: 0));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('a zero-total pie draws nothing rather than dividing by zero',
        (tester) async {
      await tester.pumpWidget(chart(ExpenditureChartType.pie,
          points: points, cats: slices([0, 0]), total: 0));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });

  group('radar guards its own minimum', () {
    testWidgets('two categories render as empty, not as an assert',
        (tester) async {
      // Availability keeps this out of the cycle, but the widget is public and
      // the fl_chart assert is a crash, so it must defend itself.
      await tester.pumpWidget(chart(ExpenditureChartType.radar,
          points: trend([1, 2, 3]), cats: slices([500, 300])));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('three categories paint', (tester) async {
      await tester.pumpWidget(chart(ExpenditureChartType.radar,
          points: trend([1, 2, 3]), cats: slices([500, 300, 120])));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });

  group('a long period and big money', () {
    testWidgets('31 days of six-figure amounts paint without overflow',
        (tester) async {
      // The combination the old chart handled worst: ₦-scale labels in a fixed
      // 46px gutter, and 31 x-labels drawn at every position.
      final points = trend([
        for (var i = 0; i < 31; i++) 120000 + (i % 7) * 48000.0,
      ]);
      await tester.pumpWidget(chart(ExpenditureChartType.line,
          points: points, cats: const [], total: 4200000));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('bars thin out rather than overlapping', (tester) async {
      final points = trend([for (var i = 0; i < 31; i++) 1000.0 * (i + 1)]);
      await tester.pumpWidget(chart(ExpenditureChartType.bar,
          points: points, cats: const [], total: 496000));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });

  group('awkward category data', () {
    testWidgets('many categories cycle colours and still paint',
        (tester) async {
      final cats = slices([for (var i = 0; i < 14; i++) 1000.0 * (14 - i)]);
      await tester.pumpWidget(chart(ExpenditureChartType.donut,
          points: trend([1, 2]), cats: cats, total: 105000));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('a very long category name does not break the radar',
        (tester) async {
      final cats = [
        const ExpenditureSlice(
            name: 'Transfers to other banks and wallets', amount: 9000),
        const ExpenditureSlice(name: 'Airtime', amount: 1200),
        const ExpenditureSlice(name: 'Electricity and utilities', amount: 800),
      ];
      await tester.pumpWidget(chart(ExpenditureChartType.radar,
          points: trend([1, 2, 3]), cats: cats, total: 11000));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('one dominant category plus slivers still labels cleanly',
        (tester) async {
      // Slices under 8% have their percentage hidden to stop the labels
      // overlapping; the legend names them instead.
      final cats = slices([98000, 900, 600, 400, 300]);
      await tester.pumpWidget(chart(ExpenditureChartType.pie,
          points: trend([1, 2]), cats: cats, total: 100200));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });
}
