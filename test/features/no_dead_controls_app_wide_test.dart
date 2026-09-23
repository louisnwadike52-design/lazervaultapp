import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// No control anywhere in the app may look functional and do nothing.
///
/// WHY THIS IS APP-WIDE
/// --------------------
/// A per-feature version of this test (see plan_my_day_no_dead_controls_test.dart)
/// caught three fakes in Plan My Day. Sweeping the rest of `lib/` then found eleven
/// more of the same two shapes, in money and security surfaces:
///
///   * A **price-alert dialog** whose field had no controller, whose dropdown was
///     `onChanged: (value) {}`, and whose "Create Alert" button ran `Navigator.pop`
///     plus a haptic buzz over the comment `// Implement alert creation`. It
///     SIMULATED SUCCESS — the worst shape, because nothing prompts the user to
///     check, so they rely on an alert that will never fire.
///   * A **send button** in the voice assistant wired to `onPressed: () {}`, beside
///     a TextField with no controller — Enter worked, the button never did.
///   * **Two dead "Resend" buttons** on legacy OTP screens, and three settings
///     switches (Data Sharing, Marketing emails, Analytics) behind `const false`
///     guards, each one bool-flip away from shipping.
///
/// The two patterns, and why each is worse than an absent control:
///
///   1. **An empty control closure.** A `Switch` renders its own state, so it
///      animates on tap and looks saved — the revert only shows on reopen. An
///      `InkWell`/`ElevatedButton` with `() {}` still ripples and still announces
///      itself as actionable to screen readers.
///   2. **Client code for an endpoint that does not exist.** These read as working
///      integration code. Plan My Day's `connectOutlookCalendar` POSTed to a route
///      with no handler and reported the 404 as a bare `false`, indistinguishable
///      from a genuine refusal.
///
/// Asserted against source: these live in screens needing GetIt, live gRPC channels
/// and an authenticated session. What is cheap and durable to check is that the
/// shapes have not come back.

final _libDir = Directory('lib');

/// Every Dart file under lib/, as (path, source).
Iterable<(String, String)> _allSources() => _libDir
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'))
    .where((f) => !f.path.contains('/generated/'))
    .map((f) => (f.path, f.readAsStringSync()));

/// Source with `//` comment lines removed.
///
/// Every removal here is documented in a comment that quotes the shape it replaced
/// — `onPressed: () {}` and the rest — so without stripping, the rationale matches
/// as a regression and the test fails on correct code.
String _stripComments(String source) => source
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//'))
    .join('\n');

/// Files allowed an empty closure, each for a stated non-stub reason.
///
/// Deliberately a allowlist of PATHS, not a blanket pattern: a new empty closure
/// anywhere else has to be justified here, in review, rather than slipping in.
const _emptyClosureAllowed = <String, String>{
  'input_pin.dart':
      'PinCodeTextField requires onChanged; the PIN is read from _pinController',
  'voice_command_sheet.dart':
      'onTap: () {} absorbs taps so they do not reach the dismiss barrier behind the card',
  'create_contribution_bottom_sheet.dart':
      'onTap: () {} exists only to give the tile an InkWell ripple',
};

void main() {
  group('no control is handed an empty closure', () {
    test('across all of lib/', () {
      // Matches a control callback whose body is empty. `catch (_) {}` is excluded:
      // a deliberate swallow is not a control handler.
      final pattern = RegExp(
        r'(?:onPressed|onTap|onChanged|onSubmitted|onSaved|onFieldSubmitted)'
        r':\s*\((?:[A-Za-z_][A-Za-z0-9_]*)?\)\s*(?:async\s*)?\{\s*\}',
      );
      final offenders = <String>[];

      for (final (path, source) in _allSources()) {
        final base = path.split('/').last;
        if (_emptyClosureAllowed.containsKey(base)) continue;
        for (final line in _stripComments(source).split('\n')) {
          if (line.contains('catch')) continue;
          if (pattern.hasMatch(line)) offenders.add('$path\n    ${line.trim()}');
        }
      }

      expect(
        offenders,
        isEmpty,
        reason: 'These controls render as actionable and do nothing:\n'
            '${offenders.join('\n')}\n\n'
            'Either wire it, or pass null so the widget goes genuinely inert '
            '(InkWell/ElevatedButton drop the ripple AND the accessibility '
            'affordance on null). If it is legitimately required-but-empty, add '
            'the file to _emptyClosureAllowed with the reason.',
      );
    });

    test('positional switch handlers are caught too', () {
      // The Plan My Day bug passed `(value) {}` POSITIONALLY to a helper, so it
      // matched no `onChanged:` pattern. Three dead switches survived that way.
      //
      // `Either.fold` is excluded. An ignored fold branch — `fold((_) {}, (r) =>
      // ...)` — is a deliberate "this side needs no handling", not a control, and
      // ten legitimate ones exist. The enclosing call is found by scanning back
      // for `fold(`/`then(`/`catchError(` since the callback sits on its own line.
      final pattern = RegExp(r'^\s*\((?:value|v|_|checked)\)\s*\{\s*\},?\s*$');
      final ignoredCall = RegExp(r'\.?(fold|then|catchError|onError|listen)\s*\(');
      final offenders = <String>[];

      for (final (path, source) in _allSources()) {
        if (_emptyClosureAllowed.containsKey(path.split('/').last)) continue;
        final lines = _stripComments(source).split('\n');
        for (var i = 0; i < lines.length; i++) {
          if (!pattern.hasMatch(lines[i])) continue;
          final lookback = lines
              .sublist((i - 4).clamp(0, lines.length), i + 1)
              .join('\n');
          if (ignoredCall.hasMatch(lookback)) continue;
          offenders.add('$path:${i + 1}: ${lines[i].trim()}');
        }
      }
      expect(offenders, isEmpty,
          reason: 'Empty positional handler(s):\n${offenders.join('\n')}');
    });
  });

  group('no CTA answers only with a toast', () {
    test('no "coming soon" snackbar sits behind a TODO', () {
      // The shape: a button whose handler is a TODO plus a toast. Four of these
      // shipped (voice export, voice share, invoice export, watchlist search).
      // A "Coming Soon" *label* or *badge* is fine — it discloses up front
      // instead of spending a tap — so only TODO-backed handlers are flagged.
      final offenders = <String>[];
      for (final (path, source) in _allSources()) {
        final lines = source.split('\n');
        for (var i = 0; i < lines.length; i++) {
          final l = lines[i];
          if (!RegExp(r'//\s*TODO.*[Ii]mplement').hasMatch(l)) continue;
          // Look at the next few lines for a user-visible toast.
          final window = lines.sublist(i, (i + 6).clamp(0, lines.length)).join('\n');
          if (RegExp(r'coming soon', caseSensitive: false).hasMatch(window)) {
            offenders.add('$path:${i + 1}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'CTA(s) that exist only to announce their own absence:\n'
            '${offenders.join('\n')}\n'
            'Remove the control, or build what it claims.',
      );
    });
  });

  group('no client method targets a route that does not exist', () {
    test('the deleted Outlook calendar endpoints stay deleted', () {
      // planning-service has no Outlook handler and no gateway mapping, so both
      // calls 404'd — and each reported that 404 as a plain `false`, which reads
      // exactly like a legitimate refusal.
      for (final (path, source) in _allSources()) {
        expect(
          _stripComments(source).contains('calendar/outlook/'),
          isFalse,
          reason: '$path posts to a calendar/outlook route with no server handler',
        );
      }
    });
  });
}
