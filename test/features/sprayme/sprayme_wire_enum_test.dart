import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';

/// lifestyle-gateway serialises THREE protobuf enums with `.String()`, which
/// emits the CONSTANT NAME rather than a value the app compares against:
///
///   sprayme_handlers_part1.go:134  "status" : s.Status.String()  -> SESSION_STATUS_ACTIVE
///   sprayme_handlers_part1.go:186  "type"   : t.Type.String()    -> TRANSACTION_TYPE_GIFT
///   sprayme_handlers_part1.go:224  "role"   : p.Role.String()    -> PARTICIPANT_ROLE_COHOST
///
/// All three were being compared against short forms ('active', 'gift',
/// 'cohost'), so all three silently failed: flags that were always false, and
/// raw enum names rendered to users. Each is now normalised at its own parse
/// boundary. These tests cover the whole class in one place.
void main() {
  group('session status', () {
    test('protobuf constant name normalises', () {
      expect(SpraySession.normalizeStatus('SESSION_STATUS_ACTIVE'), 'active');
      expect(SpraySession.normalizeStatus('SESSION_STATUS_ENDED'), 'ended');
    });
  });

  group('participant role', () {
    test('protobuf constant name normalises', () {
      expect(SessionParticipant.normalizeRole('PARTICIPANT_ROLE_HOST'), 'host');
      expect(
          SessionParticipant.normalizeRole('PARTICIPANT_ROLE_COHOST'), 'cohost');
      expect(
          SessionParticipant.normalizeRole('PARTICIPANT_ROLE_GUEST'), 'guest');
    });

    test('short form and casing still work', () {
      expect(SessionParticipant.normalizeRole('cohost'), 'cohost');
      expect(SessionParticipant.normalizeRole('  Host '), 'host');
    });

    test('null / empty / UNSPECIFIED fall back to participant', () {
      for (final raw in <String?>[null, '', '  ', 'PARTICIPANT_ROLE_UNSPECIFIED']) {
        expect(SessionParticipant.normalizeRole(raw), 'participant');
      }
    });

    SessionParticipant make(String role) => SessionParticipant.fromJson({
          'user_id': 'u1',
          'user_name': 'Ada',
          'role': role,
          'seat_state': 'seated',
        });

    test('the flags the stage UI depends on are true for wire values', () {
      // isCoHost drives whether the invite sheet offers Invite or Remove; it
      // was always false, so a co-host was offered "Invite" forever.
      expect(make('PARTICIPANT_ROLE_COHOST').isCoHost, isTrue);
      expect(make('PARTICIPANT_ROLE_HOST').isHost, isTrue);
      expect(make('PARTICIPANT_ROLE_COHOST').isBroadcaster, isTrue);
      expect(make('PARTICIPANT_ROLE_HOST').isBroadcaster, isTrue);
      expect(make('PARTICIPANT_ROLE_GUEST').isBroadcaster, isFalse);
    });

    test('seat_state is NOT normalised — it is a plain column, not an enum', () {
      final p = SessionParticipant.fromJson({
        'user_id': 'u1',
        'user_name': 'Ada',
        'role': 'PARTICIPANT_ROLE_GUEST',
        'seat_state': 'requested',
      });
      expect(p.hasRequestedSeat, isTrue);
      expect(p.isSeated, isFalse);
    });
  });

  group('transaction type', () {
    test('protobuf constant name normalises', () {
      expect(SprayTransaction.normalizeType('TRANSACTION_TYPE_GIFT'), 'gift');
      expect(SprayTransaction.normalizeType('TRANSACTION_TYPE_FUND'), 'fund');
      expect(SprayTransaction.normalizeType('TRANSACTION_TYPE_WITHDRAW'),
          'withdraw');
      expect(SprayTransaction.normalizeType('TRANSACTION_TYPE_PURCHASE'),
          'purchase');
    });

    test('SPRAY maps to the name the rest of the app already uses', () {
      expect(SprayTransaction.normalizeType('TRANSACTION_TYPE_SPRAY'),
          'money_spray');
    });

    SprayTransaction make(String type) => SprayTransaction.fromJson({
          'id': 't1',
          'type': type,
          'amount': 5000,
          'currency': 'NGN',
        });

    test('no description ever renders a raw wire value', () {
      for (final raw in [
        'TRANSACTION_TYPE_SPRAY',
        'TRANSACTION_TYPE_GIFT',
        'TRANSACTION_TYPE_FUND',
        'TRANSACTION_TYPE_WITHDRAW',
        'TRANSACTION_TYPE_PURCHASE',
        'TRANSACTION_TYPE_SOMETHING_NEW',
      ]) {
        final d = make(raw).description;
        expect(d, isNot(contains('TRANSACTION_TYPE')));
        expect(d, isNot(contains('_')));
        expect(d.trim(), isNotEmpty);
      }
    });

    test('known types read as product language', () {
      expect(make('TRANSACTION_TYPE_SPRAY').description, 'Sprayed money');
      expect(make('TRANSACTION_TYPE_FUND').description, 'Funded wallet');
      expect(make('TRANSACTION_TYPE_PURCHASE').description,
          'Bought gift credit');
    });
  });
}
