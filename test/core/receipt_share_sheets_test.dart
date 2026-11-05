import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Two sheets stood between the user and a shared receipt, and neither earned
/// its place on every share.
void main() {
  late String receipt;
  late String flags;

  setUpAll(() {
    receipt =
        File('lib/src/features/widgets/unified_transaction_receipt.dart')
            .readAsStringSync();
    flags = File('lib/core/config/feature_flags.dart').readAsStringSync();
  });

  group('the copy chooser only appears when the copies differ', () {
    test('it is gated on there being a fee', () {
      // The sender's and the recipient's copy are the same document except
      // for the fee line, which is the sender's cost and must never appear on
      // the beneficiary's. A Lazervault-to-Lazervault transfer has no fee, so
      // the two render identically and the question has no meaning.
      expect(receipt.contains('final hasFee = (_externalFee ?? 0) > 0;'), isTrue,
          reason: 'the fee gate is gone, so a zero-fee internal transfer asks '
              'the user to choose between two identical documents');
      final at = receipt.indexOf('final offerCopy =');
      expect(at, greaterThan(-1));
      expect(receipt.substring(at, at + 220).contains('hasFee'), isTrue,
          reason: 'offerCopy does not consult hasFee');
    });

    test('direction still decides the copy when no choice is offered', () {
      // Hardcoding `sender` stamped every incoming receipt "SENDER'S COPY" and
      // itemised a fee the receiver never paid. Skipping the sheet must not
      // reintroduce that.
      expect(receipt.contains('tx.flow == TransactionFlow.incoming'), isTrue);
      expect(receipt.contains('ReceiptCopyType.recipient'), isTrue);
    });
  });

  group('the PDF/JPG chooser is admin-gated and off by default', () {
    test('the share is wrapped in the flag', () {
      expect(receipt.contains('FeatureFlags.receiptFormatSheetEnabled'), isTrue,
          reason: 'the format sheet shows unconditionally again');
      final gate = receipt.indexOf('FeatureFlags.receiptFormatSheetEnabled');
      final show = receipt.indexOf('_showReceiptFormatSheet(actionLabel)');
      expect(gate, lessThan(show),
          reason: 'the flag must be checked before the sheet is shown');
    });

    test('skipping it still shares — it does not return early', () {
      // The sheet returning null means "cancelled" and returns. With the sheet
      // skipped there is nothing to cancel, so the share must proceed on the
      // default format rather than silently doing nothing.
      final gate = receipt.indexOf('FeatureFlags.receiptFormatSheetEnabled');
      final tail = receipt.substring(gate, gate + 700);
      expect(tail.contains('await action();'), isTrue,
          reason: 'the share must still run when the chooser is skipped');
    });

    test('a default format exists to fall back to', () {
      expect(
        receipt.contains('ReceiptFileFormat _chosenFormat = ReceiptFileFormat.pdf'),
        isTrue,
        reason: 'with the chooser off there would be no format at all',
      );
    });
  });

  group('both flags default to hidden and reach the app', () {
    for (final f in const [
      ('themeSwitchVisible', 'theme_switch_visible'),
      ('receiptFormatSheetVisible', 'receipt_format_sheet_visible'),
    ]) {
      test('${f.$2} is declared, bulk-read and defaults false', () {
        expect(flags.contains("'${f.$2}'"), isTrue, reason: 'key missing');
        // Must be in the bulk-read list or the snapshot never carries it and
        // the admin toggle appears to do nothing.
        final listAt = flags.indexOf('kycRequiredOnSignup,');
        expect(listAt, greaterThan(-1));
        expect(flags.substring(listAt, listAt + 400).contains(f.$1), isTrue,
            reason: '${f.$1} is not in the bulk-read list, so the admin value '
                'never reaches the app and the flag is stuck on its default');
        expect(flags.contains('getBool(${f.$1}) ?? false'), isTrue,
            reason: 'must default to FALSE — an unreadable config should not '
                'reveal a control');
      });
    }
  });
}
