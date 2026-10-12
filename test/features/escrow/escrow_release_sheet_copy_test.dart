import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';
import 'package:lazervault/src/features/escrow/presentation/view/escrow_role_labels.dart';

EscrowDealEntity deal({
  required String feePayer,
  double amount = 200,
  double fee = 20,
  required double buyerTotal,
  required double sellerNet,
}) =>
    EscrowDealEntity(
      id: 'd1',
      reference: 'ESCROW-abc',
      buyerUserId: 'b',
      buyerAccountId: 'ba',
      buyerName: 'Praiz Onah',
      sellerUserId: 's',
      sellerAccountId: 'sa',
      sellerName: 'Nnaemeka Ezeke',
      title: 'Laptop',
      description: '',
      currency: 'NGN',
      amount: amount,
      fee: fee,
      feePayer: feePayer,
      buyerTotal: buyerTotal,
      sellerNet: sellerNet,
      status: 'FUNDED',
      fraudScore: 0,
      requiresAdminReview: false,
      deliveryNote: '',
    );

String money(double v) => '₦${v.toStringAsFixed(2)}';

void main() {
  group('release PIN sheet copy', () {
    // The sheet authorises releasing what is HELD. Quoting the seller's net
    // showed "Release ₦180.00" to a buyer who had paid ₦200, which reads as a
    // second, smaller debit.
    test('always quotes the amount held, never the seller net', () {
      for (final d in [
        deal(feePayer: 'seller', buyerTotal: 200, sellerNet: 180),
        deal(feePayer: 'buyer', buyerTotal: 220, sellerNet: 200),
        deal(feePayer: 'split', buyerTotal: 210, sellerNet: 190),
      ]) {
        expect(
          EscrowRoles.releaseSheetMessage(d, money),
          contains('Release the ${money(d.buyerTotal)} held'),
          reason: 'fee payer ${d.feePayer}',
        );
      }
    });

    test('a seller-covered fee is named as the seller\'s, not the buyer\'s',
        () {
      final msg = EscrowRoles.releaseSheetMessage(
          deal(feePayer: 'seller', buyerTotal: 200, sellerNet: 180), money);
      expect(msg, contains('Release the ₦200.00 held'));
      expect(msg, contains('receives ₦180.00'));
      expect(msg, contains('₦20.00 escrow fee is covered by the seller'));
      expect(msg, contains('you pay only the item price'));
    });

    test('a buyer-paid fee says when the buyer paid it', () {
      final msg = EscrowRoles.releaseSheetMessage(
          deal(feePayer: 'buyer', buyerTotal: 220, sellerNet: 200), money);
      expect(msg, contains('₦20.00 is the escrow fee you paid when you funded'));
    });

    test('a split spells out both halves from the recorded totals', () {
      final msg = EscrowRoles.releaseSheetMessage(
          deal(feePayer: 'split', buyerTotal: 210, sellerNet: 190), money);
      expect(msg, contains('₦10.00 from you'));
      expect(msg, contains('₦10.00 from the seller'));
    });

    test('a fee-free deal mentions no fee', () {
      final msg = EscrowRoles.releaseSheetMessage(
          deal(feePayer: 'none', fee: 0, buyerTotal: 200, sellerNet: 200),
          money);
      expect(msg, contains('no escrow fee'));
      expect(msg, isNot(contains('covered by')));
    });

    test('every variant reassures the buyer they are not charged twice', () {
      for (final p in ['buyer', 'seller', 'split', 'none']) {
        expect(
          EscrowRoles.releaseSheetMessage(
              deal(feePayer: p, buyerTotal: 210, sellerNet: 190), money),
          contains('You are not being charged again'),
          reason: p,
        );
      }
    });
  });
}
