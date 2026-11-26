import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// EVERY BILL A CUSTOMER CAN PAY WITH CRYPTO MUST SAY SO ON ITS RECEIPT.
///
/// utility-payments records the split on the payment row the moment the
/// conversion's outcome meets it. For a long while exactly one surface read it
/// back — the transfer receipt — so a customer who bought data with USDT got a
/// receipt showing a bare naira total, and the document they forwarded said
/// even less.
///
/// Electricity was the last one, and it was stuck: `electricity_bill.proto`
/// carried no metadata field at all, so the data never reached the app.
///
/// This is a SOURCE-TEXT guard, which is blunt on purpose: the alternative is
/// six widget tests that each need a payment entity, a cubit and a pumped
/// tree, and the thing actually worth pinning is that nobody adds a seventh
/// bill receipt without the row.
void main() {
  // Comment lines are stripped before matching. This repo has had a guard pass
  // on text inside the very comment explaining it; prose must not satisfy a
  // check about code.
  String code(String path) {
    final f = File(path);
    if (!f.existsSync()) fail('missing file: $path');
    return f.readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');
  }

  // THE INTERNATIONAL VARIANTS ARE DELIBERATELY ABSENT.
  //
  // intl airtime and intl data have no Pay-with-Crypto selector on any of
  // their screens, so their receipts have no coin to name and adding the rows
  // would print a section that can never populate. If a crypto selector is
  // ever added to an intl flow, its receipt and PDF belong in these maps.
  const screens = <String, String>{
    // Airtime was the gap this guard was supposed to close and did not: it was
    // never listed, so when the 1.0.1+544 notes said airtime receipts name the
    // coin, nothing was checking, and they did not. Added 2026-11-24 with the
    // rows themselves.
    'airtime':
        'lib/src/features/airtime/presentation/view/airtime_payment_confirmation_screen.dart',
    'data':
        'lib/src/features/data_bundles/presentation/view/data_payment_receipt_screen.dart',
    'cable TV':
        'lib/src/features/cable_tv/presentation/view/cable_tv_payment_receipt_screen.dart',
    'internet':
        'lib/src/features/internet_bill/presentation/view/internet_payment_receipt_screen.dart',
    'water':
        'lib/src/features/water_bill/presentation/view/water_bill_payment_receipt_screen.dart',
    'electricity':
        'lib/src/features/electricity_bill/presentation/view/payment_receipt_screen.dart',
  };

  const pdfs = <String, String>{
    'airtime': 'lib/src/features/airtime/services/airtime_pdf_service.dart',
    'data':
        'lib/src/features/data_bundles/services/data_bundles_pdf_service.dart',
    'cable TV': 'lib/src/features/cable_tv/services/cable_tv_pdf_service.dart',
    'internet':
        'lib/src/features/internet_bill/services/internet_bill_pdf_service.dart',
    'water': 'lib/src/features/water_bill/services/water_bill_pdf_service.dart',
    'electricity':
        'lib/src/features/electricity_bill/services/electricity_bill_pdf_service.dart',
  };

  group('the screen a customer reads', () {
    screens.forEach((name, path) {
      test('$name names the coin that paid', () {
        expect(code(path), contains('nairaFundingRows('),
            reason: 'the $name receipt shows a bare naira total — a customer '
                'who paid out of crypto cannot tell which balance it came '
                'from, which is the whole of what they check afterwards');
      });
    });
  });

  group('the document a customer forwards', () {
    pdfs.forEach((name, path) {
      test('$name says the same as its screen', () {
        expect(code(path), contains('nairaFundingRowsAscii('),
            reason: 'the $name PDF omits the split its own screen shows. The '
                'PDF is the copy other people read, so that divergence is the '
                'one that matters');
      });
    });
  });

  test('the PDFs use the ASCII variant, never the screen one', () {
    // The screen helper composes with an em-dash (U+2014). The PDF font falls
    // back to base-14 Helvetica, which latin1-encodes and THROWS above 255, so
    // the wrong helper would crash receipt generation offline — the one moment
    // nobody can report it.
    pdfs.forEach((name, path) {
      final src = code(path);
      final usesScreenHelper = RegExp(r'nairaFundingRows\(').hasMatch(src);
      expect(usesScreenHelper, isFalse,
          reason: '$name PDF calls the SCREEN helper; its em-dash would throw '
              'in the Helvetica fallback and take the document with it');
    });
  });

  test('the unified receipt — airtime\'s OTHER surface — reads the breakdown', () {
    // CORRECTED 2026-11-24. This test used to be titled "airtime needs none of
    // this, and that is deliberate", on the premise that local airtime "has no
    // receipt screen of its own". That was wrong, and the wrong premise is why
    // airtime was missing from the maps above while the 1.0.1+544 release notes
    // said its receipts named the coin.
    //
    // Local airtime has THREE receipt surfaces, not one:
    //
    //   1. UnifiedTransactionReceipt — the history row. Covered, and pinned
    //      here, because nothing else would catch it going quiet.
    //   2. airtime_payment_confirmation_screen — what the customer sees
    //      immediately after paying, which is exactly when they ask which
    //      balance it came out of. It has its own detail rows, its own QR
    //      block and its own download/share buttons.
    //   3. airtime_pdf_service — the document those buttons produce.
    //
    // (2) and (3) are now in the maps above. This case keeps (1).
    expect(
      code('lib/src/features/widgets/unified_transaction_receipt.dart'),
      contains('PaymentMethodBreakdown.from('),
      reason: 'the unified receipt is what local airtime (and every other '
          'history row) uses; if it stops reading the breakdown, airtime '
          'silently loses the row with nothing else to catch it',
    );
  });

  test('the electricity entity actually carries the metadata', () {
    // The proto field was the blocker: electricity_bill.proto had none, so the
    // receipt could render nothing however it was written. Pin the whole chain
    // — proto, entity, mapper — because any one of them going missing puts the
    // receipt back to a bare total with no error anywhere.
    expect(File('proto/electricity_bill.proto').readAsStringSync(),
        contains('string metadata = 28;'),
        reason: 'the electricity proto lost its metadata field');
    expect(
        code(
            'lib/src/features/electricity_bill/domain/entities/bill_payment_entity.dart'),
        contains('final String? metadata;'));
    expect(
        code(
            'lib/src/features/electricity_bill/data/models/bill_payment_model.dart'),
        contains('proto.hasMetadata()'),
        reason: 'the model stopped reading metadata off the proto, so the '
            'entity would be null however the backend fills it');
  });
}
