import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// The roster said "2 members assigned" while the Start tile two inches above
/// said "Needs 1 more member", and both were reading the same list.
///
/// A `pending_invite` row is a contribution_members row like any other, so
/// counting rows counted people who had been ASKED. The Start gate counted
/// people who had ACCEPTED, which is the only count that can legally start a
/// rotation. Neither number was wrong on its own; showing them side by side
/// without saying which was which is what made the screen contradict itself.
///
/// This pins the two questions apart at the level they are actually asked,
/// because the screen asks both and they have different answers.
ContributionMember _member(String id, ContributionMembershipStatus status) =>
    ContributionMember(
      id: id,
      contributionId: 'c1',
      userId: 'user-$id',
      userName: 'User $id',
      email: '$id@example.com',
      joinedAt: DateTime.now(),
      membershipStatus: status,
    );

void main() {
  final roster = [
    _member('praiz', ContributionMembershipStatus.active),
    _member('chris', ContributionMembershipStatus.pendingInvite),
    _member('ella', ContributionMembershipStatus.pendingInvite),
    _member('gone', ContributionMembershipStatus.declined),
  ];

  group('who is actually in the contribution', () {
    test('only accepted members count as participants', () {
      expect(roster.where((m) => m.isActiveParticipant).length, 1,
          reason: 'exactly one person has accepted');
    });

    test('invited-but-not-accepted is its own state, not membership', () {
      expect(roster.where((m) => m.isPendingInvite).length, 2);
      // The bug was that these two answered the SAME question as above.
      for (final m in roster.where((m) => m.isPendingInvite)) {
        expect(m.isActiveParticipant, isFalse,
            reason: 'a pending invite must never read as a participant');
      }
    });

    test('an esusu needing two accepted members is NOT satisfied by invites',
        () {
      const minToStart = 2;
      final accepted = roster.where((m) => m.isActiveParticipant).length;
      final onRoster = roster
          .where((m) => m.membershipStatus != ContributionMembershipStatus.declined)
          .length;

      expect(onRoster >= minToStart, isTrue,
          reason: 'row count alone looks sufficient — this is the trap');
      expect(accepted >= minToStart, isFalse,
          reason: 'but the circle genuinely cannot start');
    });

    test('declined rows are neither, so they must not block a re-invite', () {
      final declined = roster
          .where((m) => m.membershipStatus == ContributionMembershipStatus.declined);
      expect(declined.length, 1);
      for (final m in declined) {
        expect(m.isActiveParticipant, isFalse);
        expect(m.isPendingInvite, isFalse);
      }
    });
  });
}
