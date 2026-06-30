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
    final currency = (txCurrency != null && txCurrency.isNotEmpty && txCurrency != 'USD')
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
    final invoiceNumber = transaction['invoice_number']?.toString();
    final fromName = transaction['from_name']?.toString();
    final toName = transaction['to_name']?.toString();

    final metadata = <String, dynamic>{};

    if (isSplit && totalAmount != null) {
      metadata['Your Share'] =
          '${_currencySymbol(currency)}${NumberFormat('#,##0.00').format(amount)}';
      metadata['Total Invoice'] =
          '${_currencySymbol(currency)}${NumberFormat('#,##0.00').format(totalAmount)}';
      metadata['Status'] =
          settledFull ? 'Invoice fully paid' : 'Awaiting other recipients';
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
      // Always "Invoice Payment" — a split share that completes the invoice is
      // not a "partial" payment; the Status metadata conveys settled vs awaiting.
      title: 'Invoice Payment',
      amount: amount,
      currency: currency,
      // Use the real server-side paid_at when present, not the device clock.
      createdAt: _parsePaidAt(transaction['paid_at']) ?? DateTime.now(),
      status: UnifiedTransactionStatus.completed,
      flow: TransactionFlow.outgoing,
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

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN': return '\u20a6';
      case 'GBP': return '\u00a3';
      case 'EUR': return '\u20ac';
      case 'ZAR': return 'R';
      case 'USD': return '\$';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      default: return '\u20a6';
    }
  }
}
