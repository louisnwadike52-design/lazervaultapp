import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The persistence and replay fix is only as good as its wiring. Each of these
/// asserts one connection that, if quietly removed, restores the original bug
/// with no test failing anywhere near it.
void main() {
  late String navigator;
  late String main;
  late String observer;

  setUpAll(() {
    navigator =
        File('lib/core/notifications/notification_navigator.dart').readAsStringSync();
    main = File('lib/main.dart').readAsStringSync();
    observer =
        File('lib/core/notifications/deep_link_replay_observer.dart').readAsStringSync();
  });

  test('the stash is restored at startup', () {
    expect(
      main.contains('PendingDeepLink.instance.restore()'),
      isTrue,
      reason: 'nothing reloads the stash the previous process was killed '
          'holding, so a tap that survived to disk is never replayed — the '
          'reported bug, back in full',
    );
  });

  test('restore runs AFTER the push handler is wired', () {
    final handler = main.indexOf('pushSvc.onMessageTap =');
    final restore = main.indexOf('PendingDeepLink.instance.restore()');
    expect(handler, greaterThan(-1));
    expect(restore, greaterThan(-1));
    expect(
      restore,
      greaterThan(handler),
      reason: "this process's own tap is fresher than the last process's "
          'leftovers and must win; restore() only no-ops correctly if the '
          'live tap has already had its chance to stash',
    );
  });

  test('restore refuses to clobber a target already held in memory', () {
    final at = navigator.indexOf('Future<void> restore()');
    expect(at, greaterThan(-1), reason: 'restore() is gone');
    final body = navigator.substring(at, at + 400);
    expect(
      body.contains('if (_pending != null) return'),
      isTrue,
      reason: 'a restored (older) target would overwrite the tap the user just '
          'made in this process',
    );
  });

  test('restore honours the same staleness window as the memory stash', () {
    final at = navigator.indexOf('Future<void> restore()');
    final body = navigator.substring(at, at + 900);
    expect(
      body.contains('_staleAfter'),
      isTrue,
      reason: 'without it, a persisted intent from days ago would yank the '
          'user to a stale receipt on some unrelated future launch',
    );
  });

  test('an unknown type in a restored link still opens the feed', () {
    final at = navigator.indexOf('Future<void> restore()');
    final body = navigator.substring(at, at + 1600);
    expect(
      body.contains('AppRoutes.notificationsFeed'),
      isTrue,
      reason: 'an older app meeting a newer server must still show what '
          'buzzed, exactly as handleOrFeed does for a live tap — otherwise a '
          'restored tap dies silently',
    );
  });

  test('the replay observer is registered on the navigator', () {
    expect(
      main.contains('deepLinkReplayObserver'),
      isTrue,
      reason: 'replay falls back to depending on the dashboard being the first '
          'authenticated screen, which it is not when login lands on KYC, a '
          'forced update, or a fraud freeze',
    );
    expect(main.contains('navigatorObservers: [appRouteObserver'), isTrue,
        reason: 'the existing observer must not be dropped to add the new one');
  });

  test('the observer defers a frame before navigating', () {
    expect(
      observer.contains('addPostFrameCallback'),
      isTrue,
      reason: 'a NavigatorObserver fires DURING the transition; pushing then '
          'throws, and a thrown navigation reads as the app ignoring the tap',
    );
  });

  test('the observer short-circuits when nothing is pending', () {
    expect(
      observer.contains('hasPending'),
      isTrue,
      reason: 'this runs on every route change in the app; it must cost '
          'nothing in the overwhelmingly common no-pending case',
    );
  });

  group('ownership', () {
    test('a restored target is refused for a different user', () {
      expect(
        navigator.contains('_stashedOwnerUserId'),
        isTrue,
        reason: 'persisting without an owner lets one person\'s transfer '
            'notification open for whoever logs in next on a shared device',
      );
      final at = navigator.indexOf('final owner = _stashedOwnerUserId;');
      expect(at, greaterThan(-1), reason: 'the owner check is gone');
      final nav = navigator.indexOf('Get.toNamed(confirmed.route');
      expect(at, lessThan(nav),
          reason: 'the owner must be checked BEFORE navigating, or the wrong '
              "user has already seen the other's notification");
    });
  });

  group('consumption clears the disk copy', () {
    test('taking the stash also clears persistence', () {
      final at = navigator.indexOf('if (!peek) {');
      expect(at, greaterThan(-1));
      final body = navigator.substring(at, at + 600);
      expect(
        body.contains('PendingDeepLinkStore.clear()'),
        isTrue,
        reason: 'a consumed target left on disk replays on the next cold '
            'start, yanking the user to a receipt they just closed',
      );
    });

    test('sign-out clears persistence for a session-captured target', () {
      final at = navigator.indexOf('void clear() {');
      final body = navigator.substring(at, at + 400);
      expect(body.contains('PendingDeepLinkStore.clear()'), isTrue);
      expect(
        body.contains('if (!_stashedUnderSession) return'),
        isTrue,
        reason: 'a PRE-AUTH intent must survive sign-out teardown — the '
            'cold-start auto-login teardown races its ingestion, and clearing '
            'it there silently drops the link the user just tapped',
      );
    });
  });

  group('gating', () {
    test('a blocking dialog defers the replay', () {
      expect(
        navigator.contains('Get.isDialogOpen') &&
            navigator.contains('Get.isBottomSheetOpen'),
        isTrue,
        reason: 'the fraud freeze and forced-update prompt are DIALOGS, not '
            'routes, so no path check sees them. The freeze is '
            'security-critical and must own the screen; pushing a receipt over '
            'it would hide it and let the user navigate away from it.',
      );
      final dlg = navigator.indexOf('Get.isDialogOpen');
      final path = navigator.indexOf("r.startsWith('/auth/')");
      expect(dlg, lessThan(path),
          reason: 'the dialog check must come first — Get.currentRoute during '
              'a dialog is the dialog route and matches none of the path rules');
    });

    test('the auth gate still blocks every onboarding screen', () {
      // transactionPinSetup, emailVerification, passcodeSetup, phoneEntry are
      // all '/auth/...' and are reached with offAllNamed, so replaying over one
      // would both pull the user out of a MANDATORY step and leave Back
      // pointing at it.
      expect(navigator.contains("r.startsWith('/auth/')"), isTrue);
      expect(navigator.contains("r.startsWith('/kyc/')"), isTrue);
    });
  });

  test('the destination is PUSHED so Back returns to the origin', () {
    expect(
      navigator.contains('Get.toNamed(confirmed.route'),
      isTrue,
      reason: 'offNamed/offAllNamed would replace the base route, and Back '
          'from the notification destination would then exit the app instead '
          'of returning to the dashboard',
    );
    expect(
      navigator.contains('Get.offAllNamed(confirmed.route'),
      isFalse,
      reason: 'offAllNamed destroys the stack the Back button needs',
    );
  });
}
