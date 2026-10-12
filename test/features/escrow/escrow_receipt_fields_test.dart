import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/utils/escrow_receipt_fields.dart';

Map<String, dynamic> deal({
  String event = 'funded',
  String role = 'buyer',
  String feePayer = 'seller',
  num amount = 200,
  num fee = 20,
  num buyerTotal = 200,
  num sellerNet = 180,
}) =>
    {
      'escrow_event': event,
      'escrow_role': role,
      'escrow_reference': 'ESCROW-abc',
      'escrow_title': 'Laptop',
      'escrow_condition': 'brand_new',
      'escrow_currency': 'NGN',
      'escrow_amount': amount,
      'escrow_fee': fee,
      'escrow_fee_payer': feePayer,
      'escrow_buyer_total': buyerTotal,
      'escrow_seller_net': sellerNet,
      'escrow_buyer_name': 'Praiz Onah',
      'escrow_seller_name': 'Nnaemeka Ezeke',
    };

String? valueFor(List<MapEntry<String, String>> rows, String label) {
  for (final r in rows) {
    if (r.key == label) return r.value;
  }
  return null;
}

void main() {
  group('EscrowReceiptFields', () {
    test('ignores rows written before the payload existed', () {
      // Every escrow row ever written carried only this key. Projecting an
      // empty field set over them would make old receipts worse.
      expect(
        EscrowReceiptFields.describes({'business_reference': 'ESCROW-abc'}),
        isFalse,
      );
      expect(
        EscrowReceiptFields.rows({'business_reference': 'ESCROW-abc'},
            fiatSymbol: '₦'),
        isEmpty,
      );
    });

    test('the two sides of one deal get different documents', () {
      final buyer = EscrowReceiptFields.rows(deal(), fiatSymbol: '₦');
      final seller = EscrowReceiptFields.rows(
          deal(event: 'released', role: 'seller'),
          fiatSymbol: '₦');

      expect(valueFor(buyer, 'Your role'), 'Buyer');
      expect(valueFor(seller, 'Your role'), 'Seller');
      expect(valueFor(buyer, 'What this is'), 'Paid into escrow');
      expect(valueFor(seller, 'What this is'), 'Escrow released to you');
      expect(valueFor(buyer, 'Outcome'),
          contains('You paid into escrow rather than paying'));
      expect(valueFor(seller, 'Outcome'), contains('released to you'));
    });

    test('item price and fee stay separate facts', () {
      // A ₦200 item with a ₦20 fee is not a ₦220 purchase, and showing only
      // the total is what made buyers think they had been overcharged.
      final rows = EscrowReceiptFields.rows(deal(), fiatSymbol: '₦');
      expect(valueFor(rows, 'Item price'), '₦200.00');
      expect(valueFor(rows, 'Escrow fee'), '₦20.00');
      expect(valueFor(rows, 'Fee paid by'), 'Seller');
      expect(valueFor(rows, 'Buyer paid'), '₦200.00');
      expect(valueFor(rows, 'Seller receives'), '₦180.00');
    });

    test('a split names each half from the recorded totals', () {
      final rows = EscrowReceiptFields.rows(
        deal(feePayer: 'split', buyerTotal: 210, sellerNet: 190),
        fiatSymbol: '₦',
      );
      expect(valueFor(rows, 'Fee paid by'), 'Split evenly');
      expect(valueFor(rows, "Fee — buyer's half"), '₦10.00');
      expect(valueFor(rows, "Fee — seller's half"), '₦10.00');
    });

    test('an unset fee payer reads as the configured default, not "buyer"', () {
      final rows =
          EscrowReceiptFields.rows(deal(feePayer: ''), fiatSymbol: '₦');
      expect(valueFor(rows, 'Fee paid by'), 'Split evenly');
    });

    test('a zero fee contributes no fee rows at all', () {
      final rows = EscrowReceiptFields.rows(
        deal(feePayer: 'none', fee: 0, buyerTotal: 200, sellerNet: 200),
        fiatSymbol: '₦',
      );
      expect(valueFor(rows, 'Escrow fee'), isNull);
      expect(valueFor(rows, 'Fee paid by'), isNull);
    });

    test('a refund says the money went back in full', () {
      final rows = EscrowReceiptFields.rows(
          deal(event: 'refunded', role: 'buyer'),
          fiatSymbol: '₦');
      expect(valueFor(rows, 'What this is'), 'Escrow refunded to you');
      expect(valueFor(rows, 'Outcome'), contains('returned to the buyer'));
    });

    test('the transaction reference is only added when it differs', () {
      final same = EscrowReceiptFields.rows(deal(),
          fiatSymbol: '₦', reference: 'ESCROW-abc');
      expect(valueFor(same, 'Transaction reference'), isNull);
      final differs = EscrowReceiptFields.rows(deal(),
          fiatSymbol: '₦', reference: 'IDEM-PW-xyz');
      expect(valueFor(differs, 'Transaction reference'), 'IDEM-PW-xyz');
    });

    test('string-encoded numbers from JSON parse the same as numbers', () {
      final rows = EscrowReceiptFields.rows({
        ...deal(),
        'escrow_amount': '200',
        'escrow_fee': '20',
      }, fiatSymbol: '₦');
      expect(valueFor(rows, 'Item price'), '₦200.00');
      expect(valueFor(rows, 'Escrow fee'), '₦20.00');
    });
  });
}
