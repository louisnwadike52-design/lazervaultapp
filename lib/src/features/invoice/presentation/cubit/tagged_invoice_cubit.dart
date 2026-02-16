import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/invoice/data/repositories/tagged_invoice_repository_grpc_impl.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/tagged_invoice_repository.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';
import 'tagged_invoice_state.dart';

class TaggedInvoiceCubit extends Cubit<TaggedInvoiceState> {
  final TaggedInvoiceRepository repository;

  TaggedInvoiceCubit({required this.repository}) : super(const TaggedInvoiceInitial());

  static const int _defaultPageSize = 20;

  /// Load invoices that the current user was tagged to pay (incoming)
  Future<void> loadIncomingInvoices({
    int page = 1,
    bool append = false,
    InvoicePaymentStatus? statusFilter,
    String? currency,
  }) async {
    try {
      if (!append) {
        if (isClosed) return;
        emit(const TaggedInvoiceLoading());
      } else if (state is IncomingTaggedInvoicesLoaded) {
        if (isClosed) return;
        final currentState = state as IncomingTaggedInvoicesLoaded;
        emit(TaggedInvoiceLoadingMore(
          currentInvoices: currentState.invoices,
          isIncoming: true,
        ));
      }

      final invoices = await repository.getIncomingTaggedInvoices(
        page: page,
        limit: _defaultPageSize,
        statusFilter: statusFilter,
        currency: currency,
      );
      if (isClosed) return;

      final statistics = await repository.getIncomingStatistics();
      if (isClosed) return;

      if (append && state is TaggedInvoiceLoadingMore) {
        final loadingState = state as TaggedInvoiceLoadingMore;
        final updatedInvoices = [...loadingState.currentInvoices, ...invoices];
        emit(IncomingTaggedInvoicesLoaded(
          invoices: updatedInvoices,
          statistics: statistics,
          currentPage: page,
          hasMore: invoices.length >= _defaultPageSize,
          currentFilter: statusFilter,
        ));
      } else {
        emit(IncomingTaggedInvoicesLoaded(
          invoices: invoices,
          statistics: statistics,
          currentPage: page,
          hasMore: invoices.length >= _defaultPageSize,
          currentFilter: statusFilter,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Load invoices that the current user created and tagged others to (outgoing)
  Future<void> loadOutgoingInvoices({
    int page = 1,
    bool append = false,
    InvoicePaymentStatus? statusFilter,
  }) async {
    try {
      if (!append) {
        if (isClosed) return;
        emit(const TaggedInvoiceLoading());
      } else if (state is OutgoingTaggedInvoicesLoaded) {
        if (isClosed) return;
        final currentState = state as OutgoingTaggedInvoicesLoaded;
        emit(TaggedInvoiceLoadingMore(
          currentInvoices: currentState.invoices,
          isIncoming: false,
        ));
      }

      final invoices = await repository.getOutgoingTaggedInvoices(
        page: page,
        limit: _defaultPageSize,
        statusFilter: statusFilter,
      );
      if (isClosed) return;

      final statistics = await repository.getOutgoingStatistics();
      if (isClosed) return;

      if (append && state is TaggedInvoiceLoadingMore) {
        final loadingState = state as TaggedInvoiceLoadingMore;
        final updatedInvoices = [...loadingState.currentInvoices, ...invoices];
        emit(OutgoingTaggedInvoicesLoaded(
          invoices: updatedInvoices,
          statistics: statistics,
          currentPage: page,
          hasMore: invoices.length >= _defaultPageSize,
          currentFilter: statusFilter,
        ));
      } else {
        emit(OutgoingTaggedInvoicesLoaded(
          invoices: invoices,
          statistics: statistics,
          currentPage: page,
          hasMore: invoices.length >= _defaultPageSize,
          currentFilter: statusFilter,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Filter incoming invoices by status
  Future<void> filterIncomingByStatus(InvoicePaymentStatus? status) async {
    await loadIncomingInvoices(page: 1, statusFilter: status);
  }

  /// Filter outgoing invoices by status
  Future<void> filterOutgoingByStatus(InvoicePaymentStatus? status) async {
    await loadOutgoingInvoices(page: 1, statusFilter: status);
  }

  /// Load more incoming invoices (pagination)
  Future<void> loadMoreIncoming() async {
    if (state is IncomingTaggedInvoicesLoaded) {
      final currentState = state as IncomingTaggedInvoicesLoaded;
      if (currentState.hasMore) {
        await loadIncomingInvoices(
          page: currentState.currentPage + 1,
          append: true,
          statusFilter: currentState.currentFilter,
        );
      }
    }
  }

  /// Load more outgoing invoices (pagination)
  Future<void> loadMoreOutgoing() async {
    if (state is OutgoingTaggedInvoicesLoaded) {
      final currentState = state as OutgoingTaggedInvoicesLoaded;
      if (currentState.hasMore) {
        await loadOutgoingInvoices(
          page: currentState.currentPage + 1,
          append: true,
          statusFilter: currentState.currentFilter,
        );
      }
    }
  }

  /// Refresh incoming invoices
  Future<void> refreshIncoming() async {
    InvoicePaymentStatus? currentFilter;
    if (state is IncomingTaggedInvoicesLoaded) {
      currentFilter = (state as IncomingTaggedInvoicesLoaded).currentFilter;
    }
    await loadIncomingInvoices(page: 1, statusFilter: currentFilter);
  }

  /// Refresh outgoing invoices
  Future<void> refreshOutgoing() async {
    InvoicePaymentStatus? currentFilter;
    if (state is OutgoingTaggedInvoicesLoaded) {
      currentFilter = (state as OutgoingTaggedInvoicesLoaded).currentFilter;
    }
    await loadOutgoingInvoices(page: 1, statusFilter: currentFilter);
  }

  /// Pay a tagged invoice with full security verification
  Future<void> payInvoice(
    String invoiceId,
    String accountId, {
    required String pin,
    required String verificationToken,
    required String transactionId,
    required String idempotencyKey,
  }) async {
    try {
      if (isClosed) return;
      emit(TaggedInvoicePaymentProcessing(
        invoiceId: invoiceId,
        message: 'Processing payment...',
      ));

      final transaction = await repository.payTaggedInvoice(
        invoiceId: invoiceId,
        sourceAccountId: accountId,
        pin: pin,
        verificationToken: verificationToken,
        transactionId: transactionId,
        idempotencyKey: idempotencyKey,
      );
      if (isClosed) return;

      emit(TaggedInvoicePaymentSuccess(
        transaction: transaction,
        message: transaction['message'] as String? ?? 'Payment successful!',
      ));

      // Optimistically refresh incoming invoices after successful payment
      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;
      await refreshIncoming();
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(
        message: 'Payment failed: ${e.toString()}',
        errorCode: 'PAYMENT_FAILED',
      ));
    }
  }

  /// Mark invoice as viewed
  Future<void> markAsViewed(String invoiceId) async {
    try {
      await repository.markAsViewed(invoiceId);
      // Optionally refresh to update view status
    } catch (e) {
      // Silent fail for view tracking
      print('Failed to mark invoice as viewed: $e');
    }
  }

  /// Load invoice details
  Future<void> loadInvoiceDetails(String invoiceId) async {
    try {
      if (isClosed) return;
      emit(const TaggedInvoiceLoading());
      final invoice = await repository.getTaggedInvoiceById(invoiceId);
      if (isClosed) return;

      // Mark as viewed when loading details
      await markAsViewed(invoiceId);
      if (isClosed) return;

      emit(TaggedInvoiceDetailsLoaded(invoice: invoice));
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Set payment reminder
  Future<void> setReminder(String invoiceId, DateTime reminderDate) async {
    try {
      await repository.setPaymentReminder(
        invoiceId: invoiceId,
        reminderDate: reminderDate,
      );
      if (isClosed) return;
      emit(const TaggedInvoiceOperationSuccess(
        message: 'Reminder set successfully',
      ));
      await refreshIncoming();
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Load overdue invoices
  Future<void> loadOverdueInvoices() async {
    try {
      if (isClosed) return;
      emit(const TaggedInvoiceLoading());
      final invoices = await repository.getOverdueTaggedInvoices(limit: 50);
      if (isClosed) return;
      final statistics = await repository.getIncomingStatistics();
      if (isClosed) return;

      emit(IncomingTaggedInvoicesLoaded(
        invoices: invoices,
        statistics: statistics,
        currentPage: 1,
        hasMore: false,
        currentFilter: InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Load upcoming invoices (due soon)
  Future<void> loadUpcomingInvoices({int daysAhead = 7}) async {
    try {
      if (isClosed) return;
      emit(const TaggedInvoiceLoading());
      final invoices = await repository.getUpcomingTaggedInvoices(
        daysAhead: daysAhead,
        limit: 50,
      );
      if (isClosed) return;
      final statistics = await repository.getIncomingStatistics();
      if (isClosed) return;

      emit(IncomingTaggedInvoicesLoaded(
        invoices: invoices,
        statistics: statistics,
        currentPage: 1,
        hasMore: false,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Search invoices
  Future<void> searchInvoices(String query, {bool incoming = true}) async {
    try {
      if (query.isEmpty) {
        if (incoming) {
          await loadIncomingInvoices();
        } else {
          await loadOutgoingInvoices();
        }
        return;
      }

      if (isClosed) return;
      emit(const TaggedInvoiceLoading());
      final invoices = await repository.searchTaggedInvoices(
        query: query,
        incoming: incoming,
        limit: 50,
      );
      if (isClosed) return;

      if (incoming) {
        final statistics = await repository.getIncomingStatistics();
        if (isClosed) return;
        emit(IncomingTaggedInvoicesLoaded(
          invoices: invoices,
          statistics: statistics,
          currentPage: 1,
          hasMore: false,
        ));
      } else {
        final statistics = await repository.getOutgoingStatistics();
        if (isClosed) return;
        emit(OutgoingTaggedInvoicesLoaded(
          invoices: invoices,
          statistics: statistics,
          currentPage: 1,
          hasMore: false,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Navigate to a specific page (incoming)
  Future<void> goToIncomingPage(int page) async {
    InvoicePaymentStatus? currentFilter;
    if (state is IncomingTaggedInvoicesLoaded) {
      currentFilter = (state as IncomingTaggedInvoicesLoaded).currentFilter;
    }
    await loadIncomingInvoicesPage(page: page, statusFilter: currentFilter);
  }

  /// Navigate to next page (incoming)
  Future<void> nextIncomingPage() async {
    if (state is IncomingTaggedInvoicesLoaded) {
      final s = state as IncomingTaggedInvoicesLoaded;
      if (s.currentPage < s.totalPages) {
        await goToIncomingPage(s.currentPage + 1);
      }
    }
  }

  /// Navigate to previous page (incoming)
  Future<void> previousIncomingPage() async {
    if (state is IncomingTaggedInvoicesLoaded) {
      final s = state as IncomingTaggedInvoicesLoaded;
      if (s.currentPage > 1) {
        await goToIncomingPage(s.currentPage - 1);
      }
    }
  }

  /// Load incoming invoices with full pagination metadata from server
  Future<void> loadIncomingInvoicesPage({
    int page = 1,
    int pageSize = _defaultPageSize,
    InvoicePaymentStatus? statusFilter,
    String? currency,
  }) async {
    try {
      if (isClosed) return;
      // If data already loaded, show revalidating state instead of full loading shimmer
      if (state is IncomingTaggedInvoicesLoaded) {
        emit((state as IncomingTaggedInvoicesLoaded).copyWith(isRevalidating: true));
      } else {
        emit(const TaggedInvoiceLoading());
      }

      // Use paginated method if repository supports it
      if (repository is TaggedInvoiceRepositoryGrpcImpl) {
        final grpcRepo = repository as TaggedInvoiceRepositoryGrpcImpl;
        final result = await grpcRepo.getIncomingTaggedInvoicesPaginated(
          page: page,
          pageSize: pageSize,
          statusFilter: statusFilter,
          currency: currency,
        );
        if (isClosed) return;

        final statistics = await repository.getIncomingStatistics();
        if (isClosed) return;

        emit(IncomingTaggedInvoicesLoaded(
          invoices: result.invoices,
          statistics: statistics,
          currentPage: result.currentPage,
          hasMore: result.hasNext,
          currentFilter: statusFilter,
          totalPages: result.totalPages,
          totalCount: result.totalCount,
          pageSize: result.pageSize,
        ));
      } else {
        // Fallback to standard method
        await loadIncomingInvoices(page: page, statusFilter: statusFilter, currency: currency);
      }
    } catch (e) {
      if (isClosed) return;
      emit(TaggedInvoiceError(message: e.toString()));
    }
  }

  /// Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(const TaggedInvoiceInitial());
  }
}
