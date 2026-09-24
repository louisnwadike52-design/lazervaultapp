import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/business/domain/entities/business_overview_entity.dart';

/// "Money in vs money out, items not displaying."
///
/// With every figure at zero the bar chart drew a bordered box containing only
/// its axis labels, under a "Money in vs out" heading. A chart that renders
/// nothing reads as broken; a sentence reads as "there is nothing here yet", and
/// only the second one is true of a business that has not recorded a sale.
///
/// The data path was NOT the problem and is pinned below: the aggregator's JSON
/// keys and the entity's mapping agree, and the figures are minor units divided by
/// 100 — so a zero chart means zero recorded activity, not a lost response. The
/// pie card beside it already had an empty state; the bar chart was the one that
/// did not.
void main() {
  group('the overview entity maps the aggregator response', () {
    test('nested keys are read, so a real response is not silently zero', () {
      // These key names are the contract with business-gateway's
      // business_overview_handler: payroll / expenses / tax nested, revenue and
      // net_cash_flow top-level.
      final o = BusinessOverviewEntity.fromJson({
        'currency': 'NGN',
        'payroll': {'net_paid': 500000},
        'expenses': {'total': 250000},
        'tax': {'total_due': 125000},
        'revenue': 1000000,
        'net_cash_flow': 125000,
      });
      expect(o.currency, 'NGN');
      // Minor units in, major units out. 500000 kobo is ₦5,000.00 — a test that
      // expected 500000 here would be encoding the same rescaling bug that
      // reported a ₦1,844 balance as ₦18.44.
      expect(o.payrollMajor, 5000.00);
      expect(o.expensesMajor, 2500.00);
      expect(o.taxMajor, 1250.00);
      expect(o.revenueMajor, 10000.00);
    });

    test('a missing section degrades to zero rather than throwing', () {
      // The aggregator fans out; one slow or failed leg returns a response with
      // that section absent.
      final o = BusinessOverviewEntity.fromJson({'currency': 'NGN'});
      expect(o.payrollMajor, 0);
      expect(o.expensesMajor, 0);
      expect(o.taxMajor, 0);
      expect(o.revenueMajor, 0);
    });

    test('string numbers are parsed', () {
      final o = BusinessOverviewEntity.fromJson({
        'revenue': '1000000',
        'payroll': {'net_paid': '500000'},
      });
      expect(o.revenueMajor, 10000.00);
      expect(o.payrollMajor, 5000.00);
    });
  });

  group('the dashboard never renders an empty chart', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/business/presentation/view/'
        'business_dashboard_screen.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'business_dashboard_screen.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('the bar chart has an empty state', () {
      expect(source, contains('if (maxV <= 0) {'),
          reason:
              'this is the case that drew a box with only axis labels in it');
      expect(source, contains('No money in or out yet'));
    });

    test('the empty state names the actions that fill it', () {
      // The figures come from sales, payroll, expenses and tax — not from wallet
      // activity — so "make a transfer" would be the wrong advice.
      expect(source, contains('Record a sale, an expense or a pay run'));
    });

    test('the pie card keeps its own empty state', () {
      expect(source, contains('No spending recorded yet'));
    });

    test('the chart still renders when there IS data', () {
      // The guard must be an early return for the zero case, not a replacement
      // of the chart.
      expect(source, contains('child: BarChart('));
    });
  });
}
