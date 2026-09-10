import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';
import 'package:lazervault/src/features/escrow/presentation/view/escrow_role_labels.dart';

/// What each party is TOLD they paid must equal what they actually paid.
///
/// The receipt used to show the fee row only when feePayer was exactly
/// 'buyer' or 'seller'. Once the 50/50 split became the default that row
/// disappeared for BOTH parties — a receipt quietly omitting a charge they
/// had each half-paid.
void main() {
  EscrowDealEntity deal({
    required String feePayer,
    double amount = 1000,
    double fee = 50,
    required double buyerTotal,
    required double sellerNet,
  }) =>
      EscrowDealEntity(
        id: 'd1',
        reference: 'ESCROW-1',
        buyerUserId: 'buyer-1',
        buyerAccountId: 'ba',
        buyerName: 'Praiz Onah',
        sellerUserId: 'seller-1',
        sellerAccountId: 'sa',
        sellerName: 'Nnaemeka Ezeke',
        title: 'Laptop',
        description: '',
        condition: 'excellent',
        currency: 'NGN',
        amount: amount,
        fee: fee,
        feePayer: feePayer,
        buyerTotal: buyerTotal,
        sellerNet: sellerNet,
        status: 'RELEASED',
        fraudScore: 0,
        requiresAdminReview: false,
        deliveryNote: '',
        buyerItemImageUrl: '',
        sellerProofImageUrl: '',
        events: const [],
        attachments: const [],
      );

  group('each party is shown the fee share they actually bore', () {
    test('split: both sides see their half, neither sees the whole fee', () {
      final d = deal(feePayer: 'split', buyerTotal: 1025, sellerNet: 975);
      expect(EscrowRoles.dealViewerFeeShare(d, true), 25);
      expect(EscrowRoles.dealViewerFeeShare(d, false), 25);
      expect(EscrowRoles.dealFeeRowLabel(d, true), 'Escrow fee (your half)');
    });

    test('seller absorbs: buyer bore nothing, seller bore all', () {
      final d = deal(feePayer: 'seller', buyerTotal: 1000, sellerNet: 950);
      expect(EscrowRoles.dealViewerFeeShare(d, true), 0);
      expect(EscrowRoles.dealViewerFeeShare(d, false), 50);
      expect(EscrowRoles.dealFeeRowLabel(d, true),
          'Escrow fee (you paid none)');
    });

    test('buyer absorbs: seller bore nothing', () {
      final d = deal(feePayer: 'buyer', buyerTotal: 1050, sellerNet: 1000);
      expect(EscrowRoles.dealViewerFeeShare(d, true), 50);
      expect(EscrowRoles.dealViewerFeeShare(d, false), 0);
    });

    test('no fee: nobody is shown a share', () {
      final d = deal(
          feePayer: 'none', fee: 0, buyerTotal: 1000, sellerNet: 1000);
      expect(EscrowRoles.dealViewerFeeShare(d, true), 0);
      expect(EscrowRoles.dealViewerFeeShare(d, false), 0);
    });

    test('an odd-kobo split still sums to exactly the fee', () {
      // fee 5.01 → 2.51 buyer / 2.50 seller. The share is read off the
      // recorded totals, so the halves cannot drift from the money moved.
      final d = deal(
          feePayer: 'split', fee: 5.01, buyerTotal: 1002.51, sellerNet: 997.50);
      final buyer = EscrowRoles.dealViewerFeeShare(d, true);
      final seller = EscrowRoles.dealViewerFeeShare(d, false);
      expect(buyer, 2.51);
      expect(seller, 2.50);
      expect(((buyer + seller) * 100).round(), (d.fee * 100).round());
    });
  });

  group('the explainer names the right payer from each seat', () {
    String money(double v) => '₦${v.toStringAsFixed(2)}';

    test('a seller-absorbed fee reads as a concession to the buyer', () {
      final d = deal(feePayer: 'seller', buyerTotal: 1000, sellerNet: 950);
      expect(EscrowRoles.dealFeeExplainer(d, true, money),
          contains('The seller covered the whole'));
      expect(EscrowRoles.dealFeeExplainer(d, false, money),
          contains('You covered the whole'));
    });

    test('a split reads the same to both', () {
      final d = deal(feePayer: 'split', buyerTotal: 1025, sellerNet: 975);
      for (final isBuyer in [true, false]) {
        expect(EscrowRoles.dealFeeExplainer(d, isBuyer, money),
            contains('split evenly'));
      }
    });
  });
}
