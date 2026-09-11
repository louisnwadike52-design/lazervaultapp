import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/move_money/presentation/receipts/beam_receipt_payload.dart';

// getPaymentHistory has NO rail filter — it returns every payment on the
// account, interbank ones included — and the Beam dashboard feeds them all
// through the wallet payload builder. That builder hardcoded the wallet rail,
// so a payout that really went to someone's bank rendered as
// "Type: Wallet transfer / Bank: Lazervault Wallet", and its Redo re-opened the
// WALLET flow for a transfer that had never touched it.
//
// `type` ("internal" | "external", from the proto's transfer_type) has carried
// the answer all along.

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
    test('Redo re-opens the BANK flow, not the wallet flow', () {
      final p = payload(tx(type: 'external', bank: 'Zenith bank PLC'));
      expect(p['redoRoute'], AppRoutes.moveMoneyTransfer);
      expect(p['redoRoute'], isNot(AppRoutes.walletTransfer));
    });

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

    test('does not pre-select wallet account ids the bank flow cannot use', () {
      final args = payload(tx(type: 'external', bank: 'Zenith bank PLC'))
          ['redoArgs'] as Map<String, dynamic>;
      expect(args.containsKey('sourceAccountId'), isFalse);
      expect(args.containsKey('destinationAccountId'), isFalse);
      // The useful parts still carry over.
      expect(args['amount'], 100.0);
      expect(args['narration'], isNotNull);
    });
  });

  group('internal (wallet) transfer', () {
    test('Redo re-opens the wallet flow and pre-selects both accounts', () {
      final p = payload(tx(type: 'internal'));
      expect(p['redoRoute'], AppRoutes.walletTransfer);
      final args = p['redoArgs'] as Map<String, dynamic>;
      expect(args['sourceAccountId'], 'src');
      expect(args['destinationAccountId'], 'dst');
    });

    test('is labelled a wallet transfer on both legs', () {
      final p = payload(tx(type: 'internal'));
      expect(p['transferType'], 'Wallet transfer');
      expect(p['recipientBankName'], 'Lazervault Wallet');
      expect(p['sourceBankName'], 'Lazervault Wallet');
    });

    test('an absent type is treated as internal', () {
      // The flow screen synthesizes a just-completed wallet transfer with no
      // type — internal by construction. Guessing "external" there would send
      // the user to the bank flow after an internal transfer.
      final p = payload(tx());
      expect(p['redoRoute'], AppRoutes.walletTransfer);
      expect(p['transferType'], 'Wallet transfer');
    });

    test('the rail check is case-insensitive', () {
      expect(payload(tx(type: 'EXTERNAL'))['redoRoute'],
          AppRoutes.moveMoneyTransfer);
    });
  });
}
