import 'package:hive/hive.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../gift_cards/data/models/gift_card_model.dart';

part 'gift_card_hive_model.g.dart';

@HiveType(typeId: 30)
class GiftCardHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String brandId;

  @HiveField(2)
  final String brandName;

  @HiveField(3)
  final String logoUrl;

  @HiveField(4)
  final double amount;

  @HiveField(5)
  final double discountPercentage;

  @HiveField(6)
  final double finalPrice;

  @HiveField(7)
  final String currency;

  @HiveField(8)
  final int statusIndex; // Store enum as index

  @HiveField(9)
  final int typeIndex; // Store enum as index

  @HiveField(10)
  final int categoryIndex; // Store enum as index

  @HiveField(11)
  final String description;

  @HiveField(12)
  final String termsAndConditions;

  @HiveField(13)
  final DateTime expiryDate;

  @HiveField(14)
  final DateTime purchaseDate;

  @HiveField(15)
  final String? recipientEmail;

  @HiveField(16)
  final String? recipientName;

  @HiveField(17)
  final String? message;

  @HiveField(18)
  final String? code;

  @HiveField(19)
  final String? pin;

  @HiveField(20)
  final bool isRedeemed;

  @HiveField(21)
  final String? transactionId;

  @HiveField(22)
  final List<String> availableDenominations;

  @HiveField(23)
  final String? qrCodeUrl;

  @HiveField(24)
  final String? barcodeUrl;

  @HiveField(25)
  final DateTime cachedAt;

  GiftCardHiveModel({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.logoUrl,
    required this.amount,
    required this.discountPercentage,
    required this.finalPrice,
    required this.currency,
    required this.statusIndex,
    required this.typeIndex,
    required this.categoryIndex,
    required this.description,
    required this.termsAndConditions,
    required this.expiryDate,
    required this.purchaseDate,
    this.recipientEmail,
    this.recipientName,
    this.message,
    this.code,
    this.pin,
    required this.isRedeemed,
    this.transactionId,
    required this.availableDenominations,
    this.qrCodeUrl,
    this.barcodeUrl,
    required this.cachedAt,
  });

  /// Convert from domain entity to Hive model
  factory GiftCardHiveModel.fromEntity(GiftCard entity) {
    return GiftCardHiveModel(
      id: entity.id,
      brandId: entity.brandId,
      brandName: entity.brandName,
      logoUrl: entity.logoUrl,
      amount: entity.amount,
      discountPercentage: entity.discountPercentage,
      finalPrice: entity.finalPrice,
      currency: entity.currency,
      statusIndex: entity.status.index,
      typeIndex: entity.type.index,
      categoryIndex: entity.category.index,
      description: entity.description,
      termsAndConditions: entity.termsAndConditions,
      expiryDate: entity.expiryDate,
      purchaseDate: entity.purchaseDate,
      recipientEmail: entity.recipientEmail,
      recipientName: entity.recipientName,
      message: entity.message,
      code: entity.code,
      pin: entity.pin,
      isRedeemed: entity.isRedeemed,
      transactionId: entity.transactionId,
      availableDenominations: entity.availableDenominations,
      qrCodeUrl: entity.qrCodeUrl,
      barcodeUrl: entity.barcodeUrl,
      cachedAt: DateTime.now(),
    );
  }

  /// Convert from Hive model to domain entity
  GiftCardModel toEntity() {
    return GiftCardModel(
      id: id,
      brandId: brandId,
      brandName: brandName,
      logoUrl: logoUrl,
      amount: amount,
      discountPercentage: discountPercentage,
      finalPrice: finalPrice,
      currency: currency,
      status: GiftCardStatus.values[statusIndex],
      type: GiftCardType.values[typeIndex],
      category: GiftCardCategory.values[categoryIndex],
      description: description,
      termsAndConditions: termsAndConditions,
      expiryDate: expiryDate,
      purchaseDate: purchaseDate,
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      message: message,
      code: code,
      pin: pin,
      isRedeemed: isRedeemed,
      transactionId: transactionId,
      availableDenominations: availableDenominations,
      qrCodeUrl: qrCodeUrl,
      barcodeUrl: barcodeUrl,
      additionalInfo: null,
    );
  }

  /// Check if cache is expired (default 24 hours)
  bool isCacheExpired({Duration ttl = const Duration(hours: 24)}) {
    return DateTime.now().difference(cachedAt) > ttl;
  }
}
