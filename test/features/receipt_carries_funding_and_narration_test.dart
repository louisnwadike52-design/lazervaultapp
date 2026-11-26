import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto_pay/domain/payment_method_breakdown.dart';

/// A RECEIPT OPENED FROM HISTORY MUST SAY THE SAME THING AS THE ONE FROM THE
/// FLOW.
///
/// A customer sees the flow's receipt once, in the second after paying. Every
/// time after that they open it from a history list — so history is the copy
/// that matters, and it was the copy missing the detail.
///
/// Two things had to survive the trip and one did not:
///
///  * the NARRATION they typed — carried, already;
///  * the FUNDING SPLIT (which coin, how much of it was sold, what the wallet
///    covered) — recorded by core-payments, projected onto the history wire,
///    read by the data source, and then dropped on the floor. A crypto-funded
///    transfer opened from history was indistinguishable from a wallet one.
void main() {
  String code(String path) => File(path)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  final payload = code(
      'lib/src/features/move_money/presentation/receipts/beam_receipt_payload.dart');
  final dataSource = code(
      'lib/src/features/funds/data/datasources/payments_transfer_data_source.dart');
  final result = code(
      'lib/src/features/funds/data/datasources/payments_transfer_data_source_widgets.dart');
  final receipt = code(
      'lib/src/features/funds/presentation/view/send_funds/transfer_receipt_screen.dart');

  group('the split survives the trip to history', () {
    test('the history record carries it', () {
      expect(result, contains('final Map<String, dynamic>? metadata;'),
          reason: 'PaymentsTransferResult had no metadata field at all, so '
              'there was nowhere for the split to live');
      expect(dataSource, contains('metadata: _paymentMetadata(p.metadata)'),
          reason: 'the wire value was decoded and then discarded');
    });

    test('the receipt payload carries it', () {
      expect(payload, contains('fundingMetadataArgs(r.metadata)'));
      expect(payload, contains("'metadata': metadata"));
    });

    test('the receipt reads it from there', () {
      expect(receipt, contains("transferDetails['metadata']"));
      expect(receipt, contains('_fundingRows'));
    });
  });

  group('the narration survives too', () {
    test('both beam builders carry it', () {
      expect("narration".allMatches(payload).length, greaterThanOrEqualTo(2),
          reason: 'the interbank and wallet builders each need it');
    });

    test('the receipt renders it as Description', () {
      expect(receipt, contains("transferDetails['narration']"));
      expect(receipt, contains("_buildDetailRow('Description', narration)"));
    });
  });

  group('what a crypto-funded receipt actually says', () {
    test('a split payment names both legs, the coin and the quantity', () {
      final b = PaymentMethodBreakdown.from(const {
        'funding_source': 'crypto',
        'funding_crypto_minor': 100000, // ₦1,000
        'funding_fiat_minor': 32300, // ₦323
        'funding_total_minor': 132300,
        'funding_asset': 'usdt',
        'funding_asset_amount': '0.9212',
      });
      expect(b, isNotNull);
      expect(b!.isSplit, isTrue);

      final rows = breakdownEntries(
          b, (m) => '₦${(m / 100).toStringAsFixed(2)}');
      final text = rows.map((e) => '${e.key}: ${e.value}').join('\n');

      expect(text, contains('USDT'), reason: 'the coin that was used');
      expect(text, contains('0.9212'), reason: 'how much of it was sold');
      expect(text, contains('₦1000.00'), reason: 'the naira that coin became');
      expect(text, contains('Wallet'), reason: 'fiat finished the payment');
      expect(text, contains('₦323.00'), reason: 'and how much of it');
      expect(text, contains('Primary payment method'));
      expect(text, contains('Secondary payment method'));
    });

    test('a coin-only payment says so without a zero wallet row', () {
      final b = PaymentMethodBreakdown.from(const {
        'funding_source': 'crypto',
        'funding_crypto_minor': 132300,
        'funding_fiat_minor': 0,
        'funding_total_minor': 132300,
        'funding_asset': 'btc',
        'funding_asset_amount': '0.00042',
      });
      final rows = breakdownEntries(b!, (m) => '₦${(m / 100).toStringAsFixed(2)}');
      expect(rows, hasLength(1),
          reason: 'a "₦0.00" wallet row invites the question of what it means');
      expect(rows.single.key, 'Payment method');
      expect(rows.single.value, contains('BTC'));
      expect(rows.single.value, contains('0.00042'));
    });

    test('an ordinary wallet payment gets no breakdown at all', () {
      expect(PaymentMethodBreakdown.from(const {'foo': 'bar'}), isNull);
      expect(PaymentMethodBreakdown.from(null), isNull);
      // Marked crypto-funded but with no figures — an older record. Nothing
      // to show beats a fabricated split.
      expect(
          PaymentMethodBreakdown.from(const {'funding_source': 'crypto'}),
          isNull);
    });

    test('a quantity we could not read is omitted, never shown as zero', () {
      final b = PaymentMethodBreakdown.from(const {
        'funding_source': 'crypto',
        'funding_crypto_minor': 50000,
        'funding_total_minor': 50000,
        'funding_asset': 'usdt',
      });
      expect(b!.assetAmount, isNull);
      final rows = breakdownRows(b, (m) => '₦${(m / 100).toStringAsFixed(2)}');
      expect(rows.single.note, isNull,
          reason: '"0 USDT sold" would be a claim that no coin was sold');
    });

    test('the list badge is short enough for a row', () {
      expect(
          breakdownBadge(PaymentMethodBreakdown.from(const {
            'funding_source': 'crypto',
            'funding_crypto_minor': 1,
            'funding_fiat_minor': 1,
            'funding_asset': 'usdt',
          })),
          'Paid with USDT + wallet');
      expect(breakdownBadge(null), isNull);
    });
  });
}
