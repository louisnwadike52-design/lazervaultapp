import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/crypto_pay/domain/payment_method_breakdown.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/external_transfer_merge.dart';

/// A CRYPTO-FUNDED TRANSFER IS REPORTED BY THREE ROWS, AND THE SPLIT IS ON
/// THE ONE THE LEDGER DOES NOT JOIN TO.
///
/// Paying for a bank transfer out of crypto writes:
///
///   * `TRF-…`         the AUTHORISING payment, created when the customer
///                     chose to pay with crypto and nothing had moved. This is
///                     where core-payments records the crypto/wallet split,
///                     because the funding event meets the payment here.
///   * `TRF-…-EXEC`    the EXECUTION, which runs once the conversion lands and
///                     is what actually debits the wallet.
///   * `HOLD-CAP-…`    the accounts-service LEDGER row for that debit, which
///                     carries `metadata.reference = TRF-…-EXEC`.
///
/// Two separate defects fell out of that, both invisible in the code:
/// the transfer appeared TWICE in history, and the split was fetched by the
/// app and dropped one line before anything could render it.
UnifiedTransaction _row({
  required String id,
  required String ref,
  required double amount,
  Map<String, dynamic>? metadata,
  String? counterpartyName,
  UnifiedTransactionStatus status = UnifiedTransactionStatus.completed,
}) =>
    UnifiedTransaction(
      id: id,
      serviceType: TransactionServiceType.transfer,
      title: 'Transfer',
      amount: amount,
      currency: 'NGN',
      createdAt: DateTime(2026, 11, 21, 14, 30),
      status: status,
      flow: TransactionFlow.outgoing,
      transactionReference: ref,
      counterpartyName: counterpartyName,
      metadata: metadata,
    );

/// What core-payments projects onto the authorising row: ₦5,023 paid, ₦3,000
/// of it from 1.93548387 USDT and the remaining ₦2,023 from the wallet.
const _funding = <String, dynamic>{
  'funding_source': 'crypto',
  'funding_asset': 'usdt',
  'funding_crypto_minor': 300000,
  'funding_fiat_minor': 202300,
  'funding_total_minor': 502300,
  'funding_asset_amount': '1.93548387',
};

/// The ledger row, which joins by the EXECUTION reference it carries.
UnifiedTransaction _ledger() => _row(
      id: 'ledger-1',
      ref: 'HOLD-CAP-abc',
      amount: 5023,
      metadata: const {'reference': 'TRF-9001-EXEC', 'bank_name': 'GTBank'},
    );

UnifiedTransaction _authorising() => _row(
      id: 'pay-auth',
      ref: 'TRF-9001',
      amount: 5000,
      counterpartyName: 'GRACE C',
      metadata: _funding,
    );

UnifiedTransaction _execution() => _row(
      id: 'pay-exec',
      ref: 'TRF-9001-EXEC',
      amount: 5000,
      counterpartyName: 'GRACE C',
      metadata: const {'bank_name': 'GTBank'},
    );

