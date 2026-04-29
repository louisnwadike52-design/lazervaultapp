import '../../domain/entities/gift_card_entity.dart';
import '../../../../generated/giftcards.pb.dart' as pb;

/// Result wrapper for paginated gift card brands from the data source
class GiftCardBrandsResult {
  final List<GiftCardBrandModel> brands;
  final int total;
  final int totalPages;
  final int currentPage;
  final bool hasNext;

  const GiftCardBrandsResult({
    required this.brands,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.hasNext,
  });
}

class GiftCardModel extends GiftCard {
  const GiftCardModel({
    required super.id,
    super.userId,
    super.accountId,
    required super.brandId,
    required super.brandName,
    super.logoUrl,
    required super.originalAmount,
    required super.currency,
    required super.status,
    required super.purchaseDate,
    required super.expiryDate,
    super.recipientEmail,
    super.recipientName,
    super.message,
    super.providerTransactionId,
    super.redemptionCode,
    super.redemptionPin,
    super.redemptionInstructions,
    super.countryCode,
    super.providerProductId,
    super.discountPercentage,
    super.senderAmount,
    super.senderCurrency,
    super.createdAt,
    super.updatedAt,
  });

  factory GiftCardModel.fromProto(pb.GiftCard proto) {
    return GiftCardModel(
      id: proto.id,
      userId: proto.userId,
      accountId: proto.accountId,
      brandId: proto.brandId,
      brandName: proto.brandName,
      logoUrl: proto.logoUrl,
      originalAmount: proto.originalAmount,
      currency: proto.currency,
      status: proto.status,
      purchaseDate: proto.purchaseDate,
      expiryDate: proto.expiryDate,
      recipientEmail: proto.recipientEmail.isEmpty ? null : proto.recipientEmail,
      recipientName: proto.recipientName.isEmpty ? null : proto.recipientName,
      message: proto.message.isEmpty ? null : proto.message,
      providerTransactionId: proto.providerTransactionId.isEmpty ? null : proto.providerTransactionId,
      redemptionCode: proto.redemptionCode.isEmpty ? null : proto.redemptionCode,
      redemptionPin: proto.redemptionPin.isEmpty ? null : proto.redemptionPin,
      redemptionInstructions: proto.redemptionInstructions.isEmpty ? null : proto.redemptionInstructions,
      countryCode: proto.countryCode.isEmpty ? null : proto.countryCode,
      providerProductId: proto.providerProductId.toInt(),
      discountPercentage: proto.discountPercentage,
      senderAmount: proto.senderAmount,
      senderCurrency: proto.senderCurrency,
      createdAt: proto.createdAt,
      updatedAt: proto.updatedAt,
    );
  }

