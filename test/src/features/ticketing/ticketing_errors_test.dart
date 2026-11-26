import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/ticketing/data/ticketing_errors.dart';

/// THE APP AND THE SERVICE MUST AGREE ON THE REFUSAL CODES.
///
/// ticketErrorToStatus in financial-products-service answers a refusal with a
/// CODE as the gRPC message ("SOLD_OUT"), and this app turns that code into a
/// sentence. A code the app does not know still produces usable copy through
/// the fallback — but it loses the RETRYABLE distinction, and then a sold-out
/// event gets a "Try again" button that can only fail. That is the failure
/// this test exists to prevent, and it is silent without it.
File _handlerSource() {
  var dir = Directory.current;
  const rel = 'microservices/financial-products-service/'
      'financial-products-microservice/internal/handler/ticketing_handler.go';
  for (var i = 0; i < 8; i++) {
    final f = File('${dir.path}/$rel');
    if (f.existsSync()) return f;
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  fail('could not find $rel by walking up from ${Directory.current.path} — '
      'repoint it rather than deleting this test: the two lists drifting is '
      'exactly what it catches');
}

void main() {
  group('refusal codes', () {
    test('every code the service sends has a sentence in the app', () {
      final src = _handlerSource().readAsStringSync();
      // The codes are the string literals passed to grpcstatus.Error in the
      // mapper — SHOUTY_SNAKE_CASE, which nothing else in that file is.
      final codes = RegExp(r'"([A-Z][A-Z_]{3,})"')
          .allMatches(src)
          .map((m) => m.group(1)!)
          .toSet();
      expect(codes, isNotEmpty,
          reason: 'found no refusal codes — the regex or the path is wrong, '
              'and this test would pass vacuously');

      final missing = codes.where((c) => !ticketRefusals.containsKey(c));
      expect(missing, isEmpty,
          reason: 'the service sends these and the app has no sentence for '
              'them, so they fall back to generic copy AND lose the '
              'retryable distinction: $missing');
    });

    test('and the app invents none the service does not send', () {
      final src = _handlerSource().readAsStringSync();
      final unknown =
          ticketRefusals.keys.where((c) => !src.contains('"$c"'));
      // A sentence for a code nothing sends is dead copy that reads as
      // supported behaviour.
      expect(unknown, isEmpty, reason: 'no longer sent by the service: $unknown');
    });

    test('a refusal offers no retry; a transport failure does', () {
      // RETRYING A REFUSAL FAILS IDENTICALLY. The button would only invite
      // tapping.
      for (final code in [
        'SOLD_OUT',
        'NOT_ON_SALE',
        'OVER_PER_BUYER_LIMIT',
        'SALES_STILL_OPEN',
        'NOTHING_TO_WITHDRAW',
        'EVENT_CANCELLED',
        'TICKET_ALREADY_USED',
      ]) {
        expect(ticketRefusals[code]!.isRetryable, isFalse, reason: code);
      }

      // A dropped response IS retryable, and safely so: the purchase carries a
      // stable idempotency key, so the server returns the original order
      // rather than charging again.
      final dropped = ticketError(GrpcError.unavailable('connection closed'));
      expect(dropped.isRetryable, isTrue);
      expect(dropped.message, contains('My tickets'),
          reason: 'the copy must tell the buyer how to check whether their '
              'money moved — a dropped response is indistinguishable from a '
              'rejected request, so it must not claim nothing happened');
    });

    test('a validation sentence is passed through, without its log prefix', () {
      final r = ticketError(GrpcError.invalidArgument(
          'tickets: at this price the commission would take everything — '
          'raise the price'));
      expect(r.message, startsWith('At this price'));
      expect(r.message, isNot(contains('tickets:')),
          reason: '"tickets: " is a log convention, not something to read to '
              'a customer');
      expect(r.isRetryable, isFalse,
          reason: 'the input has to change first');
    });

    test('an unknown failure is generic and retryable', () {
      final r = ticketError(StateError('boom'));
      expect(r.isRetryable, isTrue);
      expect(r.message, isNotEmpty);
    });
  });
}
