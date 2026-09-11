import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

// A seller was shown "Under review" on a sale that had already PAID OUT.
//
// giftcards-service stores `completed` as the terminal-success status — its own
// comment says "SaleStatusPaid is 'paid' (legacy synonym for completed)" — and
// this mapper only knew the legacy name. `completed` therefore fell through
// userDisplayStatus's default, then through userStatusLabel's default, landing
// on the catch-all "Under review". The money had arrived; the app said it was
// still being looked at.

GiftCardSale sale({required String status, String displayStatus = ''}) =>
    GiftCardSale(
      id: 's-1',
      cardType: '220',
      denomination: 100,
      status: status,
      displayStatus: displayStatus,
      actualPayout: 400,
    );

void main() {
  test('a completed sale reads as Paid, not Under review', () {
    final s = sale(status: 'completed', displayStatus: 'completed');
    expect(s.userDisplayStatus, 'paid');
    expect(s.userStatusLabel, 'Paid');
  });

  test('completed also satisfies isPaid', () {
    expect(sale(status: 'completed').isPaid, isTrue);
  });

  test('the legacy synonyms still work', () {
    for (final s in ['paid', 'settled']) {
      expect(sale(status: s).userStatusLabel, 'Paid', reason: s);
    }
  });

  test('genuinely in-flight states still read Under review', () {
    // The collapse of operator states into one user-facing label is
    // deliberate — until the money lands, the only fact that matters is that
    // it has not. This guards the fix from over-reaching.
    for (final s in [
      'pending',
      'reviewing',
      'manual_review',
      'pending_review',
      'approved',
      'settling',
      'pending_settlement',
    ]) {
      expect(sale(status: s).userStatusLabel, 'Under review', reason: s);
      expect(sale(status: s).isPaid, isFalse, reason: s);
    }
  });

  test('terminal failures are unaffected', () {
    expect(sale(status: 'rejected').userStatusLabel, 'Rejected');
    expect(sale(status: 'failed').userStatusLabel, 'Rejected');
    expect(sale(status: 'refunded').userStatusLabel, 'Refunded');
  });

  test('display_status wins over status when both are present', () {
    // The backend denormalises display_status so the UI never says "paid"
    // before settlement is confirmed; it must stay the authority.
    final s = sale(status: 'completed', displayStatus: 'pending_settlement');
    expect(s.userStatusLabel, 'Under review');
  });
}
