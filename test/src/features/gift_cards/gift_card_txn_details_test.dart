import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/utils/gift_card_txn_details.dart';

// A gift-card payout reached the transaction sheet, the receipt and the PDF as
// a bare amount plus an opaque reference — every surface could say how much
// moved and nothing about WHICH card. These pin the two things that decide
// whether the card can be identified at all: finding the reference in whatever
// shape the description happens to use, and resolving a provider subcategory
// id into a name a human recognises.

void main() {
  group('reference extraction', () {
    test('finds the reference in the real description formats', () {
      // All three are strings observed in production.
      for (final s in [
        'Gift card sale payout (SELL-93b5d3e4-6e73-4097-8ea7-569c5e288cc2) - settled after manual review',
        'Gift card sale payout - Turkey iTunes SELL-93b5d3e4-6e73-4097-8ea7-569c5e288cc2',
        'IDEM-CR-SELL-93b5d3e4-6e73-4097-8ea7-569c5e288cc2-PAYOUT',
      ]) {
        expect(giftCardReferenceIn(s),
            'SELL-93b5d3e4-6e73-4097-8ea7-569c5e288cc2',
            reason: s);
      }
    });

    test('does not swallow a trailing suffix into the reference', () {
      // The idempotency key appends -PAYOUT; including it would make the
      // reference fail to match any sale.
      final r = giftCardReferenceIn(
          'IDEM-CR-SELL-93b5d3e4-6e73-4097-8ea7-569c5e288cc2-PAYOUT');
      expect(r, isNot(contains('PAYOUT')));
    });

    test('returns null rather than a false match on unrelated text', () {
      for (final s in [null, '', 'Transfer to POS Transfer-BLESSING', 'Airtime']) {
        expect(giftCardReferenceIn(s), isNull, reason: '$s');
      }
    });

    test('distinguishes a sale from a purchased card', () {
      expect(isGiftCardSaleReference('SELL-93b5d3e4'), isTrue);
      expect(isGiftCardSaleReference('GC-93b5d3e4'), isFalse);
    });
  });

  group('sale details', () {
    GiftCardSale sale({String cardType = '220', String currency = 'USD'}) =>
        GiftCardSale(
          id: 's1',
          cardType: cardType,
          denomination: 100,
          currency: currency,
          status: 'completed',
          reference: 'SELL-93b5d3e4',
          ratePercentage: 72,
        );

    test('resolves the brand name and logo from the catalogue', () {
      final d = GiftCardTxnDetails.fromSale(sale(), [
        const SellableCard(
          cardType: '220',
          displayName: 'Turkey iTunes',
          logoUrl: 'https://x/logo.png',
        ),
      ]);
      expect(d.brandName, 'Turkey iTunes');
      expect(d.logoUrl, 'https://x/logo.png');
    });

    test('never shows a bare provider id as the brand', () {
      // "220" is the provider's subcategory id. Printing it as the card name
      // is what the My Sales row used to do, and it means nothing to a seller.
      final d = GiftCardTxnDetails.fromSale(sale(), const []);
      expect(d.brandName, isEmpty);
      expect(d.rows.map((e) => e.value), isNot(contains('220')));
    });

    test('a name-like card type is still usable without the catalogue', () {
      final d = GiftCardTxnDetails.fromSale(
          sale(cardType: 'turkey_itunes'), const []);
      expect(d.brandName, 'turkey itunes');
    });

    test('face value always carries its currency', () {
      // A bare "100" does not say 100 of what.
      expect(GiftCardTxnDetails.fromSale(sale(), const []).faceValue, 'USD 100');
    });

    test('an unknown currency degrades to the bare amount, not a guess', () {
      // The prod row for this sale had an EMPTY currency; inventing NGN would
      // misstate the card's face value.
      final d = GiftCardTxnDetails.fromSale(sale(currency: ''), const []);
      expect(d.faceValue, '100');
      expect(d.faceValue, isNot(contains('NGN')));
    });

    test('rows omit anything unresolved rather than labelling a blank', () {
      final d = GiftCardTxnDetails.fromSale(sale(), const []);
      for (final r in d.rows) {
        expect(r.value.trim(), isNotEmpty, reason: r.key);
      }
    });
  });
}
