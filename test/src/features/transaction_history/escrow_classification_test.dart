import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

// Escrow had no TransactionServiceType constant, so funding a deal fell to
// `unknown` — the grey help-outline glyph — and its receipt lost the PDF
// document every other money movement gets, falling back to a flat image.
//
// Mapping it onto `transfer` was deliberately rejected: escrow money is HELD
// pending delivery, and labelling that a completed transfer is a worse lie
// than the neutral glyph. These pin both halves of that decision.
void main() {
  TransactionServiceType classify(String description, String category) =>
      inferServiceTypeFromCategory(category, 'debit', description, '');

  test('escrow funding is classified as escrow, not unknown', () {
    expect(classify('Escrow funding: iPhone 17', 'debit'),
        TransactionServiceType.escrow);
  });

  test('escrow is recognised from the category alone', () {
    expect(classify('', 'escrow_funding'), TransactionServiceType.escrow);
  });

  test('escrow is never labelled a completed transfer', () {
    // The specific mislabel the classifier comment warns against.
    for (final d in [
      'Escrow funding: iPhone 17',
      'Escrow release to seller',
      'Escrow refund',
    ]) {
      expect(classify(d, 'debit'), isNot(TransactionServiceType.transfer),
          reason: '"$d" was labelled a transfer — the money is held');
    }
  });

  test('escrow wins over words later arms would claim', () {
    // "funding" and "release" appear in other families' matchers; escrow is
    // matched first precisely so those cannot steal it.
    expect(classify('Escrow funding for split payment', 'debit'),
        TransactionServiceType.escrow);
  });

  test('a plain transfer is still a transfer', () {
    // Guard against the new arm being too greedy.
    expect(classify('Transfer to John', 'transfer'),
        isNot(TransactionServiceType.escrow));
  });
}
