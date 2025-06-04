import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';
import 'pay_invoice_state.dart';

class PayInvoiceCubit extends Cubit<PayInvoiceState> {
  final PayInvoiceRepository repository;
  final String currentUserId = 'current_user_123'; // Mock current user ID

  PayInvoiceCubit({required this.repository}) : super(PayInvoiceInitial());

  // Load all tagged invoices for the current user
  Future<void> loadTaggedInvoices() async {
    try {
      emit(PayInvoiceLoading());
      final invoices = await repository.getTaggedInvoices(currentUserId);
      emit(PayInvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
    }
  }

  // Load invoices by status
  Future<void> loadInvoicesByStatus(PaymentStatus status) async {
    try {
      emit(PayInvoiceLoading());
      final invoices = await repository.getTaggedInvoicesByStatus(currentUserId, status);
      emit(PayInvoicesLoaded(invoices: invoices, statusFilter: status));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load invoices by status: ${e.toString()}'));
    }
  }

  // Load overdue invoices
  Future<void> loadOverdueInvoices() async {
    try {
      emit(PayInvoiceLoading());
      final invoices = await repository.getOverdueInvoices(currentUserId);
      emit(PayInvoicesLoaded(
        invoices: invoices,
        statusFilter: PaymentStatus.pending, // Overdue are pending status
      ));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load overdue invoices: ${e.toString()}'));
    }
  }

  // Load upcoming invoices
  Future<void> loadUpcomingInvoices({int days = 7}) async {
    try {
      emit(PayInvoiceLoading());
      final invoices = await repository.getUpcomingInvoices(currentUserId, days: days);
      emit(PayInvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load upcoming invoices: ${e.toString()}'));
    }
  }

  // Search invoices
  Future<void> searchInvoices(String query) async {
    try {
      emit(PayInvoiceLoading());
      if (query.trim().isEmpty) {
        await loadTaggedInvoices();
        return;
      }
      
      final invoices = await repository.searchTaggedInvoices(currentUserId, query);
      emit(PayInvoicesLoaded(invoices: invoices, searchQuery: query));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to search invoices: ${e.toString()}'));
    }
  }

  // Filter invoices by priority
  Future<void> filterInvoicesByPriority(InvoicePriority priority) async {
    try {
      emit(PayInvoiceLoading());
      final invoices = await repository.filterInvoicesByPriority(currentUserId, priority);
      emit(PayInvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to filter invoices by priority: ${e.toString()}'));
    }
  }

  // Load invoice details
  Future<void> loadInvoiceDetails(String invoiceId) async {
    try {
      emit(PayInvoiceLoading());
      final invoice = await repository.getTaggedInvoiceById(invoiceId);
      if (invoice != null) {
        emit(PayInvoiceDetailsLoaded(invoice: invoice));
        // Mark as viewed
        await repository.markInvoiceAsViewed(invoiceId);
      } else {
        emit(PayInvoiceError(message: 'Invoice not found'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load invoice details: ${e.toString()}'));
    }
  }

  // Pay invoice
  Future<void> payInvoice(String invoiceId, PaymentDetails paymentDetails) async {
    try {
      // First load the invoice to get details
      final invoice = await repository.getTaggedInvoiceById(invoiceId);
      if (invoice == null) {
        emit(PayInvoicePaymentFailure(
          errorMessage: 'Invoice not found',
          invoiceId: invoiceId,
        ));
        return;
      }

      emit(PayInvoicePaymentProcessing(
        invoiceId: invoiceId,
        paymentMethod: paymentDetails.method,
        amount: paymentDetails.amount,
      ));

      final result = await repository.payInvoice(invoiceId, paymentDetails);

      if (result.success) {
        // Load updated invoice
        final updatedInvoice = await repository.getTaggedInvoiceById(invoiceId);
        emit(PayInvoicePaymentSuccess(
          paymentResult: result,
          invoice: updatedInvoice ?? invoice,
          message: 'Payment completed successfully!',
        ));
      } else {
        emit(PayInvoicePaymentFailure(
          errorMessage: result.errorMessage ?? 'Payment failed',
          invoiceId: invoiceId,
        ));
      }
    } catch (e) {
      emit(PayInvoicePaymentFailure(
        errorMessage: 'An error occurred during payment: ${e.toString()}',
        invoiceId: invoiceId,
      ));
    }
  }

  // Process partial payment
  Future<void> processPartialPayment(String invoiceId, PaymentDetails paymentDetails) async {
    try {
      emit(PayInvoicePaymentProcessing(
        invoiceId: invoiceId,
        paymentMethod: paymentDetails.method,
        amount: paymentDetails.amount,
      ));

      final result = await repository.processPartialPayment(invoiceId, paymentDetails);

      if (result.success) {
        final invoice = await repository.getTaggedInvoiceById(invoiceId);
        emit(PayInvoicePaymentSuccess(
          paymentResult: result,
          invoice: invoice!,
          message: 'Partial payment processed successfully!',
        ));
      } else {
        emit(PayInvoicePaymentFailure(
          errorMessage: result.errorMessage ?? 'Partial payment failed',
          invoiceId: invoiceId,
        ));
      }
    } catch (e) {
      emit(PayInvoicePaymentFailure(
        errorMessage: 'An error occurred during partial payment: ${e.toString()}',
        invoiceId: invoiceId,
      ));
    }
  }

  // Request payment extension
  Future<void> requestPaymentExtension(String invoiceId, DateTime newDueDate, String? reason) async {
    try {
      final success = await repository.requestPaymentExtension(invoiceId, newDueDate, reason);
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Payment extension request submitted successfully',
          operationType: 'extension_request',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to submit payment extension request'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Error submitting extension request: ${e.toString()}'));
    }
  }

  // Dispute invoice
  Future<void> disputeInvoice(String invoiceId, String reason) async {
    try {
      final success = await repository.disputeInvoice(invoiceId, reason);
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Invoice dispute submitted successfully',
          operationType: 'dispute',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to submit invoice dispute'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Error submitting dispute: ${e.toString()}'));
    }
  }

  // Load payment statistics
  Future<void> loadPaymentStatistics() async {
    try {
      final statistics = await repository.getPaymentStatistics(currentUserId);
      emit(PayInvoiceStatisticsLoaded(statistics: statistics));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load payment statistics: ${e.toString()}'));
    }
  }

  // Load user account balance
  Future<void> loadAccountBalance() async {
    try {
      final accountBalance = await repository.getUserAccountBalance(currentUserId);
      emit(PayInvoiceAccountBalanceLoaded(accountBalance: accountBalance));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load account balance: ${e.toString()}'));
    }
  }

  // Load user payment methods
  Future<void> loadPaymentMethods() async {
    try {
      final paymentMethods = await repository.getUserPaymentMethods(currentUserId);
      emit(PayInvoicePaymentMethodsLoaded(paymentMethods: paymentMethods));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load payment methods: ${e.toString()}'));
    }
  }

  // Load recent transactions
  Future<void> loadRecentTransactions({int limit = 20}) async {
    try {
      final transactions = await repository.getRecentTransactions(currentUserId, limit: limit);
      emit(PayInvoiceRecentTransactionsLoaded(transactions: transactions));
    } catch (e) {
      emit(PayInvoiceError(message: 'Failed to load recent transactions: ${e.toString()}'));
    }
  }

  // Set payment reminder
  Future<void> setPaymentReminder(String invoiceId, DateTime reminderDate) async {
    try {
      final success = await repository.setPaymentReminder(invoiceId, reminderDate);
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Payment reminder set successfully',
          operationType: 'reminder',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to set payment reminder'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Error setting reminder: ${e.toString()}'));
    }
  }

