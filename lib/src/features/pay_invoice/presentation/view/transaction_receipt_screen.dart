import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';

class TransactionReceiptScreen extends StatelessWidget {
  final TaggedInvoice invoice;
  final PaymentMethod paymentMethod;
  final String? selectedAccount;
  final String? selectedCrypto;

  const TransactionReceiptScreen({
    super.key,
    required this.invoice,
    required this.paymentMethod,
    this.selectedAccount,
    this.selectedCrypto,
  });

  @override
  Widget build(BuildContext context) {
    final tx = _toUnifiedTransaction();
    return UnifiedTransactionReceipt(transaction: tx);
  }

  UnifiedTransaction _toUnifiedTransaction() {
    final transactionId = _generateTransactionId();
    final methodInfo = _getPaymentMethodName();

    final metadata = <String, dynamic>{};

    metadata['Invoice Number'] = '#${invoice.invoiceNumber}';
    metadata['From'] = invoice.fromUserName;
    if (invoice.fromCompanyName != null) {
      metadata['Company'] = invoice.fromCompanyName!;
    }
    metadata['Payment Method'] = methodInfo;
    if (selectedAccount != null) {
      metadata['Account'] = selectedAccount!;
    }
    if (selectedCrypto != null) {
      metadata['Crypto'] = selectedCrypto!;
    }

    // Amount breakdown
    if (invoice.items.isNotEmpty) {
      metadata['Subtotal'] = '$_currencySymbol${invoice.amount.toStringAsFixed(2)}';
    }
    if ((invoice.taxAmount ?? 0) > 0) {
      metadata['Tax'] = '$_currencySymbol${invoice.taxAmount!.toStringAsFixed(2)}';
    }
    if ((invoice.discountAmount ?? 0) > 0) {
      metadata['Discount'] = '-$_currencySymbol${invoice.discountAmount!.toStringAsFixed(2)}';
    }
    if (invoice.dueDate != null) {
      metadata['Due Date'] = DateFormat('d MMM yyyy').format(invoice.dueDate!);
    }
    if (invoice.notes != null && invoice.notes!.isNotEmpty) {
      metadata['Notes'] = invoice.notes!;
    }

    return UnifiedTransaction(
      id: transactionId,
      serviceType: TransactionServiceType.invoice,
      title: 'Invoice Payment to ${invoice.fromUserName}',
      description: invoice.title,
      amount: invoice.totalAmount,
      currency: invoice.currency,
      createdAt: DateTime.now(),
      status: UnifiedTransactionStatus.completed,
      flow: TransactionFlow.outgoing,
      transactionReference: transactionId,
      metadata: metadata.isNotEmpty ? metadata : null,
    );
  }

  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final method = paymentMethod.name.toUpperCase();
    return '${method}_${timestamp.substring(timestamp.length - 8)}';
  }

  String get _currencySymbol {
    switch (invoice.currency.toUpperCase()) {
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

  String _getPaymentMethodName() {
    switch (paymentMethod) {
      case PaymentMethod.accountBalance:
        return 'Account Balance';
      case PaymentMethod.bitcoin:
        return 'Bitcoin';
      case PaymentMethod.ethereum:
        return 'Ethereum';
      case PaymentMethod.usdc:
        return 'USD Coin';
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.googlePay:
        return 'Google Pay';
      case PaymentMethod.paypal:
        return 'PayPal';
      default:
        return 'Bank Transfer';
    }
  }
}
