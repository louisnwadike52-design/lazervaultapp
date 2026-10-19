import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// OUR TRANSPORT INTERNALS WERE PRINTED ON A USER'S SCREEN.
///
/// Prod 2026-10-19, "Set Payout Receiver", in red under the member list:
///
///   invalid request: could not resolve recipient's payout account
///   (lookup error: accounts-service unavailable (circuit open):
///   circuit breaker is open). Try again in a moment
///
/// Our service name, our transport state, our circuit breaker — none of it
/// actionable by the person reading it. The sheet returned the server's
/// invalidArgument message verbatim, and the server had interpolated the
/// internal error into it.
///
/// Fixed at BOTH ends: the server logs the detail and sends a human sentence,
/// and the UI sanitises whatever still arrives.
void main() {
  group('the exact string that leaked', () {
    const leaked =
        'could not resolve recipient\'s payout account (lookup error: '
        'accounts-service unavailable (circuit open): circuit breaker is '
        'open). Try again in a moment';

    test('is recognised as technical', () {
      expect(looksTechnical(leaked), isTrue);
    });

    test('never reaches a user', () {
      final shown = sanitizeUserFacingError(leaked);
      expect(shown, isNot(contains('circuit')));
      expect(shown, isNot(contains('accounts-service')));
      expect(shown, isNot(contains('lookup error')));
    });
  });

  group('infra vocabulary is caught by meaning, not by accident', () {
    // The leaked string happened to contain "error:", which was already a
    // marker — so it was caught by luck. These siblings carry no such word
    // and would have gone straight to the screen.
    for (final raw in const [
      'accounts-service unavailable (circuit open)',
      'circuit breaker is open',
      'service unavailable',
      'connection refused',
      'context deadline exceeded',
      'dial tcp 127.0.0.1:18087',
      'i/o timeout',
      'no such host',
    ]) {
      test('"$raw" is suppressed', () {
        expect(looksTechnical(raw), isTrue, reason: raw);
        expect(sanitizeUserFacingError(raw), isNot(contains(raw)));
      });
    }
  });

  group('real refusals still reach the user', () {
    // The whole point of showing an invalidArgument message: these are the
    // sentences a person can act on. Suppressing them would be the opposite
    // failure — a useless "something went wrong" where a clear reason exists.
    for (final raw in const [
      'Pick a member who is up to date',
      'Nnaemeka Ezeke is behind on their own payments into this circle '
          '(2 unpaid cycle(s)), so the pot would be held again',
      'this bill can no longer be removed — 2 co-payer(s) paid into it',
      'payout has already settled. Receiver cannot be reassigned',
    ]) {
      test('"${raw.substring(0, 24)}…" passes through', () {
        expect(sanitizeUserFacingError(raw), raw);
      });
    }
  });

  test('the receiver sheet no longer trusts a server message verbatim', () {
    final src = File(
      'lib/src/features/group_account/presentation/widgets/'
      'select_payout_receiver_bottom_sheet.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');
    expect(src, isNot(contains("return e.message ?? 'Invalid selection'")),
        reason: 'that is the line that printed our circuit breaker to a user');
    expect(src, contains('sanitizeUserFacingError(e.message)'));
  });
}
