import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

/// Funding a betting wallet by bank transfer looked like an ordinary transfer.
///
/// The betting flow mints a `BET-...` reference the classifier recognises. But
/// the same wallet can be funded by a plain transfer to the operator's
/// collection account — which is what happens whenever the betting provider is
/// unavailable — and that row arrives as:
///
///   description "Transfer to SPORTY BET"  reference TRF-transfer_76af…
///
/// Nothing in it says "betting", so it was titled "Transfer", filed away from
/// the user's other betting rows, and — because both receipt surfaces gate the
/// repeat button on `serviceType == transfer` — offered "Send again", which
/// would re-send money to a betting account with none of the account
/// verification the betting flow performs.
void main() {
  group('a transfer to a betting operator is betting', () {
    for (final desc in const [
      'Transfer to SPORTY BET',
      'Transfer to SPORTYBET',
      'transfer to sporty-bet',
      'Transfer to Bet9ja',
      'Transfer to 1XBET',
      'Transfer to BetKing',
    ]) {
      test(desc, () {
        expect(
          inferServiceTypeFromCategory(
            'transfer',
            'debit',
            desc,
            'TRF-transfer_76af3b53-dcc9-4880-aa27-f3d86e89d7ea',
          ),
          TransactionServiceType.betting,
          reason: 'still reads as a plain transfer, so it keeps the wrong '
              'title and keeps the Send again button',
        );
      });
    }

    test('and it is titled as betting funding, not "Transfer"', () {
      expect(
        generateTransactionTitle(
          'transfer',
          'debit',
          'Transfer to SPORTY BET',
          'TRF-transfer_76af3b53',
        ),
        'Betting Wallet Funding',
      );
    });
  });

  group('an ordinary transfer is left alone', () {
    for (final desc in const [
      'Transfer to JOHN DOE',
      'Transfer to BETTER LIFE LTD',
      'Transfer to Elizabeth',
      'Salary payment',
    ]) {
      test(desc, () {
        expect(
          inferServiceTypeFromCategory('transfer', 'debit', desc, 'TRF-transfer_1'),
          isNot(TransactionServiceType.betting),
          reason: 'a normal payee was swept into betting — the operator names '
              'must be specific enough not to catch "BETTER" or "bet" alone',
        );
      });
    }
  });

  group('mentionsBettingOperator', () {
    test('ignores empty and null', () {
      expect(mentionsBettingOperator(null), isFalse);
      expect(mentionsBettingOperator(''), isFalse);
      expect(mentionsBettingOperator('   '), isFalse);
    });
    test('does not match the bare word "bet"', () {
      expect(mentionsBettingOperator('Transfer to BET'), isFalse,
          reason: '"bet" alone would catch any payee with those letters');
    });
    test('survives punctuation and casing', () {
      expect(mentionsBettingOperator('SPORTY_BET'), isTrue);
      expect(mentionsBettingOperator('  sporty . bet '), isTrue);
    });
  });
}
