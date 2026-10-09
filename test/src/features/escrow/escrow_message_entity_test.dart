import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_message_entity.dart';

/// Who said what, on the thread a dispute is decided from.
///
/// The escrow conversation is scoped to a DEAL rather than being the
/// parties' general direct-message thread, so that support can read exactly
/// the conversation about the money in question. Which means the UI has to
/// get attribution right: a support message that looks like it came from
/// the counterparty, in a dispute, is actively misleading.
EscrowMessageEntity _m({
  String senderId = 'u1',
  String role = 'buyer',
  String name = 'Ada',
}) =>
    EscrowMessageEntity(
      id: 'm1',
      dealId: 'd1',
      senderId: senderId,
      senderRole: role,
      senderName: name,
      body: 'hello',
      createdAt: DateTime(2026, 10, 9),
    );

void main() {
  group('isMine', () {
    test('compares the SENDER ID, not the role', () {
      // Both parties on a deal where the viewer is the buyer: aligning by
      // role would put the counterparty's messages on the viewer's own side
      // whenever they happened to share one.
      expect(_m(senderId: 'u1').isMine('u1'), true);
      expect(_m(senderId: 'u2').isMine('u1'), false);
    });

    test('a platform message is never "mine"', () {
      // An admin message carries no party id. An empty senderId must not
      // match an empty viewer id and render as the viewer's own.
      final admin = _m(senderId: '', role: 'admin', name: 'LazerVault Support');
      expect(admin.isMine(''), false,
          reason: 'an unidentified viewer must not own the platform message');
      expect(admin.isMine('u1'), false);
    });

    test('an unidentified viewer owns nothing', () {
      expect(_m(senderId: 'u1').isMine(''), false);
    });
  });

  group('isFromAdmin', () {
    test('only the admin role', () {
      expect(_m(role: 'admin').isFromAdmin, true);
      expect(_m(role: 'buyer').isFromAdmin, false);
      expect(_m(role: 'seller').isFromAdmin, false);
      // An unknown role from a newer server must not be promoted to admin —
      // that would give it the platform's authority on the record.
      expect(_m(role: 'moderator').isFromAdmin, false);
      expect(_m(role: '').isFromAdmin, false);
    });
  });
}
