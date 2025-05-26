import '../entities/gift_card_entity.dart';

abstract class GiftCardRepository {
  Future<List<GiftCardBrand>> getGiftCardBrands();
  Future<List<GiftCardBrand>> getGiftCardBrandsByCategory(GiftCardCategory category);
  Future<List<GiftCardBrand>> searchGiftCardBrands(String query);
  Future<List<GiftCard>> getMyGiftCards();
} 