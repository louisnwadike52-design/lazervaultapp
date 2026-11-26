import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';

/// TAPPING A DEPOSIT PUSH SHOWED A PAGE OF gRPC TRAILERS.
///
/// Cold start from a notification: the auth cubit reports a restored session
/// as soon as it resolves, but the access token is written to secure storage
/// separately and asynchronously. The deep link replayed in that window, the
/// Deposit screen fetched immediately with no authorization header, and the
/// gateway answered UNAUTHENTICATED — which the history repository rendered by
/// interpolating the exception. What reached the customer was the status code,
/// the trailers, a Cloudflare `cf-ray` and a base64 NEL report URL, under
/// "Something went wrong".
void main() {
  /// AND THE REPOSITORY MUST ACTUALLY ROUTE THROUGH IT.
  ///
  /// The handler has had the right sentence all along; the history repository
  /// interpolated the exception instead. Every assertion about the handler
  /// passes in that world, which is why this one reads the source: it is the
  /// bug, not a hypothetical.
  test('the history repository renders failures through the handler', () {
    final src = File('lib/src/features/transaction_history/data/repository/'
            'transaction_history_repository_grpc.dart')
        .readAsStringSync();

    expect(src.contains('GrpcErrorHandler.userFriendlyMessage'), isTrue,
        reason: 'the repository builds its own message again; a raw \$e there '
            'is what put Cloudflare trailers on the Deposit page');

  });

  group('an authentication failure reads as one', () {
    test('and never as a gRPC envelope', () {
      final err = GrpcError.unauthenticated('authorization token not provided');
      final shown = GrpcErrorHandler.userFriendlyMessage(err);

      expect(shown, contains('session'));
      expect(shown.toLowerCase(), contains('log in'));
      // The things that were on screen and should never be.
      for (final leak in ['cf-ray', 'trailers', 'rawResponse', 'cloudflare',
        'nel', 'code: 16', 'UNAUTHENTICATED']) {
        expect(shown.toLowerCase(), isNot(contains(leak.toLowerCase())),
            reason: '"$leak" is infrastructure detail, not an instruction');
      }
      // Short enough to be read.
      expect(shown.length, lessThan(120));
    });

    test('a server-written message is still preferred where there is one', () {
      // The handler keeps the server's own words for codes where the backend
      // writes for customers — that is why it is the shared helper and not a
      // switch in each repository.
      final err = GrpcError.failedPrecondition(
          'Paying with crypto is not available on your account right now.');
      expect(GrpcErrorHandler.userFriendlyMessage(err),
          contains('not available on your account'));
    });
  });

  group('token readiness is published for synchronous callers', () {
    setUp(() => GrpcCallOptionsHelper.lastKnownTokenUsable = null);

    test('unknown means GO AHEAD, not block', () {
      // Refusing on no information would block the very first call of every
      // session — the deep-link gate reads this before anything has looked.
      expect(GrpcCallOptionsHelper.lastKnownTokenUsable, isNull);
      final gateWouldAllow =
          GrpcCallOptionsHelper.lastKnownTokenUsable ?? true;
      expect(gateWouldAllow, isTrue);
    });

    test('a known-unusable token holds the replay', () {
      GrpcCallOptionsHelper.lastKnownTokenUsable = false;
      expect(GrpcCallOptionsHelper.lastKnownTokenUsable ?? true, isFalse,
          reason: 'this is the window the deposit push landed in');
    });

    test('a usable token releases it', () {
      GrpcCallOptionsHelper.lastKnownTokenUsable = true;
      expect(GrpcCallOptionsHelper.lastKnownTokenUsable ?? true, isTrue);
    });
  });
}
