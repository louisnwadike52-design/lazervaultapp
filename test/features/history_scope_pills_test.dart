import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/history/history_scope_pills.dart';

void main() {
  // The operator's posture today: local only. Every assertion below is written
  // from the user's point of view, not the code's.
  bool localOnly(String s) => s == 'buy' || s == 'local';
  bool everything(String s) => true;

  group('a filter that cannot discriminate is not shown', () {
    test('AIRTIME with only Buy active renders no pills at all', () {
      // Not "All + Buy": those select identical rows, so the row would imply a
      // choice the user does not have.
      final pills = historyScopePills(
        candidates: const ['buy', 'international', 'sell'],
        isAllowed: localOnly,
      );
      expect(pills, isEmpty);
    });

    test('DATA with only Local active renders no pills at all', () {
      final pills = historyScopePills(
        candidates: const ['local', 'international'],
        isAllowed: localOnly,
      );
      expect(pills, isEmpty);
    });

    test('nothing active also renders nothing, without throwing', () {
      expect(
        historyScopePills(candidates: const ['local', 'international'], isAllowed: (_) => false),
        isEmpty,
      );
    });

    test('no candidates at all renders nothing', () {
      expect(historyScopePills(candidates: const [], isAllowed: everything), isEmpty);
    });
  });

  group('the pills come back when the admin turns a scope on', () {
    test('DATA: enabling International brings back All / Local / International', () {
      expect(
        historyScopePills(
          candidates: const ['local', 'international'],
          isAllowed: everything,
        ),
        equals(['all', 'local', 'international']),
      );
    });

    test('AIRTIME: all three scopes give All / Buy / International / Sell', () {
      expect(
        historyScopePills(
          candidates: const ['buy', 'international', 'sell'],
          isAllowed: everything,
        ),
        equals(['all', 'buy', 'international', 'sell']),
      );
    });

    test('AIRTIME: International off but Sell on still needs a row', () {
      // Two real scopes remain, so "All" is now meaningful again.
      expect(
        historyScopePills(
          candidates: const ['buy', 'international', 'sell'],
          isAllowed: (s) => s != 'international',
        ),
        equals(['all', 'buy', 'sell']),
      );
    });

    test('display order follows the candidate order, not the allow order', () {
      expect(
        historyScopePills(
          candidates: const ['buy', 'international', 'sell'],
          isAllowed: (s) => s == 'sell' || s == 'buy',
        ),
        equals(['all', 'buy', 'sell']),
      );
    });
  });

  group('a stale deep link cannot strand the user on a dead scope', () {
    test('an intl deep link falls back to All once International is closed', () {
      // The case that bites: a View All link or notification from before the
      // operator closed International. Without this the screen opens filtered
      // to a scope with no pill to deselect — an empty list with no way out.
      final pills = historyScopePills(
        candidates: const ['local', 'international'],
        isAllowed: localOnly,
      );
      expect(resolveHistoryScope('intl', pills), equals('all'));
      expect(resolveHistoryScope('international', pills), equals('all'));
    });

    test('a scope that is still selectable is kept', () {
      final pills = historyScopePills(
        candidates: const ['local', 'international'],
        isAllowed: everything,
      );
      expect(resolveHistoryScope('international', pills), equals('international'));
      expect(resolveHistoryScope('local', pills), equals('local'));
    });

    test('All is always selectable, even with no pills', () {
      expect(scopeStillSelectable('all', const []), isTrue);
      expect(resolveHistoryScope('all', const []), equals('all'));
    });

    test('an unknown scope falls back rather than filtering to nothing', () {
      expect(resolveHistoryScope('nonsense', const ['all', 'local', 'international']),
          equals('all'));
    });
  });
}
