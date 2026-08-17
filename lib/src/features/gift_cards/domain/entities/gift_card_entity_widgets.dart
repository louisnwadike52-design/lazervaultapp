part of 'gift_card_entity.dart';

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
  /// Stable internal reference (e.g. "GC-{uuid}") populated by the
  /// backend at create-pending-card time. Drives the balance-WS
  /// terminal-event match on the processing screen — the WS event's
  /// `reference` field carries this exact value, so it must be the
  /// identifier the cubit subscribes against.
  final String reference;

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
    this.reference = '',
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
    createdAt, updatedAt, reference,
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

  /// Prestmit's `form` value: "Physical" or "Ecode". Drives the
  /// sell-flow UI: Physical → image upload step (attachments[]),
  /// Ecode → text-input step (code goes to `comments`). Empty on
  /// internal/manual-provider cards (no API distinction).
  final String form;

  /// Prestmit's numeric subcategory id used as `giftcard_id` at
  /// sale time. For non-Prestmit catalogues this mirrors `cardType`.
  final String subcategoryId;

  /// ISO/Prestmit country tag (e.g. "USA", "UK") for region-specific
  /// variants. Surfaced on the card chooser so the user picks the
  /// right regional rate.
  final String country;

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
    this.form = '',
    this.subcategoryId = '',
    this.country = '',
  });

  /// True when the card is an Ecode and the sell flow should ask for a
  /// code string instead of attachment images.
  bool get isEcode => form.toLowerCase() == 'ecode';

  /// True when the card is Physical and the sell flow should ask for
  /// at least one attachment image.
  bool get isPhysical => form.toLowerCase() == 'physical';

  @override
  List<Object?> get props => [
    cardType, displayName, logoUrl, category,
    denominations, currencies, minDenomination, maxDenomination,
    providerName, form, subcategoryId, country,
  ];
}

/// A payout method available for the user to pick on the sell flow.
/// Source: Prestmit's GET /giftcard-trade/sell/payout-methods. Filtered
/// to available-only by the backend so the UI never offers an option
/// Prestmit will reject.
class PayoutMethodEntity extends Equatable {
  /// Payout-method name as Prestmit expects it back at sale time
  /// (e.g. "NAIRA", "CEDIS"). This is what we send as `payoutMethod`
  /// in /giftcard-trade/sell/create.
  final String name;

  /// Optional currency tag the method pays out in.
  final String currency;

  /// Whether the method is currently usable. The backend pre-filters
  /// to available==true, but the entity carries it for completeness.
  final bool available;

  const PayoutMethodEntity({
    required this.name,
    this.currency = '',
    this.available = true,
  });

  @override
  List<Object?> get props => [name, currency, available];
}

/// Rate for selling a gift card
class SellRate extends Equatable {
  final String cardType;
  final double denomination;
  final double ratePercentage;
  final double payoutAmount;
  final String currency;
  final String expiresAt;
  // Manual-mode payout range. Both 0 in automated mode (use
  // payoutAmount as a point estimate). hasRange returns true only
  // when both bounds are populated AND distinct from zero — guards
  // against a legacy server that hasn't been redeployed yet (the
  // backend defaults the proto fields to 0 when no range applies).
  final double payoutLowerBound;
  final double payoutUpperBound;
  final bool isManualMode;

  const SellRate({
    required this.cardType,
    required this.denomination,
    required this.ratePercentage,
    required this.payoutAmount,
    this.currency = 'NGN',
    this.expiresAt = '',
    this.payoutLowerBound = 0,
    this.payoutUpperBound = 0,
    this.isManualMode = false,
  });

  /// True only when we have a real, meaningful range to render.
  /// Falls back to false (Flutter shows point estimate) if either:
  ///   - the row isn't manual mode
  ///   - the server returned 0/0 (pre-redeploy, before range was added)
  ///   - upper <= lower (degenerate band — should never happen)
  bool get hasRange =>
      isManualMode &&
      payoutLowerBound > 0 &&
      payoutUpperBound > 0 &&
      payoutUpperBound > payoutLowerBound;