  factory GiftCardModel.fromJson(Map<String, dynamic> json) {
    return GiftCardModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      brandId: json['brandId'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      originalAmount: (json['originalAmount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? '',
      status: json['status'] as String? ?? 'available',
      purchaseDate: json['purchaseDate'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      recipientEmail: json['recipientEmail'] as String?,
      recipientName: json['recipientName'] as String?,
      message: json['message'] as String?,
      providerTransactionId: json['providerTransactionId'] as String?,
      redemptionCode: json['redemptionCode'] as String?,
      redemptionPin: json['redemptionPin'] as String?,
      redemptionInstructions: json['redemptionInstructions'] as String?,
      countryCode: json['countryCode'] as String?,
      providerProductId: json['providerProductId'] as int? ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      senderAmount: (json['senderAmount'] as num?)?.toDouble() ?? 0.0,
      senderCurrency: json['senderCurrency'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}

class GiftCardBrandModel extends GiftCardBrand {
  const GiftCardBrandModel({
    required super.id,
    required super.name,
    super.logoUrl,
    super.category,
    super.description,
    super.denominations,
    super.minAmount,
    super.maxAmount,
    super.isActive,
    super.termsAndConditions,
    super.productId,
    super.countryCode,
    super.fixedDenominations,
    super.discountPercentage,
    super.currencyCode,
    super.redemptionInstructions,
    super.providerName,
    super.senderCurrencyCode,
    super.senderDenominations,
    super.fixedSenderDenominations,
    super.minSenderAmount,
    super.maxSenderAmount,
    super.senderFee,
    super.senderFeePercentage,
    super.denominationType,
  });

  factory GiftCardBrandModel.fromProto(pb.GiftCardBrand proto) {
    return GiftCardBrandModel(
      id: proto.id,
      name: proto.name,
      logoUrl: proto.logoUrl,
      category: proto.category,
      description: proto.description,
      denominations: proto.denominations.toList(),
      minAmount: proto.minAmount,
      maxAmount: proto.maxAmount,
      isActive: proto.isActive,
      termsAndConditions: proto.termsAndConditions,
      productId: proto.productId.toInt(),
      countryCode: proto.countryCode,
      fixedDenominations: proto.fixedDenominations
          .map((d) => GiftCardDenomination(
                price: d.price,
                currencyCode: d.currencyCode,
              ))
          .toList(),
      discountPercentage: proto.discountPercentage,
      currencyCode: proto.currencyCode,
      redemptionInstructions: proto.redemptionInstructions,
      providerName: proto.providerName,
      // Sender (payment) currency fields
      senderCurrencyCode: proto.senderCurrencyCode,
      senderDenominations: proto.senderDenominations.toList(),
      fixedSenderDenominations: proto.fixedSenderDenominations
          .map((d) => GiftCardDenomination(
                price: d.price,
                currencyCode: d.currencyCode,
              ))
          .toList(),
      minSenderAmount: proto.minSenderAmount,
      maxSenderAmount: proto.maxSenderAmount,
      senderFee: proto.senderFee,
      senderFeePercentage: proto.senderFeePercentage,
      denominationType: proto.denominationType,
    );
  }

  factory GiftCardBrandModel.fromJson(Map<String, dynamic> json) {
    return GiftCardBrandModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      denominations: (json['denominations'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ?? [],
      minAmount: (json['minAmount'] as num?)?.toDouble() ?? 0.0,
      maxAmount: (json['maxAmount'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool? ?? true,
      termsAndConditions: json['termsAndConditions'] as String? ?? '',
      productId: json['productId'] as int? ?? 0,
      countryCode: json['countryCode'] as String? ?? '',
      fixedDenominations: (json['fixedDenominations'] as List<dynamic>?)
          ?.map((e) => GiftCardDenomination.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      currencyCode: json['currencyCode'] as String? ?? '',
      redemptionInstructions: json['redemptionInstructions'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      senderCurrencyCode: json['senderCurrencyCode'] as String? ?? '',
      senderDenominations: (json['senderDenominations'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ?? [],
      fixedSenderDenominations: (json['fixedSenderDenominations'] as List<dynamic>?)
          ?.map((e) => GiftCardDenomination.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      minSenderAmount: (json['minSenderAmount'] as num?)?.toDouble() ?? 0.0,
      maxSenderAmount: (json['maxSenderAmount'] as num?)?.toDouble() ?? 0.0,
      senderFee: (json['senderFee'] as num?)?.toDouble() ?? 0.0,
      senderFeePercentage: (json['senderFeePercentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class SellableCardModel extends SellableCard {
  const SellableCardModel({
    required super.cardType,
    required super.displayName,
    super.logoUrl,
    super.category,
    super.denominations,
    super.currencies,
    super.minDenomination,
    super.maxDenomination,
    super.providerName,
    super.form,
    super.subcategoryId,
    super.country,
  });

  factory SellableCardModel.fromProto(pb.SellableCard proto) {
    return SellableCardModel(
      cardType: proto.cardType,
      displayName: proto.displayName,
      logoUrl: proto.logoUrl,
      category: proto.category,
      denominations: proto.denominations.toList(),
      currencies: proto.currencies.toList(),
      minDenomination: proto.minDenomination,
      maxDenomination: proto.maxDenomination,
      providerName: proto.providerName,
      // Doc-aligned Prestmit fields per documentation.prestmit.io.
      form: proto.form,
      subcategoryId: proto.subcategoryId,
      country: proto.country,
    );
  }
}

class SellRateModel extends SellRate {
  const SellRateModel({
    required super.cardType,
    required super.denomination,
    required super.ratePercentage,
    required super.payoutAmount,
    super.currency,
    super.expiresAt,
  });

  factory SellRateModel.fromProto(pb.SellRate proto) {
    return SellRateModel(
      cardType: proto.cardType,
      denomination: proto.denomination,
      ratePercentage: proto.ratePercentage,
      payoutAmount: proto.payoutAmount,
      currency: proto.currency,
      expiresAt: proto.expiresAt,
    );
  }
}

class GiftCardSaleModel extends GiftCardSale {
  const GiftCardSaleModel({
    required super.id,
    super.userId,
    super.accountId,
    required super.cardType,
    super.cardNumber,
    required super.denomination,
    super.currency,
    super.ratePercentage,
    super.expectedPayout,
    super.actualPayout,
    required super.status,
    super.providerSaleId,
    super.providerName,
    super.reference,
    super.submittedAt,
    super.reviewedAt,
    super.paidAt,
    super.createdAt,
    super.updatedAt,
  });

  factory GiftCardSaleModel.fromProto(pb.GiftCardSale proto) {
    return GiftCardSaleModel(
      id: proto.id,
      userId: proto.userId,
      accountId: proto.accountId,
      cardType: proto.cardType,
      cardNumber: proto.cardNumber,
      denomination: proto.denomination,
      currency: proto.currency,
      ratePercentage: proto.ratePercentage,
      expectedPayout: proto.expectedPayout,
      actualPayout: proto.actualPayout,
      status: proto.status,
      providerSaleId: proto.providerSaleId,
      providerName: proto.providerName,
      reference: proto.reference,
      submittedAt: proto.submittedAt,
      reviewedAt: proto.reviewedAt,
      paidAt: proto.paidAt,
      createdAt: proto.createdAt,
      updatedAt: proto.updatedAt,
    );
  }
}

class GiftCardTransactionModel extends GiftCardTransaction {
  const GiftCardTransactionModel({
    required super.id,
    required super.giftCardId,
    super.userId,
    required super.transactionType,
    required super.amount,
    super.balanceBefore,
    super.balanceAfter,
    super.description,
    super.createdAt,
    super.providerTransactionId,
    super.reference,
  });

  factory GiftCardTransactionModel.fromProto(pb.GiftCardTransaction proto) {
    return GiftCardTransactionModel(
      id: proto.id,
      giftCardId: proto.giftCardId,
      userId: proto.userId,
      transactionType: proto.transactionType,
      amount: proto.amount,
      balanceBefore: proto.balanceBefore,
      balanceAfter: proto.balanceAfter,
      description: proto.description,
      createdAt: proto.createdAt,
      providerTransactionId: proto.providerTransactionId,
      reference: proto.reference,
    );
  }

  factory GiftCardTransactionModel.fromJson(Map<String, dynamic> json) {
    return GiftCardTransactionModel(
      id: json['id'] as String? ?? '',
      giftCardId: json['giftCardId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      transactionType: json['transactionType'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      balanceBefore: (json['balanceBefore'] as num?)?.toDouble() ?? 0.0,
      balanceAfter: (json['balanceAfter'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      providerTransactionId: json['providerTransactionId'] as String? ?? '',
      reference: json['reference'] as String? ?? '',
    );
  }
}
