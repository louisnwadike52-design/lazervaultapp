import 'package:equatable/equatable.dart';
import '../../domain/entities/invoice_entity.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object?> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoicesLoaded extends InvoiceState {
  final List<Invoice> invoices;
  final Map<String, dynamic>? statistics;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasNext;
  final bool hasPrevious;
  final String? currentFilter;
  final bool isStale;
  final bool isRevalidating;

  const InvoicesLoaded({
    required this.invoices,
    this.statistics,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.pageSize = 20,
    this.hasNext = false,
    this.hasPrevious = false,
    this.currentFilter,
    this.isStale = false,
    this.isRevalidating = false,
  });

  InvoicesLoaded copyWith({
    List<Invoice>? invoices,
    Map<String, dynamic>? statistics,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    int? pageSize,
    bool? hasNext,
    bool? hasPrevious,
    String? currentFilter,
    bool? isStale,
    bool? isRevalidating,
  }) {
    return InvoicesLoaded(
      invoices: invoices ?? this.invoices,
      statistics: statistics ?? this.statistics,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      pageSize: pageSize ?? this.pageSize,
      hasNext: hasNext ?? this.hasNext,
      hasPrevious: hasPrevious ?? this.hasPrevious,
      currentFilter: currentFilter ?? this.currentFilter,
      isStale: isStale ?? this.isStale,
      isRevalidating: isRevalidating ?? this.isRevalidating,
    );
  }

  @override
  List<Object?> get props => [invoices, statistics, currentPage, totalPages, totalCount, pageSize, hasNext, hasPrevious, currentFilter, isStale, isRevalidating];
}

class InvoiceDetailsLoaded extends InvoiceState {
  final Invoice invoice;
  final List<Map<String, dynamic>>? paymentHistory;

  const InvoiceDetailsLoaded({
    required this.invoice,
    this.paymentHistory,
  });

  @override
  List<Object?> get props => [invoice, paymentHistory];
}

class InvoiceOperationSuccess extends InvoiceState {
  final String message;
  final Invoice? invoice;

  const InvoiceOperationSuccess({
    required this.message,
    this.invoice,
  });

  @override
  List<Object?> get props => [message, invoice];
}

class InvoiceError extends InvoiceState {
  final String message;
  final String? errorCode;

  const InvoiceError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

class InvoiceSearchResults extends InvoiceState {
  final List<Invoice> results;
  final String query;

  const InvoiceSearchResults({
    required this.results,
    required this.query,
  });

  @override
  List<Object?> get props => [results, query];
}

class QRCodeGenerated extends InvoiceState {
  final String qrData;
  final String invoiceId;

  const QRCodeGenerated({
    required this.qrData,
    required this.invoiceId,
  });

  @override
  List<Object?> get props => [qrData, invoiceId];
}

class InvoiceFormState extends InvoiceState {
  final List<InvoiceItem> items;
  final bool isValid;

  const InvoiceFormState({
    required this.items,
    required this.isValid,
  });

  @override
  List<Object?> get props => [items, isValid];

  InvoiceFormState copyWith({
    List<InvoiceItem>? items,
    bool? isValid,
  }) {
    return InvoiceFormState(
      items: items ?? this.items,
      isValid: isValid ?? this.isValid,
    );
  }
}

class InvoicePaymentProcessing extends InvoiceState {
  final String invoiceId;

  const InvoicePaymentProcessing({required this.invoiceId});

  @override
  List<Object?> get props => [invoiceId];
}

class InvoicePaymentSuccess extends InvoiceState {
  final String message;
  final Invoice? invoice;

  const InvoicePaymentSuccess({required this.message, this.invoice});

  @override
  List<Object?> get props => [message, invoice];
}

class InvoiceServiceFeeProcessing extends InvoiceState {
  const InvoiceServiceFeeProcessing();
}

class InvoiceServiceFeePaid extends InvoiceState {
  final String serviceFeeRef;
  final double newBalance;

  const InvoiceServiceFeePaid({required this.serviceFeeRef, required this.newBalance});

  @override
  List<Object?> get props => [serviceFeeRef, newBalance];
}

class InvoiceUnlockProcessing extends InvoiceState {
  final String invoiceId;

  const InvoiceUnlockProcessing({required this.invoiceId});

  @override
  List<Object?> get props => [invoiceId];
}

class InvoiceUnlockSuccess extends InvoiceState {
  final String message;
  final Invoice? invoice;

  const InvoiceUnlockSuccess({required this.message, this.invoice});

  @override
  List<Object?> get props => [message, invoice];
}

/// State emitted when an invoice creation is queued for offline retry.
class InvoiceCreationQueued extends InvoiceState {
  final String title;
  final double totalAmount;
  final String currency;
  final String message;
  final String? mutationId;

  const InvoiceCreationQueued({
    required this.title,
    required this.totalAmount,
    required this.currency,
    required this.message,
    this.mutationId,
  });

  @override
  List<Object?> get props => [title, totalAmount, currency, message, mutationId];
}