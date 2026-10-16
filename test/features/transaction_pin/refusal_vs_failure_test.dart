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
      // Was 'This transfer was not allowed'. Naming the actual rule is
      // strictly more useful, and it now shares an arm with the PayID and
      // wallet self-payment refusals below.
      'cannot transfer to the same account': "You can't pay yourself",
      'this account is frozen': 'This account is restricted',
      // id-pay-service's own words. These matched NOTHING before, so the
      // sheet headed them "Transaction Failed / Something went wrong" over a
      // body explaining the rule — and the payer retried a payment that can
      // only ever be refused.
      'cannot pay your own PayID': "You can't pay yourself",
      'you cannot pay yourself': "You can't pay yourself",
      'PayID has expired': 'This request is no longer payable',
      'PayID is not active (current status: 2)':
          'This request is no longer payable',
      'this request was already paid': 'This request is no longer payable',
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
