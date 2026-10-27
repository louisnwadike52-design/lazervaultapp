import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/cards/data/repositories/card_failure.dart';

/// Every card repository method ended `ServerFailure(message: e.toString())`,
/// and the datasource had already wrapped the gRPC error in an Exception. So
/// what reached the user was the whole envelope:
///
///   Exception: Failed to create virtual card: gRPC Error (code: 9,
///   codeName: FAILED_PRECONDITION, message: KYC_REQUIRED: Verify your…)
///
/// The house rule is that people see something plain while the detail goes to
/// the logs. This was true for EVERY card failure; the identity gate just made
/// it the common path.
void main() {
  group('nothing internal reaches the user', () {
    test('a raw gRPC error never appears in the message', () {
      final f = cardFailureFrom(
        GrpcError.internal('boom: connection reset by peer'),
      );
      for (final leak in ['gRPC', 'code:', 'codeName', 'boom', 'Exception']) {
        expect(f.message.contains(leak), isFalse,
            reason: 'message leaks "$leak": ${f.message}');
      }
    });

    test('the datasource\'s wrapped Exception is unwrapped, not printed', () {
      // This is the shape the repository actually receives — the datasource
      // rethrows as Exception('Failed to …: ${e.toString()}'), so the type is
      // gone by then and only the text remains.
      final wrapped = Exception(
        'Failed to create virtual card: gRPC Error (code: 9, '
        'codeName: FAILED_PRECONDITION, message: KYC_REQUIRED: verify first)',
      );
      final f = cardFailureFrom(wrapped);
      expect(f.statusCode, kCardKycRequiredCode,
          reason: 'the code must survive the wrapping or the screen cannot route');
      expect(f.message.contains('gRPC'), isFalse);
      expect(f.message.contains('KYC_REQUIRED'), isFalse,
          reason: 'the CODE is for routing; the user gets the sentence');
    });

    test('an unknown error does not fall back to toString', () {
      // An unforeseen error is exactly the one most likely to carry something
      // internal, so it must not be the case that leaks.
      final f = cardFailureFrom(StateError('internal invariant violated'));
      expect(f.message.contains('internal invariant'), isFalse);
      expect(f.message.contains('StateError'), isFalse);
    });
  });

  group('the refusal can be routed', () {
    test('a KYC refusal carries the stable code', () {
      final f = cardFailureFrom(
        GrpcError.failedPrecondition('KYC_REQUIRED: verify your identity'),
      );
      expect(f.statusCode, kCardKycRequiredCode);
      expect(f.message, isNotEmpty);
    });

    test('an ordinary failure does NOT carry it', () {
      // Otherwise every provider blip would send the user to verify an
      // identity that was never the problem.
      final f = cardFailureFrom(GrpcError.unavailable('provider down'));
      expect(f.statusCode, isNot(kCardKycRequiredCode));
    });

    test('the user-facing copy says what to do, not what broke', () {
      final f = cardFailureFrom(
        GrpcError.failedPrecondition('KYC_REQUIRED: x'),
      );
      expect(f.message.toLowerCase(), contains('verify'));
    });
  });
}
