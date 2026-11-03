import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

/// MONEY WE GAVE THE CUSTOMER MUST BE NAMED, NOT SHOWN AS "Credit".
///
/// Both grant paths send their credit `type` to accounts-service, which stores
/// it verbatim as the transaction CATEGORY. Neither category was handled, so
/// both fell through generateTransactionTitle's whole chain to the closing
/// `else` and rendered as a bare "Credit" — which is what prompted
/// "why can't I find that in his transaction history?".
///
/// These pin the exact strings the two services send. If either renames its
/// credit type without updating the classifier, the label silently reverts to
/// "Credit" and this fails.
void main() {
  group('grant labelling', () {
    test('the onboarding grant reads as a welcome bonus', () {
      // accounts-service grant_disbursement.go passes "onboarding_grant".
      expect(
        generateTransactionTitle('onboarding_grant', 'credit',
            'Welcome bonus — spend it on Lazervault', 'GRANT-abc'),
        'Welcome Bonus',
      );
    });

    test('the tester allocation reads as a tester allocation', () {
      // admin-gateway prelaunch_funds_disburse.go passes "tester_allocation".
      expect(
        generateTransactionTitle('tester_allocation', 'credit',
            'Tester allocation — spend it on Lazervault', 'TESTERGRANT-x-y'),
        'Tester Allocation',
      );
    });

    test('neither is mislabelled as a deposit', () {
      // "Deposit" implies the customer put it there and can take it out, which
      // is the opposite of true for restricted grant money.
      for (final c in ['onboarding_grant', 'tester_allocation']) {
        final title = generateTransactionTitle(c, 'credit', '', '');
        expect(title.toLowerCase(), isNot(contains('deposit')));
        expect(title, isNot('Credit'));
      }
    });

    test('an unrelated credit is untouched', () {
      // The branches are resolved FIRST, so prove they did not swallow
      // anything that was already titled correctly.
      expect(generateTransactionTitle('deposit', 'credit', '', ''),
          'Account Deposit');
      expect(generateTransactionTitle('transfer_in', 'credit', '', ''),
          'Transfer Received');
      expect(generateTransactionTitle('gift_card_sell', 'credit', '', ''),
          'Gift Card Sale');
    });
  });
}