  // Request invoice details
  Future<void> requestInvoiceDetails(String invoiceId) async {
    try {
      final success = await repository.requestInvoiceDetails(invoiceId);
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Invoice details request sent successfully',
          operationType: 'details_request',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to request invoice details'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Error requesting details: ${e.toString()}'));
    }
  }

  // Add payment method
  Future<void> addPaymentMethod(Map<String, dynamic> paymentMethodData) async {
    try {
      final success = await repository.addPaymentMethod(currentUserId, paymentMethodData);
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Payment method added successfully',
          operationType: 'add_payment_method',
        ));
        // Reload payment methods
        await loadPaymentMethods();
      } else {
        emit(PayInvoiceError(message: 'Failed to add payment method'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Error adding payment method: ${e.toString()}'));
    }
  }

  // Remove payment method
  Future<void> removePaymentMethod(String paymentMethodId) async {
    try {
      final success = await repository.removePaymentMethod(currentUserId, paymentMethodId);
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Payment method removed successfully',
          operationType: 'remove_payment_method',
        ));
        // Reload payment methods
        await loadPaymentMethods();
      } else {
        emit(PayInvoiceError(message: 'Failed to remove payment method'));
      }
    } catch (e) {
      emit(PayInvoiceError(message: 'Error removing payment method: ${e.toString()}'));
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await loadTaggedInvoices();
  }

  // Clear state
  void clearState() {
    emit(PayInvoiceInitial());
  }

  // Clear errors and go back to loaded state
  void clearError() {
    if (state is PayInvoiceError || state is PayInvoicePaymentFailure) {
      loadTaggedInvoices();
    }
  }
} 