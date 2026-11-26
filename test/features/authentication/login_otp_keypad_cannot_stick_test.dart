// THE OTP KEYPAD MUST NEVER BE PERMANENTLY DEAD.
//
// login_otp_screen disables every digit box while a verify is in flight
// (`enabled: !_expired && !_submitting`). `_submitting` was cleared ONLY from
// the BLoC listener, which handles exactly three states — AuthenticationSuccess,
// AuthenticationError and AuthenticationFailure. Anything else leaves it true:
// a state the cubit gains later, an exception swallowed upstream, or a request
// that never completes on a bad link. The screen then accepts no input at all,
// which is what customers reported as "the OTP screen won't let me type".
//
// Enumerating states is what failed, so the fix does not enumerate them — a
// watchdog bounds the wait and re-arms the keypad whatever happens. These are
// SOURCE assertions because the failure is structural: the dangerous version
// compiles, renders and passes any test that drives only the three happy
// states. What must be guarded is that no future edit reintroduces a reset
// path that forgets the timer.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final src = File(
    'lib/src/features/authentication/presentation/views/login_otp_screen.dart',
  ).readAsStringSync();

  group('login OTP keypad', () {
    test('every in-flight reset goes through _endSubmit', () {
      // `_submitting = false` anywhere but inside _endSubmit is a path that
      // clears the flag without cancelling the watchdog — which would later
      // fire and stamp a spurious "took too long" over a finished verify.
      // Excludes the field DECLARATION (`bool _submitting = false;`), which is
      // an initialiser, not a reset path. Counting it made this assert 2 and
      // measure nothing.
      final resets = RegExp(
        r'(?<!bool )_submitting\s*=\s*false',
      ).allMatches(src).length;
      expect(
        resets,
        1,
        reason:
            'expected exactly one assignment, inside _endSubmit; found '
            '$resets. Route every reset through _endSubmit so the flag and '
            'the watchdog can never disagree.',
      );
      expect(
        src.contains('void _endSubmit()'),
        isTrue,
        reason: '_endSubmit is the single place that ends a submit',
      );
    });

    test('_endSubmit cancels the watchdog', () {
      final body = src.substring(src.indexOf('void _endSubmit()'));
      final end = body.indexOf('\n  }');
      final fn = end > 0 ? body.substring(0, end) : body;
      expect(
        fn.contains('_submitWatchdog?.cancel()'),
        isTrue,
        reason: 'a cleared flag with a live timer still fires later',
      );
      expect(fn.contains('_submitting = false'), isTrue);
    });

    test('a submit always arms the watchdog', () {
      expect(
        src.contains('_submitWatchdog = Timer('),
        isTrue,
        reason:
            'without arming it, an unanswered verify strands the keypad '
            'exactly as before',
      );
      // It must actually re-enable input, not merely show a message.
      final armIdx = src.indexOf('_submitWatchdog = Timer(');
      final arm = src.substring(armIdx, armIdx + 700);
      expect(
        arm.contains('_endSubmit()'),
        isTrue,
        reason:
            'the watchdog must clear _submitting — a message alone '
            'leaves every box still disabled',
      );
    });

    test('the watchdog is cancelled on dispose', () {
      final d = src.substring(src.indexOf('void dispose()'));
      expect(
        d.substring(0, 400).contains('_submitWatchdog?.cancel()'),
        isTrue,
        reason: 'a timer outliving the screen calls setState on a dead State',
      );
    });

    test('the watchdog window is long enough for a slow mobile link', () {
      final m = RegExp(
        r'_submitWatchdogTimeout\s*=\s*Duration\(seconds:\s*(\d+)\)',
      ).firstMatch(src);
      expect(m, isNotNull, reason: 'the timeout must be a named constant');
      final secs = int.parse(m!.group(1)!);
      // Under ~15s and a real in-flight verify on Nigerian mobile data gets
      // re-armed under the user, inviting a double submit. Over a minute and
      // the screen is dead long enough that the customer has already left.
      expect(
        secs,
        greaterThanOrEqualTo(15),
        reason: 're-arming under a live request invites a double submit',
      );
      expect(
        secs,
        lessThanOrEqualTo(60),
        reason: 'a minute of a dead keypad is already a lost customer',
      );
    });
  });
}
