import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart'
    as classifier;
import 'package:lazervault/core/types/unified_transaction.dart';

void main() {
  group('escrow rows in the transaction history', () {
    // The three legs are three different events. Before this they all fell
    // through to the generic tail: a seller read their own payout as an
    // unexplained "Credit", and a buyer read a ₦200 hold as "Debit".
    test('each leg gets its own title', () {
      expect(
        classifier.generateTransactionTitle('escrow_fund', 'debit',
            'Escrow funding: Laptop', 'ESCROW-abc', 'escrow-service'),
        'Escrow Funding',
      );
      expect(
        classifier.generateTransactionTitle('escrow_release', 'credit',
            'Escrow release: Laptop', 'ESCROW-SETTLE-abc', 'escrow-service'),
        'Escrow Released to You',
      );
      expect(
        classifier.generateTransactionTitle('escrow_refund', 'credit',
            'Escrow refund: TV', 'ESCROW-REFUND-abc', 'escrow-service'),
        'Escrow Refund',
      );
    });

    test('all three still filter as one service', () {
      for (final cat in ['escrow_fund', 'escrow_release', 'escrow_refund']) {
        final domain = classifier.classifyDomain(
            cat, 'Escrow', 'ESCROW-abc', 'escrow-service');
        expect(classifier.serviceTypeForDomain(domain),
            TransactionServiceType.escrow,
            reason: '$cat should still be an escrow row');
      }
    });

    test('the release leg is not mistaken for a plain transfer', () {
      // "escrow_release" contains neither "transfer" nor "refund", but the
      // description does once a title is in play — pin the domain explicitly.
      expect(
        classifier.classifyDomain('escrow_release', 'Escrow release: Laptop',
            'ESCROW-SETTLE-abc', 'escrow-service'),
        'escrow_release',
      );
      expect(
        classifier.classifyDomain('escrow_refund', 'Escrow refund: TV',
            'ESCROW-REFUND-abc', 'escrow-service'),
        'escrow_refund',
      );
    });
  });
}
