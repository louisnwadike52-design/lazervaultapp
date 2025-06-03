import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepository repository;
  final String currentUserId;

  InvoiceCubit({
    required this.repository,
    required this.currentUserId,
  }) : super(InvoiceInitial());

  // Load all invoices with statistics
  Future<void> loadInvoices() async {
    try {
      emit(InvoiceLoading());
      
      final invoices = await repository.getInvoicesByUserId(currentUserId);
      final statistics = await repository.getInvoiceStatistics(currentUserId);
      
      emit(InvoicesLoaded(
        invoices: invoices,
        statistics: statistics,
      ));
    } catch (e) {
      emit(InvoiceError(message: 'Failed to load invoices: ${e.toString()}'));
    }
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
      emit(InvoiceLoading());
      
      final sentInvoice = await repository.sendInvoice(invoiceId);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice sent successfully',
        invoice: sentInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to send invoice: ${e.toString()}'));
    }
  }

  // Mark invoice as paid
  Future<void> markAsPaid(String invoiceId, PaymentMethod paymentMethod, [String? reference]) async {
    try {
      emit(InvoiceLoading());
      
      final paidInvoice = await repository.markInvoiceAsPaid(invoiceId, paymentMethod, reference);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice marked as paid',
        invoice: paidInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to mark invoice as paid: ${e.toString()}'));
    }
  }

  // Cancel invoice
  Future<void> cancelInvoice(String invoiceId) async {
    try {
      emit(InvoiceLoading());
      
      final cancelledInvoice = await repository.cancelInvoice(invoiceId);
      
      emit(InvoiceOperationSuccess(
        message: 'Invoice cancelled',
        invoice: cancelledInvoice,
      ));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to cancel invoice: ${e.toString()}'));
    }
  }

  // Delete invoice
  Future<void> deleteInvoice(String invoiceId) async {
    try {
      emit(InvoiceLoading());
      
      await repository.deleteInvoice(invoiceId);
      
      emit(InvoiceOperationSuccess(message: 'Invoice deleted successfully'));
      
      await loadInvoices();
    } catch (e) {
      emit(InvoiceError(message: 'Failed to delete invoice: ${e.toString()}'));
    }
  }

  // Search invoices
  Future<void> searchInvoices(String query) async {
    try {
      emit(InvoiceLoading());
      
      final results = await repository.searchInvoices(query);
      
      emit(InvoiceSearchResults(
        results: results,
        query: query,
      ));
    } catch (e) {
      emit(InvoiceError(message: 'Search failed: ${e.toString()}'));
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
    emit(InvoiceFormState(
      editingInvoice: editingInvoice,
      items: editingInvoice?.items ?? [],
      isEditing: editingInvoice != null,
      isDraft: editingInvoice?.status == InvoiceStatus.draft,
    ));
  }

  // Add item to invoice form
  void addItem(InvoiceItem item) {
    final currentState = state;
    if (currentState is InvoiceFormState) {
      final updatedItems = List<InvoiceItem>.from(currentState.items)..add(item);
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  // Remove item from invoice form
  void removeItem(String itemId) {
    final currentState = state;
    if (currentState is InvoiceFormState) {
      final updatedItems = currentState.items.where((item) => item.id != itemId).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  // Update item in invoice form
  void updateItem(InvoiceItem updatedItem) {
    final currentState = state;
    if (currentState is InvoiceFormState) {
      final updatedItems = currentState.items.map((item) {
        return item.id == updatedItem.id ? updatedItem : item;
      }).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  // Generate unique item ID
  String generateItemId() {
    return const Uuid().v4();
  }

  // Record payment for invoice
  Future<void> recordPayment(String invoiceId, double amount, PaymentMethod method, String reference) async {
    try {
      await repository.recordPayment(invoiceId, amount, method, reference);
      
      emit(InvoiceOperationSuccess(message: 'Payment recorded successfully'));
      
      // Reload invoice details
      await loadInvoiceDetails(invoiceId);
    } catch (e) {
      emit(InvoiceError(message: 'Failed to record payment: ${e.toString()}'));
    }
  }

  // Clear state
  void clearState() {
    emit(InvoiceInitial());
  }
} 