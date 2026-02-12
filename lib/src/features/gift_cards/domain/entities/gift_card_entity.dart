import 'package:equatable/equatable.dart';

class GiftCard extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String brandId;
  final String brandName;
  final String logoUrl;
  final String cardNumber;
  final String? pin;
  final double originalAmount;
  final double currentBalance;
  final String currency;
  final String status;
  final String purchaseDate;
  final String expiryDate;
  final String? recipientEmail;
  final String? recipientName;
  final String? message;
  final String? qrCode;
  final String? providerTransactionId;
  final String? redemptionCode;
  final String? redemptionPin;
  final String? countryCode;
  final int providerProductId;
  final double discountPercentage;
  final String createdAt;
  final String updatedAt;

  const GiftCard({
    required this.id,
    this.userId = '',
    this.accountId = '',
    required this.brandId,
    required this.brandName,
    this.logoUrl = '',
    this.cardNumber = '',
    this.pin,
    required this.originalAmount,
    required this.currentBalance,
    required this.currency,
    required this.status,
    required this.purchaseDate,
    required this.expiryDate,
    this.recipientEmail,
    this.recipientName,
    this.message,
    this.qrCode,
    this.providerTransactionId,
    this.redemptionCode,
    this.redemptionPin,
    this.countryCode,
    this.providerProductId = 0,
    this.discountPercentage = 0.0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  bool get isActive => status == 'active';
  bool get isRedeemed => status == 'redeemed';
  bool get isExpired => status == 'expired';
  bool get isTransferred => status == 'transferred';

  @override
  List<Object?> get props => [
    id,
    userId,
    accountId,
    brandId,
    brandName,
    logoUrl,
    cardNumber,
    pin,
    originalAmount,
    currentBalance,
    currency,
    status,
    purchaseDate,
    expiryDate,
    recipientEmail,
    recipientName,
    message,
    qrCode,
    providerTransactionId,
    redemptionCode,
    redemptionPin,
    countryCode,
    providerProductId,
    discountPercentage,
    createdAt,
    updatedAt,
  ];

  GiftCard copyWith({
    String? id,
    String? userId,
    String? accountId,
    String? brandId,
    String? brandName,
    String? logoUrl,
    String? cardNumber,
    String? pin,
    double? originalAmount,
    double? currentBalance,
    String? currency,
    String? status,
    String? purchaseDate,
    String? expiryDate,
    String? recipientEmail,
    String? recipientName,
    String? message,
    String? qrCode,
    String? providerTransactionId,
    String? redemptionCode,
    String? redemptionPin,
    String? countryCode,
    int? providerProductId,
    double? discountPercentage,
    String? createdAt,
    String? updatedAt,
  }) {
    return GiftCard(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      logoUrl: logoUrl ?? this.logoUrl,
      cardNumber: cardNumber ?? this.cardNumber,
      pin: pin ?? this.pin,
      originalAmount: originalAmount ?? this.originalAmount,
      currentBalance: currentBalance ?? this.currentBalance,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      recipientName: recipientName ?? this.recipientName,
      message: message ?? this.message,
      qrCode: qrCode ?? this.qrCode,
      providerTransactionId: providerTransactionId ?? this.providerTransactionId,
      redemptionCode: redemptionCode ?? this.redemptionCode,
      redemptionPin: redemptionPin ?? this.redemptionPin,
      countryCode: countryCode ?? this.countryCode,
      providerProductId: providerProductId ?? this.providerProductId,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'accountId': accountId,
      'brandId': brandId,
      'brandName': brandName,
      'logoUrl': logoUrl,
      'cardNumber': cardNumber,
      'pin': pin,
      'originalAmount': originalAmount,
      'currentBalance': currentBalance,
      'currency': currency,
      'status': status,
      'purchaseDate': purchaseDate,
      'expiryDate': expiryDate,
      'recipientEmail': recipientEmail,
      'recipientName': recipientName,
      'message': message,
      'qrCode': qrCode,
      'providerTransactionId': providerTransactionId,
      'redemptionCode': redemptionCode,
      'redemptionPin': redemptionPin,
      'countryCode': countryCode,
      'providerProductId': providerProductId,
      'discountPercentage': discountPercentage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      brandId: json['brandId'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      cardNumber: json['cardNumber'] as String? ?? '',
      pin: json['pin'] as String?,
      originalAmount: (json['originalAmount'] as num?)?.toDouble() ?? 0.0,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      purchaseDate: json['purchaseDate'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      recipientEmail: json['recipientEmail'] as String?,
      recipientName: json['recipientName'] as String?,
      message: json['message'] as String?,
      qrCode: json['qrCode'] as String?,
      providerTransactionId: json['providerTransactionId'] as String?,
      redemptionCode: json['redemptionCode'] as String?,
      redemptionPin: json['redemptionPin'] as String?,
      countryCode: json['countryCode'] as String?,
      providerProductId: json['providerProductId'] as int? ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}

class GiftCardBrand extends Equatable {
  final String id;
  final String name;
  final String logoUrl;
  final String category;
  final String description;
  final List<double> denominations;
  final double minAmount;
  final double maxAmount;
  final bool isActive;
  final String termsAndConditions;
  final int productId;
  final String countryCode;
  final List<GiftCardDenomination> fixedDenominations;
  final double discountPercentage;
  final String currencyCode;
  final String redemptionInstructions;

  const GiftCardBrand({
    required this.id,
    required this.name,
    this.logoUrl = '',
    this.category = '',
    this.description = '',
    this.denominations = const [],
    this.minAmount = 0.0,
    this.maxAmount = 0.0,
    this.isActive = true,
    this.termsAndConditions = '',
    this.productId = 0,
    this.countryCode = '',
    this.fixedDenominations = const [],
    this.discountPercentage = 0.0,
    this.currencyCode = '',
    this.redemptionInstructions = '',
  });

  @override
  List<Object?> get props => [
    id,
    name,
    logoUrl,
    category,
    description,
    denominations,
    minAmount,
    maxAmount,
    isActive,
    termsAndConditions,
    productId,
    countryCode,
    fixedDenominations,
    discountPercentage,
    currencyCode,
    redemptionInstructions,
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'category': category,
      'description': description,
      'denominations': denominations,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'isActive': isActive,
      'termsAndConditions': termsAndConditions,
      'productId': productId,
      'countryCode': countryCode,
      'fixedDenominations': fixedDenominations.map((d) => d.toJson()).toList(),
      'discountPercentage': discountPercentage,
      'currencyCode': currencyCode,
      'redemptionInstructions': redemptionInstructions,
    };
  }

  factory GiftCardBrand.fromJson(Map<String, dynamic> json) {
    return GiftCardBrand(
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
    );
  }
}

class GiftCardDenomination extends Equatable {
  final double price;
  final String currencyCode;

  const GiftCardDenomination({
    required this.price,
    this.currencyCode = '',
  });

  @override
  List<Object?> get props => [price, currencyCode];

  Map<String, dynamic> toJson() => {'price': price, 'currencyCode': currencyCode};

  factory GiftCardDenomination.fromJson(Map<String, dynamic> json) {
    return GiftCardDenomination(
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currencyCode: json['currencyCode'] as String? ?? '',
    );
  }
}

class GiftCardTransaction extends Equatable {
  final String id;
  final String giftCardId;
  final String userId;
  final String transactionType;
  final double amount;
  final double balanceBefore;
  final double balanceAfter;
  final String description;
  final String createdAt;
  final String providerTransactionId;
  final String reference;

  const GiftCardTransaction({
    required this.id,
    required this.giftCardId,
    this.userId = '',
    required this.transactionType,
    required this.amount,
    this.balanceBefore = 0.0,
    this.balanceAfter = 0.0,
    this.description = '',
    this.createdAt = '',
    this.providerTransactionId = '',
    this.reference = '',
  });

  @override
  List<Object?> get props => [
    id,
    giftCardId,
    userId,
    transactionType,
    amount,
    balanceBefore,
    balanceAfter,
    description,
    createdAt,
    providerTransactionId,
    reference,
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'giftCardId': giftCardId,
      'userId': userId,
      'transactionType': transactionType,
      'amount': amount,
      'balanceBefore': balanceBefore,
      'balanceAfter': balanceAfter,
      'description': description,
      'createdAt': createdAt,
      'providerTransactionId': providerTransactionId,
      'reference': reference,
    };
  }

  factory GiftCardTransaction.fromJson(Map<String, dynamic> json) {
    return GiftCardTransaction(
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

/// Gift card balance check result
class GiftCardBalance extends Equatable {
  final double balance;
  final String brandName;
  final String expiryDate;
  final String status;

  const GiftCardBalance({
    required this.balance,
    required this.brandName,
    required this.expiryDate,
    required this.status,
  });

  @override
  List<Object?> get props => [balance, brandName, expiryDate, status];
}

/// A card type that can be sold for Naira
class SellableCard extends Equatable {
  final String cardType;
  final String displayName;
  final String logoUrl;
  final String category;
  final List<double> denominations;
  final List<String> currencies;
  final double minDenomination;
  final double maxDenomination;

  const SellableCard({
    required this.cardType,
    required this.displayName,
    this.logoUrl = '',
    this.category = '',
    this.denominations = const [],
    this.currencies = const [],
    this.minDenomination = 0.0,
    this.maxDenomination = 0.0,
  });

  @override
  List<Object?> get props => [
    cardType, displayName, logoUrl, category,
    denominations, currencies, minDenomination, maxDenomination,
  ];
}

/// Rate for selling a gift card
class SellRate extends Equatable {
  final String cardType;
  final double denomination;
  final double ratePercentage;
  final double payoutAmount;
  final String currency;
  final String expiresAt;

  const SellRate({
    required this.cardType,
    required this.denomination,
    required this.ratePercentage,
    required this.payoutAmount,
    this.currency = 'NGN',
    this.expiresAt = '',
  });

  @override
  List<Object?> get props => [
    cardType, denomination, ratePercentage, payoutAmount, currency, expiresAt,
  ];
}

/// A gift card sale transaction
class GiftCardSale extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String cardType;
  final String cardNumber;
  final double denomination;
  final String currency;
  final double ratePercentage;
  final double expectedPayout;
  final double actualPayout;
  final String status;
  final String providerSaleId;
  final String providerName;
  final String reference;
  final String submittedAt;
  final String reviewedAt;
  final String paidAt;
  final String createdAt;
  final String updatedAt;

  const GiftCardSale({
    required this.id,
    this.userId = '',
    this.accountId = '',
    required this.cardType,
    this.cardNumber = '',
    required this.denomination,
    this.currency = 'NGN',
    this.ratePercentage = 0.0,
    this.expectedPayout = 0.0,
    this.actualPayout = 0.0,
    required this.status,
    this.providerSaleId = '',
    this.providerName = '',
    this.reference = '',
    this.submittedAt = '',
    this.reviewedAt = '',
    this.paidAt = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  bool get isPending => status == 'pending';
  bool get isReviewing => status == 'reviewing';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
  bool get isPaid => status == 'paid';
  bool get isCancelled => status == 'cancelled';

  @override
  List<Object?> get props => [
    id, userId, accountId, cardType, cardNumber, denomination, currency,
    ratePercentage, expectedPayout, actualPayout, status, providerSaleId,
    providerName, reference, submittedAt, reviewedAt, paidAt, createdAt, updatedAt,
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'accountId': accountId,
      'cardType': cardType,
      'cardNumber': cardNumber,
      'denomination': denomination,
      'currency': currency,
      'ratePercentage': ratePercentage,
      'expectedPayout': expectedPayout,
      'actualPayout': actualPayout,
      'status': status,
      'providerSaleId': providerSaleId,
      'providerName': providerName,
      'reference': reference,
      'submittedAt': submittedAt,
      'reviewedAt': reviewedAt,
      'paidAt': paidAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory GiftCardSale.fromJson(Map<String, dynamic> json) {
    return GiftCardSale(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      cardType: json['cardType'] as String? ?? '',
      cardNumber: json['cardNumber'] as String? ?? '',
      denomination: (json['denomination'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'NGN',
      ratePercentage: (json['ratePercentage'] as num?)?.toDouble() ?? 0.0,
      expectedPayout: (json['expectedPayout'] as num?)?.toDouble() ?? 0.0,
      actualPayout: (json['actualPayout'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
      providerSaleId: json['providerSaleId'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      reference: json['reference'] as String? ?? '',
      submittedAt: json['submittedAt'] as String? ?? '',
      reviewedAt: json['reviewedAt'] as String? ?? '',
      paidAt: json['paidAt'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}
