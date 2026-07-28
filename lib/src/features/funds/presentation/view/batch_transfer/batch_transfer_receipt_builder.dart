import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

/// Builds the receipt-screen arguments map from a completed [BatchTransferEntity]
/// and the in-flight `batchTransferDetails` payload.
///
/// Single source of truth shared by the long flow's Processing screen and the
/// short flow's inline dispatch, so both render an identical batch receipt
/// (the shared send-funds TransferReceiptScreen rendered in its batch variant).
Map<String, dynamic> buildBatchReceiptData(
  BatchTransferEntity response,
  Map<String, dynamic> details, {
  required bool isScheduled,
  String? scheduledAt,
}) {
  final currency = details['currency'] as String? ?? 'NGN';
  final recipientNames =
      (details['recipientNames'] as Map?)?.cast<String, String>() ?? {};
  final currencySymbol = details['currencySymbol'] as String? ?? '₦';

  return <String, dynamic>{
    // Batch variant rendered by the shared send-funds TransferReceiptScreen.
    'isBatch': true,
    'amount': response.totalAmount.toDouble() / 100,
    'fee': response.totalFee.toDouble() / 100,
    'reference': response.batchId,
    'batchId': response.batchId,
    'totalAmount': response.totalAmount.toDouble() / 100,
    'totalFee': response.totalFee.toDouble() / 100,
    'currency': currency,
    'currencySymbol': currencySymbol,
    'timestamp': response.completedAt ?? response.createdAt,
    'status': response.status,
    'recipientCount': response.totalTransfers,
    'successfulTransfers': response.successfulTransfers,
    'failedTransfers': response.failedTransfers,
    'newBalance': response.newBalance,
    'message': response.message,
    'isScheduled': isScheduled,
    'scheduledAt': scheduledAt,
    'fromAccountId': details['fromAccountId'],
    'senderAccountName': details['senderAccountName'],
    'senderAccountInfo': details['senderAccountInfo'],
    'transfers': response.results.map((r) {
      // Resolve best name: prefer beneficiaryName (actual person name) over
      // recipientName (which may be an account type like "Business").
      final beneficiary = r.beneficiaryName;
      final recipient = r.recipientName;
      final fallback = recipientNames[r.recipientAccount];
      String resolvedName;
      if (beneficiary != null &&
          beneficiary.isNotEmpty &&
          beneficiary.toLowerCase() != 'unknown' &&
          beneficiary.toLowerCase() != 'external account') {
        resolvedName = beneficiary;
      } else if (recipient != null &&
          recipient.isNotEmpty &&
          recipient.toLowerCase() != 'unknown' &&
          recipient.toLowerCase() != 'business') {
        resolvedName = recipient;
      } else {
        resolvedName = fallback ?? beneficiary ?? recipient ?? 'Unknown';
      }
      return {
        'recipientName': resolvedName,
        'beneficiaryName': beneficiary,
        'recipientUserId': r.recipientUserId,
        'recipientAccount': r.recipientAccount ?? '',
        'amount': r.amount.toDouble() / 100,
        'fee': r.fee.toDouble() / 100,
        'status': r.status,
        'failureReason': r.failureReason,
        'reference': r.reference,
      };
    }).toList(),
  };
}
