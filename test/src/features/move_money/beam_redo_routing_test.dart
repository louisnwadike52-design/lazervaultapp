import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/move_money/presentation/receipts/beam_receipt_payload.dart';

// WHICH RAIL DID THIS TRANSFER ACTUALLY USE?
//
// getPaymentHistory has NO rail filter — it returns every payment on the
// account, interbank ones included — and the Beam dashboard feeds them all
// through the wallet payload builder. That builder hardcoded the wallet rail,
// so a payout that really went to someone's bank rendered as
// "Type: Wallet transfer / Bank: Lazervault Wallet".
//
// `type` ("internal" | "external", from the proto's transfer_type) has carried
// the answer all along, and these tests hold the builder to it.
//
// NOTE ON SCOPE: this file also used to assert `redoRoute`/`redoArgs`, because
// the receipt carried a "Redo" CTA. That CTA is gone — it reopened the wallet
// flow on its empty "Select Accounts" step, asking the user to rebuild a
// transfer they had just made — and repeating now happens from the transaction
// row via RepeatTransfer (see repeat_transfer_test.dart). Those assertions were
// removed with the feature. The rail-labelling ones stay, because the mislabel
// they guard against was a real production defect and is independent of Redo.

PaymentsTransferResult tx({String? type, String? bank}) =>
    PaymentsTransferResult(
      success: true,
      transferId: 't-1',
      reference: 'BTF-0-1',
      status: 'completed',
      amount: 10000,
      fee: 0,
      currency: 'NGN',
      recipientName: 'GRACE C. ONWUANAKU',
      description: 'Lazervault/GRACE C. ONWUANAKU',
      sourceAccountId: 'src',
      destinationAccountId: 'dst',
      destinationBankName: bank,
      type: type,
    );

Map<String, dynamic> payload(PaymentsTransferResult r) =>
    beamReceiptPayloadFromWalletTransfer(r, sourceName: 'Praiz Onah');

void main() {
  group('external (bank) transfer', () {
    test('is not labelled a wallet transfer', () {
      final p = payload(tx(type: 'external', bank: 'Zenith bank PLC'));
      expect(p['transferType'], 'Bank transfer');
      expect(p['recipientBankName'], 'Zenith bank PLC');
    });

    test('never claims the payee banks with Lazervault', () {
      // The exact mislabel from the receipt: Bank = LazervaultWallet on a
      // transfer that left the platform.
      final p = payload(tx(type: 'external', bank: 'Zenith bank PLC'));
      expect(p['recipientBankName'], isNot(contains('Lazervault')));
    });

    test('a missing bank name still does not fall back to Lazervault', () {
      final p = payload(tx(type: 'external'));
      expect(p['recipientBankName'], 'Recipient bank');
      expect(p['transferType'], 'Bank transfer');
    });

    test('the rail check is case-insensitive', () {
      // 'EXTERNAL' must not be read as internal and relabelled a wallet move.
      final p = payload(tx(type: 'EXTERNAL', bank: 'Zenith bank PLC'));
      expect(p['transferType'], 'Bank transfer');
      expect(p['recipientBankName'], isNot(contains('Lazervault')));
    });
  });

  group('internal (wallet) transfer', () {
    test('is labelled a wallet transfer on both legs', () {
      final p = payload(tx(type: 'internal'));
      expect(p['transferType'], 'Wallet transfer');
      expect(p['recipientBankName'], 'Lazervault Wallet');
      expect(p['sourceBankName'], 'Lazervault Wallet');
    });

    test('an absent type is treated as internal', () {
      // The flow screen synthesizes a just-completed wallet transfer with no
      // type — internal by construction. Guessing "external" there would
      // mislabel an internal move as a bank transfer.
      final p = payload(tx());
      expect(p['transferType'], 'Wallet transfer');
    });
  });

  group('the removed Redo payload', () {
    test('is gone from both builders', () {
      // Pins the removal: a stale `redoRoute` left on the payload would
      // advertise a CTA the receipt no longer renders, and send the next
      // reader looking for a code path that cannot fire.
      for (final p in [
        payload(tx(type: 'internal')),
        payload(tx(type: 'external', bank: 'Zenith bank PLC')),
      ]) {
        expect(p.containsKey('redoRoute'), isFalse);
        expect(p.containsKey('redoArgs'), isFalse);
        expect(p.containsKey('redoLabel'), isFalse);
      }
    });
  });
}
