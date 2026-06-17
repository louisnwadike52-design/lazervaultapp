import 'package:equatable/equatable.dart';

class NetworkRate extends Equatable {
  final String network;
  final double conversionRate;
  final double minAmount;
  final double maxAmount;
  final double automationFee;
  final bool isAvailable;

  const NetworkRate({
    required this.network,
    required this.conversionRate,
    required this.minAmount,
    required this.maxAmount,
    required this.automationFee,
    required this.isAvailable,
  });

  /// Estimated cash for a given airtime amount after rate and fee deduction
  double estimateCash(double airtimeAmount) =>
      (airtimeAmount * conversionRate) - automationFee;

  /// Conversion rate as percentage string (e.g., "80%")
  String get ratePercentage => '${(conversionRate * 100).toStringAsFixed(0)}%';

  /// Formatted min amount with Naira symbol
  String get formattedMinAmount => '\u20A6${minAmount.toStringAsFixed(2)}';

  /// Formatted max amount with Naira symbol
  String get formattedMaxAmount => '\u20A6${maxAmount.toStringAsFixed(2)}';

  /// Formatted automation fee with Naira symbol
  String get formattedFee => '\u20A6${automationFee.toStringAsFixed(2)}';

  /// Whether a given amount is within the allowed range
  bool isAmountValid(double amount) =>
      amount >= minAmount && amount <= maxAmount;

  NetworkRate copyWith({
    String? network,
    double? conversionRate,
    double? minAmount,
    double? maxAmount,
    double? automationFee,
    bool? isAvailable,
  }) {
    return NetworkRate(
      network: network ?? this.network,
      conversionRate: conversionRate ?? this.conversionRate,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      automationFee: automationFee ?? this.automationFee,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  List<Object?> get props => [
        network,
        conversionRate,
        minAmount,
        maxAmount,
        automationFee,
        isAvailable,
      ];
}
