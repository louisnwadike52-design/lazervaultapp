import 'package:equatable/equatable.dart';

class AccountSummaryEntity extends Equatable {
  final String id; // Unique identifier for the account
  final String accountType;
  final String currency;
  final double balance;
  final String accountNumberLast4; // e.g., "7890"
  final double trendPercentage; // e.g., 2.4 or -0.8
  final bool isUp; // Derived from trendPercentage > 0

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
    required this.trendPercentage,
    this.isFamilyAccount = false,
    this.familyTotalBalance,
    this.memberAllocatedBalance,
    this.memberRemainingBalance,
    this.memberCount,
    this.allowMemberContributions,
  }) : isUp = trendPercentage > 0; // Calculate isUp here

  @override
  List<Object?> get props => [
        id,
        accountType,
        currency,
        balance,
        accountNumberLast4,
        trendPercentage,
        isUp,
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
    double? trendPercentage,
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
      trendPercentage: trendPercentage ?? this.trendPercentage,
      isFamilyAccount: isFamilyAccount ?? this.isFamilyAccount,
      familyTotalBalance: familyTotalBalance ?? this.familyTotalBalance,
      memberAllocatedBalance: memberAllocatedBalance ?? this.memberAllocatedBalance,
      memberRemainingBalance: memberRemainingBalance ?? this.memberRemainingBalance,
      memberCount: memberCount ?? this.memberCount,
      allowMemberContributions: allowMemberContributions ?? this.allowMemberContributions,
    );
  }
} 