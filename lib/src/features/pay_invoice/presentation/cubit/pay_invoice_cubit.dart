import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';
import 'pay_invoice_state.dart';

class PayInvoiceCubit extends Cubit<PayInvoiceState> {
  final PayInvoiceRepository repository;

  // Current user ID - set from authentication state
  String? _currentUserId;
  String? get currentUserId => _currentUserId;

  /// Set the current user ID from authentication state
  void setUserId(String userId) {
    _currentUserId = userId;
    // Automatically load invoices when user ID is set
    loadTaggedInvoices();
  }

  PayInvoiceCubit({required this.repository}) : super(PayInvoiceInitial());

  // Load all tagged invoices for the current user
  Future<void> loadTaggedInvoices() async {
    try {
      if (isClosed) return;

      // Check if user is authenticated
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      emit(PayInvoiceLoading());
      final invoices = await repository.getTaggedInvoices(currentUserId!);
      if (isClosed) return;
      emit(PayInvoicesLoaded(invoices: invoices));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
    }
  }

  // Load invoices by status
  Future<void> loadInvoicesByStatus(PaymentStatus status) async {
    try {
      if (isClosed) return;
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      emit(PayInvoiceLoading());
      final invoices = await repository.getTaggedInvoicesByStatus(currentUserId!, status);
      if (isClosed) return;
      emit(PayInvoicesLoaded(invoices: invoices, statusFilter: status));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load invoices by status: ${e.toString()}'));
    }
  }

  // Load overdue invoices
  Future<void> loadOverdueInvoices() async {
    try {
      if (isClosed) return;
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      emit(PayInvoiceLoading());
      final invoices = await repository.getOverdueInvoices(currentUserId!);
      if (isClosed) return;
      emit(PayInvoicesLoaded(
        invoices: invoices,
        statusFilter: PaymentStatus.pending, // Overdue are pending status
      ));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load overdue invoices: ${e.toString()}'));
    }
  }

  // Load upcoming invoices
  Future<void> loadUpcomingInvoices({int days = 7}) async {
    try {
      if (isClosed) return;
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      emit(PayInvoiceLoading());
      final invoices = await repository.getUpcomingInvoices(currentUserId!, days: days);
      if (isClosed) return;
      emit(PayInvoicesLoaded(invoices: invoices));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load upcoming invoices: ${e.toString()}'));
    }
  }

  // Search invoices
  Future<void> searchInvoices(String query) async {
    try {
      if (isClosed) return;
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      emit(PayInvoiceLoading());
      if (query.trim().isEmpty) {
        await loadTaggedInvoices();
        return;
      }

      final invoices = await repository.searchTaggedInvoices(currentUserId!, query);
      if (isClosed) return;
      emit(PayInvoicesLoaded(invoices: invoices, searchQuery: query));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to search invoices: ${e.toString()}'));
    }
  }

  // Filter invoices by priority
  Future<void> filterInvoicesByPriority(InvoicePriority priority) async {
    try {
      if (isClosed) return;
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      emit(PayInvoiceLoading());
      final invoices = await repository.filterInvoicesByPriority(currentUserId!, priority);
      if (isClosed) return;
      emit(PayInvoicesLoaded(invoices: invoices));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to filter invoices by priority: ${e.toString()}'));
    }
  }

