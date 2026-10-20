import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_edit_rules.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// CYCLES MUST COME IN FULL ROUNDS, OR SOMEONE FUNDS SOMEBODY ELSE'S TURN.
///
/// A rotation hands the pot to ONE member per cycle. With 2 members and 3
/// cycles one of them collects twice while the other collects once — and both
/// paid in three times. That is not a rounding problem; it is one member
/// funding another, and it is the exact shape of the fanthom incident where
/// one member took both turns of a two-cycle circle.
void main() {
  dialogRules();
  group('cycles must be a whole number of rounds', () {
    test('a multiple of the member count is accepted', () {
      for (final c in [2, 4, 6, 20]) {
        expect(
          ContributionEditRules.validateCycles(cycles: c, activeMembers: 2),
          isNull,
          reason: '$c cycles over 2 members is ${c ~/ 2} full rounds',
        );
      }
    });

    test('a non-multiple is refused', () {
      expect(
        ContributionEditRules.validateCycles(cycles: 3, activeMembers: 2),
        isNotNull,
        reason: '3 cycles over 2 members gives one member two turns',
      );
    });

    test('the refusal names the nearest allowed values, not just "invalid"', () {
      // A creator told "invalid" has to guess, and the guess is the thing we
      // already know.
      final msg =
          ContributionEditRules.validateCycles(cycles: 5, activeMembers: 3)!;
      expect(msg, contains('3 or 6'));
      expect(msg, contains('3 members'));
    });

    test('below one full round it offers only the round up', () {
      // "Try 0 or 3" would be nonsense; 0 cycles is not a circle.
      final msg =
          ContributionEditRules.validateCycles(cycles: 2, activeMembers: 3)!;
      expect(msg, contains('3'));
      expect(msg, isNot(contains('0 or')));
    });

    test('zero or missing is refused with a plain ask', () {
      for (final c in [null, 0, -1]) {
        expect(
          ContributionEditRules.validateCycles(cycles: c, activeMembers: 2),
          isNotNull,
        );
      }
    });

    test('with no active members the rule does not fire', () {
      // There is nothing to divide by, and the circle has a different problem
      // — blocking the cycle field would hide it behind the wrong message.
      expect(
        ContributionEditRules.validateCycles(cycles: 3, activeMembers: 0),
        isNull,
      );
    });

    test('rounds are reported only for a valid count', () {
      expect(ContributionEditRules.roundsFor(cycles: 6, activeMembers: 3), 2);
      expect(ContributionEditRules.roundsFor(cycles: 5, activeMembers: 3),
          isNull);
    });
  });

  group('the target of a rotation is derived, not typed', () {
    test('only a rotation derives it', () {
      expect(
          ContributionEditRules.targetIsDerived(
              ContributionType.rotatingSavings),
          isTrue);
      expect(
          ContributionEditRules.targetIsDerived(ContributionType.oneTime),
          isFalse,
          reason: 'a one-time pot has a goal the creator genuinely chooses');
    });

    test('it is one pot per cycle', () {
      // 2 members x NGN 200 = NGN 400 a cycle; 2 cycles = NGN 800. Exactly
      // fanthom's numbers.
      expect(
        ContributionEditRules.derivedTargetMinor(
            regularAmountMinor: 20000, activeMembers: 2, cycles: 2),
        80000,
      );
    });

    test('a missing input yields null rather than a confident zero', () {
      // The caller then shows the STORED value instead of overwriting a real
      // figure with 0.
      expect(
        ContributionEditRules.derivedTargetMinor(
            regularAmountMinor: null, activeMembers: 2, cycles: 2),
        isNull,
      );
      expect(
        ContributionEditRules.derivedTargetMinor(
            regularAmountMinor: 20000, activeMembers: 0, cycles: 2),
        isNull,
      );
      expect(
        ContributionEditRules.derivedTargetMinor(
            regularAmountMinor: 20000, activeMembers: 2, cycles: null),
        isNull,
      );
    });
  });

  group('only active members hold a turn', () {
    ContributionMember member(ContributionMembershipStatus s) =>
        ContributionMember(
          id: 'm',
          contributionId: 'c',
          userId: 'u',
          userName: 'n',
          email: 'e',
          joinedAt: DateTime(2026),
          totalPaid: 0,
          expectedAmount: 0,
          hasPaidCurrentCycle: false,
          membershipStatus: s,
        );

    test('invitees and decliners are not counted', () {
      // Counting a shadow row widens the pot and the cycle count, which is
      // how a circle ends up with a slot nobody can fill — live on prod,
      // `alert Rosca` holds rotation position 3 for an invitee who declined.
      final members = [
        member(ContributionMembershipStatus.active),
        member(ContributionMembershipStatus.active),
        member(ContributionMembershipStatus.pendingInvite),
        member(ContributionMembershipStatus.declined),
      ];
      expect(ContributionEditRules.activeMemberCount(members), 2);
    });

    test('an empty roster counts nobody', () {
      expect(ContributionEditRules.activeMemberCount(const []), 0);
    });
  });
}

/// THE CHANGE-CYCLES DIALOG MUST REFUSE BEFORE THE SERVER DOES.
///
/// Prod 2026-10-20: entering 3 cycles for a 2-member circle passed the dialog,
/// hit the server, and came back as "Network error. Please check your
/// connection and try again." — with the keyboard still up, covering the
/// screen. The connection was fine; the number was the problem, and the
/// server's own sentence said so before it was flattened into a generic line.
void dialogRules() {
  group('the dialog validates what the server validates', () {
    test('the fanthom case is refused client-side', () {
      // 2 active members, 3 cycles: one member collects twice, the other once,
      // and both paid in three times.
      expect(
        ContributionEditRules.validateCycles(cycles: 3, activeMembers: 2),
        isNotNull,
      );
    });

    test('and the refusal names what to type instead', () {
      final msg =
          ContributionEditRules.validateCycles(cycles: 3, activeMembers: 2)!;
      expect(msg, contains('2 or 4'));
    });

    test('a valid extension passes', () {
      for (final n in [2, 4, 6]) {
        expect(
          ContributionEditRules.validateCycles(cycles: n, activeMembers: 2),
          isNull,
        );
      }
    });

    test('shadow rows do not change the rule', () {
      // The dialog counted contribution.members.length, which includes an
      // invitee who never accepted and one who declined — so it demanded a
      // count the server would then refuse.
      final roster = [
        _m(ContributionMembershipStatus.active),
        _m(ContributionMembershipStatus.active),
        _m(ContributionMembershipStatus.pendingInvite),
        _m(ContributionMembershipStatus.declined),
      ];
      final active = ContributionEditRules.activeMemberCount(roster);
      expect(active, 2);
      expect(ContributionEditRules.validateCycles(cycles: 4, activeMembers: active),
          isNull);
      expect(ContributionEditRules.validateCycles(cycles: 3, activeMembers: active),
          isNotNull);
    });
  });
}

ContributionMember _m(ContributionMembershipStatus s) => ContributionMember(
      id: 'm',
      contributionId: 'c',
      userId: 'u',
      userName: 'n',
      email: 'e',
      joinedAt: DateTime(2026),
      totalPaid: 0,
      expectedAmount: 0,
      hasPaidCurrentCycle: false,
      membershipStatus: s,
    );
