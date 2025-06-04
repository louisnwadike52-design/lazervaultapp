import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../../data/models/pagination_model.dart';
import '../../data/repositories/invoice_repository_impl.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepository repository;
  final String currentUserId;

  InvoiceCubit({
    required this.repository,
    required this.currentUserId,
  }) : super(InvoiceInitial());

  // Load all invoices with pagination and statistics
  Future<void> loadInvoices({
    int page = 1,
    int limit = 20,
    InvoiceSearchFilter? filter,
    bool append = false,
  }) async {
    try {
      if (page == 1 && !append) {
        emit(InvoiceLoading());
      }
      
      final repositoryImpl = repository as InvoiceRepositoryImpl;
      final result = await repositoryImpl.getAllInvoicesPaginated(
        page: page,
        limit: limit,
        filter: filter,
      );
      
      final statistics = await repository.getInvoiceStatistics(currentUserId);
      
      if (append && state is InvoicesLoaded) {
        final currentState = state as InvoicesLoaded;
        final updatedInvoices = [
          ...currentState.invoices,
          ...result.invoices.cast<Invoice>(),
        ];
        
        emit(InvoicesLoaded(
          invoices: updatedInvoices,
          statistics: statistics,
          pagination: result.pagination,
          filter: result.filter,
        ));
      } else {
        emit(InvoicesLoaded(
          invoices: result.invoices.cast<Invoice>(),
          statistics: statistics,
          pagination: result.pagination,
          filter: result.filter,
        ));
      }
    } catch (e) {
      emit(InvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
    }
  }

  // Search invoices with pagination
  Future<void> searchInvoices({
    required String query,
    int page = 1,
    int limit = 20,
    InvoiceSearchFilter? filter,
    bool append = false,
  }) async {
    try {
      if (page == 1 && !append) {
        emit(InvoiceLoading());
      }
      
      final repositoryImpl = repository as InvoiceRepositoryImpl;
      final result = await repositoryImpl.searchInvoicesPaginated(
        query: query,
        page: page,
        limit: limit,
        filter: filter,
      );
      
      if (append && state is InvoiceSearchResults) {
        final currentState = state as InvoiceSearchResults;
        final updatedResults = [
          ...currentState.results,
          ...result.invoices.cast<Invoice>(),
        ];
        
        emit(InvoiceSearchResults(
          results: updatedResults,
          query: query,
          pagination: result.pagination,
          filter: result.filter,
        ));
      } else {
        emit(InvoiceSearchResults(
          results: result.invoices.cast<Invoice>(),
          query: query,
          pagination: result.pagination,
          filter: result.filter,
        ));
      }
    } catch (e) {
      emit(InvoiceError(message: 'Search failed: ${e.toString()}'));
    }
  }

  // Load more invoices (pagination)
  Future<void> loadMoreInvoices() async {
    if (state is InvoicesLoaded) {
      final currentState = state as InvoicesLoaded;
      if (currentState.pagination?.hasNext == true) {
        await loadInvoices(
          page: (currentState.pagination?.page ?? 0) + 1,
          filter: currentState.filter,
          append: true,
        );
      }
    }
  }

  // Load more search results (pagination)
  Future<void> loadMoreSearchResults() async {
    if (state is InvoiceSearchResults) {
      final currentState = state as InvoiceSearchResults;
      if (currentState.pagination?.hasNext == true) {
        await searchInvoices(
          query: currentState.query,
          page: (currentState.pagination?.page ?? 0) + 1,
          filter: currentState.filter,
          append: true,
        );
      }
    }
  }

  // Apply filters
  Future<void> applyFilters(InvoiceSearchFilter filter) async {
    await loadInvoices(filter: filter);
  }

  // Clear filters
  Future<void> clearFilters() async {
    await loadInvoices();
  }

  // Load specific invoice details
  Future<void> loadInvoiceDetails(String invoiceId) async {
    try {
      emit(InvoiceLoading());
      
      final invoice = await repository.getInvoiceById(invoiceId);
      if (invoice == null) {
        emit(InvoiceError(message: 'Invoice not found'));
        return;
      }
      
      final paymentHistory = await repository.getPaymentHistory(invoiceId);
      
      emit(InvoiceDetailsLoaded(
        invoice: invoice,
        paymentHistory: paymentHistory,
      ));
    } catch (e) {
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
  }) async {
    try {
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
        currency: 'USD',
        status: sendImmediately ? InvoiceStatus.pending : InvoiceStatus.draft,
        type: type,
        createdAt: DateTime.now(),
        dueDate: dueDate,
        fromUserId: currentUserId,
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
      
      emit(InvoiceOperationSuccess(
        message: sendImmediately ? 'Invoice created and sent successfully' : 'Invoice created as draft',
        invoice: createdInvoice,
      ));
      
      // Reload invoices to update the list
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to create invoice: ${e.toString()}'));
    }
  }

  // Update existing invoice
  Future<void> updateInvoice(Invoice invoice) async {
    try {
      emit(InvoiceLoading());
      
      final updatedInvoice = await repository.updateInvoice(invoice);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice updated successfully',
        invoice: updatedInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to update invoice: ${e.toString()}'));
    }
  }

  // Send invoice (change status to pending)
  Future<void> sendInvoice(String invoiceId) async {
    try {
      final updatedInvoice = await repository.sendInvoice(invoiceId);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice sent successfully',
        invoice: updatedInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to send invoice: ${e.toString()}'));
    }
  }

  // Mark invoice as paid
  Future<void> markAsPaid(String invoiceId, PaymentMethod paymentMethod, [String? reference]) async {
    try {
      final updatedInvoice = await repository.markInvoiceAsPaid(invoiceId, paymentMethod, reference);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice marked as paid successfully',
        invoice: updatedInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to mark invoice as paid: ${e.toString()}'));
    }
  }

  // Cancel invoice
  Future<void> cancelInvoice(String invoiceId) async {
    try {
      final updatedInvoice = await repository.cancelInvoice(invoiceId);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice cancelled successfully',
        invoice: updatedInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to cancel invoice: ${e.toString()}'));
    }
  }

  // Delete invoice
  Future<void> deleteInvoice(String invoiceId) async {
    try {
      await repository.deleteInvoice(invoiceId);
      
      emit(InvoiceOperationSuccess(message: 'Invoice deleted successfully'));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to delete invoice: ${e.toString()}'));
    }
  }

  // Generate QR code for payment
  Future<void> generateQRCode(String invoiceId) async {
    try {
      final qrData = await repository.generateQRCode(invoiceId);
      
      emit(QRCodeGenerated(
        qrData: qrData,
        invoiceId: invoiceId,
      ));
    } catch (e) {
      emit(InvoiceError(message: 'Failed to generate QR code: ${e.toString()}'));
    }
  }

  // Share invoice
  Future<void> shareInvoice(String invoiceId, List<String> recipients) async {
    try {
      await repository.shareInvoice(invoiceId, recipients);
      
      emit(InvoiceOperationSuccess(message: 'Invoice shared successfully'));
    } catch (e) {
      emit(InvoiceError(message: 'Failed to share invoice: ${e.toString()}'));
    }
  }

  // Load invoices by status
  Future<void> loadInvoicesByStatus(InvoiceStatus status) async {
    try {
      emit(InvoiceLoading());
      
      final invoices = await repository.getInvoicesByStatus(status);
      
      emit(InvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
    }
  }

  // Load overdue invoices
  Future<void> loadOverdueInvoices() async {
    try {
      emit(InvoiceLoading());
      
      final invoices = await repository.getOverdueInvoices();
      
      emit(InvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoiceError(message: 'Failed to load overdue invoices: ${e.toString()}'));
    }
  }

  // Initialize form for new invoice
  void initializeForm({Invoice? editingInvoice}) {
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
    emit(InvoiceFormState(
      items: [],
      isValid: false,
    ));
  }
} 