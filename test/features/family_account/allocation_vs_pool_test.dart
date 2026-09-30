import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// A family account runs two completely different ways and the card must not
/// conflate them.
///
///   shared_pool        — nobody has an allocation; everyone spends the pool,
///                        so the pool IS the member's spendable balance.
///   equal_split /      — each member has their own allocated balance and can
///   custom_allocation    spend only that. The pool is what has NOT been handed
///                        out, and is not theirs to spend.
///
/// Showing the pool in the second case tells a member they have money the
/// backend's spend gate will refuse.
AccountSummaryEntity family({
  required String mode,
  double? allocated,
  double? remaining,
  double pool = 0,
}) =>
    AccountSummaryEntity.familyAccount(
      id: 'fam-1',
      currency: 'NGN',
      totalBalance: pool + (allocated ?? 0),
      memberAllocatedBalance: allocated,
      memberRemainingBalance: remaining,
      poolBalance: pool,
      memberCount: 3,
      allowMemberContributions: true,
      trendPercentage: 0,
      familyAccountId: 'fam-1',
      familyStatus: 'active',
      fundDistributionMode: mode,
    );

void main() {
  group('which balance the card shows', () {
    test('shared_pool shows the POOL — nobody has an allocation', () {
      final a = family(mode: 'shared_pool', pool: 1550);
      expect(a.balance, 1550);
    });

    test('allocation mode shows the member REMAINING, not the pool', () {
      // ₦5,000 allocated, ₦1,200 spent today, ₦20,000 sitting unallocated.
      final a = family(
          mode: 'custom_allocation',
          allocated: 5000,
          remaining: 3800,
          pool: 20000);
      expect(a.balance, 3800,
          reason: 'the spend gate enforces allocated minus spent today; the '
              'card must not promise the gross allocation or the pool');
    });

    test('equal_split behaves the same as custom_allocation', () {
      final a =
          family(mode: 'equal_split', allocated: 2000, remaining: 2000, pool: 9);
      expect(a.balance, 2000);
    });

    test('a fully-spent allocation reads zero, not the pool', () {
      final a = family(
          mode: 'custom_allocation', allocated: 5000, remaining: 0, pool: 20000);
      expect(a.balance, 0,
          reason: 'falling back to the pool here would invite a spend that is '
              'certain to be refused');
    });

    test('no member row falls back to the pool rather than a blank card', () {
      // An admin view, or a stale cache.
      final a = family(mode: 'custom_allocation', pool: 700);
      expect(a.balance, 700);
    });
  });
}
