import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// The Contribute CTA was gated on `isCompleted` alone.
///
/// MakePayment refuses EVERY non-active status, each with its own sentence:
///   completed  → "it has reached its target and is now closed"
///   paused     → "it is paused — the organiser can resume it"
///   cancelled  → "it was cancelled"
///
/// so a paused or cancelled contribution still showed the button, and the
/// only way to find out was to go through the pay screen, choose an amount
/// and be refused at the end. `isCollecting` mirrors the server's own state
/// check so the two cannot disagree about what "collecting" means.

Contribution contributionWith(ContributionStatus status) => Contribution(
      id: 'c1',
      groupId: 'g1',
      title: 'Test',
      description: '',
      targetAmount: 1000,
      currentAmount: 0,
      currency: 'NGN',
      status: status,
      createdBy: 'u1',
      payments: const [],
      deadline: DateTime(2026, 12, 31),
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('only an ACTIVE contribution is collecting', () {
    expect(contributionWith(ContributionStatus.active).isCollecting, isTrue);
  });

  test('the three states the server refuses are not collecting', () {
    for (final s in [
      ContributionStatus.completed,
      ContributionStatus.paused,
      ContributionStatus.cancelled,
    ]) {
      expect(contributionWith(s).isCollecting, isFalse,
          reason: '$s still offers Contribute, and the tap is refused by '
              'MakePayment after the user has picked an amount');
    }
  });

  test('isCompleted stays narrow — it is a different question', () {
    // Other call sites ask "did this finish successfully", which is not the
    // same as "can it take money"; widening isCompleted would have changed
    // their meaning too.
    expect(contributionWith(ContributionStatus.completed).isCompleted, isTrue);
    expect(contributionWith(ContributionStatus.paused).isCompleted, isFalse);
    expect(contributionWith(ContributionStatus.cancelled).isCompleted, isFalse);
  });

  group('a rotation closed with cycles owed is not a finish', () {
    // Measured on prod 2026-10-19, "fanthom daily savings":
    //   current_cycle 1 · total_cycles 2 · cycles_completed 0
    //   status completed
    //   payout_schedules position 2 -> manual_review,
    //     "contribution status is completed (must be active)"
    // The card showed a green "Completed" over a rotation that had stopped
    // one cycle in, with a member still waiting for a turn.
    Contribution rotation({
      required ContributionStatus status,
      required int current,
      required int total,
    }) =>
        Contribution(
          id: 'c1', groupId: 'g1', title: 'fanthom daily savings',
          description: '', targetAmount: 400, currentAmount: 0,
          currency: 'NGN', deadline: DateTime(2026, 12, 31),
          createdAt: DateTime(2026, 1, 1), updatedAt: DateTime(2026, 1, 1),
          status: status, createdBy: 'u1', payments: const [],
          type: ContributionType.rotatingSavings,
          currentCycle: current, totalCycles: total,
        );

    test('THE PROD ROW reads as needing attention, not Completed', () {
      final c = rotation(
          status: ContributionStatus.completed, current: 1, total: 2);
      expect(c.hasUnrunCycles, isTrue);
      expect(c.displayState, ContributionDisplayState.stalled);
      expect(c.displayState.label, 'Needs attention');
    });

    test('a rotation that ran every cycle is NOT stalled', () {
      // A clean finish leaves the pointer on the last cycle.
      final c = rotation(
          status: ContributionStatus.completed, current: 2, total: 2);
      expect(c.hasUnrunCycles, isFalse);
      expect(c.displayState, isNot(ContributionDisplayState.stalled));
    });

    test('missing counters never accuse a contribution of being stuck', () {
      final c = Contribution(
        id: 'c1', groupId: 'g1', title: 't', description: '',
        targetAmount: 400, currentAmount: 0, currency: 'NGN',
        deadline: DateTime(2026, 12, 31), createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        status: ContributionStatus.completed, createdBy: 'u1',
        payments: const [], type: ContributionType.rotatingSavings,
      );
      expect(c.hasUnrunCycles, isFalse);
    });

    test('a one-time goal is never stalled, whatever the counters say', () {
      final c = Contribution(
        id: 'c1', groupId: 'g1', title: 't', description: '',
        targetAmount: 400, currentAmount: 0, currency: 'NGN',
        deadline: DateTime(2026, 12, 31), createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        status: ContributionStatus.completed, createdBy: 'u1',
        payments: const [], type: ContributionType.oneTime,
        currentCycle: 1, totalCycles: 2,
      );
      expect(c.displayState, isNot(ContributionDisplayState.stalled));
    });
  });
}
