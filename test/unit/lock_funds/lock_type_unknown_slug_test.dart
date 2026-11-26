import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

/// THE ENUM DOES NOT KNOW EVERY PLAN, AND MUST NOT PRETEND TO.
///
/// `LockType` carries three slugs — savings, investment, goal_based — while
/// plans are rows an admin creates. Half-Year Lock ships as `half_year` and is
/// one of only TWO active plans in production, so the gap is not theoretical:
/// it is the plan in front of most users.
///
/// selectConfig falls back to `LockType.savings` for an unknown slug, which is
/// fine for identity (the create call sends the config id) and wrong for
/// anything else — so every capability must be read from the selected config,
/// never from the enum. These pin the half of that contract that can be
/// tested without a cubit.
void main() {
  group('slugs the enum knows', () {
    test('map to their own value', () {
      expect(LockTypeX.fromBackendKey('savings'), LockType.savings);
      expect(LockTypeX.fromBackendKey('investment'), LockType.investment);
      expect(LockTypeX.fromBackendKey('goal_based'), LockType.goalBased);
    });

    test('round-trip through backendKey', () {
      for (final t in LockType.values) {
        expect(LockTypeX.fromBackendKey(t.backendKey), t,
            reason: '${t.backendKey} did not survive a round trip');
      }
    });

    test('are matched case- and space-insensitively', () {
      expect(LockTypeX.fromBackendKey('  GOAL_BASED '), LockType.goalBased);
    });
  });

  group('slugs the enum does NOT know', () {
    test('half_year — an ACTIVE production plan — returns null', () {
      // Returning null is correct: it is honest about not knowing. The danger
      // was never here, it was in callers treating the savings fallback as
      // this plan's capabilities.
      expect(LockTypeX.fromBackendKey('half_year'), isNull);
    });

    test('any future admin-created slug returns null, not a wrong guess', () {
      for (final slug in ['quarter_year', 'treasury_90', 'ramadan_lock', '']) {
        expect(LockTypeX.fromBackendKey(slug), isNull, reason: slug);
      }
    });

    test('null is distinguishable from savings', () {
      // If this ever stopped being null and started returning savings, the
      // fallback would become invisible and a Half-Year deposit would be
      // validated against Flex Savings' ₦100 minimum instead of ₦1,000 —
      // which is exactly what happened before getConfigForType was fixed.
      expect(LockTypeX.fromBackendKey('half_year'),
          isNot(equals(LockType.savings)));
    });
  });
}
