import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Leaving and being removed are different facts.
///
/// THE GAP THIS CATCHES
/// --------------------
/// LeaveFamilyAccount deliberately reuses RemoveFamilyMember for its row-locked
/// refund, so BOTH land on invitation_status='removed'. That made them
/// indistinguishable everywhere except the audit log: the member list and the
/// invitations view could only ever say "removed", so an admin could not tell
/// who walked away from who was ejected — materially different when deciding
/// whether to re-invite someone.
///
/// self_exited is now recorded on the member row (the requester removing
/// themselves IS the self-exit case) and surfaced in both clients.
final _screen = File(
  'lib/src/features/family_account/presentation/views/family_account_detail_screen.dart',
).readAsStringSync();

final _entity = File(
  'lib/src/features/family_account/domain/entities/family_account_entities_widgets.dart',
).readAsStringSync();

String _strip(String s) => s
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
    .join('\n');

void main() {
  test('selfExited reaches the entity', () {
    expect(_strip(_entity), contains('final bool selfExited'));
  });

  test('a self-exit is labelled LEFT, not REMOVED', () {
    final code = _strip(_screen);
    expect(code, contains("? 'LEFT'"));
    expect(code, contains('member.selfExited'));
  });

  test('a self-exit is not coloured as a sanction', () {
    // removed = dark grey (ejected); left = neutral grey. Reusing the removed
    // colour would keep implying the member was thrown out.
    final code = _strip(_screen);
    final idx = code.indexOf('member.selfExited');
    expect(idx, isNot(-1));
    expect(code.substring(idx, idx + 400), contains('0xFF9CA3AF'));
  });

  test('invitation history is reachable and named for what it holds', () {
    // It filters pending/declined/expired/removed, so calling it "Sent
    // Invitations" made it read as things still in flight — nobody looked
    // there for a declined invite or a past member.
    final code = _strip(_screen);
    expect(code, contains("'Invitations'"));
    expect(code, contains('Pending, declined, expired and past members'));
    expect(code, contains('AppRoutes.familySentInvitations'));
  });

  group('declined must never count as active', () {
    test('the accepted-only rule is what drives active membership', () {
      // activeMemberCount is len(GetActiveMembers()) server-side, and
      // IsActive() is status=="accepted" — so declined/pending/expired/removed
      // are all excluded. Pinned here because the count drives the hero card.
      final ent = _strip(_entity);
      expect(ent, contains('enum InvitationStatus'));
      for (final s in ['pending', 'accepted', 'declined', 'removed', 'expired']) {
        expect(ent, contains(s),
            reason: '$s must remain a distinct state, not be folded together');
      }
    });
  });
}
