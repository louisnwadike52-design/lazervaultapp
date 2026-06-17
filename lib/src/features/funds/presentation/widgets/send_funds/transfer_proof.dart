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

    // Beneficiary details - separate rows
    if (recipientName.isNotEmpty) {
      metadata['Beneficiary Name'] = recipientName;
    }
    final recipientAccount = transferDetails['recipientAccountMasked']?.toString();
    if (recipientAccount != null && recipientAccount.isNotEmpty) {
      metadata['Beneficiary Account'] = recipientAccount;
    }
    final recipientBank = transferDetails['recipientBankName']?.toString();
    if (recipientBank != null && recipientBank.isNotEmpty) {
      metadata['Beneficiary Bank'] = recipientBank;
    }

    // Source account (from account) - combine info and name if available
    final sourceAccountInfo = transferDetails['sourceAccountInfo']?.toString() ?? '';
    if (sourceAccountInfo.isNotEmpty) {
      final sourceAccountName = transferDetails['sourceAccountName']?.toString();
      if (sourceAccountName != null && sourceAccountName.isNotEmpty) {
        metadata['From'] = '$sourceAccountName ($sourceAccountInfo)';
      } else {
        metadata['From'] = sourceAccountInfo;
      }
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
    if (transferDetails['reference'] != null &&
        (transferDetails['reference'] as String).isNotEmpty) {
      metadata['Reference'] = transferDetails['reference'];
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
