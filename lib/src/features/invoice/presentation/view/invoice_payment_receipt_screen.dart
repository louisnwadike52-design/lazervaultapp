import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import '../../../../../core/services/locale_manager.dart';

class InvoicePaymentReceiptScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const InvoicePaymentReceiptScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final tx = _toUnifiedTransaction();
    return UnifiedTransactionReceipt(transaction: tx);
  }

  UnifiedTransaction _toUnifiedTransaction() {
    final localeManager = GetIt.I<LocaleManager>();

    final transactionId = transaction['transaction_id']?.toString() ?? '';
    final invoiceId = transaction['invoice_id']?.toString() ?? '';
    final amount = (transaction['amount'] as num?)?.toDouble() ?? 0.0;
    final txCurrency = transaction['currency'] as String?;
    // Trust the transaction's own currency. (The old `!= 'USD'` clause guarded
    // against a since-fixed hardcoded USD default and relabelled genuine USD
    // receipts with the local currency symbol.)
    final currency = (txCurrency != null && txCurrency.isNotEmpty)
        ? txCurrency
        : localeManager.currentCurrency;
    final message = transaction['message'] as String?;
    // A split invoice payment covers the payer's SHARE of the total. settledFull
    // is true when THIS payment completed the invoice (the last payer).
    final isSplit =
        transaction['is_split'] == true || transaction['is_partial'] == true;
    final settledFull = transaction['settled_full'] == true;
    final totalAmount = (transaction['total_amount'] as num?)?.toDouble();
    // Cross-currency payment: the headline amount/currency above are already the
    // converted value in the payer's account currency. These carry the invoice's
    // own currency + amount and the rate used, so the receipt shows BOTH.
    final invoiceCurrency = transaction['invoice_currency'] as String?;
    final invoiceAmount = (transaction['invoice_amount'] as num?)?.toDouble();
    final fxRate = (transaction['fx_rate'] as num?)?.toDouble();
    final hasFx = invoiceCurrency != null &&
        invoiceCurrency.isNotEmpty &&
        fxRate != null &&
        fxRate > 0;
    final invoiceNumber = transaction['invoice_number']?.toString();
    final fromName = transaction['from_name']?.toString();
    final toName = transaction['to_name']?.toString();
    // What the invoice was FOR. Passed by the callers that hold the invoice.
    final invoiceTitle = transaction['invoice_title']?.toString();
    final dueDate = transaction['due_date']?.toString();
    // 'creator' when opened from the creator's details screen: the money came
    // IN, so flow/status/title must not claim the creator paid.
    final isCreator = transaction['perspective'] == 'creator';
    final invoiceType = transaction['invoice_type']?.toString() ?? '';
    final docLabel = invoiceType == 'request' ? 'Payment Request' : 'Invoice';

    // CANONICAL KEYS, NOT PRE-RENDERED LABELS.
    //
    // This screen used to assemble the finished rows itself — 'Invoice No.',
    // 'From', 'Bill To', 'Your Share', 'Total Invoice' — as display strings in
    // metadata. They looked right here and existed NOWHERE else: nothing was
    // persisted, so the same payment reopened from transaction history (and
    // the PDF generated from it) showed a bare transfer with the invoice
    // number buried in the narration.
    //
    // invoice-service now stamps the same facts on both ledger legs, and
    // InvoiceReceiptFields renders them. Emitting the SAME keys here means
    // this receipt and the history one are one document rendered twice, not
    // two documents that happen to describe the same payment.
    final metadata = <String, dynamic>{};
    if (invoiceId.isNotEmpty && invoiceId != 'N/A') {
      metadata['invoice_id'] = invoiceId;
    }
    if (invoiceNumber != null && invoiceNumber.isNotEmpty) {
      metadata['invoice_number'] = invoiceNumber;
    }
    if (invoiceType.isNotEmpty) metadata['invoice_doc_type'] = invoiceType;
    if (invoiceTitle != null && invoiceTitle.trim().isNotEmpty) {
      metadata['invoice_title'] = invoiceTitle.trim();
    }
    if (fromName != null && fromName.isNotEmpty) {
      metadata['invoice_billed_by'] = fromName;
    }
    if (toName != null && toName.isNotEmpty) {
      metadata['invoice_billed_to'] = toName;
    }
    // The invoice's own currency and total. On a cross-currency payment the
    // headline amount above is in the PAYER's currency, so these two must come
    // from the invoice, never from the leg.
    final docCurrency =
        hasFx && invoiceCurrency.isNotEmpty ? invoiceCurrency : currency;
    metadata['invoice_currency'] = docCurrency.toUpperCase();
    if (totalAmount != null && totalAmount > 0) {
      metadata['invoice_total_minor'] = (totalAmount * 100).round();
    }
    if (dueDate != null && dueDate.trim().isNotEmpty) {
      metadata['invoice_due_date'] = dueDate.trim();
    }
    if (isSplit) {
      metadata['invoice_split'] = true;
      // This payer's share, in the INVOICE's currency so it is comparable
      // with the total beside it.
      final shareMajor = hasFx ? (invoiceAmount ?? 0) : amount;
      if (shareMajor > 0) {
        metadata['invoice_share_minor'] = (shareMajor * 100).round();
      }
      // Only this screen knows it: the ledger stamp is written before the
      // invoice's status transition commits, so a history receipt shows no
      // settlement row rather than guessing one.
      metadata['invoice_settled'] = settledFull;
    }
    if (hasFx) {
      metadata['invoice_settle_currency'] = currency.toUpperCase();
      metadata['invoice_fx_rate'] = fxRate;
    }
    if (message != null && message.isNotEmpty) {
      metadata['Message'] = message;
    }
    // THE NEW BALANCE IS DELIBERATELY NOT HERE.
    //
    // A receipt is the one artefact built to be handed to somebody else — this
    // screen has Download and Share — and the payer's remaining balance is not
    // the counterparty's business. It stays on the statement of account, which
    // is where a running balance belongs. (Same rule as balance_before /
    // balance_after in unified_transaction_receipt.dart.)

    return UnifiedTransaction(
      id: transactionId,
      serviceType: TransactionServiceType.invoice,
      // Payer: "Invoice Payment" (a split share that completes the invoice is
      // not "partial" — Status metadata conveys settled vs awaiting). Creator:
      // the money came IN.
      title: isCreator ? '$docLabel Payment Received' : '$docLabel Payment',
      amount: amount,
      currency: currency,
      // Use the real server-side paid_at when present, not the device clock.
      createdAt: _parsePaidAt(transaction['paid_at']) ?? DateTime.now(),
      status: isCreator && isSplit && !settledFull
          ? UnifiedTransactionStatus.pending
          : UnifiedTransactionStatus.completed,
      flow: isCreator ? TransactionFlow.incoming : TransactionFlow.outgoing,
      transactionReference: transactionId.isNotEmpty ? transactionId : null,
      metadata: metadata.isNotEmpty ? metadata : null,
    );
  }

  /// Parses the backend paid_at ("2006-01-02 15:04:05", UTC) into a DateTime.
  DateTime? _parsePaidAt(Object? raw) {
    final s = raw?.toString().trim() ?? '';
    if (s.isEmpty) return null;
    // Try ISO first, then the backend's space-separated UTC format.
    return DateTime.tryParse(s) ??
        DateTime.tryParse('${s.replaceFirst(' ', 'T')}Z')?.toLocal();
  }
}
