import 'package:equatable/equatable.dart';

/// A LazerVault RECEIPT read from a QR code — proof that a payment already
/// happened, not a request for one.
///
/// WHY THIS IS ITS OWN TYPE, AND WHY IT MATTERS FOR MONEY
/// -----------------------------------------------------
/// Every receipt in the app carries a QR of its own: transfers and batch
/// transfers (`transfer`, `batch_transfer`), each bill service (`airtime`,
/// `data`, `electricity`, `cable_tv`, `internet`, `water`, `education`,
/// `intl_airtime`, `intl_data` — see bill_receipt_qr_block), group contributions,
/// exchanges, donations. They all encode the same shape: a type, a reference, an
/// amount, a currency, a status and a date.
///
/// ScannedCodeClassifier returned null for all of them, which routed the scan to
/// the OCR fallback — and OCR reading a receipt finds a recipient name, an
/// account number and an amount, which is precisely the shape of a payment
/// request. So pointing Scan-to-Pay at a receipt could offer to pay it AGAIN,
/// with the receipt's own figures pre-filled. Recognising a receipt as a receipt
/// is therefore a double-payment guard first and a feature second.
///
/// Deliberately carries no payment fields. There is nothing here to pay.
class ScannedReceipt extends Equatable {
  const ScannedReceipt({
    required this.kind,
    required this.reference,
    required this.raw,
    this.amount,
    this.currency = 'NGN',
    this.status,
    this.date,
    this.counterparty,
  });

  /// The receipt's own `type` discriminator, verbatim (e.g. 'transfer',
  /// 'cable_tv'). Kept raw rather than mapped onto an enum so a new service's
  /// receipt is still recognised as a receipt the day it ships, which is the
  /// behaviour that keeps the guard above from going stale.
  final String kind;

  /// The transaction reference — the one field that lets a human or the history
  /// screen find the original.
  final String reference;
  final double? amount;
  final String currency;
  final String? status;
  final DateTime? date;

  /// Who it was paid to, when the receipt names them ('to' on a transfer).
  final String? counterparty;

  /// The raw QR value, retained for diagnostics and for history.
  final String raw;

  /// A human label for [kind]: 'cable_tv' → 'Cable TV'.
  String get kindLabel {
    final cleaned = kind.replaceAll('_', ' ').trim();
    if (cleaned.isEmpty) return 'Payment';
    return cleaned
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  @override
  List<Object?> get props =>
      [kind, reference, amount, currency, status, date, counterparty];
}