  // Load invoice details
  Future<void> loadInvoiceDetails(String invoiceId) async {
    try {
      if (isClosed) return;
      emit(PayInvoiceLoading());
      final invoice = await repository.getTaggedInvoiceById(invoiceId);
      if (isClosed) return;
      if (invoice != null) {
        emit(PayInvoiceDetailsLoaded(invoice: invoice));
        // Mark as viewed
        await repository.markInvoiceAsViewed(invoiceId);
      } else {
        emit(PayInvoiceError(message: 'Invoice not found'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load invoice details: ${e.toString()}'));
    }
  }

  // Pay invoice
  Future<void> payInvoice(String invoiceId, PaymentDetails paymentDetails) async {
    try {
      // First load the invoice to get details
      final invoice = await repository.getTaggedInvoiceById(invoiceId);
      if (isClosed) return;
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
      if (isClosed) return;

      if (result.success) {
        // Load updated invoice
        final updatedInvoice = await repository.getTaggedInvoiceById(invoiceId);
        if (isClosed) return;
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
      if (isClosed) return;
      emit(PayInvoicePaymentFailure(
        errorMessage: 'An error occurred during payment: ${e.toString()}',
        invoiceId: invoiceId,
      ));
    }
  }

  // Process partial payment
  Future<void> processPartialPayment(String invoiceId, PaymentDetails paymentDetails) async {
    try {
      if (isClosed) return;
      emit(PayInvoicePaymentProcessing(
        invoiceId: invoiceId,
        paymentMethod: paymentDetails.method,
        amount: paymentDetails.amount,
      ));

      final result = await repository.processPartialPayment(invoiceId, paymentDetails);
      if (isClosed) return;

      if (result.success) {
        final invoice = await repository.getTaggedInvoiceById(invoiceId);
        if (isClosed) return;
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
      if (isClosed) return;
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
      if (isClosed) return;
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Payment extension request submitted successfully',
          operationType: 'extension_request',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to submit payment extension request'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Error submitting extension request: ${e.toString()}'));
    }
  }

  // Dispute invoice
  Future<void> disputeInvoice(String invoiceId, String reason) async {
    try {
      final success = await repository.disputeInvoice(invoiceId, reason);
      if (isClosed) return;
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Invoice dispute submitted successfully',
          operationType: 'dispute',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to submit invoice dispute'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Error submitting dispute: ${e.toString()}'));
    }
  }

  // Load payment statistics
  Future<void> loadPaymentStatistics() async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      final statistics = await repository.getPaymentStatistics(currentUserId!);
      if (isClosed) return;
      emit(PayInvoiceStatisticsLoaded(statistics: statistics));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load payment statistics: ${e.toString()}'));
    }
  }

  // Load user account balance
  Future<void> loadAccountBalance() async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      final accountBalance = await repository.getUserAccountBalance(currentUserId!);
      if (isClosed) return;
      emit(PayInvoiceAccountBalanceLoaded(accountBalance: accountBalance));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load account balance: ${e.toString()}'));
    }
  }

  // Load user payment methods
  Future<void> loadPaymentMethods() async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      final paymentMethods = await repository.getUserPaymentMethods(currentUserId!);
      if (isClosed) return;
      emit(PayInvoicePaymentMethodsLoaded(paymentMethods: paymentMethods));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load payment methods: ${e.toString()}'));
    }
  }

  // Load recent transactions
  Future<void> loadRecentTransactions({int limit = 20}) async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      final transactions = await repository.getRecentTransactions(currentUserId!, limit: limit);
      if (isClosed) return;
      emit(PayInvoiceRecentTransactionsLoaded(transactions: transactions));
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Failed to load recent transactions: ${e.toString()}'));
    }
  }

  // Set payment reminder
  Future<void> setPaymentReminder(String invoiceId, DateTime reminderDate) async {
    try {
      final success = await repository.setPaymentReminder(invoiceId, reminderDate);
      if (isClosed) return;
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Payment reminder set successfully',
          operationType: 'reminder',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to set payment reminder'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Error setting reminder: ${e.toString()}'));
    }
  }

  // Request invoice details
  Future<void> requestInvoiceDetails(String invoiceId) async {
    try {
      final success = await repository.requestInvoiceDetails(invoiceId);
      if (isClosed) return;
      if (success) {
        emit(PayInvoiceOperationSuccess(
          message: 'Invoice details request sent successfully',
          operationType: 'details_request',
        ));
      } else {
        emit(PayInvoiceError(message: 'Failed to request invoice details'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Error requesting details: ${e.toString()}'));
    }
  }

  // Add payment method
  Future<void> addPaymentMethod(Map<String, dynamic> paymentMethodData) async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      final success = await repository.addPaymentMethod(currentUserId!, paymentMethodData);
      if (isClosed) return;
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
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Error adding payment method: ${e.toString()}'));
    }
  }

  // Remove payment method
  Future<void> removePaymentMethod(String paymentMethodId) async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const PayInvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }
      final success = await repository.removePaymentMethod(currentUserId!, paymentMethodId);
      if (isClosed) return;
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
      if (isClosed) return;
      emit(PayInvoiceError(message: 'Error removing payment method: ${e.toString()}'));
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await loadTaggedInvoices();
  }

  // Clear state
  void clearState() {
    if (isClosed) return;
    emit(PayInvoiceInitial());
  }

  // Clear errors and go back to loaded state
  void clearError() {
    if (state is PayInvoiceError || state is PayInvoicePaymentFailure) {
      loadTaggedInvoices();
    }
  }
} 