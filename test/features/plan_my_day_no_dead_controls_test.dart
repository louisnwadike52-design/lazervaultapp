import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Plan My Day must not offer a control that cannot do what it says.
///
/// WHAT WAS LIVE
/// -------------
/// The Calendar Sync screen shipped three surfaces that looked functional and were not:
///
///   1. An **Outlook Calendar** card with Connect / Sync / Disconnect. All three handlers
///      only showed a "coming soon" snackbar, and the server's `GetCalendarSyncStatus`
///      hardcodes `OutlookConnected: false` — there is no Outlook OAuth client, token
///      store or sync path behind it.
///   2. A **Sync Settings** card with three switches (Auto-sync, Sync past events, Create
///      events in calendar). Each was passed `(value) {}`. They animated on tap, persisted
///      nothing, and no sync code ever read them — so every choice silently reverted on
///      reopen.
///   3. The **Google** card, which is real but blocked on Google verification, so it is
///      gated behind a flag that defaults OFF rather than shown and failing.
///
/// A dead control is worse than an absent one: it spends the user's trust on a no-op and
/// invites a support ticket for a feature that was never wired up. These assertions keep
/// each of those three from drifting back.
///
/// Asserted against source because the screen needs a GetIt-registered service, a live
/// planning-service and a Google OAuth session to render — what can be checked cheaply
/// and durably is that the dead surfaces have not returned.

final _pmdDir = Directory('lib/src/features/plan_my_day');

final _calendarScreen = File(
  'lib/src/features/plan_my_day/presentation/screens/calendar_settings_screen.dart',
).readAsStringSync();

final _planScreen = File(
  'lib/src/features/plan_my_day/presentation/screens/plan_my_day_screen.dart',
).readAsStringSync();

/// Every Dart file under Plan My Day, as (path, source).
Iterable<(String, String)> _allSources() => _pmdDir
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'))
    .map((f) => (f.path, f.readAsStringSync()));

/// Source with `//` comment lines removed.
///
/// The removals are DOCUMENTED in a comment that names Outlook and the switches it
/// replaced — exactly the words these tests search for. Without stripping, the rationale
/// would match as a regression and fail on correct code.
String _stripComments(String source) => source
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//'))
    .join('\n');

void main() {
  group('no unbacked connection', () {
    test('Outlook is gone from the whole feature, not just the screen', () {
      // Checked across every file so a future "Outlook" entry point elsewhere in Plan My
      // Day — a settings row, a quick action — is caught too.
      for (final (path, source) in _allSources()) {
        expect(
          _stripComments(source).toLowerCase().contains('outlook'),
          isFalse,
          reason: '$path references Outlook. There is no Outlook OAuth client, token '
              'store or sync path — any CTA for it can only show "coming soon".',
        );
      }
    });

    test('the Outlook handlers are not merely unreferenced but removed', () {
      // Leaving them behind invites a future build() from re-wiring a stub that still
      // compiles and still does nothing.
      for (final gone in [
        '_connectOutlookCalendar',
        '_disconnectOutlookCalendar',
        '_syncOutlookCalendar',
        '_outlookConnected',
        '_outlookLastSync',
      ]) {
        expect(_calendarScreen.contains(gone), isFalse,
            reason: '$gone survives in calendar_settings_screen.dart');
      }
    });
  });

  group('no switch that persists nothing', () {
    test('no control in Plan My Day is handed an empty closure', () {
      // `(value) {}` on a Switch is the exact shape of the Sync Settings bug: it renders,
      // it animates, and it drops what the user chose on the floor.
      //
      // `catch (_) {}` is a deliberate swallow, not a control handler, so it is excluded
      // — three of those exist in this tree and are correct.
      final pattern = RegExp(r'(?<!catch\s)\((?:value|v|_|checked)\)\s*\{\s*\}');
      for (final (path, source) in _allSources()) {
        for (final line in _stripComments(source).split('\n')) {
          if (line.contains('catch')) continue;
          expect(
            pattern.hasMatch(line),
            isFalse,
            reason: '$path has an empty control handler:\n  ${line.trim()}\n'
                'A switch that persists nothing tells the user their setting was saved '
                'when reopening the screen will revert it.',
          );
        }
      }
    });

    test('the Sync Settings card is gone', () {
      final body = _stripComments(_calendarScreen);
      for (final gone in [
        '_buildSyncSettings',
        '_buildSettingItem',
        'Auto-sync',
        'Sync past events',
      ]) {
        expect(body.contains(gone), isFalse,
            reason: '"$gone" is back in calendar_settings_screen.dart with no backend '
                'that reads it');
      }
    });
  });

  group('the real-but-blocked Google surface stays gated', () {
    test('the Sync entry chip is behind the flag', () {
      // This chip is the ONLY route to the Calendar Sync screen, so the flag hides the
      // entire surface. If the chip loses its gate, users reach a connect button that
      // Google refuses with access_denied until verification completes.
      final chipIdx = _planScreen.indexOf("'Sync'");
      expect(chipIdx, isNot(-1), reason: 'the Sync chip was renamed — re-point this test');
      final before = _planScreen.substring(
        chipIdx < 400 ? 0 : chipIdx - 400,
        chipIdx,
      );
      expect(
        before.contains('FeatureFlags.planMyDayGoogleIntegrations'),
        isTrue,
        reason: 'the Sync chip is no longer gated on planMyDayGoogleIntegrations',
      );
    });

    test('the Gmail card is behind the same flag', () {
      // One switch for both surfaces — gating them on different keys is how half a
      // feature ends up visible.
      expect(
        _planScreen.contains('if (!FeatureFlags.planMyDayGoogleIntegrations)'),
        isTrue,
      );
    });

    test('the flag defaults to OFF', () {
      // Default-on would expose both surfaces on any install whose settings sync has not
      // run yet — which is every fresh install.
      final flags = File('lib/core/config/feature_flags.dart').readAsStringSync();
      // The getter's read, not the const declaration — the window must clear the
      // 34-character identifier itself before it reaches the `??`.
      final idx = flags.indexOf('getBool(planMyDayGoogleIntegrationsVisible)');
      expect(idx, isNot(-1), reason: 'the flag getter was restructured');
      expect(
        flags.substring(idx, idx + 70).contains('?? false'),
        isTrue,
        reason: 'the Plan My Day Google flag must default OFF — Google has not approved '
            'the Gmail/Calendar scopes for non-test accounts yet',
      );
    });
  });
}
