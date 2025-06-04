import '../entities/invoice_entity.dart';

abstract class InvoiceRepository {
  // CRUD Operations
  Future<List<Invoice>> getAllInvoices();
  Future<List<Invoice>> getInvoicesByUserId(String userId);
  Future<List<Invoice>> getInvoicesTaggedToUser(String userId);
  Future<List<Invoice>> getInvoicesByStatus(InvoiceStatus status);
  Future<Invoice?> getInvoiceById(String id);
  Future<Invoice> createInvoice(Invoice invoice);
  Future<Invoice> updateInvoice(Invoice invoice);
  Future<void> deleteInvoice(String id);

  // Specific Operations
  Future<Invoice> sendInvoice(String invoiceId);
  Future<Invoice> markInvoiceAsPaid(String invoiceId, PaymentMethod paymentMethod, String? paymentReference);
  Future<Invoice> cancelInvoice(String invoiceId);
  Future<String> generateQRCode(String invoiceId);
  Future<List<Invoice>> searchInvoices(String query);
  Future<List<Invoice>> getOverdueInvoices();
  Future<Map<String, dynamic>> getInvoiceStatistics(String userId);

  // File Operations
  Future<String> generateInvoicePDF(String invoiceId);
  Future<void> shareInvoice(String invoiceId, List<String> recipients);
  
  // Payment tracking
  Future<void> recordPayment(String invoiceId, double amount, PaymentMethod method, String reference);
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId);
} 