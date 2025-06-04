import 'package:equatable/equatable.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';

abstract class PayInvoiceState extends Equatable {
  const PayInvoiceState();

  @override
  List<Object?> get props => [];
}

class PayInvoiceInitial extends PayInvoiceState {}

class PayInvoiceLoading extends PayInvoiceState {}

class PayInvoicesLoaded extends PayInvoiceState {
  final List<TaggedInvoice> invoices;
  final String? searchQuery;
  final PaymentStatus? statusFilter;

  const PayInvoicesLoaded({
    required this.invoices,
    this.searchQuery,
    this.statusFilter,
  });

  @override
  List<Object?> get props => [invoices, searchQuery, statusFilter];

  PayInvoicesLoaded copyWith({
    List<TaggedInvoice>? invoices,
    String? searchQuery,
    PaymentStatus? statusFilter,
  }) {
    return PayInvoicesLoaded(
      invoices: invoices ?? this.invoices,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }
}

class PayInvoiceDetailsLoaded extends PayInvoiceState {
  final TaggedInvoice invoice;

  const PayInvoiceDetailsLoaded({required this.invoice});

  @override
  List<Object> get props => [invoice];
}

class PayInvoicePaymentProcessing extends PayInvoiceState {
  final String invoiceId;
  final PaymentMethod paymentMethod;
  final double amount;

  const PayInvoicePaymentProcessing({
    required this.invoiceId,
    required this.paymentMethod,
    required this.amount,
  });

  @override
  List<Object> get props => [invoiceId, paymentMethod, amount];
}

class PayInvoicePaymentSuccess extends PayInvoiceState {
  final PaymentResult paymentResult;
  final TaggedInvoice invoice;
  final String message;

  const PayInvoicePaymentSuccess({
    required this.paymentResult,
    required this.invoice,
    required this.message,
  });

  @override
  List<Object> get props => [paymentResult, invoice, message];
}

class PayInvoicePaymentFailure extends PayInvoiceState {
  final String errorMessage;
  final String? invoiceId;

  const PayInvoicePaymentFailure({
    required this.errorMessage,
    this.invoiceId,
  });

  @override
  List<Object?> get props => [errorMessage, invoiceId];
}

class PayInvoiceError extends PayInvoiceState {
  final String message;

  const PayInvoiceError({required this.message});

  @override
  List<Object> get props => [message];
}

class PayInvoiceStatisticsLoaded extends PayInvoiceState {
  final Map<String, dynamic> statistics;

  const PayInvoiceStatisticsLoaded({required this.statistics});

  @override
  List<Object> get props => [statistics];
}

class PayInvoiceAccountBalanceLoaded extends PayInvoiceState {
  final Map<String, dynamic> accountBalance;

  const PayInvoiceAccountBalanceLoaded({required this.accountBalance});

  @override
  List<Object> get props => [accountBalance];
}

class PayInvoicePaymentMethodsLoaded extends PayInvoiceState {
  final List<Map<String, dynamic>> paymentMethods;

  const PayInvoicePaymentMethodsLoaded({required this.paymentMethods});

  @override
  List<Object> get props => [paymentMethods];
}

class PayInvoiceRecentTransactionsLoaded extends PayInvoiceState {
  final List<Map<String, dynamic>> transactions;

  const PayInvoiceRecentTransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class PayInvoiceOperationSuccess extends PayInvoiceState {
  final String message;
  final String? operationType;

  const PayInvoiceOperationSuccess({
    required this.message,
    this.operationType,
  });

  @override
  List<Object?> get props => [message, operationType];
} 