import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
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
    final newBalance = (transaction['new_balance'] as num?)?.toDouble();
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
    // 'creator' when opened from the creator's details screen: the money came
    // IN, so flow/status/title must not claim the creator paid.
    final isCreator = transaction['perspective'] == 'creator';
    final invoiceType = transaction['invoice_type']?.toString() ?? '';
    final docLabel = invoiceType == 'request' ? 'Payment Request' : 'Invoice';

    final metadata = <String, dynamic>{};

    if (isSplit && totalAmount != null) {
      // Payer: their share of the split. Creator: what has come in so far.
      metadata[isCreator ? 'Received So Far' : 'Your Share'] =
          '${_currencySymbol(currency)}${NumberFormat('#,##0.00').format(amount)}';
      // The invoice total is denominated in the invoice currency, which differs
      // from the payer's account currency on a cross-currency payment.
      final totalSymbol =
          hasFx ? _currencySymbol(invoiceCurrency) : _currencySymbol(currency);
      metadata['Total Invoice'] =
          '$totalSymbol${NumberFormat('#,##0.00').format(totalAmount)}';
      metadata['Status'] =
          settledFull ? 'Invoice fully paid' : 'Awaiting other recipients';
    }

    // Dual-currency rows: show the original invoice amount + the rate used.
    if (hasFx) {
      metadata['Invoice Amount'] =
          '${_currencySymbol(invoiceCurrency)}${NumberFormat('#,##0.00').format(invoiceAmount ?? 0)}';
      metadata['Exchange Rate'] = _formatRate(invoiceCurrency, currency, fxRate);
    }
    if (invoiceNumber != null && invoiceNumber.isNotEmpty) {
      metadata['Invoice No.'] = invoiceNumber;
    } else if (invoiceId.isNotEmpty && invoiceId != 'N/A') {
      metadata['Invoice ID'] = invoiceId;
    }
    if (fromName != null && fromName.isNotEmpty) {
      metadata['From'] = fromName;
    }
    if (toName != null && toName.isNotEmpty) {
      metadata['Bill To'] = toName;
    }
    if (newBalance != null && newBalance > 0) {
      metadata['New Balance'] = '${_currencySymbol(currency)}${NumberFormat('#,##0.00').format(newBalance)}';
    }
    if (message != null && message.isNotEmpty) {
      metadata['Message'] = message;
    }

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

  /// "1 FROM = R TO" — extra precision for very small rates (e.g. NGN→USD).
  String _formatRate(String from, String to, double rate) {
    final r = rate >= 0.01 ? rate.toStringAsFixed(4) : rate.toStringAsFixed(6);
    return '1 ${from.toUpperCase()} = $r ${to.toUpperCase()}';
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN': return '\u20a6';
      case 'GBP': return '\u00a3';
      case 'EUR': return '\u20ac';
      case 'ZAR': return 'R';
      case 'USD': return '\$';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      case 'INR': return '\u20b9';
      case 'JPY': return '\u00a5';
      // Unknown codes show their code, never a wrong \u20a6.
      default: return '${currency.toUpperCase()} ';
    }
  }
}
