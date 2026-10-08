import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// A paid-out contribution must not claim it raised nothing.
///
/// Reported: a one-time contribution that had just paid out its full NGN 500
/// target showed "NGN 0 Raised", "0% Progress" and "Remaining NGN 500.00",
/// beside a banner saying it was Completed.
///
/// currentAmount is the pot's LIVE BALANCE and a payout empties it, so every
/// one of those numbers was reading a balance that is zero by definition
/// after a sweep. What a cycle raised is a fact about the cycle and survives
/// it, so the server now sends raised_this_cycle_minor and the entity
/// prefers it.
Contribution _c({required double current, required double raised}) =>
    Contribution(
      id: 'c1',
      groupId: 'g1',
      title: 'One time Travel',
      description: '',
      targetAmount: 500,
      currentAmount: current,
      raisedThisCycle: raised,
      currency: 'NGN',
      deadline: DateTime(2026, 10, 15),
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 1),
      status: ContributionStatus.completed,
      type: ContributionType.oneTime,
      createdBy: 'u1',
      payments: const [],
    );

void main() {
  group('amountRaised', () {
    test('survives the payout that empties the pot', () {
      final c = _c(current: 0, raised: 500);
      expect(c.amountRaised, 500, reason: 'the cycle did raise 500');
      expect(c.progressPercentage, 100,
          reason: 'a completed contribution showing 0% is wrong about itself');
    });

    test('falls back to the balance when the server sends nothing', () {
      // An older server omits the field, so it arrives as 0 — behaviour must
      // be exactly what it was before this existed.
      final c = _c(current: 320, raised: 0);
      expect(c.amountRaised, 320);
      expect(c.progressPercentage, 64);
    });

    test('mid-collection the two agree, so nothing visibly changes', () {
      final c = _c(current: 250, raised: 250);
      expect(c.amountRaised, 250);
      expect(c.progressPercentage, 50);
    });

    test('progress never exceeds 100 even if raised overshoots', () {
      // Overfunding is refused server-side now, but a historical row could
      // still carry it and a 140% bar would look broken.
      final c = _c(current: 0, raised: 700);
      expect(c.progressPercentage, 100);
    });

    test('a zero target does not divide by zero', () {
      final c = Contribution(
        id: 'c2',
        groupId: 'g1',
        title: 'open ended',
        description: '',
        targetAmount: 0,
        currentAmount: 0,
        raisedThisCycle: 120,
        currency: 'NGN',
        deadline: DateTime(2026, 10, 15),
        createdAt: DateTime(2026, 10, 1),
        updatedAt: DateTime(2026, 10, 1),
        status: ContributionStatus.active,
        type: ContributionType.rotatingSavings,
        createdBy: 'u1',
        payments: const [],
      );
      expect(c.progressPercentage, 0);
      expect(c.amountRaised, 120);
    });
  });
}
