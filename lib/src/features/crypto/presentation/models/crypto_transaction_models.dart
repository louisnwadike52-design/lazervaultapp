/// Models for crypto transaction details shared across screens.

/// Transaction type enum
enum CryptoTransactionType { buy, sell, swap }

/// Transaction status enum
enum CryptoTransactionStatus { completed, pending, failed }

/// Transaction details model for buy/sell/swap operations
class CryptoTransactionDetails {
  final CryptoTransactionType type;
  final String cryptoName;
  final String cryptoSymbol;
  final String cryptoAmount;
  final double pricePerUnit;
  final double fiatAmount;
  final double networkFee;
  final double tradingFee;
  final double totalAmount;
  final String paymentMethod;
  final String? fromCrypto; // For swaps
  final String? toCrypto; // For swaps
  final String? cryptoId; // Backend crypto ID
  final String? fromCryptoId; // For swaps - source crypto ID
  final String? toCryptoId; // For swaps - target crypto ID
  final double? cryptoQuantity; // Parsed numeric quantity

  const CryptoTransactionDetails({
    required this.type,
    required this.cryptoName,
    required this.cryptoSymbol,
    required this.cryptoAmount,
    required this.pricePerUnit,
    required this.fiatAmount,
    required this.networkFee,
    required this.tradingFee,
    required this.totalAmount,
    required this.paymentMethod,
    this.fromCrypto,
    this.toCrypto,
    this.cryptoId,
    this.fromCryptoId,
    this.toCryptoId,
    this.cryptoQuantity,
  });
}
