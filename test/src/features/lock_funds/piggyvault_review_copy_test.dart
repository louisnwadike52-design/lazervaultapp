import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

/// THE PENDING-REVIEW STATE HAD A BADGE AND NO WORDS.
///
/// `LockStatus.pendingApproval` existed, its chip was amber and its label read
/// "Awaiting approval" — but the sentence explaining it was never rendered
/// anywhere, and the screens around it still spoke as though the plan were
/// live. The receipt said "Your funds are now earning interest" the instant a
/// plan was created, on a platform where every plan is held for review while
/// deposits reach the asset-management company by hand. The details screen
/// showed a term percentage climbing on a term that had not started.
///
/// These assert the copy RULES, not the wording: what a sentence about
/// somebody's money is and is not allowed to claim in this state.
void main() {
  group('LockStatus copy for a plan awaiting approval', () {
    test('it is not described as earning', () {
      final copy =
          '${LockStatus.pendingApproval.displayName} '
          '${LockStatus.pendingApproval.description}'
              .toLowerCase();

      // "starts earning once approved" is allowed and present; what must
      // never appear is the present tense.
      expect(copy.contains('is earning'), isFalse);
      expect(copy.contains('now earning'), isFalse);
      expect(copy.contains('are earning'), isFalse);
    });

    test('it says the money is set aside rather than gone', () {
      final d = LockStatus.pendingApproval.description.toLowerCase();
      expect(d.contains('review'), isTrue);
      expect(
        d.contains('set aside') || d.contains('held'),
        isTrue,
        reason: 'the user has to be told why their spendable balance dropped',
      );
    });

    test('it promises no turnaround time', () {
      // A review ends when funds reach the asset company, which nothing in
      // this system can predict. Any duration here is a commitment we cannot
      // keep, and the user would hold us to it.
      final d = LockStatus.pendingApproval.description.toLowerCase();
      for (final promise in const [
        'within',
        'hours',
        'minutes',
        'business day',
        '24',
        '48',
      ]) {
        expect(d.contains(promise), isFalse,
            reason: 'review copy must not promise "$promise"');
      }
    });

    test('the active plan still says it IS earning', () {
      // The guard above must not have been satisfied by softening every
      // status. A running plan is earning, and should say so plainly.
      expect(
        LockStatus.active.description.toLowerCase().contains('earning'),
        isTrue,
      );
    });
  });

  group('the state predicates the copy depends on', () {
    test('awaiting approval is neither earning nor terminal', () {
      expect(LockStatus.pendingApproval.isEarning, isFalse);
      expect(LockStatus.pendingApproval.isTerminal, isFalse);
      expect(LockStatus.pendingApproval.awaitingDecision, isTrue);
    });

    test('no other status is treated as awaiting a decision', () {
      for (final s in LockStatus.values) {
        if (s == LockStatus.pendingApproval) continue;
        expect(s.awaitingDecision, isFalse, reason: '$s');
      }
    });

    test('only an active plan is earning', () {
      for (final s in LockStatus.values) {
        expect(s.isEarning, s == LockStatus.active, reason: '$s');
      }
    });

    test('every status has a label and an explanation', () {
      // A new status added to the enum without copy would otherwise reach a
      // user as a blank chip.
      for (final s in LockStatus.values) {
        expect(s.displayName.trim(), isNotEmpty, reason: '$s');
        expect(s.description.trim(), isNotEmpty, reason: '$s');
      }
    });
  });
}
