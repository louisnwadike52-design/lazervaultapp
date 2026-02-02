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
    final isPartial = transaction['is_partial'] == true;
    final totalAmount = (transaction['total_amount'] as num?)?.toDouble();

    final metadata = <String, dynamic>{};

    if (isPartial && totalAmount != null) {
      metadata['Payment Type'] = 'Partial Invoice Payment';
      metadata['Total Invoice'] = '${_currencySymbol(currency)}${NumberFormat('#,##0.00').format(totalAmount)}';
    }
    if (invoiceId.isNotEmpty && invoiceId != 'N/A') {
      metadata['Invoice ID'] = invoiceId;
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
      title: isPartial ? 'Partial Invoice Payment' : 'Invoice Payment',
      amount: amount,
      currency: currency,
      createdAt: DateTime.now(),
      status: UnifiedTransactionStatus.completed,
      flow: TransactionFlow.outgoing,
      transactionReference: transactionId.isNotEmpty ? transactionId : null,
      metadata: metadata.isNotEmpty ? metadata : null,
    );
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
