// The dialog a real user saw on 2026-10-06:
//
//   "Your transaction PIN has been locked due to too many failed attempts.
//    Please try again in -29854057 minutes and 14 seconds."
//
// ~56.8 years BEFORE now — the signature of an unset protobuf Timestamp
// decoding to epoch 0 and being subtracted from today. Nothing between the
// server and the screen ever asked whether the number was possible.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_pin/domain/pin_lockout.dart';

void main() {
  final now = DateTime.utc(2026, 10, 6, 12, 0, 0);

  group('pinLockRemaining', () {
    test('the exact bug: an epoch-0 timestamp yields no countdown at all', () {
      // Not Duration.zero — null. "We were told nothing" is a different fact
      // from "the lock just lifted", and only the latter may invite a retry.
      expect(pinLockRemaining(DateTime.utc(1970), now: now), isNull);
      expect(pinLockRemaining(DateTime.fromMillisecondsSinceEpoch(0), now: now),
          isNull);
      // And the message must then state the policy rather than a number.
      expect(formatPinLockRemaining(pinLockRemaining(DateTime.utc(1970), now: now)),
          'in a few minutes');
      expect(
        pinLockedMessage(pinLockRemaining(DateTime.utc(1970), now: now)),
        isNot(contains('-')),
        reason: 'no sanitised message may ever contain a negative number',
      );
    });

    test('a real remaining lock is reported as-is', () {
      final r = pinLockRemaining(now.add(const Duration(minutes: 3, seconds: 20)), now: now);
      expect(r, const Duration(minutes: 3, seconds: 20));
      expect(formatPinLockRemaining(r), 'in 3 minutes and 20 seconds');
    });

    test('an expired lock is zero, not negative', () {
      final r = pinLockRemaining(now.subtract(const Duration(minutes: 2)), now: now);
      expect(r, Duration.zero);
      expect(formatPinLockRemaining(r), 'now');
    });

    test('anything beyond the policy maximum is capped, never relayed', () {
      // A server bug must not become a 56-year message. The user still learns
      // they have to wait; nobody is told to come back next year.
      for (final absurd in [
        const Duration(minutes: 30),
        const Duration(days: 1),
        const Duration(days: 20732),
      ]) {
        final r = pinLockRemaining(now.add(absurd), now: now);
        expect(r, kMaxPinLockout, reason: '$absurd must cap to the policy max');
      }
    });

    test('null in, null out', () {
      expect(pinLockRemaining(null, now: now), isNull);
    });

    test('the policy maximum is five minutes', () {
      // Mirrors transactionpin.DefaultPinConfig().LockoutDuration in
      // auth-service. If the server's window changes, this must change with it
      // or the app will cap a legitimate countdown.
      expect(kMaxPinLockout, const Duration(minutes: 5));
    });
  });

  group('formatPinLockRemaining', () {
    test('never emits a negative or an implausible value', () {
      // Every path, including the ones that should be unreachable.
      for (final d in <Duration?>[
        null,
        Duration.zero,
        const Duration(seconds: -1),
        const Duration(days: -20732),
        const Duration(seconds: 1),
        const Duration(minutes: 5),
      ]) {
        final out = formatPinLockRemaining(d);
        expect(out, isNot(contains('-')), reason: 'rendered "$out" for $d');
        expect(out.toLowerCase(), isNot(contains('nan')));
      }
    });

    test('singular and plural read correctly', () {
      expect(formatPinLockRemaining(const Duration(minutes: 1)), 'in 1 minute');
      expect(formatPinLockRemaining(const Duration(minutes: 2)), 'in 2 minutes');
      expect(formatPinLockRemaining(const Duration(seconds: 1)), 'in 1 second');
      expect(formatPinLockRemaining(const Duration(seconds: 2)), 'in 2 seconds');
      // A whole number of minutes doesn't say "and 0 seconds".
      expect(formatPinLockRemaining(const Duration(minutes: 3)), 'in 3 minutes');
    });
  });

  group('pinLockedMessage', () {
    test('always offers the reset, because being locked is when it is needed', () {
      for (final d in <Duration?>[null, Duration.zero, kMaxPinLockout]) {
        expect(pinLockedMessage(d).toLowerCase(), contains('reset'));
      }
    });

    test('is sane for every input a broken server could produce', () {
      for (final until in [
        DateTime.utc(1970),
        DateTime.utc(1900),
        now.add(const Duration(days: 99999)),
        now.subtract(const Duration(days: 99999)),
      ]) {
        final msg = pinLockedMessage(pinLockRemaining(until, now: now));
        expect(msg, isNot(contains('-')));
        expect(msg, isNot(contains('99999')));
      }
    });
  });
}
