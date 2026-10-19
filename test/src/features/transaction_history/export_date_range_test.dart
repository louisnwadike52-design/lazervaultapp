import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_history/utils/export_date_range.dart';

/// THE DATE FILTERS DROPPED A DAY AT EACH END, IN DIFFERENT PLACES.
///
/// Account statement: the picker returns MIDNIGHT, and the panel sent those
/// instants verbatim. "1 Oct - 19 Oct" asked for everything up to
/// 19 Oct 00:00:00, so the whole of the last day the user picked was missing.
///
/// Dashboard export: the end was widened to 23:59:59 but the start was not,
/// and that start is built from DateTime.now(). Exporting at 06:00 dropped
/// everything before 06:00 on the first day of the range.
///
/// Both treat a DATE as a timestamp. One rule, tested once, for both.

void main() {
  test('the end day is included in full', () {
    // The account-statement bug, exactly.
    final r = ExportDateRange.wholeDays(DateTime(2026, 10, 1), DateTime(2026, 10, 19));
    expect(r.end, DateTime(2026, 10, 19, 23, 59, 59),
        reason: 'a statement to 19 Oct must include 19 Oct, not stop at its '
            'first instant');
    final lateThatDay = DateTime(2026, 10, 19, 22, 30);
    expect(lateThatDay.isBefore(r.end), isTrue,
        reason: 'a 22:30 transaction on the last day belongs in the range');
  });

  test('the start day is included from its first instant', () {
    // The dashboard-export bug: a range built at 06:00 from DateTime.now().
    final builtAtSixAm = DateTime(2026, 9, 19, 6, 0);
    final r = ExportDateRange.wholeDays(builtAtSixAm, DateTime(2026, 10, 19, 6, 0));
    expect(r.start, DateTime(2026, 9, 19));
    final earlyThatDay = DateTime(2026, 9, 19, 2, 15);
    expect(earlyThatDay.isBefore(r.start), isFalse,
        reason: 'a 02:15 transaction on the first day was being dropped '
            'because the range started at 06:00');
  });

  test('a single day is a whole day, not an instant', () {
    final r = ExportDateRange.wholeDays(DateTime(2026, 10, 19), DateTime(2026, 10, 19));
    expect(r.spanInDays, 0);
    expect(r.isInverted, isFalse);
    expect(DateTime(2026, 10, 19, 23, 59).isBefore(r.end), isTrue);
  });

  test('a legitimate 366-day range is not refused by the window check', () {
    // The regression the normalisation could have introduced: with the end at
    // 23:59:59 the Duration is 366 days AND 23:59:59, so a
    // `> Duration(days: 366)` comparison rejects a range that is exactly at
    // the limit. spanInDays counts whole days instead.
    final r = ExportDateRange.wholeDays(DateTime(2026, 1, 1), DateTime(2026, 1, 1).add(const Duration(days: 366)));
    expect(r.spanInDays, 366);
    expect(r.spanInDays > 366, isFalse);
  });

  test('an inverted range is still reported as inverted', () {
    final r = ExportDateRange.wholeDays(DateTime(2026, 10, 19), DateTime(2026, 10, 1));
    expect(r.isInverted, isTrue,
        reason: 'widening to whole days must not hide a backwards range');
  });
}
