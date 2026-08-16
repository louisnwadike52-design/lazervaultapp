import 'package:equatable/equatable.dart';
import '../../domain/entities/invoice_entity.dart';

/// Base state for invoice creation
abstract class CreateInvoiceState extends Equatable {
  const CreateInvoiceState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CreateInvoiceInitial extends CreateInvoiceState {
  const CreateInvoiceInitial();
}

/// Loading state
class CreateInvoiceLoading extends CreateInvoiceState {
  const CreateInvoiceLoading();
}

/// Form updated state - emitted when any form field changes
class CreateInvoiceFormUpdated extends CreateInvoiceState {
  final InvoiceType invoiceType;
  final String title;
  final String description;
  final DateTime? dueDate;
  final List<InvoiceItem> items;
  final double subtotal;
  final double taxAmount;
  final double discountAmount;
  final double total;
  final String? payerImagePath;
  final String? recipientImagePath;
  // Split payment: included in props so toggling split mode, adding/removing
  // payers, or editing a share produces a DISTINCT state — otherwise Bloc dedups
  // the emit (props unchanged) and the split UI/switch never rebuilds.
  final bool splitMode;
  final bool splitCustom;
  final List<TaggedUserInfo> splitPayers;

  const CreateInvoiceFormUpdated({
    required this.invoiceType,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.items,
    required this.subtotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.total,
    this.payerImagePath,
    this.recipientImagePath,
    this.splitMode = false,
    this.splitCustom = false,
    this.splitPayers = const [],
  });

  @override
  List<Object?> get props => [
        invoiceType,
        title,
        description,
        dueDate,
        items,
        subtotal,
        taxAmount,
        discountAmount,
        total,
        payerImagePath,
        recipientImagePath,
        splitMode,
        splitCustom,
        splitPayers,
      ];
}

/// Validation error state
class CreateInvoiceValidationError extends CreateInvoiceState {
  final String message;

  const CreateInvoiceValidationError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Success state
class CreateInvoiceSuccess extends CreateInvoiceState {
  final Invoice invoice;

  const CreateInvoiceSuccess(this.invoice);

  @override
  List<Object?> get props => [invoice];
}

/// Error state
class CreateInvoiceError extends CreateInvoiceState {
  final String message;

  const CreateInvoiceError(this.message);

  @override
  List<Object?> get props => [message];
}
