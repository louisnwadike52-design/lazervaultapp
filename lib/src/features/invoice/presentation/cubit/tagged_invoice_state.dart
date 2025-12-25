import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';

abstract class TaggedInvoiceState extends Equatable {
  const TaggedInvoiceState();

  @override
  List<Object?> get props => [];
}

class TaggedInvoiceInitial extends TaggedInvoiceState {
  const TaggedInvoiceInitial();
}

class TaggedInvoiceLoading extends TaggedInvoiceState {
  const TaggedInvoiceLoading();
}

class IncomingTaggedInvoicesLoaded extends TaggedInvoiceState {
  final List<TaggedInvoice> invoices;
  final TaggedInvoiceStatistics statistics;
  final int currentPage;
  final bool hasMore;
  final InvoicePaymentStatus? currentFilter;

  const IncomingTaggedInvoicesLoaded({
    required this.invoices,
    required this.statistics,
    this.currentPage = 1,
    this.hasMore = false,
    this.currentFilter,
  });

  @override
  List<Object?> get props => [invoices, statistics, currentPage, hasMore, currentFilter];

  IncomingTaggedInvoicesLoaded copyWith({
    List<TaggedInvoice>? invoices,
    TaggedInvoiceStatistics? statistics,
    int? currentPage,
    bool? hasMore,
    InvoicePaymentStatus? currentFilter,
  }) {
    return IncomingTaggedInvoicesLoaded(
      invoices: invoices ?? this.invoices,
      statistics: statistics ?? this.statistics,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

class OutgoingTaggedInvoicesLoaded extends TaggedInvoiceState {
  final List<TaggedInvoice> invoices;
  final TaggedInvoiceStatistics statistics;
  final int currentPage;
  final bool hasMore;
  final InvoicePaymentStatus? currentFilter;

  const OutgoingTaggedInvoicesLoaded({
    required this.invoices,
    required this.statistics,
    this.currentPage = 1,
    this.hasMore = false,
    this.currentFilter,
  });

  @override
  List<Object?> get props => [invoices, statistics, currentPage, hasMore, currentFilter];

  OutgoingTaggedInvoicesLoaded copyWith({
    List<TaggedInvoice>? invoices,
    TaggedInvoiceStatistics? statistics,
    int? currentPage,
    bool? hasMore,
    InvoicePaymentStatus? currentFilter,
  }) {
    return OutgoingTaggedInvoicesLoaded(
      invoices: invoices ?? this.invoices,
      statistics: statistics ?? this.statistics,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

class TaggedInvoiceDetailsLoaded extends TaggedInvoiceState {
  final TaggedInvoice invoice;

  const TaggedInvoiceDetailsLoaded({required this.invoice});

  @override
  List<Object?> get props => [invoice];
}

class TaggedInvoicePaymentProcessing extends TaggedInvoiceState {
  final String invoiceId;
  final String message;

  const TaggedInvoicePaymentProcessing({
    required this.invoiceId,
    this.message = 'Processing payment...',
  });

  @override
  List<Object?> get props => [invoiceId, message];
}

class TaggedInvoicePaymentSuccess extends TaggedInvoiceState {
  final Map<String, dynamic> transaction;
  final String message;

  const TaggedInvoicePaymentSuccess({
    required this.transaction,
    this.message = 'Payment successful!',
  });

  @override
  List<Object?> get props => [transaction, message];

  String get transactionId => transaction['transaction_id'] as String? ?? '';
  String get confirmationCode => transaction['confirmation_code'] as String? ?? '';
  double get amount => transaction['amount'] as double? ?? 0.0;
  String get currency => transaction['currency'] as String? ?? 'USD';
  double get feeAmount => transaction['fee_amount'] as double? ?? 0.0;
  String get formattedAmount => '$currency ${amount.toStringAsFixed(2)}';
}

class TaggedInvoiceOperationSuccess extends TaggedInvoiceState {
  final String message;

  const TaggedInvoiceOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class TaggedInvoiceError extends TaggedInvoiceState {
  final String message;
  final String? errorCode;

  const TaggedInvoiceError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

class TaggedInvoiceLoadingMore extends TaggedInvoiceState {
  final List<TaggedInvoice> currentInvoices;
  final bool isIncoming;

  const TaggedInvoiceLoadingMore({
    required this.currentInvoices,
    required this.isIncoming,
  });

  @override
  List<Object?> get props => [currentInvoices, isIncoming];
}
