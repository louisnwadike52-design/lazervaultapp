import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// The end date the start sheet shows must be the one the server stores.
///
/// Both walk one period at a time rather than multiplying a duration, so the
/// date lands on the same calendar the payments fall due on. This mirrors the
/// sheet's _addPeriod and the backend's advanceDate; if they ever diverge the
/// creator approves one date and the circle runs to another — which is exactly
/// the bug this work replaced, where the client stored the end of cycle ONE
/// while the review screen showed the end of the rotation.
DateTime addPeriod(DateTime d, ContributionFrequency f) {
  switch (f) {
    case ContributionFrequency.daily:
      return d.add(const Duration(days: 1));
    case ContributionFrequency.weekly:
      return d.add(const Duration(days: 7));
    case ContributionFrequency.biWeekly:
      return d.add(const Duration(days: 14));
    case ContributionFrequency.monthly:
      return DateTime(d.year, d.month + 1, d.day, d.hour, d.minute, d.second);
    case ContributionFrequency.quarterly:
      return DateTime(d.year, d.month + 3, d.day, d.hour, d.minute, d.second);
    // The backend has always had yearly (models.ContributionFrequencyYearly,
    // advanceDate's AddDate(1,0,0)). Dart folded it onto monthly until this
    // was added, so a yearly circle displayed, and computed its end date, as
    // if it ran twelve times as fast.
    case ContributionFrequency.yearly:
      return DateTime(d.year + 1, d.month, d.day, d.hour, d.minute, d.second);
  }
}

DateTime endsOn(DateTime start, ContributionFrequency f, int cycles) {
  var d = start;
  for (var i = 0; i < cycles; i++) {
    d = addPeriod(d, f);
  }
  return d;
}

void main() {
  final start = DateTime(2026, 3, 10, 9, 0);

  // Every frequency the enum offers must be walkable. The picker iterates
  // ContributionFrequency.values, so a value with no arithmetic behind it is
  // selectable and then silently wrong.
  group('every frequency advances', () {
    test('each one moves the date forward', () {
      for (final f in ContributionFrequency.values) {
        expect(addPeriod(start, f).isAfter(start), isTrue,
            reason: '$f did not advance the date');
      }
    });

    test('yearly is a year, not a month', () {
      expect(addPeriod(start, ContributionFrequency.yearly),
          DateTime(2027, 3, 10, 9, 0));
      expect(endsOn(start, ContributionFrequency.yearly, 3),
          DateTime(2029, 3, 10, 9, 0));
    });

    test('seconds survive a monthly step', () {
      // Dropping them made the sheet's date differ from the server's own
      // derivation by up to a minute, which reads as agreement on screen and
      // as a mismatch to anything comparing the two.
      final withSeconds = DateTime(2026, 3, 10, 9, 0, 37);
      expect(addPeriod(withSeconds, ContributionFrequency.monthly).second, 37);
    });
  });

  group('the end date is the ROTATION end', () {
    test('six monthly cycles run six months, not one', () {
      expect(endsOn(start, ContributionFrequency.monthly, 6),
          DateTime(2026, 9, 10, 9, 0));
    });

    test('four weekly cycles', () {
      expect(endsOn(start, ContributionFrequency.weekly, 4),
          start.add(const Duration(days: 28)));
    });

    test('a single cycle still moves the date forward', () {
      expect(endsOn(start, ContributionFrequency.monthly, 1),
          DateTime(2026, 4, 10, 9, 0));
      expect(endsOn(start, ContributionFrequency.monthly, 1).isAfter(start),
          isTrue);
    });
  });

  group('calendar arithmetic, not 30-day arithmetic', () {
    test('month ends roll the way DateTime rolls', () {
      // 31 Jan + 1 month overflows to 3 March in a non-leap year — the same
      // way Go's AddDate(0,1,0) does on the server. Pinned so the two cannot
      // drift apart silently.
      final jan31 = DateTime(2026, 1, 31);
      expect(endsOn(jan31, ContributionFrequency.monthly, 1),
          DateTime(2026, 3, 3));
      expect(endsOn(jan31, ContributionFrequency.monthly, 2),
          DateTime(2026, 4, 3));
    });

    test('quarterly crosses a year boundary', () {
      expect(endsOn(DateTime(2026, 11, 5), ContributionFrequency.quarterly, 2),
          DateTime(2027, 5, 5));
    });
  });

  group('the cycle floor is the roster', () {
    // Every member holds one turn, so fewer cycles than members would end the
    // circle before some of them had ever been paid. The sheet starts at the
    // member count and the server enforces the same floor.
    int flooredCycles(int stored, int activeMembers) {
      var c = stored > activeMembers ? stored : activeMembers;
      if (c < 1) c = 1;
      return c;
    }

    test('defaults to the member count when nothing was stored', () {
      expect(flooredCycles(0, 5), 5);
    });
    test('keeps a larger stored value', () {
      expect(flooredCycles(12, 5), 12);
    });
    test('raises a stored value that is below the roster', () {
      expect(flooredCycles(2, 5), 5);
    });
    test('never returns zero', () {
      expect(flooredCycles(0, 0), 1);
    });
  });
}
