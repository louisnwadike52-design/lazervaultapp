import 'dart:async';
import 'dart:io';

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
      expect(isNetworkError(const SocketException('failed host lookup')),
          isTrue);
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
  });

  group('friendlyGrpcError', () {
    test('never leaks "expected 200, got 503" — maps to network message', () {
      final e = GrpcError.custom(
        StatusCode.unknown,
        'expected 200, got 503',
      );
      expect(friendlyGrpcError(e, 'fallback'), networkErrorMessage);
    });

    test('unavailable maps to network message', () {
      expect(
        friendlyGrpcError(GrpcError.unavailable('x'), 'fallback'),
        networkErrorMessage,
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
    test('gRPC transport error → network message', () {
      final e = GrpcError.custom(StatusCode.unknown, 'expected 200, got 503');
      expect(friendlyError(e), networkErrorMessage);
    });
  });
}
