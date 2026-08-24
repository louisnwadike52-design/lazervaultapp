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

/// Single source of truth for turning a history row into the receipt the
/// full-page [CryptoReceiptScreen] renders. Both the landing page's
/// recent-transactions section and the view-all history screen use this, so
/// share/download always carry the same, real details.
CryptoTransactionReceipt buildCryptoHistoryReceipt(
    CryptoTransactionHistory transaction) {
  final qty = double.tryParse(transaction.amount) ?? 0.0;
  final details = CryptoTransactionDetails(
    type: transaction.type,
    cryptoName: transaction.cryptoName,
    cryptoSymbol: transaction.cryptoSymbol,
    cryptoAmount: transaction.amount,
    pricePerUnit: qty > 0 ? transaction.gbpAmount / qty : 0.0,
    fiatAmount: transaction.gbpAmount,
    // The backend reports ONE fee (the platform trading fee / spread). Do
    // not invent a network/trading split it never made — the receipt hides
    // zero-value rows, so only the real fee renders.
    networkFee: 0,
    tradingFee: transaction.fee,
    totalAmount: transaction.gbpAmount + transaction.fee,
    paymentMethod: 'LazerVault Wallet',
    fromCrypto: transaction.fromCrypto,
    toCrypto: transaction.toCrypto,
    cryptoQuantity: qty,
  );
  return CryptoTransactionReceipt(
    transactionId: transaction.id,
    transactionDetails: details,
    timestamp: transaction.timestamp,
    status: transaction.status,
  );
}

/// Opens the full-page receipt for a history row directly — no intermediate
/// bottomsheet. Works for every status; the receipt renders the status badge
/// (Processing / Refunded / Failed / Completed) alongside Download / Share.
/// SEND rows route to the dedicated send receipt (hydrated from the
/// withdrawal record: recipient, network, note/narration, live status).
void openCryptoTransactionReceipt(CryptoTransactionHistory transaction) {
  if (transaction.type == CryptoTransactionType.send) {
    Get.to(() => SendCryptoReceiptScreen.fromLookup(
          transactionId: transaction.id,
        ));
    return;
  }
  Get.to(() => CryptoReceiptScreen(
        receipt: buildCryptoHistoryReceipt(transaction),
        fromHistory: true,
      ));
}

