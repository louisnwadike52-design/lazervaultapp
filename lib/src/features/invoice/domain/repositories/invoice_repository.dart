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
  Future<Invoice> markInvoiceAsPaid(String invoiceId, PaymentMethod paymentMethod, String? paymentReference, {String? pin, String? verificationToken});
  Future<Invoice> cancelInvoice(String invoiceId);
  Future<String> generateQRCode(String invoiceId);
  Future<List<Invoice>> searchInvoices(String query);
  Future<List<Invoice>> getOverdueInvoices();
  Future<Map<String, dynamic>> getInvoiceStatistics(String userId);

  // File Operations
  Future<String> generateInvoicePDF(String invoiceId);
  Future<void> shareInvoice(String invoiceId, List<String> recipients);
  
  // Unlock invoice (pay service fee)
  Future<Invoice> unlockInvoice(String invoiceId, {String? accountId, String? pin, String? verificationToken, String? transactionId, String? idempotencyKey});

  // Payment tracking
  Future<void> recordPayment(String invoiceId, double amount, PaymentMethod method, String reference);
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId);

  // User tagging for invoices
  Future<TagUsersResponse> tagUsersToInvoice(String invoiceId, List<String> userIds, List<String> emails, List<String> phoneNumbers);
  Future<List<InvoiceUser>> searchUsers(String query, {int limit = 20});
}

// User model for search results
class InvoiceUser {
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final bool isOnline;

  InvoiceUser({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.isOnline,
  });
}

// Response model for tag users operation
class TagUsersResponse {
  final bool success;
  final List<String> taggedUserIds;
  final List<String> invitedEmails;
  final List<String> invitedPhones;
  final String message;

  TagUsersResponse({
    required this.success,
    required this.taggedUserIds,
    required this.invitedEmails,
    required this.invitedPhones,
    required this.message,
  });
} 