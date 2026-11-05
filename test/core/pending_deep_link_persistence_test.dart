import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/notifications/pending_deep_link_store.dart';

/// A tapped transfer push must survive the app being KILLED during login.
///
/// The journey that broke: tap the push, land on the login gate, leave the app
/// to read the email OTP, OS reclaims the app, come back, log in — and the
/// in-memory stash died with the process, so the user landed on the dashboard
/// with nothing explaining why. The login this gate demands is exactly the one
/// that sends the user out of the app, so the stash was most fragile precisely
/// when it was needed.
void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PendingDeepLinkStore.prefs = SharedPreferences.getInstance;
  });

  group('link form survives a restart', () {
    test('a transfer push round-trips as a re-resolvable link', () async {
      await PendingDeepLinkStore.saveLink(
        type: 'transaction',
        data: const {
          'reference': 'TRF-12345',
          'entity_type': 'transfer',
          'entity_id': '11111111-1111-1111-1111-111111111111',
        },
        stashedAt: DateTime.now(),
        ownerUserId: null,
      );

      final back = await PendingDeepLinkStore.load();
      expect(back, isNotNull,
          reason: 'the stash did not survive — this is the reported bug');
      expect(back!.isLink, isTrue);

      final parsed = NotificationLink.parse(back.uri!);
      expect(parsed, isNotNull,
          reason: 'the persisted URI must parse back to (type, data) so the '
              'resolver — the single source of truth for mapping — rebuilds '
              'the target, rather than us serialising the target itself');
      expect(parsed!.type, 'transaction');
      expect(parsed.data['reference'], 'TRF-12345');
      expect(parsed.data['entity_type'], 'transfer');
    });

    test('empty payload values are dropped, not stored as empty ids', () async {
      await PendingDeepLinkStore.saveLink(
        type: 'transaction',
        data: const {'reference': 'TRF-1', 'amount': ''},
        stashedAt: DateTime.now(),
        ownerUserId: null,
      );
      final parsed =
          NotificationLink.parse((await PendingDeepLinkStore.load())!.uri!)!;
      expect(parsed.data.containsKey('amount'), isFalse,
          reason: 'an empty value would resolve to an empty-string id and open '
              'a blank record screen');
    });
  });

  group('route form', () {
    test('JSON-safe arguments persist', () async {
      final ok = await PendingDeepLinkStore.saveRoute(
        target: const NotificationTarget(
          route: '/group/join',
          arguments: {'token': 'abc123'},
        ),
        stashedAt: DateTime.now(),
        ownerUserId: null,
      );
      expect(ok, isTrue);

      final back = await PendingDeepLinkStore.load();
      final target = back!.toTarget();
      expect(target, isNotNull);
      expect(target!.route, '/group/join');
      expect((target.arguments as Map)['token'], 'abc123');
    });

    test('a bare String argument persists', () async {
      expect(
        await PendingDeepLinkStore.saveRoute(
          target: const NotificationTarget(
              route: '/group/details', arguments: 'group-1'),
          stashedAt: DateTime.now(),
          ownerUserId: null,
        ),
        isTrue,
      );
      expect((await PendingDeepLinkStore.load())!.toTarget()!.arguments,
          'group-1');
    });

    test('a live object is REFUSED rather than mangled', () async {
      // The transaction deep link passes a TransactionServiceType enum. jsonEncode
      // would stringify it via toString(), and we would restore a target whose
      // arguments the destination screen then rejects — a dead tap that looks
      // exactly like the bug this file exists to fix.
      expect(
        PendingDeepLinkStore.isPersistableArguments(
            {'serviceType': _NotJson()}),
        isFalse,
      );
      final ok = await PendingDeepLinkStore.saveRoute(
        target: NotificationTarget(
            route: '/transactions/open', arguments: {'x': _NotJson()}),
        stashedAt: DateTime.now(),
        ownerUserId: null,
      );
      expect(ok, isFalse,
          reason: 'better to lose the cross-restart guarantee for one target '
              'than to restore one that routes wrong');
      expect(await PendingDeepLinkStore.load(), isNull);
    });

    test('nested structures are checked all the way down', () {
      expect(
        PendingDeepLinkStore.isPersistableArguments({
          'a': [
            1,
            'two',
            {'b': true}
          ]
        }),
        isTrue,
      );
      expect(
        PendingDeepLinkStore.isPersistableArguments({
          'a': [
            {'b': _NotJson()}
          ]
        }),
        isFalse,
      );
      expect(PendingDeepLinkStore.isPersistableArguments(null), isTrue);
      // A non-String map key cannot round-trip through JSON.
      expect(PendingDeepLinkStore.isPersistableArguments({1: 'x'}), isFalse);
    });
  });

  group('ownership — a restored target must never open for another user', () {
    test('a session-captured target records its owner', () async {
      await PendingDeepLinkStore.saveLink(
        type: 'transaction',
        data: const {'reference': 'TRF-9'},
        stashedAt: DateTime.now(),
        ownerUserId: 'user-A',
      );
      expect((await PendingDeepLinkStore.load())!.ownerUserId, 'user-A',
          reason: 'without the owner, a restored target would replay into '
              'whoever logs in next on a shared device — showing one person '
              "another's transfer");
    });

    test('a target captured with NO session records no owner', () async {
      await PendingDeepLinkStore.saveLink(
        type: 'transaction',
        data: const {'reference': 'TRF-9'},
        stashedAt: DateTime.now(),
        ownerUserId: null,
      );
      expect((await PendingDeepLinkStore.load())!.ownerUserId, isNull,
          reason: 'a cold-start link belongs to whoever is opening it, so it '
              'must be replayable by the person who then logs in');
    });

    test('an empty owner string is treated as absent', () async {
      await PendingDeepLinkStore.saveLink(
        type: 'transaction',
        data: const {'reference': 'T'},
        stashedAt: DateTime.now(),
        ownerUserId: '',
      );
      expect((await PendingDeepLinkStore.load())!.ownerUserId, isNull);
    });
  });

  group('robustness — a bad record must never break startup', () {
    test('clear removes the record', () async {
      await PendingDeepLinkStore.saveLink(
        type: 't',
        data: const {'reference': 'R'},
        stashedAt: DateTime.now(),
        ownerUserId: null,
      );
      await PendingDeepLinkStore.clear();
      expect(await PendingDeepLinkStore.load(), isNull);
    });

    test('corrupt JSON loads as null instead of throwing', () async {
      SharedPreferences.setMockInitialValues(
          {'pending_deep_link_v1': '{not json'});
      expect(await PendingDeepLinkStore.load(), isNull);
    });

    test('a record with no timestamp is refused', () async {
      // No timestamp means no staleness bound — it could replay for ever.
      SharedPreferences.setMockInitialValues({
        'pending_deep_link_v1':
            jsonEncode({'form': 'link', 'uri': 'lazervault://n/transaction'}),
      });
      expect(await PendingDeepLinkStore.load(), isNull);
    });

    test('an unknown form is refused', () async {
      SharedPreferences.setMockInitialValues({
        'pending_deep_link_v1': jsonEncode({
          'form': 'something_new',
          'at': DateTime.now().toIso8601String(),
        }),
      });
      expect(await PendingDeepLinkStore.load(), isNull);
    });

    test('a route record with no route is refused', () async {
      SharedPreferences.setMockInitialValues({
        'pending_deep_link_v1': jsonEncode({
          'form': 'route',
          'route': '   ',
          'at': DateTime.now().toIso8601String(),
        }),
      });
      expect(await PendingDeepLinkStore.load(), isNull);
    });

    test('the stashed time is preserved so staleness can be judged', () async {
      final then = DateTime.now().subtract(const Duration(minutes: 42));
      await PendingDeepLinkStore.saveLink(
        type: 't',
        data: const {'reference': 'R'},
        stashedAt: then,
        ownerUserId: null,
      );
      final back = await PendingDeepLinkStore.load();
      expect(
        back!.stashedAt.difference(then).inSeconds.abs(),
        lessThan(2),
        reason: 'the restore path drops anything older than the staleness '
            'window; a wrong timestamp would either drop a live intent or '
            'replay a dead one',
      );
    });
  });
}

class _NotJson {
  @override
  String toString() => 'not-json';
}
