import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

/// A REFUSAL IS NOT A FAILURE.
///
/// The PIN sheet headed every terminal non-success "Transaction Failed /
/// Something went wrong", including a rule being correctly applied. Over the
/// body text "the minimum for a bank transfer is 100.00 NGN (you entered
/// 10.00)" that tells the user the app broke — so they retry, it fails
/// identically (the server marks it retryable=false), and three ₦10 attempts
/// get reported as "all transfers are failing".
///
/// A refusal is actionable and permanent until the user changes something; a
/// failure may succeed next time. The sheet now says which it is.
void main() {
  group('refusals are recognised', () {
    const cases = <String, String>{
      'the minimum for a bank transfer is 100.00 NGN (you entered 10.00) '
          '— payout providers reject smaller amounts': 'Below the minimum amount',
      'transfer amount too small: the fee meets or exceeds the amount':
          'Below the minimum amount',
      'Insufficient balance': 'Not enough balance',
      'Daily transfer limit exceeded': 'Over your limit',
      'amount exceeds your tier maximum': 'Over your limit',
      'cannot transfer to the same account': 'This transfer was not allowed',
      'this account is frozen': 'This account is restricted',
    };
    cases.forEach((message, subtitle) {
      test('"${message.substring(0, message.length.clamp(0, 44))}…"', () {
        expect(TransactionPinModalState.isRefusalMessage(message), isTrue,
            reason: 'a rule was applied; calling it a malfunction tells the '
                'user to retry something that cannot succeed');
        expect(TransactionPinModalState.refusalSubtitleFor(message), subtitle);
      });
    });
  });

  group('genuine faults stay failures', () {
    test('an unrecognised message is NOT downgraded to a refusal', () {
      for (final m in [
        'Network error. Please check your connection and try again.',
        'Our servers are having a problem right now.',
        'We couldn’t complete your transfer right now. Please try again.',
        '',
      ]) {
        expect(TransactionPinModalState.isRefusalMessage(m), isFalse,
            reason: 'mislabelling a real fault "Not sent" would stop someone '
                'retrying something that would have worked');
      }
    });

    test('null is a failure, not a refusal', () {
      expect(TransactionPinModalState.isRefusalMessage(null), isFalse);
    });
  });
}
