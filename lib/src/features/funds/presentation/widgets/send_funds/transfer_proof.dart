import 'package:flutter/material.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// Transfer proof receipt — converts legacy map-based transfer details
/// into a [UnifiedTransaction] and renders the unified receipt.
class TransferProof extends StatelessWidget {
  final Map<String, dynamic> transferDetails;

  const TransferProof({super.key, required this.transferDetails});

  @override
  Widget build(BuildContext context) {
    final tx = _toUnifiedTransaction();
    return UnifiedTransactionReceipt(transaction: tx);
  }

  UnifiedTransaction _toUnifiedTransaction() {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final recipientName =
        transferDetails['recipientName'] as String? ?? 'Recipient';
    final transferId = transferDetails['transferId']?.toString() ?? '';
    final timestamp =
        transferDetails['timestamp'] as DateTime? ?? DateTime.now();
    final status = transferDetails['status'] as String? ?? 'completed';

    final metadata = <String, dynamic>{};

    // Transfer-specific fields
    if (fee > 0) metadata['Fee'] = '${_currencySymbol(currency)}${fee.toStringAsFixed(2)}';
    if (transferDetails['recipientName'] != null) {
      metadata['Recipient'] = recipientName;
    }
    if (transferDetails['recipientAccountMasked'] != null) {
      metadata['Recipient Account'] = transferDetails['recipientAccountMasked'];
    }
    if (transferDetails['sourceAccountInfo'] != null &&
        (transferDetails['sourceAccountInfo'] as String).isNotEmpty) {
      metadata['Source Account'] = transferDetails['sourceAccountInfo'];
    }
    if (transferDetails['network'] != null) {
      metadata['Network'] = transferDetails['network'];
    }
    if (transferDetails['transferType'] != null) {
      metadata['Transfer Type'] = transferDetails['transferType'];
    }
    if (transferDetails['processingTime'] != null) {
      metadata['Processing'] = transferDetails['processingTime'];
    }
    if (transferDetails['narration'] != null &&
        (transferDetails['narration'] as String).isNotEmpty) {
      metadata['Narration'] = transferDetails['narration'];
    }
    if (transferDetails['scheduledAt'] != null) {
      final scheduled = transferDetails['scheduledAt'];
      metadata['scheduledAt'] = scheduled is DateTime
          ? scheduled.toIso8601String()
          : scheduled.toString();
      metadata['status'] = 'scheduled';
    }

    return UnifiedTransaction(
      id: transferId,
      serviceType: TransactionServiceType.transfer,
      title: 'Transfer to $recipientName',
      amount: amount,
      currency: currency,
      createdAt: timestamp,
      status: UnifiedTransactionStatus.fromString(status),
      flow: TransactionFlow.outgoing,
      transactionReference: transferId.isNotEmpty ? transferId : null,
      metadata: metadata.isNotEmpty ? metadata : null,
    );
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN': return '\u20a6';
      case 'GBP': return '\u00a3';
      case 'EUR': return '\u20ac';
      case 'USD': return '\$';
      default: return '\u20a6';
    }
  }
}
