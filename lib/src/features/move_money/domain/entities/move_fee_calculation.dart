import 'package:equatable/equatable.dart';

/// Fee item in the breakdown
class MoveFeeItem extends Equatable {
  final String label;
  final int amount; // In kobo

  const MoveFeeItem({required this.label, required this.amount});

  double get amountNaira => amount / 100.0;

  @override
  List<Object?> get props => [label, amount];
}

/// Move money fee calculation result
class MoveFeeCalculation extends Equatable {
  final int amount; // Original amount (kobo)
  final int debitFee; // Mono debit fee
  final int transferFee; // Flutterwave transfer fee
  final int stampDuty; // Stamp duty
  final int serviceFee; // LazerVault service fee
  final int totalFee; // Sum of all fees
  final int totalDebit; // Amount + totalFee
  final String currency;
  final List<MoveFeeItem> breakdown;
  final int minAmount;
  final int maxAmount;

  const MoveFeeCalculation({
    required this.amount,
    required this.debitFee,
    required this.transferFee,
    required this.stampDuty,
    required this.serviceFee,
    required this.totalFee,
    required this.totalDebit,
    required this.currency,
    required this.breakdown,
    required this.minAmount,
    required this.maxAmount,
  });

  double get amountNaira => amount / 100.0;
  double get totalFeeNaira => totalFee / 100.0;
  double get totalDebitNaira => totalDebit / 100.0;
  double get minAmountNaira => minAmount / 100.0;
  double get maxAmountNaira => maxAmount / 100.0;

  /// Fee percentage of the transfer amount
  double get feePercentage => amount > 0 ? (totalFee / amount) * 100 : 0;

  /// Whether fees are high (>20% of amount)
  bool get isHighFee => feePercentage > 20;

  @override
  List<Object?> get props => [amount, totalFee, totalDebit, currency];
}
