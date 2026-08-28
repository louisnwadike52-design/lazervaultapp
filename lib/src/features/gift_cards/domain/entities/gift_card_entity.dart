import 'package:equatable/equatable.dart';
part 'gift_card_entity_widgets.dart';

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

  /// Reloadly's authoritative denomination model.
  ///   "FIXED" — only listed `fixedDenominations` are valid amounts
  ///   "RANGE" — any value in [minAmount, maxAmount] is valid
  ///   ""      — upstream didn't supply; fall back to the
  ///             fixedDenominations.empty heuristic.
  final String denominationType;

  /// True when the provider does NOT fulfil this card instantly: the order is
  /// accepted and the code arrives later.
  ///
  /// Prestmit flags most of its catalogue this way; Reloadly always sends
  /// false. Surfaced before payment because "buy a gift card" otherwise
  /// implies a code on the very next screen.
  final bool preOrder;

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
    this.denominationType = '',
    this.preOrder = false,
  });

  /// True when Reloadly says this brand accepts custom amounts in the
  /// allowed range. Prefers the explicit denominationType field; falls
  /// back to the legacy heuristic for brands seeded before the field
  /// was wired through (model, service, proto, regen).
  bool get acceptsCustomAmount {
    final t = denominationType.toUpperCase().trim();
    if (t == 'RANGE') return true;
    if (t == 'FIXED') return false;
    // Legacy fallback.
    return fixedDenominations.isEmpty && minAmount > 0 && maxAmount > 0;
  }

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
        providerName,
        senderCurrencyCode,
        senderDenominations,
        fixedSenderDenominations,
        minSenderAmount,
        maxSenderAmount,
        senderFee,
        senderFeePercentage,
        denominationType,
        preOrder,
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
      'fixedSenderDenominations':
          fixedSenderDenominations.map((d) => d.toJson()).toList(),
      'minSenderAmount': minSenderAmount,
      'maxSenderAmount': maxSenderAmount,
      'senderFee': senderFee,
      'senderFeePercentage': senderFeePercentage,
      'denominationType': denominationType,
      'preOrder': preOrder,
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
              .toList() ??
          [],
      minAmount: (json['minAmount'] as num?)?.toDouble() ?? 0.0,
      maxAmount: (json['maxAmount'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool? ?? true,
      termsAndConditions: json['termsAndConditions'] as String? ?? '',
      productId: json['productId'] as int? ?? 0,
      countryCode: json['countryCode'] as String? ?? '',
      fixedDenominations: (json['fixedDenominations'] as List<dynamic>?)
              ?.map((e) =>
                  GiftCardDenomination.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      currencyCode: json['currencyCode'] as String? ?? '',
      redemptionInstructions: json['redemptionInstructions'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      senderCurrencyCode: json['senderCurrencyCode'] as String? ?? '',
      senderDenominations: (json['senderDenominations'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      fixedSenderDenominations:
          (json['fixedSenderDenominations'] as List<dynamic>?)
                  ?.map((e) =>
                      GiftCardDenomination.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
      minSenderAmount: (json['minSenderAmount'] as num?)?.toDouble() ?? 0.0,
      maxSenderAmount: (json['maxSenderAmount'] as num?)?.toDouble() ?? 0.0,
      senderFee: (json['senderFee'] as num?)?.toDouble() ?? 0.0,
      senderFeePercentage:
          (json['senderFeePercentage'] as num?)?.toDouble() ?? 0.0,
      denominationType: json['denominationType'] as String? ?? '',
      preOrder: json['preOrder'] as bool? ?? false,
    );
  }
}
