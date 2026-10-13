import 'package:flutter_test/flutter_test.dart';

/// Which of THREE things to tell someone who cannot read a group.
///
/// The screen modelled two — "waiting for approval" and "members only" — and
/// an invitee is neither. Reported from the dashboard's "waiting on you"
/// sheet, which routed a Group Funds invite straight at the group's own page:
/// the invitee is by definition not a member, the server refused the reads,
/// and they were shown "Your request to join has been sent" (they never sent
/// one) with a raw "not authorized" over the top.
///
/// Mirrors the branch in _buildAwaitingApprovalView.
({String title, String cta}) accessCopy({
  required bool hasPendingInvite,
  required bool awaitingApproval,
}) {
  if (hasPendingInvite) {
    return (title: 'You have an invite', cta: 'View invite');
  }
  if (awaitingApproval) {
    return (title: 'Waiting for approval', cta: 'Check again');
  }
  return (title: 'Members only', cta: 'Check again');
}

void main() {
  group('what a non-member is told', () {
    test('an invitee is told they were invited, and where to go', () {
      final c = accessCopy(hasPendingInvite: true, awaitingApproval: false);
      expect(c.title, 'You have an invite');
      expect(c.cta, 'View invite');
    });

    test('an invite OUTRANKS a join request', () {
      // Both can be true: somebody asked to join and was separately invited.
      // Accepting is immediate and theirs to do; waiting is not.
      final c = accessCopy(hasPendingInvite: true, awaitingApproval: true);
      expect(c.title, 'You have an invite');
      expect(c.cta, 'View invite',
          reason: 'never offer "check again" to someone who can act now');
    });

    test('a join request still says waiting', () {
      final c = accessCopy(hasPendingInvite: false, awaitingApproval: true);
      expect(c.title, 'Waiting for approval');
    });

    test('no invite and no request is members-only', () {
      final c = accessCopy(hasPendingInvite: false, awaitingApproval: false);
      expect(c.title, 'Members only');
    });

    test('an invitee is never told they sent a request', () {
      final c = accessCopy(hasPendingInvite: true, awaitingApproval: true);
      expect(c.title.toLowerCase(), isNot(contains('approval')));
      expect(c.title.toLowerCase(), isNot(contains('request')));
    });
  });
}
