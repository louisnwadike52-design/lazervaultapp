import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_offer_entity.dart';

// On an accepted buy_request the seller's screen said only "Waiting for
// Nnaemeka Ezeke". That names who is holding things up but not what has to
// happen — on the one screen where that is the entire question. It also sat
// above a card explaining the buyer had to "fund the escrow", our internal
// mechanic rather than what the buyer actually does, which is pay.

const buyer = 'buyer-id';
const seller = 'seller-id';

EscrowOfferEntity offer(String status) => EscrowOfferEntity(
      id: 'o-1',
      reference: 'ESCROFR-1',
      // buy_request: created BY the buyer, addressed to the seller.
      direction: 'buy_request',
      creatorUserId: buyer,
      creatorName: 'Nnaemeka Ezeke',
      counterpartyUserId: seller,
      counterpartyName: 'Praiz Onah',
      title: 'TV',
      amount: 500000,
      status: status,
    );

void main() {
  test('an accepted request tells the seller the buyer must PAY', () {
    final (label, actionable) =
        offer('AWAITING_FUNDING').nextActionLabel(seller);
    expect(label, 'Waiting for Nnaemeka Ezeke to pay');
    // Not the seller's move, so it must not read as actionable.
    expect(actionable, isFalse);
  });

  test('a label the viewer cannot act on never stops at just a name', () {
    // The exact regression: when there is nothing for THIS viewer to do, the
    // label was "Waiting for <name>" with no verb. Labels the viewer CAN act
    // on already name their action ("Waiting for you — review this request"),
    // so they are not what this guards.
    for (final s in ['AWAITING_FUNDING', 'OPEN', 'CONVERTED']) {
      for (final viewer in [seller, buyer, 'bystander-id']) {
        final (label, actionable) = offer(s).nextActionLabel(viewer);
        if (actionable || !label.startsWith('Waiting for')) continue;
        expect(
          RegExp(r'^Waiting for .+ to \w+').hasMatch(label),
          isTrue,
          reason: '"$label" ($s, viewer=$viewer) names a person but not the '
              'action being waited on',
        );
      }
    }
  });

  test('an unnamed counterparty still produces a sentence', () {
    // Names can be missing on a link-shared offer; the copy must not degrade
    // into "Waiting for  to pay".
    final anon = EscrowOfferEntity(
      id: 'o-2',
      reference: 'ESCROFR-2',
      direction: 'buy_request',
      creatorUserId: buyer,
      counterpartyUserId: seller,
      title: 'TV',
      amount: 1000,
      status: 'AWAITING_FUNDING',
    );
    final (label, _) = anon.nextActionLabel(seller);
    expect(label, 'Waiting for the buyer to pay');
    expect(label, isNot(contains('  ')));
  });

  test('the party who CAN act is still told to act, not to wait', () {
    // Guard: the new branches must not swallow the actionable cases above
    // them — the buyer on their own awaiting-funding request still pays.
    final (label, actionable) =
        offer('AWAITING_FUNDING').nextActionLabel(buyer);
    expect(actionable, isTrue);
    expect(label, contains('you'));
  });
}
