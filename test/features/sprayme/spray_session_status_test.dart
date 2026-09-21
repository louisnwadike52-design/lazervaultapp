import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';

/// lifestyle-gateway emits `s.Status.String()`, which for a protobuf enum is the
/// CONSTANT NAME (`SESSION_STATUS_ACTIVE`), not the short form the app compared
/// against. Both `isActive` and `isEnded` were therefore ALWAYS false, which
/// silently broke four things at once: active sessions lost their Join button,
/// ended sessions lost their total, the re-entry banner could never appear, and
/// the raw enum leaked into the status pill as the fallback branch.
void main() {
  group('SpraySession.normalizeStatus', () {
    test('strips the protobuf SESSION_STATUS_ prefix', () {
      expect(SpraySession.normalizeStatus('SESSION_STATUS_ACTIVE'), 'active');
      expect(SpraySession.normalizeStatus('SESSION_STATUS_ENDED'), 'ended');
      expect(SpraySession.normalizeStatus('SESSION_STATUS_PAUSED'), 'paused');
    });

    test('accepts the short form unchanged, so a gateway fix cannot break it',
        () {
      expect(SpraySession.normalizeStatus('active'), 'active');
      expect(SpraySession.normalizeStatus('ended'), 'ended');
    });

    test('is case- and whitespace-insensitive', () {
      expect(SpraySession.normalizeStatus('  Session_Status_Active '), 'active');
      expect(SpraySession.normalizeStatus('ENDED'), 'ended');
    });

    test('null, empty and UNSPECIFIED fall back to active', () {
      // A session we cannot classify is far more likely to be live than ended,
      // and treating a live session as ended hides the way back into it.
      for (final raw in <String?>[null, '', '   ', 'SESSION_STATUS_UNSPECIFIED']) {
        expect(SpraySession.normalizeStatus(raw), 'active');
      }
    });

    test('an unknown status is preserved rather than discarded', () {
      expect(SpraySession.normalizeStatus('SESSION_STATUS_ARCHIVED'), 'archived');
    });
  });

  group('SpraySession.statusLabel', () {
    SpraySession make(String status) => SpraySession.fromJson({
          'id': 'x',
          'status': status,
          'title': 't',
          'occasion_type': 'party',
        });

    test('never renders the raw wire value', () {
      for (final raw in [
        'SESSION_STATUS_ACTIVE',
        'SESSION_STATUS_ENDED',
        'SESSION_STATUS_PAUSED',
      ]) {
        final label = make(raw).statusLabel;
        expect(label, isNot(contains('SESSION_STATUS')));
        expect(label, isNot(contains('_')));
      }
    });

    test('reads as product language', () {
      expect(make('SESSION_STATUS_ACTIVE').statusLabel, 'Live');
      expect(make('SESSION_STATUS_ENDED').statusLabel, 'Ended');
      expect(make('SESSION_STATUS_PAUSED').statusLabel, 'Paused');
    });

    test('an unmapped status is title-cased, never raw or blank', () {
      expect(make('SESSION_STATUS_ARCHIVED').statusLabel, 'Archived');
    });
  });

  group('the flags that drove the broken UI', () {
    test('a gateway-shaped active session is recognised as active', () {
      final s = SpraySession.fromJson({
        'id': 'x',
        'status': 'SESSION_STATUS_ACTIVE',
        'title': 't',
        'occasion_type': 'party',
      });
      expect(s.isActive, isTrue, reason: 'drives the Join button and the re-entry banner');
      expect(s.isEnded, isFalse);
    });

    test('a gateway-shaped ended session is recognised as ended', () {
      final s = SpraySession.fromJson({
        'id': 'x',
        'status': 'SESSION_STATUS_ENDED',
        'title': 't',
        'occasion_type': 'party',
      });
      expect(s.isEnded, isTrue, reason: 'drives the total-sprayed line');
      expect(s.isActive, isFalse);
    });
  });
}
