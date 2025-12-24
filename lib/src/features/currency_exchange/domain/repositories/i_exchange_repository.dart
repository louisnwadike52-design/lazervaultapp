import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';

abstract class IExchangeRepository {
  /// Get real-time exchange rate between two currencies
  Future<Either<Failure, ExchangeRate>> getExchangeRate({
    required String fromCurrency,
    required String toCurrency,
  });

  /// Initiate an international transfer
  Future<Either<Failure, CurrencyTransaction>> initiateInternationalTransfer({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String recipientId,
    String? notes,
  });

  /// Get recent exchange transactions
  Future<Either<Failure, List<CurrencyTransaction>>> getRecentExchanges({
    int? limit,
    int? offset,
  });
}

class ExchangeRate {
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime timestamp;
  final double fees;

  ExchangeRate({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.timestamp,
    this.fees = 0.0,
  });

  double calculateToAmount(double fromAmount) {
    return fromAmount * rate;
  }

  double calculateTotalCost(double fromAmount) {
    return fromAmount + fees;
  }
}
