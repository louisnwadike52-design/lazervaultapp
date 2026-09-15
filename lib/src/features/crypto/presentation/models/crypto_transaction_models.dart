// Models for crypto transaction details shared across screens.

import 'package:flutter/material.dart';

/// Transaction type enum
///
/// buy/sell/swap come from crypto_swap_transactions; send (crypto withdrawal to
/// an external/internal address) and deposit (incoming crypto) come from the
/// crypto_transactions table. All five are surfaced by the unified history RPC.
enum CryptoTransactionType { buy, sell, swap, send, deposit }

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

/// SINGLE source of truth for mapping the backend's raw status string onto
/// the UI enum. The crypto landing page's recent-transactions section and the
/// view-all history screen previously each had their own switch and rendered
/// DIFFERENT badges for the same row (landing collapsed everything unknown —
/// including swap_pending and reversed — to "failed"). Every crypto surface
/// must call this instead of hand-rolling a switch.
///
/// `reversed` maps to [CryptoTransactionStatus.refunded]: the backend uses it
/// for the undeliverable-buy auto-refund, where the user got their fiat back —
/// "Refunded" is the truthful badge, not "Failed".
CryptoTransactionStatus mapBackendCryptoTxStatus(String status) {
  switch (status.trim().toLowerCase()) {
    case 'completed':
    case 'success':
      return CryptoTransactionStatus.completed;
    case 'quote_pending':
    case 'submitting':
    case 'swap_pending':
    case 'pending':
    case 'processing':
      return CryptoTransactionStatus.pending;
    case 'failed':
    case 'error':
      return CryptoTransactionStatus.failed;
    case 'reversed':
    case 'refunded':
    case 'refund_pending':
      return CryptoTransactionStatus.refunded;
    case 'manual_review':
      return CryptoTransactionStatus.manualReview;
    case 'submission_unknown':
      return CryptoTransactionStatus.verifying;
    default:
      // Conservative default — an unknown future status must not show a
      // misleading green badge.
      return CryptoTransactionStatus.verifying;
  }
}

/// Badge colour for a crypto transaction status — shared by every list.
Color cryptoTxStatusColor(CryptoTransactionStatus status) {
  switch (status) {
    case CryptoTransactionStatus.completed:
      return Colors.green;
    case CryptoTransactionStatus.pending:
    case CryptoTransactionStatus.verifying:
      return Colors.orange;
    case CryptoTransactionStatus.failed:
      return Colors.red;
    case CryptoTransactionStatus.refunded:
      // Neutral grey — the user got their fiat back; neither good nor bad.
      return const Color(0xFF9CA3AF);
    case CryptoTransactionStatus.manualReview:
      return const Color(0xFFFB923C);
  }
}

/// Badge label for a crypto transaction status — shared by every list.
String cryptoTxStatusLabel(CryptoTransactionStatus status) {
  switch (status) {
    case CryptoTransactionStatus.completed:
      return 'Completed';
    case CryptoTransactionStatus.pending:
      return 'Processing';
    case CryptoTransactionStatus.failed:
      return 'Failed';
    case CryptoTransactionStatus.refunded:
      return 'Refunded';
    case CryptoTransactionStatus.manualReview:
      return 'Under Review';
    case CryptoTransactionStatus.verifying:
      return 'Verifying';
  }
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

/// PLATFORM FEE PRESENTATION POLICY — crypto buy / sell / swap.
///
/// The platform margin is taken as a SPREAD on the quoted rate, not as a
/// charge added on top. The backend already works this way: every
/// crypto_swap_transactions row carries `spread_bps` / `spread_minor_units`
/// priced into `quoted_price`, and on completion `creditSpreadIfNotYet` books
/// that margin to `CRYPTO_REVENUE_<from-currency>` (verified in production: a
/// ₦2,773.46 buy booked its ₦6.93 spread to CRYPTO_REVENUE_NGN).
///
/// So the money is already collected and already recognised as revenue. The UI
/// must therefore NOT render it as a separate "Trading fee" / "Lazervault fee"
/// line: doing so implied a second deduction on top of the rate the user had
/// just accepted, and made the displayed total disagree with the quoted rate
/// directly above it. The user pays exactly the rate they were shown.
///
/// This applies to confirmation sheets, receipts, and shared/exported PDFs.
///
/// NETWORK FEES ARE DIFFERENT and must still be shown: an on-chain send costs
/// the user a real third-party fee that is not our margin, and hiding it would
/// understate what leaves their wallet.
///
/// If a genuine explicit fee is ever introduced (charged in addition to the
/// rate, not inside it), it should be surfaced — this policy covers the
/// spread-based model only.
const String cryptoPlatformFeePolicy =
    'Platform margin is priced into the quoted rate and booked to '
    'CRYPTO_REVENUE at settlement; it is never shown as a separate user-facing '
    'fee line. Network fees are a real third-party cost and ARE shown.';
