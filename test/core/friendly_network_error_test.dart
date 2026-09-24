import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/core/errors/failures.dart';

void main() {
  group('isNetworkError', () {
    test('true for a non-200 gateway response surfacing as gRPC unknown', () {
      final e = GrpcError.custom(
        StatusCode.unknown,
        'HTTP request completed: expected 200, got 503',
      );
      expect(isNetworkError(e), isTrue);
    });

    test('true for gRPC unavailable / internal / deadlineExceeded / aborted',
        () {
      expect(isNetworkError(GrpcError.unavailable('x')), isTrue);
      expect(isNetworkError(GrpcError.internal('x')), isTrue);
      expect(isNetworkError(GrpcError.deadlineExceeded('x')), isTrue);
      expect(isNetworkError(GrpcError.aborted('x')), isTrue);
    });

    test('true for SocketException and TimeoutException', () {
      expect(
          isNetworkError(const SocketException('failed host lookup')), isTrue);
      expect(isNetworkError(TimeoutException('slow')), isTrue);
    });

    test('false for a business gRPC error with a human message', () {
      final e = GrpcError.alreadyExists('Account already exists.');
      expect(isNetworkError(e), isFalse);
    });
  });

  group('isNetworkStatusCode', () {
    test('true for network-class gRPC int codes and HTTP 5xx', () {
      for (final c in [2, 4, 10, 13, 14, 500, 502, 503, 504]) {
        expect(isNetworkStatusCode(c), isTrue, reason: 'code $c');
      }
    });

    test('false for auth/validation codes', () {
      for (final c in [3, 7, 16, 400, 401, 403, 404, 429]) {
        expect(isNetworkStatusCode(c), isFalse, reason: 'code $c');
      }
    });

    test('true for Cloudflare edge codes (tunnel origin down)', () {
      for (final c in [520, 521, 522, 523, 524, 525, 526, 527, 530]) {
        expect(isNetworkStatusCode(c), isTrue, reason: 'code $c');
      }
    });
  });

  group('looksTechnical', () {
    test('true for raw transport/exception text', () {
      expect(looksTechnical('expected 200, got 503'), isTrue);
      expect(looksTechnical('SocketException: Connection refused'), isTrue);
      expect(looksTechnical(''), isTrue);
      expect(looksTechnical(null), isTrue);
    });

    test('false for a normal human sentence', () {
      expect(looksTechnical('Account already exists.'), isFalse);
      expect(looksTechnical('Insufficient funds for this transfer.'), isFalse);
    });

    test('true for a raw Cloudflare status line, e.g. "HTTP 530"', () {
      expect(looksTechnical('Scan error: HTTP 530'), isTrue);
      expect(looksTechnical('http 522'), isTrue);
    });

    test('false when 5xx-looking digits are just money copy', () {
      expect(looksTechnical('You sent NGN 530 to Ada.'), isFalse);
      expect(looksTechnical('Your balance is 522.40.'), isFalse);
    });
  });

  group('friendlyGrpcError', () {
    test('never leaks "expected 200, got 503" — and names it as OURS', () {
      final e = GrpcError.custom(
        StatusCode.unknown,
        'expected 200, got 503',
      );
      // Used to be networkErrorMessage, i.e. "check your connection". A 503 is
      // our gateway answering. The user's connection carried it perfectly.
      expect(friendlyGrpcError(e, 'fallback'), serverErrorMessage);
    });

    test('unavailable with no other evidence names both possibilities', () {
      // gRPC unavailable is produced BOTH by a dead socket and by a dead server,
      // and nothing here distinguishes them — so the honest message says so
      // rather than picking one and being wrong half the time.
      expect(
        friendlyGrpcError(GrpcError.unavailable('x'), 'fallback'),
        unreachableErrorMessage,
      );
    });

    test('passes through a benign server-authored business message', () {
      final e = GrpcError.alreadyExists('Account already exists.');
      expect(friendlyGrpcError(e, 'fallback'), 'Account already exists.');
    });

    test('default branch returns the fallback, never the raw message', () {
      final e = GrpcError.custom(StatusCode.internal, 'panic: nil pointer');
      // internal is network-class → network message (and definitely not raw).
      final msg = friendlyGrpcError(e, 'Authentication failed.');
      expect(msg, isNot(contains('panic')));
    });

    test('unauthenticated maps to session-expired message', () {
      final e = GrpcError.unauthenticated('token expired');
      expect(friendlyGrpcError(e, 'fallback'),
          'Session expired. Please log in again.');
    });
  });

  group('friendlyError', () {
    test('a 5xx behind a gRPC error is reported as our problem', () {
      final e = GrpcError.custom(StatusCode.unknown, 'expected 200, got 503');
      expect(friendlyError(e), serverErrorMessage);
    });
  });

  /// The bug this split exists for.
  ///
  /// Reported from a device during signup: a card reading "Our servers are being
  /// worked on right now" — which was correct that time, but the same code path
  /// produced "Network error. Please check your connection and try again."
  /// whenever OUR server returned a 5xx. Someone whose signup failed on our 503
  /// was told their connection was broken: they would restart the router, switch
  /// to mobile data, and retry into the same outage.
  ///
  /// Three outcomes now, because there are three genuinely different situations
  /// and only two of them are knowable.
  group('whose fault is it', () {
    test('a 5xx is ours, in every shape it arrives in', () {
      expect(isServerError(GrpcError.internal('panic: nil pointer')), isTrue);
      expect(isServerError(GrpcError.custom(StatusCode.unknown, 'got 502')),
          isTrue);
      expect(isServerError('expected 200, got 503'), isTrue);
      expect(isServerError('Scan error: HTTP 530'), isTrue,
          reason: 'Cloudflare origin-unreachable codes are still our origin');
      expect(
        isServerError(dio.DioException(
          requestOptions: dio.RequestOptions(path: '/x'),
          response: dio.Response<void>(
              requestOptions: dio.RequestOptions(path: '/x'), statusCode: 503),
        )),
        isTrue,
      );
    });

    test('an undeployed service is ours, not a connectivity problem', () {
      // The method is not registered: the service is down or the gateway route
      // is missing. Sending the user to check their wifi fixes nothing.
      expect(isServerError(GrpcError.unimplemented('unknown service Foo')),
          isTrue);
      expect(friendlyGrpcError(GrpcError.unimplemented('unknown service Foo')),
          serverErrorMessage);
    });

    test('a dead socket is the device, and says so', () {
      expect(isDeviceTransportError(const SocketException('failed')), isTrue);
      expect(isDeviceTransportError('Failed host lookup: api.lazervault.app'),
          isTrue);
      expect(transportFailureMessage(const SocketException('failed')),
          networkErrorMessage);
    });

    test('money copy containing 5xx-looking digits is neither', () {
      // The reason the HTTP pattern is anchored on "http": these are ordinary
      // sentences a user should see unchanged.
      expect(isServerError('You sent NGN 530 to Ada.'), isFalse);
      expect(sanitizeUserFacingError('You sent NGN 530 to Ada.'),
          'You sent NGN 530 to Ada.');
    });

    test('server evidence beats transport evidence when both are present', () {
      // "connection" appears in plenty of 5xx text. A concrete 5xx is proof; the
      // word "connection" is not.
      expect(
        transportFailureMessage(
            'HTTP connection completed with 502 instead of 200'),
        serverErrorMessage,
      );
    });

    test('the sanitiser splits the same three ways', () {
      expect(
          sanitizeUserFacingError('expected 200, got 503'), serverErrorMessage);
      expect(sanitizeUserFacingError('SocketException: Connection refused'),
          networkErrorMessage);
      expect(
          sanitizeUserFacingError('bad status code'), unreachableErrorMessage);
    });

    test('isNetworkError still covers everything it used to', () {
      // 49 call sites use it for retry and offline control flow. The split
      // changed the WORDS, and must not have changed the classification.
      for (final e in <Object>[
        GrpcError.unavailable('x'),
        GrpcError.internal('x'),
        GrpcError.deadlineExceeded('x'),
        GrpcError.aborted('x'),
        const SocketException('failed'),
        TimeoutException('slow'),
        GrpcError.custom(StatusCode.unknown, 'expected 200, got 503'),
      ]) {
        expect(isNetworkError(e), isTrue, reason: '$e');
      }
      expect(isNetworkError(GrpcError.alreadyExists('Account already exists.')),
          isFalse);
    });
  });
}