  @override
  List<Object?> get props => [
    cardType, denomination, ratePercentage, payoutAmount, currency, expiresAt,
    payoutLowerBound, payoutUpperBound, isManualMode,
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
  // Rejection reason — populated when status=rejected (admin reject
  // OR Prestmit-webhook reject). User-facing copy that the receipt /
  // sell detail screen renders. Distinct from the operator's internal
  // admin_notes which the giftcards-service strips on user RPCs.
  final String rejectionReason;
  // Backend's denormalised lifecycle label. Computed from (status,
  // settlement_status, settlement_confirmations) so the UI never
  // shows "paid" until settlement is fully confirmed. Optional —
  // empty for legacy rows / pre-redeploy server builds; falls back
  // to status. Drives userDisplayStatus below.
  final String displayStatus;
  final String settlementStatus;

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
    this.rejectionReason = '',
    this.displayStatus = '',
    this.settlementStatus = '',
  });

  // userDisplayStatus is the simplified label shown to end users on
  // Flutter. Internal lifecycle states like "settling",
  // "pending_settlement", "approved" all collapse to "pending"
  // because the user only cares whether they have the money yet.
  // Terminal states (paid, rejected, refunded, settled) pass through.
  // Drives the My Sales status badge so users never see operator
  // jargon and never see "Paid" before they actually have funds.
  String get userDisplayStatus {
    final s = displayStatus.isNotEmpty ? displayStatus : status;
    switch (s) {
      case 'paid':
      case 'settled':
        return 'paid';
      case 'rejected':
      case 'failed':
        return 'rejected';
      case 'refunded':
        return 'refunded';
      case 'refund_pending':
      case 'refund_failed':
        return 'pending';
      // Every internal in-flight state collapses to user-facing "pending".
      case 'settling':
      case 'pending_settlement':
      case 'approved':
      case 'reviewing':
      case 'pending_review':
      case 'manual_review':
      case 'pending':
        return 'pending';
      default:
        return s;
    }
  }

  bool get isPending => status == 'pending';
  bool get isReviewing => status == 'reviewing';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
  bool get isPaid => status == 'paid';
  // Pending settlement = provider confirmed the trade but the wallet
  // credit hasn't landed yet (either the credit was never attempted or
  // the credit attempt failed and is queued for retry by the
  // settlement-retry worker). Distinct from isPaid: the user does NOT
  // yet have the money. UI must render "Pending wallet credit" rather
  // than "Paid".
  bool get isPendingSettlement => status == 'pending_settlement';
  // Canonical sell terminal-failure name is `failed` (post migration 013).
  // The legacy `cancelled` value is treated as a synonym so older rows
  // emitted before the rename still surface correctly.
  bool get isFailed => status == 'failed' || status == 'cancelled';
  // Deprecated: use isFailed.
  bool get isCancelled => isFailed;
  // Manual_review replaced the legacy `escalated` post migration 013.
  bool get isManualReview => status == 'manual_review' || status == 'escalated';

  @override
  List<Object?> get props => [
    id, userId, accountId, cardType, cardNumber, denomination, currency,
    ratePercentage, expectedPayout, actualPayout, status, providerSaleId,
    providerName, reference, submittedAt, reviewedAt, paidAt, createdAt, updatedAt,
    rejectionReason, displayStatus, settlementStatus,
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
      'rejectionReason': rejectionReason,
      'displayStatus': displayStatus,
      'settlementStatus': settlementStatus,
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
      rejectionReason: json['rejectionReason'] as String? ?? json['rejection_reason'] as String? ?? '',
      displayStatus: json['displayStatus'] as String? ?? json['display_status'] as String? ?? '',
      settlementStatus: json['settlementStatus'] as String? ?? json['settlement_status'] as String? ?? '',
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
