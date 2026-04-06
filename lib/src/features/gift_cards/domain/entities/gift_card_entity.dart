import 'package:equatable/equatable.dart';

class GiftCard extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String brandId;
  final String brandName;
  final String logoUrl;
  final double originalAmount;
  final String currency;
  final String status;
  final String purchaseDate;
  final String expiryDate;
  final String? recipientEmail;
  final String? recipientName;
  final String? message;
  final String? providerTransactionId;
  final String? redemptionCode;
  final String? redemptionPin;
  final String? redemptionInstructions;
  final String? countryCode;
  final int providerProductId;
  final double discountPercentage;
  /// Amount charged in sender/payment currency (what the user actually paid)
  final double senderAmount;
  /// Sender/payment currency code (e.g., "NGN")
  final String senderCurrency;
  final String createdAt;
  final String updatedAt;

  const GiftCard({
    required this.id,
    this.userId = '',
    this.accountId = '',
    required this.brandId,
    required this.brandName,
    this.logoUrl = '',
    required this.originalAmount,
    required this.currency,
    required this.status,
    required this.purchaseDate,
    required this.expiryDate,
    this.recipientEmail,
    this.recipientName,
    this.message,
    this.providerTransactionId,
    this.redemptionCode,
    this.redemptionPin,
    this.redemptionInstructions,
    this.countryCode,
    this.providerProductId = 0,
    this.discountPercentage = 0.0,
    this.senderAmount = 0.0,
    this.senderCurrency = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  /// Whether this card was purchased in a different currency from its face value
  bool get isMultiCurrency =>
      senderCurrency.isNotEmpty &&
      currency.isNotEmpty &&
      senderCurrency != currency;

  bool get isActive => status == 'available';
  bool get isRedeemed => status == 'redeemed';
  bool get isExpired => status == 'expired';
  bool get isTransferred => status == 'transferred';

  @override
  List<Object?> get props => [
    id, userId, accountId, brandId, brandName, logoUrl,
    originalAmount, currency, status, purchaseDate, expiryDate,
    recipientEmail, recipientName, message, providerTransactionId,
    redemptionCode, redemptionPin, redemptionInstructions, countryCode,
    providerProductId, discountPercentage, senderAmount, senderCurrency,
    createdAt, updatedAt,
  ];

  GiftCard copyWith({
    String? id, String? userId, String? accountId, String? brandId,
    String? brandName, String? logoUrl,
    double? originalAmount, String? currency,
    String? status, String? purchaseDate, String? expiryDate,
    String? recipientEmail, String? recipientName, String? message,
    String? providerTransactionId, String? redemptionCode,
    String? redemptionPin, String? redemptionInstructions, String? countryCode,
    int? providerProductId, double? discountPercentage, double? senderAmount,
    String? senderCurrency, String? createdAt, String? updatedAt,
  }) {
    return GiftCard(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      logoUrl: logoUrl ?? this.logoUrl,
      originalAmount: originalAmount ?? this.originalAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      recipientName: recipientName ?? this.recipientName,
      message: message ?? this.message,
      providerTransactionId: providerTransactionId ?? this.providerTransactionId,
      redemptionCode: redemptionCode ?? this.redemptionCode,
      redemptionPin: redemptionPin ?? this.redemptionPin,
      redemptionInstructions: redemptionInstructions ?? this.redemptionInstructions,
      countryCode: countryCode ?? this.countryCode,
      providerProductId: providerProductId ?? this.providerProductId,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      senderAmount: senderAmount ?? this.senderAmount,
      senderCurrency: senderCurrency ?? this.senderCurrency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'userId': userId, 'accountId': accountId, 'brandId': brandId,
      'brandName': brandName, 'logoUrl': logoUrl,
      'originalAmount': originalAmount,
      'currency': currency, 'status': status,
      'purchaseDate': purchaseDate, 'expiryDate': expiryDate,
      'recipientEmail': recipientEmail, 'recipientName': recipientName,
      'message': message,
      'providerTransactionId': providerTransactionId,
      'redemptionCode': redemptionCode, 'redemptionPin': redemptionPin,
      'redemptionInstructions': redemptionInstructions,
      'countryCode': countryCode, 'providerProductId': providerProductId,
      'discountPercentage': discountPercentage,
      'senderAmount': senderAmount, 'senderCurrency': senderCurrency,
      'createdAt': createdAt, 'updatedAt': updatedAt,
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

class GiftCardBrand extends Equatable {
  final String id;
  final String name;
  final String logoUrl;
  final String category;
  final String description;
  /// Recipient (card face value) denominations
  final List<double> denominations;
  final double minAmount;
  final double maxAmount;
  final bool isActive;
  final String termsAndConditions;
  final int productId;
  final String countryCode;
  final List<GiftCardDenomination> fixedDenominations;
  final double discountPercentage;
  /// Recipient/card currency (e.g., "GBP", "USD") — the gift card's face currency
  final String currencyCode;
  final String redemptionInstructions;
  /// Provider that supplies this gift card brand (e.g., "reloadly", "prestmit")
  final String providerName;
  /// Sender (payment) currency code — what Reloadly charges (e.g., "NGN")
  final String senderCurrencyCode;
  /// Sender (payment) denominations — wholesale prices matching each recipient denomination
  final List<double> senderDenominations;
  /// Fixed sender denomination objects (paired with recipient denominations)
  final List<GiftCardDenomination> fixedSenderDenominations;
  final double minSenderAmount;
  final double maxSenderAmount;
  final double senderFee;
  final double senderFeePercentage;

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
    this.providerName = '',
    this.senderCurrencyCode = '',
    this.senderDenominations = const [],
    this.fixedSenderDenominations = const [],
    this.minSenderAmount = 0.0,
    this.maxSenderAmount = 0.0,
    this.senderFee = 0.0,
    this.senderFeePercentage = 0.0,
  });

  /// Whether this brand has different sender and recipient currencies.
  /// Also requires sender denomination data to actually display dual pricing.
  bool get isMultiCurrency =>
      senderCurrencyCode.isNotEmpty &&
      currencyCode.isNotEmpty &&
      senderCurrencyCode != currencyCode &&
      (senderDenominations.isNotEmpty || minSenderAmount > 0);

  /// Whether sender denomination data is available for price lookup.
  bool get hasSenderPricing =>
      senderDenominations.isNotEmpty || minSenderAmount > 0;

  /// Get the sender (payment) amount for a given recipient denomination.
  /// Returns null if no mapping found or data unavailable.
  double? getSenderAmountForDenomination(double recipientAmount) {
    if (recipientAmount <= 0) return null;

    // Fixed denominations: indexed match (with bounds check)
    if (denominations.isNotEmpty && senderDenominations.isNotEmpty) {
      final minLen = denominations.length < senderDenominations.length
          ? denominations.length
          : senderDenominations.length;
      for (int i = 0; i < minLen; i++) {
        if (denominations[i] == recipientAmount) {
          return senderDenominations[i];
        }
      }
    }
    // Range-based products: proportional calculation (division-by-zero safe)
    if (minAmount > 0 && minSenderAmount > 0) {
      final ratio = recipientAmount / minAmount;
      return minSenderAmount * ratio;
    }
    return null;
  }

  @override
  List<Object?> get props => [
    id, name, logoUrl, category, description, denominations,
    minAmount, maxAmount, isActive, termsAndConditions, productId,
    countryCode, fixedDenominations, discountPercentage, currencyCode,
    redemptionInstructions, providerName, senderCurrencyCode,
    senderDenominations, fixedSenderDenominations, minSenderAmount,
    maxSenderAmount, senderFee, senderFeePercentage,
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
      'providerName': providerName,
      'senderCurrencyCode': senderCurrencyCode,
      'senderDenominations': senderDenominations,
      'fixedSenderDenominations': fixedSenderDenominations.map((d) => d.toJson()).toList(),
      'minSenderAmount': minSenderAmount,
      'maxSenderAmount': maxSenderAmount,
      'senderFee': senderFee,
      'senderFeePercentage': senderFeePercentage,
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
  /// Provider that handles this card type (e.g., "prestmit")
  /// Used to ensure provider consistency between listing and sell.
  final String providerName;

  const SellableCard({
    required this.cardType,
    required this.displayName,
    this.logoUrl = '',
    this.category = '',
    this.denominations = const [],
    this.currencies = const [],
    this.minDenomination = 0.0,
    this.maxDenomination = 0.0,
    this.providerName = '',
  });

  @override
  List<Object?> get props => [
    cardType, displayName, logoUrl, category,
    denominations, currencies, minDenomination, maxDenomination,
    providerName,
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

/// Paginated result for gift card brands
class PaginatedBrands {
  final List<GiftCardBrand> brands;
  final int total;
  final int totalPages;
  final int currentPage;
  final bool hasNext;

  const PaginatedBrands({
    required this.brands,
    this.total = 0,
    this.totalPages = 1,
    this.currentPage = 0,
    this.hasNext = false,
  });
}

/// A country supported by Reloadly for gift cards
class GiftCardCountry extends Equatable {
  final String isoCode;
  final String name;
  final String flagUrl;
  final String currencyCode;
  final String currencyName;

  const GiftCardCountry({
    required this.isoCode,
    required this.name,
    this.flagUrl = '',
    this.currencyCode = '',
    this.currencyName = '',
  });

  /// Generate flag emoji from ISO country code
  String get flagEmoji {
    if (isoCode.length != 2) return '\u{1F30D}';
    final int firstLetter = isoCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = isoCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  @override
  List<Object?> get props => [isoCode, name, flagUrl, currencyCode, currencyName];

  Map<String, dynamic> toJson() => {
    'isoCode': isoCode,
    'name': name,
    'flagUrl': flagUrl,
    'currencyCode': currencyCode,
    'currencyName': currencyName,
  };

  factory GiftCardCountry.fromJson(Map<String, dynamic> json) {
    return GiftCardCountry(
      isoCode: json['isoCode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      flagUrl: json['flagUrl'] as String? ?? '',
      currencyCode: json['currencyCode'] as String? ?? '',
      currencyName: json['currencyName'] as String? ?? '',
    );
  }
}

/// Arguments passed from PurchaseGiftCardScreen to GiftCardPurchaseProcessingScreen
class GiftCardPurchaseArgs {
  final GiftCardBrand brand;
  final double amount;           // Recipient denomination (card face value)
  final String transactionId;
  final String verificationToken;
  final int? productId;
  final String? countryCode;
  final String? providerName;
  final double? senderAmount;    // Amount in sender/payment currency
  final String? senderCurrency;  // Sender currency code (e.g., "NGN")
  final double userBalance;      // User's available balance at time of purchase

  const GiftCardPurchaseArgs({
    required this.brand,
    required this.amount,
    required this.transactionId,
    required this.verificationToken,
    this.productId,
    this.countryCode,
    this.providerName,
    this.senderAmount,
    this.senderCurrency,
    this.userBalance = 0.0,
  });
}

/// Settlement entity for tracking gift card sale settlements
class Settlement extends Equatable {
  final String id;
  final String saleId;
  final String reference;
  final String userId;
  final String accountId;
  final String cardType;
  final double denomination;
  final String currency;
  final double ratePercentage;
  final double expectedPayout;
  final double actualPayout;
  final String status; // pending_settlement, settled, credit_failed
  final String settlementStatus; // pending, verified, failed
  final String providerName;
  final String providerSaleId;
  final String submittedAt;
  final String paidAt;
  final String settledAt;
  final String settlementVerifiedAt;
  final int settlementConfirmations;
  final String escalationReason;
  final String createdAt;
  final String updatedAt;

  const Settlement({
    required this.id,
    required this.saleId,
    required this.reference,
    required this.userId,
    required this.accountId,
    required this.cardType,
    required this.denomination,
    this.currency = 'NGN',
    this.ratePercentage = 0.0,
    this.expectedPayout = 0.0,
    this.actualPayout = 0.0,
    required this.status,
    this.settlementStatus = 'pending',
    this.providerName = '',
    this.providerSaleId = '',
    this.submittedAt = '',
    this.paidAt = '',
    this.settledAt = '',
    this.settlementVerifiedAt = '',
    this.settlementConfirmations = 0,
    this.escalationReason = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  bool get isPendingSettlement => status == 'pending_settlement';
  bool get isSettled => status == 'settled';
  bool get isCreditFailed => status == 'credit_failed';

  @override
  List<Object?> get props => [
    id, saleId, reference, userId, accountId, cardType, denomination, currency,
    ratePercentage, expectedPayout, actualPayout, status, settlementStatus,
    providerName, providerSaleId, submittedAt, paidAt, settledAt,
    settlementVerifiedAt, settlementConfirmations, escalationReason,
    createdAt, updatedAt,
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'saleId': saleId,
      'reference': reference,
      'userId': userId,
      'accountId': accountId,
      'cardType': cardType,
      'denomination': denomination,
      'currency': currency,
      'ratePercentage': ratePercentage,
      'expectedPayout': expectedPayout,
      'actualPayout': actualPayout,
      'status': status,
      'settlementStatus': settlementStatus,
      'providerName': providerName,
      'providerSaleId': providerSaleId,
      'submittedAt': submittedAt,
      'paidAt': paidAt,
      'settledAt': settledAt,
      'settlementVerifiedAt': settlementVerifiedAt,
      'settlementConfirmations': settlementConfirmations,
      'escalationReason': escalationReason,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Settlement.fromJson(Map<String, dynamic> json) {
    return Settlement(
      id: json['id'] as String? ?? '',
      saleId: json['saleId'] as String? ?? json['sale_id'] ?? '',
      reference: json['reference'] as String? ?? '',
      userId: json['userId'] as String? ?? json['user_id'] ?? '',
      accountId: json['accountId'] as String? ?? json['account_id'] ?? '',
      cardType: json['cardType'] as String? ?? json['card_type'] ?? '',
      denomination: (json['denomination'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'NGN',
      ratePercentage: (json['ratePercentage'] as num?)?.toDouble() ??
                      (json['rate_percentage'] as num?)?.toDouble() ?? 0.0,
      expectedPayout: (json['expectedPayout'] as num?)?.toDouble() ?? 0.0,
      actualPayout: (json['actualPayout'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending_settlement',
      settlementStatus: json['settlementStatus'] as String? ??
                        json['settlement_status'] as String? ?? 'pending',
      providerName: json['providerName'] as String? ?? json['provider_name'] ?? '',
      providerSaleId: json['providerSaleId'] as String? ??
                      json['provider_sale_id'] ?? '',
      submittedAt: json['submittedAt'] as String? ?? json['submitted_at'] ?? '',
      paidAt: json['paidAt'] as String? ?? json['paid_at'] ?? '',
      settledAt: json['settledAt'] as String? ?? json['settled_at'] ?? '',
      settlementVerifiedAt: json['settlementVerifiedAt'] as String? ??
                          json['settlement_verified_at'] ?? '',
      settlementConfirmations: json['settlementConfirmations'] as int? ??
                           json['settlement_confirmations'] as int? ?? 0,
      escalationReason: json['escalationReason'] as String? ??
                       json['escalation_reason'] ?? '',
      createdAt: json['createdAt'] as String? ?? json['created_at'] ?? '',
      updatedAt: json['updatedAt'] as String? ?? json['updated_at'] ?? '',
    );
  }

  Settlement copyWith({
    String? id,
    String? saleId,
    String? reference,
    String? userId,
    String? accountId,
    String? cardType,
    double? denomination,
    String? currency,
    double? ratePercentage,
    double? expectedPayout,
    double? actualPayout,
    String? status,
    String? settlementStatus,
    String? providerName,
    String? providerSaleId,
    String? submittedAt,
    String? paidAt,
    String? settledAt,
    String? settlementVerifiedAt,
    int? settlementConfirmations,
    String? escalationReason,
    String? createdAt,
    String? updatedAt,
  }) {
    return Settlement(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      reference: reference ?? this.reference,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      cardType: cardType ?? this.cardType,
      denomination: denomination ?? this.denomination,
      currency: currency ?? this.currency,
      ratePercentage: ratePercentage ?? this.ratePercentage,
      expectedPayout: expectedPayout ?? this.expectedPayout,
      actualPayout: actualPayout ?? this.actualPayout,
      status: status ?? this.status,
      settlementStatus: settlementStatus ?? this.settlementStatus,
      providerName: providerName ?? this.providerName,
      providerSaleId: providerSaleId ?? this.providerSaleId,
      submittedAt: submittedAt ?? this.submittedAt,
      paidAt: paidAt ?? this.paidAt,
      settledAt: settledAt ?? this.settledAt,
      settlementVerifiedAt: settlementVerifiedAt ?? this.settlementVerifiedAt,
      settlementConfirmations: settlementConfirmations ?? this.settlementConfirmations,
      escalationReason: escalationReason ?? this.escalationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
