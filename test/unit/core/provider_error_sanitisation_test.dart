import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

void main() {
  // The real strings Nomba returned to production on 2026-09-28, and the shape
  // our own Go clients wrap them in. None of these may ever reach a user: they
  // are meaningless to someone sending money, and they describe our
  // infrastructure to a person who should never see it.
  const leaks = <String>[
    'Your Request Seems to be coming from an unknown source',
    'Request forbidden, You are not whitelisted to access this resource',
    'Forbidden error',
    'nomba transfer failed: http 403 code=403 desc=Your Request Seems to be coming from an unknown source',
    'nomba bank transfer failed: http 403 code=403 desc=Forbidden error',
    'flutterwave payout failed: http 401 code=401 desc=Invalid API key',
    'storage-service upload failed: service not authorized',
    'your IP address is not permitted',
    'access denied for this merchant',
  ];

  group('provider refusals never reach the user', () {
    for (final raw in leaks) {
      test('"${raw.length > 46 ? '${raw.substring(0, 46)}…' : raw}"', () {
        expect(messageLooksLikeProviderRefusal(raw), isTrue,
            reason: 'not detected as a provider refusal');

        final sanitised = sanitizeUserFacingError(raw);
        expect(sanitised, providerUnavailableMessage);

        // And the same through the object-level entry point, at every gRPC
        // status a service might wrap a provider 403 in.
        for (final code in [
          StatusCode.internal,
          StatusCode.unavailable,
          StatusCode.failedPrecondition,
          StatusCode.invalidArgument,
          StatusCode.unknown,
        ]) {
          final shown = friendlyError(GrpcError.custom(code, raw));
          expect(shown, providerUnavailableMessage,
              reason: 'leaked at gRPC status $code');
        }
      });
    }

    test('no leaked fragment survives into the shown message', () {
      const forbidden = [
        'whitelist',
        'unknown source',
        'desc=',
        'http 403',
        'api key',
        'merchant',
      ];
      for (final raw in leaks) {
        final shown = sanitizeUserFacingError(raw).toLowerCase();
        for (final frag in forbidden) {
          expect(shown.contains(frag), isFalse,
              reason: '"$frag" survived into: $shown');
        }
      }
    });

    test('does not blame the user\'s connection', () {
      // Sending someone to restart a router when our IP fell off a provider's
      // allowlist is the failure serverErrorMessage exists to prevent.
      expect(providerUnavailableMessage.toLowerCase(),
          contains('not your connection'));
    });
  });

  group('legitimate business messages still pass through', () {
    // Over-broad matching would be its own bug: a user who cannot see
    // "Insufficient balance" is worse off than one who saw a provider string.
    const keep = <String>[
      'Insufficient balance',
      'Quote expired, please try again',
      'Daily transfer limit reached',
      'Recipient account could not be verified',
      'Payouts to this bank are temporarily paused',
      'Enter a valid account number',
    ];
    for (final msg in keep) {
      test('"$msg"', () {
        expect(messageLooksLikeProviderRefusal(msg), isFalse);
        expect(sanitizeUserFacingError(msg), msg);
      });
    }
  });

  group('edge cases', () {
    test('empty and null are handled', () {
      expect(messageLooksLikeProviderRefusal(null), isFalse);
      expect(messageLooksLikeProviderRefusal(''), isFalse);
      expect(isProviderRefusalError(null), isFalse);
    });

    test('detection is case-insensitive', () {
      expect(messageLooksLikeProviderRefusal('NOT WHITELISTED'), isTrue);
      expect(messageLooksLikeProviderRefusal('Unknown Source'), isTrue);
    });

    test('a plain string error is detected, not just GrpcError', () {
      expect(isProviderRefusalError('you are not whitelisted'), isTrue);
    });

    test('a 403 WITHOUT provider framing is left to the auth path', () {
      // The app's own session expiry must keep its own message rather than
      // being mistaken for a provider refusal.
      expect(messageLooksLikeProviderRefusal('403'), isFalse);
      expect(messageLooksLikeProviderRefusal('permission denied'), isFalse);
    });
  });
}
