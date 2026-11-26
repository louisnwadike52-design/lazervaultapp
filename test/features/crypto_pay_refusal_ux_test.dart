import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_coverage_dialog.dart';

/// THE CUSTOMER WHO WAS TOLD HIS TRANSFER FAILED WHEN IT HAD NOT.
///
/// He chose Pay with Crypto on a ₦1,023 transfer while his wallet already
/// covered it. Under the `shortfall` fund mode there was nothing to convert,
/// so the server refused — correctly, after the PIN. The app then showed a red
/// cross and "Transfer Failed" directly above body text reading "Nothing was
/// converted and you have not been charged."
///
/// Two separate defects on one screen:
///   1. the condition was knowable BEFORE the PIN and was not surfaced;
///   2. a refusal was rendered as a failure.
///
/// The ledger confirmed no money moved on that attempt. The damage was purely
/// what he was told.
void main() {
  group('the wallet-covers case is caught before the PIN', () {
    test('a wallet that covers the payment is its own state', () {
      // Checked BEFORE the coin's own coverage: it is the fact that decides
      // whether converting is needed at all.
      expect(
        assessCoverage(
            amountMinor: 102300, coinValueMinor: 500000, walletMinor: 150000),
        CryptoCoverage.walletAlreadyCovers,
        reason: 'the wallet alone covers ₦1,023 — the customer must be told '
            'before their PIN, not after the server refuses',
      );
    });

    test('it is NOT reported when the wallet falls short', () {
      expect(
        assessCoverage(
            amountMinor: 102300, coinValueMinor: 500000, walletMinor: 50000),
        CryptoCoverage.covers,
        reason:
            'the coin covers it and the wallet does not — ordinary crypto payment',
      );
    });

    test('an unreadable wallet is not treated as covering it', () {
      // null is "unknown", never "enough". Claiming the wallet covers a
      // payment on a balance we failed to load would send someone back to a
      // wallet that cannot pay.
      expect(
        assessCoverage(
            amountMinor: 102300, coinValueMinor: 500000, walletMinor: null),
        CryptoCoverage.covers,
      );
    });

    test('an unpriceable coin still defers to the server', () {
      // We cannot claim anything either way; refusing here would decline a
      // payment that would have worked.
      expect(
        assessCoverage(
            amountMinor: 102300, coinValueMinor: null, walletMinor: 150000),
        CryptoCoverage.unknown,
      );
    });

    test('coin and wallet together falling short is still insufficient', () {
      expect(
        assessCoverage(
            amountMinor: 102300, coinValueMinor: 40000, walletMinor: 10000),
        CryptoCoverage.insufficient,
      );
    });
  });

  group('a refusal is not rendered as a failure', () {
    String code(String path) => File(path).readAsLinesSync().where((l) {
          final t = l.trimLeft();
          return !t.startsWith('//') && !t.startsWith('///');
        }).join('\n');

    test('the transfer receipt branches on a spend refusal before failure', () {
      final src = code(
          'lib/src/features/funds/presentation/view/send_funds/transfer_receipt_screen.dart');
      // The FULL branch condition, not just the getter name: a bare
      // '_isSpendRefusal)' also matches 'false && _isSpendRefusal)', which is
      // how this guard was proved toothless the first time it was written.
      final refusal =
          src.indexOf('failedStates.contains(s) && _isSpendRefusal)');
      final failed =
          src.indexOf("titleText = _isBatch ? 'Batch Transfer Failed'");
      expect(refusal, greaterThan(-1),
          reason: 'the receipt no longer distinguishes a refusal, so a payment '
              'that never started is shown as Failed again');
      expect(refusal, lessThan(failed),
          reason: 'the refusal branch must come FIRST — Dart takes the first '
              'matching else-if, so a later branch never runs');
    });

    test('the refusal wording and the headline cannot contradict', () {
      // The copy promises "you have not been charged". A headline of "Failed"
      // over that promise is the contradiction this fixes, so the receipt
      // falls back to the message when the flag is not threaded.
      final src = code(
          'lib/src/features/funds/presentation/view/send_funds/transfer_receipt_screen.dart');
      expect(src, contains('you have not been charged'),
          reason: 'the message fallback is gone; call sites that do not pass '
              'isSpendRefusal would show Failed again');
    });

    test('the conversion sheet does not paint the wallet case as danger', () {
      final src = code(
          'lib/src/features/crypto_pay/presentation/crypto_conversion_sheet.dart');
      expect(src, contains('walletCovers'),
          reason: 'the sheet no longer handles the wallet-covers state');
      expect(src, contains('Your wallet already covers this'));
    });
  });
}
