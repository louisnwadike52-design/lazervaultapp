import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto_pay/domain/payment_method_breakdown.dart';

/// WHAT THIS PINS.
///
/// A crypto-funded BILL recorded the split correctly — utility-payments writes
/// `funding_source` / `funding_asset` / `funding_crypto_minor` /
/// `funding_fiat_minor` onto the purchase the moment the conversion's outcome
/// meets it — and then showed the customer a receipt that said only the naira
/// total. Six bill receipts and six share-PDFs, none of which mentioned the
/// coin that had been sold to pay for it.
///
/// The transfer receipt had these rows from the start. The bills did not,
/// because each keeps its metadata in a different shape and nothing made the
/// rows easy to reach from all of them.
void main() {
  Map<String, dynamic> cryptoFunded({int crypto = 80000, int fiat = 20000}) => {
        'funding_source': 'crypto',
        'funding_asset': 'usdt',
        'funding_crypto_minor': crypto,
        'funding_fiat_minor': fiat,
        'funding_total_minor': crypto + fiat,
        'funding_asset_amount': '0.53241100',
      };

  group('decodeFundingMetadata takes every shape a bill entity uses', () {
    test('a decoded map (data bundles)', () {
      expect(decodeFundingMetadata(cryptoFunded()), isNotNull);
    });

    test('a raw JSON string (water, cable TV, internet)', () {
      final rows = nairaFundingRows(jsonEncode(cryptoFunded()));
      expect(rows, isNotEmpty,
          reason: 'a receipt whose metadata is the raw JSON string the '
              'backend sent must still render the split');
    });

    test('null, empty and malformed are silent, never thrown', () {
      // A receipt that throws on bad metadata loses the whole document over a
      // row that is merely informative.
      for (final bad in <Object?>[null, '', '   ', '{not json', 42, <int>[]]) {
        expect(() => nairaFundingRows(bad), returnsNormally);
        expect(nairaFundingRows(bad), isEmpty);
      }
    });
  });

  test('an ordinary wallet purchase adds no rows at all', () {
    // Almost every bill. The caller splats these unconditionally, so "nothing
    // to say" has to mean an empty list rather than a placeholder row.
    expect(nairaFundingRows({'plan_name': 'MTN 1GB'}), isEmpty);
    expect(nairaFundingRowsAscii({'plan_name': 'MTN 1GB'}), isEmpty);
  });

  test('a split names both legs, coin first, with the quantity', () {
    final rows = nairaFundingRows(cryptoFunded());
    expect(rows.length, 2);
    expect(rows.first.key, 'Primary payment method');
    expect(rows.first.value, contains('USDT'));
    expect(rows.first.value, contains('₦800.00'));
    expect(rows.first.value, contains('0.53241100'),
        reason: 'the quantity is a string: crypto carries up to eighteen '
            'places and parsing it into a double loses the tail');
    expect(rows.last.key, 'Secondary payment method');
    expect(rows.last.value, contains('Wallet'));
    expect(rows.last.value, contains('₦200.00'));
  });

  test('coin-only funding shows one row, not a ₦0.00 wallet line', () {
    final rows = nairaFundingRows(cryptoFunded(crypto: 100000, fiat: 0));
    expect(rows.length, 1);
    expect(rows.single.key, 'Payment method');
  });

  test('the PDF rows are ASCII — the naira sign crashes the document', () {
    // The embedded font is fetched over HTTP and falls back to base-14
    // Helvetica, which latin1-encodes every string and THROWS above 255. A
    // receipt generated offline would die on exactly this row.
    final rows = nairaFundingRowsAscii(cryptoFunded());
    expect(rows, isNotEmpty);
    for (final r in rows) {
      for (final unit in '${r.key}${r.value}'.codeUnits) {
        expect(unit, lessThan(128),
            reason: 'non-ASCII in a PDF row: "${r.key}: ${r.value}"');
      }
      expect(r.value, contains('NGN'));
    }
  });

  test('screen and PDF describe the same split', () {
    // Two renderers of one split is how a forwarded document comes to
    // contradict the screen it was taken from.
    final screen = nairaFundingRows(cryptoFunded());
    final pdf = nairaFundingRowsAscii(cryptoFunded());
    expect(pdf.length, screen.length);
    // Compared on CONTENT, not bytes: the PDF copy deliberately swaps the
    // em-dash and middle dot for ASCII, so an exact-string check would be
    // asserting the typography rather than the facts.
    String facts(String v) => v
        .replaceAll('₦', '')
        .replaceAll('NGN', '')
        .replaceAll(RegExp(r'[^0-9A-Za-z.]'), '');
    for (var i = 0; i < screen.length; i++) {
      expect(pdf[i].key, screen[i].key);
      expect(facts(pdf[i].value), facts(screen[i].value),
          reason: 'the forwarded document states a different split from the '
              'screen it was taken from');
    }
  });
}
