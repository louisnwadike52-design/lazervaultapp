part of 'crypto_transaction_history_screen.dart';

// Transaction history model
class CryptoTransactionHistory {
  final String id;
  final CryptoTransactionType type;
  final String cryptoName;
  final String cryptoSymbol;
  final String amount;
  final double gbpAmount;
  final CryptoTransactionStatus status;
  final DateTime timestamp;
  final double fee;
  final String? fromCrypto;
  final String? toCrypto;

  const CryptoTransactionHistory({
    required this.id,
    required this.type,
    required this.cryptoName,
    required this.cryptoSymbol,
    required this.amount,
    required this.gbpAmount,
    required this.status,
    required this.timestamp,
    required this.fee,
    this.fromCrypto,
    this.toCrypto,
  });
}
