import 'package:equatable/equatable.dart';

enum GiftCardStatus { active, used, expired, pending, cancelled }
enum GiftCardType { digital, physical }
enum GiftCardCategory {
  entertainment,
  shopping,
  dining,
  travel,
  gaming,
  other
}

class GiftCard extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String logoUrl;
  final double amount;
  final double discountPercentage;
  final double finalPrice;
  final String currency;
  final GiftCardStatus status;
  final GiftCardType type;
  final GiftCardCategory category;
  final String description;
  final String termsAndConditions;
  final DateTime expiryDate;
  final DateTime purchaseDate;
  final String? recipientEmail;
  final String? recipientName;
  final String? message;
  final String? code;
  final String? pin;
  final bool isRedeemed;
  final String? transactionId;
  final List<String> availableDenominations;
  final String? qrCodeUrl;
  final String? barcodeUrl;
  final Map<String, dynamic>? additionalInfo;

  const GiftCard({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.logoUrl,
    required this.amount,
    required this.discountPercentage,
    required this.finalPrice,
    required this.currency,
    required this.status,
    required this.type,
    required this.category,
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
    this.additionalInfo,
  });

  @override
  List<Object?> get props => [
    id,
    brandId,
    brandName,
    logoUrl,
    amount,
    discountPercentage,
    finalPrice,
    currency,
    status,
    type,
    category,
    description,
    termsAndConditions,
    expiryDate,
    purchaseDate,
    recipientEmail,
    recipientName,
    message,
    code,
    pin,
    isRedeemed,
    transactionId,
    availableDenominations,
    qrCodeUrl,
    barcodeUrl,
    additionalInfo,
  ];

  GiftCard copyWith({
    String? id,
    String? brandId,
    String? brandName,
    String? logoUrl,
    double? amount,
    double? discountPercentage,
    double? finalPrice,
    String? currency,
    GiftCardStatus? status,
    GiftCardType? type,
    GiftCardCategory? category,
    String? description,
    String? termsAndConditions,
    DateTime? expiryDate,
    DateTime? purchaseDate,
    String? recipientEmail,
    String? recipientName,
    String? message,
    String? code,
    String? pin,
    bool? isRedeemed,
    String? transactionId,
    List<String>? availableDenominations,
    String? qrCodeUrl,
    String? barcodeUrl,
    Map<String, dynamic>? additionalInfo,
  }) {
    return GiftCard(
      id: id ?? this.id,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      logoUrl: logoUrl ?? this.logoUrl,
      amount: amount ?? this.amount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      finalPrice: finalPrice ?? this.finalPrice,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      expiryDate: expiryDate ?? this.expiryDate,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      recipientName: recipientName ?? this.recipientName,
      message: message ?? this.message,
      code: code ?? this.code,
      pin: pin ?? this.pin,
      isRedeemed: isRedeemed ?? this.isRedeemed,
      transactionId: transactionId ?? this.transactionId,
      availableDenominations: availableDenominations ?? this.availableDenominations,
      qrCodeUrl: qrCodeUrl ?? this.qrCodeUrl,
      barcodeUrl: barcodeUrl ?? this.barcodeUrl,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }
}

class GiftCardBrand extends Equatable {
  final String id;
  final String name;
  final String logoUrl;
  final String description;
  final GiftCardCategory category;
  final double? discountPercentage;
  final bool isPopular;

  const GiftCardBrand({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.description,
    required this.category,
    this.discountPercentage,
    this.isPopular = false,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    logoUrl,
    description,
    category,
    discountPercentage,
    isPopular,
  ];
}

class GiftCardTransaction extends Equatable {
  final String id;
  final String giftCardId;
  final String userId;
  final double amount;
  final String currency;
  final DateTime transactionDate;
  final String transactionType; // purchase, redeem, refund
  final GiftCardStatus status;
  final String? failureReason;
  final Map<String, dynamic>? additionalDetails;

  const GiftCardTransaction({
    required this.id,
    required this.giftCardId,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.transactionDate,
    required this.transactionType,
    required this.status,
    this.failureReason,
    this.additionalDetails,
  });

  @override
  List<Object?> get props => [
    id,
    giftCardId,
    userId,
    amount,
    currency,
    transactionDate,
    transactionType,
    status,
    failureReason,
    additionalDetails,
  ];
} 