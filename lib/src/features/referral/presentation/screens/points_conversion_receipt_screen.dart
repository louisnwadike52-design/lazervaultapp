import 'package:flutter/material.dart';

import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/referral/domain/entities/redemption_entities.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// The receipt for converting Lazerpoints into cash.
///
/// WHY THIS EXISTS
/// ---------------
/// Converting rewards to money ended in a SnackBar. It was the only money
/// movement in the product with no receipt at all: nothing to download, nothing
/// to share, and nothing to refer back to when someone asks what happened to a
/// balance they had been building for months. A green toast that disappears in
/// four seconds is not a record of a payout.
///
/// WHY IT REUSES UnifiedTransactionReceipt
/// ---------------------------------------
/// Rather than drawing a rewards-specific receipt, this builds a
/// [UnifiedTransaction] and hands it to the receipt every other money movement
/// already uses — so the conversion inherits the share sheet, the PDF download,
/// the ASCII-safe font handling and the status treatment for free, and cannot
/// drift away from them later. The whole job here is describing the conversion
/// accurately; the rendering is already solved.
class PointsConversionReceiptScreen extends StatelessWidget {
  const PointsConversionReceiptScreen({
    super.key,
    required this.result,
    required this.pointsPerMajorUnit,
  });

  final RedemptionResultEntity result;

  /// The rate the conversion was priced at, recorded ON the receipt.
  ///
  /// Rates change. A receipt that omits the one it used cannot be checked after
  /// the fact, and "why did the same points pay out less this time" becomes
  /// unanswerable for the person best placed to notice it.
  final int pointsPerMajorUnit;

  UnifiedTransaction get _transaction => UnifiedTransaction(
        // The redemption reference IS the server's idempotency key, so the
        // receipt and the ledger row can always be tied together — including by
        // support, who will only ever have what the customer can read out.
        id: result.reference,
        serviceType: TransactionServiceType.lazerpoints,
        title: 'Lazerpoints converted',
        description:
            '${_formatPoints(result.pointsRedeemed)} points converted to cash',
        amount: result.cashMajor,
        currency: result.currency,
        createdAt: DateTime.now(),
        status: UnifiedTransactionStatus.completed,
        // Money ARRIVING in the wallet. The points left the balance, but this
        // receipt is about the cash, and marking it outgoing would show a minus
        // against a payment the user just received.
        flow: TransactionFlow.incoming,
        transactionReference: result.reference,
        counterpartyName: 'Lazerpoints rewards',
        // Human labels as KEYS, matching the invoice and contribution receipts.
        //
        // The metadata humanizer falls back to printing the key verbatim, so
        // snake_case keys reach the document as "points_redeemed 1,500" — and
        // the PDF builders read the same map, so both surfaces would show it.
        //
        // Values are pre-formatted strings for the same reason: the humanizer
        // only converts keys containing "minor", and everything else is printed
        // as-is. All ASCII apart from the naira sign, which the embedded Inter
        // face draws (see ReceiptFonts — the built-in Helvetica RAISES on a
        // glyph it lacks, which fails the whole document rather than
        // substituting).
        metadata: {
          'Points converted': '${_formatPoints(result.pointsRedeemed)} LP',
          'Rate': '${_formatPoints(pointsPerMajorUnit)} LP = ${_naira(1)}',
          'Points remaining': '${_formatPoints(result.newBalance)} LP',
        },
      );

  static String _naira(num v) => '₦${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(transaction: _transaction);
  }

  static String _formatPoints(int v) {
    // Thousands separators by hand rather than pulling NumberFormat in for one
    // integer: this runs inside a getter on the build path.
    final s = v.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
