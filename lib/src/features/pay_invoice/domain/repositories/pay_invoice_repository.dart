import '../entities/tagged_invoice_entity.dart';

enum PaymentMethod {
  accountBalance,
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
  bitcoin,
  ethereum,
  usdc,
  bankTransfer,
}

class PaymentDetails {
  final PaymentMethod method;
  final double amount;
  final String currency;
  final String? cardLast4;
  final String? accountId;
  final String? reference;
  final Map<String, dynamic>? metadata;

  const PaymentDetails({
    required this.method,
    required this.amount,
    required this.currency,
    this.cardLast4,
    this.accountId,
    this.reference,
    this.metadata,
  });
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final String? paymentReference;
  final String? errorMessage;
  final PaymentStatus status;
  final DateTime processedAt;

  const PaymentResult({
    required this.success,
    this.transactionId,
    this.paymentReference,
    this.errorMessage,
    required this.status,
    required this.processedAt,
  });
}

abstract class PayInvoiceRepository {
  // Invoice retrieval methods
  Future<List<TaggedInvoice>> getTaggedInvoices(String userId);
  Future<List<TaggedInvoice>> getTaggedInvoicesByStatus(String userId, PaymentStatus status);
  Future<List<TaggedInvoice>> getOverdueInvoices(String userId);
  Future<List<TaggedInvoice>> getUpcomingInvoices(String userId, {int days = 7});
  Future<TaggedInvoice?> getTaggedInvoiceById(String invoiceId);
  
  // Search and filter methods
  Future<List<TaggedInvoice>> searchTaggedInvoices(String userId, String query);
  Future<List<TaggedInvoice>> filterInvoicesByPriority(String userId, InvoicePriority priority);
  Future<List<TaggedInvoice>> filterInvoicesByDateRange(String userId, DateTime start, DateTime end);
  
  // Payment methods
  Future<PaymentResult> payInvoice(String invoiceId, PaymentDetails paymentDetails);
  Future<PaymentResult> processPartialPayment(String invoiceId, PaymentDetails paymentDetails);
  Future<bool> requestPaymentExtension(String invoiceId, DateTime newDueDate, String? reason);
  Future<bool> disputeInvoice(String invoiceId, String reason);
  
  // Payment tracking
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId);
  Future<Map<String, dynamic>> getPaymentStatistics(String userId);
  Future<List<Map<String, dynamic>>> getRecentTransactions(String userId, {int limit = 20});
  
  // Notification methods
  Future<bool> markInvoiceAsViewed(String invoiceId);
  Future<bool> setPaymentReminder(String invoiceId, DateTime reminderDate);
  Future<bool> requestInvoiceDetails(String invoiceId);
  
  // User account methods
  Future<Map<String, dynamic>> getUserAccountBalance(String userId);
  Future<List<Map<String, dynamic>>> getUserPaymentMethods(String userId);
  Future<bool> addPaymentMethod(String userId, Map<String, dynamic> paymentMethodData);
  Future<bool> removePaymentMethod(String userId, String paymentMethodId);
} 