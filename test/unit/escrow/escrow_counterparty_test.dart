import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';
import 'package:lazervault/src/features/escrow/presentation/view/escrow_party_chat_action.dart';

/// Who the chat button reaches. Getting this wrong opens a private channel to
/// the wrong person, or to a stranger's counterparty — on a screen about money
/// two people are mid-transaction over.
EscrowDealEntity _deal({
  String buyerId = 'buyer-1',
  String buyerName = 'Ada Obi',
  String sellerId = 'seller-1',
  String sellerName = 'Chris N',
}) {
  return EscrowDealEntity(
    id: 'deal-1',
    reference: 'ESC-1',
    buyerUserId: buyerId,
    buyerAccountId: 'acc-b',
    buyerName: buyerName,
    sellerUserId: sellerId,
    sellerAccountId: 'acc-s',
    sellerName: sellerName,
    title: 'Laptop',
    description: 'A laptop',
    currency: 'NGN',
    amount: 100000,
    fee: 500,
    feePayer: 'buyer',
    buyerTotal: 100500,
    sellerNet: 100000,
    status: 'funded',
    fraudScore: 0,
    requiresAdminReview: false,
    deliveryNote: '',
  );
}

void main() {
  group('escrowCounterpartyFor', () {
    test('the buyer is pointed at the seller', () {
      final c = escrowCounterpartyFor(_deal(), 'buyer-1');
      expect(c!.userId, 'seller-1');
      expect(c.name, 'Chris N');
    });

    test('the seller is pointed at the buyer', () {
      final c = escrowCounterpartyFor(_deal(), 'seller-1');
      expect(c!.userId, 'buyer-1');
      expect(c.name, 'Ada Obi');
    });

    // An escrow can be opened from a share link by somebody who has not
    // claimed it. They are not a party, and handing them a private channel to
    // someone else's counterparty would be a real leak.
    test('a viewer who is neither party gets nothing', () {
      expect(escrowCounterpartyFor(_deal(), 'someone-else'), isNull);
    });

    // The normal state of an open-link deal nobody has accepted: there is
    // literally no second person to message yet.
    test('an unclaimed other side gets nothing', () {
      final c = escrowCounterpartyFor(_deal(sellerId: ''), 'buyer-1');
      expect(c, isNull);
    });

    test('an empty viewer id gets nothing', () {
      expect(escrowCounterpartyFor(_deal(), ''), isNull);
    });

    // A blank display name is common before someone completes their profile.
    // The chat still works, so it must not block the action.
    test('a nameless counterparty still resolves, with a fallback label', () {
      final c = escrowCounterpartyFor(_deal(sellerName: '   '), 'buyer-1');
      expect(c!.userId, 'seller-1');
      expect(c.name, 'Counterparty');
    });

    // Degenerate data, but it must never route someone into a conversation
    // with themselves — the p2p screen is not built for that.
    test('a deal where both sides are the same user offers no chat', () {
      final c = escrowCounterpartyFor(
          _deal(buyerId: 'same', sellerId: 'same'), 'same');
      expect(c, isNull);
    });
  });
}
