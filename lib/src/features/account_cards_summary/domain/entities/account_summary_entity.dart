import 'package:equatable/equatable.dart';

/// Supported account types for virtual accounts
enum VirtualAccountType {
  personal('Personal'),
  savings('Savings'),
  investment('Investment'),
  family('Family & Friends'),
  main('Main'),
  business('Business'),
  usd('USD Wallet'),
  gbp('GBP Wallet'),
  eur('EUR Wallet');

  final String displayName;
  const VirtualAccountType(this.displayName);

  /// Create from string account type
  static VirtualAccountType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'personal':
        return VirtualAccountType.personal;
      case 'savings':
        return VirtualAccountType.savings;
      case 'investment':
        return VirtualAccountType.investment;
      case 'family':
      case 'family & friends':
        return VirtualAccountType.family;
      case 'main':
        return VirtualAccountType.main;
      case 'business':
        return VirtualAccountType.business;
      case 'usd':
      case 'usd wallet':
        return VirtualAccountType.usd;
      case 'gbp':
      case 'gbp wallet':
        return VirtualAccountType.gbp;
      case 'eur':
      case 'eur wallet':
        return VirtualAccountType.eur;
      default:
        return VirtualAccountType.personal;
    }
  }
}

class AccountSummaryEntity extends Equatable {
  final String id; // Unique identifier for the account
  final String accountType;
  final String currency;
  final double balance;
  final String accountNumberLast4; // e.g., "7890"
  final String? accountNumber; // Full NUBAN account number for deposits
  final String? bankName; // Bank name (e.g., "Wema Bank", "VFD MFB")
  final String? accountName; // Account holder name for deposits
  final double trendPercentage; // e.g., 2.4 or -0.8
  final bool isUp; // Derived from trendPercentage > 0
  final bool isPrimary; // Whether this is the user's primary account
  final String? accountLabel; // Custom label for the account

  // Family account specific fields
  final bool isFamilyAccount;
  final double? familyTotalBalance; // Total family pool balance
  final double? memberAllocatedBalance; // Member's allocated balance
  final double? memberRemainingBalance; // Member's remaining balance
  final int? memberCount; // Total member count
  final bool? allowMemberContributions; // Can members contribute

  const AccountSummaryEntity({
    required this.id,
    required this.accountType,
    required this.currency,
    required this.balance,
    required this.accountNumberLast4,
    this.accountNumber,
    this.bankName,
    this.accountName,
    required this.trendPercentage,
    this.isPrimary = false,
    this.accountLabel,
    this.isFamilyAccount = false,
    this.familyTotalBalance,
    this.memberAllocatedBalance,
    this.memberRemainingBalance,
    this.memberCount,
    this.allowMemberContributions,
  }) : isUp = trendPercentage > 0; // Calculate isUp here

  /// Get the display name for the account type
  String get displayName => accountLabel ?? accountType;

  /// Get the account type enum
  VirtualAccountType get accountTypeEnum => VirtualAccountType.fromString(accountType);

  /// Check if this is a personal account
  bool get isPersonalAccount => accountTypeEnum == VirtualAccountType.personal;

  /// Check if this is a savings account
  bool get isSavingsAccount => accountTypeEnum == VirtualAccountType.savings;

  /// Check if this is an investment account
  bool get isInvestmentAccount => accountTypeEnum == VirtualAccountType.investment;

  @override
  List<Object?> get props => [
        id,
        accountType,
        currency,
        balance,
        accountNumberLast4,
        accountNumber,
        bankName,
        accountName,
        trendPercentage,
        isUp,
        isPrimary,
        accountLabel,
        isFamilyAccount,
        familyTotalBalance,
        memberAllocatedBalance,
        memberRemainingBalance,
        memberCount,
        allowMemberContributions,
      ];

  // Factory constructor for family accounts
  factory AccountSummaryEntity.familyAccount({
    required String id,
    required String currency,
    required double totalBalance,
    required double memberAllocatedBalance,
    required double memberRemainingBalance,
    required int memberCount,
    required bool allowMemberContributions,
    required double trendPercentage,
    String? accountNumberLast4,
  }) {
    return AccountSummaryEntity(
      id: id,
      accountType: 'Family & Friends',
      currency: currency,
      balance: memberAllocatedBalance, // Show member's allocation as main balance
      accountNumberLast4: accountNumberLast4 ?? '••••',
      trendPercentage: trendPercentage,
      isFamilyAccount: true,
      familyTotalBalance: totalBalance,
      memberAllocatedBalance: memberAllocatedBalance,
      memberRemainingBalance: memberRemainingBalance,
      memberCount: memberCount,
      allowMemberContributions: allowMemberContributions,
    );
  }

  AccountSummaryEntity copyWith({
    String? id,
    String? accountType,
    String? currency,
    double? balance,
    String? accountNumberLast4,
    String? accountNumber,
    String? bankName,
    String? accountName,
    double? trendPercentage,
    bool? isPrimary,
    String? accountLabel,
    bool? isFamilyAccount,
    double? familyTotalBalance,
    double? memberAllocatedBalance,
    double? memberRemainingBalance,
    int? memberCount,
    bool? allowMemberContributions,
  }) {
    return AccountSummaryEntity(
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      accountNumberLast4: accountNumberLast4 ?? this.accountNumberLast4,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      trendPercentage: trendPercentage ?? this.trendPercentage,
      isPrimary: isPrimary ?? this.isPrimary,
      accountLabel: accountLabel ?? this.accountLabel,
      isFamilyAccount: isFamilyAccount ?? this.isFamilyAccount,
      familyTotalBalance: familyTotalBalance ?? this.familyTotalBalance,
      memberAllocatedBalance: memberAllocatedBalance ?? this.memberAllocatedBalance,
      memberRemainingBalance: memberRemainingBalance ?? this.memberRemainingBalance,
      memberCount: memberCount ?? this.memberCount,
      allowMemberContributions: allowMemberContributions ?? this.allowMemberContributions,
    );
  }

  /// Factory constructor for signup accounts (Personal, Savings, Investment)
  factory AccountSummaryEntity.signupAccount({
    required String id,
    required VirtualAccountType type,
    required String currency,
    required double balance,
    required String accountNumberLast4,
    required String bankName,
    bool isPrimary = false,
    String? accountLabel,
    double trendPercentage = 0.0,
  }) {
    return AccountSummaryEntity(
      id: id,
      accountType: type.displayName,
      currency: currency,
      balance: balance,
      accountNumberLast4: accountNumberLast4,
      trendPercentage: trendPercentage,
      isPrimary: isPrimary,
      accountLabel: accountLabel,
    );
  }
} 