import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final String accountNumber;
  final double balance;
  final String currency;
  // Add other relevant fields based on your data model (e.g., accountType, status)

  const Account({
    required this.id,
    required this.accountNumber,
    required this.balance,
    required this.currency,
  });

  @override
  List<Object?> get props => [id, accountNumber, balance, currency];
} 