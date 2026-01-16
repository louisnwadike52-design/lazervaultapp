import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

void main() {
  group('Gift Card Entity Tests', () {
    test('GiftCard entity should create with all required fields', () {
      final now = DateTime.now();
      final giftCard = GiftCard(
        id: 'test-id',
        brandId: 'brand-1',
        brandName: 'Test Brand',
        logoUrl: 'https://example.com/logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.active,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Test gift card',
        termsAndConditions: 'Terms apply',
        expiryDate: now.add(Duration(days: 365)),
        purchaseDate: now,
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );

      expect(giftCard.id, 'test-id');
      expect(giftCard.brandName, 'Test Brand');
      expect(giftCard.amount, 100.0);
      expect(giftCard.status, GiftCardStatus.active);
    });

    test('GiftCard entity should support all status types', () {
      // Test all enum values exist
      expect(GiftCardStatus.active, isNotNull);
      expect(GiftCardStatus.used, isNotNull);
      expect(GiftCardStatus.expired, isNotNull);
      expect(GiftCardStatus.pending, isNotNull);
      expect(GiftCardStatus.cancelled, isNotNull);
      expect(GiftCardStatus.partiallyRedeemed, isNotNull);
    });

    test('GiftCardBrand entity should create with required fields including minAmount', () {
      final brand = GiftCardBrand(
        id: 'brand-1',
        name: 'Test Brand',
        logoUrl: 'https://example.com/logo.png',
        description: 'Test description',
        category: GiftCardCategory.shopping,
        discountPercentage: 5.0,
        isPopular: true,
        minAmount: 10.0,
        maxAmount: 500.0,
        availableDenominations: ['25', '50', '100'],
      );

      expect(brand.id, 'brand-1');
      expect(brand.name, 'Test Brand');
      expect(brand.minAmount, 10.0);
      expect(brand.maxAmount, 500.0);
      expect(brand.availableDenominations, isNotNull);
    });

    test('GiftCardTransaction entity should create with all fields', () {
      final now = DateTime.now();
      final transaction = GiftCardTransaction(
        id: 'txn-1',
        giftCardId: 'card-1',
        userId: 'user-1',
        amount: 100.0,
        currency: 'USD',
        transactionDate: now,
        transactionType: 'purchase',
        status: GiftCardStatus.active,
        description: 'Purchase transaction',
        brandName: 'Test Brand',
        failureReason: null,
        additionalDetails: {'key': 'value'},
      );

      expect(transaction.id, 'txn-1');
      expect(transaction.transactionType, 'purchase');
      expect(transaction.description, 'Purchase transaction');
      expect(transaction.brandName, 'Test Brand');
    });

    test('GiftCard copyWith should work correctly', () {
      final now = DateTime.now();
      final original = GiftCard(
        id: 'test-id',
        brandId: 'brand-1',
        brandName: 'Test Brand',
        logoUrl: 'https://example.com/logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.active,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Test gift card',
        termsAndConditions: 'Terms apply',
        expiryDate: now.add(Duration(days: 365)),
        purchaseDate: now,
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );

      final updated = original.copyWith(
        status: GiftCardStatus.partiallyRedeemed,
        amount: 75.0,
      );

      expect(updated.status, GiftCardStatus.partiallyRedeemed);
      expect(updated.amount, 75.0);
      expect(updated.brandName, 'Test Brand'); // Unchanged fields should remain
      expect(updated.id, 'test-id');
    });
  });
}
