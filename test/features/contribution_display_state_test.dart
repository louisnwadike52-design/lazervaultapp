import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// `status == completed` meant two different things and the card showed one
/// word for both: a goal that reached its target, and one the scheduler
/// closed at its deadline with the target unmet. They are not the same
/// outcome to the people who funded it.
Contribution _c({
  required ContributionStatus status,
  double target = 1000,
  double current = 0,
  double raised = 0,
  bool paidOut = false,
  Duration deadlineIn = const Duration(days: 7),
}) {
  final now = DateTime.now();
  return Contribution(
    id: 'c1',
    groupId: 'g1',
    title: 'Goal',
    description: '',
    targetAmount: target,
    currentAmount: current,
    raisedThisCycle: raised,
    currency: 'NGN',
    deadline: now.add(deadlineIn),
    createdAt: now,
    updatedAt: now,
    status: status,
    createdBy: 'u1',
    payments: const [],
    paidOut: paidOut,
  );
}

void main() {
  group('Contribution.displayState', () {
    test('an active goal before its deadline is Active', () {
      expect(_c(status: ContributionStatus.active).displayState,
          ContributionDisplayState.active);
    });

    test('an active goal past its deadline is Overdue, not Closed', () {
      // Still open: members can pay, the scheduler has not run yet. Calling
      // it Closed would tell them not to bother.
      final s = _c(
        status: ContributionStatus.active,
        deadlineIn: const Duration(days: -1),
      ).displayState;
      expect(s, ContributionDisplayState.overdue);
      expect(s.isTerminal, isFalse);
    });

    test('completed with the target met is Completed', () {
      expect(
        _c(status: ContributionStatus.completed, raised: 1000).displayState,
        ContributionDisplayState.completed,
      );
    });

    test('completed with the target UNMET is Closed', () {
      // The deadline arrived and the scheduler closed it. "Completed" would
      // claim something that did not happen.
      expect(
        _c(
          status: ContributionStatus.completed,
          raised: 400,
          deadlineIn: const Duration(days: -1),
        ).displayState,
        ContributionDisplayState.closed,
      );
    });

    test('a settled payout wins over both', () {
      // The strongest statement available: the money has actually reached
      // the recipient, which neither of the other two says.
      expect(
        _c(status: ContributionStatus.completed, raised: 1000, paidOut: true)
            .displayState,
        ContributionDisplayState.paidOut,
      );
      expect(
        _c(status: ContributionStatus.completed, raised: 100, paidOut: true)
            .displayState,
        ContributionDisplayState.paidOut,
      );
    });

    test('target is measured against RAISED, not the live balance', () {
      // A payout empties the pot. A fully funded goal does not stop having
      // been fully funded because the money has gone where it was meant to.
      final swept = _c(
        status: ContributionStatus.completed,
        raised: 1000,
        current: 0,
      );
      expect(swept.targetMet, isTrue);
      expect(swept.displayState, ContributionDisplayState.completed);
    });

    test('paused and cancelled pass straight through', () {
      expect(_c(status: ContributionStatus.paused).displayState,
          ContributionDisplayState.paused);
      expect(_c(status: ContributionStatus.cancelled).displayState,
          ContributionDisplayState.cancelled);
    });

    test('terminal states are the ones that mean "this is over"', () {
      expect(ContributionDisplayState.completed.isTerminal, isTrue);
      expect(ContributionDisplayState.closed.isTerminal, isTrue);
      expect(ContributionDisplayState.paidOut.isTerminal, isTrue);
      expect(ContributionDisplayState.cancelled.isTerminal, isTrue);
      expect(ContributionDisplayState.active.isTerminal, isFalse);
      expect(ContributionDisplayState.overdue.isTerminal, isFalse);
      expect(ContributionDisplayState.paused.isTerminal, isFalse);
    });

    test('every state has a label', () {
      for (final s in ContributionDisplayState.values) {
        expect(s.label, isNotEmpty, reason: '$s has no badge text');
      }
    });

    test('a zero target cannot be "met"', () {
      // Guards the progress maths too: target 0 would otherwise divide badly
      // and report 100% on a goal with no goal.
      expect(_c(status: ContributionStatus.completed, target: 0).targetMet,
          isFalse);
    });
  });
}
