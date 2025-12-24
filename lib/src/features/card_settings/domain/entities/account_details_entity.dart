import 'package:equatable/equatable.dart';

class AccountDetailsEntity extends Equatable {
  final String id;
  final String accountType;
  final String currency;
  final double balance;
  final String status;
  final String? cardHolderName;
  final String? cardType;
  final String? expiryDate;
  final double dailyLimit;
  final double monthlyLimit;
  final bool enable3dSecure;
  final bool enableContactless;
  final bool enableOnlinePayments;
  final String accountNumber;
  final String? iban;
  final String? bicSwift;
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
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.enable3dSecure,
    required this.enableContactless,
    required this.enableOnlinePayments,
    required this.accountNumber,
    this.iban,
    this.bicSwift,
    this.createdAt,
    this.updatedAt,
  });

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
        dailyLimit,
        monthlyLimit,
        enable3dSecure,
        enableContactless,
        enableOnlinePayments,
        accountNumber,
        iban,
        bicSwift,
        createdAt,
        updatedAt,
      ];

  bool get isFrozen => status.toLowerCase() == 'frozen';
  bool get isActive => status.toLowerCase() == 'active';
}
