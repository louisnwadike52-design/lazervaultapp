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

  const InvoicesLoaded({
    required this.invoices,
    this.statistics,
  });

  @override
  List<Object?> get props => [invoices, statistics];
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
  final Invoice? editingInvoice;
  final List<InvoiceItem> items;
  final bool isEditing;
  final bool isDraft;

  const InvoiceFormState({
    this.editingInvoice,
    required this.items,
    required this.isEditing,
    required this.isDraft,
  });

  @override
  List<Object?> get props => [editingInvoice, items, isEditing, isDraft];

  InvoiceFormState copyWith({
    Invoice? editingInvoice,
    List<InvoiceItem>? items,
    bool? isEditing,
    bool? isDraft,
  }) {
    return InvoiceFormState(
      editingInvoice: editingInvoice ?? this.editingInvoice,
      items: items ?? this.items,
      isEditing: isEditing ?? this.isEditing,
      isDraft: isDraft ?? this.isDraft,
    );
  }
} 