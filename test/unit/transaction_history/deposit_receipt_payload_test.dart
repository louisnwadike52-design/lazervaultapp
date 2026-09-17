import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

/// A deposit receipt has to say who sent the money.
///
/// banking-service writes "Deposit from Praiz Onah" and leaves
/// counterparty_name EMPTY (verified against production), so the receipt's From
/// line had nobody to name — the document proving money arrived could not say
/// where it came from. The name is only ever in the description.
void main() {
  group('deposits are classified so a receipt can be produced at all', () {
    test('a deposit resolves to the deposit identity, not unknown', () {
      // Until this held, deposits could never match the PDF allowlist, so
      // Share/Download handed back a flat screenshot.
      expect(
        inferServiceTypeFromCategory(
            'deposit', 'credit', 'Deposit from Praiz Onah', '', 'banking-service'),
        TransactionServiceType.deposit,
      );
    });

    test('a withdrawal keeps its own identity', () {
      expect(
        inferServiceTypeFromCategory(
            'withdrawal', 'debit', 'Withdrawal to GTBank', '', 'banking-service'),
        TransactionServiceType.withdrawal,
      );
    });
  });
}
