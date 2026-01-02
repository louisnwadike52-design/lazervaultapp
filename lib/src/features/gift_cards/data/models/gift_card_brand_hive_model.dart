import 'package:hive/hive.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../gift_cards/data/models/gift_card_model.dart';

part 'gift_card_brand_hive_model.g.dart';

@HiveType(typeId: 31)
class GiftCardBrandHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String logoUrl;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final int categoryIndex; // Store enum as index

  @HiveField(5)
  final double? discountPercentage;

  @HiveField(6)
  final bool isPopular;

  @HiveField(7)
  final DateTime cachedAt;

  GiftCardBrandHiveModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.description,
    required this.categoryIndex,
    this.discountPercentage,
    required this.isPopular,
    required this.cachedAt,
  });

  /// Convert from domain entity to Hive model
  factory GiftCardBrandHiveModel.fromEntity(GiftCardBrand entity) {
    return GiftCardBrandHiveModel(
      id: entity.id,
      name: entity.name,
      logoUrl: entity.logoUrl,
      description: entity.description,
      categoryIndex: entity.category.index,
      discountPercentage: entity.discountPercentage,
      isPopular: entity.isPopular,
      cachedAt: DateTime.now(),
    );
  }

  /// Convert from Hive model to domain entity
  GiftCardBrandModel toEntity() {
    return GiftCardBrandModel(
      id: id,
      name: name,
      logoUrl: logoUrl,
      description: description,
      category: GiftCardCategory.values[categoryIndex],
      discountPercentage: discountPercentage,
      isPopular: isPopular,
    );
  }

  /// Check if cache is expired (default 24 hours)
  bool isCacheExpired({Duration ttl = const Duration(hours: 24)}) {
    return DateTime.now().difference(cachedAt) > ttl;
  }
}
