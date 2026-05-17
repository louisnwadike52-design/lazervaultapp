/// Models for crypto transaction details shared across screens.

/// Transaction type enum
enum CryptoTransactionType { buy, sell, swap }

/// Transaction status enum.
///
/// Covers every terminal-and-intermediate state the backend exposes for a
/// crypto swap row (per migrations 007 + 018 + 020):
///   - completed: order filled, balances reflected
///   - pending: order placed on Quidax, awaiting webhook completion
///                (covers backend statuses: quote_pending, submitting,
///                swap_pending — all "in flight, will resolve")
///   - failed: order rejected by Quidax pre-charge, hold released
///   - refunded: rollback pipeline completed; user got their fiat back
///   - manualReview: rollback escalated to admin (settlement exhausted,
///                   ambiguous Quidax POST after max retries)
///   - verifying: submission_unknown — we don't know yet whether Quidax
///                actually placed the order; supervisor is reconciling
enum CryptoTransactionStatus {
  completed,
  pending,
  failed,
  refunded,
  manualReview,
  verifying,
}

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
