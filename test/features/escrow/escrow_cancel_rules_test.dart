import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';

EscrowDealEntity deal({required String status}) => EscrowDealEntity(
      id: 'd1',
      reference: 'ESCROW-abc',
      buyerUserId: 'buyer-1',
      buyerAccountId: 'ba',
      buyerName: 'Praiz Onah',
      sellerUserId: 'seller-1',
      sellerAccountId: 'sa',
      sellerName: 'Nnaemeka Ezeke',
      title: 'Laptop',
      description: '',
      currency: 'NGN',
      amount: 200,
      fee: 20,
      feePayer: 'seller',
      buyerTotal: 200,
      sellerNet: 180,
      status: status,
      fraudScore: 0,
      requiresAdminReview: false,
      deliveryNote: '',
    );

void main() {
  group('who may cancel', () {
    // The buyer's money is what is at risk, so a buyer who could unwind the
    // deal unilaterally would hold a free option on the seller's time. The
    // seller still has the goods, so the seller calls it off.
    test('the seller can cancel a funded deal', () {
      expect(deal(status: 'FUNDED').canCancel('seller-1'), isTrue);
    });

    test('the buyer cannot cancel, whoever created the deal', () {
      expect(deal(status: 'FUNDED').canCancel('buyer-1'), isFalse);
    });

    test('a bystander cannot cancel', () {
      expect(deal(status: 'FUNDED').canCancel('someone-else'), isFalse);
    });

    test('not even the seller can cancel once delivery is marked', () {
      for (final s in ['DELIVERED', 'RELEASED', 'DISPUTED', 'CANCELLED']) {
        expect(deal(status: s).canCancel('seller-1'), isFalse, reason: s);
      }
    });
  });

  group('who may dispute', () {
    // The buyer's route out of a deal they are unhappy with.
    test('both parties can dispute while the deal is live', () {
      for (final s in ['FUNDED', 'DELIVERED']) {
        expect(deal(status: s).canDispute('buyer-1'), isTrue, reason: s);
        expect(deal(status: s).canDispute('seller-1'), isTrue, reason: s);
      }
    });

    test('nobody can dispute a closed deal', () {
      for (final s in ['RELEASED', 'CANCELLED', 'REFUNDED']) {
        expect(deal(status: s).canDispute('buyer-1'), isFalse, reason: s);
        expect(deal(status: s).canDispute('seller-1'), isFalse, reason: s);
      }
    });
  });

  group('a released deal is final for both sides', () {
    test('both parties are told so, not just shown fewer buttons', () {
      final d = deal(status: 'RELEASED');
      for (final uid in ['buyer-1', 'seller-1']) {
        final s = d.waitingSubtitle(uid);
        expect(s.yourTurn, isFalse);
        expect(s.text, contains('closed'));
        expect(s.text, contains('cancelled, refunded or disputed'));
      }
    });

    test('a cancellation tells each side who bore the fee', () {
      final d = deal(status: 'CANCELLED');
      expect(d.waitingSubtitle('buyer-1').text, contains('charged no fee'));
      expect(d.waitingSubtitle('seller-1').text, contains('charged to you'));
    });
  });
}
