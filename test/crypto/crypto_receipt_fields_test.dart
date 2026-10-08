import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/utils/crypto_receipt_fields.dart';

/// The production buy that exposed the problem (swap 73346e90, 7 Oct 2026).
/// These are the exact values crypto-service now stamps on the ledger row.
const _buy = <String, dynamic>{
  'op': 'buy',
  'asset': 'usdc',
  'from_currency': 'ngn',
  'to_currency': 'usdc',
  'from_amount': '2769.24',
  'to_amount': '2',
  'fiat_currency': 'ngn',
  'fiat_total': '2776.16',
  'platform_fee': '6.92',
  'unit_rate': '1388.08',
  'order_reference': 'CRYPTO-93b0fc69-eaaa-45a9-82a6-4ba4a44370ff',
};

Map<String, String> _asMap(List<MapEntry<String, String>> rows) =>
    {for (final r in rows) r.key: r.value};

void main() {
  group('CryptoReceiptFields', () {
    test('a buy renders the canonical field set, in order', () {
      final rows = CryptoReceiptFields.rows(_buy,
          fiatSymbol: '₦', reference: 'ref-123');
      expect(rows.map((r) => r.key).toList(), [
        'Description',
        'Reference',
        'Type',
        'Category',
        'Currency',
        'You receive',
        'Rate',
        'Total',
        'Payment method',
        'Settlement',
        'Custody',
      ]);
      final m = _asMap(rows);
      expect(m['Description'], '2 USDC');
      expect(m['Type'], 'Crypto');
      expect(m['Category'], 'Debit');
      expect(m['Currency'], 'NGN');
      expect(m['You receive'], '2 USDC');
      expect(m['Total'], '₦2,776.16');
      expect(m['Payment method'], 'Personal account');
      expect(m['Custody'], 'Managed by licensed partner');
    });

    test('rate times quantity reproduces the total', () {
      final m = _asMap(CryptoReceiptFields.rows(_buy, fiatSymbol: '₦'));
      // A document whose own two numbers do not multiply out reads as an
      // error in the money, so this is the property that matters — not the
      // literal string.
      final rate = double.parse(
          m['Rate']!.split('=').last.replaceAll(RegExp(r'[^0-9.]'), ''));
      final total =
          double.parse(m['Total']!.replaceAll(RegExp(r'[^0-9.]'), ''));
      final qty = double.parse(m['You receive']!.split(' ').first);
      expect((rate * qty - total).abs(), lessThan(0.01));
    });

    test('the ledger-internal vocabulary never appears', () {
      final labels = CryptoReceiptFields.rows(_buy, fiatSymbol: '₦')
          .map((r) => r.key)
          .toSet();
      // These are the rows the history receipt used to show instead.
      for (final gone in [
        'Balance before',
        'Balance after',
        'Transaction ID',
        'Asset',
        'Paid with',
        'Asset amount',
        'Order reference',
      ]) {
        expect(labels, isNot(contains(gone)),
            reason: '$gone is ledger plumbing, not a crypto receipt row');
      }
    });

    test('every key it reads is also a key it hides', () {
      // Otherwise the generic metadata dump prints each value twice — once as
      // a designed row and once as a snake_case key.
      for (final k in _buy.keys) {
        expect(CryptoReceiptFields.consumedKeys, contains(k),
            reason: '$k is projected but not hidden from the generic dump');
      }
    });

    test('a sell reports what landed, as a credit', () {
      final m = _asMap(CryptoReceiptFields.rows({
        'op': 'sell',
        'asset': 'usdt',
        'from_currency': 'usdt',
        'to_currency': 'ngn',
        'from_amount': '51.55',
        'fiat_currency': 'ngn',
        'fiat_total': '69628.72',
        'unit_rate': '1350.90',
      }, fiatSymbol: '₦'));
      expect(m['Category'], 'Credit');
      expect(m['You sell'], '51.55 USDT');
      expect(m['Total'], '₦69,628.72');
    });

    test('a crypto-to-crypto trade claims no fiat leg', () {
      final m = _asMap(CryptoReceiptFields.rows({
        'op': 'convert',
        'from_currency': 'usdt',
        'to_currency': 'xrp',
        'from_amount': '1.5',
        'to_amount': '3.2',
      }, fiatSymbol: '₦'));
      expect(m['Category'], 'Swap');
      expect(m['Currency'], 'USDT → XRP');
      expect(m['From'], '1.5 USDT');
      expect(m['To'], '3.2 XRP');
      // Not "₦3.20" — that was the asset amount wearing a naira symbol.
      expect(m['Total'], '3.2 XRP');
      expect(m.containsKey('Rate'), isFalse);
    });

    test('a row without the payload is left to the generic renderer', () {
      // Old captures carry the human labels. Projecting an empty field set
      // over them would make those receipts worse, not better.
      expect(CryptoReceiptFields.describes(null), isFalse);
      expect(CryptoReceiptFields.describes(const {}), isFalse);
      expect(
          CryptoReceiptFields.describes(const {
            'Asset': 'usdc',
            'Paid with': '2769.2 ngn',
          }),
          isFalse);
      expect(CryptoReceiptFields.rows(const {'Asset': 'usdc'}, fiatSymbol: '₦'),
          isEmpty);
      // ...but the old keys are still hidden, so they do not double-print
      // alongside anything else.
      expect(CryptoReceiptFields.consumedKeys, contains('Paid with'));
    });

    test('an explicit payment method wins over the default', () {
      final m = _asMap(CryptoReceiptFields.rows(
        {..._buy, 'payment_method': 'Business account'},
        fiatSymbol: '₦',
      ));
      expect(m['Payment method'], 'Business account');
    });
    group('a send states what it was worth', () {
      // A send is asset->asset: no fiat moves, so it reaches neither Total
      // branch and the receipt used to show "1 USDC" with no money value at
      // all. The backend captures an indicative valuation AT SEND TIME —
      // pricing it later from the then-current rate would silently restate a
      // historical document.
      const send = {
        'op': 'send',
        'from_currency': 'usdc',
        'from_amount': '1',
        'fiat_currency': 'NGN',
        'fiat_estimate': '1355.01',
      };

      test('renders the captured estimate, marked as one', () {
        final m = _asMap(CryptoReceiptFields.rows(send, fiatSymbol: '₦'));
        expect(m['Value at send'], '≈ ₦1,355.01');
        expect(m.containsKey('Total'), isFalse,
            reason: 'no fiat moved, so nothing may be labelled Total');
      });

      test('an unpriced send shows no row rather than a confident zero', () {
        for (final bad in <Map<String, dynamic>>[
          {'op': 'send', 'from_currency': 'usdc', 'from_amount': '1'},
          {...send, 'fiat_estimate': '0'},
          {...send, 'fiat_estimate': ''},
          {...send, 'fiat_estimate': 'not a number'},
        ]) {
          final m = _asMap(CryptoReceiptFields.rows(bad, fiatSymbol: '₦'));
          expect(m.containsKey('Value at send'), isFalse,
              reason: 'unpriced: $bad');
        }
      });

      test('the raw key never double-prints in a generic dump', () {
        expect(CryptoReceiptFields.consumedKeys, contains('fiat_estimate'));
      });

      test('buy and sell keep their real Total and gain no estimate row', () {
        final m = _asMap(CryptoReceiptFields.rows(_buy, fiatSymbol: '₦'));
        expect(m.containsKey('Value at send'), isFalse);
        expect(m.containsKey('Total'), isTrue);
      });
    });
  });
}
