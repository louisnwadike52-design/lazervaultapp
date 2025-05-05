import 'package:equatable/equatable.dart';

class AccountSummaryEntity extends Equatable {
  final String id; // Unique identifier for the account
  final String accountType;
  final String currency;
  final double balance;
  final String accountNumberLast4; // e.g., "7890"
  final double trendPercentage; // e.g., 2.4 or -0.8
  final bool isUp; // Derived from trendPercentage > 0
  // Add other core fields if necessary

  const AccountSummaryEntity({
    required this.id,
    required this.accountType,
    required this.currency,
    required this.balance,
    required this.accountNumberLast4,
    required this.trendPercentage,
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
      ];
} 