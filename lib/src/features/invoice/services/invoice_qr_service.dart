import 'dart:convert';
import '../domain/entities/invoice_entity.dart';

class InvoiceQrService {
  static String generateInvoiceQR(Invoice invoice) {
    // Create invoice data for QR code
    final qrData = {
      'type': 'invoice',
      'id': invoice.id,
      'title': invoice.title,
      'amount': invoice.totalAmount,
      'currency': invoice.currency,
      'dueDate': invoice.dueDate?.toIso8601String(),
      'recipient': invoice.toName ?? 'Client',
      'email': invoice.toEmail,
      'status': invoice.status.name,
    };

    // Convert to JSON string for QR code
    return jsonEncode(qrData);
  }

  static String generatePaymentQR(Invoice invoice) {
    // Create payment-specific QR data
    final paymentData = {
      'type': 'payment',
      'invoiceId': invoice.id,
      'amount': invoice.totalAmount,
      'currency': invoice.currency,
      'recipient': invoice.toName ?? 'Client',
      'description': 'Payment for ${invoice.title}',
      'dueDate': invoice.dueDate?.toIso8601String(),
    };

    return jsonEncode(paymentData);
  }

  static String generateInvoiceUrl(Invoice invoice) {
    // Generate a URL that could be used to view the invoice
    // This would typically point to your web app or payment portal
    return 'https://lazervault.app/invoice/${invoice.id}';
  }
} 