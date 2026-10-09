import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/transfer_bank_display.dart';
import 'package:lazervault/src/features/funds/domain/batch_item_unified.dart';

/// Reported: "Details in batch transfer receipt from [the batch] flow should
/// be the same as the sendfunds receipt and share — and the same when the user
/// accesses the receipt from batch transfer history, general history or any
/// other history source."
///
/// They were not. One payment had three layouts and two PDF generators: the
/// item receipt screen hand-built its own header, Download/Share pair and
/// eight-row Details card; the batch receipt and batch detail screens each had
/// an inline per-recipient download/share calling BatchTransferPdfService with
/// a loose map; and transaction history rendered the same payment through
/// UnifiedTransactionReceipt. This is the single projection they now share.
void main() {
  group('status', () {
    test('a FAILED item is REFUNDED, not FAILED', () {
      // A failed item released its hold, so the money is already back. On a
      // document someone may show a merchant, "Failed" is the ambiguity the
      // refunded state exists to remove.
      expect(batchItemStatus('failed'), UnifiedTransactionStatus.refunded);
      expect(batchItemStatus('reversed'), UnifiedTransactionStatus.refunded);
    });

    test('success spellings all complete', () {
      for (final s in ['success', 'successful', 'completed', 'COMPLETED', ' completed ']) {
        expect(batchItemStatus(s), UnifiedTransactionStatus.completed,
            reason: s);
      }
    });

    test('in-flight states', () {
      for (final s in ['pending', 'processing', 'queued', 'submitted']) {
        expect(batchItemStatus(s), UnifiedTransactionStatus.processing,
            reason: s);
      }
    });

    test('an unknown status is never asserted as completed', () {
      expect(batchItemStatus('something_new'),
          UnifiedTransactionStatus.processing);
      expect(batchItemStatus(''), UnifiedTransactionStatus.processing);
    });
  });

  group('projection', () {
    final tx = batchItemUnified(
      itemId: 'item-1',
      status: 'completed',
      amount: 100,
      currency: 'NGN',
      fee: 26.88,
      reference: 'BT-REF-1',
      recipientName: 'GRACE C. ONWUANAKU',
      recipientAccount: '0123456789',
      bankName: 'Zenith Bank',
      bankCode: '057',
      narration: 'September payout',
      providerName: 'flutterwave',
      batchId: 'batch-9',
      sourceAccountName: 'Louis N',
      sourceAccountNumber: '9988776655',
      at: DateTime.utc(2026, 10, 1, 9, 30),
    );

    test('money leaves the account', () {
      expect(tx.flow, TransactionFlow.outgoing);
      expect(tx.serviceType, TransactionServiceType.transfer);
      expect(tx.amount, 100);
    });

    test('the item id, not the batch id, identifies the receipt', () {
      // Two recipients in one batch are two receipts; keying on the batch
      // would collide them in any cache.
      expect(tx.id, 'item-1');
      expect(tx.metadata!['batch_id'], 'batch-9');
    });

    test('the destination bank resolves, logo code included', () {
      // The loose map the inline buttons used to build carried no bank at
      // all, so the per-recipient PDF named no institution. The resolver
      // reads both the name and the code; the code is what BankLogo matches.
      final bank = TransferBankDisplay.resolve(tx.metadata, isTransfer: true);
      expect(bank?.name, 'Zenith Bank');
      expect(bank?.code, '057');
    });

    test('fee travels in MINOR units under the *_minor convention', () {
      // A bare `fee` key would be printed as a raw number by the receipt's
      // generic metadata rendering; `fee_minor` is humanized into money.
      expect(tx.metadata!['fee_minor'], 2688);
      expect(tx.metadata!.containsKey('fee'), false);
    });

    test('an absent field produces no empty row', () {
      final bare = batchItemUnified(
        itemId: 'i', status: 'completed', amount: 10, currency: 'NGN',
      );
      for (final k in [
        'recipient_bank_name',
        'fee_minor',
        'reason',
        'batch_id',
        'provider',
      ]) {
        expect(bare.metadata!.containsKey(k), false, reason: k);
      }
      expect(bare.transactionReference, isNull);
      expect(bare.counterpartyName, isNull);
    });

    test('a failure reason becomes the receipt reason row', () {
      final failed = batchItemUnified(
        itemId: 'i', status: 'failed', amount: 10, currency: 'NGN',
        failureReason: 'Account does not exist',
      );
      expect(failed.status, UnifiedTransactionStatus.refunded);
      expect(failed.metadata!['reason'], 'Account does not exist');
    });

    test('no balances are invented', () {
      // Batch items do not record them, and a guess on a document people
      // treat as proof of what their account held is worse than no row.
      expect(tx.balanceBefore, isNull);
      expect(tx.balanceAfter, isNull);
    });
  });

  group('from the loose map the inline buttons build', () {
    test('produces the same shape as the typed projection', () {
      final mapped = batchItemUnifiedFromMap(
        {
          'recipientName': 'GRACE C. ONWUANAKU',
          'recipientAccount': '0123456789',
          'amount': 100.0,
          'fee': 26.88,
          'status': 'completed',
          'failureReason': '',
          'reference': 'BT-REF-1',
        },
        batchId: 'batch-9',
        currency: 'NGN',
      );
      expect(mapped.amount, 100);
      expect(mapped.status, UnifiedTransactionStatus.completed);
      expect(mapped.metadata!['fee_minor'], 2688);
      expect(mapped.transactionReference, 'BT-REF-1');
      expect(mapped.counterpartyName, 'GRACE C. ONWUANAKU');
    });

    test('numbers arriving as strings still parse', () {
      final mapped = batchItemUnifiedFromMap(
        {'amount': '250.5', 'fee': '3', 'status': 'completed'},
        batchId: 'b',
      );
      expect(mapped.amount, 250.5);
      expect(mapped.metadata!['fee_minor'], 300);
    });

    test('a row with no reference still gets a unique id', () {
      // Falling back to the batch id alone would give every recipient in the
      // batch the same receipt identity.
      final a = batchItemUnifiedFromMap(
          {'recipientAccount': '111', 'status': 'completed', 'amount': 1},
          batchId: 'b');
      final b = batchItemUnifiedFromMap(
          {'recipientAccount': '222', 'status': 'completed', 'amount': 1},
          batchId: 'b');
      expect(a.id, isNot(b.id));
    });
  });
}
