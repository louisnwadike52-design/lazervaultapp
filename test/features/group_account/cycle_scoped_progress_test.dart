import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/cycle_scoped_progress.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// A NEW CYCLE SHOWED THE OLD CYCLE'S PAYERS.
///
/// Reported from production: after a rotation advanced to cycle 2, the
/// statistics widget still read "2 fully paid" — those two had paid for cycle
/// 1, and nobody had paid anything into cycle 2. The Payments tab had the same
/// fault from the same cause: both folded the contribution's LIFETIME payment
/// list, while the share they compared against is PER CYCLE.
///
/// The per-cycle truth already lives on the member and the server maintains
/// both edges of it — a completed payment adds to cycle_paid_amount and flips
/// has_paid_current_cycle; the rotation advance resets both for every ACTIVE
/// member. The screen simply was not reading it.

ContributionMember member({
  required String id,
  required bool hasPaid,
  double cyclePaid = 0,
  ContributionMembershipStatus status = ContributionMembershipStatus.active,
}) =>
    ContributionMember(
      id: id,
      contributionId: 'c1',
      userId: id,
      userName: 'Member $id',
      email: '$id@example.com',
      joinedAt: DateTime(2026, 10, 1),
      totalPaid: 0,
      expectedAmount: 200,
      hasPaidCurrentCycle: hasPaid,
      cyclePaidAmount: cyclePaid,
      missedCycles: 0,
      membershipStatus: status,
    );

ContributionPayment payment({
  required String id,
  String? txn,
  required DateTime at,
}) =>
    ContributionPayment(
      id: id,
      contributionId: 'c1',
      groupId: 'g1',
      userId: 'u1',
      userName: 'Member',
      amount: 200,
      currency: 'NGN',
      paymentDate: at,
      status: PaymentStatus.completed,
      transactionId: txn,
    );

void main() {
  group('the reported case', () {
    test('a fresh cycle reads zero, however much was paid last cycle', () {
      // Exactly the prod shape: the server has reset both per-cycle fields,
      // so every member reads as unpaid for the new cycle.
      final p = cycleProgressFromMembers([
        member(id: 'a', hasPaid: false),
        member(id: 'b', hasPaid: false),
        member(id: 'c', hasPaid: false),
      ]);
      expect(p.fullyPaid, 0, reason: '"2 fully paid" was the bug');
      expect(p.partial, 0);
      expect(p.contributors, 0);
      expect(p.collected, 0);
      expect(p.awaiting, 3);
      expect(p.everyoneHasPaid, isFalse);
    });

    test('it counts this cycle as members pay into it', () {
      final p = cycleProgressFromMembers([
        member(id: 'a', hasPaid: true, cyclePaid: 200),
        member(id: 'b', hasPaid: false, cyclePaid: 50),
        member(id: 'c', hasPaid: false),
      ]);
      expect(p.fullyPaid, 1);
      expect(p.partial, 1);
      expect(p.contributors, 2);
      expect(p.awaiting, 1);
      expect(p.collected, 250);
    });
  });

  group('who is taking part', () {
    test('a pending invite is not a member of this cycle', () {
      // Mirrors the server, which excludes pending_invite shadows from the
      // pot maths. Counting them would make the denominator — and so every
      // member's share — wrong.
      final p = cycleProgressFromMembers([
        member(id: 'a', hasPaid: true, cyclePaid: 200),
        member(
            id: 'ghost',
            hasPaid: false,
            status: ContributionMembershipStatus.pendingInvite),
        member(
            id: 'no',
            hasPaid: false,
            status: ContributionMembershipStatus.declined),
      ]);
      expect(p.activeMembers, 1);
      expect(p.everyoneHasPaid, isTrue,
          reason: 'the one participating member has paid');
    });

    test('an empty circle has not "everyone paid"', () {
      expect(cycleProgressFromMembers(const []).everyoneHasPaid, isFalse);
      expect(CycleProgress.empty.everyoneHasPaid, isFalse);
    });
  });

  group('merging the cycle list with what this device just paid', () {
    final t0 = DateTime(2026, 10, 19, 10);
    test('newest first, with the local payment visible immediately', () {
      final merged = mergeCyclePayments(
        local: [payment(id: 'local-1', at: t0.add(const Duration(minutes: 5)))],
        cycle: [payment(id: 'srv-1', at: t0)],
      );
      expect(merged.map((p) => p.id), ['local-1', 'srv-1']);
    });

    test('a local row does not double up with its persisted copy', () {
      // Same payment, two identities: the optimistic local row and the one
      // the server now reports. Matching on the transaction id is what stops
      // the member seeing their single payment twice.
      final merged = mergeCyclePayments(
        local: [payment(id: 'local-1', txn: 'TX-9', at: t0)],
        cycle: [payment(id: 'srv-1', txn: 'TX-9', at: t0)],
      );
      expect(merged.length, 1);
      expect(merged.single.id, 'srv-1', reason: 'the server row is canonical');
    });

    test('nothing paid into this cycle yet is empty, not last cycle', () {
      expect(mergeCyclePayments(local: const [], cycle: const []), isEmpty);
    });
  });

  group('the screen reads the cycle, not the lifetime log', () {
    final src = File(
      'lib/src/features/group_account/presentation/views/'
      'contribution_details_screen.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('statistics come from the members, not a payment fold', () {
      expect(src, contains('cycleProgressFromMembers(contribution.members)'));
      expect(src, isNot(contains('for (final p in contribution.payments)')),
          reason: 'that fold is what counted last cycle\'s payers');
    });

    test('the payments tab reads the current cycle', () {
      expect(src, contains('mergeCyclePayments('));
      expect(src, contains('cycle: cycle.payments'));
    });

    test('it reloads when the cycle turns and when a payment lands', () {
      expect(src, contains('_loadCurrentCycleView(state.contribution)'));
      expect(src, contains('_loadCurrentCycleView(paid, force: true)'));
    });
  });
}
