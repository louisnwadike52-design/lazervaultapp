// A READ KILLED BY A TORN-DOWN CONNECTION MUST NOT REACH THE USER AS AN ERROR.
//
// The app's gRPC channels sit behind Cloudflare, which closes idle HTTP/2
// connections with GOAWAY. The in-flight call fails, and
// ResilientClientChannel swaps in a fresh inner channel — but only for the
// NEXT call. So the first request after an idle period failed and the screen
// painted "Something went wrong", while the server logged the very same RPC
// completing normally in 80ms. Reported as PiggyVault breaking on entry.
//
// The fix is a retry, NOT a longer deadline: the deadline is already 90s and
// the call had failed in milliseconds. These tests pin the shape of that
// retry, because getting it wrong in either direction is its own bug — too
// few and the error still shows, too many (or too slow) and a screen that is
// about to succeed feels broken instead.
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/network/retry_policy.dart';

void main() {
  group('transientRead', () {
    test('recovers a call that failed once on a transport error', () async {
      var attempts = 0;
      final result = await RetryPolicy.transientRead.execute(() async {
        attempts++;
        if (attempts == 1) {
          // What a GOAWAY surfaces as.
          throw GrpcError.unavailable('Connection is being forcefully terminated');
        }
        return 'loaded';
      });

      expect(result, 'loaded');
      expect(attempts, 2, reason: 'exactly one retry — the channel has already '
          'been swapped, so a second attempt is all it takes');
    });

    test('gives up after one retry rather than hiding a real outage', () async {
      var attempts = 0;
      await expectLater(
        RetryPolicy.transientRead.execute(() async {
          attempts++;
          throw GrpcError.unavailable('still down');
        }),
        throwsA(isA<GrpcError>()),
      );
      expect(attempts, 2,
          reason: 'if the second attempt fails too, the connection is not the '
              'problem and the user should be told');
    });

    test('is fast — a screen about to succeed must not feel broken', () {
      expect(RetryPolicy.transientRead.maxRetries, 1);
      expect(RetryPolicy.transientRead.initialDelay.inMilliseconds,
          lessThanOrEqualTo(300),
          reason: 'the backoff that suits a struggling server is exactly wrong '
              'here: the connection is already replaced');
      expect(RetryPolicy.transientRead.addJitter, isFalse,
          reason: 'jitter spreads load across many clients; with one retry on '
              'an already-healed channel it only adds latency');
    });

    test('does not retry a refusal the server actually made', () async {
      // A business refusal is a decision, not a blip. Replaying it wastes a
      // round trip and can hide the message the user needs to read.
      var attempts = 0;
      await expectLater(
        RetryPolicy.transientRead.execute(() async {
          attempts++;
          throw GrpcError.failedPrecondition('Your plan minimum is NGN200,000');
        }),
        throwsA(isA<GrpcError>()),
      );
      expect(attempts, 1, reason: 'a server decision must not be retried');
    });

    test('does not retry invalid input', () async {
      var attempts = 0;
      await expectLater(
        RetryPolicy.transientRead.execute(() async {
          attempts++;
          throw GrpcError.invalidArgument('bad page size');
        }),
        throwsA(isA<GrpcError>()),
      );
      expect(attempts, 1);
    });
  });
}