void main() {
  group('one transfer, one row', () {
    test('the authorising row and the -EXEC row collapse together', () {
      final out = mergeExternalTransfers(
        [_ledger()],
        [_authorising(), _execution()],
      );
      expect(out, hasLength(1),
          reason: 'a crypto-funded transfer used to list twice — the '
              'authorising row and the execution had different keys, and both '
              'are external and completed, so both were shown');
    });

    test('an ordinary transfer is untouched by the -EXEC rule', () {
      // The suffix strip must not collapse rows that merely END in something
      // similar, and an ordinary transfer has no execution row at all.
      final out = mergeExternalTransfers(
        [_row(id: 'l', ref: 'HOLD-CAP-x', amount: 223, metadata: const {
          'reference': 'TRF-7000'
        })],
        [_row(id: 'p', ref: 'TRF-7000', amount: 200)],
      );
      expect(out, hasLength(1));
      expect(out.first.amount, 223, reason: 'the ledger still wins the total');
      expect(out.first.metadata?['external_principal'], 200);
    });

    test('two genuinely different transfers stay two rows', () {
      final out = mergeExternalTransfers(
        [],
        [
          _row(id: 'a', ref: 'TRF-1', amount: 100),
          _row(id: 'b', ref: 'TRF-2', amount: 200),
        ],
      );
      expect(out, hasLength(2));
    });
  });

  group('the split reaches the merged row', () {
    test('and is readable as a breakdown', () {
      final out = mergeExternalTransfers(
        [_ledger()],
        [_authorising(), _execution()],
      );
      final b = PaymentMethodBreakdown.from(out.first.metadata);
      expect(b, isNotNull,
          reason: 'the merge kept the ledger metadata and discarded the '
              'payment row, so this was always null');
      expect(b!.cryptoMinor, 300000);
      expect(b.fiatMinor, 202300);
      expect(b.totalMinor, 502300);
      expect(b.assetLabel, 'USDT');
      expect(b.assetAmount, '1.93548387');
      expect(b.isSplit, isTrue);
    });

    test('whichever order the payment rows arrive in', () {
      // The rows come back from one list in whatever order the server
      // returned them, and only ONE of the two carries the funding keys. If
      // the row without them could overwrite, the breakdown would appear or
      // vanish depending on the sort — the worst kind of bug to be told about.
      for (final payments in [
        [_authorising(), _execution()],
        [_execution(), _authorising()],
      ]) {
        final out = mergeExternalTransfers([_ledger()], payments);
        expect(out, hasLength(1));
        expect(PaymentMethodBreakdown.from(out.first.metadata), isNotNull,
            reason: 'order ${payments.map((p) => p.id).toList()} lost it');
      }
    });

    test('the ledger row still wins the amount and the bank', () {
      // Carrying the funding keys must not let the payment row take over the
      // fields the ledger is authoritative for.
      final out = mergeExternalTransfers(
        [_ledger()],
        [_authorising(), _execution()],
      );
      expect(out.first.amount, 5023, reason: 'the money that actually left');
      expect(out.first.metadata?['bank_name'], 'GTBank');
      expect(out.first.metadata?['reference'], 'TRF-9001-EXEC',
          reason: 'the join key must survive, or the next merge un-joins it');
      expect(out.first.counterpartyName, 'GRACE C');
    });
  });

  group('an ordinary payment never claims to be crypto-funded', () {
    test('figures with no funding_source are not carried', () {
      // Defence in depth: core-payments refuses to project these, and the
      // merge refuses to accept them. Either alone would be enough today;
      // both means a change to one side cannot produce a false receipt.
      final out = mergeExternalTransfers(
        [_ledger()],
        [
          _row(id: 'p', ref: 'TRF-9001', amount: 5000, metadata: const {
            'funding_crypto_minor': 300000,
            'funding_fiat_minor': 202300,
          }),
        ],
      );
      expect(out.first.metadata?.containsKey('funding_crypto_minor'), isFalse);
      expect(PaymentMethodBreakdown.from(out.first.metadata), isNull);
    });

    test('a wallet transfer has no breakdown', () {
      final out = mergeExternalTransfers(
        [_row(id: 'l', ref: 'HOLD-CAP-y', amount: 223, metadata: const {
          'reference': 'TRF-8000',
          'bank_name': 'Access'
        })],
        [_row(id: 'p', ref: 'TRF-8000', amount: 200)],
      );
      expect(PaymentMethodBreakdown.from(out.first.metadata), isNull);
    });
  });

  group('a transfer still waiting on its conversion', () {
    test('shows on its own, with the split it already has', () {
      // Before the conversion settles there is no ledger row and no execution
      // — only the authorising payment. It must still be listed, or a
      // customer who has committed their crypto sees nothing at all.
      final out = mergeExternalTransfers(
        [],
        [
          _row(
            id: 'pay-auth',
            ref: 'TRF-9002',
            amount: 5000,
            status: UnifiedTransactionStatus.processing,
            metadata: const {
              'funding_source': 'crypto',
              'funding_asset': 'usdt',
            },
          )
        ],
      );
      expect(out, hasLength(1));
      expect(out.first.status, UnifiedTransactionStatus.processing);
      // No figures yet, so no breakdown — but the row is there and honest.
      expect(PaymentMethodBreakdown.from(out.first.metadata), isNull);
      expect(out.first.metadata?['funding_asset'], 'usdt');
    });
  });
}
