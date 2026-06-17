import 'package:equatable/equatable.dart';

/// Card type enum
enum CardType {
  virtual,
  disposable,
  permanent;

  String toProtoString() {
    switch (this) {
      case CardType.virtual:
        return 'Virtual';
      case CardType.disposable:
        return 'Disposable';
      case CardType.permanent:
        return 'Permanent';
    }
  }

  static CardType fromProtoString(String value) {
    switch (value.toLowerCase()) {
      case 'virtual':
        return CardType.virtual;
      case 'disposable':
        return CardType.disposable;
      case 'permanent':
        return CardType.permanent;
      default:
        return CardType.virtual;
    }
  }
}

/// Card status enum
enum CardStatus {
  active,
  frozen,
  cancelled,
  expired;

  String toProtoString() {
    return name;
  }

  static CardStatus fromProtoString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return CardStatus.active;
      case 'frozen':
        return CardStatus.frozen;
      case 'cancelled':
        return CardStatus.cancelled;
      case 'expired':
        return CardStatus.expired;
      default:
        return CardStatus.active;
    }
  }
}

/// Represents a card (virtual, disposable, or permanent)
class Card extends Equatable {
  final String uuid;
  final int id;
  final int accountId;
  final int userId;
  final String cardHolderName;
  final String? cardNumber; // Full card number (only returned on creation)
  final String? cvv; // CVV (only returned on creation)
  final String last4; // Last 4 digits for display
  final String cardExpiry; // MM/YY
  final String brand; // e.g., Visa, Mastercard
  final CardType type;
  final CardStatus status;
  final bool isActive;
  final bool isDefault;
  final String? nickname;
  final double? spendingLimit; // For disposable cards
  final double? remainingLimit; // Remaining spending limit
  final DateTime? expiresAt; // For disposable cards
  final int? usageCount;
  final int? maxUsageCount; // Max usage (0 = unlimited)
  final String? currency;
  final String? billingAddress;
  final String? frozenReason;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Card({
    required this.uuid,
    required this.id,
    required this.accountId,
    required this.userId,
    required this.cardHolderName,
    this.cardNumber,
    this.cvv,
    required this.last4,
    required this.cardExpiry,
    required this.brand,
    required this.type,
    required this.status,
    required this.isActive,
    required this.isDefault,
    this.nickname,
    this.spendingLimit,
    this.remainingLimit,
    this.expiresAt,
    this.usageCount,
    this.maxUsageCount,
    this.currency,
    this.billingAddress,
    this.frozenReason,
    this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty card
  static final Card empty = Card(
    uuid: '',
    id: 0,
    accountId: 0,
    userId: 0,
    cardHolderName: '',
    last4: '',
    cardExpiry: '',
    brand: '',
    type: CardType.virtual,
    status: CardStatus.active,
    isActive: false,
    isDefault: false,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  /// Check if card is empty
  bool get isEmpty => this == Card.empty;

  /// Check if card is not empty
  bool get isNotEmpty => this != Card.empty;

  /// Check if card is disposable
  bool get isDisposable => type == CardType.disposable;

  /// Check if card is virtual
  bool get isVirtual => type == CardType.virtual;

  /// Check if card is permanent
  bool get isPermanent => type == CardType.permanent;

  /// Check if card is frozen
  bool get isFrozen => status == CardStatus.frozen;

  /// Check if card is cancelled
  bool get isCancelled => status == CardStatus.cancelled;

  /// Check if card is expired
  bool get isExpired => status == CardStatus.expired || (expiresAt != null && expiresAt!.isBefore(DateTime.now()));

  /// Get masked card number (shows only last 4 digits)
  String get maskedCardNumber => '•••• •••• •••• $last4';

  /// Get full card number if available
  String? get fullCardNumber => cardNumber;

  /// Check if spending limit is reached (for disposable cards)
  bool get isSpendingLimitReached {
    if (!isDisposable || spendingLimit == null || remainingLimit == null) {
      return false;
    }
    return remainingLimit! <= 0;
  }

  /// Check if usage limit is reached (for disposable cards)
  bool get isUsageLimitReached {
    if (!isDisposable || maxUsageCount == null || usageCount == null) {
      return false;
    }
    return maxUsageCount! > 0 && usageCount! >= maxUsageCount!;
  }

  /// Copy with method
  Card copyWith({
    String? uuid,
    int? id,
    int? accountId,
    int? userId,
    String? cardHolderName,
    String? cardNumber,
    String? cvv,
    String? last4,
    String? cardExpiry,
    String? brand,
    CardType? type,
    CardStatus? status,
    bool? isActive,
    bool? isDefault,
    String? nickname,
    double? spendingLimit,
    double? remainingLimit,
    DateTime? expiresAt,
    int? usageCount,
    int? maxUsageCount,
    String? currency,
    String? billingAddress,
    String? frozenReason,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Card(
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      userId: userId ?? this.userId,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      cvv: cvv ?? this.cvv,
      last4: last4 ?? this.last4,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      brand: brand ?? this.brand,
      type: type ?? this.type,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      isDefault: isDefault ?? this.isDefault,
      nickname: nickname ?? this.nickname,
      spendingLimit: spendingLimit ?? this.spendingLimit,
      remainingLimit: remainingLimit ?? this.remainingLimit,
      expiresAt: expiresAt ?? this.expiresAt,
      usageCount: usageCount ?? this.usageCount,
      maxUsageCount: maxUsageCount ?? this.maxUsageCount,
      currency: currency ?? this.currency,
      billingAddress: billingAddress ?? this.billingAddress,
      frozenReason: frozenReason ?? this.frozenReason,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        id,
        accountId,
        userId,
        cardHolderName,
        cardNumber,
        cvv,
        last4,
        cardExpiry,
        brand,
        type,
        status,
        isActive,
        isDefault,
        nickname,
        spendingLimit,
        remainingLimit,
        expiresAt,
        usageCount,
        maxUsageCount,
        currency,
        billingAddress,
        frozenReason,
        lastUsedAt,
        createdAt,
        updatedAt,
      ];
}
