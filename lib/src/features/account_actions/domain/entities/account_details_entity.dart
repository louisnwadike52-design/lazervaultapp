import 'package:equatable/equatable.dart';

/// Represents detailed account information for card settings
class AccountDetailsEntity extends Equatable {
  final String id;
  final String accountType;
  final String currency;
  final double balance;
  final String status;
  final String? cardHolderName;
  final String? cardType;
  final String? expiryDate;
  final String? cardNumber;  // Full card number (masked for security)
  final String? cvv;  // Only available with auth
  final String? accountNumber;
  final String? iban;
  final String? bicSwift;
  final double dailyLimit;
  final double monthlyLimit;
  final double? singleTransactionLimit;
  final bool enable3DSecure;
  final bool enableContactless;
  final bool enableOnlinePayments;
  final bool enableATMWithdrawals;
  final bool enableInternationalPayments;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AccountDetailsEntity({
    required this.id,
    required this.accountType,
    required this.currency,
    required this.balance,
    required this.status,
    this.cardHolderName,
    this.cardType,
    this.expiryDate,
    this.cardNumber,
    this.cvv,
    this.accountNumber,
    this.iban,
    this.bicSwift,
    required this.dailyLimit,
    required this.monthlyLimit,
    this.singleTransactionLimit,
    required this.enable3DSecure,
    required this.enableContactless,
    required this.enableOnlinePayments,
    required this.enableATMWithdrawals,
    required this.enableInternationalPayments,
    this.createdAt,
    this.updatedAt,
  });

  /// Returns true if the card is frozen/blocked
  bool get isFrozen => status.toLowerCase() == 'frozen' ||
                      status.toLowerCase() == 'blocked_temporary' ||
                      status.toLowerCase() == 'blocked_permanent' ||
                      status.toLowerCase() == 'blocked_stolen';

  /// Returns true if the card is active
  bool get isActive => status.toLowerCase() == 'active';

  /// Returns the display status
  String get displayStatus {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Active';
      case 'frozen':
        return 'Frozen';
      case 'blocked_temporary':
        return 'Temporarily Blocked';
      case 'blocked_permanent':
        return 'Permanently Blocked';
      case 'blocked_stolen':
        return 'Reported Stolen';
      default:
        return status;
    }
  }

  /// Returns masked card number (e.g., •••• 1234)
  String get maskedCardNumber {
    if (cardNumber == null || cardNumber!.length < 4) {
      return '•••• •••• •••• ••••';
    }
    return '•••• •••• •••• ${cardNumber!.substring(cardNumber!.length - 4)}';
  }

  /// Returns currency symbol
  String get currencySymbol {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return currency;
    }
  }

  @override
  List<Object?> get props => [
        id,
        accountType,
        currency,
        balance,
        status,
        cardHolderName,
        cardType,
        expiryDate,
        cardNumber,
        cvv,
        accountNumber,
        iban,
        bicSwift,
        dailyLimit,
        monthlyLimit,
        singleTransactionLimit,
        enable3DSecure,
        enableContactless,
        enableOnlinePayments,
        enableATMWithdrawals,
        enableInternationalPayments,
        createdAt,
        updatedAt,
      ];

  /// CopyWith method
  AccountDetailsEntity copyWith({
    String? id,
    String? accountType,
    String? currency,
    double? balance,
    String? status,
    String? cardHolderName,
    String? cardType,
    String? expiryDate,
    String? cardNumber,
    String? cvv,
    String? accountNumber,
    String? iban,
    String? bicSwift,
    double? dailyLimit,
    double? monthlyLimit,
    double? singleTransactionLimit,
    bool? enable3DSecure,
    bool? enableContactless,
    bool? enableOnlinePayments,
    bool? enableATMWithdrawals,
    bool? enableInternationalPayments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccountDetailsEntity(
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardType: cardType ?? this.cardType,
      expiryDate: expiryDate ?? this.expiryDate,
      cardNumber: cardNumber ?? this.cardNumber,
      cvv: cvv ?? this.cvv,
      accountNumber: accountNumber ?? this.accountNumber,
      iban: iban ?? this.iban,
      bicSwift: bicSwift ?? this.bicSwift,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      singleTransactionLimit: singleTransactionLimit ?? this.singleTransactionLimit,
      enable3DSecure: enable3DSecure ?? this.enable3DSecure,
      enableContactless: enableContactless ?? this.enableContactless,
      enableOnlinePayments: enableOnlinePayments ?? this.enableOnlinePayments,
      enableATMWithdrawals: enableATMWithdrawals ?? this.enableATMWithdrawals,
      enableInternationalPayments: enableInternationalPayments ?? this.enableInternationalPayments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
