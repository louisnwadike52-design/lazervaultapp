import '../../domain/entities/gift_card_entity.dart';

class GiftCardModel extends GiftCard {
  const GiftCardModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.logoUrl,
    required super.amount,
    required super.discountPercentage,
    required super.finalPrice,
    required super.currency,
    required super.status,
    required super.type,
    required super.category,
    required super.description,
    required super.termsAndConditions,
    required super.expiryDate,
    required super.purchaseDate,
    super.recipientEmail,
    super.recipientName,
    super.message,
    super.code,
    super.pin,
    required super.isRedeemed,
    super.transactionId,
    required super.availableDenominations,
    super.qrCodeUrl,
    super.barcodeUrl,
    super.additionalInfo,
  });

  factory GiftCardModel.fromJson(Map<String, dynamic> json) {
    return GiftCardModel(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      logoUrl: json['logoUrl'] as String,
      amount: (json['amount'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      finalPrice: (json['finalPrice'] as num).toDouble(),
      currency: json['currency'] as String,
      status: GiftCardStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => GiftCardStatus.active,
      ),
      type: GiftCardType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => GiftCardType.digital,
      ),
      category: GiftCardCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => GiftCardCategory.shopping,
      ),
      description: json['description'] as String,
      termsAndConditions: json['termsAndConditions'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      recipientEmail: json['recipientEmail'] as String?,
      recipientName: json['recipientName'] as String?,
      message: json['message'] as String?,
      code: json['code'] as String?,
      pin: json['pin'] as String?,
      isRedeemed: json['isRedeemed'] as bool,
      transactionId: json['transactionId'] as String?,
      availableDenominations: (json['availableDenominations'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      qrCodeUrl: json['qrCodeUrl'] as String?,
      barcodeUrl: json['barcodeUrl'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandId': brandId,
      'brandName': brandName,
      'logoUrl': logoUrl,
      'amount': amount,
      'discountPercentage': discountPercentage,
      'finalPrice': finalPrice,
      'currency': currency,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'category': category.toString().split('.').last,
      'description': description,
      'termsAndConditions': termsAndConditions,
      'expiryDate': expiryDate.toIso8601String(),
      'purchaseDate': purchaseDate.toIso8601String(),
      'recipientEmail': recipientEmail,
      'recipientName': recipientName,
      'message': message,
      'code': code,
      'pin': pin,
      'isRedeemed': isRedeemed,
      'transactionId': transactionId,
      'availableDenominations': availableDenominations,
      'qrCodeUrl': qrCodeUrl,
      'barcodeUrl': barcodeUrl,
      'additionalInfo': additionalInfo,
    };
  }
}

class GiftCardBrandModel extends GiftCardBrand {
  const GiftCardBrandModel({
    required super.id,
    required super.name,
    required super.logoUrl,
    required super.description,
    required super.category,
    super.discountPercentage,
    super.isPopular = false,
  });

  factory GiftCardBrandModel.fromJson(Map<String, dynamic> json) {
    return GiftCardBrandModel(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String,
      description: json['description'] as String,
      category: GiftCardCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => GiftCardCategory.shopping,
      ),
      discountPercentage: json['discountPercentage'] != null 
          ? (json['discountPercentage'] as num).toDouble() 
          : null,
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'description': description,
      'category': category.toString().split('.').last,
      'discountPercentage': discountPercentage,
      'isPopular': isPopular,
    };
  }
}

class GiftCardTransactionModel extends GiftCardTransaction {
  const GiftCardTransactionModel({
    required super.id,
    required super.giftCardId,
    required super.userId,
    required super.amount,
    required super.currency,
    required super.transactionDate,
    required super.transactionType,
    required super.status,
    super.failureReason,
    super.additionalDetails,
  });

  factory GiftCardTransactionModel.fromJson(Map<String, dynamic> json) {
    return GiftCardTransactionModel(
      id: json['id'] as String,
      giftCardId: json['giftCardId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      transactionDate: DateTime.parse(json['transactionDate'] as String),
      transactionType: json['transactionType'] as String,
      status: GiftCardStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => GiftCardStatus.pending,
      ),
      failureReason: json['failureReason'] as String?,
      additionalDetails: json['additionalDetails'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'giftCardId': giftCardId,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      'transactionDate': transactionDate.toIso8601String(),
      'transactionType': transactionType,
      'status': status.toString().split('.').last,
      'failureReason': failureReason,
      'additionalDetails': additionalDetails,
    };
  }
} 