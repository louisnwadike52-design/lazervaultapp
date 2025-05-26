import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/gift_card_entity.dart';
import 'gift_card_state.dart';

class GiftCardCubit extends Cubit<GiftCardState> {
  GiftCardCubit() : super(GiftCardInitial());

  Future<void> loadGiftCardBrands() async {
    try {
      emit(GiftCardBrandsLoading());
      // Simulate loading brands - replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));
      final brands = <GiftCardBrand>[
        const GiftCardBrand(
          id: '1',
          name: 'Amazon',
          logoUrl: 'https://example.com/amazon-logo.png',
          description: 'Shop everything on Amazon',
          category: GiftCardCategory.shopping,
          discountPercentage: 5.0,
          isPopular: true,
        ),
        const GiftCardBrand(
          id: '2',
          name: 'Starbucks',
          logoUrl: 'https://example.com/starbucks-logo.png',
          description: 'Coffee and more',
          category: GiftCardCategory.dining,
          discountPercentage: 3.0,
          isPopular: true,
        ),
      ];
      emit(GiftCardBrandsLoaded(brands));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> loadGiftCardBrandsByCategory(GiftCardCategory category) async {
    try {
      emit(GiftCardBrandsLoading());
      // Simulate loading brands by category
      await Future.delayed(const Duration(seconds: 1));
      final brands = <GiftCardBrand>[
        const GiftCardBrand(
          id: '1',
          name: 'Amazon',
          logoUrl: 'https://example.com/amazon-logo.png',
          description: 'Shop everything on Amazon',
          category: GiftCardCategory.shopping,
          discountPercentage: 5.0,
          isPopular: true,
        ),
      ];
      emit(GiftCardBrandsLoaded(brands));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> searchGiftCardBrands(String query) async {
    try {
      emit(GiftCardBrandsLoading());
      // Simulate search
      await Future.delayed(const Duration(milliseconds: 500));
      final results = <GiftCardBrand>[
        const GiftCardBrand(
          id: '1',
          name: 'Amazon',
          logoUrl: 'https://example.com/amazon-logo.png',
          description: 'Shop everything on Amazon',
          category: GiftCardCategory.shopping,
          discountPercentage: 5.0,
          isPopular: true,
        ),
      ];
      emit(GiftCardBrandsSearched(results, query));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) async {
    emit(GiftCardPurchasing());
    
    try {
      // Simulate purchase
      await Future.delayed(const Duration(seconds: 2));
      final giftCard = GiftCard(
        id: 'gc_${DateTime.now().millisecondsSinceEpoch}',
      brandId: brandId,
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
      amount: amount,
        discountPercentage: 5.0,
        finalPrice: amount * 0.95,
      currency: currency,
        status: GiftCardStatus.active,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now(),
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      message: message,
        code: 'AMZN${DateTime.now().millisecondsSinceEpoch}',
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardPurchased(giftCard));
    } catch (e) {
      emit(GiftCardPurchaseError(e.toString()));
    }
  }

  Future<void> redeemGiftCard(String giftCardId, String code) async {
    emit(GiftCardRedeeming());
    
    try {
      // Simulate redemption
      await Future.delayed(const Duration(seconds: 2));
      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.used,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        code: code,
        isRedeemed: true,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardRedeemed(giftCard));
    } catch (e) {
      emit(GiftCardRedeemError(e.toString()));
    }
  }

  void resetState() {
    emit(GiftCardInitial());
  }

  Future<void> loadMyGiftCards() async {
    try {
      emit(GiftCardLoading());
      // Simulate loading user's gift cards
      await Future.delayed(const Duration(seconds: 1));
      final giftCards = <GiftCard>[
        GiftCard(
          id: 'gc_1',
          brandId: '1',
          brandName: 'Amazon',
          logoUrl: 'https://example.com/amazon-logo.png',
          amount: 100.0,
          discountPercentage: 5.0,
          finalPrice: 95.0,
          currency: 'USD',
          status: GiftCardStatus.active,
          type: GiftCardType.digital,
          category: GiftCardCategory.shopping,
          description: 'Amazon Gift Card',
          termsAndConditions: 'Terms and conditions apply',
          expiryDate: DateTime.now().add(const Duration(days: 365)),
          purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
          code: 'AMZN123456789',
          isRedeemed: false,
          availableDenominations: ['25', '50', '100'],
        ),
        GiftCard(
          id: 'gc_2',
          brandId: '2',
          brandName: 'Starbucks',
          logoUrl: 'https://example.com/starbucks-logo.png',
          amount: 50.0,
          discountPercentage: 3.0,
          finalPrice: 48.5,
          currency: 'USD',
          status: GiftCardStatus.pending,
          type: GiftCardType.digital,
          category: GiftCardCategory.dining,
          description: 'Starbucks Gift Card',
          termsAndConditions: 'Terms and conditions apply',
          expiryDate: DateTime.now().add(const Duration(days: 365)),
          purchaseDate: DateTime.now().subtract(const Duration(days: 5)),
          code: 'STAR987654321',
          isRedeemed: false,
          availableDenominations: ['25', '50', '100'],
        ),
        GiftCard(
          id: 'gc_3',
          brandId: '3',
          brandName: 'Netflix',
          logoUrl: 'https://example.com/netflix-logo.png',
          amount: 25.0,
          discountPercentage: 0.0,
          finalPrice: 25.0,
          currency: 'USD',
          status: GiftCardStatus.used,
          type: GiftCardType.digital,
          category: GiftCardCategory.entertainment,
          description: 'Netflix Gift Card',
          termsAndConditions: 'Terms and conditions apply',
          expiryDate: DateTime.now().add(const Duration(days: 300)),
          purchaseDate: DateTime.now().subtract(const Duration(days: 60)),
          code: 'NFLX456789123',
          isRedeemed: true,
          availableDenominations: ['25', '50', '100'],
        ),
      ];
      emit(MyGiftCardsLoaded(giftCards));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> sellGiftCardToContact({
    required String giftCardId,
    required String contactName,
    required String contactEmail,
    required double price,
  }) async {
    emit(GiftCardSelling());
    
    try {
      // Simulate selling gift card
      await Future.delayed(const Duration(seconds: 2));
      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.used,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        recipientEmail: contactEmail,
        recipientName: contactName,
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardSold(giftCard));
    } catch (e) {
      emit(GiftCardSellError(e.toString()));
    }
  }

  Future<void> sendGiftCardToContact({
    required String giftCardId,
    required String contactName,
    required String contactEmail,
    String? message,
  }) async {
    emit(GiftCardSending());
    
    try {
      // Simulate sending gift card
      await Future.delayed(const Duration(seconds: 2));
      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.active,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now(),
        recipientEmail: contactEmail,
        recipientName: contactName,
        message: message,
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardSent(giftCard));
    } catch (e) {
      emit(GiftCardSendError(e.toString()));
    }
  }

  Future<void> validateGiftCardCode(String code) async {
    try {
      emit(GiftCardLoading());
      // Simulate code validation
      await Future.delayed(const Duration(seconds: 1));
      // Simple validation - in real app, this would call an API
      final isValid = code.length >= 8 && code.isNotEmpty;
      emit(GiftCardCodeValidated(isValid));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> checkGiftCardBalance(String giftCardId) async {
    try {
      emit(GiftCardLoading());
      // Simulate balance check
      await Future.delayed(const Duration(seconds: 1));
      // Mock balance - in real app, this would call an API
      final balance = 75.50; // Example remaining balance
      emit(GiftCardBalanceLoaded(balance, giftCardId));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> loadGiftCardTransactions(String giftCardId) async {
    try {
      emit(GiftCardLoading());
      // Simulate loading transactions
      await Future.delayed(const Duration(seconds: 1));
      final transactions = <GiftCardTransaction>[
        GiftCardTransaction(
          id: 'txn_1',
          giftCardId: giftCardId,
          userId: 'user_1',
          amount: 25.0,
          currency: 'USD',
          transactionDate: DateTime.now().subtract(const Duration(days: 5)),
          transactionType: 'redeem',
          status: GiftCardStatus.used,
        ),
      ];
      emit(GiftCardTransactionsLoaded(transactions));
    } catch (e) {
      emit(GiftCardError(e.toString()));
    }
  }

  Future<void> quickSellGiftCard({
    required String giftCardId,
    required double askingPrice,
  }) async {
    emit(GiftCardSelling());
    
    try {
      // Simulate quick sell
      await Future.delayed(const Duration(seconds: 2));
      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: askingPrice,
        currency: 'USD',
        status: GiftCardStatus.pending,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card - Quick Sell',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardSold(giftCard));
    } catch (e) {
      emit(GiftCardSellError(e.toString()));
    }
  }
} 