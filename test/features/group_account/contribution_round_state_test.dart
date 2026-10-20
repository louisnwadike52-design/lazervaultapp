import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_round_state.dart';

// A ROUND IS ONE FULL PASS THROUGH THE MEMBERS.
//
// Cycle indices keep counting up across rounds, so a two-member circle's
// second round is cycles 3 and 4. Everything the screen decides — whether to
// offer the two choices, what the badge says, whether the circle is finished
// or merely between rounds — is derived here, so it is derived once.

void main() {
  group('round lifecycle', () {
    test('a round whose cycles have all run is awaiting a decision', () {
      const s = ContributionRoundState(
        code: ContributionRoundCode.ready,
        canStartNextRound: true,
        currentRound: 1,
        cyclesCompleted: 2,
        totalCycles: 2,
        activeMembers: 2,
      );
      expect(s.roundFinished, isTrue);
      expect(s.awaitingDecision, isTrue);
      expect(s.inProgress, isFalse);
      expect(s.cyclesRemaining, 0);
    });

    test('a running round is not awaiting anything', () {
      const s = ContributionRoundState(
        code: ContributionRoundCode.stillRunning,
        currentRound: 1,
        cyclesCompleted: 1,
        totalCycles: 3,
      );
      expect(s.roundFinished, isFalse,
          reason: 'the banner must render nothing while a round runs');
      expect(s.inProgress, isTrue);
      expect(s.cyclesRemaining, 2);
    });

    test('an ended circle is never awaiting a decision again', () {
      const s = ContributionRoundState(
        code: ContributionRoundCode.alreadyEnded,
        currentRound: 3,
        cyclesCompleted: 6,
        totalCycles: 6,
        roundsEnded: true,
      );
      expect(s.roundsEnded, isTrue);
      expect(s.roundFinished, isFalse,
          reason: 'offering "go round again" after the creator closed the '
              'circle would undo their decision');
      expect(s.awaitingDecision, isFalse);
      expect(s.inProgress, isFalse);
    });

    test('cyclesRemaining never goes negative', () {
      // A circle whose roster shrank mid-rotation can report more completed
      // cycles than the agreed total. "-1 cycles left" is not a thing to show.
      const s = ContributionRoundState(cyclesCompleted: 5, totalCycles: 3);
      expect(s.cyclesRemaining, 0);
    });

    test('an indefinite circle is neither finished nor in progress', () {
      // No agreed cycle count: it keeps rotating, so there is no round to
      // finish and no progress to report against a total.
      const s = ContributionRoundState(
        code: ContributionRoundCode.noAgreedCycles,
        cyclesCompleted: 4,
        totalCycles: 0,
      );
      expect(s.roundFinished, isFalse);
      expect(s.inProgress, isFalse);
      expect(s.cycleProgressLabel(4), isEmpty);
    });
  });

  group('labels', () {
    test('the progress label counts within the agreed total', () {
      const s = ContributionRoundState(cyclesCompleted: 2, totalCycles: 4);
      expect(s.cycleProgressLabel(3), 'Cycle 3 of 4');
    });

    test('a cycle index past the total is clamped, not printed raw', () {
      // "Cycle 5 of 4" reads as a bug to the member looking at it.
      const s = ContributionRoundState(cyclesCompleted: 4, totalCycles: 4);
      expect(s.cycleProgressLabel(5), 'Cycle 4 of 4');
    });

    test('with no cycle index it falls back to completed + 1', () {
      const s = ContributionRoundState(cyclesCompleted: 1, totalCycles: 3);
      expect(s.cycleProgressLabel(null), 'Cycle 2 of 3');
    });

    test('the round label names the round', () {
      const s = ContributionRoundState(currentRound: 2);
      expect(s.roundLabel, 'Round 2');
    });
  });

  group('codes', () {
    test('every server code maps to its own value', () {
      final wires = {
        'round_ready': ContributionRoundCode.ready,
        'round_not_rotating': ContributionRoundCode.notRotating,
        'round_no_agreed_cycles': ContributionRoundCode.noAgreedCycles,
        'round_still_running': ContributionRoundCode.stillRunning,
        'round_contribution_stopped': ContributionRoundCode.contributionStopped,
        'round_already_ended': ContributionRoundCode.alreadyEnded,
        'round_payout_in_flight': ContributionRoundCode.payoutInFlight,
        'round_pot_not_empty': ContributionRoundCode.potNotEmpty,
        'round_no_active_members': ContributionRoundCode.noActiveMembers,
      };
      wires.forEach((wire, expected) {
        expect(ContributionRoundCode.fromWire(wire), expected,
            reason: '$wire must not be read as something else');
      });
    });

    test('an unrecognised code is NOT read as ready', () {
      // The important one. A code added by a newer server read as "ready"
      // would put a button in front of an action the server is going to
      // refuse.
      for (final v in ['round_something_new', '', null, '  ']) {
        expect(ContributionRoundCode.fromWire(v),
            ContributionRoundCode.unknown,
            reason: 'unknown code $v leaked into a real value');
      }
    });

    test('the can-start flag is the server\'s, not inferred from the code', () {
      // So a build that does not recognise a newer code still shows the
      // right button, because the server already decided.
      const s = ContributionRoundState(
        code: ContributionRoundCode.unknown,
        canStartNextRound: true,
      );
      expect(s.canStartNextRound, isTrue);
    });
  });
}
