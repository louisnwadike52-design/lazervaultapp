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

  // generateInvoiceUrl REMOVED. It minted
  // `https://lazervault.app/invoice/<id>` and was called from nowhere — its
  // own comment said the URL "would typically point to your web app or
  // payment portal", i.e. it was speculative.
  //
  // Deleted rather than wired up, because a dead method that LOOKS like a
  // share link is worse than no method: an audit of "which share paths does
  // the app mint, and does the OS claim them?" reports it as an unclaimed
  // path, and the fix that suggests itself is to claim /invoice/ on two
  // platforms and serve a landing page — for a link nothing sends.
  //
  // The two generators above are the real ones, and they return JSON payloads
  // for a QR rather than URLs, so neither needs a path claimed.
}
