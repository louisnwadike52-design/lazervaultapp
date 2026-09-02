import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

void main() {
  GiftCardSale sale(String status, {String display = ''}) => GiftCardSale(
        id: 'x', userId: 'u', accountId: 'a', cardType: '220',
        cardNumber: '', denomination: 100, currency: '', ratePercentage: 4,
        expectedPayout: 400, actualPayout: 0, status: status,
        providerSaleId: '', providerName: 'prestmit', reference: 'r',
        submittedAt: '', reviewedAt: '', paidAt: '', createdAt: '',
        updatedAt: '', rejectionReason: '', displayStatus: display,
      );

  test('the list badge and the receipt never disagree', () {
    // manual_review is the state that diverged: the list collapsed it to
    // "Pending" while the receipt title-cased the raw value into
    // "Manual review".
    for (final s in ['manual_review', 'reviewing', 'pending_review',
                     'approved', 'settling', 'pending_settlement', 'pending']) {
      expect(sale(s).userStatusLabel, 'Under review', reason: 'status=$s');
    }
    expect(sale('paid').userStatusLabel, 'Paid');
    expect(sale('settled').userStatusLabel, 'Paid');
    expect(sale('rejected').userStatusLabel, 'Rejected');
    expect(sale('failed').userStatusLabel, 'Rejected');
    expect(sale('refunded').userStatusLabel, 'Refunded');
  });

  test('an unknown internal state never leaks operator jargon', () {
    expect(sale('some_new_internal_state').userStatusLabel, 'Under review');
  });
}
