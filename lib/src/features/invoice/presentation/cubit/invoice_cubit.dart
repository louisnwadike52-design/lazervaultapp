import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../../../../core/offline/mutation_queue.dart';
import '../../../../../core/offline/mutation.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepository repository;
  final SWRCacheManager? cacheManager;
  final MutationQueue? mutationQueue;

  static const int defaultPageSize = 20;

  StreamSubscription<SWRResult<List<Invoice>>>? _cacheSubscription;

  // Current user ID - set from authentication state
  String? _currentUserId;
  String? get currentUserId => _currentUserId;

  /// Set the current user ID from authentication state
  void setUserId(String userId) {
    _currentUserId = userId;
    // Automatically load invoices when user ID is set
    loadInvoices();
  }

  InvoiceCubit({
    required this.repository,
    this.cacheManager,
    this.mutationQueue,
  }) : super(InvoiceInitial());

  @override
  Future<void> close() {
    _cacheSubscription?.cancel();
    return super.close();
  }

  String _getCacheKey({String? status}) {
    return 'invoices:${_currentUserId ?? 'unknown'}:${status ?? 'all'}';
  }

  /// Check if an error is a network-related error that should trigger offline queuing
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  // Load all invoices with statistics (legacy, loads all at once)
  Future<void> loadInvoices({
    List<String>? statusFilter,
  }) async {
    try {
      // Check if user is authenticated
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const InvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      if (isClosed) return;
      emit(InvoiceLoading());

      // Load all invoices from gRPC repository
      final invoices = await repository.getAllInvoices();
      if (isClosed) return;
      final statistics = await repository.getInvoiceStatistics(currentUserId!);
      if (isClosed) return;

      // Apply client-side filtering if statusFilter is provided
      List<Invoice> filteredInvoices = invoices;
      if (statusFilter != null && statusFilter.isNotEmpty) {
        filteredInvoices = invoices.where((invoice) {
          return statusFilter.contains(invoice.status.name);
        }).toList();
      }

      emit(InvoicesLoaded(
        invoices: filteredInvoices,
        statistics: statistics,
        totalCount: filteredInvoices.length,
        totalPages: 1,
        currentPage: 1,
        pageSize: filteredInvoices.length,
        hasNext: false,
        hasPrevious: false,
      ));
    } catch (e) {
      if (isClosed) return;
      // Check if error is due to service being unavailable
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('unimplemented') ||
          errorMessage.contains('unavailable') ||
          errorMessage.contains('service') ||
          errorMessage.contains('not found')) {
        // Service not yet implemented - show empty state
        emit(InvoicesLoaded(
          invoices: [],
          statistics: {
            'total_invoices': 0,
            'paid_invoices': 0,
            'unpaid_invoices': 0,
            'total_amount': 0.0,
            'total_paid': 0.0,
            'total_unpaid': 0.0,
          },
        ));
      } else {
        emit(InvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
      }
    }
  }

  /// Load invoices page-based (server-side pagination + filtering)
  Future<void> loadInvoicesPage({
    int page = 1,
    int pageSize = defaultPageSize,
    String? statusFilter,
  }) async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const InvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      if (isClosed) return;
      emit(InvoiceLoading());

      final result = await repository.getSentInvoicesPaginated(
        page: page,
        pageSize: pageSize,
        status: statusFilter,
      );
      if (isClosed) return;

      final statistics = await repository.getInvoiceStatistics(currentUserId!);
      if (isClosed) return;

      emit(InvoicesLoaded(
        invoices: result.invoices,
        statistics: statistics,
        currentPage: result.currentPage,
        totalPages: result.totalPages,
        totalCount: result.totalCount,
        pageSize: result.pageSize,
        hasNext: result.hasNext,
        hasPrevious: result.hasPrevious,
        currentFilter: statusFilter,
      ));
    } catch (e) {
      if (isClosed) return;
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('unimplemented') ||
          errorMessage.contains('unavailable') ||
          errorMessage.contains('service') ||
          errorMessage.contains('not found')) {
        emit(InvoicesLoaded(
          invoices: [],
          statistics: {
            'total_invoices': 0,
            'paid_invoices': 0,
            'unpaid_invoices': 0,
            'total_amount': 0.0,
            'total_paid': 0.0,
            'total_unpaid': 0.0,
          },
        ));
      } else {
        emit(InvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
      }
    }
  }

  /// Navigate to a specific page
  Future<void> goToPage(int page) async {
    String? currentFilter;
    int currentPageSize = defaultPageSize;
    if (state is InvoicesLoaded) {
      final loaded = state as InvoicesLoaded;
      currentFilter = loaded.currentFilter;
      currentPageSize = loaded.pageSize;
    }
    await loadInvoicesPage(page: page, pageSize: currentPageSize, statusFilter: currentFilter);
  }

  /// Navigate to next page
  Future<void> nextPage() async {
    if (state is InvoicesLoaded) {
      final loaded = state as InvoicesLoaded;
      if (loaded.hasNext) {
        await goToPage(loaded.currentPage + 1);
      }
    }
  }

  /// Navigate to previous page
  Future<void> previousPage() async {
    if (state is InvoicesLoaded) {
      final loaded = state as InvoicesLoaded;
      if (loaded.hasPrevious) {
        await goToPage(loaded.currentPage - 1);
      }
    }
  }

  // Search invoices
  Future<void> searchInvoices({
    required String query,
  }) async {
    try {
      if (isClosed) return;
      emit(InvoiceLoading());

      // Search using gRPC repository
      final results = await repository.searchInvoices(query);
      if (isClosed) return;

      emit(InvoiceSearchResults(
        results: results,
        query: query,
      ));
    } catch (e) {
      if (isClosed) return;
      // Check if error is due to service being unavailable
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('unimplemented') ||
          errorMessage.contains('unavailable') ||
          errorMessage.contains('service') ||
          errorMessage.contains('not found')) {
        // Service not yet implemented - show empty results
        emit(InvoiceSearchResults(
          results: [],
          query: query,
        ));
      } else {
        emit(InvoiceError(message: 'Search failed: ${e.toString()}'));
      }
    }
  }

  // Apply status filter
  Future<void> applyStatusFilter(List<String> statuses) async {
    await loadInvoices(statusFilter: statuses);
  }

  // Clear filters
  Future<void> clearFilters() async {
    await loadInvoices();
  }

  // Load specific invoice details
  Future<void> loadInvoiceDetails(String invoiceId) async {
    try {
      if (isClosed) return;
      emit(InvoiceLoading());

      final invoice = await repository.getInvoiceById(invoiceId);
      if (isClosed) return;
      if (invoice == null) {
        emit(InvoiceError(message: 'Invoice not found'));
        return;
      }

      // Try to load payment history, but don't fail if not implemented
      List<Map<String, dynamic>> paymentHistory = [];
      try {
        paymentHistory = await repository.getPaymentHistory(invoiceId);
        if (isClosed) return;
      } catch (e) {
        // Payment history not available or not implemented - that's okay
        print('Payment history not available: $e');
      }

      emit(InvoiceDetailsLoaded(
        invoice: invoice,
        paymentHistory: paymentHistory,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to load invoice details: ${e.toString()}'));
    }
  }

  // Create new invoice
  Future<void> createInvoice({
    required String title,
    required String description,
    required List<InvoiceItem> items,
    required InvoiceType type,
    String? toEmail,
    String? toName,
    DateTime? dueDate,
    double? taxAmount,
    double? discountAmount,
    String? notes,
    bool sendImmediately = false,
    AddressDetails? recipientDetails,
    AddressDetails? payerDetails,
    String currency = 'NGN',
    String? payerLogoUrl,
    String? recipientLogoUrl,
  }) async {
    // Store current form state to restore if error occurs
    final previousFormState = state is InvoiceFormState ? state as InvoiceFormState : null;

    try {
      // Check if user is authenticated
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const InvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      if (isClosed) return;
      emit(InvoiceLoading());

      final subtotal = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
      final finalTaxAmount = taxAmount ?? 0;
      final finalDiscountAmount = discountAmount ?? 0;
      final totalAmount = subtotal + finalTaxAmount - finalDiscountAmount;

      final invoice = Invoice(
        id: '', // Will be generated in repository
        title: title,
        description: description,
        amount: subtotal,
        currency: currency,
        status: sendImmediately ? InvoiceStatus.pending : InvoiceStatus.draft,
        type: type,
        createdAt: DateTime.now(),
        dueDate: dueDate,
        fromUserId: currentUserId!,
        toEmail: toEmail,
        toName: toName,
        items: items,
        taxAmount: finalTaxAmount,
        discountAmount: finalDiscountAmount,
        totalAmount: totalAmount,
        notes: notes,
        recipientDetails: recipientDetails,
        payerDetails: payerDetails,
        payerLogoUrl: payerLogoUrl,
        recipientLogoUrl: recipientLogoUrl,
      );

      final createdInvoice = await repository.createInvoice(invoice);
      if (isClosed) return;

      // Invalidate cache after successful creation
      cacheManager?.invalidatePattern('invoices:');

      emit(InvoiceOperationSuccess(
        message: sendImmediately ? 'Invoice created and sent successfully' : 'Invoice created as draft',
        invoice: createdInvoice,
      ));
    } catch (e) {
      if (isClosed) return;

      // Check if this is a network error and we can queue for offline retry
      if (_isNetworkError(e) && mutationQueue != null) {
        print('📴 [InvoiceCubit] Network error detected, queuing invoice creation for offline retry');
        try {
          final subtotal = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
          final finalTaxAmount = taxAmount ?? 0;
          final finalDiscountAmount = discountAmount ?? 0;
          final totalAmount = subtotal + finalTaxAmount - finalDiscountAmount;

          // Serialize items manually since InvoiceItem may not have toJson
          final itemsList = items.map((i) => {
            'description': i.description,
            'quantity': i.quantity,
            'unitPrice': i.unitPrice,
            'totalPrice': i.totalPrice,
          }).toList();

          final mutation = await mutationQueue!.enqueue(QueuedMutation.create(
            type: MutationType.invoiceCreation,
            payload: {
              'title': title,
              'description': description,
              'items': itemsList,
              'type': type.name,
              'toEmail': toEmail,
              'toName': toName,
              'dueDate': dueDate?.toIso8601String(),
              'taxAmount': taxAmount,
              'discountAmount': discountAmount,
              'notes': notes,
              'sendImmediately': sendImmediately,
              'currency': currency,
              'totalAmount': totalAmount,
            },
          ));
          emit(InvoiceCreationQueued(
            title: title,
            totalAmount: totalAmount,
            currency: currency,
            message: 'Invoice creation queued. Will retry when you\'re back online.',
            mutationId: mutation?.id,
          ));
          return;
        } catch (queueError) {
          print('❌ [InvoiceCubit] Failed to queue invoice creation: $queueError');
          // Fall through to emit regular error
        }
      }

      emit(InvoiceError(message: 'Failed to create invoice: ${e.toString()}'));
      // Restore form state so user can retry with updated data
      if (previousFormState != null) {
        emit(previousFormState);
      }
    }
  }

  // Update existing invoice
  Future<void> updateInvoice(Invoice invoice) async {
    // Store current form state to restore if error occurs
    final previousFormState = state is InvoiceFormState ? state as InvoiceFormState : null;

    try {
      if (isClosed) return;
      emit(InvoiceLoading());

      final updatedInvoice = await repository.updateInvoice(invoice);
      if (isClosed) return;

      emit(InvoiceOperationSuccess(
        message: 'Invoice updated successfully',
        invoice: updatedInvoice,
      ));

      await loadInvoices();
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to update invoice: ${e.toString()}'));
      // Restore form state so user can retry with updated data
      if (previousFormState != null) {
        emit(previousFormState);
      }
    }
  }

  // Send invoice (change status to pending)
  Future<void> sendInvoice(String invoiceId) async {
    try {
      final updatedInvoice = await repository.sendInvoice(invoiceId);
      if (isClosed) return;

      emit(InvoiceOperationSuccess(
        message: 'Invoice sent successfully',
        invoice: updatedInvoice,
      ));

      await loadInvoices();
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to send invoice: ${e.toString()}'));
    }
  }

  // Mark invoice as paid (with offline queue support)
  Future<void> markAsPaid(String invoiceId, PaymentMethod paymentMethod, [String? reference, String? pin, String? verificationToken]) async {
    try {
      if (isClosed) return;
      emit(InvoicePaymentProcessing(invoiceId: invoiceId));

      final updatedInvoice = await repository.markInvoiceAsPaid(
        invoiceId,
        paymentMethod,
        reference,
        pin: pin,
        verificationToken: verificationToken,
      );
      if (isClosed) return;

      // Invalidate cache after successful payment
      cacheManager?.invalidatePattern('invoices:');

      emit(InvoicePaymentSuccess(
        message: 'Invoice marked as paid successfully',
        invoice: updatedInvoice,
      ));
    } catch (e) {
      if (isClosed) return;

      // For financial operations, show clear error and let user retry manually
      // NEVER queue payments offline - security tokens expire, balances change
      if (_isNetworkError(e)) {
        emit(const InvoiceError(
          message: 'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(InvoiceError(message: 'Failed to mark invoice as paid: ${e.toString()}'));
      }
    }
  }

  // Unlock invoice (pay service fee)
  Future<void> unlockInvoice(String invoiceId, {String? accountId, String? verificationToken, String? transactionId}) async {
    try {
      if (isClosed) return;
      emit(InvoiceUnlockProcessing(invoiceId: invoiceId));

      final idempotencyKey = 'unlock-${invoiceId}-${const Uuid().v4().substring(0, 8)}';
      final invoice = await repository.unlockInvoice(
        invoiceId,
        accountId: accountId,
        verificationToken: verificationToken,
        transactionId: transactionId,
        idempotencyKey: idempotencyKey,
      );
      if (isClosed) return;

      emit(InvoiceUnlockSuccess(
        message: 'Invoice unlocked successfully',
        invoice: invoice,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to unlock invoice: ${e.toString()}'));
    }
  }

  // Cancel invoice
  Future<void> cancelInvoice(String invoiceId) async {
    try {
      final updatedInvoice = await repository.cancelInvoice(invoiceId);
      if (isClosed) return;

      emit(InvoiceOperationSuccess(
        message: 'Invoice cancelled successfully',
        invoice: updatedInvoice,
      ));

      await loadInvoices();
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to cancel invoice: ${e.toString()}'));
    }
  }

  // Delete invoice
  Future<void> deleteInvoice(String invoiceId) async {
    try {
      await repository.deleteInvoice(invoiceId);
      if (isClosed) return;

      emit(InvoiceOperationSuccess(message: 'Invoice deleted successfully'));

      await loadInvoices();
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to delete invoice: ${e.toString()}'));
    }
  }

  // Generate QR code for payment
  Future<void> generateQRCode(String invoiceId) async {
    try {
      final qrData = await repository.generateQRCode(invoiceId);
      if (isClosed) return;

      emit(QRCodeGenerated(
        qrData: qrData,
        invoiceId: invoiceId,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to generate QR code: ${e.toString()}'));
    }
  }

  // Share invoice
  Future<void> shareInvoice(String invoiceId, List<String> recipients) async {
    try {
      await repository.shareInvoice(invoiceId, recipients);
      if (isClosed) return;

      emit(InvoiceOperationSuccess(message: 'Invoice shared successfully'));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to share invoice: ${e.toString()}'));
    }
  }

  // Load invoices by status
  Future<void> loadInvoicesByStatus(InvoiceStatus status) async {
    try {
      if (isClosed) return;
      emit(InvoiceLoading());

      final invoices = await repository.getInvoicesByStatus(status);
      if (isClosed) return;

      emit(InvoicesLoaded(invoices: invoices));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
    }
  }

  // Load overdue invoices
  Future<void> loadOverdueInvoices() async {
    try {
      if (isClosed) return;
      emit(InvoiceLoading());

      final invoices = await repository.getOverdueInvoices();
      if (isClosed) return;

      emit(InvoicesLoaded(invoices: invoices));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to load overdue invoices: ${e.toString()}'));
    }
  }

  // Tag users to an invoice
  Future<void> tagUsers(String invoiceId, List<String> userIds) async {
    try {
      if (isClosed) return;
      emit(InvoiceLoading());

      final result = await repository.tagUsersToInvoice(invoiceId, userIds, [], []);
      if (isClosed) return;

      emit(InvoiceOperationSuccess(
        message: result.message,
      ));

      await loadInvoices();
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to tag users: ${e.toString()}'));
    }
  }

  // Load sent invoices (created by current user)
  Future<void> loadSentInvoices({List<String>? statusFilter}) async {
    await loadInvoices(statusFilter: statusFilter);
  }

  // Load invoice statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      if (currentUserId == null) return {};
      return await repository.getInvoiceStatistics(currentUserId!);
    } catch (e) {
      return {
        'total_invoices': 0,
        'paid_invoices': 0,
        'unpaid_invoices': 0,
        'total_amount': 0.0,
        'total_paid': 0.0,
        'total_unpaid': 0.0,
      };
    }
  }

  // Create invoice and tag users
  Future<void> createInvoiceWithTags({
    required String title,
    required String description,
    required List<InvoiceItem> items,
    required InvoiceType type,
    List<String> taggedUserIds = const [],
    String? toEmail,
    String? toName,
    DateTime? dueDate,
    double? taxAmount,
    double? discountAmount,
    String? notes,
    bool sendImmediately = false,
    AddressDetails? recipientDetails,
    AddressDetails? payerDetails,
    String currency = 'NGN',
  }) async {
    try {
      if (currentUserId == null) {
        if (isClosed) return;
        emit(const InvoiceError(message: 'User not authenticated. Please log in.'));
        return;
      }

      if (isClosed) return;
      emit(InvoiceLoading());

      final subtotal = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
      final finalTaxAmount = taxAmount ?? 0;
      final finalDiscountAmount = discountAmount ?? 0;
      final totalAmount = subtotal + finalTaxAmount - finalDiscountAmount;

      final invoice = Invoice(
        id: '',
        title: title,
        description: description,
        amount: subtotal,
        currency: currency,
        status: sendImmediately ? InvoiceStatus.pending : InvoiceStatus.draft,
        type: type,
        createdAt: DateTime.now(),
        dueDate: dueDate,
        fromUserId: currentUserId!,
        toEmail: toEmail,
        toName: toName,
        items: items,
        taxAmount: finalTaxAmount,
        discountAmount: finalDiscountAmount,
        totalAmount: totalAmount,
        notes: notes,
        recipientDetails: recipientDetails,
        payerDetails: payerDetails,
      );

      final createdInvoice = await repository.createInvoice(invoice);
      if (isClosed) return;

      // Tag users if any were selected
      if (taggedUserIds.isNotEmpty && createdInvoice.id.isNotEmpty) {
        try {
          await repository.tagUsersToInvoice(createdInvoice.id, taggedUserIds, [], []);
        } catch (e) {
          // Tagging failed but invoice was created - notify but don't fail
          print('Warning: Failed to tag users: $e');
        }
      }

      if (isClosed) return;
      emit(InvoiceOperationSuccess(
        message: sendImmediately ? 'Invoice created and sent successfully' : 'Invoice created as draft',
        invoice: createdInvoice,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InvoiceError(message: 'Failed to create invoice: ${e.toString()}'));
    }
  }

  // Initialize form for new invoice
  void initializeForm({Invoice? editingInvoice}) {
    if (isClosed) return;
    if (editingInvoice != null) {
      emit(InvoiceFormState(
        items: editingInvoice.items,
        isValid: editingInvoice.items.isNotEmpty,
      ));
    } else {
      emit(InvoiceFormState(
        items: [],
        isValid: false,
      ));
    }
  }

  // Generate unique item ID
  String generateItemId() {
    return 'item_${DateTime.now().millisecondsSinceEpoch}_${const Uuid().v4().substring(0, 8)}';
  }

  // Add item to form
  void addItem(InvoiceItem item) {
    if (isClosed) return;
    if (state is InvoiceFormState) {
      final currentState = state as InvoiceFormState;
      final updatedItems = [...currentState.items, item];
      emit(currentState.copyWith(
        items: updatedItems,
        isValid: updatedItems.isNotEmpty,
      ));
    }
  }

  // Update item in form by finding the item with matching ID
  void updateItem(InvoiceItem updatedItem) {
    if (isClosed) return;
    if (state is InvoiceFormState) {
      final currentState = state as InvoiceFormState;
      final updatedItems = currentState.items.map((item) {
        return item.id == updatedItem.id ? updatedItem : item;
      }).toList();
      emit(currentState.copyWith(
        items: updatedItems,
        isValid: updatedItems.isNotEmpty,
      ));
    }
  }

  // Remove item from form by ID
  void removeItem(String itemId) {
    if (isClosed) return;
    if (state is InvoiceFormState) {
      final currentState = state as InvoiceFormState;
      final updatedItems = currentState.items.where((item) => item.id != itemId).toList();
      emit(currentState.copyWith(
        items: updatedItems,
        isValid: updatedItems.isNotEmpty,
      ));
    }
  }

  // Update item in form by index (legacy method)
  void updateItemByIndex(int index, InvoiceItem item) {
    if (isClosed) return;
    if (state is InvoiceFormState) {
      final currentState = state as InvoiceFormState;
      final updatedItems = [...currentState.items];
      if (index < updatedItems.length) {
        updatedItems[index] = item;
        emit(currentState.copyWith(
          items: updatedItems,
          isValid: updatedItems.isNotEmpty,
        ));
      }
    }
  }

  // Remove item from form by index (legacy method)
  void removeItemByIndex(int index) {
    if (isClosed) return;
    if (state is InvoiceFormState) {
      final currentState = state as InvoiceFormState;
      final updatedItems = [...currentState.items];
      if (index < updatedItems.length) {
        updatedItems.removeAt(index);
        emit(currentState.copyWith(
          items: updatedItems,
          isValid: updatedItems.isNotEmpty,
        ));
      }
    }
  }

  // Reset form
  void resetForm() {
    if (isClosed) return;
    emit(InvoiceFormState(
      items: [],
      isValid: false,
    ));
  }
} 