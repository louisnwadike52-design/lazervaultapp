import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';

abstract class IExchangeRepository {
  /// Get real-time exchange rate between two currencies
  Future<Either<Failure, ExchangeRate>> getExchangeRate({
    required String fromCurrency,
    required String toCurrency,
    double? amount,
  });

  /// Initiate an international transfer
  Future<Either<Failure, CurrencyTransaction>> initiateInternationalTransfer({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String recipientId,
    required String verificationToken,
    required String idempotencyKey,
    String? rateId,
    String? purposeOfPayment,
    String? recipientName,
    String? recipientAccountNumber,
    String? recipientBankName,
    String? recipientBankCode,
    String? recipientSwiftCode,
    String? recipientCountry,
    String? recipientEmail,
    String? notes,
  });

  /// Convert currency between user's own wallets
  Future<Either<Failure, CurrencyTransaction>> convertCurrency({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String verificationToken,
    required String idempotencyKey,
    String? rateId,
  });

  /// Get the status of an exchange transaction
  Future<Either<Failure, CurrencyTransaction>> getTransactionStatus({
    required String transactionId,
  });

  /// Get recent exchange transactions
  Future<Either<Failure, List<CurrencyTransaction>>> getRecentExchanges({
    int? limit,
    int? offset,
  });

  /// Get supported currencies for exchange
  Future<Either<Failure, List<SupportedCurrencyInfo>>> getSupportedCurrencies();
}

class ExchangeRate {
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime timestamp;
  final double fees;
  final double feePercentage;
  final int rateValidSeconds;
  final String rateId;

  ExchangeRate({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.timestamp,
    this.fees = 0.0,
    this.feePercentage = 0.0,
    this.rateValidSeconds = 60,
    this.rateId = '',
  });

  double calculateToAmount(double fromAmount) {
    return fromAmount * rate;
  }

  double calculateTotalCost(double fromAmount) {
    return fromAmount + fees;
  }

  /// Format rate for display: "1 FROM = X.XX TO"
  /// Always shows the rate in the direction the user selected.
  /// For very small rates (e.g., 0.00065 for NGN→USD), uses more decimal places
  /// so users can see the actual conversion rate for their source currency.
  String formatForDisplay() {
    if (rate >= 0.01) {
      return '1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency';
    }
    // For very small rates, show more decimal places for precision
    return '1 $fromCurrency = ${rate.toStringAsFixed(6)} $toCurrency';
  }

  /// Whether this rate has expired based on its validity window.
  bool get isExpired {
    return DateTime.now().difference(timestamp).inSeconds > rateValidSeconds;
  }
}

class SupportedCurrencyInfo {
  final String code;
  final String name;
  final String symbol;
  final String country;
  final bool supportsConversion;
  final bool supportsInternational;
  final double minAmount;
  final double maxAmount;

  SupportedCurrencyInfo({
    required this.code,
    required this.name,
    required this.symbol,
    required this.country,
    required this.supportsConversion,
    required this.supportsInternational,
    required this.minAmount,
    required this.maxAmount,
  });
}
