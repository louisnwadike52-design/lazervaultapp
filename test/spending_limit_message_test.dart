import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// A spending limit is a REFUSAL, not a failure. The server says exactly why;
/// the app was replacing it with "Transfer failed. Please try again." — advice
/// to retry the one thing that cannot succeed until tomorrow.
void main() {
  test('the gRPC envelope no longer hides a daily limit refusal', () {
    final e = Exception(
        'rpc error: code = FailedPrecondition desc = daily transfer amount limit exceeded');
    final msg = spendingLimitMessage(e);
    expect(msg, isNotNull);
    expect(msg, contains('daily'));
    expect(msg!.toLowerCase(), isNot(contains('rpc error')),
        reason: 'the transport envelope must never reach the customer');
  });

  test('it tells the customer what to DO, not just that they were refused', () {
    final msg = spendingLimitMessage(
        Exception('daily transfer amount limit exceeded'))!;
    expect(msg, contains('Settings'),
        reason: '"limit exceeded" alone leaves them nowhere to go');
  });

  test('monthly is named as monthly', () {
    final msg = spendingLimitMessage(
        Exception('monthly transfer amount limit exceeded'))!;
    expect(msg, contains('monthly'));
    expect(msg, isNot(contains('daily')));
  });

  test('unrelated failures are left alone', () {
    for (final e in [
      Exception('insufficient balance'),
      Exception('rpc error: code = Unavailable desc = connection refused'),
      Exception('something went wrong'),
      null,
    ]) {
      expect(spendingLimitMessage(e), isNull,
          reason: 'only a limit refusal may claim this copy');
    }
  });

  test('friendlyError routes a limit refusal to the actionable copy', () {
    final out = friendlyError(Exception(
        'rpc error: code = FailedPrecondition desc = daily transfer amount limit exceeded'));
    expect(out, contains('limit'));
    expect(out, isNot(contains('Something went wrong')));
  });
}
