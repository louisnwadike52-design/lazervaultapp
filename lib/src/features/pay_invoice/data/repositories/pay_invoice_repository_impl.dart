import 'dart:math';

import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';
import '../datasources/pay_invoice_local_datasource.dart';

class PayInvoiceRepositoryImpl implements PayInvoiceRepository {
  final PayInvoiceLocalDataSource localDataSource;

  PayInvoiceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TaggedInvoice>> getTaggedInvoices(String userId) async {
    final models = await localDataSource.getTaggedInvoices(userId);
    return models.cast<TaggedInvoice>();
  }

  @override
  Future<List<TaggedInvoice>> getTaggedInvoicesByStatus(String userId, PaymentStatus status) async {
    final models = await localDataSource.getTaggedInvoicesByStatus(userId, status);
    return models.cast<TaggedInvoice>();
  }

  @override
  Future<List<TaggedInvoice>> getOverdueInvoices(String userId) async {
    final allInvoices = await getTaggedInvoices(userId);
    return allInvoices.where((invoice) => invoice.isOverdue && invoice.paymentStatus != PaymentStatus.completed).toList();
  }

  @override
  Future<List<TaggedInvoice>> getUpcomingInvoices(String userId, {int days = 7}) async {
    final allInvoices = await getTaggedInvoices(userId);
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: days));
    
    return allInvoices.where((invoice) {
      if (invoice.dueDate == null || invoice.paymentStatus == PaymentStatus.completed) return false;
      return invoice.dueDate!.isAfter(now) && invoice.dueDate!.isBefore(futureDate);
    }).toList();
  }

  @override
  Future<TaggedInvoice?> getTaggedInvoiceById(String invoiceId) async {
    final model = await localDataSource.getTaggedInvoiceById(invoiceId);
    return model;
  }

  @override
  Future<List<TaggedInvoice>> searchTaggedInvoices(String userId, String query) async {
    final allInvoices = await getTaggedInvoices(userId);
    final lowerQuery = query.toLowerCase();
    
    return allInvoices.where((invoice) {
      return invoice.title.toLowerCase().contains(lowerQuery) ||
             invoice.description.toLowerCase().contains(lowerQuery) ||
             invoice.fromUserName.toLowerCase().contains(lowerQuery) ||
             invoice.fromCompanyName?.toLowerCase().contains(lowerQuery) == true ||
             invoice.invoiceNumber.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<TaggedInvoice>> filterInvoicesByPriority(String userId, InvoicePriority priority) async {
    final allInvoices = await getTaggedInvoices(userId);
    return allInvoices.where((invoice) => invoice.priority == priority).toList();
  }

  @override
  Future<List<TaggedInvoice>> filterInvoicesByDateRange(String userId, DateTime start, DateTime end) async {
    final allInvoices = await getTaggedInvoices(userId);
    return allInvoices.where((invoice) {
      return invoice.createdAt.isAfter(start) && invoice.createdAt.isBefore(end);
    }).toList();
  }

  @override
  Future<PaymentResult> payInvoice(String invoiceId, PaymentDetails paymentDetails) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate payment processing
    
    try {
      // Simulate payment processing logic
      final success = _simulatePaymentProcessing(paymentDetails);
      
      if (success) {
        // Update invoice status to completed
        await localDataSource.updateInvoiceStatus(invoiceId, PaymentStatus.completed);
        
        return PaymentResult(
          success: true,
          transactionId: _generateTransactionId(),
          paymentReference: _generatePaymentReference(),
          status: PaymentStatus.completed,
          processedAt: DateTime.now(),
        );
      } else {
        return PaymentResult(
          success: false,
          errorMessage: 'Payment processing failed. Please try again.',
          status: PaymentStatus.failed,
          processedAt: DateTime.now(),
        );
      }
    } catch (e) {
      return PaymentResult(
        success: false,
        errorMessage: 'An error occurred during payment processing: ${e.toString()}',
        status: PaymentStatus.failed,
        processedAt: DateTime.now(),
      );
    }
  }

  @override
  Future<PaymentResult> processPartialPayment(String invoiceId, PaymentDetails paymentDetails) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate processing
    
    // For now, we don't support partial payments in the mock implementation
    return PaymentResult(
      success: false,
      errorMessage: 'Partial payments are not currently supported',
      status: PaymentStatus.failed,
      processedAt: DateTime.now(),
    );
  }

  @override
  Future<bool> requestPaymentExtension(String invoiceId, DateTime newDueDate, String? reason) async {
    await Future.delayed(Duration(milliseconds: 500));
    
    // Simulate extension request processing
    // In a real app, this would send a request to the invoice sender
    final random = Random();
    return random.nextBool(); // 50% chance of approval for simulation
  }

  @override
  Future<bool> disputeInvoice(String invoiceId, String reason) async {
    await Future.delayed(Duration(milliseconds: 800));
    
    // Simulate dispute submission
    // In a real app, this would create a dispute record and notify relevant parties
    return true; // Always successful for simulation
  }

  @override
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId) async {
    return await localDataSource.getPaymentHistory(invoiceId);
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics(String userId) async {
    final invoices = await getTaggedInvoices(userId);
    
    final totalInvoices = invoices.length;
    final paidInvoices = invoices.where((i) => i.paymentStatus == PaymentStatus.completed).length;
    final pendingInvoices = invoices.where((i) => i.paymentStatus == PaymentStatus.pending).length;
    final overdueInvoices = invoices.where((i) => i.isOverdue && i.paymentStatus != PaymentStatus.completed).length;
    
    final totalAmount = invoices.fold<double>(0, (sum, invoice) => sum + invoice.totalAmount);
    final paidAmount = invoices
        .where((i) => i.paymentStatus == PaymentStatus.completed)
        .fold<double>(0, (sum, invoice) => sum + invoice.totalAmount);
    final pendingAmount = invoices
        .where((i) => i.paymentStatus == PaymentStatus.pending)
        .fold<double>(0, (sum, invoice) => sum + invoice.totalAmount);

    return {
      'total_invoices': totalInvoices,
      'paid_invoices': paidInvoices,
      'pending_invoices': pendingInvoices,
      'overdue_invoices': overdueInvoices,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'pending_amount': pendingAmount,
      'payment_rate': totalInvoices > 0 ? (paidInvoices / totalInvoices) * 100 : 0,
      'average_payment_time': _calculateAveragePaymentTime(invoices),
    };
  }

  @override
  Future<List<Map<String, dynamic>>> getRecentTransactions(String userId, {int limit = 20}) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    // Generate mock recent transactions
    final transactions = <Map<String, dynamic>>[];
    final random = Random();
    
    for (int i = 0; i < min(limit, 10); i++) {
      transactions.add({
        'id': 'txn_${random.nextInt(999999)}',
        'type': 'invoice_payment',
        'amount': (random.nextDouble() * 2000 + 100).toDouble(),
        'currency': 'GBP',
        'status': 'completed',
        'date': DateTime.now().subtract(Duration(days: random.nextInt(30))).toIso8601String(),
        'description': 'Invoice payment',
        'reference': _generatePaymentReference(),
      });
    }
    
    return transactions;
  }

  @override
  Future<bool> markInvoiceAsViewed(String invoiceId) async {
    await Future.delayed(Duration(milliseconds: 200));
    // In a real app, this would update the invoice's view status
    return true;
  }

  @override
  Future<bool> setPaymentReminder(String invoiceId, DateTime reminderDate) async {
    await Future.delayed(Duration(milliseconds: 300));
    // In a real app, this would schedule a notification
    return true;
  }

  @override
  Future<bool> requestInvoiceDetails(String invoiceId) async {
    await Future.delayed(Duration(milliseconds: 400));
    // In a real app, this would send a request for more invoice details
    return true;
  }

  @override
  Future<Map<String, dynamic>> getUserAccountBalance(String userId) async {
    return await localDataSource.getUserAccountBalance(userId);
  }

  @override
  Future<List<Map<String, dynamic>>> getUserPaymentMethods(String userId) async {
    return await localDataSource.getUserPaymentMethods(userId);
  }

  @override
  Future<bool> addPaymentMethod(String userId, Map<String, dynamic> paymentMethodData) async {
    await Future.delayed(Duration(milliseconds: 800));
    // In a real app, this would add the payment method to the user's account
    return true;
  }

  @override
  Future<bool> removePaymentMethod(String userId, String paymentMethodId) async {
    await Future.delayed(Duration(milliseconds: 500));
    // In a real app, this would remove the payment method from the user's account
    return true;
  }

  // Private helper methods
  bool _simulatePaymentProcessing(PaymentDetails paymentDetails) {
    final random = Random();
    
    // Simulate different success rates for different payment methods
    switch (paymentDetails.method) {
      case PaymentMethod.accountBalance:
        return random.nextDouble() > 0.05; // 95% success rate
      case PaymentMethod.creditCard:
      case PaymentMethod.debitCard:
        return random.nextDouble() > 0.1; // 90% success rate
      case PaymentMethod.paypal:
        return random.nextDouble() > 0.08; // 92% success rate
      case PaymentMethod.applePay:
      case PaymentMethod.googlePay:
        return random.nextDouble() > 0.03; // 97% success rate
      case PaymentMethod.bitcoin:
      case PaymentMethod.ethereum:
      case PaymentMethod.usdc:
        return random.nextDouble() > 0.15; // 85% success rate
      case PaymentMethod.bankTransfer:
        return random.nextDouble() > 0.02; // 98% success rate
    }
  }

  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return 'TXN-$timestamp-$random';
  }

  String _generatePaymentReference() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return 'PAY-$timestamp-$random';
  }

  double _calculateAveragePaymentTime(List<TaggedInvoice> invoices) {
    final paidInvoices = invoices.where((i) => i.paymentStatus == PaymentStatus.completed && i.paidAt != null);
    
    if (paidInvoices.isEmpty) return 0.0;
    
    final totalDays = paidInvoices.fold<int>(0, (sum, invoice) {
      final daysToPay = invoice.paidAt!.difference(invoice.createdAt).inDays;
      return sum + daysToPay;
    });
    
    return totalDays / paidInvoices.length;
  }
} 