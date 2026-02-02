import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';

abstract class TaggedInvoiceRepository {
  /// Get invoices that the current user was tagged to pay (incoming)
  /// These are invoices where someone else tagged this user
  Future<List<TaggedInvoice>> getIncomingTaggedInvoices({
    int page = 1,
    int limit = 20,
    InvoicePaymentStatus? statusFilter,
    String? currency,
  });

  /// Get invoices that the current user created and tagged others to (outgoing)
  /// These are invoices where this user is the creator
  Future<List<TaggedInvoice>> getOutgoingTaggedInvoices({
    int page = 1,
    int limit = 20,
    InvoicePaymentStatus? statusFilter,
  });

  /// Get statistics for incoming tagged invoices (what user needs to pay)
  Future<TaggedInvoiceStatistics> getIncomingStatistics();

  /// Get statistics for outgoing tagged invoices (what user is owed)
  Future<TaggedInvoiceStatistics> getOutgoingStatistics();

  /// Get a specific tagged invoice by ID
  Future<TaggedInvoice> getTaggedInvoiceById(String taggedInvoiceId);

  /// Mark a tagged invoice as viewed
  Future<void> markAsViewed(String invoiceId);

  /// Pay a tagged invoice from account balance with security verification
  /// Returns the transaction details
  Future<Map<String, dynamic>> payTaggedInvoice({
    required String invoiceId,
    required String sourceAccountId,
    required String pin,
    required String verificationToken,
    required String transactionId,
    required String idempotencyKey,
  });

  /// Get overdue tagged invoices (incoming only)
  Future<List<TaggedInvoice>> getOverdueTaggedInvoices({
    int page = 1,
    int limit = 20,
  });

  /// Get upcoming tagged invoices (due soon, incoming only)
  Future<List<TaggedInvoice>> getUpcomingTaggedInvoices({
    int page = 1,
    int limit = 20,
    int daysAhead = 7,
  });

  /// Search tagged invoices
  Future<List<TaggedInvoice>> searchTaggedInvoices({
    required String query,
    bool incoming = true,
    int page = 1,
    int limit = 20,
  });

  /// Set a reminder for a tagged invoice
  Future<void> setPaymentReminder({
    required String invoiceId,
    required DateTime reminderDate,
  });

  /// Update tagged invoice notes
  Future<void> updateNotes({
    required String taggedInvoiceId,
    required String notes,
  });

  /// Update tagged invoice priority
  Future<void> updatePriority({
    required String taggedInvoiceId,
    required InvoicePriority priority,
  });
}
