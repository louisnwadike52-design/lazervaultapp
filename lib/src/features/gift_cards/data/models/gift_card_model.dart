import '../../domain/entities/gift_card_entity.dart';
import '../../../../generated/giftcard.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamp;

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

  factory GiftCardModel.fromProto(pb.GiftCard proto) {
    return GiftCardModel(
      id: proto.id,
      brandId: proto.brandId,
      brandName: proto.brandName,
      logoUrl: proto.logoUrl,
      amount: proto.amount,
      discountPercentage: proto.discountPercentage,
      finalPrice: proto.finalPrice,
      currency: proto.currency,
      status: _statusFromProto(proto.status),
      type: _typeFromProto(proto.type),
      category: _categoryFromProto(proto.category),
      description: proto.description,
      termsAndConditions: proto.termsAndConditions,
      expiryDate: proto.expiryDate.toDateTime(),
      purchaseDate: proto.purchaseDate.toDateTime(),
      recipientEmail: proto.recipientEmail.isEmpty ? null : proto.recipientEmail,
      recipientName: proto.recipientName.isEmpty ? null : proto.recipientName,
      message: proto.message.isEmpty ? null : proto.message,
      code: proto.code.isEmpty ? null : proto.code,
      pin: proto.pin.isEmpty ? null : proto.pin,
      isRedeemed: proto.isRedeemed,
      transactionId: proto.transactionId.isEmpty ? null : proto.transactionId,
      availableDenominations: proto.availableDenominations.toList(),
      qrCodeUrl: proto.qrCodeUrl.isEmpty ? null : proto.qrCodeUrl,
      barcodeUrl: proto.barcodeUrl.isEmpty ? null : proto.barcodeUrl,
      additionalInfo: null,
    );
  }

  pb.GiftCard toProto() {
    return pb.GiftCard()
      ..id = id
      ..userId = ''
      ..brandId = brandId
      ..brandName = brandName
      ..logoUrl = logoUrl
      ..amount = amount
      ..discountPercentage = discountPercentage
      ..finalPrice = finalPrice
      ..currency = currency
      ..status = _statusToProto(status)
      ..type = _typeToProto(type)
      ..category = _categoryToProto(category)
      ..description = description
      ..termsAndConditions = termsAndConditions
      ..expiryDate = timestamp.Timestamp.fromDateTime(expiryDate)
      ..purchaseDate = timestamp.Timestamp.fromDateTime(purchaseDate)
      ..recipientEmail = recipientEmail ?? ''
      ..recipientName = recipientName ?? ''
      ..message = message ?? ''
      ..code = code ?? ''
      ..pin = pin ?? ''
      ..isRedeemed = isRedeemed
      ..transactionId = transactionId ?? ''
      ..availableDenominations.addAll(availableDenominations)
      ..qrCodeUrl = qrCodeUrl ?? ''
      ..barcodeUrl = barcodeUrl ?? ''
      ..remainingBalance = amount
      ..originalAmount = amount;
  }

  // Helper methods for enum conversion
  static GiftCardStatus _statusFromProto(pb.GiftCardStatus protoStatus) {
    switch (protoStatus) {
      case pb.GiftCardStatus.GIFTCARD_STATUS_ACTIVE:
        return GiftCardStatus.active;
      case pb.GiftCardStatus.GIFTCARD_STATUS_USED:
        return GiftCardStatus.used;
      case pb.GiftCardStatus.GIFTCARD_STATUS_EXPIRED:
        return GiftCardStatus.expired;
      case pb.GiftCardStatus.GIFTCARD_STATUS_PENDING:
        return GiftCardStatus.pending;
      case pb.GiftCardStatus.GIFTCARD_STATUS_CANCELLED:
        return GiftCardStatus.cancelled;
      case pb.GiftCardStatus.GIFTCARD_STATUS_PARTIALLY_REDEEMED:
        return GiftCardStatus.partiallyRedeemed;
      default:
        return GiftCardStatus.active;
    }
  }

  static pb.GiftCardStatus _statusToProto(GiftCardStatus status) {
    switch (status) {
      case GiftCardStatus.active:
        return pb.GiftCardStatus.GIFTCARD_STATUS_ACTIVE;
      case GiftCardStatus.used:
        return pb.GiftCardStatus.GIFTCARD_STATUS_USED;
      case GiftCardStatus.expired:
        return pb.GiftCardStatus.GIFTCARD_STATUS_EXPIRED;
      case GiftCardStatus.pending:
        return pb.GiftCardStatus.GIFTCARD_STATUS_PENDING;
      case GiftCardStatus.cancelled:
        return pb.GiftCardStatus.GIFTCARD_STATUS_CANCELLED;
      case GiftCardStatus.partiallyRedeemed:
        return pb.GiftCardStatus.GIFTCARD_STATUS_PARTIALLY_REDEEMED;
    }
  }

  static GiftCardType _typeFromProto(pb.GiftCardType protoType) {
    switch (protoType) {
      case pb.GiftCardType.GIFTCARD_TYPE_DIGITAL:
        return GiftCardType.digital;
      case pb.GiftCardType.GIFTCARD_TYPE_PHYSICAL:
        return GiftCardType.physical;
      default:
        return GiftCardType.digital;
    }
  }

  static pb.GiftCardType _typeToProto(GiftCardType type) {
    switch (type) {
      case GiftCardType.digital:
        return pb.GiftCardType.GIFTCARD_TYPE_DIGITAL;
      case GiftCardType.physical:
        return pb.GiftCardType.GIFTCARD_TYPE_PHYSICAL;
    }
  }

  static GiftCardCategory _categoryFromProto(pb.GiftCardCategory protoCategory) {
    switch (protoCategory) {
      case pb.GiftCardCategory.GIFTCARD_CATEGORY_ENTERTAINMENT:
        return GiftCardCategory.entertainment;
      case pb.GiftCardCategory.GIFTCARD_CATEGORY_SHOPPING:
        return GiftCardCategory.shopping;
      case pb.GiftCardCategory.GIFTCARD_CATEGORY_DINING:
        return GiftCardCategory.dining;
      case pb.GiftCardCategory.GIFTCARD_CATEGORY_TRAVEL:
        return GiftCardCategory.travel;
      case pb.GiftCardCategory.GIFTCARD_CATEGORY_GAMING:
        return GiftCardCategory.gaming;
      case pb.GiftCardCategory.GIFTCARD_CATEGORY_OTHER:
        return GiftCardCategory.other;
      default:
        return GiftCardCategory.shopping;
    }
  }

  static pb.GiftCardCategory _categoryToProto(GiftCardCategory category) {
    switch (category) {
      case GiftCardCategory.entertainment:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_ENTERTAINMENT;
      case GiftCardCategory.shopping:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_SHOPPING;
      case GiftCardCategory.dining:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_DINING;
      case GiftCardCategory.travel:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_TRAVEL;
      case GiftCardCategory.gaming:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_GAMING;
      case GiftCardCategory.other:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_OTHER;
    }
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

  factory GiftCardBrandModel.fromProto(pb.GiftCardBrand proto) {
    return GiftCardBrandModel(
      id: proto.id,
      name: proto.name,
      logoUrl: proto.logoUrl,
      description: proto.description,
      category: GiftCardModel._categoryFromProto(proto.category),
      discountPercentage: proto.discountPercentage != 0 ? proto.discountPercentage : null,
      isPopular: proto.isPopular,
    );
  }

  pb.GiftCardBrand toProto() {
    return pb.GiftCardBrand()
      ..id = id
      ..name = name
      ..logoUrl = logoUrl
      ..description = description
      ..category = GiftCardModel._categoryToProto(category)
      ..discountPercentage = discountPercentage ?? 0.0
      ..isPopular = isPopular;
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

  factory GiftCardTransactionModel.fromProto(pb.GiftCardTransaction proto) {
    return GiftCardTransactionModel(
      id: proto.id,
      giftCardId: proto.giftCardId,
      userId: proto.userId,
      amount: proto.amount,
      currency: proto.currency,
      transactionDate: proto.transactionDate.toDateTime(),
      transactionType: _transactionTypeFromProto(proto.transactionType),
      status: GiftCardModel._statusFromProto(proto.status),
      failureReason: proto.failureReason.isEmpty ? null : proto.failureReason,
      additionalDetails: null,
    );
  }

  pb.GiftCardTransaction toProto() {
    return pb.GiftCardTransaction()
      ..id = id
      ..giftCardId = giftCardId
      ..userId = userId
      ..amount = amount
      ..currency = currency
      ..transactionDate = timestamp.Timestamp.fromDateTime(transactionDate)
      ..transactionType = _transactionTypeToProto(transactionType)
      ..status = GiftCardModel._statusToProto(status)
      ..failureReason = failureReason ?? '';
  }

  // Helper methods for transaction type conversion
  static String _transactionTypeFromProto(pb.TransactionType protoType) {
    switch (protoType) {
      case pb.TransactionType.TRANSACTION_TYPE_PURCHASE:
        return 'purchase';
      case pb.TransactionType.TRANSACTION_TYPE_REDEEM:
        return 'redeem';
      case pb.TransactionType.TRANSACTION_TYPE_TRANSFER:
        return 'transfer';
      case pb.TransactionType.TRANSACTION_TYPE_REFUND:
        return 'refund';
      case pb.TransactionType.TRANSACTION_TYPE_SELL:
        return 'sell';
      default:
        return 'purchase';
    }
  }

  static pb.TransactionType _transactionTypeToProto(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case 'purchase':
        return pb.TransactionType.TRANSACTION_TYPE_PURCHASE;
      case 'redeem':
        return pb.TransactionType.TRANSACTION_TYPE_REDEEM;
      case 'transfer':
        return pb.TransactionType.TRANSACTION_TYPE_TRANSFER;
      case 'refund':
        return pb.TransactionType.TRANSACTION_TYPE_REFUND;
      case 'sell':
        return pb.TransactionType.TRANSACTION_TYPE_SELL;
      default:
        return pb.TransactionType.TRANSACTION_TYPE_PURCHASE;
    }
  }
} 