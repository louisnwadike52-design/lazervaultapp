import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

/// Money was printed without thousands separators everywhere in the app.
///
/// `CurrencySymbols.formatAmount` and `formatAmountWithCurrency` — 265 call
/// sites between them — both ended in `toStringAsFixed(2)`, so a family account
/// holding ₦120,000 displayed as `₦120000.00`. At that length the digits have to
/// be counted to be read, which is where someone misreads their own balance by a
/// factor of ten.
///
/// The formatter needs a real currency/locale to run, so the pattern is
/// exercised directly and the source is pinned below.
void main() {
  group('the pattern groups thousands and keeps the leading zero', () {
    final money = NumberFormat('#,##0.00');

    test('large balances are grouped', () {
      expect(money.format(120000), '120,000.00');
      expect(money.format(1844), '1,844.00');
      expect(money.format(12345678.9), '12,345,678.90');
    });

    test('values below one keep their leading zero', () {
      // The other half of the bug, found in send-funds: '#,###.00' renders these
      // with no integer digit at all — ₦0.50 as "₦.50", zero as "₦.00".
      expect(money.format(0.5), '0.50');
      expect(money.format(0), '0.00');
      expect(NumberFormat('#,###.00').format(0.5), '.50',
          reason: 'the pattern being replaced, kept here so the difference is '
              'visible rather than asserted from memory');
    });

    test('kobo are never dropped', () {
      expect(money.format(1500.05), '1,500.05');
      expect(money.format(99.9), '99.90');
    });
  });

  group('the shared formatter uses it', () {
    late String source;

    setUpAll(() {
      source =
          File('lib/core/utils/currency_formatter.dart').readAsStringSync();
    });

    test('both public formatters go through one pattern', () {
      expect(source, contains("NumberFormat('#,##0.00')"));
      expect(source, isNot(contains('amount.toStringAsFixed(2)')),
          reason: 'this is what printed 265 amounts ungrouped');
      // Two methods, ONE pattern constant — so the next fix does not have to
      // find both call sites.
      expect("NumberFormat('#,##0.00')".allMatches(source).length, 1);
    });

    test('the dead third formatter is gone', () {
      // formatAmountWithCode had zero call sites.
      expect(source, isNot(contains('formatAmountWithCode')));
    });
  });

  group('closing a family account clears its card', () {
    late String source;

    setUpAll(() {
      source = File(
        'lib/src/features/family_account/presentation/views/'
        'family_account_detail_screen.dart',
      ).readAsStringSync();
    });

    test('deleting refreshes the dashboard before popping', () {
      // The carousel reads the regular accounts list, so without this the closed
      // account's card stays on the dashboard with its old balance.
      final idx = source.indexOf('state is FamilyAccountDeleted');
      expect(idx, greaterThan(-1));
      final branch = source.substring(idx, idx + 1200);
      expect(branch, contains('_refreshDashboardSummaries();'));
      expect(
        branch.indexOf('_refreshDashboardSummaries();'),
        lessThan(branch.indexOf('Get.back()')),
        reason: 'refresh before popping, or the cubit may be gone',
      );
    });

    test('leaving refreshes it too', () {
      final idx = source.indexOf('state is FamilyAccountLeft');
      expect(idx, greaterThan(-1));
      expect(source.substring(idx, idx + 900),
          contains('_refreshDashboardSummaries();'));
    });

    test('the returned balance is formatted, not raw', () {
      // It is the money the user just got back. "₦120000.00" is the worst place
      // in the flow to make someone count digits.
      expect(source,
          contains('CurrencySymbols.formatAmount(state.returnedBalance)'));
      expect(
          source, isNot(contains('state.returnedBalance.toStringAsFixed(2)')));
    });
  });
}
