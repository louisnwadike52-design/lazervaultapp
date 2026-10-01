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

  /// The other side of the trade: NGN for a buy/sell, the asset given up for
  /// a crypto→crypto swap. Empty when the backend did not say.
  final String counterCurrency;

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
    this.counterCurrency = '',
  });

  /// True when [gbpAmount] is NOT money in the user's own currency.
  ///
  /// A USDT→USDC swap reports its value as 1.5 USDT. Rendering that with the
  /// global naira symbol produced "₦1.50" for a trade worth about ₦2,000 —
  /// off by three orders of magnitude and in the wrong unit.
  bool get valueIsCrypto {
    final c = counterCurrency.trim().toUpperCase();
    if (c.isEmpty) return false;
    return !const {'NGN', 'USD', 'GBP', 'EUR', 'KES', 'GHS', 'ZAR', 'CAD'}
        .contains(c);
  }

  /// The value column, in whatever unit the value is actually denominated in.
  String formattedValue(String fiatSymbol) => valueIsCrypto
      ? '${gbpAmount.toStringAsFixed(6)} ${counterCurrency.toUpperCase()}'
      : '$fiatSymbol${gbpAmount.toStringAsFixed(2)}';
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
    // NOT gbpAmount + fee. gbpAmount is ALREADY the total the backend
    // reports (CryptoTransaction.totalAmount), and the platform margin is
    // carried in the RATE the user accepted, never charged on top — see the
    // policy note in crypto_receipt_screen. Adding the fee here made a sell
    // receipt read 2,023.02 when 2,017.97 reached the wallet, and made the
    // Total disagree with the Rate line directly above it.
    totalAmount: transaction.gbpAmount,
    paymentMethod: cryptoSettlementAccountLabel(),
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
