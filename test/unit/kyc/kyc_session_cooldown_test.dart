import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/domain/kyc_session_cooldown.dart';

/// Mono validates the customer's name against the BVN/NIN record and refuses on
/// a mismatch, so somebody who signed up with a typo fails every attempt. The
/// fix is to correct it and retry — but a session carrying the OLD name may
/// still be inside its billed reuse window, so the retry has to wait.
///
/// The wait is only tolerable if the number shown is right. These pin the
/// arithmetic the modal reads.

void main() {
  group('how long is left', () {
    test('rounds UP to whole minutes', () {
      // "Try again in 1 minute" with 61 seconds left sends the customer back a
      // second early, into the same refusal — which reads as the app being
      // broken rather than as a wait.
      const cases = {
        1: 1,
        59: 1,
        60: 1,
        61: 2,
        119: 2,
        120: 2,
        121: 3,
        600: 10,
      };
      cases.forEach((seconds, wantMinutes) {
        final e = KycSessionCooldownException(
            retryAfter: Duration(seconds: seconds));
        expect(e.minutesRemaining, wantMinutes,
            reason: '$seconds seconds should read as $wantMinutes minute(s)');
      });
    });

    test('an elapsed window reports nothing left and is retryable', () {
      for (final secs in [0, -1, -600]) {
        final e =
            KycSessionCooldownException(retryAfter: Duration(seconds: secs));
        expect(e.minutesRemaining, 0, reason: '$secs');
        expect(e.elapsed, isTrue, reason: '$secs');
      }
    });

    test('a live window is not retryable yet', () {
      const e = KycSessionCooldownException(retryAfter: Duration(seconds: 1));
      expect(e.elapsed, isFalse,
          reason: 'retrying inside the window hits the same refusal');
    });
  });

  group('what the customer is told', () {
    test("the server's message is used when it sends one", () {
      const e = KycSessionCooldownException(
        retryAfter: Duration(minutes: 7),
        message: 'your details were updated, so a new verification session is '
            'needed. Please try again in 7 minutes',
      );
      expect(e.toString(), contains('7 minutes'));
      expect(e.toString(), contains('details were updated'));
    });

    test('an empty message still explains itself', () {
      // The server is the source of the wording, but a blank one must not
      // surface as "Instance of KycSessionCooldownException".
      const e = KycSessionCooldownException(retryAfter: Duration(minutes: 3));
      expect(e.toString(), isNotEmpty);
      expect(e.toString(), isNot(contains('Instance of')));
      expect(e.toString().toLowerCase(), contains('try again'));
    });
  });

  test('it is an Exception, so a generic catch still contains it', () {
    // The KYC screen catches this BEFORE ProveKycException. If it ever stopped
    // being an Exception the ordering would silently stop working.
    const e = KycSessionCooldownException(retryAfter: Duration(minutes: 1));
    expect(e, isA<Exception>());
  });
}
