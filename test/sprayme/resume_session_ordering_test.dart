import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';

SpraySession s(String id, String status, {String host = 'me'}) => SpraySession(
      id: id,
      hostUserId: host,
      hostName: 'Praiz',
      title: 'Session $id',
      occasionType: 'wedding',
      sessionCode: 'ABC123',
      status: status,
      createdAt: DateTime(2026, 1, 1),
    );

/// A session you are still LIVE in is the most actionable thing on the
/// LazerSpray home screen, and it used to be possible for it to not render at
/// all: the server orders by created_at DESC with no notion of "live", and the
/// list showed only the first five. A host with six or more sessions whose live
/// one was not among the most recent had no visible way back in — the per-row
/// "Join" CTA existed, but its row never appeared.
///
/// This pins the ordering rule the home list now applies.
List<SpraySession> homeOrder(List<SpraySession> all) {
  final active = all.where((x) => x.isActive).toList();
  final past = all.where((x) => !x.isActive).toList();
  return <SpraySession>[
    ...active,
    ...past.take(5 - active.length.clamp(0, 5)),
  ];
}

void main() {
  group('home session ordering', () {
    test('a live session buried behind 6 ended ones is still shown', () {
      final all = [
        for (var i = 0; i < 6; i++) s('ended$i', 'ended'),
        s('live1', 'active'),
      ];
      final shown = homeOrder(all);
      expect(shown.map((x) => x.id), contains('live1'),
          reason: 'the resumable session must never be paged off the list');
      expect(shown.first.id, 'live1', reason: 'live sessions come first');
    });

    test('the list stays capped at five when nothing is live', () {
      final all = [for (var i = 0; i < 9; i++) s('ended$i', 'ended')];
      expect(homeOrder(all).length, 5);
    });

    test('every live session is shown, even several at once', () {
      final all = [
        s('l1', 'active'), s('l2', 'active'), s('l3', 'active'),
        for (var i = 0; i < 9; i++) s('e$i', 'ended'),
      ];
      final shown = homeOrder(all);
      expect(shown.where((x) => x.isActive).length, 3);
    });

    test('more live sessions than the cap does not produce a negative take', () {
      // take(-1) throws; the clamp is what prevents it.
      final all = [for (var i = 0; i < 7; i++) s('l$i', 'active')];
      expect(() => homeOrder(all), returnsNormally);
      expect(homeOrder(all).length, 7);
    });

    test('an empty list is handled', () {
      expect(homeOrder(const []), isEmpty);
    });
  });
}
