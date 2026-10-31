import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/dashboard/expenditure_chart_type.dart';

/// The dashboard expenditure card lets the user cycle its chart between a
/// trend (line / area / bar) and a share (pie / donut / radar). Two classes of
/// bug are possible and both are silent, so both are pinned here:
///
///   * CYCLING ONTO A SHAPE THE DATA CANNOT FILL. A pie with no categories
///     draws nothing; a radar with two of them trips fl_chart's
///     `dataEntries.length >= 3` assert, which is a crash in debug and an
///     undefined shape in release. [availableChartTypes] is the gate.
///   * AXES DERIVED FROM THE DATA'S OWN MAXIMUM. The chart this replaced set
///     its gridline interval to `maxAmount / 4` and `maxY` to
///     `maxAmount * 1.2` — 4.8 steps, so the top gridline fell short of the
///     plot and every label was a fraction of the largest single day. At zero
///     it was worse: maxY became 0 and fl_chart divides by it.
void main() {
  group('availableChartTypes', () {
    test('nothing at all is drawable from nothing', () {
      expect(availableChartTypes(trendPoints: 0, categoryCount: 0), isEmpty);
    });

    test('a single trend point gives bars only, never a line', () {
      // A one-point line has no segment, and fl_chart's x-range collapses
      // (minX == maxX). One bar is perfectly legible.
      final a = availableChartTypes(trendPoints: 1, categoryCount: 0);
      expect(a, [ExpenditureChartType.bar]);
      expect(a, isNot(contains(ExpenditureChartType.line)));
      expect(a, isNot(contains(ExpenditureChartType.area)));
    });

    test('two trend points unlock line and area', () {
      expect(
        availableChartTypes(trendPoints: 2, categoryCount: 0),
        containsAll([
          ExpenditureChartType.line,
          ExpenditureChartType.area,
          ExpenditureChartType.bar,
        ]),
      );
    });

    test('no categories means no share shapes', () {
      final a = availableChartTypes(trendPoints: 10, categoryCount: 0);
      expect(a, isNot(contains(ExpenditureChartType.pie)));
      expect(a, isNot(contains(ExpenditureChartType.donut)));
      expect(a, isNot(contains(ExpenditureChartType.radar)));
    });

    test('one category gives pie and donut but NOT radar', () {
      final a = availableChartTypes(trendPoints: 10, categoryCount: 1);
      expect(a, contains(ExpenditureChartType.pie));
      expect(a, contains(ExpenditureChartType.donut));
      expect(a, isNot(contains(ExpenditureChartType.radar)));
    });

    test('radar appears only at the package minimum of 3 categories', () {
      // fl_chart asserts >= 3. Two must stay out.
      expect(
        availableChartTypes(trendPoints: 5, categoryCount: 2),
        isNot(contains(ExpenditureChartType.radar)),
      );
      expect(
        availableChartTypes(trendPoints: 5, categoryCount: kRadarMinCategories),
        contains(ExpenditureChartType.radar),
      );
    });

    test('order is stable, so the cycle is predictable', () {
      final a = availableChartTypes(trendPoints: 30, categoryCount: 6);
      final b = availableChartTypes(trendPoints: 30, categoryCount: 6);
      expect(a, b);
      expect(a.first, ExpenditureChartType.line);
    });
  });

  group('nextChartType / resolveChartType', () {
    test('cycles forward and wraps', () {
      final a = availableChartTypes(trendPoints: 10, categoryCount: 4);
      var t = a.first;
      final walked = <ExpenditureChartType>[t];
      for (var i = 0; i < a.length - 1; i++) {
        t = nextChartType(t, a)!;
        walked.add(t);
      }
      expect(walked, a, reason: 'one tap per shape should visit each once');
      expect(nextChartType(t, a), a.first, reason: 'and then wrap');
    });

    test('a shape that is no longer available falls back to the first', () {
      // The period changed under a pie and the categories went away. This
      // happens on every period switch, so it is the common path, not an edge.
      final trendOnly = availableChartTypes(trendPoints: 8, categoryCount: 0);
      expect(nextChartType(ExpenditureChartType.pie, trendOnly),
          trendOnly.first);
      expect(resolveChartType(ExpenditureChartType.radar, trendOnly),
          trendOnly.first);
    });

    test('a remembered, still-valid shape is kept', () {
      final a = availableChartTypes(trendPoints: 8, categoryCount: 5);
      expect(resolveChartType(ExpenditureChartType.donut, a),
          ExpenditureChartType.donut);
    });

    test('null when nothing is drawable — caller must show its empty state',
        () {
      expect(nextChartType(ExpenditureChartType.line, const []), isNull);
      expect(resolveChartType(ExpenditureChartType.line, const []), isNull);
      expect(resolveChartType(null, const []), isNull);
    });

    test('never chosen yet resolves to the first available', () {
      final a = availableChartTypes(trendPoints: 1, categoryCount: 0);
      // Note this is BARS, not a line: the data has one point. A default of
      // "always line" would have been undrawable here.
      expect(resolveChartType(null, a), ExpenditureChartType.bar);
    });
  });

  group('niceAxisStep / niceAxisMax', () {
    test('steps are always 1, 2 or 5 times a power of ten', () {
      for (final max in [
        3.0, 47.0, 180.0, 999.0, 1250.0, 4800.0, 25000.0, 123456.0, 9.9e6,
      ]) {
        final step = niceAxisStep(max);
        final mantissa = step / _pow10((step.abs()).floorLog10());
        expect([1.0, 2.0, 5.0], contains(mantissa),
            reason: 'step $step for max $max is not a readable axis step');
      }
    });

    test('never returns zero, at any degenerate input', () {
      // A zero step makes fl_chart divide by zero laying out gridlines; a zero
      // maxY makes it lay out a zero-height plot. A period where every amount
      // is 0 is real — a month with only refunds.
      for (final v in [0.0, -5.0, double.nan, double.infinity, 1e-12]) {
        expect(niceAxisStep(v), greaterThan(0), reason: 'step for $v');
        expect(niceAxisMax(v), greaterThan(0), reason: 'max for $v');
      }
    });

    test('the axis always reaches ABOVE the data', () {
      for (var i = 1; i < 400; i++) {
        final max = i * 137.0;
        expect(niceAxisMax(max), greaterThan(max),
            reason: 'axis top must clear the peak, else the line is clipped');
      }
    });

    test('maxY is a whole number of steps, so the top gridline lands on it',
        () {
      // This is the "proper alignment" fix: 4.8 steps was why the top gridline
      // stopped short of the plot ceiling.
      for (final max in [100.0, 1250.0, 47000.0, 980000.0]) {
        final step = niceAxisStep(max);
        final top = niceAxisMax(max);
        expect((top / step - (top / step).round()).abs(), lessThan(0.0001),
            reason: '$top is not a whole multiple of $step');
      }
    });
  });

  group('compactMoney', () {
    test('abbreviates at each magnitude', () {
      expect(compactMoney(0, '₦'), '₦0');
      expect(compactMoney(950, '₦'), '₦950');
      expect(compactMoney(1000, '₦'), '₦1k');
      expect(compactMoney(1500, '₦'), '₦1.5k');
      expect(compactMoney(25000, '₦'), '₦25k');
      expect(compactMoney(1250000, '₦'), '₦1.3M');
      expect(compactMoney(2000000000, '₦'), '₦2B');
    });

    test('drops a trailing .0 rather than wasting label width', () {
      expect(compactMoney(2000, '₦'), '₦2k');
      expect(compactMoney(4000000, '₦'), '₦4M');
    });

    test('keeps a label short enough for a gutter, at Nigerian amounts', () {
      // The defect: '₦${value.toInt()}' produced '₦1250000' — eight characters
      // in a 46-logical-pixel gutter, which overflowed into the plot.
      expect(compactMoney(1250000, '₦').length, lessThanOrEqualTo(7));
      expect(compactMoney(987654321, '₦').length, lessThanOrEqualTo(7));
    });

    test('signs negatives rather than dropping the sign', () {
      expect(compactMoney(-1500, '₦'), '-₦1.5k');
    });
  });

  group('yAxisGutter', () {
    test('always wide enough for the widest label it will draw', () {
      // The invariant that matters is NO CLIPPING, not monotonic growth.
      // Growth is the wrong thing to assert: compactMoney bounds label length
      // so well that a 400 axis ("₦100") and a 9.5M one ("₦15M") are both four
      // characters and correctly get the same gutter. Checking the gutter
      // against the labels the axis actually renders catches a real clip at
      // any magnitude.
      for (final max in [
        0.0, 37.0, 400.0, 1500.0, 48000.0, 9500000.0, 1.2e9,
      ]) {
        final step = niceAxisStep(max);
        final top = niceAxisMax(max);
        var widestChars = 0;
        for (var v = 0.0; v <= top + step / 2; v += step) {
          final len = compactMoney(v, '₦').length;
          if (len > widestChars) widestChars = len;
        }
        final gutter = yAxisGutter(top, step, '₦');
        expect(gutter, greaterThanOrEqualTo(widestChars * 6.5),
            reason: 'gutter $gutter cannot fit a $widestChars-char label at '
                'max $max — the label is painted clipped, silently');
        // And stays a gutter, not a column: a runaway value would eat the plot.
        expect(gutter, lessThan(120),
            reason: 'gutter $gutter at max $max is wider than the chart can '
                'spare');
      }
    });

    test('a longer currency symbol gets a wider gutter', () {
      // The one thing that genuinely must widen it.
      expect(
        yAxisGutter(2000, niceAxisStep(2000), r'US$'),
        greaterThan(yAxisGutter(2000, niceAxisStep(2000), '₦')),
      );
    });

    test('terminates on a degenerate step', () {
      // The loop increments by step; a zero step would spin forever and hang
      // the build. niceAxisStep cannot return 0, but the guard is cheap.
      expect(yAxisGutter(0, 0, '₦'), greaterThan(0));
    });
  });

  group('category colours', () {
    test('cycle rather than going out of range', () {
      expect(expenditureCategoryColor(0), kExpenditureCategoryColors.first);
      expect(
        expenditureCategoryColor(kExpenditureCategoryColors.length),
        kExpenditureCategoryColors.first,
      );
      expect(() => expenditureCategoryColor(999), returnsNormally);
    });

    test('an index maps to one stable colour across chart shapes', () {
      // The legend names categories by colour and the pie hides the
      // percentage on slices under 8%, so a colour that changed between
      // shapes would leave small categories unidentifiable.
      for (var i = 0; i < 20; i++) {
        expect(expenditureCategoryColor(i), expenditureCategoryColor(i));
      }
    });
  });

  group('shape metadata is complete', () {
    test('every shape has a label, icon and explanation', () {
      for (final t in ExpenditureChartType.values) {
        expect(t.label, isNotEmpty);
        expect(t.explanation.length, greaterThan(20),
            reason: '${t.name} needs a real explanation for the info sheet');
        expect(t.icon, isNotNull);
      }
    });

    test('exactly the share shapes are category charts', () {
      final category = ExpenditureChartType.values
          .where((t) => t.isCategoryChart)
          .toSet();
      expect(category, {
        ExpenditureChartType.pie,
        ExpenditureChartType.donut,
        ExpenditureChartType.radar,
      });
    });
  });
}

int _floorLog10(double v) {
  var e = 0;
  var x = v;
  while (x >= 10) {
    x /= 10;
    e++;
  }
  while (x < 1 && x > 0) {
    x *= 10;
    e--;
  }
  return e;
}

double _pow10(int e) {
  var r = 1.0;
  if (e >= 0) {
    for (var i = 0; i < e; i++) {
      r *= 10;
    }
  } else {
    for (var i = 0; i < -e; i++) {
      r /= 10;
    }
  }
  return r;
}

extension on double {
  int floorLog10() => _floorLog10(this);
}
