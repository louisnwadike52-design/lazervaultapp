import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

void main() {
  group('Gift Card Entity Tests', () {
    test('GiftCard entity should create with all required fields', () {
      final giftCard = GiftCard(
        id: 'test-id',
        brandId: 'brand-1',
        brandName: 'Test Brand',
        logoUrl: 'https://example.com/logo.png',
        originalAmount: 100.0,
        currentBalance: 100.0,
        currency: 'USD',
        status: 'active',
        purchaseDate: '2025-01-01T00:00:00Z',
        expiryDate: '2026-01-01T00:00:00Z',
        discountPercentage: 5.0,
      );

      expect(giftCard.id, 'test-id');
      expect(giftCard.brandName, 'Test Brand');
      expect(giftCard.originalAmount, 100.0);
      expect(giftCard.status, 'active');
    });

    test('GiftCard entity should support status getters', () {
      final activeCard = GiftCard(
        id: '1', brandId: 'b1', brandName: 'Brand',
        originalAmount: 100, currentBalance: 100,
        currency: 'USD', status: 'active',
        purchaseDate: '', expiryDate: '',
      );
      expect(activeCard.isActive, true);
      expect(activeCard.isRedeemed, false);
      expect(activeCard.isExpired, false);

      final redeemedCard = activeCard.copyWith(status: 'redeemed');
      expect(redeemedCard.isRedeemed, true);
      expect(redeemedCard.isActive, false);

      final expiredCard = activeCard.copyWith(status: 'expired');
      expect(expiredCard.isExpired, true);

      final transferredCard = activeCard.copyWith(status: 'transferred');
      expect(transferredCard.isTransferred, true);
    });

    test('GiftCardBrand entity should create with required fields', () {
      final brand = GiftCardBrand(
        id: 'brand-1',
        name: 'Test Brand',
        logoUrl: 'https://example.com/logo.png',
        description: 'Test description',
        category: 'shopping',
        discountPercentage: 5.0,
        minAmount: 10.0,
        maxAmount: 500.0,
        fixedDenominations: [
          GiftCardDenomination(price: 25.0, currencyCode: 'USD'),
          GiftCardDenomination(price: 50.0, currencyCode: 'USD'),
        ],
      );

      expect(brand.id, 'brand-1');
      expect(brand.name, 'Test Brand');
      expect(brand.minAmount, 10.0);
      expect(brand.maxAmount, 500.0);
      expect(brand.fixedDenominations.length, 2);
    });

    test('GiftCardTransaction entity should create with all fields', () {
      final transaction = GiftCardTransaction(
        id: 'txn-1',
        giftCardId: 'card-1',
        userId: 'user-1',
        amount: 100.0,
        transactionType: 'purchase',
        description: 'Purchase transaction',
        createdAt: '2025-01-01T00:00:00Z',
        balanceBefore: 200.0,
        balanceAfter: 100.0,
        reference: 'GC-txn-1',
      );

      expect(transaction.id, 'txn-1');
      expect(transaction.transactionType, 'purchase');
      expect(transaction.description, 'Purchase transaction');
      expect(transaction.balanceBefore, 200.0);
      expect(transaction.balanceAfter, 100.0);
    });

    test('GiftCard copyWith should work correctly', () {
      final original = GiftCard(
        id: 'test-id',
        brandId: 'brand-1',
        brandName: 'Test Brand',
        logoUrl: 'https://example.com/logo.png',
        originalAmount: 100.0,
        currentBalance: 100.0,
        currency: 'USD',
        status: 'active',
        purchaseDate: '2025-01-01T00:00:00Z',
        expiryDate: '2026-01-01T00:00:00Z',
        discountPercentage: 5.0,
      );

      final updated = original.copyWith(
        status: 'partially_redeemed',
        currentBalance: 75.0,
      );

      expect(updated.status, 'partially_redeemed');
      expect(updated.currentBalance, 75.0);
      expect(updated.brandName, 'Test Brand'); // Unchanged fields should remain
      expect(updated.id, 'test-id');
    });
  });
}
